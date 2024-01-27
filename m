Return-Path: <linux-kernel+bounces-41071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E283EB3E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C46281EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1129913FE7;
	Sat, 27 Jan 2024 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="K23S8VkV"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5C7F;
	Sat, 27 Jan 2024 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332621; cv=none; b=A3LQX9NADomKeEjvakIGt1PzX3MsgZyjvy3yKJwCyq2CuE3rqzEDjZP11yfy6j86njTXEQ5G0PQ5GKO6DJat+i+4reT+n6ewZoNx+ZYqyY/zJSHBkoy87VpZQm4+Bp+0h/YQAdvzh29+Z1bxSMip2on6aOep3Xqg6F9BT+gD88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332621; c=relaxed/simple;
	bh=2oy7FXJoc1dYh+Zik8b/XfAW1rAHXWBj27ZopQY1g/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX2g2DFqCyc8nFLyG+LpUW8eGxR80J0DTSDHGn8HQZSpEGeNLMJvRAN6KqR8mhmOg4rVBa6juO4yfMXaAusH3yOvqEhBM8eIPGVlnzn0NFuvq3lqAA0peamKap3w4G/H4R/ByL5rjlWhE6WGwLRC3uv2sr4QNQa0esJ1eQzhr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=K23S8VkV; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R4DcXU003200;
	Sat, 27 Jan 2024 04:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=LfUQSwHCxqCuC+PAruuCClPENWlIgNi29wcXxn4Mv64=;
 b=K23S8VkVEdyFCCxuhO5+cp457qW1pUtxhAVhXYi8gPmbUu1xtMhyiN0TyUpQT3BiE1AF
 LFvsSi3FkWNDmQmvLobHEInf7UXmhbIe2jNj4gMNkIc6Z/5LcQxTrCmfdkeRER1vEpHs
 3dTA2T0MDzs8GqAtNRkKkZ8UztimTaxNePA+kzDPny9nQgNZzPheMdGGce1Enc4Q4qKE
 23fNmhSBR8HSWfFUrBtxW/BNu7VMDidRSzOizP7uc1e8bNu+pV5SJp02I3OoFHlyN25v
 /99odRmHw3OTJPQwc3j99/0VGRjVXUNhhF1TzNkrvH6jQ5Ro0psHpW/rZwSBodYzo8rK ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vvr6sgk2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 04:41:43 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40R4fZW9019561;
	Sat, 27 Jan 2024 04:41:43 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3vvr6sgk26-2;
	Sat, 27 Jan 2024 04:41:43 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Date: Fri, 26 Jan 2024 22:41:23 -0600
Message-ID: <20240127044124.57594-2-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127044124.57594-1-jinghao7@illinois.edu>
References: <20240127044124.57594-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6AcGzVALhN6jMOtlsY4LV4ujrRjLfrRA
X-Proofpoint-ORIG-GUID: ZskEOsMGNoEg_vC6oFkBJuWgxorMRFdc
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=789 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270033
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Both INTs (INT n, INT1, INT3, INTO) and UDs (UD0, UD1, UD2) serve
special purposes in the kernel, e.g., INT3 is used by KGDB and UD2 is
involved in LLVM-KCFI instrumentation. At the same time, attaching
kprobes on these instructions (particularly UDs) will pollute the stack
trace dumped in the kernel ring buffer, since the exception is triggered
in the copy buffer rather than the original location.

Check for INTs and UDs in can_probe and reject any kprobes trying to
attach to these instructions.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 arch/x86/kernel/kprobes/core.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index e8babebad7b8..792b38d22126 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -252,6 +252,22 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
 	return __recover_probed_insn(buf, addr);
 }
 
+static inline int is_exception_insn(struct insn *insn)
+{
+	if (insn->opcode.bytes[0] == 0x0f) {
+		/* UD0 / UD1 / UD2 */
+		return insn->opcode.bytes[1] == 0xff ||
+		       insn->opcode.bytes[1] == 0xb9 ||
+		       insn->opcode.bytes[1] == 0x0b;
+	} else {
+		/* INT3 / INT n / INTO / INT1 */
+		return insn->opcode.bytes[0] == 0xcc ||
+		       insn->opcode.bytes[0] == 0xcd ||
+		       insn->opcode.bytes[0] == 0xce ||
+		       insn->opcode.bytes[0] == 0xf1;
+	}
+}
+
 /* Check if paddr is at an instruction boundary */
 static int can_probe(unsigned long paddr)
 {
@@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
 #endif
 		addr += insn.length;
 	}
+	__addr = recover_probed_instruction(buf, addr);
+	if (!__addr)
+		return 0;
+
+	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
+		return 0;
+
+	if (is_exception_insn(&insn))
+		return 0;
+
 	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
 		/*
 		 * The compiler generates the following instruction sequence
@@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
 		 * Also, these movl and addl are used for showing expected
 		 * type. So those must not be touched.
 		 */
-		__addr = recover_probed_instruction(buf, addr);
-		if (!__addr)
-			return 0;
-
-		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
-			return 0;
-
 		if (insn.opcode.value == 0xBA)
 			offset = 12;
 		else if (insn.opcode.value == 0x3)
-- 
2.43.0


