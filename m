Return-Path: <linux-kernel+bounces-143056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E15418A33A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD47B26064
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FF14A4EC;
	Fri, 12 Apr 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RlVELxdm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA514A4CE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938824; cv=none; b=Pi8bnrXx5UZwNEtcv00Uazm8Jya5KZRALC0pyboMLk3fpwY9RXPKK5MFNhD05jWCSawaXcHCl8cyKd3DS+aqMvjWDGblT50eKm6b2cNHCyYfIKY8QNpl7OQwajtPPvow2V7LirfFtCzkicYoaXDsz1Z3e71RBSMJQHjJMQ+kWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938824; c=relaxed/simple;
	bh=e5mYNY4DUllTjOI7Oiqn8SS/QG9UHp50BnW7WhVKxFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELMTnjf5oGF9j6M+APf+dr/x95i7ri+IUf98ftZ9n2RqaRPZ9c7lCMZfkG3iuzK+ui5g4jSGLsuod8Q8gL8N2mmg/w8ouC4/rsVABTOgsGOFkaOfcodPkvPX7ZkiOwCvnly6PknPe3E5zWH6xzqSSUfG8H8px4oXdM5ieDWvzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RlVELxdm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1lq0SFauIf5vQAWAnoHa3FcN9F5SmZ1FACZ36sCVz5Q=; b=RlVELxdmohqA/BsrX14Bnsezkb
	cW6dyR2a1/ZQ1Eb9MpwUbOFV1s+fxm7xqMbqjYU/TdH0F76dP3iDzY16kSaLPNawRtbJnsyJZU/bZ
	AtGlN4zkySPIyYfUem6+QAMJ16IoO70KB0/9BP074pEEe4VWOVMsrbr+TV+yCUAHEtu3IuHan1oP6
	9siff2+0OHdBS1s0AoSA6ZhzRB8OlRkcwVmWNNwpjrL4h8MvZMiriNUsnf7dbJLemZYvwq3qjkOwn
	xo98fs1E/QZz4ZuHa/5EVB3azKHLsFevD1oZTohysYZs9t9O34YyVPVwQrfyMet8o5M8h/q4ZqYau
	9JUbqxMw==;
Received: from [2603:3004:644:9100::3458]
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvJdM-00000009DKG-2DrY;
	Fri, 12 Apr 2024 16:20:13 +0000
Message-ID: <5ab77ba9-721a-413e-bb26-6c842679f61a@infradead.org>
Date: Fri, 12 Apr 2024 09:20:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Prasad Pandit <pjp@fedoraproject.org>, Yang Li <yang.lee@linux.alibaba.com>
References: <20240412103204.453d912c@gandalf.local.home>
 <CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
 <20240412121531.24669544@gandalf.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240412121531.24669544@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 9:15 AM, Steven Rostedt wrote:
> On Fri, 12 Apr 2024 09:07:18 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Fri, 12 Apr 2024 at 07:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> - Replace bad tab with space in Kconfig for FTRACE_RECORD_RECURSION_SIZE  
>>
>> Argh. What parser is this? We need to fix this craziness.

something that fedora cares about.
out-of-tree I expect.

>> Yes, yes, we have "tabs and spaces" issues due to the fundamental
>> brokenness of make, and we can't get rid of *that* bogosity.
>>
>> But for our own Kconfig files? Whitespace is whitespace (ignoring
>> crazy unicode extensions), we need to get away from "tabs and spaces
>> act differently".
> 
> Note, the tab is here:
> 
> -	default	128
> +	default 128
>                ^
> 
> That is, the tab was between "default" and "128".
> 
> I'm really agnostic to if we care about it, and was questioning about
> taking it or not. But, it looks to be a hidden tab in a weird location,
> so I took it.

Yes, I'm about the same. My comments were:

"""
> Fix FTRACE_RECORD_RECURSION_SIZE entry, replace tab with

replace the tab between "default" and "128" with a space

> a space character. It helps Kconfig parsers to read file
> without error.

Parsers should accept either tab or space but this is a
reasonable change.
"""

Guess I wasn't forceful enough.


