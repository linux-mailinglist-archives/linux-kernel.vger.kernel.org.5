Return-Path: <linux-kernel+bounces-130507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59889790C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF771C25E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A5314885B;
	Wed,  3 Apr 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="1sMyENt+"
Received: from mail-108-mta238.mxroute.com (mail-108-mta238.mxroute.com [136.175.108.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AC1514CF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172869; cv=none; b=SX/6tgx6RtyRU/fHxznYpPqJ7P5kT6M8F+gLNpdr4sMasu6Zvuxctsvu1ckH2S8V2g2g/xHyGeSZRwrC8yB6CJmzkxldJ/TiP3oiEC6d1rFrGee5MlrHzDjiMjYnbYZC89GJyXO0MlVLHSuvFu4VzJdDHfU3nNLcMlju7KLeRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172869; c=relaxed/simple;
	bh=cANrsz0u60hHFNJQZKvJ4/xJFm9Ch/qceTvDPi+CiFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ix0eaR3+IPG1kkDotvEk/57AIcrs83OYlHC7KFqVawuVReJV1xSMA9rUO9YSxvPhm5YsbldASQ4wz0Hx02VnGbBP321Xw2JG8z/vzqULjdsErimxYQXqKAzkuOwhggBlJfiUdkdhsXxViZgQBxN8Z0JAsI4X1MU+ECbuXf0EJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=1sMyENt+; arc=none smtp.client-ip=136.175.108.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta238.mxroute.com (ZoneMTA) with ESMTPSA id 18ea5747e090003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 19:34:18 +0000
X-Zone-Loop: b3223afca6d9dcad25040026afc7ed70ecf40e85aeec
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/VJr7xFJj+0rNkOMJVS/zLwSwMJZdRxVNuA6QJGZknw=; b=1sMyENt+XKyQGBnEprQFcuct+x
	GoWW1GYXqX7UiYycV7x5CHl4+zXrz/B4dbWf23n1VaYP3JAm8j+XCy3ta/ybDzJejeKTg4cQpEZes
	WbfwqlFgjioV0H6AqxzbH3dODmNihctMun5QSJMOP2RCZgGASD+SuiObWrr5vlp8V26G63CuzkYF+
	yRCEEvHWKLBJ7EzHou8ngOWzu/b2ZspJ9+iJtRd1um3Hqz7Z6ox/DUIX4EhYu3WJk2QyW2utr00LM
	axbfmuMMY9YGYj+7ughmnFMPrsUs7+oIwHY0kqI+xyizh6A/rrAplCYpQLKfTJLZ3sjRsIPG0HY8G
	iDDvdDAQ==;
Message-ID: <dd0e64c8-5eef-421a-9d9f-8a5865743369@luigi311.com>
Date: Wed, 3 Apr 2024 13:34:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/25] drivers: media: i2c: imx258: Add support for
 powerdown gpio
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-24-git@luigi311.com>
 <Zg2DBasC501hMQSS@kekkonen.localdomain>
 <wjlcde7yoooygj4hhdmiwrdloh6l4p6i2qbmjek5uwsifyzwgu@xjhutvmsdfou>
Content-Language: en-US
From: Luigi311 <git@luigi311.com>
In-Reply-To: <wjlcde7yoooygj4hhdmiwrdloh6l4p6i2qbmjek5uwsifyzwgu@xjhutvmsdfou>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: git@luigi311.com

On 4/3/24 10:57, Ondřej Jirman wrote:
> Hi Sakari and Luis,
> 
> On Wed, Apr 03, 2024 at 04:25:41PM GMT, Sakari Ailus wrote:
>> Hi Luis, Ondrej,
>>
>> On Wed, Apr 03, 2024 at 09:03:52AM -0600, git@luigi311.com wrote:
>>> From: Luis Garcia <git@luigi311.com>
>>>
>>> On some boards powerdown signal needs to be deasserted for this
>>> sensor to be enabled.
>>>
>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> Signed-off-by: Luis Garcia <git@luigi311.com>
>>> ---
>>>  drivers/media/i2c/imx258.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>>> index 30352c33f63c..163f04f6f954 100644
>>> --- a/drivers/media/i2c/imx258.c
>>> +++ b/drivers/media/i2c/imx258.c
>>> @@ -679,6 +679,8 @@ struct imx258 {
>>>  	unsigned int lane_mode_idx;
>>>  	unsigned int csi2_flags;
>>>  
>>> +	struct gpio_desc *powerdown_gpio;
>>> +
>>>  	/*
>>>  	 * Mutex for serialized access:
>>>  	 * Protect sensor module set pad format and start/stop streaming safely.
>>> @@ -1213,6 +1215,8 @@ static int imx258_power_on(struct device *dev)
>>>  	struct imx258 *imx258 = to_imx258(sd);
>>>  	int ret;
>>>  
>>> +	gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
>>
>> What does the spec say? Should this really happen before switching on the
>> supplies below?
> 
> There's no powerdown input in the IMX258 manual. The manual only mentions
> that XCLR (reset) should be held low during power on.
> 
> https://megous.com/dl/tmp/15b0992a720ab82d.png
> 
> https://megous.com/dl/tmp/f2cc991046d97641.png
> 
>    This sensor doesn’t have a built-in “Power ON Reset” function. The XCLR pin
>    is set to “LOW” and the power supplies are brought up. Then the XCLR pin
>    should be set to “High” after INCK supplied.
> 
> So this input is some feature on camera module itself outside of the
> IMX258 chip, which I think is used to gate power to the module. Eg. on Pinephone
> Pro, there are two modules with shared power rails, so enabling supply to
> one module enables it to the other one, too. So this input becomes the only way
> to really enable/disable power to the chip when both are used at once at some
> point, because regulator_bulk_enable/disable becomes ineffective at that point.
> 
> Luis, maybe you saw some other datasheet that mentions this input? IMO,
> it just gates the power rails via some mosfets on the module itself, since
> there's not power down input to the chip itself.
> 
> kind regards,
> 	o.
> 

Ondrej, I did not see anything else in the datasheet since I'm pretty sure
I'm looking at the same datasheet as it was supplied to me by Pine64. I'm
not sure what datasheet Dave has access to since he got his for a
completely different module than what we are testing with though.

>>> +
>>>  	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
>>>  				    imx258->supplies);
>>>  	if (ret) {
>>> @@ -1224,6 +1228,7 @@ static int imx258_power_on(struct device *dev)
>>>  	ret = clk_prepare_enable(imx258->clk);
>>>  	if (ret) {
>>>  		dev_err(dev, "failed to enable clock\n");
>>> +		gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>>>  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>>  	}
>>>  
>>> @@ -1238,6 +1243,8 @@ static int imx258_power_off(struct device *dev)
>>>  	clk_disable_unprepare(imx258->clk);
>>>  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>>  
>>> +	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -1541,6 +1548,12 @@ static int imx258_probe(struct i2c_client *client)
>>>  	if (!imx258->variant_cfg)
>>>  		imx258->variant_cfg = &imx258_cfg;
>>>  
>>> +	/* request optional power down pin */
>>> +	imx258->powerdown_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
>>> +						    GPIOD_OUT_HIGH);
>>> +	if (IS_ERR(imx258->powerdown_gpio))
>>> +		return PTR_ERR(imx258->powerdown_gpio);
>>> +
>>>  	/* Initialize subdev */
>>>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>>>  
>>
>> -- 
>> Regards,
>>
>> Sakari Ailus


