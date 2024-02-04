Return-Path: <linux-kernel+bounces-51436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0536848B31
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF662844C9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4226FA8;
	Sun,  4 Feb 2024 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="khJzISEW"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61D6119;
	Sun,  4 Feb 2024 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707024182; cv=none; b=B/0kZDPhpwCFbw2x2qHl7EnCni75NFyeiXXYZl5egF+9WEYEMyWVsd8UfuUMqcgFKIDH7x7Ryrzyn4ykQdB+rEGIYeg/N5/gc3y8SnATRANdvw+NsyfqK5wjtpdDZRJ7uO7MUbmHGFLqCSMWvFzVY3oMWc1zpZydyko5JFPCZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707024182; c=relaxed/simple;
	bh=UyQtY5NzwuQh5f8YBmtuvP5BCquorDhnoNHeHzzRUOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1EE8UgVl31TrHPXuIM+ZQU2tsk876x6n5Uop1U+47Zs4/xZ58YR4jeDoELGlr0Z/EFq8aNfYXPbmEGCbIpz5lUDbMuDP/2rqMInWZkJSiQjaMO8FsQe60Fxj7K7Tad0TZuvqQEQILCM+Kietm9bH5/rk/UPSmWs/7NteGiV3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=khJzISEW; arc=none smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4142fM2V032217;
	Sun, 4 Feb 2024 03:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=8U/uRPUZ4LmGmqQfXkYTK77RgNRpuaAarihJR0mJhDA=;
 b=khJzISEWHGYeSlSHd+aovNPF7cTLl2U1ohNvSG4mQCuUQ3P+pgXiDgUkoDeBwkCQgsU8
 LRYttbHmF3YtW70lEUaSuKkiT8heve4LAR3fyQZP350l2tFp7iQ1rBGhuCxybt73PiLy
 YdnvFt502AYf74YviWdk0ybK5dy6/+YMMwZqMUtSPcRztEZcYbJL26+pSibG6DVxSDxB
 yM5NUVIFckBbOgCAEbvHejYeHtYlS6lCfUlpxeZ2/PM3Mdliz3IftGgY7jJ8LA5SA4Eg
 EFRkcUFGMBC1KoIhKJzgKz3FpkBO5nMZQaaTCtJfNVO3La0oNSHwj4KgqRKzF5rAJasa Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3w1e8n4ktv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 03:13:06 +0000
Received: from m0166257.ppops.net (m0166257.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4143D4G0010150;
	Sun, 4 Feb 2024 03:13:06 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0a-00007101.pphosted.com (PPS) with ESMTP id 3w1e8n4ktm-3;
	Sun, 04 Feb 2024 03:13:06 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin@zytor.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH v2 2/3] x86/kprobes: Prohibit kprobing on INT and UD
Date: Sat,  3 Feb 2024 21:12:59 -0600
Message-ID: <20240204031300.830475-3-jinghao7@illinois.edu>
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
X-Proofpoint-GUID: pTjztUL61FTrJXA6ja-s8oTry9VD_41U
X-Proofpoint-ORIG-GUID: 3fRQU1wk2aq7g_e9smfCVJe3fgw5voOI
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402040022
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Both INT (INT n, INT1, INT3, INTO) and UD (UD0, UD1, UD2) serve special
purposes in the kernel, e.g., INT3 is used by KGDB and UD2 is involved
in LLVM-KCFI instrumentation. At the same time, attaching kprobes on
these instructions (particularly UD) will pollute the stack trace dumped
in the kernel ring buffer, since the exception is triggered in the copy
buffer rather than the original location.

Check for INT and UD in can_probe and reject any kprobes trying to
attach to these instructions.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 arch/x86/kernel/kprobes/core.c | 48 +++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 644d416441fb..7a08d6a486c8 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -252,7 +252,28 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
 	return __recover_probed_insn(buf, addr);
 }
 
-/* Check if paddr is at an instruction boundary */
+/* Check if insn is INT or UD */
+static inline bool is_exception_insn(struct insn *insn)
+{
+	/* UD uses 0f escape */
+	if (insn->opcode.bytes[0] == 0x0f) {
+		/* UD0 / UD1 / UD2 */
+		return insn->opcode.bytes[1] == 0xff ||
+		       insn->opcode.bytes[1] == 0xb9 ||
+		       insn->opcode.bytes[1] == 0x0b;
+	}
+
+	/* INT3 / INT n / INTO / INT1 */
+	return insn->opcode.bytes[0] == 0xcc ||
+	       insn->opcode.bytes[0] == 0xcd ||
+	       insn->opcode.bytes[0] == 0xce ||
+	       insn->opcode.bytes[0] == 0xf1;
+}
+
+/*
+ * Check if paddr is at an instruction boundary and that instruction can
+ * be probed
+ */
 static bool can_probe(unsigned long paddr)
 {
 	unsigned long addr, __addr, offset = 0;
@@ -291,6 +312,22 @@ static bool can_probe(unsigned long paddr)
 #endif
 		addr += insn.length;
 	}
+
+	/* Check if paddr is at an instruction boundary */
+	if (addr != paddr)
+		return false;
+
+	__addr = recover_probed_instruction(buf, addr);
+	if (!__addr)
+		return false;
+
+	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
+		return false;
+
+	/* INT and UD are special and should not be kprobed */
+	if (is_exception_insn(&insn))
+		return false;
+
 	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
 		/*
 		 * The compiler generates the following instruction sequence
@@ -305,13 +342,6 @@ static bool can_probe(unsigned long paddr)
 		 * Also, these movl and addl are used for showing expected
 		 * type. So those must not be touched.
 		 */
-		__addr = recover_probed_instruction(buf, addr);
-		if (!__addr)
-			return false;
-
-		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
-			return false;
-
 		if (insn.opcode.value == 0xBA)
 			offset = 12;
 		else if (insn.opcode.value == 0x3)
@@ -325,7 +355,7 @@ static bool can_probe(unsigned long paddr)
 	}
 
 out:
-	return (addr == paddr);
+	return true;
 }
 
 /* If x86 supports IBT (ENDBR) it must be skipped. */
-- 
2.43.0


