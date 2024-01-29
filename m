Return-Path: <linux-kernel+bounces-42784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E38128406B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD14B25023
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD763135;
	Mon, 29 Jan 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtws33Mh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQjETdD5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77B63112;
	Mon, 29 Jan 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534502; cv=none; b=l8BdB1FaNaD5FJ6Ego7NvRBwtzmyKRSRzjlv/wyB4APTc0sUAVXejK4VjhjzRcqzpPNwlIKU4EnTrPXG6fRV+8X3VxS9PVgXXw0Zn9ZPAZXxVWRP1B8O6f7ujoAE+Cd+EBKIM8i/eUNthE5B9CoVWAF4tYJavbIjIm6vqzWDTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534502; c=relaxed/simple;
	bh=0pEULVPu+zWIBMmD1eo1hQ+2bfOBZ18qqMqydR+ghZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FudQRzvLRhGNyHXdD2pII9p0faE5+hivNGF5pSVT3l++pIHUA4tSamJhO/v/yc44VmXV+ly9Eq5jTEU8wfldp2yifHII2IqxqomEBUBR6m0ywkGdP5gkD/5tX/+RcD65Worem81TeATlyv4LrEIC3dIOIuQxureVLMDTq+3rlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtws33Mh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQjETdD5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706534498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfVt3oAKgzDKkygtJtzkC8uaIqXYdsey9gM4hCAem3s=;
	b=vtws33MhW6tZCG4lyyRzPlAz/gB7PW7GbUoiFoxBuvXMVyiSuiap3mPHXrrmAm/Tk2BdXw
	JAX9e7egUaTh6qVvP+Gz8mblimlfeZWqp+9PchRq53VG2TtWv2SQrJM52Di8O4IO+Kd20e
	y1C/aHfM1IsGKCu1srQCAbgie1uW3g3LojKodSvbsu5WgDXZdUQ8EUJ52rWNm/jMCa2jAC
	cRSHUVltJT9sO/ZaOTtImyFm/xVtshECTnILL2gNDXTf9ntAlv+9PgxtDZ3aveeG6N06VL
	22pawZbAdSFOMsg5WKeXomsj2OTZrLdorXIVUItdxfrEZJ9b+amKaDIpD57cwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706534498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfVt3oAKgzDKkygtJtzkC8uaIqXYdsey9gM4hCAem3s=;
	b=ZQjETdD51Ax1BU5LMPzuXWWUNC7iOBDP+fNpQfuSe50INL4U9WTJLMGJNzMXyOWGS5LmeU
	rXMKWWcR8JRayiAg==
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <87r0i59ops.fsf@meer.lwn.net>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
 <87o7d9d7dd.fsf@somnus> <87plxpbgpz.fsf@meer.lwn.net>
 <87zfwtbbjd.fsf@somnus> <87r0i59ops.fsf@meer.lwn.net>
Date: Mon, 29 Jan 2024 14:21:38 +0100
Message-ID: <87plxkqnq5.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
>
>>> I've thought for a while that we should have a standard warning or two
>>> along these lines, like Wikipedia does, but of course haven't done
>>> anything about it.
>>>
>>
>> Sure, if we could standardize it, I would definitely prefere it! For me
>> as a not sphinx/rst/... expert, it would be great if only something like
>>
>> .. might_be_outdated:: <optional additional text>
>>
>> needs to be added to the code. And then the default lines would appear
>> together with the optional additional text.
>>
>> Is this what you have been thinking about?
>
> You've already put more thought into it than I have :)
>
> I was just thinking in terms of some relatively standard text.  I'd
> rather not create an extension just for this, but Jani's idea of using
> the todo extension could work, or just a convention like:
>
>   .. include crufty-stuff-note.rst
>
> might be good enough and not require an extension at all.

Maybe also a combination of both - using the todo extension inside the
include file?

I would integrate it into a v2, but I'm not sure, when I have time to
prepare it.

Thanks,

        Anna-Maria


