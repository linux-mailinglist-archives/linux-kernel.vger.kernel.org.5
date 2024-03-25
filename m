Return-Path: <linux-kernel+bounces-117896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F088B10C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DEA1FA59BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D194E1DB;
	Mon, 25 Mar 2024 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="MiiCoAhb"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F55812B;
	Mon, 25 Mar 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397511; cv=none; b=lZeBX/L9AK1c+HIh/HrshEFAn/84s02XXWjw7Lxc6wpM4o4GVPhBk8EvgXqWO4vmEzr3lcLp0KBoGMPGR+onM4pO5LcSJUvH/g/gdxUgI+BsFCFAlgvyryjANRhvWuwE109oTzcLgKVoq3WOo3Stwr/jdmEEoNIQ2oE2sbRCOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397511; c=relaxed/simple;
	bh=3iDIgOlyvuqyioJ6WS6fsqOQ5p353dXrtDE8Wlpcxlc=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sJGNj81PsyQIpOjFnuMISrkrltfw4mG8NJADXvDSeHTH2TiSVKIoN41ixO9U+G5LogF8cpE3/49sc5eH/4J5RHwanADdBycxsZGKHIEb6IypgvChnaQvb86oFelfXdWOnMGBedfzWqR53qCE37+WwVGpSNSzmv7ZrI8tzVSCiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=MiiCoAhb; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711397509; x=1742933509;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=nZm0+TOxnLlCiQwpuMtOZy0/rA/EOQRcZGUJenN26Hk=;
  b=MiiCoAhbdKP7nuGoAgzFFKxNN/c45HRRF89/hA8i4T6yGfsCadI+hgXx
   AbTaDmHzZmXC7l5dGW0XeqhCWBLhKJww/8aOAxGz/vadwuC0QAxaCLz7I
   taG2GDIqpTm8rWinePZ/kdAalUcbMyxJrHX7MRgf8GP0kn9Z6BYsIhIFG
   c=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="283719456"
Subject: Re: [PATCH v2 3/4] dt-bindings: rng: Add vmgenid support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:11:46 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:17780]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.21:2525] with esmtp (Farcaster)
 id a0177e7f-73dc-4400-8ccb-89bba7ceadee; Mon, 25 Mar 2024 20:11:44 +0000 (UTC)
