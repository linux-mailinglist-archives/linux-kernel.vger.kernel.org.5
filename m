Return-Path: <linux-kernel+bounces-168408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73F8BB83E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7069DB23FFC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87083CD8;
	Fri,  3 May 2024 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fl4HV5pC"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D482492;
	Fri,  3 May 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778861; cv=none; b=hsXiUEcBdICfmpZzgJ1sznCGAMWSF1cYz4Cxn1CxT3E2RSLJJSEBxOFosuGcuGKZnss/c4z9iYsJVVQ7Sc8OPOAgJXSXdYSE0sSVMeVZ6j+d8HnY7WGW2wYeNfDOUhN/LumLZFxEQ/do9ESC6Czo4A4/EFPYlW/gX3BxjMhhoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778861; c=relaxed/simple;
	bh=km2JbMYOVMBRBh5wdBigoe+/JkP+p1OtJjyOJmtgrNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j4Pn4xhXlaCq2byW8Huhbdnd+buVBN+YRcfsYd7bChUzL1L8asS/TJZObumSUS0RfYV6X9ky+O7aqZASJptxNdJSolMoge9zZWl8eYu9FIDMqsbrslnLMyrmCZQUcjiWsaffEb5viMMCXDhlMZRX/0F5u5GXNex+02/6/BTM/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=fl4HV5pC; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 89D0B12000D;
	Sat,  4 May 2024 02:27:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 89D0B12000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714778853;
	bh=aqLgLmOfjg9tWRTqIW89TpjQRFOLV36kFW4nNXsy8JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=fl4HV5pCdGAVnzJc5bj322ihGtRGNMSbHUxQG4SJHrf0wMTZJo44yM1pMIDcp/xqo
	 pyHvyJLhuQ9rQtJZoOKnQQvW98ytoqEmwfYUcM6bp+yGWmEKLXOWNbIHpYM2Galgun
	 PLn+eZ1hipBGE69WeC8zIdQrAaJUg18lfpyMUdtT7gsUvi0NaxfADO+lCr/AV29qHY
	 W9LqFdPs4vi2QEXqme3macsDnW8EdJ16nu8t4Vv/CNwMYRE63MUjHGtYma++ZJvN40
	 yoksLU9AvnEAcBozU9sxyJ0KKFpcst51JEt+nbL0xqR0qmVsBIv/D0AyW0erXUFcKa
	 6/sHc3og6GF3g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat,  4 May 2024 02:27:33 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 4 May 2024 02:27:33 +0300
