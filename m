Return-Path: <linux-kernel+bounces-29174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B6830A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDE01F24BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DC22301;
	Wed, 17 Jan 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PcSv0otR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8321A0A;
	Wed, 17 Jan 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506813; cv=none; b=A9/0tpIF1apruAm0b8ZTb2HW413hXBkJE6zwRy1QeicqZF89u4ShDFzVc4WpI6eII7nKZYTzeYRGgZUlbsEtHpsXzQhlZYjQnHAzvYxTmJbjdhhG1lUoZjjbdK1GVDGmnL0H61OZ4ZW0oHc1tOcs+6E9jWMdOGCXlpLB5K+SHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506813; c=relaxed/simple;
	bh=RN/TRAV+0bm5AnELjwjgmIYkKjf1u9x2nlP5hpU2ebs=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=EVhH3G5SEckwbCHojO0hWFvEcw70CjI/MmwPZm1O9v9AMvYfrazyYxfEYmAXvHQO5zBNNfNxM2sVNsAT9mGQmxYYfWuws1xSx6TGVMFQedWEHuQ2exEkWQiJpqCHVjPrRcvX51pEWC2c0zG/7zibxg82CrGfCokYeUh1zDFNhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PcSv0otR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HFqhek107121;
	Wed, 17 Jan 2024 09:52:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705506764;
	bh=UqoXHpuOsyXayN31wfG4/f1gx1ZHV/XtpeqO3uEEUxI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PcSv0otRf22cpnWL4ex8dgpTo4kYPE2YfM2FC7uA12j/9tyFYkEgZ2AhY9W2/eqIL
	 UCcCKSNc2rAQMq34hF8aMVsEK2gtD8n3zgq1B2X+uumQ7rbozLTXHpMAbIth4PU623
	 ZP/avpnMlwdRxFKiL0uRf9F+iQpxHCSIF8/AviO8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HFqh7o004410
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 09:52:43 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 09:52:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 09:52:43 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HFqgSs087030;
	Wed, 17 Jan 2024 09:52:42 -0600
Message-ID: <55efd488-c6a0-4dca-baea-1fa93d13dd17@ti.com>
Date: Wed, 17 Jan 2024 09:52:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] ARM: dts: DRA7xx: Add device tree entry for SGX GPU
To: Tony Lindgren <tony@atomide.com>
CC: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Adam
 Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?=
	<bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Paul Cercueil
	<paul@crapouillou.net>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <linux-mips@vger.kernel.org>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-9-afd@ti.com> <20240110082924.GA5185@atomide.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240110082924.GA5185@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/10/24 2:29 AM, Tony Lindgren wrote:
> * Andrew Davis <afd@ti.com> [240109 17:20]:
>> --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
>> +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
>> @@ -850,12 +850,19 @@ target-module@56000000 {
>>   					<SYSC_IDLE_SMART>;
>>   			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
>>   					<SYSC_IDLE_NO>,
>> -					<SYSC_IDLE_SMART>;
>> +					<SYSC_IDLE_SMART>,
>> +					<SYSC_IDLE_SMART_WKUP>;
> 
> You probably checked this already.. But just in case, can you please
> confirm this is intentional. The documentation lists the smart wakeup
> capability bit as reserved for dra7, maybe the documentation is wrong.
> 

It was an intentional change, although I'm not sure it is correct :)

This is how we had it in our "evil vendor tree" for years (back when it
was hwmod based), so when converting these nodes to use "ti,sysc" I noticed
this bit was set, but as you point out the documentation disagrees.

I'd rather go with what has worked before, but it doesn't seem to
break anything either way, so we could also break this change out into
its own patch if you would prefer.

Andrew

> Regards,
> 
> Tony
> 