X-Farcaster-Flow-ID: a0177e7f-73dc-4400-8ccb-89bba7ceadee
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:11:41 +0000
Received: from [192.168.17.104] (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:11:36 +0000
Message-ID: <51403072-f5ca-450e-9206-19ca627ead11@amazon.co.uk>
Date: Mon, 25 Mar 2024 20:11:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Sudan Landge <sudanl@amazon.com>
CC: <tytso@mit.edu>, <Jason@zx2c4.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240321025105.53210-1-sudanl@amazon.com>
 <20240321025105.53210-4-sudanl@amazon.com>
 <20240325150609.GA3477574-robh@kernel.org>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240325150609.GA3477574-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 25/03/2024 15:06, Rob Herring wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Thu, Mar 21, 2024 at 02:51:04AM +0000, Sudan Landge wrote:
>> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
>> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
>> ACPI only device.
>>
>> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
>> a mechanism for the BIOS/hypervisors to communicate to the virtual machine
>> that it is executed with a different configuration (e.g. snapshot execution
>> or creation from a template).
>> The guest operating system can use the notification for various purposes
>> such as re-initializing its random number generator etc.
>>
>> As per the specs, hypervisor should provide a globally unique identified,
>> or GUID via ACPI.
>>
>> This patch tries to mimic the mechanism to provide the same functionality
>> which is for a hypervisor/BIOS to notify the virtual machine when it is
>> executed with a different configuration.
>>
>> As part of this support the devicetree bindings requires the hypervisors or
>> BIOS to provide a memory address which holds the GUID and an IRQ which is
>> used to notify when there is a change in the GUID.
>> The memory exposed in the DT should follow the rules defined in the
>> vmgenid spec mentioned above.
>>
>> *Reason for this change*:
>> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
>> Without going into details of why a hypervisor would chose DT over ACPI,
>> we would like to highlight that the hypervisors that have chose devicetree
>> and now want to make use of the vmgenid functionality cannot do so today
>> because vmgenid is an ACPI only device.
>> This forces these hypervisors to change their design which could have
>> undesirable impacts on their use-cases, test-scenarios etc.
>>
>> The point of vmgenid is to provide a mechanism to discover a GUID when
>> the execution state of a virtual machine changes and the simplest
>> way to do it is pass a memory location and an interrupt via devicetree.
>> It would complicate things unnecessarily if instead of using devicetree,
>> we try to implement a new protocol or modify other protocols to somehow
>> provide the same functionility.
>>
>> We believe that adding a devicetree binding for vmgenid is a simpler,
>> better alternative to provide the same functionality and will allow
>> such hypervisors as mentioned above to continue using devicetree.
>>
>> More references to vmgenid specs:
>>   - https://www.qemu.org/docs/master/specs/vmgenid.html
>>   - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier
>>
>> Signed-off-by: Sudan Landge <sudanl@amazon.com>
>> ---
>>   .../devicetree/bindings/rng/vmgenid.yaml      | 57 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Documentation/devicetree/bindings/rng/vmgenid.yaml
>> new file mode 100644
>> index 000000000000..4b6ab62cc2ae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rng/vmgenid.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Virtual Machine Generation Counter ID device
>> +
>> +maintainers:
>> +  - Jason A. Donenfeld <Jason@zx2c4.com>
>> +
>> +description:
>> +  Firmwares or hypervisors can use this devicetree to describe
>> +  interrupts and the shared resources to inject a Virtual Machine Generation
>> +  counter.
>> +
>> +properties:
>> +  compatible:
>> +    const: linux,vmgenctr
> 
> Why 'linux'? It should be named for a particular host implementation
> (and that implementation's bugs/quirks). However, this thing is simple
> enough we can perhaps avoid that here. As the interface is defined by
> Microsoft, then perhaps they should be the vendor here.
> 
We chose "linux" because the current implementation and usage of 
devicetree was Linux specific. However, I think "virtual" would be a 
better choice than "Microsoft" since this is a generic virtual device 
that could be configured by any hypervisor or firmware not owned or 
related to Microsoft. I have updated this as part of the new version if 
it looks good. I don't have a strong opinion for "virtual" though so if 
that is the right choice as per you I can update it.

>> +
>> +  "#interrupt-cells":
>> +    const: 3
>> +    description: |
>> +      The 1st cell is the interrupt type.
>> +      The 2nd cell contains the interrupt number for the interrupt type.
>> +      The 3rd cell is for trigger type and level flags.
>> +
>> +  interrupt-controller: true
> 
> Why is this device an interrupt controller?
> 
My devicetree references I took initially were incorrect which led to 
the addition of this, I have removed this in the next version. Sorry 
about that.

>> +
>> +  reg:
>> +    description: |
>> +      specifies the base physical address and
>> +      size of the regions in memory which holds the VMGenID counter.
> 
> Odd wrapping, but drop unless you have something specific to say about
> region like perhaps the layout of the registers. Or maybe thats defined
> somewhere else?
> 
> Does the spec say anything about endianness or access size? DT assumes
> native endianness by default. We have properties to deal these, but
> would be better to be explicit if that's defined already.
> 
The spec doesn't mention anything about the endianness but, I have 
updated the description with some more data.

>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description: |
> 
> Don't need '|' if no formatting.
> 
>> +      interrupt used to notify that a new VMGenID counter is available.
>> +      The interrupt should be Edge triggered.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    rng@80000000 {
>> +      compatible = "linux,vmgenctr";
>> +      reg = <0x80000000 0x1000>;
>> +      interrupts = <0x00 0x23 0x01>;
>> +    };
>> +
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 43b39956694a..cf4b2e10fb49 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18431,6 +18431,7 @@ M:    "Theodore Ts'o" <tytso@mit.edu>
>>   M:   Jason A. Donenfeld <Jason@zx2c4.com>
>>   S:   Maintained
>>   T:   git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
>> +F:   Documentation/devicetree/bindings/rng/vmgenid.yaml
>>   F:   drivers/char/random.c
>>   F:   drivers/virt/vmgenid.c
>>
>> --
>> 2.40.1
>>
>>
Thank you for the feedback, I have pushed a new version of the patch to 
address the review comments.

