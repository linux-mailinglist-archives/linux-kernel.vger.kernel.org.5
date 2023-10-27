Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E007D94C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345661AbjJ0KJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0KJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:09:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F1C4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:09:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32dc918d454so1188050f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698401370; x=1699006170; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=eCgIckExqjVeeUki95cqbKKediAgvysu6tsWmmMNWo8=;
        b=tki/2Z5WiL9IEojLoyOHzAllY7xpY7D2ozxNXhWmypjnVPkncwO697r3HnDiC42nJs
         pYu5aWNMzO10HMGFs/o2BePQ5qBglX6A1vkIrVxiAeRbKqzR/Fy6QqMZdAGh4O3uvGde
         vEAO7yAd9O50GYfJQ6emQjbJXLa7kh1YzU5jSJT8w656CaZWQ5ERA35Xi39f5JvuCqzo
         YZzY1tcaekq/ARb0vf+gQzwaJ1RVVypqINR6zEvRhNKKL0ZO2jXY1IJBLUTGlUf2WM+a
         JBGe34LLzU27VfYjaNXRkUFyNYLNjggQVCH+tDLmY5/zHB6qfPNHZh5cGFj4ZZkf7RFc
         VY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401370; x=1699006170;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCgIckExqjVeeUki95cqbKKediAgvysu6tsWmmMNWo8=;
        b=hThvbI9YQVdkTFW6kST9iUOCEsabxK9Qk3UnYLVh+Lr1F6z24up+jAIlN3hPBgN496
         xl8Eup/KIfKMj5TblM14iSXq23jQAXjD6yu2UVo7ZNRt+XGql6ss0p6LKkPhqB5LOdvG
         HIxIF1bW+WbvFIE9hl5pI+mhUELZjrgySsq8u3V4x2u6i2bLuswKf+gcFX+34JJ/oPXP
         m5UCzmji7zVDx3WHpHHx3bQlNjJUVdQOKSnxdJq06Tw0PgDjTpBX/QwktI37myy9ebTo
         iqLg1cLXVT49XjuX7afGJieP0X4L2FKsjkVBlQWlb66+VSgByhzkf83KM9l04aKdbGE8
         0gYQ==
X-Gm-Message-State: AOJu0YxKsqfF/8psplxYvQPteeBtqqD9QOqrRdBuEhxtgYyNBsJA3Kaa
        Z0Y4oDz7VYvUqvHDie7SnUU1fQ==
X-Google-Smtp-Source: AGHT+IGa1T7lEat0slw/AwjDK1QpinPLfhfQndnxOfkNu0bsXcI3kQkBPm8CYqm1V9dqWxwRoE9W/Q==
X-Received: by 2002:a05:6000:b8d:b0:32d:9395:dec6 with SMTP id dl13-20020a0560000b8d00b0032d9395dec6mr1985532wrb.67.1698401370089;
        Fri, 27 Oct 2023 03:09:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:816f:104b:c6b3:b87d])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d534b000000b0032da7454ebesm1413195wrv.79.2023.10.27.03.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:09:29 -0700 (PDT)
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
 <10dcc778-f165-407e-b765-760d277d5e35@salutedevices.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     George Stark <gnstark@salutedevices.com>,
        JunYi Zhao <junyi.zhao@amlogic.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
Date:   Fri, 27 Oct 2023 12:00:50 +0200
In-reply-to: <10dcc778-f165-407e-b765-760d277d5e35@salutedevices.com>
Message-ID: <1jzg041ina.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 23 Oct 2023 at 23:07, George Stark <gnstark@salutedevices.com> wrote:

> Hello JunYi Zhao
>
> On 10/16/23 08:24, JunYi Zhao wrote:
>> From: "junyi.zhao" <junyi.zhao@amlogic.com>
>> Support PWM for S4 soc.
>> Now the PWM clock input is done in independent CLKCTRL registers.
>> And no more in the PWM registers.
>> PWM needs to obtain an external clock source.
>> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>
>> ---
>> V2 -> V3:
>> Rebase and Review the latest upstream code again.
>> After reconstruction, stick to the previous code as much as possible.
>>   drivers/pwm/pwm-meson.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 25519cddc2a9..fe9fd75747c4 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -99,6 +99,7 @@ struct meson_pwm_channel {
>>   struct meson_pwm_data {
>>   	const char * const *parent_names;
>>   	unsigned int num_parents;
>> +	unsigned int extern_clk;
> may be bool extern_clk;
>>   };
>>     struct meson_pwm {
>> @@ -396,6 +397,10 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>>   	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>>   };
>>   +static const struct meson_pwm_data pwm_s4_data = {
>> +	.extern_clk = true,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>   	{
>>   		.compatible = "amlogic,meson8b-pwm",
>> @@ -429,6 +434,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>   		.data = &pwm_g12a_ao_cd_data
>>   	},
>> +	{
>> +		.compatible = "amlogic,s4-pwm",
>> +		.data = &pwm_s4_data,
>> +	},
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>> @@ -451,6 +460,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>>   		struct clk_parent_data div_parent = {}, gate_parent = {};
>>   		struct clk_init_data init = {};
>>   +		if (meson->data->extern_clk) {

Instead of hacking through the existing registration function, it be
much better to provide the clock registration function as on ops in dt data.

Also, as Neil pointed out on the v2 [1], the meaning of clkin0/1 is changed
on this SoC.
* On previous SoC, it was a reference to clock input the PWM block
  should select from the hard-coded list it has (should fix that
  someday)
* Now it is directly the input the PWM block must claim.

You need to update the bindings accordingly for the S4

[1]: https://lore.kernel.org/linux-amlogic/07581fb8-0cd9-5b76-6fa3-1d1a7353d944@baylibre.com

>> +			snprintf(name, sizeof(name), "clkin%u", i);
>> +			channel->clk = devm_clk_get(dev, name);
>> +			if (IS_ERR(channel->clk)) {
>> +				dev_err(meson->chip.dev, "can't get device clock\n");
>> +				return PTR_ERR(channel->clk);
>> +			}
>> +			continue;
>> +		}
>> +
>>   		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>     		init.name = name;
>> base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36

