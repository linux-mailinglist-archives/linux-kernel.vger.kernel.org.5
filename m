Return-Path: <linux-kernel+bounces-135865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966989CC48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B1285ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110E145332;
	Mon,  8 Apr 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngdI8VkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F821DDD6;
	Mon,  8 Apr 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603620; cv=none; b=sm5enWCcCdzta01B5aC5WrTfAKLMBor2tdQfoNKPr4XmaEkBr4l5MPlWglSGRRjVcCRVSYjxkq/ci3r7JBkvNXCTXvBUcWZH2/XNAR5BSfEYjYVmcva+Yiz/4rteps3r1FA7xSXLYkExiviLdXpF7stzC4pQONb3Oct9vjmYa4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603620; c=relaxed/simple;
	bh=ZQYtPEJCpxwgy71jYr4Xt0wKLHqXYR73lblW6olRIfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMFzUotZgCX2GePb8mQ1EcyvCwYEYqDXMZ9/ofpSciCaKkPAAYxaFWFs3hfbwFEgOoAyeIcm2ZeWK9QcSWlqTlRuCoeHeu42BTrx5ImuNH6xsh/I/BdynYnmM4JxDWOHCVRMwBIdoxK8akBLGzHizoIa4FH/gTZ3YukoGMNRGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngdI8VkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18CAC433C7;
	Mon,  8 Apr 2024 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712603620;
	bh=ZQYtPEJCpxwgy71jYr4Xt0wKLHqXYR73lblW6olRIfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngdI8VkPGjQyywirngIsUWF1u+GWVSlbMXTxfuLCGGZyDPUmr63zbWDxBMBOWviFL
	 9VLQhh0EazNUwXEUijaXrOxlp5Ux2/aieECbqvhv4mJZ22hw49NmhCPhHPaqcA2rEW
	 8L/YnGEDsRH0dkOaliG2zcIan3Qi375Q6srDu5HkwwLgF5j/n6Z/tpqxBqsu8fwbMS
	 7pfDfDTEqdo7afpO/K4XW1gA15Q8qJg4kDq5pkCZdJOP1dKoXiTdEmYLOaGmBAquZe
	 zGq9A5g2qb0IH53KIzeeFk7pcOdh5oxTOuSpvQl1mjvYtqjB2FEHn9Sg74z/qp47Kr
	 Yh2uYpEmcsGhQ==
Date: Mon, 8 Apr 2024 16:13:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
Message-ID: <ZhRB4BULj1Y1f1TN@x1>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>

On Mon, Apr 08, 2024 at 11:55:11AM -0700, Namhyung Kim wrote:
> Hello,
> 
> I'm gonna carry these changes on the perf tools tree.  I'll update the
> vhost.h once it lands on the mainline.

Humm, maybe its not a good idea to do that this cycle? I mean some of
these were moved from tools/{include,arch} to tools/perf/trace/beauty/{include,arch},
like tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h.

But having said that, probably isn't a problem, when you get this pulled
upstream I'll do a merge with perf-tools-next and this should be
trivially resolved, I think.

Using the above example:

⬢[acme@toolbox perf-tools-next]$ git log tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
commit c8bfe3fad4f86a029da7157bae9699c816f0c309
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Mar 11 17:07:33 2024 -0300

    perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the directory used to build perf
    
    It is used only to generate string tables, not to build perf, so move it
    to the tools/perf/trace/beauty/include/ hierarchy, that is used just for
    scraping.
    
    This is a something that should've have happened, as happened with the
    linux/socket.h scrapper, do it now as Ian suggested while doing an
    audit/refactor session in the headers used by perf.
    
    No other tools/ living code uses it.
    
    Suggested-by: Ian Rogers <irogers@google.com>
    Reviewed-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> This is the full explanation from Arnaldo:
> 
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
> 
> The way these headers are used in perf are not restricted to just
> including them to compile something.
> 
> There are sometimes used in scripts that convert defines into string
> tables, etc, so some change may break one of these scripts, or new MSRs
> may use some different #define pattern, etc.
> 
> E.g.:
> 
>   $ ls -1 tools/perf/trace/beauty/*.sh | head -5
>   tools/perf/trace/beauty/arch_errno_names.sh
>   tools/perf/trace/beauty/drm_ioctl.sh
>   tools/perf/trace/beauty/fadvise.sh
>   tools/perf/trace/beauty/fsconfig.sh
>   tools/perf/trace/beauty/fsmount.sh
>   $
>   $ tools/perf/trace/beauty/fadvise.sh
>   static const char *fadvise_advices[] = {
>         [0] = "NORMAL",
>         [1] = "RANDOM",
>         [2] = "SEQUENTIAL",
>         [3] = "WILLNEED",
>         [4] = "DONTNEED",
>         [5] = "NOREUSE",
>   };
>   $
> 
> The tools/perf/check-headers.sh script, part of the tools/ build
> process, points out changes in the original files.
> 
> So its important not to touch the copies in tools/ when doing changes in
> the original kernel headers, that will be done later, when
> check-headers.sh inform about the change to the perf tools hackers.
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (9):
>   tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
>   tools/include: Sync uapi/linux/fs.h with the kernel sources
>   tools/include: Sync uapi/linux/kvm.h and asm/kvm.h with the kernel
>     sources
>   tools/include: Sync uapi/sound/asound.h with the kernel sources
>   tools/include: Sync x86 CPU feature headers with the kernel sources
>   tools/include: Sync x86 asm/irq_vectors.h with the kernel sources
>   tools/include: Sync x86 asm/msr-index.h with the kernel sources
>   tools/include: Sync asm-generic/bitops/fls.h with the kernel sources
>   tools/include: Sync arm64 asm/cputype.h with the kernel sources
> 
>  tools/arch/arm64/include/asm/cputype.h        |   4 +
>  tools/arch/arm64/include/uapi/asm/kvm.h       |  15 +-
>  tools/arch/powerpc/include/uapi/asm/kvm.h     |  45 +-
>  tools/arch/s390/include/uapi/asm/kvm.h        | 315 +++++++-
>  tools/arch/x86/include/asm/cpufeatures.h      |  17 +-
>  .../arch/x86/include/asm/disabled-features.h  |  11 +-
>  tools/arch/x86/include/asm/irq_vectors.h      |   2 -
>  tools/arch/x86/include/asm/msr-index.h        |  74 +-
>  .../arch/x86/include/asm/required-features.h  |   3 +-
>  tools/arch/x86/include/uapi/asm/kvm.h         | 308 +++++++-
>  tools/include/asm-generic/bitops/__fls.h      |   8 +-
>  tools/include/asm-generic/bitops/fls.h        |   8 +-
>  tools/include/uapi/drm/i915_drm.h             |  16 +
>  tools/include/uapi/linux/fs.h                 |  30 +-
>  tools/include/uapi/linux/kvm.h                | 689 +-----------------
>  tools/include/uapi/sound/asound.h             |   4 +-
>  16 files changed, 809 insertions(+), 740 deletions(-)
> 
> 
> base-commit: 25e973a0e077da585e472b4cadb1d2f4c1113285
> -- 
> 2.44.0.478.gd926399ef9-goog

