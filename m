Return-Path: <linux-kernel+bounces-110511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9ED885FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C7E284185
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255C612BF3E;
	Thu, 21 Mar 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="twhwCJ4M"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB068624C;
	Thu, 21 Mar 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042788; cv=none; b=TsvahzagSWlq49EmIFRCgl4lx1NXI09ibktw/xc9diET+n4qSNwVsEzr1yCQ68MLHuc6FS0aLw27vLTdew12M8JRkU/BzlpknZAziYxoXS4TkFoEkCMzSRY5NLH4lrcaF6kjpc8pgqe1zbiZF4zfBmMEbidHRsXpPHimDrHzMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042788; c=relaxed/simple;
	bh=tmVyl3CnV/a8ywSLGoP9rsnHV/1ICdCewlLv8W7cRX4=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L4MYEzDeo+oWLsluX6bSgd7z1vX6RhraXBOLY0M9+IJVwNHhrD2a7Ut4c6kp3iMrVF2S3rTVoe7oGh25Y/FyOQ8S+sE+KRH06IJUXeCOptAENHbFu1eQ5oERoQu30mg247DOiIw2ObdG/MmPtOleuc53mbN2NkPtl4ci/ctKklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=twhwCJ4M; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711042786; x=1742578786;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=Y2m0HUIoPsV3lCWkx5c13P3hII6BgfumgnVO7r8vV/0=;
  b=twhwCJ4MOi1AdIEx/qlHJTs6nIanHZjex7NMfjF8GgPe8U6mWCflP6IM
   Z2YBiThp43iy4TsqUp+fFQlcxSOPKhq/XSS2ELeYw1m6DacFPVF12ImqT
   g28Ucu6vvGRIzOoYAGYk5iY1LwMYCheDk/LXF1lVwtF1vRxkr25KcjlXl
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,143,1708387200"; 
   d="scan'208";a="405714813"
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 17:39:39 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:51553]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.24.234:2525] with esmtp (Farcaster)
 id 07620b8e-e807-42d8-ae98-352d02494533; Thu, 21 Mar 2024 17:39:38 +0000 (UTC)
X-Farcaster-Flow-ID: 07620b8e-e807-42d8-ae98-352d02494533
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 17:39:38 +0000
Received: from [192.168.15.25] (10.106.82.17) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 21 Mar
 2024 17:39:32 +0000
Message-ID: <db5a1027-93b7-4630-b679-8a654905dc48@amazon.co.uk>
Date: Thu, 21 Mar 2024 17:39:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, David Woodhouse <dwmw2@infradead.org>
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
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240321133250.GA1600070-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 21/03/2024 13:32, Rob Herring wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Mar 20, 2024 at 04:55:45PM +0000, David Woodhouse wrote:
>> On Wed, 2024-03-20 at 11:15 -0500, Rob Herring wrote:
>>> On Wed, Mar 20, 2024 at 01:50:43PM +0000, David Woodhouse wrote:
>>>> On Tue, 2024-03-19 at 16:24 +0100, Krzysztof Kozlowski wrote:
>>>>> On 19/03/2024 15:32, Sudan Landge wrote:
>>>>>> This small series of patches aims to add devicetree bindings support for
>>>>>> the Virtual Machine Generation ID (vmgenid) driver.
>>>>>>
>>>>>> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
>>>>>> ("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
>>>>>> ACPI only device.
>>>>>> We would like to extend vmgenid to support devicetree bindings because:
>>>>>> 1. A device should not be defined as an ACPI or DT only device.
>>>
>>> This (and the binding patch) tells me nothing about what "Virtual
>>> Machine Generation ID driver" is and isn't really justification for
>>> "why".
>>
>> It's a reference to a memory area which the OS can use to tell whether
>> it's been snapshotted and restored (or 'forked'). A future submission
>> should have a reference to something like
>> https://www.qemu.org/docs/master/specs/vmgenid.html or the Microsoft
>> doc which is linked from there.
> 
> That doc mentions fw_cfg for which we already have a binding. Why can't
> it be used/extended here?
QEMU has support for vmgenid but even they do not pass vmgenid directly 
to the guest kernel using fw_cfg. QEMU passes the vmgenid/UUID via 
fw_cfg to an intermediate UEFI firmware. This UEFI firmware, running as 
a guest in QEMU, reads the UUID from fw_cfg and creates ACPI tables for 
it. The UEFI firmware then passes the UUID information to the guest 
kernel via ACPI.
This approach requires yet another intermediary which is UEFI firmware 
and adds more complexity than ACPI for minimalist hypervisors that do 
not have an intermediate bootloader today.

> 
> Rob
> 
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/firmware/qemu%2Cfw-cfg-mmio.yaml


