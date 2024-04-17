Return-Path: <linux-kernel+bounces-148780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193C8A874E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAC7281E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD17146D65;
	Wed, 17 Apr 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="vlFY7dUn"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF32146A98;
	Wed, 17 Apr 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367159; cv=none; b=DkcjbNXeia2EaQEN+cSL3ihtaBLa15mII9w9SuzLIKltPsTkY7Ts5Qlh7LwVYJHR5KO9GtaNfKCcxnD5wVMM/huD7yPdZt0sx1J5n/xj0JYfrMsED0R+/iHwWYwMZP00aaBImWMyDWgFJN/V6BC//ar+agcvSpa9aVnTmOristg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367159; c=relaxed/simple;
	bh=mMo0cwC/rttzuCWdxwf3w8LgjczbB4jsNmjV24Jm68w=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JXOFTloGAg6BBdrktqRPUBoX8iYN2zWRCRtbbB/1D5DRRSx7yAknsh5tNC1be2W4WZ9/7jm69yTlffoPTvpuaKglwsZ7N1/mxP6k3DtyKR5jBmqSuoOVuAEJRTJI3RQDFfTCbk1IdVsuF6scOn4aHTn1Wf7tTcE5nBR+N7kXY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=vlFY7dUn; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713367154; x=1744903154;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=D5yVlSSq78hryXa+FH5bdNGCKVY+GLfhRaLLBcOWrGM=;
  b=vlFY7dUnSTUZ7IBE1VOtcYnBxrZlWKrpFHhCjJ88fniQBq63eHiTHTqi
   AmJL7RrzqulG31rKfEbus8c0CgDnJfoGPr7rzgZZSdPVJQhLqj3D/KNEa
   qZxTyayS/joii/eG62C7BQFr6OTmpa3c2e3wMwQQWiqsE37fXIouXIWHt
   I=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="82195097"
Subject: Re: [PATCH v6 4/5] dt-bindings: rng: Add vmgenid support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 15:19:10 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:45373]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.188:2525] with esmtp (Farcaster)
 id 78989997-edb1-4bc4-af34-e1b4e9f7549e; Wed, 17 Apr 2024 15:19:09 +0000 (UTC)
X-Farcaster-Flow-ID: 78989997-edb1-4bc4-af34-e1b4e9f7549e
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 15:19:09 +0000
Received: from [192.168.27.23] (10.1.212.9) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 17 Apr
 2024 15:19:03 +0000
Message-ID: <433a026a-352c-48c1-84cf-e538bb30aad7@amazon.es>
Date: Wed, 17 Apr 2024 15:18:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krzysztof Kozlowski <krzk@kernel.org>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<olivia@selenic.com>, <herbert@gondor.apana.org.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
	<dwmw@amazon.co.uk>, Alexander Graf <graf@amazon.com>
References: <20240417104046.27253-1-bchalios@amazon.es>
 <20240417104046.27253-5-bchalios@amazon.es>
 <a9f1d643-f171-4b41-88c5-bd9bae0f8200@kernel.org>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <a9f1d643-f171-4b41-88c5-bd9bae0f8200@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

On 4/17/24 14:09, Krzysztof Kozlowski wrote:
>
> On 17/04/2024 12:40, Babis Chalios wrote:
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
>>   - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-
>> machine-generation-identifier
>>
>> Co-authored-by: Sudan Landge <sudanl@amazon.com>
>> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> What happened here?
>
> NAK
>
> You are no the author of this patch. You changed here nothing and you
> took authorship?
>
> Read carefully submitting patches, this is not acceptable.
Hi Krzysztof,

Thanks for your review and your comments (both here and at the thread in
the previous version). I will read again the documentation for DCO on 
submitting
patches.

In the meantime, I followed the suggestion of Alex in the discussion of the
previous thread and had already sent v6 before receiving yours and Jason's
responses. In my defense, I didn't want to plagiarize Sudan here. It 
just seemed
from the discussion in the previous version that this is the standard 
practice
when someone is taking over the submission of a patch-set.

I will re-create the patches with correct authorship, my SoB and the 
Reviewed-by
tags I had received in previous versions and send a v7.

Cheers,
Babis


>
> Best regards,
> Krzysztof
>


