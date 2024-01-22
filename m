Return-Path: <linux-kernel+bounces-33992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE948371F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13888B2C3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376953E37;
	Mon, 22 Jan 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qMCmsA20"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10D53812
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948546; cv=none; b=B/Hbob7781HHxo8KB7s5d/sZKr6RGGjvV5u/0wCTyAQXtHDnGWYamq5NIXdbmi0LeG2lvsZJPNEepAgcMdVA8w1xIT7zyfKJIUQ7B+BxvENtqWOS7TV+8kbAuhnx/LAtM34VFbvALYa/L/tFeNhAmNcAU+gunqo4I642bOK7oPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948546; c=relaxed/simple;
	bh=X4oiGtQDe6Pom+07coqzxMStwwOl6rmxWTszP465WXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwsO6IcmP7PjhHmfuhtyccbiswY30Qt3la7Qy2QCZrYEln2W8DMwYzIRn2+a1YpWJivRzArIoCKqXPUY4JBOS+bGe2Js9pi7LiSLA83jq88pIRMsGbP3eoqkalPLImv75rgs6Luf75ZePSmtLKe+sNuww5IfaLFfpWEa1ACfNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qMCmsA20; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705948542;
	bh=X4oiGtQDe6Pom+07coqzxMStwwOl6rmxWTszP465WXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qMCmsA208S8p1KrKg6EzKEwWItsKQWq9ZUStNcaiBge9iAvo6axs0oc9XG8u7PK6D
	 LbbAYAmCmqvwWpvEuIaHyebfUb6g8wnJfP2Qujjgwz5Ak+EeJocW+ClNYyAG+9zVV6
	 vU0u0HZPE+wwccycrQV+bgjxSnmFnR+YvhvGGC/4NhvuqKtvP5zpafiBnXiLfAs9sn
	 CWaePidFWfWHL+q+sM+hBPhA84VmvQBREnW7m4rsHzGreD8e4xbGNAaoomggakSdm6
	 5HaVCCFTQ6MtikFKJvtjMJLcVd4HVptMhz/YKGua5XcxkHseJCTKlpn34Gt0/0sgGw
	 1/UYLoFQ3xEuA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TJf6k373fzTbb;
	Mon, 22 Jan 2024 13:35:42 -0500 (EST)
Message-ID: <c8982677-64bf-4078-be1a-e5e18c35ecb4@efficios.com>
Date: Mon, 22 Jan 2024 13:35:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
References: <20240117143548.595884070@goodmis.org>
 <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home>
 <ccc4234d-8a47-4c0f-808a-95e61c9c9171@efficios.com>
 <20240122125004.7bbf0b70@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240122125004.7bbf0b70@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-22 12:50, Steven Rostedt wrote:
> On Mon, 22 Jan 2024 12:14:36 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
[...]
>> On my 6.1.0 kernel:
>>
>> find /sys/kernel/tracing | wc -l
>> 15598
>>
>> (mainly due to TRACE_EVENT ABI files)
>>
>> Hashing risks:
>>
>> - Exposing kernel addresses if the hashing algorithm is broken,
> 
> Well this was my biggest concern, but if I truncate at least a nibble, with
> the unique salt to the algorithm for each file, how easily does that expose
> kernel addresses.
> 
> The ei itself, is created from kmalloc() so you would at best get a heap
> address. But with the missing nibble (if I mask it with ((1 << 28) - 1),
> and much more taken away for 64 bit systems), and the added unique salt, is
> it possible for this to expose anything that could be used in an attack?

I don't know, which is why I am concerned about it.

But I don't think we should spend time trying to understand all
possible attack scenarios associated with hashing of kernel addresses
when there are much simpler options available.

> 
>> - Collisions if users are unlucky (which could trigger those
>>     'find' errors).
>>
>> Those 15598 inode values fit within a single page (bitmap of
>> 1922 bytes).
>>
>> So I would recommend simply adding a bitmap per tracefs filesystem
>> instance to keep track of inode number allocation.
> 
> And how do I recover this bit after the inode is freed, but then referenced
> again?

You would keep the allocated inode number value within your data
structure associated with the inode.

If you never free inodes, then you can just use a static increment
as Linus suggested. But AFAIU there are cases where you free inodes,
hence my suggestion of bitmap.

When the inode is freed, you know which inode number is associated from
the field in your data structure, so you can clear this bit in the bitmap.

On the next inode allocation, you find-first-zero-bit in the bitmap, and
set it to one to reserve it.

> 
>>
>> Creation/removal of files/directories in tracefs should not be
>> a fast-path anyway, so who cares about the speed of a find first
>> bit within a single page ?
>>
> 
> When an inode is no longer referenced, it is freed. When it is referenced
> again, I want it to be recreated with the same inode number it had
> previously. How would having a bitmask help with that? I need a way to map
> an ei structure with a unique number without adding another 4 bytes to the
> structure itself.

As discussed in a separate exchange with Linus, why do you care so much about
not adding a 4 bytes field to the structure ?

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


