Return-Path: <linux-kernel+bounces-156605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94B8B0580
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456C728CFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E93158D69;
	Wed, 24 Apr 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oiE7Rbnh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B66157489
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949713; cv=none; b=tn6FDik2d/Uz0ZPt+GuE2GCXZWdBmOjrjAQsfw6ZILLzrbJXt+8f3E+fNwaO7Xlxxb/+FpwO/a6FEo5Bx9VzAN2ogbhQaRAFET/oEAuzXU9BBfetvHg5mGVuNpOnlbsdKJ1ShPdvq6w4g5OWjYdwve4QUyZOyKfjd0j7uvZlqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949713; c=relaxed/simple;
	bh=Msw/f+57MQK6afEMuOsBELp1SeA+pbWBBWPgm728e/w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=RLwawQ7sPvYYhNc/bD+asaC1cibtw051rs/t/M+MSpLUtvEy7wfT7zMcFnd0aarxO1+/MyCUZ9F8TJ/4bXU/KULI6F3cwREXLOPUz2Be4qH9jEVKcXxEW2BoOvI4dfBzcZNiMR1laLkIfxjquYpxbXoXL3EDiaheqFiD8Lo/qss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oiE7Rbnh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso25889215e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713949708; x=1714554508; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rvbtxxL0KA7+nw2JDrdSITHMot8lmC1r+u81WvHz+K8=;
        b=oiE7RbnhV18YVH9BixeqGUZG7Mo7pfAHwvHwP0KOjRp2OOqcHvxFUSKtXytKyBHN84
         vwMWIMGM1yCzP+wlrsjGtkY2WfYtlnqIXgAmb/carwV3IVMHokmara41dAFQISTfC9Z6
         kziTT+FLknabpZjQ9vLHblcFpFuDyJHDz3mg5N5iCtpQwe9H87RKSWWInGgic1NB3I6N
         xyE1PSP6fiqM9yMXMMeARWDQWI9SSlsQTfqT8RnRdjV98Wm7MaINY+TpWTfmBCgvmgty
         OZ88sp1TnckNb4CMmDe0j8FaytMnEbVzlC0PYdrP7TbYopy/0QvhvoAL6iN8ksWElfNG
         gi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949708; x=1714554508;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvbtxxL0KA7+nw2JDrdSITHMot8lmC1r+u81WvHz+K8=;
        b=s6krcGYnzkMXobtvzK+W4jGw1709YPbSlfuyKQTyiHIRLEUH96hwyfGt2rm6tRSIYa
         8Oeph/ON2NkNzywlpqyjlgj40gkDliYDDp5r+NpL44AyuTcmn5LGzlYV6cMwoJ5Wj7T7
         LMtiZl3ZMoybGgII8tcJ1bJxXQjn3IN1iIO6Ry1Iulq0qY6ebZpTInTmuZVeG4TOY3bY
         qKTQ/eQkERBDpY8C2KMDTu226/4zZKFis42FsqU078dCwdGvADDXZPnrJRN5CmaWYZFd
         TechQn1QHHSjIZWvSd6MPEGk+m3fRW2rWJdVtKMyPlzSSYfGeXA1JlMCxEbmLgp3kwwg
         41hg==
X-Forwarded-Encrypted: i=1; AJvYcCVLnOdd/JiKtJROENrlj5xvekfh2XKOXyk49SYeEy6uCPuIve9NH9Z2JCaXZZBhodxVT28suPCbFt7xOXt10lk7c5NVyRFuq/Te1aqR
X-Gm-Message-State: AOJu0YwRNhIOBc5g005wVKKgMSPUKE7CclIqbmO8NVBG6X3E3/iM7RXs
	chF51cCQd+ZCWMHL3Jih/6xTZoYxMtaTX8Jpn0iAqT08bU9iMJiun+s5ZjZdMJo=
X-Google-Smtp-Source: AGHT+IFezzal7JjWvHMGZYy61bCLzRhsiQD5U7WszFsfXL9gRrzNRJlTMjBSCQ2VYQubwKxlAGjtSw==
X-Received: by 2002:a05:600c:468d:b0:418:f307:4b82 with SMTP id p13-20020a05600c468d00b00418f3074b82mr1358453wmo.39.1713949708334;
        Wed, 24 Apr 2024 02:08:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ab48:1b7:631c:952a])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b0041b0d4e1c27sm987467wms.42.2024.04.24.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:08:27 -0700 (PDT)
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-3-gnstark@salutedevices.com>
 <1jv848ezzo.fsf@starbuckisacylon.baylibre.com>
 <4feb8fe3-af72-4483-87b2-30503328cfe2@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u.kleine-koenig@pengutronix.de,
 neil.armstrong@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, thierry.reding@gmail.com,
 hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com, George Stark
 <gnstark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH 2/2] pwm: meson: support meson A1 SoC family
