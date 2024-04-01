Return-Path: <linux-kernel+bounces-126790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ED4893CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202C9B219A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8974643A;
	Mon,  1 Apr 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j2L+IDWd"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F93FBBD;
	Mon,  1 Apr 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984766; cv=none; b=OdSey1+BGN6GMeTjeYF+LaedLyEK9QoU4GNRNpYAtgBXuKqPOZCC9eo7ZgH76DENVvMPtho8GvHUt5UT6W+5Of2kCFU9Dm6zUdKvF0BFTxOR46vYgUSvzJIribbYgIRJeGZTvDP7DA4sGP1dm4zR9HK6V6/3MD0JKboqp+spoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984766; c=relaxed/simple;
	bh=Mn1oI23NTg1AaPyrE/mNULagWOv/BYrH388SG9DOQ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mFPfcldQKcX+QLEVaPPG4QSByOWjVzq28SahAhaCIdwQQlWTEJ1XNk6C4HL2QW1doeMasyzEWYbZbIE4YqT6yAfWg2mT68v8v/dQS3Rg5AzMeCWXkNKn9uUFRidjRhe1EtfSYLbL8mkAuPfA+SCixuSVine026mIMeP1lCDZpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j2L+IDWd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=PhKhQVr7znpcbPo62k7GO48yiZBLMZxLiecMoLCt7H0=; b=j2L+IDWdbDjfujvsEsWML8vFZ6
	zbq6Ls9c9euevDYveD9NG+7LLKm7ZfwjqJpmtnRJZBsGFglBLjOX9pX4z9kXnGbC7jm4J+WCkq/bv
	azbYVH+XEEebbJ+pfcHZaBjGi4H5hkn6D4tKce7P/qMuyFObMoYJE4oBJgHkVDpimYS7e5pfqA4MO
	EG3a99Wq+EOizTudYSE7ewsJc3OGbIqF0y31Z/B2StM3uwm2jjdKi30GOWFXueFTxa9ezc9y1xUi4
	zeSetGH6ToX9LR71sSJURpblWy4rnJ4ZxapdKrp7bXwCk2oDjwYuNpBvZpvkfhXBI2sBhGUPLHWPw
	BdKDniwQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrJRQ-00000008A3d-42JM;
	Mon, 01 Apr 2024 15:19:21 +0000
Message-ID: <b3b37454-df45-4826-ac5a-85c687f99d20@infradead.org>
Date: Mon, 1 Apr 2024 08:19:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: handling-regressions.rst: clarify that
 "Closes:" tags work too
To: Thorsten Leemhuis <linux@leemhuis.info>, Karel Balej <balejk@matfyz.cz>,
 Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20240328194342.11760-1-balejk@matfyz.cz>
 <20240328194342.11760-3-balejk@matfyz.cz>
 <dfa22ac1-36e9-48da-a2a8-8d7818c09187@leemhuis.info>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <dfa22ac1-36e9-48da-a2a8-8d7818c09187@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/24 1:38 AM, Thorsten Leemhuis wrote:
> On 28.03.24 20:29, Karel Balej wrote:
>> The regressions handling manual claims that regzbot associates patches
>> fixing an issue with the report based on the occurrence of the
>> appropriate "Link:" trailers. It reasons that this does not add any
>> burden on the maintainers/bug fix authors as this is already mandated by
>> the "Submitting patches" guide. In fact however, the guide encourages
>> using "Link:" tags for related discussions or issues which the patch
>> fixes only partially, recommending "Closes:" for full resolutions.
>>
>> Despite it not being mentioned anywhere in the "Handling regressions"
>> guide, regzbot does in fact take the "Closes:" tags into account and
>> seems to in fact treat them fully equivalently to "Link:" tags.
>>
>> Clarify this in the regressions handling guide by always mentioning both
>> of the tags.
> 
> Many thx for this and the other patch. I had planned to do something
> like this myself, but never got around to.
> 
> There is just one thing that makes me slightly unhappy: this tells
> readers that they can use both, but leaves the question "what's the
> difference" respectively "in which situation should I use one or the
> other" unanswered.
> 
> To answer that question: in a ideal world developers would use "Closes:"
> when a change resolves an issue, and "Link" when it's somehow related to
> a report, but not resolving the problem.

I use Link: when I fix only part of an LKP report and Closes: when I fix
all of one.

> But we don't live in that world and I wonder if we ever reach that point
> where regzbot could act accordingly. Nevertheless I'd say it would be
> wise to write the docs towards that ideal world. E.g.: tell developers
> to uses 'Closes:', but in some places briefly hint that "'Link:' works
> for now, too".

I don't see Link: going away any time in the "near" future.

> I also find the patch description a bit verbose; and it would be good to
> turn the text upside down: first outline what the patch, then maybe
> describe the "why".

It's almost amusing that you find something verbose.  ;)

-- 
#Randy

