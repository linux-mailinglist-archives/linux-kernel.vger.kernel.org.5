Return-Path: <linux-kernel+bounces-100323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFFC8795B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C03A28325C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768F7AE73;
	Tue, 12 Mar 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="QWjwyvsS"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DC78298;
	Tue, 12 Mar 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252591; cv=none; b=npI5Jv31xthhe0ZwzTZsGKPU3DvpSF4uApRSgCSlPh/fly8Fe/h6XB7zxwqWHP7ehw4MjboUMovC1KlHMNJZNHkWwKwWt2826iqiPV/mhJG7cvVgC/twCkv6wWdqwXYHxC0/lZmMl7bvkgkibBsXfOyyeAsAItfls0SkYbf7iIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252591; c=relaxed/simple;
	bh=8P9bBzn3Aiha2NlQ/uegJyJ6edLvB2HNcbKt6Yo0QCA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rUBmPx4eDz17w4RoUQyClVrAEclT213+SE4frAAYbQmKLljc2T6jvizpJN4heIpEdoVWjz55LpPh9LjdA1Hdk4TZ19DBsVN8yID0jJctlOKX5Aau844AyjlS8GRaa7GvQJcqnbyc+tFnDr5xnaWkuKSA+UxL9wkkgEBCv1pQlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=QWjwyvsS; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id ADAF9408C7;
	Tue, 12 Mar 2024 19:09:42 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710252585; bh=8P9bBzn3Aiha2NlQ/uegJyJ6edLvB2HNcbKt6Yo0QCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QWjwyvsS3OHgWeuVCVlmpOLn+PYcSzXv7QExbowRLcra89t3IzEpT3AyZzyNEW8ll
	 76zOUsAGI5zoV1lMR1e8YKN0hl+4qjyoLPCWMAg90TEeR0I8o6Qw5JfviGREejVU6Z
	 z6Kr+lDapyusG6nTdDEHK8CehBIiA+jbpJU+tD0p7ZoWltti0F9mkOZHud6kkwEXVt
	 sUpFqq3qAKzdsX1pBU44Uns57Fa+Sp1KZNJAIvThV33Oib2I26gjTGJdIjXAQE3tuu
	 lunauIGW3GHVZxhdKkGhVS/KrJLcxHLHQ93ViAts1twx6KVxsKq+hN2bsliZjcl5MH
	 M1HJFyG9xPVgA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Mar 2024 19:09:39 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 3/4] platform: arm64: Add Acer Aspire 1 embedded
 controller driver
In-Reply-To: <104ae92c-e9ef-494e-b33e-351210c93846@linaro.org>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
 <20240312-aspire1-ec-v4-3-bd8e3eea212f@trvn.ru>
 <f62bbc98-12c1-48e1-8ebc-17dd5887026a@linaro.org>
 <84b4d83f3340402e98fe0e70afd085be@trvn.ru>
 <104ae92c-e9ef-494e-b33e-351210c93846@linaro.org>
Message-ID: <a25602fa7e11322800d9430d353172b8@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bryan O'Donoghue писал(а) 12.03.2024 17:44:
> On 12/03/2024 12:23, Nikita Travkin wrote:
>> Bryan O'Donoghue писал(а) 12.03.2024 16:58:
>>> On 12/03/2024 08:42, Nikita Travkin wrote:
>>>> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
>>>> controller to perform a set of various functions, such as:
>>>>
>>>> - Battery and charger monitoring;
>>>> - Keyboard layout control (i.e. fn_lock settings);
>>>> - USB Type-C DP alt mode HPD notifications;
>>>> - Laptop lid status.
>>>>
>>>> Unfortunately, while all this functionality is implemented in ACPI, it's
>>>> currently not possible to use ACPI to boot Linux on such Qualcomm
>>>> devices. To allow Linux to still support the features provided by EC,
>>>> this driver reimplments the relevant ACPI parts. This allows us to boot
>>>> the laptop with Device Tree and retain all the features.
>>>>
>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>> ---
>>>>    drivers/platform/arm64/Kconfig           |  16 +
>>>>    drivers/platform/arm64/Makefile          |   2 +
>>>>    drivers/platform/arm64/acer-aspire1-ec.c | 555 +++++++++++++++++++++++++++++++
>>>
>>> You should be listing yourself as a maintainer for a driver you contribute.
>>
>> I always believed that being in the AUTHOR() at the bottom of the driver
>> would guarantee me being in CC for patches, which so far worked great,
>> thus I was always hesitent adding extra entries in MAINTAINERS.
> 
> There's no such rule that I'm aware of there.
> 
> scripts/get_maintainer.pl won't list a driver author for the CC list
> 
> This is a substantial body of code, you should own it upstream.
> 

