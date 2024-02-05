Return-Path: <linux-kernel+bounces-53248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B0B84A2A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9A0B24F27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E447F7E;
	Mon,  5 Feb 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S/6nMhxR"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162B47F65;
	Mon,  5 Feb 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158687; cv=none; b=tiUNgbRAS4krgHKrreDs64DNF4tdgkPy5bpIYj4lx8cKaCH6JcR4kYJxyPJoS5yqD87lEgCMJUaTjlhvvPgPFPPGu37g0NsaBa+/zTJmO4ezIFT2+3RYaQQmskKsROoJRYHRkFM1YQvCFz1S1S/T0+ACYvDXms35PAvyfqqGcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158687; c=relaxed/simple;
	bh=cPf5HjwCxIExcPKrZp5F+wbaQ+QW92oioAReuEv7mlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed/ZU/3OUDDCJkbrwYGpjVIuxviG85Rgta8DG1VlVyHGjsBEhkbJprPpzSeMa46vytcUL8Vi4mnRt9MCzkA+g6bpVxT0DjZtpatitPeeuWpqsBlmg50CbafK7YX8J1sjH66xpfp/RpDqOIycSoskRgLfWVHDWusiPspQViduMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S/6nMhxR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707158683;
	bh=cPf5HjwCxIExcPKrZp5F+wbaQ+QW92oioAReuEv7mlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S/6nMhxR9GgUiDw2pSHL6CAiQh28PIV2ytDCNnAjc+DwiDYGJeJr9PvgkuHC9lzhH
	 LtLQukd4QFABLWfB6lrg8OBGe5Rx0w0T7rgsd0S/MigjNj7AP6RkrM+hEt/q2xDWEF
	 LOjZo/1494NdrRYJqR9IodKDH2c1maQ1qQcPyiQ5DMn95Dhp53PRwytUJmDZ6r76KG
	 OxgWwpj4+HZCE62anjDti4KMFTx23d/ofrUGIMjybAQ7AfyZb0adlisirJS/V9HgV/
	 A+JTPR/bN6Ujyyr3oIVL8N0mE8LLZfsySou00sHUcykwlGD588avKZ0fA0bbU8Oi0I
	 lTQQOSb5d4JRA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TTFff6MmWzXCp;
	Mon,  5 Feb 2024 13:44:42 -0500 (EST)
Message-ID: <d1aa52b9-d2a5-4315-b39d-d2784cece3f4@efficios.com>
Date: Mon, 5 Feb 2024 13:44:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] tracing: Allow user-space mapping of the
 ring-buffer
Content-Language: en-US
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
References: <20240205163410.2296552-1-vdonnefort@google.com>
 <20240205163410.2296552-5-vdonnefort@google.com>
 <3c16bee0-70b7-420f-a085-c9e09e293fe2@efficios.com>
 <ZcEqLmyi3fEMOSIl@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZcEqLmyi3fEMOSIl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 13:34, Vincent Donnefort wrote:
> On Mon, Feb 05, 2024 at 11:55:08AM -0500, Mathieu Desnoyers wrote:
[...]

>>
>> How are the kernel linear mapping and the userspace mapping made coherent
>> on architectures with virtually aliasing data caches ?
>>
>> Ref. https://lore.kernel.org/lkml/20240202210019.88022-1-mathieu.desnoyers@efficios.com/T/#t
> 
> Hi Mathieu,
> 
> Thanks for the pointer.
> 
> We are in the exact same problem as DAX. We do modify the data through the
> kernel linear mapping while user-space can read it through its own. I should
> probably return an error when used with any of the arch ARM || SPARC || MIPS,
> until cpu_dcache_is_aliasing() introduces a fine-grain differentiation.

You might want to use LTTng's ring buffer approach instead. See

https://github.com/lttng/lttng-modules/blob/master/src/lib/ringbuffer/ring_buffer_frontend.c#L1202

lib_ring_buffer_flush_read_subbuf_dcache()

Basically, whenever user-space grabs a sub-buffer for reading (through
lttng-modules's LTTNG_KERNEL_ABI_RING_BUFFER_GET_SUBBUF ioctl), lttng
calls flush_dcache_page() on all pages of this subbuffer (I should
really change this for a call to flush_dcache_folio() which would be
more efficient).

Note that doing this is not very efficient on architectures which have
coherent data caches and incoherent dcache vs icache: in that case,
we issue the flush_dcache_page uselessly. I plan on using the new
cpu_dcache_is_aliasing() check once/if it makes it way upstream to
remove those useless flushes on architectures which define
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, but do not virtually alias the
data cache.

The equivalent of LTTng's "get subbuf" operation would be
the new TRACE_MMAP_IOCTL_GET_READER ioctl in ftrace AFAIU.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


