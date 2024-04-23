Return-Path: <linux-kernel+bounces-155985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE628AFC61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D651F247E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237862E62F;
	Tue, 23 Apr 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Ey2kgYal"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9EC1C6BE;
	Tue, 23 Apr 2024 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913229; cv=none; b=KYYHWbMTUHOO/5tm3ghhXQ02wbyHIFHGCUMLds2HaSNKkrICpFBF3Pny5scOTA3CxmS3izhb5blnjRaA4+QOGOJ43QlSngeDCX56HTrUA7kDacZVkaqe2UqesC5C0HIzD5h+9pvDuRY1lNx4jRG1X9hA109goMT58mCMM/0KF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913229; c=relaxed/simple;
	bh=g2/HsqUrBh9Sgq2CvmzDNLX3ZRhUVGTx7iFVUGdteJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jcDcl/nMlFBzdqI0DBuUmkXkk0/Dq83yEn9L0vsVC4SLnwx4QF+yaI2vp/hLqCTL26B147FgjEnh2Owi6zXAW1HDAZURWFtYFiYUaIjcpJ1GyM/jIHl8IEL4ne/VsdXtZPG8GDrCqnsKqj+/eZ3tIfWDJtHJrYrZDI5nbs1k8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Ey2kgYal; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 23725100004;
	Wed, 24 Apr 2024 02:00:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 23725100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713913221;
	bh=tcVfNzm8I5LEMAd+H5pTx/XXdCO1zxNExqAEu+sh1rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Ey2kgYalHNsRgGMEO8gcRyn3v4qM3sybzmq8nLPF5QgoUxsadY+FbtMZ0/fPt6/sp
	 kDgX9dxk+jdYtPfZQcWaax5+HH8QwHvpuG2+FgPMEi9A8fKwJXD5FUGSBexCT3xdm9
	 5aGwvjIJqEe16Ep7Fbap0bnVS4+neN8mS/6BczYxn3VP7NYLyrZ3zGciNCXr323hfY
	 i8wSdmMUrkOG1sKC/xLWOlvUcE6jX6Sx2JP5DaDDeihgnPLA8tNr8kGIkg5TlsqK8N
	 D5m7oLk4CPJLiZgmQVayu00tjEACovLNRcwAGfyi+nFm82MuO6mwM41q3XSMyddk2q
	 K1aNgUCRAT6Sg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 02:00:20 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Apr 2024 02:00:20 +0300
Message-ID: <4feb8fe3-af72-4483-87b2-30503328cfe2@salutedevices.com>
Date: Wed, 24 Apr 2024 02:00:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: meson: support meson A1 SoC family
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<thierry.reding@gmail.com>, <hkallweit1@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-3-gnstark@salutedevices.com>
 <1jv848ezzo.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <1jv848ezzo.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184885 [Apr 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/23 19:04:00 #24945065
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Jerome

Thanks for the review


On 4/23/24 20:35, Jerome Brunet wrote:
> 
> On Tue 23 Apr 2024 at 19:10, George Stark <gnstark@salutedevices.com> wrote:
> 
>> From: George Stark <gnstark@sberdevices.ru>
>>
>> Add a compatible string and configuration for the meson A1 SoC family
>> PWM. Additionally, provide an external clock initialization helper
>> specifically designed for these PWM IPs.
>>
>> Signed-off-by: George Stark <gnstark@sberdevices.ru>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index ea96c5973488..529a541ba7b6 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -462,6 +462,33 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>   }
>>   
>> +static int meson_pwm_init_channels_ext_clock(struct pwm_chip *chip)
> 
> That kind on naming (ext) is almost sure to clash with whatever comes next.
> Just use the name of the first SoC using the method, a1 for instance.

It's true that pwm core in a1 s4, t7 etc is the same AFAWK.
I just want to clarify your proposal:
I add a1 compatible to the dt-bindings with s4 as fallback,
t7 compatible will be added later in the same way.

Here in the driver I don't mention a1 at all and use s4-centric naming e.g.:

{
	.compatible = "amlogic,meson-s4-pwm",
	.data = &pwm_meson_s4_data
},
static const struct meson_pwm_data pwm_meson_s4_data = {
	.channels_init = meson_pwm_init_channels_s4,
};

right?

>> +{
>> +	struct device *dev = pwmchip_parent(chip);
>> +	struct meson_pwm *meson = to_meson_pwm(chip);
>> +	struct meson_pwm_channel *channels = meson->channels;
>> +	struct clk_bulk_data *clks = NULL;
>> +	unsigned int i;
>> +	int res;
>> +
>> +	res = devm_clk_bulk_get_all(dev, &clks);
>> +	if (res < 0) {
>> +		dev_err(dev, "can't get device clocks\n");
>> +		return res;
>> +	}
> 
> I don't think allocating the 'clk_bulk_data *clks' is necessary or safe.
> We know exactly how many clocks we expect, there is no need for a get all.
> 
>> +
>> +	if (res != MESON_NUM_PWMS) {
>> +		dev_err(dev, "clock count must be %d, got %d\n",
>> +			MESON_NUM_PWMS, res);
>> +		return -EINVAL;
>> +	}
> 
> ... and this only catches the problem after the fact.
> 
> It is probably convinient but not necessary.
> 
>> +
>> +	for (i = 0; i < MESON_NUM_PWMS; i++)
>> +		channels[i].clk = clks[i].clk;
> 
> channels[i].clk could be assigned directly of_clk_get() using clock
> indexes. No extra allocation needed.

if we use of_clk_get then we'll have to free the clock objects in the
end. Could we use devm_clk_bulk_get instead?

>> +
>> +	return 0;
>> +}
>> +
>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> @@ -500,11 +527,19 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>>   	.channels_init = meson_pwm_init_channels_meson8b_v2,
>>   };
>>   
>> +static const struct meson_pwm_data pwm_meson_ext_clock_data = {
>> +	.channels_init = meson_pwm_init_channels_ext_clock,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>   	{
>>   		.compatible = "amlogic,meson8-pwm-v2",
>>   		.data = &pwm_meson8_v2_data
>>   	},
>> +	{
>> +		.compatible = "amlogic,meson-a1-pwm",
>> +		.data = &pwm_meson_ext_clock_data
>> +	},
>>   	/* The following compatibles are obsolete */
>>   	{
>>   		.compatible = "amlogic,meson8b-pwm",
> 
> 

-- 
Best regards
George

