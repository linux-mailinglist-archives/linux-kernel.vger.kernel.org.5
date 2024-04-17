Return-Path: <linux-kernel+bounces-148063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F758A7D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A1128336E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98DA6EB62;
	Wed, 17 Apr 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOk3u++w"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68C54F96;
	Wed, 17 Apr 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339348; cv=none; b=JHByDD1+6wMF7PLs2aREU+vaB2DwNZKZJJYQhU6iY7oHK5u1Hr2PLBx/LuJ8pK9aM53U4ruZumoWkwVISbKoACxTbJ5k3+B01tgikhevaRxCxEFt2QWd6qO4bmOtrQgOjn5JQHENf4xbrTSdDd9aEFcym7OqTD2X6hlmhJn2VnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339348; c=relaxed/simple;
	bh=loCEYmCNq0bWoL3QRJvjkDo2M/+Dk1ZSmKRR+9qBE2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kM0C55IRVR/VFdnUl/PDDlgS/N1a4A6DnfCJgQtMpssvwe0uvn962Jo5SY9XU0IOPs1RRV3Tgs0CshdbOd2SO6qzxBqI/A4WpAhhKbSRv9IYn9cirVdWB6c1Nfp0StPQLnRe7idItruXx+qHR9yoEKGr078tLD69igODdcG3Evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOk3u++w; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d3776334so6697618e87.1;
        Wed, 17 Apr 2024 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713339345; x=1713944145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6EVRLrBsLhKslUhuzemyZUHO7VOX5hRp+ari7MTAR4=;
        b=IOk3u++we5xhBEmX+m466ascDNABrIllU6jBNz9D1nVTWehXDKycE7l38wgleK3zRR
         JPOfi3iS9V0JY+5yfSsyUDGSkg3tDhHN2eiwCaO5l/rxfBch7nqm1zWf0mr8l5V8KY3F
         q7MNzHsfPhq1GsIFHSYht0sNN9Y5ucXGaDfTu/IgNKtNiVbKjy8IZmtDbSB+F5gQM9K5
         EjrWeJY51LIg9QCL0n8+DZI/JK6cyYYm5tLBYJKHgMrJd3Af0wN5Eq6Hj/pKjBbKv6Ms
         KNlL+o77DdE57/78LpaPzdrdShVdZfv3gHyjVsokR08DS9eIfM02ybRbr9x91UinzDQq
         3UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339345; x=1713944145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6EVRLrBsLhKslUhuzemyZUHO7VOX5hRp+ari7MTAR4=;
        b=R98vUYOJhMeycg1zevWzgP39eIeq41y0orUZODpkPxXMNlUvK4r+NslTpgNdmi/jV9
         3y3CjWzVTElYaM0yTxA2PfZZroy24Jn84JgLW7cbJNY1k3O5F9x8wp8uJCkPT1ICyMTG
         kaVtENqNaINuAPZ3r0HM3VvyI8eBhJNhYhiu1h1xeTWWuVbliu5MtR/wR25pPcFG03Fx
         Fc5ghMqpJF7bH0Qb5omtwZKz4dP0yeYeJuPVZj/mKwEXMOZuScvWGTWCbCZ3VYuz2ZWH
         Rd5H125ZN7WbOn8iHWmUV9uRpLry/3+et1OdBb+3SVJih+Ra0qVYWnixtrhiqMFJUpVz
         6k3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMUHLdUV6tanCMZcTcQuaSEWcaVKMa/UNcxUYeZWfqN4VxB1hqLo9LItheOLRYuNBiTAJZTQQjIny6wLUDnrR/tVBKooKIMIeSeed0/jKuy8rl5kDWPGqn2imD4WtVUJYG5YFEi7ODH4E89fBqC6mcQ0ZhO0P00Jwn3/hwEMV46H5dWCn4B2BQ
X-Gm-Message-State: AOJu0Yw27gzxaXRloowLh2Dwfe8+0AFTVL6NwR5XFJrkMNEV/g3d8t2j
	UXdacuCU/ZgkmYLze1nyqHe6MTOfniAxCdJkGI97NtCZ5mLKVNxr
