Return-Path: <linux-kernel+bounces-129088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A5489649C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0011C215F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A218C08;
	Wed,  3 Apr 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miDeKGY2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205316426;
	Wed,  3 Apr 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126080; cv=none; b=YgpUHh8wOqH5ZhUrlv9wzBCwUAZoxhSz4zv1/E1NxU6PoqbCAH+EszicloceX95YiIH0lSB3d8evn775JswRlGxXn+psMXr7n6nmmYGb3N+uYW3O8bwg7MD1FMmGDu4gJGa7KSBDDu8nkynkpcIVeOtIIVfYNsND4hx8qdzRLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126080; c=relaxed/simple;
	bh=LsqiMQRj1wLiHq3ixUN2WdUJjb05d/kIG70zyVbhQmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/nBahoAC8BJMWX6xZOBmFVlPq+gUd+zNMgBBWW5/piPFETkjrj3JodJbYxOlB4G4fQfBtz2lBF0i9e7OvSTAibIb6VA9dVtcaQNjP5yUL7o9b3D4qkMqVYgvJ14EFfrOvhuHDINxUnBkcx2EHGX+p/bJXyX4ox4uT9P0e5SMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miDeKGY2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e25afabaso6631256e87.2;
        Tue, 02 Apr 2024 23:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712126077; x=1712730877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYW+AlVSbomobMt65A43JiBTiKdCWd+FhRAeUO4UCk0=;
        b=miDeKGY26beikKOSEWmnvyaXWXLcPY0VuMginmTs8v5ftz4qgjkGN5ABmA5mREsqB9
         JVpAwCKfMYUWoEQ9oQ57IQWx99D/Hu9p+byjOqib7dKE/6XyfXo/udsh/jpS4DT9o2vb
         nQ45qHxeG+gp7/K+y0Re3EA6Y2Wu8IC1+GFpGA8KHvX/79yWaLcWwAyAOtACxKzuGJeT
         1CZVAZTeCQHudjgdIEdwc79PN7Zbg3WdCbWeF0fPzlSzJkb0K+Y8ioCAl3FMdKYszih9
         RtAzQdtOKOjSZxcAeOxq9+Ygp3WGlQwf5L/doKq1bq60IUhltVkpObfZcomL1DXxn1it
         TEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712126077; x=1712730877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYW+AlVSbomobMt65A43JiBTiKdCWd+FhRAeUO4UCk0=;
        b=drH5+ayMmPtO3mcMHcYcX60ueYm2ap5i7904HelEUMVPiQ18A4iIYjbj3gge898agp
         c82RS9bAL2q9CFvWqRvOxevD2Qw4eapsnWkuRJSetf6lM6WI8kiguPjhwMU0wjCsW5mt
         u6gz2FFyOGaMTXqoE1KX157yGpXuVb0jtUyReJuKO5o/Z/3nh8RHVMydY9nvs9899tIV
         IELisEYi/e80dqSs+J6+riu5n5gQpu9slbltB7m889Lx66YvaSd3YJpp0GB/7JQSF+ZN
         zI7R/8Tp73gcB1gjrYHrc1eiu3O0tQRPP8HSNSLhKtTklWvl3zR6A6di2V1W6zIz/Zhe
         CEEA==
X-Forwarded-Encrypted: i=1; AJvYcCW6B9CazS0LQwIvtpChkdNFxiqTRS6nTg5zK9tSZd4h369/Xs3LdeNh3SSQmB9iFp3AGA3LqRizjMZ5iMgHILvugi+7AYzphcTO+xCCh+iWTB5UQ3BbNLD7Q+QqaSuo8+Ucut31NUsfbh60ASzSOdqTger9YoPrUYTJ3EdMEjnkCvuAnPZi0rIa
X-Gm-Message-State: AOJu0YwsvN2YcwAjwaLbX341KvjKRG5DEJK8KKlXpssuZ7EBweZRy3Sv
	BIWTsOLK0jMSTDNAEdRj/TpKKOb3LDFGSNZohEmVgCBd2RkqtZNk
X-Google-Smtp-Source: AGHT+IGWzVyYdrudwcj1Pmu++3KZb9mW8E8mBL+bBIcA60MJSmD0OL1V9LOTjIn04uB7VvLV7F+HRA==
X-Received: by 2002:ac2:562c:0:b0:512:a4ce:abaa with SMTP id b12-20020ac2562c000000b00512a4ceabaamr9103494lff.48.1712126076579;
        Tue, 02 Apr 2024 23:34:36 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k17-20020a05651210d100b00515c8ff6f52sm1915386lfg.229.2024.04.02.23.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 23:34:36 -0700 (PDT)
Message-ID: <279336b3-f28d-48ee-a10f-47abba7b0b89@gmail.com>
Date: Wed, 3 Apr 2024 09:34:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Content-Language: en-US, en-GB
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>
 <4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Guenter,

First of all, thanks for the review. It was quick! Especially when we 
speak of a RFC series. Very much appreciated.

