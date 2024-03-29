Return-Path: <linux-kernel+bounces-125134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A74892084
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4A2287BED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCD2033E;
	Fri, 29 Mar 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzUtUjy/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604541EF1E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726481; cv=none; b=EsAnRe/5R8cN02VpB7Lcth9MH1MZCaYWMWxINTJdGFCxWoew5E+4y3Oj0giR8nP8IqAXCoqxF7pL2TERU7YqFYxmIPgTjPTf8WTSVfsky/XI+KY0EXsYHEkYBKDHI9+QhJrG+qiXXzPAlrbY/u5IV/MmQ2rdtXziTtrTGddP6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726481; c=relaxed/simple;
	bh=/zf8QngZ3hyImBN4WDegCVS0Lx4ZiaoGVJ7Pg5Z+G4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LA/vLTXULjth4A/YqsvPxaYpIFSw87Wu5ha9UWP6t4J1eOgRXCJgDvFTBoju2V0Xof9KQNKFLROEGDcxhDytVZTwtg/xqQDEsSk/PZs43EmBsW/iw2ElSLb4hrZYb79+d6+vFUyZRpWtxCW8UTwlyYWKtIiIIWwp1HtIewQHnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FzUtUjy/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42TFO04M015461;
	Fri, 29 Mar 2024 15:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=Ve4J55T171tf8HtnHWyHJ1FgHOgS8+lZXPB68rADmJo=;
 b=FzUtUjy/Iio3JPP0uJypWlJXM1GRIQ9p4E8k4NyKw/9og/6RIwTbud06G1nE4WD3H09Z
 YP7pCNmMvqRwAx7rN1rvQG8vVCxY36mfqjGRWtFdrurDWzNVtJQf4AByBQtWoc2O4/47
 3eafSN4JZ/HNvttl73MaEpKgYQ/wqyx3zoNm/avGNREsPsXqgbnlW20H/Kc4l1bdrs/o
 LrGX5g+REG/bES+ioa5iECzMPg7oJwfqNVswmRS8BC12wFunFV1lBn6J5c7SDXu9BUZy
 h8mkw1HUSdFzCv7TpO5iutrS6SXA4aV2IY3g3JgoZ++fb5/k+y5y3LdJ80jL1Z+0igSD 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2kxe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 15:34:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42TEq361014352;
	Fri, 29 Mar 2024 15:34:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbe48s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 15:34:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42TFMGLb018586;
	Fri, 29 Mar 2024 15:34:18 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-175-60-105.vpn.oracle.com [10.175.60.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x1nhbe48f-1;
	Fri, 29 Mar 2024 15:34:18 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH V2] objtool/x86: objtool can confuse memory and stack access
Date: Fri, 29 Mar 2024 16:34:16 +0100
Message-Id: <20240329153416.899057-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=996 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290137
X-Proofpoint-GUID: yRPhRL9LQDawciyLdt-W0FQaSc5o_WJO
X-Proofpoint-ORIG-GUID: yRPhRL9LQDawciyLdt-W0FQaSc5o_WJO

The encoding of an x86 instruction can include a ModR/M and a SIB
(Scale-Index-Base) byte to describe the addressing mode of the
instruction.

objtool processes all addressing mode with a SIB base of 5 as having
%rbp as the base register. However, a SIB base of 5 means that the
effective address has either no base (if ModR/M mod is zero) or %rbp
as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
an absolute address access with a stack operation.

For example, objtool will see the following instruction:

 4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12

as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).

[Note that this kind of weird absolute address access is added by the
 compiler when using KASAN.]

If this perceived stack operation happens to reference the location
where %r12 was pushed on the stack then the objtool validation will
think that %r12 is being restored and this can cause a stack state
mismatch.

This kind behavior was seen on xfs code, after a minor change (convert
kmem_alloc() to kmalloc()):

>> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3a1d80a7878d3..5872818b8930c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -125,8 +125,14 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 #define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
 #define have_SIB() ((modrm_rm & 7) == CFI_SP && mod_is_mem())
 
+/*
+ * Check the ModRM register. If there is a SIB byte then check with
+ * the SIB base register. But if the SIB base is 5 (i.e. CFI_BP) and
+ * ModRM mod is 0 then there is no base register.
+ */
 #define rm_is(reg) (have_SIB() ? \
-		    sib_base == (reg) && sib_index == CFI_SP : \
+		    sib_base == (reg) && sib_index == CFI_SP && \
+		    (sib_base != CFI_BP || modrm_mod != 0):	\
 		    modrm_rm == (reg))
 
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
-- 
2.39.3


