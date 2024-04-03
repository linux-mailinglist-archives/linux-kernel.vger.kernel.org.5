Return-Path: <linux-kernel+bounces-129924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B31897215
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E328BBDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D5148FFA;
	Wed,  3 Apr 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="0Sj6qoBQ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B75148305;
	Wed,  3 Apr 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153631; cv=none; b=IkkPBy+yrJrzlbellUXLoLcTaCTXEgwqZV7p2/H42M/ciVzXwdAKxWOnKhEv7GGhIzqSVGL1dYbER0HsH5Kvmvh4LdvQOZrdZ4c4vmZ2ih7DIdQLDZXGaWWCJkbBOFOYrYUqn6tvZTJrnpQNJ4vyplKhpdbSgckE7yBc6gz/hXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153631; c=relaxed/simple;
	bh=zKJFrGdF2qGu/n2TGV0fUv9CKDKnucQKcYZzpUFutVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWJ3Y/CZHEGpKF2lt1Sjn3yEa59P6V/6LIyl7au5iPm5E23DDhGODs78ovsZNcP6iVT1ZpKrga1rsc+BZEDaa77Qz7TibA0uSBwTIIe39Wdf9BxlHAjnxYeWF/DAYTVGVWDyRNfjnJVaRcdRzK7g37aUlM0/fOmiQCaU08HySYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=0Sj6qoBQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nrj3sfqjkQRn9Dtg6zXtP8OAsYxyZsPOu98C70VK54Q=; t=1712153629;
	x=1712585629; b=0Sj6qoBQ/UIB2/84y+YPnAQHbh38+8O0FQ3yfMeM749+EGkveeuUMHQ+nji/u
	KuAuq9t+xYwKTn74KpzBxmF+wKdXsYU0RrcJicZYXjpDK/IGr4ZDewACCAdnFT9ggPhFxqsBMK1Qe
	2vn8iESS6RQV7ddn5ARHJtFCkNDTH2IGFOlXlA2ELpVWp3xNyxcPppGZro9xl42wbmGtgpCGv3nP7
	ydlCfPeLi4Nei26BHLQoZisd4Kaq/yR0DIx7K+y5n++w4F+dL6MCK3jzrd3tcpKnE9D1t1IXFtvD7
	mbhjNBFBIlJhoiy/xNNLlqtcwNZdlewNi7QxEgmdYAFScKtLlA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rs1N0-0008G8-4I; Wed, 03 Apr 2024 16:13:42 +0200
Message-ID: <a625f197-79b6-4e01-845c-0af024de8f7b@leemhuis.info>
Date: Wed, 3 Apr 2024 16:13:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: handling-regressions.rst: clarify that
 "Closes:" tags work too
To: Karel Balej <balejk@matfyz.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
References: <20240328194342.11760-1-balejk@matfyz.cz>
 <20240328194342.11760-3-balejk@matfyz.cz>
 <dfa22ac1-36e9-48da-a2a8-8d7818c09187@leemhuis.info>
 <b3b37454-df45-4826-ac5a-85c687f99d20@infradead.org>
 <5ea364e9-8a7d-4239-bf3b-1f4ae13f311b@leemhuis.info>
 <D09K2WCTEKK9.2NJ2C8NVQXZ6D@matfyz.cz>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <D09K2WCTEKK9.2NJ2C8NVQXZ6D@matfyz.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712153629;2745acc8;
X-HE-SMSGID: 1rs1N0-0008G8-4I

On 02.04.24 12:13, Karel Balej wrote:
> thank you very much for your feedback.

yw!

