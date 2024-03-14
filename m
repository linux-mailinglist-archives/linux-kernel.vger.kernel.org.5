Return-Path: <linux-kernel+bounces-103588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278F87C17D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF60B21524
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D274417;
	Thu, 14 Mar 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="Ls/AXlM1"
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467007351C;
	Thu, 14 Mar 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434768; cv=pass; b=gssfAGrttQt3FCYg4LPk/JY1stRyupxrH7DaZU+dJfvWMcOprB1+YyJRVeo+TJ9EquhjlZyF1JQ+tcr/F1P5QIDzN4tYXF/y4u72F68rUKtop/Tt0IwY/TGmJ8dUj1jfAPGcBN6FPEjKc8XN4sYUNEbPK8iD32yAnPiM1y6aM/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434768; c=relaxed/simple;
	bh=gYNOZ2yggoM+idNd0GWHbWWuNgubjmawR6xtRb2o4iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzmNqfdocbB9+YUGaPFW00ejR+eptfLFJNwNfLlRxXgAmnLuM2exz1ZyjoLEOCvGuO4SE3qDayQIgs4RPZHY87CyDgn7HjFTbhLd0yAyT62EqEj3RkOyuhyfUw35f4X5K27q2QEZo0g++j1yHKXZxkzLs0U/WdHEwfmI5IBslDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=Ls/AXlM1; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4TwYD71pWjz3thN;
	Thu, 14 Mar 2024 16:45:59 +0000 (UTC)
	(envelope-from jhb@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4TwYD70pLsz47rh;
	Thu, 14 Mar 2024 16:45:59 +0000 (UTC)
	(envelope-from jhb@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1710434759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Or9nCnb/dQWNRqBHg4JM/wqAutmYuKp/s8W5MxKH3A=;
	b=Ls/AXlM1E/0PoEUirK+ne97gapJUuFtvpieTbONtiLNQQLfaov1zfk6ga0kuguUTFt0BAI
	JqVDO/0vHH8Uk5e1SE8+tLH5eXGrEPanZVX9S6TwjOe+ck/hrzO74RtGuzNrUR1Vwx5XxZ
	3w8upAG4TMX0CLr8Dv35sDJrkGQpc2rPKgSpnKHgn7UzJY3tA4naI4v+CgJjpHjdlDrGM4
	Bt4rBmdI/7xLaZpxhXq9EZDM96CR+lBUZwTLfE71W2J6fgkzprxqHNEMbeu9o0o6fWt/GD
	gcWLeuymUQYU7Mu2zSpTWdOAbPz5IiEsWqSaqdmGdnZuCoTQBt3iVNdUX/tJ/w==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1710434759; a=rsa-sha256; cv=none;
	b=ydVZ+5k65PrkUrfACDATGl7fbchhyd//uhylOn2yTwlLH2KMFmqZhungfqnWfp6V9a0/tv
	oK/9wOxteAkn27y3DsGcWhpWIPv89PNKZC3rs+TF9tqonvJtiRQ6/99Ft8zjdTdps6dzIv
	w/JTKtl7DliSVxsFhVt/C96AkTEtT1/wh3JrvmkDUDky01getdnC902ITK7adiObM0maDI
	mzMp3yqgEcz7ydde5s+l57YSYoNq0uggKxLHzpCVAYxbfay721YOoZ1AoVpZvFEGInzDNX
	cGXt/798v5VhqlWlFOWDBV0513T5ABrdcC4l7ei+OeX4iTr3fUc1osZ0sw7stA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1710434759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Or9nCnb/dQWNRqBHg4JM/wqAutmYuKp/s8W5MxKH3A=;
	b=M7JfQhri+AHphqqXzABLoVnxXu4/VCefwkUY+x9uMHDXQXtXmOAhgZv2z674l+fdhdLfug
	bZXV/OYJYBp3Uk5jwj6HJoxlk5VJSPUpzU1/sdUBuOkPNHn+k4Gyvq4LxlNiliUevn/bOR
	oFoC8Ad4LEFWDaaTq/FLAuiN+fxqboTGrfoCJf5Z4x1SsT+HK9C//sibVaNjvXY/yJQzSi
	49O9yd2SDkvNH4Fk1QXoE/Gj1w3oTbK+Sd83iKSZVXx5ELYkV/bW4VOtmho7jgEf5EBVdT
	4M4fy1YIBfuVQRV3gY9GE8tcR8i74MOcNbJakGayJayfWIMBjMOIJNcJ5DdjkQ==
Received: from [128.232.109.22] (user-109-22.vpn.cl.cam.ac.uk [128.232.109.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: jhb)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4TwYD226LszMsW;
	Thu, 14 Mar 2024 16:45:54 +0000 (UTC)
	(envelope-from jhb@FreeBSD.org)
Message-ID: <971d21b7-0309-439e-91b6-234f84da959d@FreeBSD.org>
Date: Thu, 14 Mar 2024 09:45:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing Xfeatures
 information to x86 core files
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 Vignesh Balasubramanian <vigbalas@amd.com>, linux-kernel@vger.kernel.org,
 linux-toolchains@vger.kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, ebiederm@xmission.com,
 keescook@chromium.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, bpetkov@amd.com, jinisusan.george@amd.com, matz@suse.de,
 binutils@sourceware.org, felix.willgerodt@intel.com
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
 <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
From: John Baldwin <jhb@FreeBSD.org>
In-Reply-To: <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 8:37 AM, Dave Hansen wrote:
> On 3/14/24 04:23, Vignesh Balasubramanian wrote:
>> Add a new .note section containing type, size, offset and flags of
>> every xfeature that is present.
> 
> Mechanically, I'd much rather have all of that info in the cover letter
> in the actual changelog instead.
> 
> I'd also love to see a practical example of what an actual example core
> dump looks like on two conflicting systems:
> 
>     * Total XSAVE size
>     * XCR0 value
>     * XSTATE_BV from the core dump
>     * XFEATURE offsets for each feature

I noticed this when I bought an AMD Ryzen 9 5900X based system for my desktop
running FreeBSD and found that the XSAVE core dump notes were not recognized
by GDB (FreeBSD dumps an XSAVE register set note that matches the same
layout of NT_X86_XSTATE used by Linux).

In particular, as the cover letter notes, on this AMD processor, there is
no "gap" for MPX, so the PKRU registers it provides are at a different offset
than on Intel CPUs.  Furthermore, my reading of the SDM is that there is no
guarantee of architectural offsets of a given XSAVE feature and that software
should be querying CPUID to determine the layout.

FWIW, the relevant CPUID leaves for my AMD system:

    XSAVE features (0xd/0):
       XCR0 valid bit field mask               = 0x0000000000000207
          x87 state                            = true
          SSE state                            = true
          AVX state                            = true
          MPX BNDREGS                          = false
          MPX BNDCSR                           = false
          AVX-512 opmask                       = false
          AVX-512 ZMM_Hi256                    = false
          AVX-512 Hi16_ZMM                     = false
          PKRU state                           = true
          XTILECFG state                       = false
          XTILEDATA state                      = false
       bytes required by fields in XCR0        = 0x00000988 (2440)
       bytes required by XSAVE/XRSTOR area     = 0x00000988 (2440)
       XSAVEOPT instruction                    = true
       XSAVEC instruction                      = true
       XGETBV instruction                      = true
       XSAVES/XRSTORS instructions             = true
       XFD: extended feature disable supported = false
       SAVE area size in bytes                 = 0x00000348 (840)
       IA32_XSS valid bit field mask           = 0x0000000000001800
          PT state                             = false
          PASID state                          = false
          CET_U user state                     = true
          CET_S supervisor state               = true
          HDC state                            = false
          UINTR state                          = false
          LBR state                            = false
          HWP state                            = false

> Do you have any information about what other OSes are doing in this
> area?  I thought Windows, for instance, was even less flexible about the
> XSAVE format than Linux is.

I have an implementation of a similar note for FreeBSD already as well as
patches for GDB to make use of the note (for FreeBSD) and generate it
via 'gcore' (on FreeBSD).  However, I would very much like to reach
consensus on a shared format of the note to avoid gratuitous differences
between FreeBSD and Linux.  The AMD folks were gracious enough to work on
the Linux kernel implementation.  A bit more on that below though.

> Why didn't LWP cause this problem?
> 
>  From the cover letter:
> 
>> But this patch series depends on heuristics based on the total XSAVE
>> register set size and the XCR0 mask to infer the layouts of the
>> various register blocks for core dumps, and hence, is not a foolproof
>> mechanism to determine the layout of the XSAVE area.
> 
> It may not be theoretically foolproof.  But I'm struggling to think of a
> case where it would matter in practice.  Is there any CPU from any
> vendor where this is actually _needed_?
> 
> Sure, it's ugly as hell, but these notes aren't going to be available
> universally _ever_, so it's not like the crummy heuristic code gets to
> go away.
> 
> Have you seen the APX spec?
> 
>>
> https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-performance-extensions-apx.html
> 
> It makes this even more fun because it adds a new XSAVE state component,
> but reuses the MPX offsets.
> 
>> This information will be used by the debuggers to understand the XSAVE
>> layout of the machine where the core file is dumped, and to read XSAVE
>> registers, especially during cross-platform debugging.
> 
> This is pretty close to just a raw dump of the XSAVE CPUID leaves.
> Rather than come up with an XSAVE-specific ABI that depends on CPUID
> *ANYWAY* (because it dumps the "flags" register aka. ECX), maybe we
> should just bite the bullet and dump out (some of) the raw CPUID space.

So the current note I initially proposed and implemented for FreeBSD
(https://reviews.freebsd.org/D42136) and an initial patch set for GDB
(https://sourceware.org/pipermail/gdb-patches/2023-October/203083.html)
do indeed dump a raw set of CPUID leaves.  The version I have for FreeBSD
only dumps the raw leaf values for leaf 0x0d though the note format is
extensible should additional leaves be needed in the future.  One of the
questions if we wanted to use a CPUID leaf note is which leaves to dump
(e.g. do you dump all of them, or do you just dump the subset that is
currently needed).  Another quirky question is what to do about systems
with hetergeneous cores (E vs P for example).  Currently those systems
use the same XSAVE layout across all cores, but other CPUID leaves do
already vary across cores on those systems.  Some options considered for
that are to 1) use a separate note type for "other" core types (e.g.
a separate note type for "E" cores), or 2) make this new note a per-thread
note that matches the core the given thread was running on when the
register state stored in the process core dump was saved.

However, there are other wrinkles with the leaf approach.  Namely, one
of the use cases that I currently have an ugly hack for in GDB is if
you are using gdb against a remote host running gdbserver and then use
'gcore' to generate a core dump.  GDB needs to write out a NT_X86_XSTATE
note, but that note requires a layout.  What GDB does today is just pick
a known Intel layout based on the XCR0 mask.  However, GDB should ideally
start writing out whatever new note we adopt here, so if we dump raw
CPUID leaves it means extending the GDB remote protocol so we can query
the CPUID leaves from the remote host.  On the other hand, if we choose a
more abstract format as proposed in this patch, the local GDB (or LLDB
or whatever) can generate whatever synthetic layout it wants to write
the local NT_X86_XSTATE.  (NB: A relevant detail here is that the GDB
remote protocol does not pass the entire XSAVE state across as a block,
instead gdbserver parses individual register values for AVX, etc.
registers and those decoded register values are passed over the
protocol.)

Another question is potentially supporting compact XSAVE format in
for NT_X86_XSTATE.  Today Linux has some complicated code to re-expand
the compat XSAVE format back out to the standard layout for ptrace() and
process core dumps.  (FreeBSD doesn't yet make use of XSAVEC so we
haven't yet dealt with that problem.)  The CPUID leaf approach would
allow us to support compact formats, though GDB would have to check for
the flag in the XSAVE header to decide which format to use, etc.  On
the other hand, if we use the more abstract format in this patch, then
GDB wouldn't actually have to care at all.  The kernel would just dump
out the "compact" form of the layout note and the direct XSAVEC output
as the note.  (I will probably do this in FreeBSD eventually, but
using a policy knob (sysctl on FreeBSD) to control if it is enabled
that FreeBSD would default to on at some point in the future.)

I don't really have a strong preference for which type of note to dump
myself, I really just want to have a shared format so that there is
less work to do on the tools side (e.g. GDB).

Also, FWIW, I did try to raise this topic on LLDB's discussion forums
and got a simple "sounds ok" type response but no detailed feedback.
That was a proposal for the CPUID leaf note, but I suspect LLDB will
be fine with either approach.  Certainly I will update GDB to work
with whatever approach is adopted.

-- 
John Baldwin


