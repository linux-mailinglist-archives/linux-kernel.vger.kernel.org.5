Return-Path: <linux-kernel+bounces-127632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2625894EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373B0281DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730658207;
	Tue,  2 Apr 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IJ6mmUkL"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD21E525;
	Tue,  2 Apr 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050090; cv=none; b=Dm9CCef0JY+GujxhyQUv1WiQlyRcz6heWrpiU+jmm64t3zBtJcJS2zdFC5S47FYp88+2h8vzFOMrVBm2BIXHMikYTKp5f4J7MXD/b+cbr5liWtcUeRfOOqE6JYtGfavrvtuTYOSejVEsIDAodqr77LR+I9WNo/rG1WgzcJno9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050090; c=relaxed/simple;
	bh=FbPLe7V7K5eiJlYqWL110p9H9wbc9kXV+qhEMNz/3YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JQOBSG8TmWQqYqlmEZs+cOaMAZ5EgMiM23iS9lPvO4qpkpmrW9zDatjEd4yflAbJsEreV18UsgjwUZy6Km4auunXCJDU3ixY+0M4mczzj3jQbh+pT8VV1lwrWJmbhuxT2pJH7rc114kkeNmKdJDmmYk5yK+K1b8ExLRTBQrh8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IJ6mmUkL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Ta7ZEK0rmgLi5O4VE/68X27Ju/Jnf5hCRpkNmYKlBoc=; t=1712050088;
	x=1712482088; b=IJ6mmUkLPZLJnDXIaXLi5/9pJp1RXFVoZK3B6cCHuD9njay0VS2nQ+0iBCs7a
	0P9W7nt4oy/OIL4IOhBY+G9uICDxAjjiU19FeWSlv2CqvLnLn8LaRpqQOeamHhhqirbq2JgPvJ6zC
	SfXHgygx51T9ZVL52fptqhUA/NwEuNXqABs84+VwUl+bdYDS0OH7J1iooHLos41BZPEhwArU8HKSf
	WNUpmIhlA+FEW88YHmTS68i9o2maousDqjL7NsOMK1OsncaQYnkn2nkyUrFBiu6OrAPBs20RZfanC
	hlIFxWKKF8R6OqTAF4+LveI8qGH3JGkobhdzjSi3jcnUT8SHXQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rraQv-0007q5-Pe; Tue, 02 Apr 2024 11:27:57 +0200
Message-ID: <5ea364e9-8a7d-4239-bf3b-1f4ae13f311b@leemhuis.info>
Date: Tue, 2 Apr 2024 11:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: handling-regressions.rst: clarify that
 "Closes:" tags work too
To: Randy Dunlap <rdunlap@infradead.org>, Karel Balej <balejk@matfyz.cz>,
 Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20240328194342.11760-1-balejk@matfyz.cz>
 <20240328194342.11760-3-balejk@matfyz.cz>
 <dfa22ac1-36e9-48da-a2a8-8d7818c09187@leemhuis.info>
 <b3b37454-df45-4826-ac5a-85c687f99d20@infradead.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <b3b37454-df45-4826-ac5a-85c687f99d20@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712050088;09f639c6;
X-HE-SMSGID: 1rraQv-0007q5-Pe

On 01.04.24 17:19, Randy Dunlap wrote:
> On 4/1/24 1:38 AM, Thorsten Leemhuis wrote:
>> On 28.03.24 20:29, Karel Balej wrote:
>>> The regressions handling manual claims that regzbot associates patches
>>> fixing an issue with the report based on the occurrence of the
>>> appropriate "Link:" trailers. It reasons that this does not add any
>>> burden on the maintainers/bug fix authors as this is already mandated by
>>> the "Submitting patches" guide. In fact however, the guide encourages
>>> using "Link:" tags for related discussions or issues which the patch
>>> fixes only partially, recommending "Closes:" for full resolutions.
>>>
>>> Despite it not being mentioned anywhere in the "Handling regressions"
>>> guide, regzbot does in fact take the "Closes:" tags into account and
>>> seems to in fact treat them fully equivalently to "Link:" tags.
>>>
>>> Clarify this in the regressions handling guide by always mentioning both
>>> of the tags.
>>
>> Many thx for this and the other patch. I had planned to do something
>> like this myself, but never got around to.
>>
>> There is just one thing that makes me slightly unhappy: this tells
>> readers that they can use both, but leaves the question "what's the
>> difference" respectively "in which situation should I use one or the
>> other" unanswered.
>>
>> To answer that question: in a ideal world developers would use "Closes:"
>> when a change resolves an issue, and "Link" when it's somehow related to
>> a report, but not resolving the problem.
> 
> I use Link: when I fix only part of an LKP report and Closes: when I fix
> all of one.

Yup.

>> But we don't live in that world and I wonder if we ever reach that point
>> where regzbot could act accordingly. Nevertheless I'd say it would be
>> wise to write the docs towards that ideal world. E.g.: tell developers
>> to uses 'Closes:', but in some places briefly hint that "'Link:' works
>> for now, too".
> 
> I don't see Link: going away any time in the "near" future.

Sure, I didn't mean to imply that! Just in the scope of the document and
the sections where the tag is mentioned I think (but it would be good to
recheck) it's always about a "resolving a reported regression", so
Closes there makes more sense. But yeah, might be wise to spell that all
out.

Karel: if I'm asking too much here, I could pick up your patches and
improve upon them to handle this. Or we simply wait until two other
regzbot features are in place, then I could fix this as part of some
other changes.

>> I also find the patch description a bit verbose; and it would be good to
>> turn the text upside down: first outline what the patch, then maybe
>> describe the "why".
> It's almost amusing that you find something verbose.  ;)

:-D

I often wonder what the main reason for that verbosity it. That I used
to write for a mainstream computer magazine? Or that English is a second
language to me? Whatever.

Ciao, Thorsten

