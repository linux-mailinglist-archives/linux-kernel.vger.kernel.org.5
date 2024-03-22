Return-Path: <linux-kernel+bounces-111788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCE887100
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB88285387
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC25CDF2;
	Fri, 22 Mar 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="OPFlwYmW"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42826495F0;
	Fri, 22 Mar 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125565; cv=none; b=n8ow4z1zqoDNAbOTFWYKlSe4/H2jXUBBhN0DZvr5+b17kR3I/i69hzSd4MbiCrPDQqrJxwy7n6D+JQPCZs28kWbmz8VjYZ4+MSrT2Qgo4zcv3AV9NGWGfgI+9cNtCTkK0fuQehIu0Ag2BU637Zu4wD2TRGPqBloYdX5fDxRharw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125565; c=relaxed/simple;
	bh=nlkMOMncwpIINGvRX/UEkWw6eMthWmsYDewKJVNfR6E=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Us+X8jOtHhl6MQlZoeVCj53LuCJ1L4LugjmPrRGOqX1gphrjy/DGfaICPWcv2cYDkRh6zYhbe7l3B0/X8fn4a3IRsyWusyg+IDpkuAH2kZV5QVZnXqoxk1FIB3Vy4MioDlSxLU07Rsdc33mVc0Q5yMRR/U/9W4kRASos5vAsoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=OPFlwYmW; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711125563; x=1742661563;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=H3tv937L/nNlgjDfXEwnKqcwdZa8dGHZRZ7eEGPyFgw=;
  b=OPFlwYmW9s49e9Yvm/O/1zAspOtRhE8CPfvMBeSvl03ZI25j5yl2uxH6
   FqBp08hRpV0hftIRpoUqZ2b5H104F8o1r1inOqlIINHvKbq1tIoC9Jaiu
   9x7PdQtGrtGqiYURX0hsJqxKUir32M4vZc+QkawTg80yZnE9Ebr8ue6AZ
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,146,1708387200"; 
   d="scan'208";a="642879176"
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:39:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:18975]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.17:2525] with esmtp (Farcaster)
 id e58a527d-dcbd-4bc9-a202-dbb0c45db04e; Fri, 22 Mar 2024 16:39:18 +0000 (UTC)
X-Farcaster-Flow-ID: e58a527d-dcbd-4bc9-a202-dbb0c45db04e
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 16:39:17 +0000
Received: from [192.168.15.170] (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 16:39:11 +0000
Message-ID: <d790d5cc-a116-4d5b-97a4-da0d073ff3e3@amazon.co.uk>
Date: Fri, 22 Mar 2024 16:39:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sudan Landge
	<sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <thomas.lendacky@amd.com>,
	<dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <graf@amazon.de>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>, <ardb@kernel.org>, benh <benh@kernel.crashing.org>
References: <20240319143253.22317-1-sudanl@amazon.com>
 <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
 <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>
 <20240320161531.GA1810860-robh@kernel.org>
 <60404403932a984d1f75d111ff53b9053af03579.camel@infradead.org>
 <20240321133250.GA1600070-robh@kernel.org>
 <db5a1027-93b7-4630-b679-8a654905dc48@amazon.co.uk>
 <17611183-f288-47fe-a5e1-91ee16168db0@linaro.org>
 <ee688cca986d95148a55e32fee48ceed8567f128.camel@infradead.org>
 <CAL_JsqJOn9yU_YC0+q=4DX9_=0+z8yTact0HAvOKbrUpcXHxkQ@mail.gmail.com>
 <0a83e174db16e15cb0f0d3ac37d6717c918ee78d.camel@infradead.org>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <0a83e174db16e15cb0f0d3ac37d6717c918ee78d.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 22/03/2024 14:27, David Woodhouse wrote:
> On Fri, 2024-03-22 at 08:22 -0500, Rob Herring wrote:
>>
>>>> What stops you from passing fw_cfg not to UEFI FW? BTW, no actual VM
>>>> name was used in your posting, but now suddenly it is a talk about QEMU.
> 
> (Forgot to address the second part of that last time. No specific VMM
> was mentioned in the first place because this isn't VMM-specific)
> 
QEMU is referenced to explain `vmgenid` which they are also using and 
have more documentation on it. We mentioned the hypervisor we tested the 
changes with in the cover letter which is 
https://github.com/firecracker-microvm/firecracker but this change isn't 
VMM specific.

>>> That would be possible. But not ideal.
>>
>> Why not ideal?
>>
>> To rephrase the question, why is it fine for UEFI to read the vmgenid
>> from fw_cfg, but the kernel can't use the same mechanism?
> 
> Because fw_cfg an incestuous way to get data from the VMM into the BIOS
> (both SeaBIOS and UEFI). It's the way we pass the ACPI tables and
> things like that.
> 
> It *isn't* designed as a general-purpose way of doing device discovery
> for use by various operating systems.
> 
> I'm also not sure Firecracker, which is the VMM Sudan is working on,
> even *has* fw_cfg. Especially on ARM. If we're going to be forced to
> add some complicated device with MMIO and DMA just to be able to
> advertise the existence of a simple memory region, that's just as bad
> as being forced to expose it as an emulated PCI device.
> 
> This is what DT is *for*.
> 
> 
>> The response
>> that you'd have to use UEFI to use fw_cfg makes no sense to me. The
>> only reason I can think of is just being lazy and wanting to have
>> minimal changes to some existing driver. It looks to me like you could
>> implement this entirely in userspace already with zero kernel or
>> binding changes. From a quick look, we already have a fw_cfg driver
>> exposing UUID (that's the same thing as vmgenid AIUI) to userspace,
>> and you can feed that back into the random pool.
>>
>> I am concerned that we already have a mechanism and you want to add a
>> second way. When do we ever think that's a good idea? What happens
>> on the next piece of fw_cfg data? We add yet another binding?
> 
> No, because fw_cfg is a way for the VMM to give configuration
> information to the firmware. There's a clue in the name. The firmware
> then sets up ACPI tables or DT to pass information in a more coherent
> and structured fashion to general-purpose operating systems.
> 
> And some VMMs *don't* use fw_cfg at all because for the minimal microvm
> case it's overkill.
> 
The hypervisor we work on 
(https://github.com/firecracker-microvm/firecracker) does not have 
fw_cfg, it loads kernel directly without the need for UEFI or any 
intermediate firmware. It is, as said, an overkill to enable UEFI and 
fw_cfg just to support `vmgenid` specially when there is an alternative 
available which could keep things simple for the vmm and for the linux 
driver.

