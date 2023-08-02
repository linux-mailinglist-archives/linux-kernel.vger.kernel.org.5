Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639E76C443
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjHBEtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHBEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:49:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FB1715
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:49:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso42343905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690951769; x=1691556569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAbWpgPJcZFTF6ikG/f4YE6/d7JnZiLc/O7kJzBUss8=;
        b=pOd/8qxNCpOWrGmzudMdlhSnmd35SmFT42m2bvEo8squIl+8V3f21CKl7cCi5ShC2b
         OLh+NwLMG1tEMYlK3d+fair3Fxbex2APxPPjBXNnewlHBOyFzivFasKKf4q1eCJ3eQHY
         iEEge1ep7AWVuTWFsE3vOIQs3TaD6GQ0EBCnRedn4F+L2cBB1nXYEyLMqq3WFtyF4nCX
         AZAhuWSBhffwWqF+Dx/L0XtIWSpsf3HCyb+70cKe2Yjc+mHEbHmRg64eyYtJSHrnwujr
         Mm23bUbUK+t6sQKvEKsWjKArHnDwVEhjXz0+5jGOSi22q6U9aZUIotyOGGz7gc94HB8o
         xzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690951769; x=1691556569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAbWpgPJcZFTF6ikG/f4YE6/d7JnZiLc/O7kJzBUss8=;
        b=dsfr/wOeVWKA/tJcnzS4m5KL2d/CWEIoWiC098YG5e/wsNC+hQ7pmIm44E7KdllsHg
         bbZpyip2OVoJg6pd/QX5ABOdhbw5ZF7FX7UWplJHjFFNcgoQF3B1mylpcvLuQiU5Hd8e
         E/vlwxmKtG0IKI7ZugiQqoZ43CxylJ0QctlfC907DwBY5e96fogsydix+B0KrVsVPZl/
         3jBzJrKr38BsycxVUuxxaNkpkgOGFvxSW7cZGSPluOgcljGhY6sQQgqh1jqsdJNNAjrK
         hwM8bgg9xZbgJgKu3ExuEE2mPYLpUwaDbXIeMUhg8l31E7bWva4r/b8u7r8xqbO83Grv
         20aA==
X-Gm-Message-State: ABy/qLbDqg1X/003ofIqT7oBccR5ZnTFEfcrbDF/TZIo8axJ9N1GxNBe
        NPaAyOH4NvvAYKZzYNiVCdXKAw==
X-Google-Smtp-Source: APBJJlFKjM4juNCXxSB69JAC/8Tr5sGwCH19iHDo9LPf9zMLaDNlF70WomZOSTB3FJisDGf0HSBJ9A==
X-Received: by 2002:a05:600c:ac6:b0:3fb:d1db:5454 with SMTP id c6-20020a05600c0ac600b003fbd1db5454mr3803059wmr.35.1690951769350;
        Tue, 01 Aug 2023 21:49:29 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id m2-20020adffa02000000b003175a994555sm18137559wrr.6.2023.08.01.21.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:49:29 -0700 (PDT)
Message-ID: <0440d144-2ec9-ded1-6c74-a8cbd7b462ea@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:49:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] ARM: at91: Remove unused extern declarations
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725141105.26904-1-yuehaibing@huawei.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230725141105.26904-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.07.2023 17:11, YueHaibing wrote:
> commit 157576d55233 ("misc: remove atmel_tclib")
> left behind this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to at91-soc, thanks!
