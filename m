Return-Path: <linux-kernel+bounces-41073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D383EB4B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D81F28509B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313B14294;
	Sat, 27 Jan 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="A4xfiP5M"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF213FF6;
	Sat, 27 Jan 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706333491; cv=none; b=YyNN2MAO7Ai3LHu5aB4oZUZOpMUlSuSEoItIhOmjMXzdwdh6nlGt5misGV7iiryQvyVUR1SnqiltuWmnpl+kna/oq7DdNyxiZyu9pv8DFHsRD20ubT4LKZYKlyJqq5PsRTapSLVbf/x9km9rDOrzaNcLMfwewUC4zqL8LkG5Eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706333491; c=relaxed/simple;
	bh=stu1F0JfOCHjg7AgZJrbtdkqx432uMQgP9mHUw9Mn38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhgS4V1nFYH61gT/bynmVJC09R/RaaqabLI3dlH8if0/YE1In9mdFY0Pk0zS4uOrf6mwZRP4QM5dlxSwLV4MEkCmJP65nO+Ls+kUagxq5flqbQeChhKci3N+Zw5Teaegr5lfF4at65NU/XELLGa5ymsxFxV7B9nqlZGlpZfL8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=A4xfiP5M; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R4S5C0030863;
	Sat, 27 Jan 2024 04:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=zanHTTHL7xpzc2N9psUavdOTb7nP0R5LEXpPiANsROQ=;
 b=A4xfiP5ML8jgQBTuSyngHnwxZe0/tV4ghsLfdXdT5z7Z/jnOdJAcnMaY3lBhhGSvpzL2
 ybtx+ji+mmBn6AB/puGsdtmCgbEiiMqaXcBI7HiEIqX8W/CVzwfZUFBXcLSInN+Qb+1G
 +y/wApMchHajjh2PViU+PEWA9oM8onfVhlDDN0S0ocwIOYkTKam/l8nlWwvJ1IkjsN/k
 2EANpWjpWIxSm2tb2cH44vvT1kuhA208aurMv09wZr4oQD+Fq2g+09+0w2zR4cxpuYdL
 qF/UtCUaNtl7sczqKi3iM/oTK9Nc6QWsEUfdcxVr3dJn+DaDQv4ePqjZb064ivM8o3sH SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vvr6sgk2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 04:41:44 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40R4fZWB019561;
	Sat, 27 Jan 2024 04:41:44 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3vvr6sgk26-3;
	Sat, 27 Jan 2024 04:41:44 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [RFC PATCH 2/2] x86/kprobes: boost more instructions from grp2/3/4/5
Date: Fri, 26 Jan 2024 22:41:24 -0600
Message-ID: <20240127044124.57594-3-jinghao7@illinois.edu>
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
X-Proofpoint-GUID: to-4KoCvOCZefqxN8lWquI0J_-KXG8Ug
X-Proofpoint-ORIG-GUID: F63QRDlgMhTLTfrSvjsA8EYkXX_AWl5d
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=773 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270033
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

With the instruction decoder, we are now able to decode and recognize
instructions with opcode extensions. There are more instructions in
these groups that can be boosted:

Group 2: ROL, ROR, RCL, RCR, SHL/SAL, SHR, SAR
Group 3: TEST, NOT, NEG, MUL, IMUL, DIV, IDIV
Group 4: INC, DEC (byte operation)
Group 5: INC, DEC (word/doubleword/quadword operation)

These instructions are not boosted previously because there are reserved
opcodes within the groups, e.g., group 2 with ModR/M.nnn == 110 is
unmapped. As a result, kprobes attached to them requires two int3 traps
as being non-boostable also prevents jump-optimization.

Some simple tests on QEMU show that after boosting and jump-optimization
a single kprobe on these instructions with an empty pre-handler runs 10x
faster (~1000 cycles vs. ~100 cycles).

Since these instructions are mostly ALU operations and do not touch
special registers like RIP, let's boost them so that we get the
performance benefit.

Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 arch/x86/kernel/kprobes/core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 792b38d22126..f847bd9cc91b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -169,22 +169,31 @@ int can_boost(struct insn *insn, void *addr)
 	case 0x62:		/* bound */
 	case 0x70 ... 0x7f:	/* Conditional jumps */
 	case 0x9a:		/* Call far */
-	case 0xc0 ... 0xc1:	/* Grp2 */
 	case 0xcc ... 0xce:	/* software exceptions */
-	case 0xd0 ... 0xd3:	/* Grp2 */
 	case 0xd6:		/* (UD) */
 	case 0xd8 ... 0xdf:	/* ESC */
 	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
 	case 0xe8 ... 0xe9:	/* near Call, JMP */
 	case 0xeb:		/* Short JMP */
 	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
-	case 0xf6 ... 0xf7:	/* Grp3 */
-	case 0xfe:		/* Grp4 */
 		/* ... are not boostable */
 		return 0;
+	case 0xc0 ... 0xc1:	/* Grp2 */
+	case 0xd0 ... 0xd3:	/* Grp2 */
+		/* ModR/M nnn == 110 is reserved */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) != 6;
+	case 0xf6 ... 0xf7:	/* Grp3 */
+		/* ModR/M nnn == 001 is reserved */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) != 1;
+	case 0xfe:		/* Grp4 */
+		/* Only inc and dec are boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0 ||
+		       X86_MODRM_REG(insn->modrm.bytes[0]) == 1;
 	case 0xff:		/* Grp5 */
-		/* Only indirect jmp is boostable */
-		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
+		/* Only inc, dec, and indirect jmp are boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0 ||
+		       X86_MODRM_REG(insn->modrm.bytes[0]) == 1 ||
+		       X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
 		return 1;
 	}
-- 
2.43.0


