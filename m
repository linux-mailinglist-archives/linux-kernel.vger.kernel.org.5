Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0275BCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGUDXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUDXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:23:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEEB2729;
        Thu, 20 Jul 2023 20:23:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66869feb7d1so974066b3a.3;
        Thu, 20 Jul 2023 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689909800; x=1690514600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHecIKul0gU7fdVT3teNwesZNnsTZ9+IU+ORqN0e/Zk=;
        b=n4QO+s/tUBFNmX+nwaXkIX9qmQwWwSz8fllbevlzPEI+sTkwEIwfxfIiZY5UCecImQ
         Ltr7bUu+s5bg8676ou3DkBCEbuIpEgTMcy5jcWFD2QuLWf3mla+f+Fd3HvQJihf+lv7M
         v7LlRN0JY8ywQ8tbVoYnLydznHWMIzscyHms/3wVd4kNkyx8yYd8WG0MNwYZ77h55JBM
         lruqFJjvTCQQZ3RMZGUjh/0F9LydOyDmaFv6MfKmv8HLq9osyP7mCEzbct9nRo5W0u86
         ZCSgb9O7bocF7uUKJWrIc4/QMI8pwj4JSEoVnL54GO1nC7nnQlBZQLPLP3KlXfjnj+NQ
         O6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689909800; x=1690514600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHecIKul0gU7fdVT3teNwesZNnsTZ9+IU+ORqN0e/Zk=;
        b=bmz8y5YRHwZyBp2pswxAGW0ZPW0DLC2gTX7km2XoGKqPBJWHWlrFOw+FPDyr7haG3j
         QrYUhg6nAk3E0vZmr5eHi9KkpaQ5kK1S1jX6LdOtmdgVogjwZmYVlU3LCkMgCX6FcPxx
         4WkReNd4bbNFWhltcebnCiP+qJB5VGRmTXhSj1RP9m+49iFV5lNkyqcgqILm3dozoBuf
         /4/kP+KqOJ1E0cmqkDnnRwIw4xzhq2UZAoBv5oLei2v1o0HvDlrJfJfVdzd3VoEi340h
         SJ5G+5YiIczd98ZT08MyClUhvfx77zXV5bu2oKe3qt/D/pPBcFrIQBOBDH0omeZ8z4JN
         UTpQ==
X-Gm-Message-State: ABy/qLaPKLHXcBCHWIKI2N0M87Z+pagotR54+EWboTlK+QDhgPUbmoOT
        9gMsJtUxF6/rPFRUQalLmMx4yDF4ooVs0iBR
X-Google-Smtp-Source: APBJJlEK4NTWGGtsX2TrBgUD/7odoPs2h3EVz7Jscbhj5sbG9E7iLYby2PYpVlmynl5FvuyfHySvSg==
X-Received: by 2002:a05:6a20:a110:b0:132:86ea:4725 with SMTP id q16-20020a056a20a11000b0013286ea4725mr824854pzk.45.1689909799965;
        Thu, 20 Jul 2023 20:23:19 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001b51b3e84cesm2172928plg.166.2023.07.20.20.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 20:23:19 -0700 (PDT)
Message-ID: <c79d5a16-2716-6cd8-8b6a-f0e5916a65cf@gmail.com>
Date:   Fri, 21 Jul 2023 11:23:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v6] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     claudiu.beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230716020652.18557-1-aarongt.shen@gmail.com>
 <ZLlO3vGr-ECdnmKA@orome>
Content-Language: en-US
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <ZLlO3vGr-ECdnmKA@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 23:12:30PM GMT+8, Thierry Reding wrote:
> On Sun, Jul 16, 2023 at 10:06:52AM +0800, Guiting Shen wrote:
>> The driver would never call clk_enable() if the PWM channel was already
>> enabled in bootloader which lead to dump the warning message "the PWM
>> clock already disabled" when turning off the PWM channel.
>>
>> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
>> the PWM channel was already enabled in bootloader.
>>
>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>> ---
>>  drivers/pwm/pwm-atmel.c | 47 +++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index cdbc23649032..fc89282db645 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -36,7 +36,7 @@
>>  #define PWM_SR			0x0C
>>  #define PWM_ISR			0x1C
>>  /* Bit field in SR */
>> -#define PWM_SR_ALL_CH_ON	0x0F
>> +#define PWM_SR_ALL_CH_MASK	0x0F
>>  
>>  /* The following register is PWM channel related registers */
>>  #define PWM_CH_REG_OFFSET	0x200
>> @@ -464,6 +464,42 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
>>  
>> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
>> +{
>> +	unsigned int i, cnt = 0;
>> +	int ret = 0;
>> +	u32 sr;
>> +
>> +	sr = atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
>> +	if (!sr)
>> +		return 0;
>> +
>> +	cnt = bitmap_weight((unsigned long *)&sr, atmel_pwm->chip.npwm);
> 
> Tiny nit here: not sure if that cast is safe to do. You've got a 32-bit
> variable, but if you cast &sr to unsigned long * on a 64-bit machine it
> would cause hweight64() to get called and that would then read 64 bits
> from a 32-bit variable. This probably works most of the time because we
> don't read any of the upper bits, but it is strictly an illegal access
> and could be unaligned as well.

I found that the CONFIG_PWM_ATMEL was only in arch/arm/configs directory
which seems that the pwm-atmel driver only run in 32-bit soc machine.

> Should we just turn sr into an unsigned long to be safe here? No need to
> resend, I can make that change when I apply.

Yes, It is safer by doing this. Thank you.

-- 
Regards,
Guiting Shen

