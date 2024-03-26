Return-Path: <linux-kernel+bounces-119035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E488C2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736B71C2BA82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713771739;
	Tue, 26 Mar 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="TwTZXKoc"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531156D1AB;
	Tue, 26 Mar 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458394; cv=none; b=ZmTm9B0dUPiOICcpAfsYLp2SXHpkKijbMo039vEVQXl7TCYx9buu4pITXe25UaHNcAn7bTwSV3CDEmUPI4RbJ4J1lkMFxI7XaJpnEGA7UN5UbUu/rWtryBLmxNTMMnUAWDVxJyocHlQdvXYqSJb1cE4q753weGM6IaLIn5uvKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458394; c=relaxed/simple;
	bh=C1lns0hmF/ZFdYXZmwb6mRMtg+MzMiLPqOEBEcJGeZc=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KaFwFZXT+v76rQpj/RQ4aKMgPdCf1lZdvUacf4kk6la61hCI2OhKQoNowzHocHE0q9O0MT9Mu7lrBqqdxYQX+AUD1YpxbpOHaYSnCvRHQybr6FApBk0isom+PxYgSfz8EvCTpKG/IRoaXycC5mlZ1ijl9C6EIbhLfaVW5G5bD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=TwTZXKoc; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711458390; x=1742994390;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=nXEdpgCUmREY3ofef4i8+nCfBb4YBIpNnsbD0WGVIIo=;
  b=TwTZXKocRAsPss7Zf4iS5TMjxTCLreIJ4heortT8Vk6MhE6e3iTXVp3w
   6bL0ZfvFurIUDtBhuFwRdaZym+ruU2MvxPNc6P5dK0C9AXLr3lA8hKfzw
   emKl6jHUC+UiV6ZsSWOVzxh2gIk26ZkpAUIUXNcSKl3EmdNXCHu7LIctq
   o=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708387200"; 
   d="scan'208";a="396130015"
Subject: Re: [PATCH v2 3/4] dt-bindings: rng: Add vmgenid support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:06:27 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:24510]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.129:2525] with esmtp (Farcaster)
 id fafddf53-9fb2-47ff-8e5c-18a4c6d4f7ef; Tue, 26 Mar 2024 13:06:26 +0000 (UTC)
X-Farcaster-Flow-ID: fafddf53-9fb2-47ff-8e5c-18a4c6d4f7ef
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 13:06:25 +0000
Received: from [192.168.18.216] (10.106.83.18) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 13:06:20 +0000
Message-ID: <96df7e5a-52df-4171-9cd6-78d088a7a1e2@amazon.co.uk>
Date: Tue, 26 Mar 2024 13:06:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Sudan Landge <sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <thomas.lendacky@amd.com>,
	<dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <graf@amazon.de>, <dwmw@amazon.co.uk>,
	<bchalios@amazon.es>, <xmarcalx@amazon.co.uk>
References: <20240321025105.53210-1-sudanl@amazon.com>
 <20240321025105.53210-4-sudanl@amazon.com>
 <20240325150609.GA3477574-robh@kernel.org>
 <51403072-f5ca-450e-9206-19ca627ead11@amazon.co.uk>
 <CAL_JsqKpp+J2a_+wmcaOX8RfTEEyZBESWBX7GWGa_u_5_=4gsg@mail.gmail.com>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <CAL_JsqKpp+J2a_+wmcaOX8RfTEEyZBESWBX7GWGa_u_5_=4gsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 25/03/2024 20:41, Rob Herring wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Mon, Mar 25, 2024 at 3:11 PM Landge, Sudan <sudanl@amazon.co.uk> wrote:
