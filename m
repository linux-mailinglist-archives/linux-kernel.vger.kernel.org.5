Return-Path: <linux-kernel+bounces-166395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C18B9A06
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FF6287CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600283CC0;
	Thu,  2 May 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vjW5ckz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgMFHWTM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C96F073;
	Thu,  2 May 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649179; cv=none; b=aLRcIyRBib4/QAN8x0ejumxMi5lWTuNl9TqC7uW8VLIYRTRl4sui3PGWpDfMA5ifkQOq0ZJX1MugJZ+EibZFySgCI5CYXWGHIYyfskXnzVjHCMzyIvgA3RR4aHvPZzp29IBv57D5YtO2Ee2jm8iq/wa2IkdrER5OEN5s3Kue+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649179; c=relaxed/simple;
	bh=VYNAaxOZS5AksDxAuRXVjx/C0He2up/qfnRAOUxScDY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NVrfgd/MUJ+fX4QWr9JkoTJ12X+QZgN9q6u9GsBNy0vsTPD7rCyx8yjAuW9C9oXTnts4Ha5+YtzJozdLpTuZe8JO1TAlx4GVg68+QykmAw7c0I+dAWCPEMzyV/58OaEtSKuX824cQN3ZX8BSL+sxEaV1+TxIvwHtKLtFl9KtLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vjW5ckz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgMFHWTM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:26:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZh7i7rDP3k2rF6lNeHUpW0Dya9k3ME96enBIlnDGBE=;
	b=1vjW5ckzYuoXnl6Cz2MetnxLt+eI89ThTHqBvhAXrPh2rARHD/qCJfKXCaP6GEPVzE4ovf
	o8hFoqN0dm568RDDM+7TNjWkqWNuBJBUjXb1ulIzWGujY20qnF6UcGhq/LkQ9mBF+htXeV
	T1Cv3Rwu5AykHzIpONsvRcVebVuMuVOrELX6NmDuL+ZKNJPM59iGxqPwO8UKQkrAPybRoW
	4yunwQW9q3wMdgKMMNvwreoje4j7PEjci1vRPdcQKS3v4TzPYgr0dL0t1NTCNJBiKlu4Ko
	H9Q4MPrlEr00arFEOSHVmuSDUAAShl1xnc3t/85OR0Gf9Kgdj2Ne7Io9BfcPzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZh7i7rDP3k2rF6lNeHUpW0Dya9k3ME96enBIlnDGBE=;
	b=RgMFHWTMQymcoSTbDRYfK23gHGWk8y5JNN2a+KtAOu0ZXTqEm5vPg7LUyDUGez2F69mKTP
	m831nObYzbNL0uCg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Fix PUSH instruction in x86 instruction
 decoder opcode map
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-3-adrian.hunter@intel.com>
References: <20240502105853.5338-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917311.10875.9987680443195298218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59162e0c11d7257cde15f907d19fefe26da66692
Gitweb:        https://git.kernel.org/tip/59162e0c11d7257cde15f907d19fefe26da66692
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:45 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:41 +02:00

x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-3-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index c94988d..4ea2e6a 100644
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
index c94988d..4ea2e6a 100644
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

