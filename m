Return-Path: <linux-kernel+bounces-91498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91E87125F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838971F22C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504B17C6D;
	Tue,  5 Mar 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tioNCMft"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6F5CBD;
	Tue,  5 Mar 2024 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602584; cv=none; b=cmJysd9dK7SsDWxtkX4oQrK4g8VImgOV6cFhNVTAQ4nL4nP1nOKi7LRU0RskaleZvm/RmAkFA6wbwJ8wZ+yJ7/8dtOsN9YT/itbJiH/ISZ/ew5LxnWqoToef82NtLWyJj/LtNUqxki6YYK3sy2egjEFskL/7P19RvvVDWMmMouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602584; c=relaxed/simple;
	bh=odJVN7Fd1V/o7yKree4ELR1BZzJe5u+sfi1HbW0lKdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7fUszmFGLfXwrL2/+SWDO1WO8NetavJMiCJA59rJ7gkp07Z1S090AZ7wfgcpFCCa5jKFmV7ZHmwfFIyqbA1J6BLHetPzhz1unVrQBwApNHxLbuZrXv9M3zEFtG0HQ7/0tEbJgKfz7mjoAkH2aU1yl2g3if6d5PBY/hQ9LNVKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tioNCMft; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709602581;
	bh=odJVN7Fd1V/o7yKree4ELR1BZzJe5u+sfi1HbW0lKdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tioNCMftE22BP1mKy8N0niZY1paXJTU+y0yjgGXs1ophlJZILlWKMRKqMsyWhGpdn
	 YQP/B4wm3SMIlWrSdRW0zTioJt7atDkAbE1t/8MiYlpxo01EgEYHDPe34R67zTfoJB
	 MWA8C2mDBKZnkCygzLjYpcvWsLD3pXMi70Z62nK8zWZX/5HJU6bpX+Un+YzISx1PkA
	 w3MOA4WwS8Vb4TsCgLuRYWCT3ZIwEXHULg/OAl8VU8y5r0QauU7CS0MqBNg1hTxwnh
	 GC97/wQSasSjxFdWltIdpDm7s4mqqmlE4hSbaqX7Ef9V6CneR3jn71ULHAZkPWnH+Y
	 fe9+ra70aB/rw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TpdSj1hxlzfcV;
	Mon,  4 Mar 2024 20:36:21 -0500 (EST)
Message-ID: <e34628b6-fdb3-420f-8563-4cf91ad3a04b@efficios.com>
Date: Mon, 4 Mar 2024 20:36:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304192710.4c99677c@gandalf.local.home>
 <469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
 <20240304203516.45b7a551@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304203516.45b7a551@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 20:35, Steven Rostedt wrote:
> On Mon, 4 Mar 2024 20:15:57 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-03-04 19:27, Steven Rostedt wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> Since the size of trace_seq's buffer is the max an event can output, have
>>> the trace_marker be half of the entire TRACE_SEQ_SIZE, which is 4K. That
>>> will keep writes that has meta data written from being dropped (but
>>> reported), because the total output of the print event is greater than
>>> what the trace_seq can hold.
>>
>> Defining the trace_mark limit in terms of "TRACE_SEQ_SIZE / 2"
>> seems backwards. It's basically using a define of the maximum
>> buffer size for the pretty-printing output and defining the maximum
>> input size of a system call to half of that.
>>
>> I'd rather see, in a header file shared between tracing mark
>> write implementation and output implementation:
>>
>> #define TRACING_MARK_MAX_SIZE	4096
>>
>> and then a static validation that this input fits within your
>> pretty printing output in the output implementation file:
>>
>> BUILD_BUG_ON(TRACING_MARK_MAX_SIZE + sizeof(meta data stuff...) > TRACE_SEQ_SIZE);
> 
> That's not the meta size I'm worried about. The sizeof(meta data) is the
> raw event binary data, which is not related to the size of the event output.
> 
>   # cd /sys/kernel/tracing
>   # echo hello > trace_marker
>   # cat trace
> [..]
>             <...>-999     [001] .....  2296.140373: tracing_mark_write: hello
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     This is the meta data that is added to trace_seq

If this header has a known well-defined upper-limit length, then use
that in the BUILD_BUG_ON().

Thanks,

Mathieu

> 
> -- Steve
> -- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


