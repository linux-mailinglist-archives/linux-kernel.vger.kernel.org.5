Return-Path: <linux-kernel+bounces-92428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5817C872005
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C395D1F224AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CA185C52;
	Tue,  5 Mar 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="n+oNEcpr"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268665A7A4;
	Tue,  5 Mar 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645025; cv=none; b=V2ynJwArTJLV0owLzD5SCvVzc11YSZmHELYrBr+Fd1K7TCzjasoPDSI+4M6rA4G7awa7jx7uhWmmOafzyvcCnU95bDXruIuYBEsb/Gd0ojEZ2WwlzdARvgQMyRfZexW79jQTTLVPqzkNlKTpVfs0AqkYP4VH9QD/VHVufUQTKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645025; c=relaxed/simple;
	bh=NSn3fjj7cZhdRvPGCd66wr3eOuzKXKPPeUoqCE4yTi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ0X6YPlEVy33ZMqbt4Yb/3uUBu5iQCwJJCt7Cjh1nJSijgbco1brGPWfhIDSLkXXK/rcqvM1mKZBzxg9A5en8uYcUr81KsJJcGbsp12L89cqAUDF2ARuq/UCq4G6j4i5/NAXEYd/Hbv0QLvWJ0VbtrScy92q5Zzjo3C702xpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=n+oNEcpr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=R8G11MBkvhlXCVhZnnXEF3NYg8qRglIYPfW64j0+IFs=; t=1709645023;
	x=1710077023; b=n+oNEcprrzj5xwS3oJtdE/0Sl9xDGDu34mTMPLxl2fWA8fDdkO/Fr8G0dQ2U8
	D83rD47V7qlez8LP1M3vZHUCMGX7I9C1AwRjcDLlzwoWDTItpaCwzCtHIXAfM+s9uu4o3OKoId1PH
	x6oW8uQ4BgBV89nM7HF9aDt2xuGdP6vjURcYBS3iazXNdUAC89NOrIJsVTXNGyIIx2fOdwqcRb74t
	jTfIEQiT3EUYLaOx0vBux4Fo+r7UKTSov11raGQs1CItWccQqpHMl+e6NcWsxbk0WWzc0kc5txoS7
	e3TYfDvjB5qLmNaKoGqFasVqp2vwuxY4hzv4EtuzKmq3mM3ZnA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhUlf-00081c-Ei; Tue, 05 Mar 2024 14:23:39 +0100
Message-ID: <3d40b22d-2cc0-4c34-b8af-e9c84042dd12@leemhuis.info>
Date: Tue, 5 Mar 2024 14:23:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Towards a re-organized submitting patches
Content-Language: en-US, de-DE
To: Jonathan Corbet <corbet@lwn.net>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
 <87plwbxon7.fsf@meer.lwn.net>
 <57b07ec5-586a-46e6-9ba2-26be2372c1c2@leemhuis.info>
 <87edcorg06.fsf@meer.lwn.net>
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <87edcorg06.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1709645023;1a982acb;
X-HE-SMSGID: 1rhUlf-00081c-Ei

On 05.03.24 13:59, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
>> On 03.03.24 17:31, Jonathan Corbet wrote:
>>> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>>>> I wanted to clean up the development-process documentation. There is
>>>> however no easy way to break the ice here:
>>>>
>>>> The elephant in the room is that there is some unclear relation between
>>>> 5.Posting.rst, 6.Followthrough.rst and submitting-patches.rst.
>>>> (Yes, I know each document has its own history...; but let us put the
>>>> history aside for now.)
>>>
>>> FWIW, the objective of those two documents is quite different; one is a
>>> high-level overview of how the development process as a whole works, the
>>> other is a detailed guide to submitting work for consideration.
>>
>> Sorry, I'm slightly confused here, so I have to ask: which is which?
>>
>> Due to the "*essential*" in the headline of submitting-patches.rst and
>> its "For *detailed* information on how the kernel development process
>> works, see Documentation/process/development-process.rst" in the intro
>> make it sounds to me like submitting-patches.rst should be the one with
>> the high-level overview. But...
>>
>>> Again, let's remember the different purposes of these documents.  The
>>> development-process document is an overall description of the process,
>>> so it doesn't need the details.
>>
>> ...this makes it sounds like you consider it the other way around. And
>> for me that feels the wrong, as why describe the overall process in
>> detail, but leave the most important part of the process to some other
>> document?
>>
>> /me wonders what he is missing
> 
> The series of files starting with Documentation/process/1.Intro.rst was
> meant to describe the whole of the development process to a wider
> audience; I originally wrote it as a project for the Linux Foundation.
> It covers far more than the business of putting up patches for
> consideration - development cycles and all that.
> 
> submitting-patches.rst, instead, covers the details of getting code
> considered for merging; it is intended to be read by the people actually
> trying to do that work.
> 
> One document describes what the pieces of the car are and how they work
> together to get you to the pub.  The other gives all of the steps for
> working on the brakes without causing accidents.  They both fit as part
> of a larger body of documentation, but they are definitely not the same
> document.

Thx for the clarification. And of course both fit in a larger body. It
seems some of the word used in the intros of both documents made me
assume it was the other way around at some point in the past and then it
stuck. Wondering if that's just me or if that happened to others as
well. Whatever, if Lukas will realize his plans I guess the different
target audiences will become more obvious over time.

Thx again! Ciao, Thorsten

