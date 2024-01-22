Return-Path: <linux-kernel+bounces-32994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1168362EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9EA1F264A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3173B2A6;
	Mon, 22 Jan 2024 12:16:37 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE273B18D;
	Mon, 22 Jan 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925796; cv=none; b=ZKWr7KXSi95eDT0FUcGIyCi0vTi48eUAlRLFn2NXGbN7Cg+y6c1+ZqsbID4JY4USb7RF+/KS4VbuINVTgmaYguOS+PawICsCferrh6zoOpXclYrJCRtmPv59JiY5y2sOwzyuIiP0Gx0+Zxn40q3ZSkv2ilmmN/rNMfUwtbfYdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925796; c=relaxed/simple;
	bh=khMbC9WBL9kCXqma5V4jmh3o9tYUeemxhqD4KZ3qQdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwdxgW9/NBgWeRQONECcbKzAvB+TUEL/hnAfxLA/+rVu0hfMjYI89x6ReDJgvVa/hBRpp56VwBWCqqgI734E/nebSWe5RjknyyNCE93kLm9jl+pAL60EM+t5dJKJmdRvha80Qs8t7s24FDernzO+hnTBxGzJuc10yc+NZujtkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bc1e4d0fd8so428894b6e.0;
        Mon, 22 Jan 2024 04:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705925794; x=1706530594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfT7X2kMzMMEPUHYOfWuqlodXoPKXpatbvpSfjvWKIM=;
        b=SBimiv7YgFtdak0cqEc/vMcsx7NOvP0Bv2patA2y2X8hNtyIu2xrc5z2X1JOUcZrur
         VwkdQOspyQvbpsPqc/eoxeShes091IojUuRKFNATW1kIOHl71p980DUI9G5btXaq1rpG
         ftJXwAFGY/jSkop1htmcmJ6u/spKZdmtm9lzxyINJYAc9zvu47npsyWPf1g71PBLh3dy
         ANY8wkiB7CUIS3qITM6PoEsUymHj0F79SgKfWJIPoSYucTVKECjKzB20VDadMXP3Vq4W
         +XIaEaVLoxzcanMrsQErT8pwwgUSsM/Oyx/f57EsTs3FW1DMjt/ccFaTuQum4MAA45/u
         42PQ==
X-Gm-Message-State: AOJu0YxIjnrAGUiXaz3AZI/JtEzKaet71XflBdHIHtaa7aSueMNluAHn
	mgMPsuXkutExOgPdGu2OUZVigmV6VWjTKA9K5p3HX3h2F1bHqalg+rk32l64jMjISNqa7MysQB7
	vZ64ILy8KZ2wVRb3rTQEcDyV3KPoE8iDm
X-Google-Smtp-Source: AGHT+IHiPl9YQYobmVCLUA1KZEtdiUxavV00DxNt9jZRYeghdxNtC+i3rwvK4QK8IHVrvt/w7wohqDANJoiFC6+T9q0=
X-Received: by 2002:a05:6870:d14f:b0:210:b3ca:43e2 with SMTP id
 f15-20020a056870d14f00b00210b3ca43e2mr6547205oac.4.1705925793908; Mon, 22 Jan
 2024 04:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700048610.git.quic_nprakash@quicinc.com>
 <2153c549-2a45-3d1d-a407-e175a34b77bf@quicinc.com> <CAJZ5v0jqDEEw0CCAxCOcK+u+BtEa1M1B4t3OZj8umw=rxigu_g@mail.gmail.com>
 <dfa3747f-4ed6-299f-1a43-0c0f13d103d9@quicinc.com>
In-Reply-To: <dfa3747f-4ed6-299f-1a43-0c0f13d103d9@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 13:16:22 +0100
Message-ID: <CAJZ5v0gaaTj+_LNCyX-Ugw+gNea7QKwrG59ZjbSZcHMvgXp3Hg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/4] PM: hibernate: LZ4 compression support
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_pkondeti@quicinc.com, quic_kprasan@quicinc.com, 
	quic_mpilaniy@quicinc.com, quic_shrekk@quicinc.com, mpleshivenkov@google.com, 
	ericyin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:14=E2=80=AFPM Nikhil V <quic_nprakash@quicinc.com=
