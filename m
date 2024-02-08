Return-Path: <linux-kernel+bounces-57540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACDF84DA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8121E1F22FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68069305;
	Thu,  8 Feb 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="bTnyjtOk"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B822692EE;
	Thu,  8 Feb 2024 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375806; cv=none; b=ok7H7apM3uVGmlJiw9JQGtdnfEuH/jVsfYxks2ybCO2jJA7NsMKjVbAikfcq0a1rW+egUUS875b9hfqvwAh9NChtotw9pD0Lix4CdhpZQX4O7Ysgx5oVQaRgQlKeLjFffFu6QH3qVKUMbZuVxBuQA8eOjZLoYpHaOGMMs0m2V0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375806; c=relaxed/simple;
	bh=uPLCZRgDaIadbtMF2//aJx5zwFVadHIP7fergVohN/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8K09yBVFZjvnvaTZcJtm8Zo/M6brGAusrcRgo1FuOc9W3w07JQ7/1uKO+e0CNbJgeux7fthbQGwmPhbF4dr6MBsDo9rQ7+ZL3sS2rG1reabmNMxqBve3BtmJ9vv6cPhTZY5hVcb3Mtf3EWeLB5JdtE1qYJSRC0iXTcTeu6q3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=bTnyjtOk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707375751; x=1707980551; i=deller@gmx.de;
	bh=uPLCZRgDaIadbtMF2//aJx5zwFVadHIP7fergVohN/I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bTnyjtOkyNLwx6qXUWxSsNiQX8+LHW0+UuTQL253UHJVQc+A9SnPNy3uojPoc/Bb
	 53YcpTQrPSYInA6Eiols+j/3CMWSih/VhGbKWZRzrmNkEYOZAyGv3VeB16tKBo6c9
	 ZAIWBAWHjrbtMyjo8LUFZLkcmHoO0kWc9qCMDEUfMbR+sTxSiDyLWkNPqiBF4Ol4b
	 A4oKrxpWJq74YDEOi/rrFsgd79SNjbHFqRuaARG35VF/IcIwLoaUu3CGNSVQxFaC+
	 HqTTJ8fT+P/Bsh5ZOCgHEFfOarJSobEd4hNSggy8+1JCemvlDqBnKdLoJWlPgjlvR
	 Swlkm/81ICvkF9dn0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.159.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1rhI6H2H3q-009Orf; Thu, 08
 Feb 2024 08:02:31 +0100
Message-ID: <385d72eb-2443-42e5-858d-0cc083a29a26@gmx.de>
Date: Thu, 8 Feb 2024 08:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: prctl: Reject PR_SET_MDWE where not supported
To: Zev Weiss <zev@bewilderbeest.net>, linux-parisc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Florent Revest <revest@chromium.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <yang@os.amperecomputing.com>, Stefan Roesch <shr@devkernel.io>,
 Oleg Nesterov <oleg@redhat.com>, David Hildenbrand <david@redhat.com>,
 Josh Triplett <josh@joshtriplett.org>, Ondrej Mosnacek
 <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Sam James <sam@gentoo.org>,
 stable@vger.kernel.org
