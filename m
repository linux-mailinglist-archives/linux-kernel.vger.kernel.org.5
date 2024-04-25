Return-Path: <linux-kernel+bounces-158990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3148B27D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F421F21673
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832C1514E6;
	Thu, 25 Apr 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKDhNvoH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CF1509A2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068361; cv=none; b=RbL91BcQCqBfxPaewFrsKrKTFlqOTbZCniXj9Qf1p5QyUwXByy5q9sGFNRmOXXBizhWk0ltsgxeZK1YAtWbOzHdvGprPpovanI007fqpjra+h2c+6NuWoN5WmpTLLpDHNI+waAWH/emQTsvaEXvf9nWgpgdXmZemlF3KuZ9cBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068361; c=relaxed/simple;
	bh=cI7gssY7RK5sFBcqYPd69se9pxreozcJ57b2DuII1KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYAolIKe3PbSfWFwFB/ImdpLa+7GfM6J8+J2Dv8Kt3PhwcCQFTFQ+1wYKDvM+zVqJoAoeBYf0QL9wML/DeQW+/sIg9LAfcZmQ/jgP68yeA0yXhbTR7LxJ7wrazt9fCEXL9V66sjOZ7pMMbhufN8Viq2UZnN2oj0y/BmrxIa977g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YKDhNvoH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHNxlJ024243;
	Thu, 25 Apr 2024 18:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=PpOUtB30mkU/WhCWnJO885CVzo2dXyXZaqQ4tqSiGwI=;
 b=YKDhNvoHpKYAErNlmQk2logYk3ypjlQqNq3+B8s0SA0SHZ/YVKzljLac3pjO4zVFvnmU
 dAT6PAfzsk0vSsE7DFZA7iczqzGPx5DsWRG4PJIMWDuMyfNHDHVYptYC9zF6abvqLoFR
 QB3S4Wy8RGDUJB985WjpyzDYS+2bMBsxchGwS2DrBuLP+hseSWrgooYzlStXRZnnab4F
 wOsPfETdnA8wRaa11Dg8LoKp/NdKu2tazzaLt5+EWyPdLHdEbVnZy919k7Rxbh/7aL8C
 17hVyxfT8CnVCbJ9ZeWB+Yf9/Sl4KA/YlQ87pCh3taiTx4cwbP/G04+bfmeViVHyVDup 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re44gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PGTbR6001812;
	Thu, 25 Apr 2024 18:05:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45be425-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:49 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PI20Kj032785;
	Thu, 25 Apr 2024 18:05:48 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm45be3wd-4;
	Thu, 25 Apr 2024 18:05:48 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v3 3/4] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
Date: Thu, 25 Apr 2024 18:05:41 +0000
Message-Id: <20240425180542.1042933-4-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250131
X-Proofpoint-ORIG-GUID: E0CnQJjba1e4Np_Llegy2PTRtSuUzgLD
X-Proofpoint-GUID: E0CnQJjba1e4Np_Llegy2PTRtSuUzgLD

If the alternate signal stack is protected by a different pkey than the
current execution stack, copying xsave data to the altsigstack will fail
if its pkey is not enabled. This commit enables all pkeys before xsave,
so that the signal handler accessibility is not dictated by the PKRU
value that the thread sets up. It then writes the original PKRU value
onto the sigframe so that it's restored correctly from sigcontext.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 11 +++++++++--
 arch/x86/kernel/signal.c     |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index dce84cce7cf8..5d52c7fde43b 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -185,8 +185,15 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf,
 					  u32 pkru)
 {
-	if (use_xsave())
-		return xsave_to_user_sigframe(buf);
+	int err = 0;
+
+	if (use_xsave()) {
+		err = xsave_to_user_sigframe(buf);
+		if (!err && cpu_feature_enabled(X86_FEATURE_OSPKE))
+			err = __update_pkru_in_sigframe(buf, pkru);
+		return err;
+	}
+
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 75dfd05c59aa..c985bdfd855a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -278,6 +278,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
+	pkru = sig_prepare_pkru();
 	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
 	if (!failed) {
 		/*
@@ -295,6 +296,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
 		fpu__clear_user_states(fpu);
+	} else {
+		write_pkru(pkru);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
-- 
2.39.3


