Return-Path: <linux-kernel+bounces-79372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0D86214B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301FA1F25E05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFB17C9;
	Sat, 24 Feb 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="iSoXZxje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hf/nqDL6"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAF139D;
	Sat, 24 Feb 2024 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735432; cv=none; b=ELGqf+pZVpKEF4axPW0wrgUQDPJSM/76+DzkKPklziI4mvZFVTZPOJy75vKcWiy0EOAQNmZvo2cBgG/OHWZidK8pvdkGmZfLCJibZN/4rL4eNcG4D1CtJDznJDAeZpuyG5exbo04t0mPTHSdoBzAVtBSi3uYFTn+0J2E+Z4dPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735432; c=relaxed/simple;
	bh=aHe/z2RQP8KthhPa74vKrrkE3v1GYWNO/gq7pW9BWAE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HeNU5OgDHMAiqYmf0y1s40r3XZ/CW6b/R7giw+ZpfF3+6hTWyEdkNnQI3YTZHbLo+OCJHBuFjNIxSclV8kKRNxrRYVdR6caELoIwS7fLRUeY2qkwA0gSlu6qaSTrhQ0c3U9Dgc2TrMGMnCdYFtGlHA6kITv6Fqy2NBS4pU2Mcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=iSoXZxje; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hf/nqDL6; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 683093200A00;
	Fri, 23 Feb 2024 19:43:48 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 23 Feb 2024 19:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1708735427; x=1708821827; bh=HuXJ6x1LTn
	c+2ceV2FyaIIS3r2dfwL/DtfsGQmv8C0M=; b=iSoXZxjeYvh42TZwU58FQOhpas
	G0A3uBL0ydUdbY2GOLKxLX0sNT4Uo78nbDKoYj7IQnXUq0kl0SC7ZyJU1+laFFaO
	/Z19GnkhO3AvetJsUvcpKozQTQGgwydBna7sYARhPG8Mcoj5Ayb2MWTgs4tHCqEM
	+JNdR4auvR8ZUcZfumPsjrlQbk62pW9KEg1e8sllE4pPYWgw6Krf1BwwGhx0NFkk
	fWROG7lx3+50gKfKnJMhrgW/ccunhxKrbArh6+hFY44N/+Aw21Awn+SadOVbXTvt
	4gnyhzjMWFbpoSremRAsgzkWLj3u1E6r47kvX2KRgnmN8vwyZRRjNZRKjfRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708735427; x=1708821827; bh=HuXJ6x1LTnc+2ceV2FyaIIS3r2df
	wL/DtfsGQmv8C0M=; b=Hf/nqDL6xfO3XFk/nby17+UyncTCv5tChLdt9OYX6sw7
	bXoSe3aRzbemwpCq4MhPf6RSdQ9MmoMR9cm49pMLP/ZpsVxFkR/xXUy/Vd6diaxS
	3u5TkR6tJrokz90GG4Q5JrlJbU+tYNnkDwomz8+b2f068vUNUn0pQQ32WEyvABUA
	Bt6VvI7qjaGpISbMxBPveA9xi3Sj7OCL3WduRxmm3oX0270xTS+30HN5KC6dro8/
	+d0SAp0iO/tl941v8TSH37M0U9OS0N9VwjVM25LKmHw4T8F+MbMtt4QA5qg67z72
	evoHnetBJtssofx1ZV/DTqcnGusGB2OsPD9y//VGOA==
