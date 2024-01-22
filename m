Return-Path: <linux-kernel+bounces-33762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABA836E47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD821F289CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52E4D11B;
	Mon, 22 Jan 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cUQW2Ou3"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0753D553
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943690; cv=none; b=Lb90TyvOzmMktjCM8a9ia5Ok1uzU2mKEkbmIkVmidF/cwaYyrmVBu9VZNpyl/FVApUqlEJz2YSwrFAEZxOnyIL5pdHd7A8FomuOxQq3KbaoVfpXWoSaECvTWVkPk/6hQxM2u7tezk8JeU7hnSUy0dLVPIM8T49Zj4ISWJfOHXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943690; c=relaxed/simple;
	bh=K6UYNxq2K4G4RHPD/rPE7hHKt01Gkw182/zmsv/gKVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOAo9C6zc//Yb/m3tHxNSO8thZZJjTGUucdKn8yrUyVEonpebDlc0eH36icHaB+tKdvCZKTPFM0sATigTYpWf38rVHc397jWTE5PPWuDMhUHJ3wR5PPPOBtN8oyzgbSDFs7uZ58a2/8vgX8nkkwLGbcdtkDm9agkpce8cZ/v2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cUQW2Ou3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705943676;
	bh=K6UYNxq2K4G4RHPD/rPE7hHKt01Gkw182/zmsv/gKVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cUQW2Ou370dTCTh9nmR7a7B4XUpjIlfdbH80fSLhzOCoZPpnDRahqN8e+f8s1HWlk
	 HuB4MrZ4A4IHqLRxTyxI21ceebBQ0nZEBeFfajPJx6hX/4/Gn7a6U+sk/CYo3mcbaK
	 0QmVv8Q99CF+IZnPxx5QieRvjHhIYamVrBC0aUaex/MPKhD7m7XgBzYEUFeXNUCkF7
	 W1+AUuCWzUowJAzHhERKoA/OSsWGhuc3u/z6pU7fU+MbEwdMRspOEuAo1bZ05lU6Ha
	 f5JMdKMEKTZMaAGa+08pSrXh9RzBEzClw6d8iB7LbM6nvaL8GCWjxyxOKVxOld+sW4
	 8JyA33NSAR5ag==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TJcK803HjzTlH;
	Mon, 22 Jan 2024 12:14:35 -0500 (EST)
Message-ID: <ccc4234d-8a47-4c0f-808a-95e61c9c9171@efficios.com>
Date: Mon, 22 Jan 2024 12:14:36 -0500
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
To: Steven Rostedt <rostedt@goodmis.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
References: <20240117143548.595884070@goodmis.org>
 <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240122100630.6a400dd3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-01-22 10:06, Steven Rostedt wrote:
> On Mon, 22 Jan 2024 11:38:52 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
[...]
>>
>> On Wed, Jan 17, 2024 at 3:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> The dentries and inodes are created in the readdir for the sole purpose of
>>> getting a consistent inode number. Linus stated that is unnecessary, and
>>> that all inodes can have the same inode number. For a virtual file system
>>> they are pretty meaningless.
>>>
>>> Instead use a single unique inode number for all files and one for all
>>> directories.
>>>
>>> Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.local.home/
> 
> Yeah, Linus wanted me to try this first and see if there's any regressions.
> Well, I guess you just answered that.
> 
>> This confuses "find".
>> Running "find /sys/" now prints lots of error messages to stderr:
>>
>> find: File system loop detected;
>> ‘/sys/kernel/debug/tracing/events/initcall/initcall_finish’ is part of
>> the same file system loop as
>> ‘/sys/kernel/debug/tracing/events/initcall’.
>
> So at a minimum, the directories need to have unique inode numbers.

[...]

> I'm using the eventfs_inode pointer to create a unique value for the inode.
> But it's being salted, hashed and then truncated. As it is very easy to
> read inodes (although by default, only root has access to read these
> inodes), the inode numbers themselves shouldn't be able to leak kernel
> addresses via the results of these inode numbers, would it?

Why use an improvised hashing function (re-purposed from
scripts/kconfig/symbol.c to a use-case which is exposed through a
userspace ABI prone to kernel address leaks) rather than simply
reserving values by setting bits in a bitmap ?

How many inodes do we realistically expect to have there ?

On my 6.1.0 kernel:

find /sys/kernel/tracing | wc -l
15598

(mainly due to TRACE_EVENT ABI files)

Hashing risks:

- Exposing kernel addresses if the hashing algorithm is broken,
- Collisions if users are unlucky (which could trigger those
   'find' errors).

Those 15598 inode values fit within a single page (bitmap of
1922 bytes).

So I would recommend simply adding a bitmap per tracefs filesystem
instance to keep track of inode number allocation.

Creation/removal of files/directories in tracefs should not be
a fast-path anyway, so who cares about the speed of a find first
bit within a single page ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