References: <20240208012620.32604-4-zev@bewilderbeest.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240208012620.32604-4-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xUHXoor0X0Tczwb0phFhyiIkBZYuYO1Y7oAoH+bcsfFdDXzGiX/
 4cDLml5CNyNLnGrMvK9WLmm+5iAGEVfqyaPsGd1wjJ+xyY84h2PrjQn7bK8Dr1nb/ENlwgS
 74COURsfhqrAnFZ13QBBkTYNB1oN1gxE0OO0PopLxf3SxoWi667u+Lj0bMOm+wIgV4mn/bg
 qJ3cr7DEFJbWCR7o2a5iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H4sUo4N9x80=;dMcRV8QJxd0UOI+7LLCR2CEJQvB
 YozMvzxJvEQOKYW9eFdBiRQRYWtq7SMJZthysyM5F6GPZXofnnJDQiglaJXgz4rT58BP71HQi
 IbpedJQuP9IoNfWhJmZH1kHUMlgZs6g8fFeWoA38f48+X9Hw6HerkfZhPjuE3mj6wcIkgc1p0
 K2r2c+waoAIK6QMpF/r96OHVC044yoE55DfYlN5khPoZ4kANeLbOssbozfEjz7OcrEekgb6xC
 fcNAgNgxIRzLG7Zm6VnZoZiwzghhZMZEFhMAjDQXNev60lsYCVEbbaOJoBzUBur6beSNvJYEQ
 xwbmKd+HU638McFvdS73gQVL+onlOCvi/9Xjy9qWtgjhqBuVen0AQT2HX2VY5N2iPFLLFr3Vt
 UcHMsD/OZrYrazuR5OqP+wMFDTR75dmp4dzKEuo+K95dNLzyKIUYlIH1vxjQaqMRPTheuOUtT
 YgFtB2zy7SlAHDmIWtSfeCQksV148jHnWx7nsmOsTOxAy7IFF4TRdDFNVEQ7WLQ0zJ+pHizKr
 y/v4QR2PiuONspvi8Rw+2SulvgtChVz7aZHkAwf8ls7sruYh06L0QgWzyVVJyZo83Hy+y753K
 1pbCjFwJuLdxrACAESSS/ZgT75o1PKfOoGM0iLllZrsd9OAxD/HHrPsOmjzt0uyz1oko7MaXD
 MfpQqheoaDSg4P/A8TEZFjp8lj5E5lUSBUys2yRpv3iAZRYicvw6s18LAPwdAzFG4+9MW6zi3
 oCxKB0NKw6XN/4xRUo16M0n+crdXtif0R3/iQNlq1qr571mF0lZjsuSZt9BmsNe4ehL788Y72
 jIcNPIc2w1EFnYuXw3W1sKB5Pcd/HyWEzLRfNuB9/JQ54=

Hi Zev,

On 2/8/24 02:26, Zev Weiss wrote:
> Hello,
>
> I noticed after a recent kernel update that my ARM926 system started
> segfaulting on any execve() after calling prctl(PR_SET_MDWE).  After
> some investigation it appears that ARMv5 is incapable of providing the
> appropriate protections for MDWE, since any readable memory is also
> implicitly executable.
>
> (Note that I'm not an expert in either ARM arch details or the mm
> subsystem, so please bear with me if I've botched something in the
> above analysis.)
>
> The prctl_set_mdwe() function already had some special-case logic
> added disabling it on PARISC (commit 793838138c15, "prctl: Disable
> prctl(PR_SET_MDWE) on parisc"); this patch series (1) generalizes that
> check to use an arch_*() function, and (2) adds a corresponding
> override for ARM to disable MDWE on pre-ARMv6 CPUs.

Instead of splitting it out to a new function in mman.h,
I'd prefer having it as config option, e.g. ARCH_HAS_NO_MDWE_SUPPORT (?)
which could be checked instead.
For parisc we still want to allow mdwe in the future, we just have
to wait until most user-space programs have updated to the latest
binaries which don't need an executable stack any longer.

> With the series applied, prctl(PR_SET_MDWE) is rejected on ARMv5 and
> subsequent execve() calls (as well as mmap(PROT_READ|PROT_WRITE)) can
> succeed instead of unconditionally failing; on ARMv6 the prctl works
> as it did previously.
>
> Since this was effectively a userspace-breaking change in v6.3 (with
> newer MDWE-aware userspace on older pre-MDWE kernels the prctl would
> simply fail safely) I've CCed -stable for v6.3+, though since the
> patches depend on the PARISC one above it will only apply cleanly on
> the linux-6.6.y and linux-6.7.y branches, since at least at time of
> writing the 6.3 through 6.5 branches don't have that patch backported
> (due to further missing dependencies [0]).
> [0] https://lore.kernel.org/all/2023112456-linked-nape-bf19@gregkh/

I think you don't need to worry about that, since stable kernel series
for 6.3 up to 6.5 were stopped...

> Zev Weiss (2):
>    prctl: Generalize PR_SET_MDWE support check to be per-arch
>    ARM: prctl: Reject PR_SET_MDWE on pre-ARMv6
>
>   arch/arm/include/asm/mman.h    | 14 ++++++++++++++
>   arch/parisc/include/asm/mman.h | 14 ++++++++++++++
>   include/linux/mman.h           |  8 ++++++++
>   kernel/sys.c                   |  7 +++++--
>   4 files changed, 41 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/include/asm/mman.h
>   create mode 100644 arch/parisc/include/asm/mman.h
>