> wrote:
>
>
>
> On 12/12/2023 6:14 PM, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Wed, Nov 29, 2023 at 11:20=E2=80=AFAM Nikhil V <quic_nprakash@quicin=
c.com> wrote:
> >>
> >>
> >> On 11/15/2023 5:52 PM, Nikhil V wrote:
> >>> This patch series covers the following:
> >>> 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
> >>> used in the next patch where we move to crypto based APIs for
> >>> compression. There are no functional changes introduced by this
> >>> approach.
> >>>
> >>>
> >>> 2. Replace LZO library calls with crypto generic APIs
> >>>
> >>> Currently for hibernation, LZO is the only compression algorithm
> >>> available and uses the existing LZO library calls. However, there
> >>> is no flexibility to switch to other algorithms which provides better
> >>> results. The main idea is that different compression algorithms have
> >>> different characteristics and hibernation may benefit when it uses
> >>> alternate algorithms.
> >>>
> >>> By moving to crypto based APIs, it lays a foundation to use other
> >>> compression algorithms for hibernation.
> >>>
> >>>
> >>> 3. LZ4 compression
> >>>
> >>> Extend the support for LZ4 compression to be used with hibernation.
> >>> The main idea is that different compression algorithms have different
> >>> characteristics and hibernation may benefit when it uses any of these
> >>> algorithms: a default algorithm, having higher compression rate but i=
s
> >>> slower(compression/decompression) and a secondary algorithm, that is
> >>> faster(compression/decompression) but has lower compression rate.
> >>>
> >>> LZ4 algorithm has better decompression speeds over LZO. This reduces
> >>> the hibernation image restore time.
> >>> As per test results:
> >>>                                       LZO             LZ4
> >>> Size before Compression(bytes)   682696704       682393600
> >>> Size after Compression(bytes)    146502402       155993547
> >>> Decompression Rate               335.02 MB/s     501.05 MB/s
> >>> Restore time                       4.4s             3.8s
> >>>
> >>> LZO is the default compression algorithm used for hibernation. Enable
> >>> CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
> >>>
> >>> Compression Benchmarks: https://github.com/lz4/lz4
> >>>
> >>>
> >>> 4. Support to select compression algorithm
> >>>
> >>> Currently the default compression algorithm is selected based on
> >>> Kconfig. Introduce a kernel command line parameter "hib_compression" =
to
> >>> override this behaviour.
> >>>
> >>> Users can set "hib_compression" command line parameter to specify
> >>> the algorithm.
> >>> Usage:
> >>>       LZO: hib_compression=3Dlzo
> >>>       LZ4: hib_compression=3Dlz4
> >>> LZO is the default compression algorithm used with hibernation.
> >>>
> >>>
> >>> Changes in v2:
> >>>    - Fixed build issues reported by kernel test robot for ARCH=3Dsh, =
[1].
> >>> [1] https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@i=
ntel.com/
> >>>
> >>> Nikhil V (4):
> >>>     PM: hibernate: Rename lzo* to make it generic
> >>>     PM: hibernate: Move to crypto APIs for LZO compression
> >>>     PM: hibernate: Add support for LZ4 compression for hibernation
> >>>     PM: hibernate: Support to select compression algorithm
> >>>
> >>>    .../admin-guide/kernel-parameters.txt         |   6 +
> >>>    kernel/power/Kconfig                          |  26 ++-
> >>>    kernel/power/hibernate.c                      |  85 +++++++-
> >>>    kernel/power/power.h                          |  19 ++
> >>>    kernel/power/swap.c                           | 189 +++++++++++---=
----
> >>>    5 files changed, 251 insertions(+), 74 deletions(-)
> >>>
> >>>
> >>> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> >>
> >> Hi @Rafael/@Pavel/@Len,
> >>
> >> Could you please let me know if you have any concerns on this approach=
?
> >
> > Not really a concern, but that is a significant change that I would
> > rather make early in the cycle, which means after the 6.8 merge
> > window.
> >
> > No need to resend unless there is something to address in which case
> > I'll let you know.
> >
> > Thanks!
> >
> >> FYI: We have tested this on QEMU and its working fine.
> >>
> >> Logs(suspend):
> >> [   75.242227] PM: Using 3 thread(s) for lz4 compression
> >> [   75.243043] PM: Compressing and saving image data (17495 pages)...
> >> [   75.243917] PM: Image saving progress:   0%
> >> [   75.261727] PM: Image saving progress:  10%
> >> [   75.277968] PM: Image saving progress:  20%
> >> [   75.290927] PM: Image saving progress:  30%
> >> [   75.305186] PM: Image saving progress:  40%
> >> [   75.318252] PM: Image saving progress:  50%
> >> [   75.330310] PM: Image saving progress:  60%
> >> [   75.345906] PM: Image saving progress:  70%
> >> [   75.359054] PM: Image saving progress:  80%
> >> [   75.372176] PM: Image saving progress:  90%
> >> [   75.388411] PM: Image saving progress: 100%
> >> [   75.389775] PM: Image saving done
> >> [   75.390397] PM: hibernation: Wrote 69980 kbytes in 0.14 seconds
> >> (499.85 MB/s)
> >> [   75.391591] PM: Image size after compression: 28242 kbytes
> >> [   75.393089] PM: S|
> >> [   75.399784] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >> [   75.439170] sd 0:0:0:0: [sda] Stopping disk
> >> [   75.501461] ACPI: PM: Preparing to enter system sleep state S5
> >> [   75.502766] reboot: Power down
> >>
> >>
> >>
> >> Logs(resume):
> >> [    1.063248] PM: hibernation: resume from hibernation
> >> [    1.072868] Freezing user space processes
> >> [    1.073707] Freezing user space processes completed (elapsed 0.000
> >> seconds)
> >> [    1.075192] OOM killer disabled.
> >> [    1.075837] Freezing remaining freezable tasks
> >> [    1.078010] Freezing remaining freezable tasks completed (elapsed
> >> 0.001 seconds)
> >> [    1.087489] PM: Using 3 thread(s) for lz4 decompression
> >> [    1.088570] PM: Loading and decompressing image data (17495 pages).=
.
> >> [    1.125549] PM: Image loading progress:   0%
> >> [    1.190380] PM: Image loading progress:  10%
> >> [    1.204963] PM: Image loading progress:  20%
> >> [    1.218988] PM: Image loading progress:  30%
> >> [    1.233697] PM: Image loading progress:  40%
> >> [    1.248658] PM: Image loading progress:  50%
> >> [    1.262910] PM: Image loading progress:  60%
> >> [    1.276966] PM: Image loading progress:  70%
> >> [    1.290517] PM: Image loading progress:  80%
> >> [    1.305427] PM: Image loading progress:  90%
> >> [    1.320666] PM: Image loading progress: 100%
> >> [    1.321866] PM: Image loading done
> >> [    1.322599] PM: hibernation: Read 69980 kbytes in 0.23 seconds
> >> (304.26 MB/s)
> >> [    1.324795] printk: Suspending console(s) (use no_console_suspend t=
o
> >> debug)
> >> [   74.943801] ata1.00: Entering standby power mode
> >>
> >>
> >> Thanks,
> >> Nikhil V
>
>
> Hi @Rafael
>
> We have picked this patch series on 6.8-rc1 and tested the functionality
> on QEMU. Its working fine. However, while applying the patches we could
> see minor conflicts. Could you please let me know if we need to push a
> new version after resolving these conflicts?

It will help.

I can resolve the conflicts, but I may make mistakes in the process.

Thanks!

