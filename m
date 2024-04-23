Return-Path: <linux-kernel+bounces-155355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A687E8AE944
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85C81C21995
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3813C3C7;
	Tue, 23 Apr 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUSbLvbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703113B28D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881760; cv=none; b=ZCv9smi44q4+bqGuhHw/GkXl801+gjClS+EMA3v01sMgBdlXMdDe1H3gy4usHAgDb080xj3EGi/yFd/KpSOFJ852PrHoOw73y1BMzxMNxUeBxtvydvYjxJF9wItLCwNIV/QCh5/b82J81yvn9DnaUaSDnhHswN6i5TrRIzHs27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881760; c=relaxed/simple;
	bh=y5f5weJFRnxiw6ynDMcFieSZ2f9FgFYM9E+rwvT1a1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DCCiOnk7zGs1jri53TlbSXTNYyh1WE+N2qav9WQurpY8MTWom4DDeKTgVsjQ9bjlSCeG8FX4SUC6dvePouYCNoRlDD2qo7BwezCYC4LYgaNSAX3cs2iYk++hTEfdGRe87JWplfRAXyQfD+mZOSMBFoGThU+az9BkXBOv1fREegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUSbLvbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D305C116B1;
	Tue, 23 Apr 2024 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713881759;
	bh=y5f5weJFRnxiw6ynDMcFieSZ2f9FgFYM9E+rwvT1a1c=;
	h=Date:From:To:Cc:Subject:From;
	b=DUSbLvbeubQDGG5yhfulNKJt54429nxOGcCJ6J//bjraXcYlM1Iwk+0fw8Lq0RxB6
	 U2y5gk8gFJF47kJObqjhS+ZfAfMlq3rWWZKSWmn6o6UeJZYPDqmiB9hAgNu0pjf6Fw
	 RuEC3Ppu6QuJdAZzqHt+cOInLJlDQpGiBnpa4YTdMUdg42L6Iki+bPX+Dq+ZapwohR
	 RiSOMe0upoWqMb/Zav/VRUYsSaoU6WBE4moiBI71S8a9EDo03pv9K57I1elGd9gFgK
	 QZ/H6PWr6pDCMiiY82QhsKQEth0/uTp2f9veKVV7h/zjKN/M+lrDreP1zmVv9uAsnW
	 anx8ukFGFZ0bg==
Date: Tue, 23 Apr 2024 11:15:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel
Message-ID: <ZifCnEZFx5MZQuIW@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.
 sources

To pick up the changes from these csets:

  be482ff9500999f5 ("x86/bhi: Enumerate Branch History Injection (BHI) bug")
  0f4a837615ff925b ("x86/bhi: Define SPEC_CTRL_BHI_DIS_S")

That cause no changes to tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > x86_msr.before
  $ objdump -dS /tmp/build/perf-tools-next/util/amd-sample-raw.o > amd-sample-raw.o.before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ make -C tools/perf O=/tmp/build/perf-tools-next
  <SNIP>
  CC      /tmp/build/perf-tools-next/trace/beauty/tracepoints/x86_msr.o
  <SNIP>
  CC      /tmp/build/perf-tools-next/util/amd-sample-raw.o
  <SNIP>
  $ objdump -dS /tmp/build/perf-tools-next/util/amd-sample-raw.o > amd-sample-raw.o.after
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > x86_msr.after
  $ diff -u x86_msr.before x86_msr.after
  $ diff -u amd-sample-raw.o.before amd-sample-raw.o.after

Just silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 05956bd8bacf50e3..e72c2b87295799af 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -61,10 +61,13 @@
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
+#define SPEC_CTRL_BHI_DIS_S_SHIFT	10	   /* Disable Branch History Injection behavior */
+#define SPEC_CTRL_BHI_DIS_S		BIT(SPEC_CTRL_BHI_DIS_S_SHIFT)
 
 /* A mask for bits which the kernel toggles when controlling mitigations */
 #define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
-							| SPEC_CTRL_RRSBA_DIS_S)
+							| SPEC_CTRL_RRSBA_DIS_S \
+							| SPEC_CTRL_BHI_DIS_S)
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
@@ -163,6 +166,10 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
+#define ARCH_CAP_BHI_NO			BIT(20)	/*
+						 * CPU is not affected by Branch
+						 * History Injection.
+						 */
 #define ARCH_CAP_PBRSB_NO		BIT(24)	/*
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
-- 
2.44.0