X-ME-Sender: <xms:wzvZZZbTydxOIXy-icSy8FkXytjqZ1tcokugEMzA7sIz3oGPsSxIeQ>
    <xme:wzvZZQb3RcDJOe0pb3SaQ3oAfXD7leHT9KegjU-wOlzcAXWxDTL2s71CCcRL_4_RU
    e7h24eGwmdGgsqjygg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeejgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdforghr
    khcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnsehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeuvefftdefjeevveejheehhfevfeelffehfefgheffjeetvddvhfdu
    ffegheefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:wzvZZb_poZ6k8Zpnk98vYp5lD8cnH1gscm3y6Mw1C1iQojp0hRvjhQ>
    <xmx:wzvZZXqM6WWxivVGGTIa1APK-vd7_LSMJVaT19ZyuAw7tQcrfDNk9w>
    <xmx:wzvZZUowYsG0wABCB3SlAnR7r9I_mhhdxM2PGxmMhORzH7yEX-2KgA>
    <xmx:wzvZZfWzzfVHbu2gNm8cPJDM5DlVTXmoDn52NLqOpSL0iX03neuekw>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 67A1DC60097; Fri, 23 Feb 2024 19:43:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4209014c-1730-4c31-87d8-4192d68bcbc6@app.fastmail.com>
In-Reply-To: <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
References: <20230721122931.505957-1-dober6023@gmail.com>
 <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
 <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
Date: Fri, 23 Feb 2024 19:43:17 -0500
From: "Mark Pearson" <mpearson@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>, "David Ober" <dober6023@gmail.com>,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Type: text/plain

Thanks Guenter

On Fri, Feb 23, 2024, at 3:21 PM, Guenter Roeck wrote:
> On 2/23/24 11:58, Mark Pearson wrote:
>> On Fri, Jul 21, 2023, at 8:29 AM, David Ober wrote:
>>> This modules is to allow for the new ITE 5632 EC chip
>>> to support the watchdog for initial use in the Lenovo SE10
>>>
>>> Signed-off-by: David Ober <dober6023@gmail.com>
>>>
>>> V2 Fix stop to deactivate wdog on unload of module
>>> V2 Remove extra logging that is not needed
>>> V2 change udelays to usleep_range
>>> V2 Changed to now request region on start and release on stop instead
>>>     of for every ping and read/write
>>> V3 add counter to while loops so it will not hang
>>> V3 rework code to use platform_device_register_simple
>>> V3 rework getting the Chip ID to remove duplicate code and close IO
>>> V3 change some extra logging to be debug only
>>> ---
> [ ... ]
>>> +config ITE5632_WDT
>>> +        tristate "ITE 5632"
>>> +        select WATCHDOG_CORE
>>> +        help
>>> +          If you say yes here you get support for the watchdog
>>> +          functionality of the ITE 5632 eSIO chip.
>>> +
>>> +          This driver can also be built as a module. If so, the module
>>> +          will be called ite5632_wdt.
>>> +
>
> [ ... ]
>
>>
>> 
>> Please let us know if there is anything else needed to get this accepted. Happy to address any feedback.
>> 
>
> I am sure I commented on this before. The fact that the Lenovo SE10 uses an
> ITE 5632 controller is completely irrelevant. Lenovo could decide tomorrow to
> replace the ITE chip with a Nuvoton chip, use the same API to talk with it,
> and the watchdog would work perfectly fine.
>
> This is a driver for the watchdog implemented in the embedded controller
> on Lenovo SE10. It is not a watchdog driver for ITE5632. Again, the EC chip
> used in that Lenovo system is completely irrelevant, even more so since
> this seems to be one of those undocumented ITE chips which officially
> don't even exist. Claiming that this would be a watchdog driver for ITE5632
> would be not only misleading but simply wrong.
>
> It seems that we can not agree on this. That means that, from my perspective,
> there is no real path to move forward. Wim will have to decide if and how
> to proceed.
>
My apologies - I hadn't realised that was the issue (my fault for missing it). Appreciate the clarification.

Is this as simple as renaming this driver as (for example) a lenovo_se_wdt device, and adding in the appropriate checking during the init that it is only used on Lenovo SE10 platforms?

I don't understand the concern if a different chip was used - wouldn't that need a different driver at that point?

If it's more subtle than that, is there something you propose instead?

Thanks
Mark


