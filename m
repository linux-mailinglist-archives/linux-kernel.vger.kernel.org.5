Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5F0752164
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjGMMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:39:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F92689
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:39:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so6087885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689251961; x=1691843961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7hFNGhDsoWdE2O4YN92/eI74pnG6KmIvX3zGxiiC/w=;
        b=xbQMjfJYZG5xGlH7W6WxJgCSO9B5u7zU/wqu37zOULkyPHL+nxjsCwcQBabaoBNZHc
         79LkTqtZQV4tNueCmdjmb2jxSTFyYbz7PD30zKWi7Tto+htv3geXFknI738sJESeY9nD
         imub6y3bVMCm5mw9dCarK+wvUuGONdC1E6R0khWlF5oRtNxhwkwSFystJFL5ULCg9Sse
         ha2Q7RV6PTnXH0g9vqaBRugZAGv0B6Yahrl/x7GsRdJiLBzzy7eJvIn9HpO+dB6ia1Qv
         tPsw0AzywAWaNWlpbJPzxTW5H2EmMURCzIB2ghhB47ZmnUPsTU2MusouAxS+qzl4/abE
         UhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689251961; x=1691843961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7hFNGhDsoWdE2O4YN92/eI74pnG6KmIvX3zGxiiC/w=;
        b=YRmfM9dILE5j4t2DahqxqbVfEbdSHUr/xdXM9EPf5wX3H9Fy9xpYidHUdyoAV3Ea/f
         zZE7M850TH2Z+m+t2eZVK09fLAbi44iZ7YJEOaMNANdPvA20DTmybyGMjvcrzyp15btP
         qZNJBKAwT1IWbSTG5CmVlHHQeElHN+rm7u0t5Jp7YTgbCyqSEDA+mKi7E138WafIUwpV
         OdLdyTzHow4U6HUe1RO7Y7Oj5D0JCdVHfRUXNEHVsp2NVU2XkpbJoxZvfLXVMImgXUpV
         2VHrK0ktTCCzzIdTEEevQxgaQ/SLiVvnNeYubUey99sjttr9j5F6+ye6zf+RG/+UxAou
         0E5w==
X-Gm-Message-State: ABy/qLbSXGSfOQ79yabT3ZVbipEIKMNfZezgWcjop/ETwSLp6DOKr7r6
        0h5TYfbu1iPqGHRznDIOghUy2LCIHZNJzhr5VkIYMQ==
X-Google-Smtp-Source: APBJJlESELdVE1fjqV5C6AI5MqR/qUJYMMbrNP3VdlOetvKF5lMSl6c1ybsvTRlGq+uNjpRK5ta+xw==
X-Received: by 2002:a05:600c:151:b0:3fb:a46c:7eac with SMTP id w17-20020a05600c015100b003fba46c7eacmr1409580wmm.7.1689251961370;
        Thu, 13 Jul 2023 05:39:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bcd12000000b003fa999cefc0sm7728504wmj.36.2023.07.13.05.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:39:20 -0700 (PDT)
Message-ID: <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
Date:   Thu, 13 Jul 2023 14:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: constrain minItems of clocks and
 clock-names
To:     Mark Brown <broonie@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-3-william.qiu@starfivetech.com>
 <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 14:28, Mark Brown wrote:
> On Thu, Jul 13, 2023 at 05:00:14PM +0800, William Qiu wrote:
> 
>> The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
>> so there add minItems whose value is equal to 1. Other platforms do not
>> have this constraint.
> 
> Presumably this means that this is some variant of the usual pl022 IP,

Hm, in such case this could mean we need dedicated compatible.

> or that the clock is in fact present but is not modelled in your DT?

Best regards,
Krzysztof

