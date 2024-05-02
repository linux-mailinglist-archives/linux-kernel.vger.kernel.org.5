Return-Path: <linux-kernel+bounces-166358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37878B9989
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46561C213D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EE62A02;
	Thu,  2 May 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFgW7b4H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216085F84F;
	Thu,  2 May 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647564; cv=none; b=ZF48tsexEt4jKrETL8fPnv1VmEF/qdij8sVO6xx+jpWhR5/hQtR+0IuIVw5DVwZaTWOAHYfz8504t2gIcb6uLdP1Kyz802RJvZhPlkoHCTkdLlrAdLBxyi/m2xwHz517RuSODuNjHeKKeZZh8sY4ktcHLxe7SNFh8Z8hId+7VjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647564; c=relaxed/simple;
	bh=NNFviughzQ3a6Z7/wNHw2sov/UpBM8nlPRe20s5qNWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k23aFsc98p7r34wOlHD4n1l82L2+KC9UQSjsmIXiRkNyS07kJbGDB+k18jgnnTvqf40xXNOkOxedaEAyrIifMMEPoOejkbRYnYq5hhgf40JNiGLEUJVJ/NUsTO+Vq+Jf5A5hKyz5D+HYEmo1A/YzBAQ8eBbYsQ5+azXQQCGyL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFgW7b4H; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647561; x=1746183561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NNFviughzQ3a6Z7/wNHw2sov/UpBM8nlPRe20s5qNWo=;
  b=nFgW7b4HLSkiR/FMJv+AvmDRmv24qfQ/W4c4Lxf0N4jcWuXBLLWjrSiF
   vkklqKdMXgEzHnVrw8/a/3Yhdm0jNbFhEn9PYknwLoNcEsujYhKFRWun+
   EYgP9EX+qCwpBu/AW0phEglTlE/IP5kg7DptHpk18g8Ih/qwSe/ju1G4A
   97Ua6F4zWnC+bB3HcUhmzVo/DZ0LvdsYQjZw8GFhU91nuXOVWB6ZHjSI7
   D7wEDYKz6hp7tL+x4QCiUpibBqMos1ZeDxX5/ow/KGPqBO69qlGwxCMe3
   D22SoN22KXcyrEAjgjpUpnEZhCkvjgb7R6wLCGSDsAJcUGMwVCDvbOmE8
   A==;
X-CSE-ConnectionGUID: r7gycx+4Que6Ba3+aFLCkQ==
X-CSE-MsgGUID: UvtPojLfQDG0/PotcX+amw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228574"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228574"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:20 -0700
X-CSE-ConnectionGUID: vyxYADehRpu1KKYdXVKmEw==
X-CSE-MsgGUID: luf//AFfTES2FIa7/yZflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50278876"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:16 -0700
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
Subject: [PATCH 02/10] x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
Date: Thu,  2 May 2024 13:58:45 +0300
Message-Id: <20240502105853.5338-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502105853.5338-1-adrian.hunter@intel.com>
References: <20240502105853.5338-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The x86 instruction decoder is used not only for decoding kernel
instructions. It is also used by perf uprobes (user space probes) and by
perf tools Intel Processor Trace decoding. Consequently, it needs to
support instructions executed by user space also.

Opcode 0x68 PUSH instruction is currently defined as 64-bit operand size
only i.e. (d64). That was based on Intel SDM Opcode Map. However that is
contradicted by the Instruction Set Reference section for PUSH in the
same manual.

Remove 64-bit operand size only annotation from opcode 0x68 PUSH
instruction.

Example:

  $ cat pushw.s
  .global  _start
  .text
  _start:
          pushw   $0x1234
          mov     $0x1,%eax   # system call number (sys_exit)
          int     $0x80
  $ as -o pushw.o pushw.s
  $ ld -s -o pushw pushw.o
  $ objdump -d pushw | tail -4
  0000000000401000 <.text>:
    401000:       66 68 34 12             pushw  $0x1234
    401004:       b8 01 00 00 00          mov    $0x1,%eax
    401009:       cd 80                   int    $0x80
  $ perf record -e intel_pt//u ./pushw
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.014 MB perf.data ]

 Before:

  $ perf script --insn-trace=disasm
  Warning:
  1 instruction trace errors
           pushw   10349 [000] 10586.869237014:            401000 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           pushw $0x1234
           pushw   10349 [000] 10586.869237014:            401006 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb %al, (%rax)
           pushw   10349 [000] 10586.869237014:            401008 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb %cl, %ch
           pushw   10349 [000] 10586.869237014:            40100a [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb $0x2e, (%rax)
   instruction trace error type 1 time 10586.869237224 cpu 0 pid 10349 tid 10349 ip 0x40100d code 6: Trace doesn't match instruction

 After:

  $ perf script --insn-trace=disasm
             pushw   10349 [000] 10586.869237014:            401000 [unknown] (./pushw)           pushw $0x1234
             pushw   10349 [000] 10586.869237014:            401004 [unknown] (./pushw)           movl $1, %eax

Fixes: eb13296cfaf6 ("x86: Instruction decoder API")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index c94988d5130d..4ea2e6adb477 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index c94988d5130d..4ea2e6adb477 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
-- 
2.34.1