> Thorsten Leemhuis, 2024-04-02T11:27:57+02:00:
>> On 01.04.24 17:19, Randy Dunlap wrote:
>>> On 4/1/24 1:38 AM, Thorsten Leemhuis wrote:
>>>> On 28.03.24 20:29, Karel Balej wrote:
>>>>> The regressions handling manual claims that regzbot associates patches
>>>>> fixing an issue with the report based on the occurrence of the
>>>>> appropriate "Link:" trailers. It reasons that this does not add any
>>>>> burden on the maintainers/bug fix authors as this is already mandated by
>>>>> the "Submitting patches" guide. In fact however, the guide encourages
>>>>> using "Link:" tags for related discussions or issues which the patch
>>>>> fixes only partially, recommending "Closes:" for full resolutions.
>>>>>
>>>>> Despite it not being mentioned anywhere in the "Handling regressions"
>>>>> guide, regzbot does in fact take the "Closes:" tags into account and
>>>>> seems to in fact treat them fully equivalently to "Link:" tags.
>>>>>
>>>>> Clarify this in the regressions handling guide by always mentioning both
>>>>> of the tags.
>>>>
>>>> Many thx for this and the other patch. I had planned to do something
>>>> like this myself, but never got around to.
>>>>
>>>> There is just one thing that makes me slightly unhappy: this tells
>>>> readers that they can use both, but leaves the question "what's the
>>>> difference" respectively "in which situation should I use one or the
>>>> other" unanswered.
> 
> I see your point and I agree. I have perceived something similar when
> editing the document: I wondered whether it's really good to *always*
> spell out both variants or whether it would perhaps be enough in some
> places only.
> 
> I think the way that I ultimately did it counts on the reader being
> familiar with the "Submitting patches" document and knowing the "true"
> meanings of both Closes: and Link: and when to use each. So my goal was
> only to mention it because the way it was written seemed to almost imply
> to me that Closes: does *not* work and is thus not recommended which
> seemed in conflict with the "Submitting patch" guide, which was even
> more confusing since it literally referred to it.
> 
> In other words, it wasn't actually my goal to answer that question you
> pose, because that is already answered in the other document.

Yeah, but documents ideally should work on their own, so offering two
solutions without at least hinting at the differences is not ideal.

> I also didn't want to be too drastic with the changes because the
> prevalence of Link: seemed so strong that I thought that I must be
> missing something and that you have a good reason to write it like this.

Just history: when that document was written we didn't have a "Closes"
tag yet.

> So I wanted to stay safe :-)

:-)

> Anyway, if you are OK with that, I can definitely change it to Closes:
> everywhere and only mention Link: marginally, saying that it works too
> and explaining the difference while referring the reader to "Submitting
> patches" for more information (not that there would be too much more on
> this subject).

Yeah. Maybe just write something along the lines of "using a 'Link:' tag
instead  works for now as well, as some subsystems prefer it over the
younger 'Closes:' tag" somewhere -- while using Closes: everywhere else.

> Of course I wouldn't want to for example delay you so if you get around
> to it sooner than I will then feel free to make the changes either as a
> modification of this patch or just on its own.

I doubt that will happen.

> Perhaps you could take the first patch already if you have no
> reservations there and I will then just send v2 of this one?

I'll send a reviewed-by for that, but I guess Jonathan will take that
for the next merge window anyway. So there is still some time to prepare
a updated series with both changes. And if time is running out, we can
still ask Jonathan to pick up the first patch.

>>>> I also find the patch description a bit verbose; and it would be
>>>> good to turn the text upside down: first outline what the patch,
>>>> then maybe describe the "why".
> 
> I actually probably like it more this way. After all, the outline (or
> "what") is the patch subject, everything that comes after it in the body
> is usually meant to explain "why". But sure, I can swap it if you want
> :-)

Well, imagine you have to read 25 shorts text that each explain the
"why" first and then the "what" while you only care about one certain
change. Then your preferred approach quickly becomes annoying, because
you have to read a lot of "why" for every patch before you can decide if
you actually care about it.

> As for the verbosity, I will keep it in mind when working on v2,
> although I also generally don't consider verbosity a bad thing. I might
> have been too verbose, though, because as I have mentioned, I was
> confused why it isn't like this already and wanted to offer my full
> reasoning so that I could be shown where I err :-)

:-)

> One more thing that I wanted but ultimately forgot to mention in the
> cover letter: thank you very much for writing these guides in the first
> place, I find them very instructive and useful.

Thx for saying that, I often wonder if they are really worth the trouble...

Ciao, Thosten