Message-ID: <80e41cb1-6ad9-436c-b5b0-2045e6a379b7@salutedevices.com>
Date: Sat, 4 May 2024 02:27:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] pwm: meson: Add support for Amlogic S4 PWM
To: Junyi Zhao <junyi.zhao@amlogic.com>, <kelvin.zhang@amlogic.com>
CC: Jerome Brunet <jbrunet@baylibre.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
 <20240424-s4-pwm-v4-1-ee22effd40d0@amlogic.com>
 <1jil07f3ps.fsf@starbuckisacylon.baylibre.com>
 <d990d835-e4bb-4248-b17e-da8907cf16e7@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <d990d835-e4bb-4248-b17e-da8907cf16e7@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185054 [May 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/03 16:56:00 #25080849
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Junyi, Kelvin

I'm sorry for the ping. Do you have plans to finish these patches?

Here is sample code how devm could be used to manage clk objects created
by of_clk_get:

struct clk_set_devres {
	struct clk *clks[MESON_NUM_PWMS];
};

static void devm_clk_set_release(struct device *dev, void *res)
{
	struct clk_set_devres *devres = res;
	int num_clks = MESON_NUM_PWMS;

	while (--num_clks >= 0)
		clk_put(devres->clks[num_clks]);
}

static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
{
	struct device *dev = pwmchip_parent(chip);
	struct meson_pwm *meson = to_meson_pwm(chip);
	struct clk_set_devres *devres;
	unsigned int i;
	int res;

	devres = devres_alloc(devm_clk_set_release,
			      sizeof(*devres), GFP_KERNEL);
	if (!devres)
		return -ENOMEM;

	devres_add(dev, devres);

	for (i = 0; i < MESON_NUM_PWMS; i++) {
		devres->clks[i] = of_clk_get(dev->of_node, i);
		if (IS_ERR(devres->clks[i])) {
			res = PTR_ERR(devres->clks[i]);
			dev_err_probe(dev, res, "Failed to get clk\n");
			return res;
		}
		meson->channels[i].clk = devres->clks[i];
	}
	return 0;
}

On 4/24/24 14:44, Junyi Zhao wrote:
> 
> 
> On 2024/4/24 18:32, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Wed 24 Apr 2024 at 18:28, Kelvin Zhang via B4 Relay 
>> <devnull+kelvin.zhang.amlogic.com@kernel.org> wrote:
>>
>>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>>
>>> This patch adds support for Amlogic S4 PWM.
>>>
>>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>> ---
>>>   drivers/pwm/pwm-meson.c | 37 +++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index ea96c5973488..6abc823745e4 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -462,6 +462,35 @@ static int 
>>> meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>>        return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>>   }
>>>
>>> +static int meson_pwm_init_channels_meson_s4(struct pwm_chip *chip)
>>> +{
>>> +     int i, ret;
>>> +     struct device *dev = pwmchip_parent(chip);
>>> +     struct device_node *np = dev->of_node;
>>> +     struct meson_pwm *meson = to_meson_pwm(chip);
>>> +     struct meson_pwm_channel *channel;
>>> +
>>> +     for (i = 0; i < MESON_NUM_PWMS; i++) {
>>> +             channel = &meson->channels[i];
>>> +             channel->clk = of_clk_get(np, i);
>>> +             if (IS_ERR(channel->clk)) {
>>> +                     ret = PTR_ERR(channel->clk);
>>> +                     dev_err_probe(dev, ret, "Failed to get clk\n");
>>> +                     goto err;
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +
>>> +err:
>>> +     while (--i >= 0) {
>>> +             channel = &meson->channels[i];
>>> +             clk_put(channel->clk);
>>
>> Fine on error but leaks on module unload.
>>
>> Same as George,
>>
>> Add the devm variant of of_clk_get() if you must.
>> Use devm_add_action_or_reset() otherwise
> Hi jerom，but we have discussed before.devm variant such as follows：
> devm_clk_get_enable(struct device * dev, char * id)
> struct clk *devm_clk_get(struct device *dev, const char *id)
> struct clk *devm_clk_get_optional(struct device *dev, const char *id)
> 
> after i check api parm ,these api's 2rd parm "id" is string not index.
> because dt binding have no name property. could we use devm？
>>
>> Could please synchronize this series with George and deal with all the
>> supported SoCs ? a1, s4, t7, c3 ...
>>
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>>        .parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>>        .channels_init = meson_pwm_init_channels_meson8b_legacy,
>>> @@ -500,6 +529,10 @@ static const struct meson_pwm_data 
>>> pwm_meson8_v2_data = {
>>>        .channels_init = meson_pwm_init_channels_meson8b_v2,
>>>   };
>>>
>>> +static const struct meson_pwm_data pwm_meson_s4_data = {
>>> +     .channels_init = meson_pwm_init_channels_meson_s4,
>>> +};
>>> +
>>>   static const struct of_device_id meson_pwm_matches[] = {
>>>        {
>>>                .compatible = "amlogic,meson8-pwm-v2",
>>> @@ -538,6 +571,10 @@ static const struct of_device_id 
>>> meson_pwm_matches[] = {
>>>                .compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>>                .data = &pwm_g12a_ao_cd_data
>>>        },
>>> +     {
>>> +             .compatible = "amlogic,meson-s4-pwm",
>>> +             .data = &pwm_meson_s4_data
>>> +     },
>>>        {},
>>>   };
>>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>>
>>
>> -- 
>> Jerome

-- 
Best regards
George