Date: Wed, 24 Apr 2024 11:02:10 +0200
In-reply-to: <4feb8fe3-af72-4483-87b2-30503328cfe2@salutedevices.com>
Message-ID: <1jmspjf7qs.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Wed 24 Apr 2024 at 02:00, George Stark <gnstark@salutedevices.com> wrote:

> Hello Jerome
>
> Thanks for the review
>
>
> On 4/23/24 20:35, Jerome Brunet wrote:
>> On Tue 23 Apr 2024 at 19:10, George Stark <gnstark@salutedevices.com>
>> wrote:
>> 
>>> From: George Stark <gnstark@sberdevices.ru>
>>>
>>> Add a compatible string and configuration for the meson A1 SoC family
>>> PWM. Additionally, provide an external clock initialization helper
>>> specifically designed for these PWM IPs.
>>>
>>> Signed-off-by: George Stark <gnstark@sberdevices.ru>
>>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>>> ---
>>>   drivers/pwm/pwm-meson.c | 35 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index ea96c5973488..529a541ba7b6 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -462,6 +462,33 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>>   }
>>>   +static int meson_pwm_init_channels_ext_clock(struct pwm_chip *chip)
>> That kind on naming (ext) is almost sure to clash with whatever comes
>> next.
>> Just use the name of the first SoC using the method, a1 for instance.
>
> It's true that pwm core in a1 s4, t7 etc is the same AFAWK.
> I just want to clarify your proposal:
> I add a1 compatible to the dt-bindings with s4 as fallback,
> t7 compatible will be added later in the same way.

If you know t7 is compatible as well, please add it to.

Other people (including from amlogic) have responded to thread around
the s4 pwm topic. You should probably Cc them of your future submission.

They may help test and review

>
> Here in the driver I don't mention a1 at all and use s4-centric naming e.g.:
>
> {
> 	.compatible = "amlogic,meson-s4-pwm",
> 	.data = &pwm_meson_s4_data
> },
> static const struct meson_pwm_data pwm_meson_s4_data = {
> 	.channels_init = meson_pwm_init_channels_s4,
> };
>
> right?
>
yes

>>> +{
>>> +	struct device *dev = pwmchip_parent(chip);
>>> +	struct meson_pwm *meson = to_meson_pwm(chip);
>>> +	struct meson_pwm_channel *channels = meson->channels;
>>> +	struct clk_bulk_data *clks = NULL;
>>> +	unsigned int i;
>>> +	int res;
>>> +
>>> +	res = devm_clk_bulk_get_all(dev, &clks);
>>> +	if (res < 0) {
>>> +		dev_err(dev, "can't get device clocks\n");
>>> +		return res;
>>> +	}
>> I don't think allocating the 'clk_bulk_data *clks' is necessary or safe.
>> We know exactly how many clocks we expect, there is no need for a get all.
>> 
>>> +
>>> +	if (res != MESON_NUM_PWMS) {
>>> +		dev_err(dev, "clock count must be %d, got %d\n",
>>> +			MESON_NUM_PWMS, res);
>>> +		return -EINVAL;
>>> +	}
>> ... and this only catches the problem after the fact.
>> It is probably convinient but not necessary.
>> 
>>> +
>>> +	for (i = 0; i < MESON_NUM_PWMS; i++)
>>> +		channels[i].clk = clks[i].clk;
>> channels[i].clk could be assigned directly of_clk_get() using clock
>> indexes. No extra allocation needed.
>
> if we use of_clk_get then we'll have to free the clock objects in the
> end. Could we use devm_clk_bulk_get instead?

Add the devm variant of of_clk_get() if you must.
Use devm_add_action_or_reset() otherwise

>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>>> @@ -500,11 +527,19 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>>>   	.channels_init = meson_pwm_init_channels_meson8b_v2,
>>>   };
>>>   +static const struct meson_pwm_data pwm_meson_ext_clock_data = {
>>> +	.channels_init = meson_pwm_init_channels_ext_clock,
>>> +};
>>> +
>>>   static const struct of_device_id meson_pwm_matches[] = {
>>>   	{
>>>   		.compatible = "amlogic,meson8-pwm-v2",
>>>   		.data = &pwm_meson8_v2_data
>>>   	},
>>> +	{
>>> +		.compatible = "amlogic,meson-a1-pwm",
>>> +		.data = &pwm_meson_ext_clock_data
>>> +	},
>>>   	/* The following compatibles are obsolete */
>>>   	{
>>>   		.compatible = "amlogic,meson8b-pwm",
>> 


-- 
Jerome

