Return-Path: <linux-kernel+bounces-38713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B283C491
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C125928A15E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7963411;
	Thu, 25 Jan 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAWUBONj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAB633F4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192351; cv=none; b=bMEE1OwKGeCQvTReoQnoKynqeg3ztRFqBZyshF5z01jjJQob6+LfvgFzbLETH5tROYA5vZLVCzeSqV6MQEtXv8h7Rg/1hY74LZw7g6wIPeKdhqwXNMifHzrUI6eKZ/x5g+tptW0dTg6PmOrf270Mv/D3mRnf1T5fMVzebrsYxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192351; c=relaxed/simple;
	bh=1bLUIWpLx127mVujO9y94HqM7q9CrpLnMA+IDBr6PB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V8tClv4XQfjgq+KSRDhQ4VgKUwoLFXDoK4jAql+fVxELRE/X45Wzl947gnMl7utGL0lZmwhe5anAzL4uBuTjEdtxeJBPGkileYzTmCRb7x03CBedOicoQQtfiGE6yY9arFh3XkbMjbj0gfE2FM1iHsCA0wqYWFO4toOK6NRDD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAWUBONj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA52C433F1;
	Thu, 25 Jan 2024 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706192350;
	bh=1bLUIWpLx127mVujO9y94HqM7q9CrpLnMA+IDBr6PB4=;
	h=Date:From:To:Cc:Subject:From;
	b=JAWUBONjkjLchI5bTMkiSMuT3gdFgIHAczdIa1jWRvnuqlMfVLsFz7NfdN9sVrZ9b
	 +nBL1LN2mIHfPODXJa4KhQ/z/dYmuoipXUkvhKmmUYUHilfqxvKLxCP8nMjgjCkfXi
	 DqToFe2Ec914wQGoMAzT8qVctPVzmpIaFsNFaXNiHkBzvc9jUO9/ueiJx8TbBftYND
	 tSA5Y+zGt82IfiZUEqOHCfhUpwubOnsP6F4lOkIEGWh5XGU4eQf4y+HMajUJNfcIxU
	 3q5TNMlK4s7gr6BqfMNWkg9hu4vqDA8nD4NRT39KVnzr9sywJGZVCq9ycFnRWxy8yq
	 AZdXMrhyZMbLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id DC10C405B2; Thu, 25 Jan 2024 11:19:07 -0300 (-03)
Date: Thu, 25 Jan 2024 11:19:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kai Huang <kai.huang@intel.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with the
 kernel sources to pick IA32_MKTME_KEYID_PARTITIONING
Message-ID: <ZbJt27rjkQVU1YoP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

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

---

To pick up the changes in:

  765a0542fdc7aad7 ("x86/virt/tdx: Detect TDX during kernel boot")

Addressing this tools/perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2024-01-25 11:08:12.363223880 -0300
  +++ after	2024-01-25 11:08:24.839307699 -0300
  @@ -21,6 +21,7 @@
   	[0x0000004f] = "PPIN",
   	[0x00000060] = "LBR_CORE_TO",
   	[0x00000079] = "IA32_UCODE_WRITE",
  +	[0x00000087] = "IA32_MKTME_KEYID_PARTITIONING",
   	[0x0000008b] = "AMD64_PATCH_LEVEL",
   	[0x0000008C] = "IA32_SGXLEPUBKEYHASH0",
   	[0x0000008D] = "IA32_SGXLEPUBKEYHASH1",
  $

Now one can trace systemwide asking to see backtraces to where that MSR
is being read/written, see this example with a previous update:

  # perf trace -e msr:*_msr/max-stack=32/ --filter="msr==IA32_MKTME_KEYID_PARTITIONING"
  ^C#

If we use -v (verbose mode) we can see what it does behind the scenes:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_MKTME_KEYID_PARTITIONING"
  Using CPUID GenuineIntel-6-8E-A
  0x87
  New filter for msr:read_msr: (msr==0x87) && (common_pid != 58627 && common_pid != 3792)
  0x87
  New filter for msr:write_msr: (msr==0x87) && (common_pid != 58627 && common_pid != 3792)
  mmap size 528384B
  ^C#

Example with a frequent msr:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
  Using CPUID AuthenticAMD-25-21-0
  0x48
  New filter for msr:read_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  0x48
  New filter for msr:write_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  mmap size 528384B
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: build id mismatch for vmlinux.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
   0.000 Timer/2525383 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
  				   do_trace_write_msr ([kernel.kallsyms])
  				   do_trace_write_msr ([kernel.kallsyms])
  				   __switch_to_xtra ([kernel.kallsyms])
  				   __switch_to ([kernel.kallsyms])
  				   __schedule ([kernel.kallsyms])
  				   schedule ([kernel.kallsyms])
  				   futex_wait_queue_me ([kernel.kallsyms])
  				   futex_wait ([kernel.kallsyms])
  				   do_futex ([kernel.kallsyms])
  				   __x64_sys_futex ([kernel.kallsyms])
  				   do_syscall_64 ([kernel.kallsyms])
  				   entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
  				   __futex_abstimed_wait_common64 (/usr/lib64/libpthread-2.33.so)
   0.030 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
  				   do_trace_write_msr ([kernel.kallsyms])
  				   do_trace_write_msr ([kernel.kallsyms])
  				   __switch_to_xtra ([kernel.kallsyms])
  				   __switch_to ([kernel.kallsyms])
  				   __schedule ([kernel.kallsyms])
  				   schedule_idle ([kernel.kallsyms])
  				   do_idle ([kernel.kallsyms])
  				   cpu_startup_entry ([kernel.kallsyms])
  				   secondary_startup_64_no_verify ([kernel.kallsyms])
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 1d51e1850ed03d46..f1bd7b91b3c63735 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -237,6 +237,11 @@
 #define LBR_INFO_CYCLES			0xffff
 #define LBR_INFO_BR_TYPE_OFFSET		56
 #define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
+#define LBR_INFO_BR_CNTR_OFFSET		32
+#define LBR_INFO_BR_CNTR_NUM		4
+#define LBR_INFO_BR_CNTR_BITS		2
+#define LBR_INFO_BR_CNTR_MASK		GENMASK_ULL(LBR_INFO_BR_CNTR_BITS - 1, 0)
+#define LBR_INFO_BR_CNTR_FULL_MASK	GENMASK_ULL(LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS - 1, 0)
 
 #define MSR_ARCH_LBR_CTL		0x000014ce
 #define ARCH_LBR_CTL_LBREN		BIT(0)
@@ -536,6 +541,9 @@
 #define MSR_RELOAD_PMC0			0x000014c1
 #define MSR_RELOAD_FIXED_CTR0		0x00001309
 
+/* KeyID partitioning between MKTME and TDX */
+#define MSR_IA32_MKTME_KEYID_PARTITIONING	0x00000087
+
 /*
  * AMD64 MSRs. Not complete. See the architecture manual for a more
  * complete list.
-- 
2.43.0