On 4/2/24 20:11, Guenter Roeck wrote:
> On Tue, Apr 02, 2024 at 04:11:41PM +0300, Matti Vaittinen wrote >> +static int init_wdg_hw(struct wdtbd96801 *w)
>> +{
>> +	u32 hw_margin[2];
>> +	int count, ret;
>> +	u32 hw_margin_max = BD96801_WDT_DEFAULT_MARGIN, hw_margin_min = 0;
>> +
>> +	count = device_property_count_u32(w->dev->parent, "rohm,hw-timeout-ms");
>> +	if (count < 0 && count != -EINVAL)
>> +		return count;
>> +
>> +	if (count > 0) {
>> +		if (count > ARRAY_SIZE(hw_margin))
>> +			return -EINVAL;
>> +
>> +		ret = device_property_read_u32_array(w->dev->parent,
>> +						     "rohm,hw-timeout-ms",
>> +						     &hw_margin[0], count);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (count == 1)
>> +			hw_margin_max = hw_margin[0];
>> +
>> +		if (count == 2) {
>> +			hw_margin_max = hw_margin[1];
>> +			hw_margin_min = hw_margin[0];
>> +		}
>> +	}
>> +
>> +	ret = bd96801_set_wdt_mode(w, hw_margin_max, hw_margin_min);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
>> +					   "prstb");
>> +	if (ret >= 0) {
>> +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
>> +				 BD96801_WD_ASSERT_MASK,
>> +				 BD96801_WD_ASSERT_RST);
>> +		return ret;
>> +	}
>> +
>> +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
>> +					   "intb-only");
>> +	if (ret >= 0) {
>> +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
>> +				 BD96801_WD_ASSERT_MASK,
>> +				 BD96801_WD_ASSERT_IRQ);
>> +		return ret;
>> +	}
> 
> I don't see the devicetree bindings documented in the series.

Seems like I have missed this WDG binding. But after reading your 
comment below, I am wondering if I should just drop the binding and 
default to "prstb" (shutdown should the feeding be skipped) - and leave 
the "intb-only" case for one who actually needs such.

> I am also a bit surprised that the interrupt isn't handled in the driver.
> Please explain.

Basically, I just had no idea what the IRQ should do in the generic 
case. If we get an interrupt, it means the WDG feeding has failed. My 
thinking is that, what should happen is forced reset. I don't see how 
that can be done in reliably manner from an IRQ handler.

When the "prstb WDG action" is set (please, see the above DT binding 
handling), the PMIC shall shut down power outputs. This should get the 
watchdog's job done.

With the "intb-only"-option, PMIC will not turn off the power. I'd 
expect there to be some external HW connection which handles the reset 
by HW.

After all this being said, I wonder if I should just unconditionally 
configure the PMIC to always turn off the power (prstb option) should 
the feeding fail? Or do someone have some suggestion what the IRQ 
handler should do (except maybe print an error msg)?

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int bd96801_wdt_probe(struct platform_device *pdev)
>> +{
>> +	struct wdtbd96801 *w;
>> +	int ret;
>> +	unsigned int val;
>> +
>> +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
>> +	if (!w)
>> +		return -ENOMEM;
>> +
>> +	w->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> 
> dev_get_regmap() can return NULL.
> 
>> +	w->dev = &pdev->dev;
>> +
>> +	w->wdt.info = &bd96801_wdt_info;
>> +	w->wdt.ops =  &bd96801_wdt_ops;
>> +	w->wdt.parent = pdev->dev.parent;
>> +	w->wdt.timeout = DEFAULT_TIMEOUT;
>> +	watchdog_set_drvdata(&w->wdt, w);
>> +
>> +	w->always_running = device_property_read_bool(pdev->dev.parent,
>> +						      "always-running");
>> +
> Without documentation, it looks like the always-running (from
> linux,wdt-gpio.yaml) may be abused. Its defined meaning is
> "the watchdog is always running and can not be stopped". Its
> use here seems to be "start watchdog when loading the module and
> prevent it from being stopped".

Yes. You're right.

> Oh well, looks like the abuse was introduced with bd9576_wdt. That
> doesn't make it better. At the very least it needs to be documented
> that the property does not have the intended (documented) meaning.

I can raise my hand for a sign of an error here. I've been misreading 
the intended meaning of the always-running. Not sure if I've picked it 
from another driver (maybe GPIO watchdog), or if I've just 
misinterpreted the binding docs.

Do you suggest me to add a note in the BD9576 binding doc (there is no 
BD9576 specific binding doc for watchdog. I wonder whether this warrants 
adding one under watchdog or if the note can be added under 
Documentation/devicetree/bindings/mfd/rohm,bd9576...).

>> +	ret = regmap_read(w->regmap, BD96801_REG_WD_CONF, &val);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				     "Failed to get the watchdog state\n");
>> +
>> +	/*
>> +	 * If the WDG is already enabled we assume it is configured by boot.
>> +	 * In this case we just update the hw-timeout based on values set to
>> +	 * the timeout / mode registers and leave the hardware configs
>> +	 * untouched.
>> +	 */
>> +	if ((val & BD96801_WD_EN_MASK) != BD96801_WD_DISABLE) {
>> +		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
>> +		ret = bd96801_set_heartbeat_from_hw(w, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
>> +	} else {
>> +		/* If WDG is not running so we will initializate it */
>> +		ret = init_wdg_hw(w);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
>> +	watchdog_set_nowayout(&w->wdt, nowayout);
>> +	watchdog_stop_on_reboot(&w->wdt);
>> +
>> +	if (w->always_running)
>> +		bd96801_wdt_start(&w->wdt);
> 
> I think this needs to set WDOG_HW_RUNNING or the watchdog will trigger
> a reboot if the watchdog device is not opened and the watchdog wasn't
> already running when the module was loaded.

I believe you're right. Seems I haven't properly tested this path.

> That makes me wonder what happens if the property is set and the
> watchdog daemon isn't started in the bd9576_wdt driver.

My assumption is the dog starts barking. I'll see if I find the BD9576 
break-out board from one of my boxes to wire it up and test this. If the 
always-running is not working it might be justified to just drop it from 
both drivers. I believe it'd be indication that no-one is really using 
the always-running with the upstream driver.

Thanks a ton!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


