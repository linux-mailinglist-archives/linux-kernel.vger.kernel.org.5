Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B777754D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 04:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGPCEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 22:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGPCD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 22:03:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6BC26BC;
        Sat, 15 Jul 2023 19:03:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66767d628e2so2177517b3a.2;
        Sat, 15 Jul 2023 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689473037; x=1692065037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN1+B9rujjxMw1qUBg2KMt93qZtXYxGTcSrggvR1cyI=;
        b=DMTq/CDj5lnEkF5AI7MFu46NGv6cH1/1r3J7Ms1dTQJ3u2E8P3Cr+XYKLm5Mk2bJdz
         mBAYZx8jwR+Ac62jHV/299RhG0Lh5eO/nf1wEKY6OkJL+Uvvn0/wRIUQ9Jse6OMzi9aT
         BsnozozdfUNxbXvpgsqlJc2dGcy8JMxODu8iTkii2JNHAXKSU6MpYmoM7uVDj8q1qt+c
         PA4yxwDTp9NTCuVoIKCRERPe952oHSHaRJAXC/dKyoOuW9xb3eeJcSLpjD+iaCDAC986
         C300uyjnJg1GcgbRXaX9VNsPBLIHdNmH1Wx2Hw5h71j+hjrvikOOPY9ThiCEjMR7UiY0
         G5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689473037; x=1692065037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN1+B9rujjxMw1qUBg2KMt93qZtXYxGTcSrggvR1cyI=;
        b=D+hwdauKAh1ReU3p8P+CBPTk1aR3ppAGB1cp0Kk4m/2JtjEfk1XnR/tIcSxrZnjRVE
         yz7tI3J78YQtOWHRCJBdz/LUeMDW64bLSuNcmlUKjxdgXTHryisn6jNVX5ytuctaz+/6
         lgaeGY82nnfQFoVKHaK3c+7gBktZJ7nAeukGrmxxjjxvXEvwTGK3hE/sqxwwFiyVyGnd
         J7iw5xiPadwfemgB/BhrmOm7uMgOJvfqxDIuSCs7qtfcLRmj5CN201noSjcuhB7oWTgU
         xTbOOeXTN7sixruVuEQF7J/Cd1Vq+BTRXQvp/qDsKqSPdpy2oeOkZcHXTsE+/hoNIxLQ
         kwew==
X-Gm-Message-State: ABy/qLbVi8RfRSwkwlEw1FhN6N1ASdc0rH11yvdBCNnz6SMI10CfzCCS
        aFAjL/PSsI2nQNoqBoWDdc8=
X-Google-Smtp-Source: APBJJlHh3l7nMx/Z3ghRrpGo+77oJordFcXeo2vYt64bsJ5/5fmPdoyk6ruDCTHKMbsulGIDe0ixig==
X-Received: by 2002:a05:6a00:2d01:b0:66d:263f:d923 with SMTP id fa1-20020a056a002d0100b0066d263fd923mr10153782pfb.20.1689473036830;
        Sat, 15 Jul 2023 19:03:56 -0700 (PDT)
Received: from [192.168.1.5] ([121.32.71.42])
        by smtp.gmail.com with ESMTPSA id q1-20020a656a81000000b00553dcfc2179sm9129942pgu.52.2023.07.15.19.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 19:03:56 -0700 (PDT)
Message-ID: <db6ba884-7125-c2bb-de65-83b2f980e7a1@gmail.com>
Date:   Sun, 16 Jul 2023 10:03:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230715023653.56872-1-aarongt.shen@gmail.com>
 <20230715121253.gvhcszjoqxwh4gjz@pengutronix.de>
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <20230715121253.gvhcszjoqxwh4gjz@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat,Jul 15,2023 at 20:12:53PM GMT+8, Uwe Kleine-König wrote:
> On Sat, Jul 15, 2023 at 10:36:53AM +0800, Guiting Shen wrote:
>> The driver would never call clk_enable() if the PWM channel was already
>> enabled in bootloader which lead to dump the warning message "the PWM
>> clock already disabled" when turning off the PWM channel.
>>
>> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
>> the PWM channel was already enabled in bootloader.
>>
>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>> ---
>>   drivers/pwm/pwm-atmel.c | 50 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index cdbc23649032..4dd6e1319343 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -36,7 +36,7 @@
>>   #define PWM_SR			0x0C
>>   #define PWM_ISR			0x1C
>>   /* Bit field in SR */
>> -#define PWM_SR_ALL_CH_ON	0x0F
>> +#define PWM_SR_ALL_CH_MASK	0x0F
>>   
>>   /* The following register is PWM channel related registers */
>>   #define PWM_CH_REG_OFFSET	0x200
>> @@ -464,6 +464,45 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
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
>> +	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
>> +		if (sr & (1 << i))
>> +			cnt++;
>> +	}
> 
> If it's just about counting the set bits, there is the function
> bitmap_weight().

Got it, Thank you.


>> +	if (!on)
>> +		goto disable_clk;
>> +
>> +	for (i = 0; i < cnt; i++) {
>> +		ret = clk_enable(atmel_pwm->clk);
>> +		if (ret) {
>> +			dev_err(atmel_pwm->chip.dev,
>> +				"failed to enable clock for pwm #%d: %pe\n",
>> +							i, ERR_PTR(ret));
> 
> The output is bogus here. If SR is say 0xc, and the second enable
> fails, it's about pwm #3, but then i is 1.

I would just output the error clock message like this to fix it:
	dev_err(atmel_pwm->chip.dev,
		"failed to enable clock for pwm %pe\n", ERR_PTR(ret));


>> +			cnt = i;
>> +			goto disable_clk;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +disable_clk:
>> +	while (cnt--)
>> +		clk_disable(atmel_pwm->clk);
>> +
>> +	return ret;
>> +}
>> +
>>   static int atmel_pwm_probe(struct platform_device *pdev)
>>   {
>>   	struct atmel_pwm_chip *atmel_pwm;
> 
> Best regards
> Uwe
> 

-- 
Best regards,
Guiting Shen
