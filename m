Return-Path: <linux-kernel+bounces-108899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20E88118C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C43285C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564B3FB8A;
	Wed, 20 Mar 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="GmPmSTG5"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D03FB3E;
	Wed, 20 Mar 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936987; cv=none; b=WQnR2z0vFKUlk9LpyH4sfiRfDbme32zuKcTOVurrpPxTwwewXeq/18V7zPME/BJnxt3wC/TXjlavp0G5grei4y+ottGMvEhzsadPtF6WiIBI0Xe0cWAeAeVP+rEQ+9VZ7HmlNKe80aSmDg7/z898mi1AeUG6vCQGb0qffO9MDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936987; c=relaxed/simple;
	bh=9wUxNya5MwO0AWzbSx0vgHmuEQkxOF5N+gqswt8BCKQ=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:CC:From:
	 In-Reply-To:Content-Type; b=cQZ7MP58Z8G86wDltQYv14flzF2we5NFlyuhorXidmjKW6u+s9Cu/55djjB2tYeg4Yfs6dpPQXTpt9K+nZGlHKMF/Idde3VoDP7ePIw4mFsaZEtNOGE9urilfNLG04X7rQWDsxZaek/d4W9sXa9GHNKI0+frJ97cvPgO0CSEHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=GmPmSTG5; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1710936986; x=1742472986;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=oNAChz6dcAhqmSOfvCdYjG/OjnMxp1CwiKwicGuGmuI=;
  b=GmPmSTG57knKUIgnD62ZVZc9Rq5ZIVJDRTsAINY6W2Q0z7+0Uzr9NcbI
   6WwxQh0eBvxLWinFQgqqHYj4nGh/gDLBYHjxaLQrEK0H6Rzpha9unx/mo
   c6SETAclX/sbcgjhBV+fBS0iijDslFON66W8U2poAiMYJrFv9Dbea5u4R
   A=;
X-IronPort-AV: E=Sophos;i="6.07,140,1708387200"; 
   d="scan'208";a="389099048"
Subject: Re: [PATCH v1 3/4] dt-bindings: Add bindings for vmgenid
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:16:22 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:15322]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.20:2525] with esmtp (Farcaster)
 id 21669b37-9eef-4d6e-851b-cf088b8821dd; Wed, 20 Mar 2024 12:16:20 +0000 (UTC)
X-Farcaster-Flow-ID: 21669b37-9eef-4d6e-851b-cf088b8821dd
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 12:16:20 +0000
Received: from [192.168.16.135] (10.106.82.23) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 12:16:14 +0000
Message-ID: <7d8f7c42-02e9-46df-8ea5-ab9a4b9721dc@amazon.co.uk>
Date: Wed, 20 Mar 2024 12:16:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sudan Landge
	<sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319143253.22317-1-sudanl@amazon.com>
 <20240319143253.22317-4-sudanl@amazon.com>
 <ba8418ab-2829-416c-8e20-414f7818cab9@linaro.org>
 <f221da06-2a7c-4db3-a0de-870156865631@amazon.co.uk>
 <cfdb77c8-e893-41bf-965f-1013f3fc910e@linaro.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <cfdb77c8-e893-41bf-965f-1013f3fc910e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Hi Krzysztof,


The recipient were removed by mistake. I have added them all back and 
fixed the email client to send mail in the right format. Sorry about that.
I'll revert after I have done more analysis and better data to explain.
Thank you for the quick feedback again.

Thanks and regards,
Sudan

On 20/03/2024 10:24, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 20/03/2024 11:17, Landge, Sudan wrote:
>>
>> On 19/03/2024 15:28, Krzysztof Kozlowski wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
> 
> Why did you remove all the people from CC list?
> >>>
>>> On 19/03/2024 15:32, Sudan Landge wrote:
>>>> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
>>>> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
>>>> ACPI only device.
>>> That's not a valid rationale. Second today... we do not add things to
>>> bindings just because someone added some crazy or not crazy idea to Linux.
>>>
>>> Bindings represent the hardware.
>>>
>>> Please come with real rationale. Even if this is accepted, above reason
>>> is just wrong and will be used as an excuse to promote more crap into
>>> bindings.
>>
>> Thank you for the quick review.
>>
>> I will add more details to the problem we are trying to fix with an
>> updated cover letter
>>
>> but to summarize the problem briefly:
>>
>> Firecracker is a minimalist feature hypervisor and we do not have ACPI
>> support
>>
>> for ARM yet. The vmgenid devicetree support looked a better option because
>>
>> supporting ACPI on ARM means supporting UEFI which adds a lot of complexity.
> 
> That does not convince me. Amount of work for you is not making virtual
> stuff real hardware. Come with some other discoverable protocol - you
> have full control of both sides of this thing.
> 
>>
>>> A nit, subject: drop second/last, redundant "bindings". The
>>> "dt-bindings" prefix is already stating that these are bindings.
>>> See also:
>>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>>>
>>> Please use subject prefixes matching the subsystem. You can get them for
>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>> your patch is touching.
>> Got it, thanks.
>>>> Add a devicetree binding support for vmgenid so that hypervisors
>>>> can support vmgenid without the need to support ACPI.
>>> Devicetree is not for virtual platforms. Virtual platform can define
>>> whatever interface they want (virtio, ACPI, "VTree" (just invented now)).
>> Sorry for my lack of experience in this area. I took reference of virtio
>> devices when I
>>
>> uploaded the patch. We would still like to support vmgenid via a
>> devicetree so I'll
>>
>> revert with a new approach.
> 
> There are other solutions, I think. This was discussed already multiple
> times.
> 
>>
>>>> Signed-off-by: Sudan Landge<sudanl@amazon.com>
>>>> ---
>>>>    .../devicetree/bindings/vmgenid/vmgenid.yaml  | 57 +++++++++++++++++++
>>> No, you do not get your own hardware subsystem. Use existing ones.
>>
>> Got it. The changes are related to the "rng" subsystem so I'll rethink
>> if that is the
>>
>> right place for this and revert.
> 
> Your wrapping is odd. Please use some decent email client.
> 
> Anyway, I am not discussing topics semi-private. Keep all maintainers in
> loop.
> 
> Best regards,
> Krzysztof
> 

