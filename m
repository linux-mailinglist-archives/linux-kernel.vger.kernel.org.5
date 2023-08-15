Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C077CEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbjHOPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbjHOPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:12:33 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401661737;
        Tue, 15 Aug 2023 08:12:32 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FDjmUu006792;
        Tue, 15 Aug 2023 08:12:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=pfptdkimsnps; bh=n84xbQoUW83vqJus6c8czr5VRDIzztj+K2pbIYP91R0=;
 b=fxbzpxR3/TwkP0vzQjPg6lzrnfx3v3AVHC5PZMy3z7WYL60oRry84Udg+STyJREXmOHu
 cwLFSMtZqBbw8jNkhOj0VTQLzKzugYNjfUzTw2v7AEbSskTrisTwmMj0MKPyIu7kdCRR
 XsDdsHdnM/eK1ofGZRkUDtpXXRF1y9TuRIyPUt8hW2tl+6LgCS381QFDmy3EB5/cssuR
 Upzqv9ZxRJbmb6/VP41FkzmElKN073UK5pGLvBe+5NCS3wH52iB9WKwo4lVQqu8zPI2H
 Ep9Cg97mohDVCf8iiEpi2QoVnZS8CwGLdR7cUz0GLl5TGbgF1HoYNQGSh7mflB3LkOZC JA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3se8qd6rbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:12:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692112338; bh=vMpHfhpzpfw50BBq390znIY3g/XxaVW9isAEYbS6FH8=;
        h=From:To:Cc:Subject:Date:From;
        b=hWT3uAuvL4cxJ76D5v0h4Ly1IHrYHhXyIHXrHtSGXHylbY4bnhagCFk5KkSMGiTXP
         rVMbkt04d+c5jOC4EB5FxS5cfBvnZu6NQFmj2FpvF+nszG8ISsEIsPtXQNyCCNfVNW
         y/g4m9w2pRcsHOq1uv/RHwMElGHO3lAJQBKuI0iKS+kdCCDi7VUXPyXAg/QpPeEksy
         XUD89Fgc1j5hqC68dX3oYT0tdOpSHbYFs8Bkv+TX/12l83qJsD2M2gpWU/avmnoacN
         jCToaH6lhEoVjG7hGD6bnh/ECRFaGq2Q8d3/jvhPOTSGOeTk1MDP1EZraETSnTZx/J
         K4jPh1Njq27dA==
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4837040149;
        Tue, 15 Aug 2023 15:12:18 +0000 (UTC)
Received: from SNPS-o0WHuHJU73.internal.synopsys.com (snps-o0whuhju73.internal.synopsys.com [10.116.106.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 0A303A005D;
        Tue, 15 Aug 2023 15:12:13 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Pavel.Kozlov@synopsys.com
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vgupta@kernel.org,
        Pavel Kozlov <Pavel.Kozlov@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARC: avoid unwanted gcc optimizations in atomic operations
Date:   Tue, 15 Aug 2023 19:11:36 +0400
Message-Id: <20230815151136.2220588-1-kozlov@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kcK-i6Ujx8QPu7hMhdv0YPEL1p1xD9J4
X-Proofpoint-GUID: kcK-i6Ujx8QPu7hMhdv0YPEL1p1xD9J4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxlogscore=781 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Kozlov <pavel.kozlov@synopsys.com>

Notify a compiler about write operations and prevent unwanted
optimizations. Add the "memory" clobber to the clobber list.

An obvious problem with unwanted compiler optimizations appeared after
the cpumask optimization commit 596ff4a09b89 ("cpumask: re-introduce
constant-sized cpumask optimizations").

After this commit the SMP kernels for ARC no longer loads because of
failed assert in the percpu allocator initialization routine:

percpu: BUG: failure at mm/percpu.c:2981/pcpu_build_alloc_info()!

The write operation performed by the scond instruction in the atomic
inline asm code is not properly passed to the compiler. The compiler
cannot correctly optimize a nested loop that runs through the cpumask
in the pcpu_build_alloc_info() function.

Add the "memory" clobber to fix this.

Link: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/135
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Pavel Kozlov <pavel.kozlov@synopsys.com>
---
 arch/arc/include/asm/atomic-llsc.h    | 6 +++---
 arch/arc/include/asm/atomic64-arcv2.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/atomic-llsc.h b/arch/arc/include/asm/atomic-llsc.h
index 1b0ffaeee16d..5258cb81a16b 100644
--- a/arch/arc/include/asm/atomic-llsc.h
+++ b/arch/arc/include/asm/atomic-llsc.h
@@ -18,7 +18,7 @@ static inline void arch_atomic_##op(int i, atomic_t *v)			\
 	: [val]	"=&r"	(val) /* Early clobber to prevent reg reuse */	\
 	: [ctr]	"r"	(&v->counter), /* Not "m": llock only supports reg direct addr mode */	\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 }									\
 
 #define ATOMIC_OP_RETURN(op, asm_op)				\
@@ -34,7 +34,7 @@ static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 	: [val]	"=&r"	(val)						\
 	: [ctr]	"r"	(&v->counter),					\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 									\
 	return val;							\
 }
@@ -56,7 +56,7 @@ static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 	  [orig] "=&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 									\
 	return orig;							\
 }
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index 6b6db981967a..9b5791b85471 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -60,7 +60,7 @@ static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
 	"	bnz     1b		\n"				\
 	: "=&r"(val)							\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");							\
+	: "cc", "memory");						\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
@@ -77,7 +77,7 @@ static inline s64 arch_atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)	\
 	"	bnz     1b		\n"				\
 	: [val] "=&r"(val)						\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
+	: "cc", "memory");						\
 									\
 	return val;							\
 }
@@ -99,7 +99,7 @@ static inline s64 arch_atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)	\
 	"	bnz     1b		\n"				\
 	: "=&r"(orig), "=&r"(val)					\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
+	: "cc", "memory");						\
 									\
 	return orig;							\
 }
-- 
2.25.1