>>
>>
>>
>> On 25/03/2024 15:06, Rob Herring wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu, Mar 21, 2024 at 02:51:04AM +0000, Sudan Landge wrote:
>>>> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
>>>> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
>>>> ACPI only device.
>>>>
>>>> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
>>>> a mechanism for the BIOS/hypervisors to communicate to the virtual machine
>>>> that it is executed with a different configuration (e.g. snapshot execution
>>>> or creation from a template).
>>>> The guest operating system can use the notification for various purposes
>>>> such as re-initializing its random number generator etc.
>>>>
>>>> As per the specs, hypervisor should provide a globally unique identified,
>>>> or GUID via ACPI.
>>>>
>>>> This patch tries to mimic the mechanism to provide the same functionality
>>>> which is for a hypervisor/BIOS to notify the virtual machine when it is
>>>> executed with a different configuration.
>>>>
>>>> As part of this support the devicetree bindings requires the hypervisors or
>>>> BIOS to provide a memory address which holds the GUID and an IRQ which is
>>>> used to notify when there is a change in the GUID.
>>>> The memory exposed in the DT should follow the rules defined in the
>>>> vmgenid spec mentioned above.
>>>>
>>>> *Reason for this change*:
>>>> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
>>>> Without going into details of why a hypervisor would chose DT over ACPI,
>>>> we would like to highlight that the hypervisors that have chose devicetree
>>>> and now want to make use of the vmgenid functionality cannot do so today
>>>> because vmgenid is an ACPI only device.
>>>> This forces these hypervisors to change their design which could have
>>>> undesirable impacts on their use-cases, test-scenarios etc.
>>>>
>>>> The point of vmgenid is to provide a mechanism to discover a GUID when
>>>> the execution state of a virtual machine changes and the simplest
>>>> way to do it is pass a memory location and an interrupt via devicetree.
>>>> It would complicate things unnecessarily if instead of using devicetree,
>>>> we try to implement a new protocol or modify other protocols to somehow
>>>> provide the same functionility.
>>>>
>>>> We believe that adding a devicetree binding for vmgenid is a simpler,
>>>> better alternative to provide the same functionality and will allow
>>>> such hypervisors as mentioned above to continue using devicetree.
>>>>
>>>> More references to vmgenid specs:
>>>>    - https://www.qemu.org/docs/master/specs/vmgenid.html
>>>>    - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier
>>>>
>>>> Signed-off-by: Sudan Landge <sudanl@amazon.com>
>>>> ---
>>>>    .../devicetree/bindings/rng/vmgenid.yaml      | 57 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  1 +
>>>>    2 files changed, 58 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Documentation/devicetree/bindings/rng/vmgenid.yaml
>>>> new file mode 100644
>>>> index 000000000000..4b6ab62cc2ae
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
>>>> @@ -0,0 +1,57 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/rng/vmgenid.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Virtual Machine Generation Counter ID device
>>>> +
>>>> +maintainers:
>>>> +  - Jason A. Donenfeld <Jason@zx2c4.com>
>>>> +
>>>> +description:
>>>> +  Firmwares or hypervisors can use this devicetree to describe
>>>> +  interrupts and the shared resources to inject a Virtual Machine Generation
>>>> +  counter.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: linux,vmgenctr
>>>
>>> Why 'linux'? It should be named for a particular host implementation
>>> (and that implementation's bugs/quirks). However, this thing is simple
>>> enough we can perhaps avoid that here. As the interface is defined by
>>> Microsoft, then perhaps they should be the vendor here.
>>>
>> We chose "linux" because the current implementation and usage of
>> devicetree was Linux specific. However, I think "virtual" would be a
>> better choice than "Microsoft" since this is a generic virtual device
>> that could be configured by any hypervisor or firmware not owned or
>> related to Microsoft. I have updated this as part of the new version if
>> it looks good. I don't have a strong opinion for "virtual" though so if
>> that is the right choice as per you I can update it.
> 
> I'm not really a fan of 'virtual' and its one and only existing use.
> Don't add to it.
> 
> Someone has defined how to read a GUID from register(s). I can think
> of many ways that could be implemented. The data itself could be hex
> or ascii. You could read N times from one register or read from N
> sequential registers. And again, there's endianness and access sizes.
> Given the only source of any of that is a Microsoft spec, then that
> makes sense to me. Or just no vendor prefix is possible, but I prefer
> to avoid those cases.
ok, you are right. Using "Microsoft" as the compatible string makes more 
sense. I will use that.
> 
> Also, consider 'vmgenctr' has basically 0 search results. 'vmgenid'
> returns some relevant results. Not that search results are a
> requirement for naming, but perhaps something to consider.
> 
The original driver supports 2 ACPI CIDs, "VMGENCTR" and 
"VM_GEN_COUNTER" and as per this commit 
https://github.com/torvalds/linux/commit/0396e46dc46523cba8401a0df84f67cc0b6067ab 
"VMGENCTR" is to be used for VMGenID specs. So, I used "vmgenctr" to be 
consistent with its ACPI counterpart "VMGENCTR".

>>>> +
>>>> +  "#interrupt-cells":
>>>> +    const: 3
>>>> +    description: |
>>>> +      The 1st cell is the interrupt type.
>>>> +      The 2nd cell contains the interrupt number for the interrupt type.
>>>> +      The 3rd cell is for trigger type and level flags.
>>>> +
>>>> +  interrupt-controller: true
>>>
>>> Why is this device an interrupt controller?
>>>
>> My devicetree references I took initially were incorrect which led to
>> the addition of this, I have removed this in the next version. Sorry
>> about that.
> 
> Try again...
> 
Ok, I will confirm my understanding and provide a better answer in my 
next mail. As you mentioned in another mail, I will also pause on 
posting any new version till the current threads are answered.

>>>> +
>>>> +  reg:
>>>> +    description: |
>>>> +      specifies the base physical address and
>>>> +      size of the regions in memory which holds the VMGenID counter.
>>>
>>> Odd wrapping, but drop unless you have something specific to say about
>>> region like perhaps the layout of the registers. Or maybe thats defined
>>> somewhere else?
>>>
>>> Does the spec say anything about endianness or access size? DT assumes
>>> native endianness by default. We have properties to deal these, but
>>> would be better to be explicit if that's defined already.
>>>
>> The spec doesn't mention anything about the endianness but, I have
>> updated the description with some more data.
> 
> Then what does your driver assume? Microsoft may not have thought
> about it because they don't care, but now you want to use DT so you
> have to because it is frequently used on BE systems. If we define
> something, then there's some hope. Otherwise, it's pretty much a
> guarantee folks will do the opposite.
> 
> Rob
The driver does not assume any endianness. To provide more context, The 
hypervisor stores a 128bit unique ID at the address pointed by the 
"reg"'s 1st cell, driver memcpy's this ID to an internal context and 
uses memcmp to compare if the ID is new or old.
But yes, it will be good to define a fixed endianness to avoid any 
error. I will update the description to use little endian.

