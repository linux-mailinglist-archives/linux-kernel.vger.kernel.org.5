Return-Path: <linux-kernel+bounces-166356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E18B9986
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B912B21149
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7BE5FBAA;
	Thu,  2 May 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIiTHR9c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C925F84F;
	Thu,  2 May 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647556; cv=none; b=PWpgF7pArzDGyG75xDk3G8ITJcFSqcInXHcksi3z056F59I3Rk0NOjxoXihBmmS3xZgY/IWxnU4wdkWZDfmDGPaL8rfDdujpot7uoDvZkdQ+NXTfO9PRtWFocyUPqepYmzTUq0oB4E5mMXlLk9um7KoiW8XwWdkqwh6MxyO3gMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647556; c=relaxed/simple;
	bh=moNG66s5vENtI3caa4cdwoP4aeWIekH7x4n7ZpG692A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pf8IDzUbJzC/fh7V1eOSF1O5ZNKiUeAzpHEEIu35ozvAsdlUTCoq+LCznuFj2mF4Es0GTwo3RQ2FXpO1eMcHzePzecfM6/8g2ASkgZtX2JkznNI5H/eNSQlxwal5kLn0Jcul+trO6//34unbAFvte9ten7r0rEZuOuA1ft9LOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIiTHR9c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647553; x=1746183553;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=moNG66s5vENtI3caa4cdwoP4aeWIekH7x4n7ZpG692A=;
  b=XIiTHR9cwiyt6djy6jN51iNMksZzIjsrcsP4rzY7XvzczvpCtwRfBf1C
   3zLvnTh4JzcDyk27eZINJcTvQqcfidwWKrowgreYiN06A5yTelX1N6Lco
   lDU4W6J7n6o7AxSYX/mDME0OLUFt1Nz3VAzwLfpBS1ZtiqrupUEMrxEfy
   rVUl2LHwqRn+wfkHYnQVN2snzpDtDc+VtA4eRHqu96hm+eO/ycP5vkKPa
   0L1JX/Hkz96PgI2tTqEBnVRwlspFEry909fhtfU+2erMjeeZWH0iCNPL8
   BpNS30hkE2/546x13iDTl9wHmKCYEEWiWbi72Pk10E4fxOkWIxv3ric3d
   g==;
X-CSE-ConnectionGUID: NG4huO0XS0WJIZhoTk/WLg==
X-CSE-MsgGUID: JZ9snnmtScaEpjoYvqb2SA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228549"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228549"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:12 -0700
X-CSE-ConnectionGUID: OG7ot37pT6qNmSah9qyt6A==
X-CSE-MsgGUID: ZQB31iSTSYWwwdmlm3KxjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50278865"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:07 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 00/10] perf intel pt: Update instruction decoder for APX and other new instructions
Date: Thu,  2 May 2024 13:58:43 +0300
Message-Id: <20240502105853.5338-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

The x86 instruction decoder is used not only for decoding kernel
instructions. It is also used by perf uprobes (user space probes) and by
perf tools Intel Processor Trace decoding. Consequently, it needs to
support instructions executed by user space also.

It should be noted that there are 2 copies of the instruction decoder.
One for the kernel and one for tools, which is a policy to prevent
changes from breaking builds.

Changes are based upon documents:

      Intel® Advanced Performance Extensions (Intel® APX)
      Architecture Specification
      April, 2024 Revision 4.0 355828-004

      Intel® Architecture Instruction Set Extensions
      and Future Features Programming Reference
      March 2024 319433-052

The patches depend on a patch by Chang S. Bae that they have already
submitted in their Key Locker patch set.  Nevertheless, the patch is
included in this patch set as well.

The final patch is an update to the perf tools' "x86 instruction decoder
test - new instructions" test, which provides testing.


Adrian Hunter (9):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
      x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS
      x86/insn: Add misc new Intel instructions
      x86/insn: Add support for REX2 prefix to the instruction decoder logic
      x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map
      x86/insn: Add support for APX EVEX to the instruction decoder logic
      x86/insn: Add support for APX EVEX instructions to the opcode map
      perf intel pt: Add new JMPABS instruction to the Intel PT instruction decoder
      perf tests: Add APX and other new instructions to x86 instruction decoder test

Chang S. Bae (1):
      x86/insn: Add Key Locker instructions to the opcode map

 arch/x86/include/asm/inat.h                        |   17 +-
 arch/x86/include/asm/insn.h                        |   32 +-
 arch/x86/lib/insn.c                                |   29 +
 arch/x86/lib/x86-opcode-map.txt                    |  315 ++++--
 arch/x86/tools/gen-insn-attr-x86.awk               |   15 +-
 tools/arch/x86/include/asm/inat.h                  |   17 +-
 tools/arch/x86/include/asm/insn.h                  |   32 +-
 tools/arch/x86/lib/insn.c                          |   29 +
 tools/arch/x86/lib/x86-opcode-map.txt              |  315 ++++--
 tools/arch/x86/tools/gen-insn-attr-x86.awk         |   15 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        |  116 +++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        | 1026 ++++++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       |  597 ++++++++++++
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    9 +
 14 files changed, 2370 insertions(+), 194 deletions(-)


Regards
Adrian

