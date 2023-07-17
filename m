Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA1755B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGQF7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGQF67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:58:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37A8E4B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:58:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98e011f45ffso514520366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689573536; x=1692165536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k631ugiro94uqzvQOpxnR6/BSCvO3zY6daW5g9o+b4c=;
        b=noOLwLxY+8VAm0GPn80Qt4djj2hliItvWMeuYPZ/VfTfgfhYBFycibxIxgGcwk33Lp
         u/O3HL17SUAbD3NcKuxcc6GjqP8tSLuRaKgSgG1C0grYZbJQGXkDJJjX4j6ZSGYaGHi+
         RrI2unE/l6vQZUTdCLbShqcRYz09++k5rEqKdfWyJ4FCoBUPP8QLlc4AfAFYENcTPHT3
         8hE3Vin1cthOnb/8miTb6ChvPIEE/pNB/iIOSunjO8Qc/P1jkAxi/qZraRM2bYVRH0CT
         LCXha+Mc32qhmi7/0nra1k3eMBcBWDtXkT26BiBP54XoiDsMuRbE4TmkvSThBhHoBMIO
         1MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689573536; x=1692165536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k631ugiro94uqzvQOpxnR6/BSCvO3zY6daW5g9o+b4c=;
        b=OY4IO/BzphIuDFrDQcZv/yiKS3PMi8dH4PPI0OZoLgHBhwvd8r8ORgiqGYC/gEnBw/
         cOy6vbpwscReU0bswSxhTPd0NIsiza7vORw0ELAVqGanvvwAYINAutRAMY2P/QJ/sBfq
         6d3tSt+xhbNO3r3ceVlSWWQUKn4akt7w6sqjBqSqUkJg/QIzbRRgrar47r/Q2s4ScSYq
         vsxM6yhny8p8UZ9Yp1XEDkqIl0AqyLEyy9lZkCqh8INhrA9ZoXHtxujKBuFLFtt9Q5ud
         W6sr29RBHOIwRK9ve8JLBwxDmmdbJM0eZ0WQ4SuW0Lm3jk8QQ7Xj7Lg65ncI0Ns9UdPn
         mR+A==
X-Gm-Message-State: ABy/qLYhlKz2EfdQ4tN4/sq+545jIOhsmYcZ3qqPZQc7C5frx3JohHIz
        NaRC53INFyyjeuOQBXhc/n1mzw==
X-Google-Smtp-Source: APBJJlHgKqIdlmRkFNftYeegIddWrsGKkE5tQaWsbAjoEdQ4qunH1DIhrT2XP16EPef81XkUgI71JQ==
X-Received: by 2002:a17:906:74c4:b0:993:fba5:cdfa with SMTP id z4-20020a17090674c400b00993fba5cdfamr9395356ejl.26.1689573536167;
        Sun, 16 Jul 2023 22:58:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm8678232eju.215.2023.07.16.22.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 22:58:55 -0700 (PDT)
Message-ID: <31af3a96-7e98-8bb1-f9e9-53ccb0441310@linaro.org>
Date:   Mon, 17 Jul 2023 07:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] pwm: samsung: Add compatible for ExynosAutov9 SoC
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
 <CGME20230714101434epcas2p3e2475698c527ca72dee797225d3dad37@epcas2p3.samsung.com>
 <20230714100929.94563-3-jaewon02.kim@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714100929.94563-3-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 12:09, Jaewon Kim wrote:
> Add new compatible string to support ExynosAutov9 SoC.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index e8828f57ab15..50a88565c440 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -513,6 +513,7 @@ static const struct of_device_id samsung_pwm_matches[] = {
>  	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant },
>  	{ .compatible = "samsung,s5pc100-pwm", .data = &s5pc100_variant },
>  	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p64x0_variant },
> +	{ .compatible = "samsung,exynosautov9-pwm", .data = &s5p64x0_variant },

That's not what I asked for. You do not need entry here. Devices are
compatible.

Best regards,
Krzysztof

