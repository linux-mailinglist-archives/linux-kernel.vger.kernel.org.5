Return-Path: <linux-kernel+bounces-81893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EF867BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC51C2A5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1612C7F2;
	Mon, 26 Feb 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Sz/gV9NS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SL/YMeut"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E901D531;
	Mon, 26 Feb 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964626; cv=none; b=BVsdUb7Jw6E9tkVcTwZPNSerbyTxphor4tNoGvEjUtzvsTbPMyJppTOfqK6NTBy2LWQjOnYXMBeQDSc1BD/IWX7hARi1FPsT6r25Z9EjLoeGReFtdtuF/qiV1NHl+tERfu/+NJB5KskVwCPOKs2AXNNRoe5PJnSwvjwbMcqL0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964626; c=relaxed/simple;
	bh=4obKeBixDa4cpomzXgdwYi7596cE2U0BVj92sW6prFY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=V4sg+HFdqrN3ndQPbTx/lRz4H88dR0MMixp7n+gH2fDiHpguja4thNNZwxq0tyn5tzTCw2/i894v86LoEiiymWKl9KR9V2Ye6vlf3Khf1LZ2S3bzA2NiW6jNAh28qhkxPTUhyUwbDLugc9hoNYsDoIqMZvgUYpjSXFTIX+wAmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Sz/gV9NS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SL/YMeut; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 4A2BA32009FD;
	Mon, 26 Feb 2024 11:23:42 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 26 Feb 2024 11:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1708964621; x=1709051021; bh=7BXRwHYzYW
	EEQc06izLcRYLoHa9smQMLXOquwBp98Gc=; b=Sz/gV9NSlhEK97/komx9Q0Zu5v
	jzuxwEZ/Wn7TQ5uVz4vhthFdaOsoa1wr3uRhCezTlRYzj6uzLGzmAsTeZZIbAnkk
	hIUc8zRMzEVPBo5PZVqwVS5JzWujZHuDkSubplEh/SNV+hjV2xgg5QwXPtz74ZNg
	bOsMRz0R7bsEEMIyyLI/4s9Ku7Acp2aO9uRqas1SFuL62o8xZC84W5i0igwiBEDi
	fj8mllMiXJ/U02WevVKgvOHDSe7WdDgT9l1DOXQA1SQwDecgagfWP0ZRokLQ49kR
	MekN3TGjlnLSmV+jvart4UnQ/J8zAPY89NLYY3gQiPUuUaJZw4JI0e9oI2Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708964621; x=1709051021; bh=7BXRwHYzYWEEQc06izLcRYLoHa9s
	mQMLXOquwBp98Gc=; b=SL/YMeutO4pVf4HxFUjOYvIeke9MvwHvQL2UcgjJdieU
	iPv9uHP/E03YQ06X163RI7tR65Vk2lKgqLqzT60y9vdP3Gpz77WzEmhaAm4VhZU5
	mv0jvzTihod45073YT8+2Itnm1lPIQbbYNocbNh12vQi2FxsFsO733j+bDyi5r0W
	DYh8WGtxR+vHr4mPwMdiA2Aa09sJPisATMtBnx/VraJBASK0DqqvCw+koxvsh1B6
	Ms3ILlaFIOOL3tCJFiZcnKifhkW/EMR0CVweFihWwgr6Kcf1IkWNa5Mgd/OWlSeY
	K3ZPP8eq9aiP9P+0wP6wWhqFVvMtWRWFPxv4ElnMGA==
X-ME-Sender: <xms:DLvcZROh5buX2qRB8W-x-igYTNXKehK0IorrKPmCvDgdEMcr_lZW8Q>
    <xme:DLvcZT_D9o7MnKjm1QO2se6URqwaEz-Uw52f52ASL-EE4J1CV0aJPXozUGpcSCmcl
    Jg5w_vdVQk8oQSRkUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdforghr
    khcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnsehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeuvefftdefjeevveejheehhfevfeelffehfefgheffjeetvddvhfdu
    ffegheefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:DLvcZQQU8CmU4LEC1QtrwP7Z8_zi8b3RRv_8d3A3zhngkG8aZbeY9w>
    <xmx:DLvcZduJx70iFrMMjaDiUKrV7c88X2S2AHlmUeZoTshm6KLhOutLCA>
    <xmx:DLvcZZc4-E_JVjmeTESjSgmnmBO2LIJGoYdHzsElWIic3QLUwjx9sg>
    <xmx:DbvcZd4aC1CbCBK-fuANP4AWcu0eFfcKWb8EVCNjJ8PyUT7XQS7dHw>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9D735C60097; Mon, 26 Feb 2024 11:23:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74a39cd0-cee3-49a2-a47b-92a9cf9ca008@app.fastmail.com>
