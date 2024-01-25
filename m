Return-Path: <linux-kernel+bounces-38405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B8583BF15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919DB1F23D28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42F12C696;
	Thu, 25 Jan 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cylqpedh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cfd/GmCu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80632C684;
	Thu, 25 Jan 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179187; cv=none; b=hVXpr2OLCHSC0UJFpB/6pwhDhqtAaKqEosWJftYUoQ5wYEXSsdgCUf0P2TPl/9nfXRQZIy0ybyjsK/UPksSf6NdLg3olB6CG/1z2qLiPI6Bpn9TUlj4OTLKsmvlipyK4EjoZicWV7wniXsVy62wjiZXxIZYgZRZnZqmgGSHGOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179187; c=relaxed/simple;
	bh=Il7Se0v/oqXNI5U7CR1goWqSpyVYu+LQzeWBXvViFtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVQ0T3bT4tXQY1gvkQH2hD0aRJgyTOX6k5s3G8tWDd7xn04AfSioi38YxWxEzNeIJH29aaqOR1uKwt6qbAYffdBLmzx77DNlexPPPb5/I0dBz/KNRpk5T+4UcVuXBjwZNv+HMz3gIObiuQDwB/oqeCHtp0++E7A+VotEW4f5XXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cylqpedh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cfd/GmCu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706179182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XY1La2TGjSx9YGnqBSie++t7ZlT6vyosAqovaYlT9pU=;
	b=Cylqpedheoi8COcHwid53WW3dsgqXX3nqqgFkbRt/A9ERHDRmlz29OzVbrgwAEzI1f4VZ4
	zrr6/r1V/9Ft7TZ34NUgcGtmZ7k7a7AEVUrFcuou5hJR8p7Qqc0lGCB7p87FyusShXDLSM
	U6a1X1KVRjnMCmMr+PvEPRcWuaN9WusMR3DV/LpGeSHUzqUDcJr8S57maaxRuDFb2L3UZK
	I3iXQC0AuYLJoM5loJLK6bagc9DVxfFKOBcmbwiEzrLwIXzFVJHJFk2JT0y4idtGR3tt9p
	b5Mvcfq10tIUob0UzpyDaoHRrYEHfkTcZDpWH9X65PtLVg0muKKNIv3LT4rLtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706179182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XY1La2TGjSx9YGnqBSie++t7ZlT6vyosAqovaYlT9pU=;
	b=Cfd/GmCuHjsm1AfzAlDhqw1iOehPV12GL5qO2VlI6lptNz2Hp5FfjOTxEqx+Ju4ie+UVuR
	0BgmQZ5zIrx/DEBg==
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
Date: Thu, 25 Jan 2024 11:39:42 +0100
Message-ID: <87o7d9d7dd.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> On 1/23/24 08:47, Anna-Maria Behnsen wrote:
>> The structure of documentation changed. There is 'core-api' where also
>> timer related documentation belongs to. But the timer related documentation
>> (doesn't matter whether it is up to date or outdated) is still located in a
>> separate folder with no relation to core-api.
>> 
>> Create a new folder which is located below core-api and make it the new
>> place for all timer related documentation. Instead of revisiting all files
>> below the already existing timer folder right now, add a warning banner to
>> the top of all those files. When it is ensured the content is up to date,
>> they can be moved to the final destination.
>> 
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> ---
>>  Documentation/core-api/index.rst        |  1 +
>>  Documentation/core-api/timers/index.rst | 22 ++++++++++++++++++++++
>>  Documentation/timers/highres.rst        |  5 +++++
>>  Documentation/timers/hpet.rst           |  5 +++++
>>  Documentation/timers/hrtimers.rst       |  5 +++++
>>  Documentation/timers/index.rst          |  5 +++++
>>  Documentation/timers/no_hz.rst          |  4 ++++
>>  Documentation/timers/timekeeping.rst    |  5 +++++
>>  Documentation/timers/timers-howto.rst   |  5 +++++
>
> When can we remove the old, "might be outdated" files?
> Do you think that some of their contents might be valuable to someone?
>
> I prefer not to have the old documentation and the new.
>

This is also nothing I prefere for a final solution. But I got stucked
when I was looking for a way to add the actual documentation because I
wanted to add it into a cleaned-up environment. But I don't have the
possibility at the moment to cleanup the existing timer documentation
right away with all its aspects (content, formatting, referencing,
location below Documentation,... ).

So I had those options:

1. wait until I have time for all this before publishing the new
   documentation -> not an option because I don't know when there is
   time to do all those things in one go

2. Put the new documentation below the existing one and ignore the rest
   silently (maybe someone else will clean it up someday) -> not an
   option because it suggests that the new documentation structure is
   just ignored

3. Just move the old documentation without revisiting it -> not an
   option because there might be outdated information and then it
   doesn't has a benefit for the reader

4. Add a warning banner at the existing documentation and prepare
   everything to get the timer documentation to the proper place and
   create a place for timer documentation below the current structure.

The benefit of 4. for me is, that there is this warning banner at the
top. So this suggests the reader, that this has to be revisited before
relying on it for 100%. This banner might also remind the original
author/technically deep involved developer that this should be
updated.

If there is a better way to go, please let me know!

Thanks,

        Anna-Maria


