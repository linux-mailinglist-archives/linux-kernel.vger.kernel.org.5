Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD779026C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbjIATPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjIATPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:15:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD3D10DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:15:20 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381J9HNH006835;
        Fri, 1 Sep 2023 19:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s+3NeorMcULnI76AxEKRXmNLozU/9pZ6CJ5NNbhCP9A=;
 b=OJuHOXyn1/C8LkiswmZEEIdppakdqr5jL7x8PJtwdBqi+iq/JqqhPkIrOPFcnCVLgyf4
 avAbU/wkWWzoEngh79UK2gl+OZ2x4KTfpLc3YrFgcbiVBtNhzPRB1Qp4bvEWVeQiwR5i
 QYvVW72MBLZYldfNy2UCdccbyvSfJCkAQyBYs9sdf8t6FBHR5EmTPFw5jB6/uLyo/V1f
 nMpAOi0eNbnOUQonaQB+NszQri9C+iDwmsjhFDR6vYJXQ8tqRoKRfjc0EPHfwFrIMzgu
 5YP9TKDmxk+kMYjTmYFj//GdBayu2Osgo4aomPTGWsFONu2pIevUhJcmfcSsk4EpVxmJ 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sunpdrs2w-67
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 19:15:05 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381J0atd017105;
        Fri, 1 Sep 2023 19:07:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sunpdrc38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 19:07:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 381Ibcgj004891;
        Fri, 1 Sep 2023 19:04:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqtfh1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 19:04:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 381J4hSl17760990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 19:04:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C3B420043;
        Fri,  1 Sep 2023 19:04:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7039820040;
        Fri,  1 Sep 2023 19:04:41 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.87.168])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Sep 2023 19:04:41 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/fadump: make is_kdump_kernel() return false when fadump is active
Date:   Sat,  2 Sep 2023 00:34:38 +0530
Message-ID: <20230901190438.375678-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901190438.375678-1-hbathini@linux.ibm.com>
References: <20230901190438.375678-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hYavF-Vx3mzG0UCkc-WOOU12s7d6S7mh
X-Proofpoint-GUID: Fr0uXum4M1SzGrwM4gQ4xCzeYmB3yEYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010179
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, is_kdump_kernel() returns true in crash dump capture kernel
for both kdump and fadump crash dump capturing methods, as both these
methods set elfcorehdr_addr. Some restrictions enforced for crash dump
capture kernel, based on is_kdump_kernel(), are specifically meant for
kdump case and not desirable for fadump - eg. IO queues restriction in
device drivers. So, define is_kdump_kernel() to return false when f/w
assisted adump is active. For fadump case, is_fadump_active() can be
used for capture kernel specific checks.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h |  8 ++++++--
 arch/powerpc/kernel/crash_dump.c | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index a1ddba01e7d1..e1b43aa12175 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -99,10 +99,14 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
 
 void kexec_copy_flush(struct kimage *image);
 
-#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
+#if defined(CONFIG_CRASH_DUMP)
+bool is_kdump_kernel(void);
+#define is_kdump_kernel			is_kdump_kernel
+#if defined(CONFIG_PPC_RTAS)
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 #define crash_free_reserved_phys_range crash_free_reserved_phys_range
-#endif
+#endif /* CONFIG_PPC_RTAS */
+#endif /* CONFIG_CRASH_DUMP */
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_elf64_ops;
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 9a3b85bfc83f..2086fa6cdc25 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <asm/rtas.h>
 #include <asm/inst.h>
+#include <asm/fadump.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -92,6 +93,17 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	return csize;
 }
 
+/*
+ * Return true only when kexec based kernel dump capturing method is used.
+ * This ensures all restritions applied for kdump case are not automatically
+ * applied for fadump case.
+ */
+bool is_kdump_kernel(void)
+{
+	return !is_fadump_active() && elfcorehdr_addr != ELFCORE_ADDR_MAX;
+}
+EXPORT_SYMBOL_GPL(is_kdump_kernel);
+
 #ifdef CONFIG_PPC_RTAS
 /*
  * The crashkernel region will almost always overlap the RTAS region, so
-- 
2.41.0