Hm, ack, will add an entry in MAINTAINERS for this.

>>>> +	case ASPIRE_EC_EVENT_FG_INF_CHG:
>>>> +		/* Notify (\_SB.I2C3.BAT1, 0x81) // Information Change */
>>>
>>> fallthrough;
>>>
>>
>> Hm I believe this would not warn since it's just two values for the same
>> code, just with an extra comment inbetween?
> 
> True
>

(Adding anyway given Ilpo also thinks it's better than not)

>>>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>>>> +		val->intval = le16_to_cpu(ddat.voltage_now) * 1000;
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>>>> +		val->intval = le16_to_cpu(sdat.voltage_design) * 1000;
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
>>>> +		val->intval = le16_to_cpu(ddat.capacity_now) * 1000;
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
>>>> +		val->intval = le16_to_cpu(sdat.capacity_full) * 1000;
>>>> +		break;
>>>
>>> You could stick this "* 1000" stuff in a macro
>>>
>>
>> acpi/battery.c also explicitly sets the multiplier so I think it's the
>> "common" way to do this.
> 
> common != nice
> 
> Purely aesthetics but anyway consider decomposing the replication down.
>

(Adding a macro for this)

>>>> +
>>>> +	case POWER_SUPPLY_PROP_CAPACITY:
>>>> +		val->intval = le16_to_cpu(ddat.capacity_now) * 100;
>>>> +		val->intval /= le16_to_cpu(sdat.capacity_full);
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>>> +		val->intval = (s16)le16_to_cpu(ddat.current_now) * 1000;
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_PRESENT:
>>>> +		val->intval = !!(ddat.flags & ASPIRE_EC_FG_FLAG_PRESENT);
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_SCOPE:
>>>> +		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_MODEL_NAME:
>>>> +		if (sdat.model_id - 1 < ARRAY_SIZE(aspire_ec_bat_psy_battery_model))
>>>> +			val->strval = aspire_ec_bat_psy_battery_model[sdat.model_id - 1];
>>>> +		else
>>>> +			val->strval = "Unknown";
>>>> +		break;
>>>> +
>>>> +	case POWER_SUPPLY_PROP_MANUFACTURER:
>>>> +		if (sdat.vendor_id - 3 < ARRAY_SIZE(aspire_ec_bat_psy_battery_vendor))
>>>> +			val->strval = aspire_ec_bat_psy_battery_vendor[sdat.vendor_id - 3];
>>>
>>> How does this -3 offset not underflow ?
>>>
>>
>> vendor_id here is unsigned so the if check would actually overflow,
>> though explaining that I guess it's better to be explicit there and let
>> the compiler optimize that check away anyway... I will update the if
>> condition with an extra (id >= 3).
> 
> What's the "3" about though, that's what's not jumping out at me here.
> 

Ah, well... the 3 comes from a big if/elseif table in the decompiled dsdt
which starts at 3... I will add a small comment near it.

>>
>>> Seems a bit dodgy to me - can you add a comment to the code to explain ? Its not immediately obvious the -3 is OK.
>>>
>>> Also could you take an index instead of replicating the -value stepdown each time ?
>>>
>>> int myindex = sdat.model_id - 1;
>>>
>>> if (myindex < someconstraint)
>>> 	strval = somearry[myindex];
>>>
>>
>> I decided against adding a dedicated index variable since there is only
>> one actual use for each, so it's easy to see where it goes.
> 
> But you do it twice which is why I'm suggesting take an index and do it once.
> 
> Then add
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Ack, given there is also >0, will add str_index variable for the offset
index.

Thanks!
Nikita

