Return-Path: <linux-kernel+bounces-78484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3B861400
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188FF2857E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85818883C;
	Fri, 23 Feb 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="q1JvnxXT"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425979CC;
	Fri, 23 Feb 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698745; cv=none; b=BL8Q1xZ7xL7ZLPxqxfOsPxjYnfSajlWBzzkMakRgF2fwCHVw48bHaFab0hM+FVnY+mZvCZetEYFyansbW2UNl62CH4ECO57ctBED4Xfo+S6UupaxgVy71BXLbh7nANQlojJgB5NDA9mTokmSYJIoDqrWXOUxEGivwJjwuwYSWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698745; c=relaxed/simple;
	bh=jiMJsyiTNHv8UOOvPguE/ydpC4lYJNHBv7Q8fPcd5vw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=grlL2NpDAx7gUApnQp4Z8lyVpIqKuRPBd0yy0a7/sXRaBnMgousxv/YUvDsyC0uWrEM+u+Y+lCi+oPJRBnLPEhIT0y8klK8VTMlJlyD5jpsGxEXGZOK+9f2cAtW/R4nNqeoYnCN0CRoB/EK6uDK/7koUQ2TfdlQ3lfu4uk5GN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=q1JvnxXT; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 81FE0408D8;
	Fri, 23 Feb 2024 19:32:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1708698739; bh=jiMJsyiTNHv8UOOvPguE/ydpC4lYJNHBv7Q8fPcd5vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1JvnxXTtJ3QhyO00A/qk6Ygn5aeMNvly1UmdUKktB4H7OxrI9esp/pwqHM0iUxVa
	 /jkGL1o67J8wqqZuSQCZIGBEyH8ZgXGJgG0QjEEl8vb/IXysGhsi8sPP4ndwY3sYgO
	 g8Fwjt4BsNE6RmUxRE4pMeGWG0DWhLbJr2OWd24I1EXIPVG6oEUb8OLb+/JB3BTwJs
	 SiqSgVQ8yoU/3nTJKUiEUievYmOo/14iXdbTa+riOvjxI9iS2BVhDinNK21Ba0ehnR
	 V+oO8zZNuCra5R+b9DxSwauCA8GNRqaj2ArPhMDiyVX1d0J/sOOAiDm2QmkKzoiV0D
	 R8Ia+QYER9I5Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Feb 2024 19:32:17 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Hans de Goede
 <hdegoede@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
In-Reply-To: <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
 <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
Message-ID: <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sebastian Reichel писал(а) 22.02.2024 04:41:
> Hi,
> 
> On Tue, Feb 20, 2024 at 04:57:13PM +0500, Nikita Travkin wrote:
>> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
>> controller to control the charging and battery management, as well as to
>> perform a set of misc functions.
>>
>> Unfortunately, while all this functionality is implemented in ACPI, it's
>> currently not possible to use ACPI to boot Linux on such Qualcomm
>> devices. To allow Linux to still support the features provided by EC,
>> this driver reimplments the relevant ACPI parts. This allows us to boot
>> the laptop with Device Tree and retain all the features.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  drivers/power/supply/Kconfig           |  14 +
>>  drivers/power/supply/Makefile          |   1 +
>>  drivers/power/supply/acer-aspire1-ec.c | 453 +++++++++++++++++++++++++++++++++
> 
> I think this belongs into drivers/platform, as it handles all bits of
> the EC.
> 

Hm, I initially submitted it to power/supply following the c630 driver,
but I think you're right... Though I'm not sure where in platform/ I'd
put this driver... (+CC Hans)

Seems like most of the things live in platform/x86 but there is no i.e.
platform/arm64...

Hans, (as a maintainer for most things in platform/) what do you think
would be the best place to put this (and at least two more I'd expect)
driver in inside platform/? And can we handle it through the
platform-driver-x86 list?

> [...]
> 
>>  3 files changed, 468 insertions(+)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 3e31375491d5..e91a3acecb41 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -985,4 +985,18 @@ config FUEL_GAUGE_MM8013
>>  	  the state of charge, temperature, cycle count, actual and design
>>  	  capacity, etc.
>>
>> +config EC_ACER_ASPIRE1
>> +	tristate "Acer Aspire 1 Emedded Controller driver"
>> +	depends on I2C
>> +	depends on DRM
>> +	help
>> +	  Say Y here to enable the EC driver for the (Snapdragon-based)
>> +	  Acer Aspire 1 laptop. The EC handles battery and charging
>> +	  monitoring as well as some misc functions like the lid sensor
>> +	  and USB Type-C DP HPD events.
>> +
>> +	  This driver provides battery and AC status support for the mentioned
> 
> I did not see any AC status bits?
> 

I was referring to whatever ACPI spec calls "AC Adapter" but I guess
I should have used the word "charger" instead... Will reword this.

>> [...]
> 
>> +	case POWER_SUPPLY_PROP_PRESENT:
>> +		val->intval = 1;
> 
> You have an unused ASPIRE_EC_FG_FLAG_PRESENT, that looks like it
> should be used here?
> 

Oh, you're right! I think I initially didn't have this property and
added it like this as a reaction to that upower change that made it
consider everything not explicitly present as absent.

I've just checked what is reported after unplugging the battery and
seems like the flag (as well as everything else) is gone. Will change
the driver to read the flag.

Thanks for your review!
Nikita

>> [...]
> 
> Otherwise the power-supply bits LGTM.
> 
> -- Sebastian

