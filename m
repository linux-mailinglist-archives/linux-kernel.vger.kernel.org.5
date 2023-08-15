Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF977CDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjHOOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjHOOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:21:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561E173F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:21:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so49362325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692109294; x=1692714094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcRYAsELzZ8xRLuoOUuCkPhIs6L8FpGXiLKJ/U31bwc=;
        b=W8xTN3MuYzsk/gktkGIfSE/PAeK98mpIjOfIYE/T3/2MX3yrRDb3azJBlDK7GzR4Tz
         AeAQ1bz+s0fHgqrEMYLn3BVVDyNWduExyhI/6N/4zIrQJuAHXr6fFhOmTLj7hWxMmtET
         1u+RyuVd3gerwE9AxrDSts6g178F9f5MN/GgBsJpDdw4XytAeIFvwXAlXtAlnl9aoNyT
         coz/AW+OnpkcCaCsvms44BGaXma8zUXstmUicH+SC/GSxqHJqyGj8TRnunGmkcLQPnqh
         WzkN91TLjGSWaHEkSsrKad4jQ3Ez58daY/eHTzDqMHDAj7vUlZNJu+dVeCKapvbKTuZD
         iKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109294; x=1692714094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcRYAsELzZ8xRLuoOUuCkPhIs6L8FpGXiLKJ/U31bwc=;
        b=kTqlBEgDSSnJ5WmmW2Ux5UVJKPP2DWGkahPHbn+BwzDf7ocmc95iUn1zyO1c2ZhRWw
         bInCjgykeh/+7Xzp1wWiU/axkMewOy4cXPdowtPpqhlI9euiwdKrK+4NAwrLZZ1KdRbV
         KduP7iGsJyMNQFoa2XDWCbRX1cZZsz/sCrJjhDBFjc2i+Mfw5xv8bBIyjF78ODXGJfPr
         dQczdqCklSS4bJzbJzQp8yBGiawEg3ukpYM+jsGVzMDf/RJTTS0wKs/MleufAZo+hYkM
         acQ2jRcC+6Z36Pjl675MMPRVQWe0N2jWmrzEqVzC8TgfPoD3UElMsxNbVXIg1bMB57Fi
         7SCA==
X-Gm-Message-State: AOJu0Yyd4CcM80l2VIFPAbI6usGLdPjFHiuP7cAsnh/wSqWXuzY6fuWx
        q9SwkEnnoT5s0oDDp1lrekjSXQ==
X-Google-Smtp-Source: AGHT+IGMZDYsY9WXT/bGyg3GabwvTyu8r4sZ31hz3OHbKpNSggTjUynaU2Kv5wRsGCL3EmjExdrD9A==
X-Received: by 2002:adf:e784:0:b0:319:6d91:28c2 with SMTP id n4-20020adfe784000000b003196d9128c2mr6426748wrm.61.1692109294035;
        Tue, 15 Aug 2023 07:21:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b003141f96ed36sm18128814wri.0.2023.08.15.07.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:21:33 -0700 (PDT)
Message-ID: <e8548782-65bf-114e-afb9-f0450468f6a5@linaro.org>
Date:   Tue, 15 Aug 2023 16:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] ASoC: aw88261: Fix unitialized ret of
 aw88261_reg_update()
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, llvm@lists.linux.dev,
        Andi Shyti <andi.shyti@kernel.org>
References: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
 <7b35b3b6-7eab-4652-9a16-851a060350bd@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7b35b3b6-7eab-4652-9a16-851a060350bd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 16:10, Mark Brown wrote:
> On Thu, Aug 10, 2023 at 12:47:43PM +0200, Krzysztof Kozlowski wrote:
>> There is a branch in if() clause where aw88261_reg_update() could return
>> uninitialized value.  Pounted out by W=1 clang build:
> 
> This series appears to have two copies of every patch which *look*
> similar but I'm not 100% sure if that's the case or in general what's
> going on - could you please resend a clean copy, it's probably easier
> than figuring it out?

Sorry for that, I must have screwed something while sending. I'll rebase
(first patch seems to be already fixed by Arnd) and send again.

Best regards,
Krzysztof

