Return-Path: <linux-kernel+bounces-51425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D10848B11
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86141F225B5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603DE4409;
	Sun,  4 Feb 2024 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="B9CDCUQN"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DD7460;
	Sun,  4 Feb 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021931; cv=none; b=ZtXdMfaoe+rTxU3JegeGxlqoGxsPoeIy3HgpkQg6CNg9ryJdk/xpAOEPe90cS7QsYtE1eb6sWxUxXRjRGaC75fZtHI5ehguSXlOMY809Inu5+U/xH9gGdg4P3y8CaCgqOrMJSCekr99m9qvP1fwwV2fQqNFSu++g3uGnDp532Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021931; c=relaxed/simple;
	bh=cqAZVRCbOXBgk10uwImR7+eKfgO2Qe7PuU3zufmS+y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo+pZO3UaYnCdDpcknXFUTRejfUxJn0rOIetCVGC4NHtESseR7gSVm9vmxa5+JjZlq7mSTR5pM4gnZthjQJozklNlpzq91JJw0YOjyIDjhjPcf6h8NYZm1+3ttBsFI2Vnkr1YUJDhXfrqIlK3S/Attcw9M+zq5rck8EHCBb5/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=B9CDCUQN; arc=none smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4142oQ1A012456;
	Sun, 4 Feb 2024 03:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=UaL3xCx8AUncFg+isg4UuFMjDAHuz/SlcxJjBkpVqCM=;
 b=B9CDCUQN3zDFBCCGiaUCLDwePzw1IonQjBqfD8408/OH+b+Ua80ddiA2AsDpHy7tbcpK
 ODw5//Z1iEZEh4gpA2i/izSDqffEMCS76Yb1ObhOeqg84QrW7rkZtyVcklA5WAZxa/Y+
 rwIpRrhF5m+Hu9yKEYBQ0LX4XcTTdEMf/qJLs43Ra2T4UbWskLT+jXNw6v8tc63hppT8
 S+uOcb9b5Eijqdi/g+iAwCd2AHOo3SRSBBtez5Wc0QJO7/N5CmcxK+TeTBfahrvp/PLT
 z4WxKpDUM2ecgpSokxHfw9yaXhi4p5A7ZKdalmx635kMDTY0dQ85QUtHZePHbIEUWM8I jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3w1e8n4ku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 03:13:07 +0000
Received: from m0166257.ppops.net (m0166257.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4143D4G2010150;
	Sun, 4 Feb 2024 03:13:07 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0a-00007101.pphosted.com (PPS) with ESMTP id 3w1e8n4ktm-4;
	Sun, 04 Feb 2024 03:13:07 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin@zytor.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH v2 3/3] x86/kprobes: Boost more instructions from grp2/3/4/5
Date: Sat,  3 Feb 2024 21:13:00 -0600
Message-ID: <20240204031300.830475-4-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204031300.830475-1-jinghao7@illinois.edu>
References: <20240204031300.830475-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: czHbX_K7foO7WJCefQH9zPBPKAETMcJM
X-Proofpoint-ORIG-GUID: 9XqJBTkOjiePTMozqFeXhqssPsd8m9Fm
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402040022
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
 arch/x86/kernel/kprobes/core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7a08d6a486c8..530f6d4b34f4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -169,22 +169,33 @@ bool can_boost(struct insn *insn, void *addr)
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
 		return false;
+	case 0xc0 ... 0xc1:	/* Grp2 */
+	case 0xd0 ... 0xd3:	/* Grp2 */
+		/*
+		 * AMD uses nnn == 110 as SHL/SAL, but Intel makes it reserved.
+		 */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) != 0b110;
+	case 0xf6 ... 0xf7:	/* Grp3 */
+		/* AMD uses nnn == 001 as TEST, but Intel makes it reserved. */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) != 0b001;
+	case 0xfe:		/* Grp4 */
+		/* Only INC and DEC are boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0b000 ||
+		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b001;
 	case 0xff:		/* Grp5 */
-		/* Only indirect jmp is boostable */
-		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
+		/* Only INC, DEC, and indirect JMP are boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0b000 ||
+		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b001 ||
+		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b100;
 	default:
 		return true;
 	}
-- 
2.43.0


