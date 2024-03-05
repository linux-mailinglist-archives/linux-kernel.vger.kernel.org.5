Return-Path: <linux-kernel+bounces-91489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B987124A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD711F22FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75CE125CC;
	Tue,  5 Mar 2024 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cOIGynwT"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30D11718
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601605; cv=none; b=A+I8op+fBREIrOpRDPduZOurQazEZrWK64IvanrwmBSemasQexIomD8doXTi5OsTUwxvNNwDroaGemHIcAcLcrPLXW7lKZgjeRCRHYhF4jQb0O6rzMcsXN2ZjQkqkAuEYgY1KHccZqR+Xhwux+jEBvbh6KCkTexdCFA4zUKzwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601605; c=relaxed/simple;
	bh=bENHrIi81b7/cGsKexLb2v9wAL/OrojLPNNJ8WftWKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9IxhDqvIVjsTQ5n/Hease8AEdKJEsMf/upRvP3+iAdux7nWFY92BN8KVwpvE05qtVr5a4mjp8GL1sF/h6w72H4PG+r2y9GHXC4hEzP/BDLapXoq7A4yKMxpWfVAPZ4ibI9V/6iq4P3Xl1fySPrcQF8eSnzrRzTVA/pMdShdU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cOIGynwT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709601602;
	bh=bENHrIi81b7/cGsKexLb2v9wAL/OrojLPNNJ8WftWKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cOIGynwTXC+fmQcA31sL445SuITH6cKexqqDiu6ETgd145F+iubShVd1Nw3U+da9b
	 fgTAvgbkfBZ8O2ZrjyeDspHWCsN0DOHlkA8Y7R1rzqvGdGpY8vyidEI6KvINX+6RZG
	 hf/v5xOKsh/Ep/BxgYYVT4XAi37Cj79xVQEtOG4wwOeyjM6ql85HvKqlpzFRCGiYKs
	 OEkY1S+k6uIzo9C/g1BOQJfW8AN6UxY4KAcxl9JCVOUOY40CvZqlFSfG4z43F4Mmas
	 D595UnmaXsXLDy54CMchIeA4jlObyrVjZsd7z8dcbEfzHZKd5skB1ykjk/U/er8Mkm
	 1Y59teTf13vkA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tpd5t23jszfcT;
	Mon,  4 Mar 2024 20:20:02 -0500 (EST)
Message-ID: <c73feaa6-ec84-4792-a624-7693d9bec44a@efficios.com>
Date: Mon, 4 Mar 2024 20:20:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Sachin Sant <sachinp@linux.ibm.com>
References: <20240302111244.3a1674be@gandalf.local.home>
 <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
 <20240302154713.71e29402@rorschach.local.home>
 <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
 <20240303075937.36fc6043@rorschach.local.home>
 <CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
 <20240303140705.0f655e36@rorschach.local.home>
 <CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
 <20240303160024.458d4f91@rorschach.local.home>
 <20240304164205.3245608a@gandalf.local.home>
 <CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
 <20240304171034.08d037aa@gandalf.local.home>
 <CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
 <20240304184725.55449e70@gandalf.local.home>
 <20240304185241.7ce42097@gandalf.local.home>
 <CAHk-=wgR7NrXTk8rJbWEv0PBN5z8kbyWaWqKO_UDnK1DXoSbqg@mail.gmail.com>
 <20240304194343.57a6a541@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304194343.57a6a541@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 19:43, Steven Rostedt wrote:
> On Mon, 4 Mar 2024 16:17:15 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Mon, 4 Mar 2024 at 15:50, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> But this still isn't fixing anything. It's just adding a limit.
>>
>> Limiting things to a common maximum size is a good thing. The kernel
>> limits much  more important things for very good reasons.
>>
>> The kernel really shouldn't have big strings. EVER.  And it literally
>> shows in our kernel infrastructure. It showed in that vsnprintf
>> precision thing. It shows in our implementation choices, where we tend
>> to have simplistic implementations because doing things a byte at a
>> time is simple and cheap when the strings are limited in size (and we
>> don't want fancy and can't use vector state anyway).
>>
>> If something as core as a pathname can be limited to 4kB, then
>> something as unimportant as a trace string had better be limited too.
>> Because we simply DO NOT WANT to have to deal with longer strings in
>> the kernel.
>>
> 
> So I made three patches that do basically what you want. And as a bonus,
> it's not really an arbitrary limit but based on trace_seq size.
> 
> The first patch will be removing the precision check, as that's not needed.
> 
> The second patch is to remove the dependency between trace_seq and
> PAGE_SIZE, as its size really can just be 8K for all architectures. Which
> has the side effect of limiting the size of trace_marker, as its size is
> limited by the trace_seq size.
> 
> Finally, because the trace_seq defines the max output that a trace_event
> can write (for all its fields), the extra data of a print event could
> possibly overflow that, which will cause the event not to print, and just
> an "OVERFLOW" output would show in the trace buffer. So I used the
> TRACE_SEQ_SIZE / 2 as the max size that trace_marker can read, which
> happens to be 4K.

Steven, see my other reply. This is backwards.

You can leave the trace_seq as is if you want. It's the trace marking
input size that should be #define to 4kB, not defined as
half-the-size-of-an-internal-buffer-that-happens-to-be-8k.

Then add a BUILD_BUG_ON() in the output code to make sure the output
buffer is always large enough.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