In-Reply-To: <42a7e7e9-01b0-4d41-8af1-328de90934ef@roeck-us.net>
References: <20230721122931.505957-1-dober6023@gmail.com>
 <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
 <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
 <4209014c-1730-4c31-87d8-4192d68bcbc6@app.fastmail.com>
 <6615ab2a-3267-477c-ad1b-a72d5a4244e0@roeck-us.net>
 <412acdd3-6b1f-4c45-966f-c493b6fc3ddf@app.fastmail.com>
 <42a7e7e9-01b0-4d41-8af1-328de90934ef@roeck-us.net>
Date: Mon, 26 Feb 2024 11:23:53 -0500
From: "Mark Pearson" <mpearson@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>, "David Ober" <dober6023@gmail.com>,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Type: text/plain

Thanks!

On Sun, Feb 25, 2024, at 1:43 AM, Guenter Roeck wrote:
> On 2/24/24 12:19, Mark Pearson wrote:
>> Thanks Guenter,
>> 
>> On Sat, Feb 24, 2024, at 10:49 AM, Guenter Roeck wrote:
>>> On 2/23/24 16:43, Mark Pearson wrote:
>>>> Thanks Guenter
>>>>
>>>> On Fri, Feb 23, 2024, at 3:21 PM, Guenter Roeck wrote:
>>>>> On 2/23/24 11:58, Mark Pearson wrote:
>>>>>> On Fri, Jul 21, 2023, at 8:29 AM, David Ober wrote:
>>>>>>> This modules is to allow for the new ITE 5632 EC chip
>>>>>>> to support the watchdog for initial use in the Lenovo SE10
>>>>>>>
>>>>>>> Signed-off-by: David Ober <dober6023@gmail.com>
>>>>>>>
>>>>>>> V2 Fix stop to deactivate wdog on unload of module
>>>>>>> V2 Remove extra logging that is not needed
>>>>>>> V2 change udelays to usleep_range
>>>>>>> V2 Changed to now request region on start and release on stop instead
>>>>>>>       of for every ping and read/write
>>>>>>> V3 add counter to while loops so it will not hang
>>>>>>> V3 rework code to use platform_device_register_simple
>>>>>>> V3 rework getting the Chip ID to remove duplicate code and close IO
>>>>>>> V3 change some extra logging to be debug only
>>>>>>> ---
>>>>> [ ... ]
>>>>>>> +config ITE5632_WDT
>>>>>>> +        tristate "ITE 5632"
>>>>>>> +        select WATCHDOG_CORE
>>>>>>> +        help
>>>>>>> +          If you say yes here you get support for the watchdog
>>>>>>> +          functionality of the ITE 5632 eSIO chip.
>>>>>>> +
>>>>>>> +          This driver can also be built as a module. If so, the module
>>>>>>> +          will be called ite5632_wdt.
>>>>>>> +
>>>>>
>>>>> [ ... ]
>>>>>
>>>>>>
>>>>>>
>>>>>> Please let us know if there is anything else needed to get this accepted. Happy to address any feedback.
>>>>>>
>>>>>
>>>>> I am sure I commented on this before. The fact that the Lenovo SE10 uses an
>>>>> ITE 5632 controller is completely irrelevant. Lenovo could decide tomorrow to
>>>>> replace the ITE chip with a Nuvoton chip, use the same API to talk with it,
>>>>> and the watchdog would work perfectly fine.
>>>>>
>>>>> This is a driver for the watchdog implemented in the embedded controller
>>>>> on Lenovo SE10. It is not a watchdog driver for ITE5632. Again, the EC chip
>>>>> used in that Lenovo system is completely irrelevant, even more so since
>>>>> this seems to be one of those undocumented ITE chips which officially
>>>>> don't even exist. Claiming that this would be a watchdog driver for ITE5632
>>>>> would be not only misleading but simply wrong.
>>>>>
>>>>> It seems that we can not agree on this. That means that, from my perspective,
>>>>> there is no real path to move forward. Wim will have to decide if and how
>>>>> to proceed.
>>>>>
>>>> My apologies - I hadn't realised that was the issue (my fault for missing it). Appreciate the clarification.
>>>>
>>>> Is this as simple as renaming this driver as (for example) a lenovo_se_wdt device, and adding in the appropriate checking during the init that it is only used on Lenovo SE10 platforms?
>>>>
>>>
>>> There would have to be additional changes. For example, the driver does not
>>> return errors if its wait loops time out, and it doesn't reserve the IO address
>>> range used by the chip. Tying the wait time to the number of wait loops
>>> and not to the elapsed time is also something that would need to be explained.
>>>
>> Ack - we can look at those. Thanks for the feedback.
>> 
>>> Also, I notice that the communication is similar to the communication with
>>> Super-IO chips from ITE, but not the same. Specifically, the unlock key is
>>> the same, but the lock key is different. This means that the code may unlock
>>> other chips from ITE in a given system, but not lock them. Some of those chips
>>> are ... let's call it less then perfect. They will act oddly on the bus if left
>>> unlocked. Some of those chips will act oddly if an attempt is made to lock them
>>> after unlocking them, and they have to remain unlocked to avoid corrupting
>>> communication with other chips on the same bus. The impact on other chips
>>> from the same vendor will have to be explored further.
>> 
>> Afraid I'm still missing something here. If we make it so this driver is only used on the SE10 platform, then does that remove the concern? At that point it's specific to that HW platform and no HW changes are planned.
>
> Yes.
>
>> Agreed that having this available generically is not a good idea.
>> 
>>>
>>>> I don't understand the concern if a different chip was used - wouldn't that need a different driver at that point?
>>>>
>>>
>>> Why would that be the case ?
>>>
>>> Maybe I am missing something essential. If you insist to tie this driver to the
>>> ITE5632 and not to the system, you will have to provide additional information.
>> 
>> I'm in agreement we should tie this to the platform - we'll make that change. No insistence implied :)
>> 
>>> The chip does not even exist in public, so no one but you and ITE really knows
>>> what its capabilities are. Is this is a chip which is used, or is going to be
>>> used, in a variety of systems, possibly including systems from other vendors ?
>>> Is the communication between main CPU and the chip tied to the chip and will/may
>>> only be used with this chip or variants of it ? Is the ITE5632 a SuperIO-like
>>> chip with fixed capabilities, or is it a programmed micro-controller ?
>>>
>> 
>> Afraid I don't understand the point about the chip not existing in public - do you just mean publicly available datasheets? At the risk of being repetitive, if this driver is locked to the Lenovo SE10 platform does that address the concerns?
>> 
>
> Just try to find information about this chip anywhere. The only 
> evidence that the
> chip even exists appears to be this submission.
>
>>> To a large degree all that is due to ITE and its customers not
>>> providing information
>>> about their chips to the public. Due to that lack of information, my
>>> assumption was
>>> that it is a programmed micro-controller. The code itself suggests,
>>> through the
>>> use of the term "EC" in the driver, that it is an embedded controller,
>>> not a Suoer-IO
>>> or other fixed-capability chip. If that is not the case, and if the
>>> communication
>>> with the chip is fixed and not programmable, you'll have to explain
>>> that.
>> 
>> Yeah, ack to that - and in that's something we need to address going forward in contracts we set for platforms that will have Linux support. I can't change what has already been done I'm afraid. We do have access, under NDA, to more details - but we're also limited in what we can disclose.
>> I need to go look at the details for this again, with David, and see what we can do to address any questions; but there are going to be some limits I'm afraid and I'm hoping they aren't blockers.
>
> I can't say that I am surprised. It is quite common for chips from ITE.
> Most of them seem to be custom builds made for specific customers/boards,
> with little if any information available. People providing tools for Windows
> can often sign NDAs with board vendors to get the information they need to
> implement support in those tools. Unfortunately that isn't an option for
> Linux kernel maintainers.
>
>> The aim is to get a driver working for this platform in shape enough to get accepted upstream and be useful.
>> 
>>>
>>> If it is an EC, the protocol is defined by its microcode, and the
>>> driver needs
>>> to be tied to the systems using that microcode. If it is a
>>> fixed-capability chip,
>>> the driver should not suggest that it communicates with an embedded
>>> controller
>>> but with a fixed-capability chip.
>>>
>> 
>> OK - we may also have used some incorrect terminology inadvertently, so I don't want to jump to too many conclusions. Will look into this.
>> 
>> Thanks for the detailed notes - we weren't sure what had been missing from the driver since the last submission so it's helpful to know where improvements are needed.
>> Appreciate the patience as this is a learning experience for us for this kernel sub-tree.
>> 
> And I still have no idea if this an EC or not ;-). My best guess would
> be that it is an NDS32 based micro-controller, related to IT5671.
>
> Of course, the next question would be if this chip has additional
> functionality, such as hardware monitoring. I guess I'll see that
> when I get a patch introducing its hwmon driver.
>
We believe it is only providing watchdog functionality, but we're double checking with the HW team to be sure.

Afraid I don't have the details on what it is based on to be able to answer that.

Mark