X-Google-Smtp-Source: AGHT+IEA1hY6wIdC7jGk1wjFx3vL0HTS8jscv+ahPQi5VCoVUSyHqQ3JTEIslI3xC7B5GXshPR4sug==
X-Received: by 2002:a05:6512:e9d:b0:519:730:b399 with SMTP id bi29-20020a0565120e9d00b005190730b399mr6189120lfb.9.1713339344439;
        Wed, 17 Apr 2024 00:35:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id s6-20020a197706000000b00518ac6f0b37sm1267379lfc.244.2024.04.17.00.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 00:35:44 -0700 (PDT)
Message-ID: <a605e79e-7b3d-477b-b6af-56ffb0cca6d3@gmail.com>
Date: Wed, 17 Apr 2024 10:35:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Content-Language: en-US, en-GB
To: George Cherian <george.cherian@marvell.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <d52fd63e98635293022e5a607fd763b580e24189.1712920132.git.mazziesaccount@gmail.com>
 <20240417042949.GA3513394@IPBU-BLR-SERVER1>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240417042949.GA3513394@IPBU-BLR-SERVER1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi George,

Thanks for the input! Reviewing is very much appreciated :)

On 4/17/24 07:29, George Cherian wrote:
> On 2024-04-12 at 16:52:46, Matti Vaittinen (mazziesaccount@gmail.com) wrote:
>> Introduce driver for WDG block on ROHM BD96801 scalable PMIC.
>>
>> This driver only supports watchdog with I2C feeding and delayed
>> response detection. Whether the watchdog toggles PRSTB pin or
>> just causes an interrupt can be configured via device-tree.
>>
>> The BD96801 PMIC HW supports also window watchdog (too early
>> feeding detection) and Q&A mode. These are not supported by
>> this driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>> RFCv1 => RFCv2:
>> - remove always running
>> - add IRQ handling
>> - call emergency_restart()
>> - drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
>> ---
>>   drivers/watchdog/Kconfig       |  13 ++
>>   drivers/watchdog/Makefile      |   1 +
>>   drivers/watchdog/bd96801_wdt.c | 389 +++++++++++++++++++++++++++++++++
>>   3 files changed, 403 insertions(+)
>>   create mode 100644 drivers/watchdog/bd96801_wdt.c
>>4
>> +
>> +static const struct watchdog_ops bd96801_wdt_ops = {
>> +	.start		= bd96801_wdt_start,
>> +	.stop		= bd96801_wdt_stop,
>> +	.ping		= bd96801_wdt_ping,
>> +};
> Is there no way to setup a timeout to the WDOG device from userspace?
> 

For the BD96801 hardware? Currently no. (See below)

>> +
>> +static int init_wdg_hw(struct wdtbd96801 *w)
>> +{
>> +	u32 hw_margin[2];
>> +	int count, ret;
>> +	u32 hw_margin_max = BD96801_WDT_DEFAULT_MARGIN, hw_margin_min = 0;
>> +
>> +	count = device_property_count_u32(w->dev->parent, "rohm,hw-timeout-ms");
> Why is that timeout need to be configured from a devicce-tree property?
> set_timeout/get_timeout can't be done for this device?

The BD96801 supports 32 different "slow detection" timeouts - only 1 of 
which is guaranteed to be greater than 1s (1.8432 Sec). The timeout 
setting interface uses seconds.

Furthermore, I think that the HW heartbeat is not all that meaningful to 
the user-space. What is meaningful to user-space is how often the 
userland daemon needs to write the watchdog file to keep system alive. 
This is different thing. With the sub-second HW timeouts it is better 
the kernel keeps feeding the watchdog based on a timer (adjusted to meet 
the HW requirements) and can thus require the userspace to ping less 
frequently than the HW heartbeat.

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
>> +
>> +	return 0;
>> +}
>> +
>> +extern void emergency_restart(void);
>> +static irqreturn_t bd96801_irq_hnd(int irq, void *data)
>> +{
>> +	emergency_restart();
> In case of a full system hang will this function get executed?

Maybe, maybe not. It is probably still the best we can do if the 
watchdog has not been configured to kill the power by HW. Or, do you 
have some other suggestion? (The emergency_restart() was actually 
suggested by Guenter during the v1 review).

>> +	return IRQ_NONE;
>> +}

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


