Return-Path: <linux-kernel+bounces-100197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69090879368
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6DB1C22432
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810DA79DC9;
	Tue, 12 Mar 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="b9LbA1nX"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499E56471;
	Tue, 12 Mar 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244567; cv=none; b=bHydrDmT76TuhVlPV0jeMaNBOa8EMjk6hkUS1ykj84SnjHyzCKaODW/APgPJccIRZ6Prm8XRGW/PEFc4pDZMHarCDEskiXSynx9QCDLPiZpzV8400J49LS2xojaixs9Wrx0NtbQ2iwSx88XQtWuTi9r0gc7QAL/g7FzJoOJwRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244567; c=relaxed/simple;
	bh=PQ1onOCNmoZb1WuqiYG6mAiWg8oiBlv8sMZhEhOIYKY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LvNIwFhJgQtv0zL896aodkWt6/7fVAX8UlE3gY2VdkRmGlkpBc7aLmj5/7PFxDbBEpkI9q7nBvKk3trJWONcVhUrRVoOWnc+vA084d8WW0OaHONYe7PbZXqkKLTZPUaKKZi+O0kPYJ2NryZwWhE6AMMsg1J9P5jBZu9CWtj66fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=b9LbA1nX; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 4D5C9400F9;
	Tue, 12 Mar 2024 16:56:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710244560; bh=PQ1onOCNmoZb1WuqiYG6mAiWg8oiBlv8sMZhEhOIYKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b9LbA1nXQS7ZXbM3dG8CTpXPxZlSykZXR39MuuUxOMG45JbPXtqcATRkzKCI14UqB
	 IVDhXsqErW0SJ+8jLlHmuXcSUaRp36hw1Fa0SBv5YLRdfiF59pD68VngE4xQYTloyq
	 hFfluotxz7MEhTWeyTe1i3AQUrDapEYEXicOlr0X92X6I3Xw5oZkQjg36Ih8LzlZsA
	 1X1O4LS8hhNOaOaaKlY1RkzxrziPm37E1Z9x6jGSy4RZk8R9wkRq2ZKQGRmcuieCTl
	 MDx9jzLZdBxcSP1V6CGY953aotJh4RWoOefsRcDzMTAaA/bH/2adPSekss4QKhVSe5
	 IGfQ04BOzkSpA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Mar 2024 16:55:58 +0500
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
Subject: Re: [PATCH v4 2/4] platform: Add ARM64 platform directory
In-Reply-To: <5d4434fc-862e-4430-a2a0-758887d7596d@linaro.org>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
 <20240312-aspire1-ec-v4-2-bd8e3eea212f@trvn.ru>
 <5d4434fc-862e-4430-a2a0-758887d7596d@linaro.org>
Message-ID: <7ecbcea00a4b59d7afdb529dce12801b@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bryan O'Donoghue писал(а) 12.03.2024 16:36:
> On 12/03/2024 08:42, Nikita Travkin wrote:
>> Some ARM64 based laptops and computers require vendor/board specific
>> drivers for their embedded controllers. Even though usually the most
>> important functionality of those devices is implemented inside ACPI,
>> unfortunately Linux doesn't currently have great support for ACPI on
>> platforms like Qualcomm Snapdragon that are used in most ARM64 laptops
>> today. Instead Linux relies on Device Tree for Qualcomm based devices
>> and it's significantly easier to reimplement the EC functionality in
>> a dedicated driver than to make use of ACPI code.
>>
>> This commit introduces a new platform/arm64 subdirectory to give a
>> place to such drivers for EC-like devices.
>>
>> A new MAINTAINERS entry is added for this directory. Patches to files in
>> this directory will be taken up by the platform-drivers-x86 team (i.e.
>> Hans de Goede and Mark Gross).
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>   MAINTAINERS                     |  9 +++++++++
>>   drivers/platform/Kconfig        |  2 ++
>>   drivers/platform/Makefile       |  1 +
>>   drivers/platform/arm64/Kconfig  | 19 +++++++++++++++++++
>>   drivers/platform/arm64/Makefile |  6 ++++++
>>   5 files changed, 37 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b43102ca365d..ec8d706a99aa 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3050,6 +3050,15 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
>>   N:	zynq
>>   N:	xilinx
>>   +ARM64 PLATFORM DRIVERS
>> +M:	Hans de Goede <hdegoede@redhat.com>
>> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
>> +Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> 
> Surely some sort of Arm specific mailing list should be added here ? platform-drivers-x86 for arm64 platform drivers standalone, makes little sense.
> 

We agreed with Hans that pdx86 list/tree can work for EC drivers for
other platforms because many maintainers familiar with ECs through x86
are already there.

> Perhaps for each new SoC class added - you could add the appropriate mailing list linux-arm-msm is suspiciously missing from the list even though the only driver that will live in this directory after this series is a qcom based device.
> 
> And if tomorrow someone added a Rockchip based EC controller then you'd assume the rockchip mailing list should get a ping.

I believe that even though those drivers are "board specific" (Hans
asked to only include EC drivers here, and we have soc/ for other things
anyway) they are not at all "platform"/"soc" specific, so I'm not sure
adding arm lists here is a great idea:

I don't think these drivers would be too specific to the SoC given it's
just an i2c peripheral most of the time, and considering that it seems
there soon will be many WoA devices with socs from many vendors, we would
just have a collection of all the arm platform lists here...

So even if for now, while all existing WoA devices use Snapdragon chips,
we could get away with adding linux-arm-msm, it may end up just spamming
all the platform lists for no reason when the list grows...

I think it's better for the contributors to CC the relevant list for
their board themselves, which is easily done implicitly by adding dts
changes along the way, like in this series.

Of course if you and other people on linux-arm-msm are fine with that
possibility, we could add an extra list there and see if it gets out of
hand.

Nikita

> 
> ---
> bod

