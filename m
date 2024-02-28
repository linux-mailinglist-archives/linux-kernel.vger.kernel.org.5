Return-Path: <linux-kernel+bounces-85298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CB786B3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541641C258BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9B152E14;
	Wed, 28 Feb 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="VhUxaeXu"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C915B990;
	Wed, 28 Feb 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135374; cv=none; b=UIJWFoa0bEJzRhaaLjlY4sQKykAutPQ6DEKUIvWBdjJD+n3y46lBsFgAVXweH+bLE4BdksY8beRq8lHjHZZz1Jc7IBQ6L0QpeRAycrF8dE6nr1X1/ZJ/yp9xpRT9BIwffbKPTGRb9I8klO+7oqD14esci7s6b8TUhUI/tR8vHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135374; c=relaxed/simple;
	bh=TXDkaVmG4OI79+ODTlB7W6xh7e9pcZZeRG8zXY6AXzw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ie+cRsjsouoBCaTcsL9NE4tWHjPWAqNTB/kz1dATcQqxXQt4IBUhNXsl4UdDVuM45MVdyixKpPSgdrFAsBc1uo3QZz7S9nhBiaFeIfxDR3Im5MEyOc7Uwiz3SlnQ76rUFA2bwvplPM52zJpvEPEYwgI/34tyf9JwB3wUimfFFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=VhUxaeXu; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 17F9C401B2;
	Wed, 28 Feb 2024 20:49:20 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1709135361; bh=TXDkaVmG4OI79+ODTlB7W6xh7e9pcZZeRG8zXY6AXzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VhUxaeXulzylqIHcBOnJNwY4jOYMTJXvIftsBCqCYyH6bJYpqGMkNdixEF8ywO1gd
	 YBXJs4cXAbTUzHbceGHR7lQaNudEBrUJT0i4ObkYrLbtcDxHWusSt3gzfB5Ao2m2w6
	 SS32hXdQrrBzOIrfcMZV9JvV+7FTIlQIf7RwMg7TAko/xdQzOtcPG0qKy7vJSYSIhB
	 a7eWrk3WbM+XGAZgA4diXytBhRufxWHFsLFioElwvPQlNH8FOYEXObh3vXfjFNQNJk
	 b4Qb3rzba0t924LGfS6qCqPm7tceRPbeCial2GrvwJEfqh27O5Qdxw9kzRgzOnUUh3
	 ipJ4nfXO16Y7w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Feb 2024 20:49:18 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, =?UTF-8?Q?Ilpo_J?=
 =?UTF-8?Q?=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
In-Reply-To: <edec3bee-8604-49a9-8e2f-6c21e852ef6c@redhat.com>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
 <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
 <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>
 <edec3bee-8604-49a9-8e2f-6c21e852ef6c@redhat.com>
Message-ID: <c6d3d9841fe5a754e78adaf95522b434@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hans de Goede писал(а) 26.02.2024 15:59:
> Hi,
> 
> +Ilpo (fellow pdx86 maintainer)
> 
> On 2/23/24 15:32, Nikita Travkin wrote:
>> Sebastian Reichel писал(а) 22.02.2024 04:41:
>>> Hi,
>>>
>>> On Tue, Feb 20, 2024 at 04:57:13PM +0500, Nikita Travkin wrote:
>>>> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
>>>> controller to control the charging and battery management, as well as to
>>>> perform a set of misc functions.
>>>>
>>>> Unfortunately, while all this functionality is implemented in ACPI, it's
>>>> currently not possible to use ACPI to boot Linux on such Qualcomm
>>>> devices. To allow Linux to still support the features provided by EC,
>>>> this driver reimplments the relevant ACPI parts. This allows us to boot
>>>> the laptop with Device Tree and retain all the features.
>>>>
>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>> ---
>>>>  drivers/power/supply/Kconfig           |  14 +
>>>>  drivers/power/supply/Makefile          |   1 +
>>>>  drivers/power/supply/acer-aspire1-ec.c | 453 +++++++++++++++++++++++++++++++++
>>>
>>> I think this belongs into drivers/platform, as it handles all bits of
>>> the EC.
>>>
>>
>> Hm, I initially submitted it to power/supply following the c630 driver,
>> but I think you're right... Though I'm not sure where in platform/ I'd
>> put this driver... (+CC Hans)
>>
>> Seems like most of the things live in platform/x86 but there is no i.e.
>> platform/arm64...
>>
>> Hans, (as a maintainer for most things in platform/) what do you think
>> would be the best place to put this (and at least two more I'd expect)
>> driver in inside platform/? And can we handle it through the
>> platform-driver-x86 list?
> 
> I guess that adding a drivers/platform/aarch64 map for this makes
> sense, with some comments in the Makefile and in the Kconfig
> help explaining that this is for PC/laptop style EC drivers,
> which combine multiple logical functions in one, only!
> 
> Assuming that we are only going to use this for such EC drivers,
> using the platform-driver-x86 mailinglist for this makes sense
> since that is where are the people are with knowledge of e.g.
> userspace APIs for various typical EC functionalities.
> 
> It might even make sense to also use:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> 
> As git tree for this and send pull-reqs to Linus for this
> together with the other pdx86 for the same reasons.
> 
> I would be open to that as long as this is strictly limited to
> EC (like) drivers.

Yes, I believe the EC are the only "boad-specific" drivers we need for
the Windows-on-Arm devices as of today. I expect at least two more EC
drivers to be added later.

Then I will re-target this series to platform-driver-x86:

- Will add a new drivers/platform/aarch64/ dir with a Makefile and Kconfig
  that would explicitly note it's only for EC-like drivers. Will update
  the "X86 PLATFORM DRIVERS" entry in MAINTAINERS. (Or should I add a new
  entry?)
- Will add this driver there, also updating per the last Sebastian's
  comments.
- Will also move the dt binding to a new bindings/platform/ dir.

Thanks!
Nikita

> 
> Ilpo, what do you think about this ?
> 
> Regards,
> 
> Hans
> 

