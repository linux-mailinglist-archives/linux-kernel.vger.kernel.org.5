Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4779C9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjILIa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjILIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:30:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2940510D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:30:14 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C8N3VK014641;
        Tue, 12 Sep 2023 08:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DnnDuJS+0K60REixaoJUh9q88TyjPe4JdQr41N1/YMU=;
 b=Xk/ChSZ+d0TEf8FftB4YybefoQfJCfh4N2CWVbvz6rqHUQCO3phAByG/92IzZ6P/NfTm
 CpdgpMIdVKUJU/uS93qSRAgBbwiMzoN1H5hI5g+4hT1iqvofCGVSeS6oe0iwjCEVULsD
 MjGh1SucEmXI0m8tEUElFMSKu4xpgh+A85oVHleMO35qDdxwkSWC2F8wuFHhPevDlmgj
 VXGI9XoSabutJzdKehzawCSHsNJZEUUDCqz3nUNljQ24e45hnL5I8IYTOW932VGHqHcz
 dK/rP875vcPlmqhMISJOz7GBHjnlE6C3OiXNTIrzj12nWj2KtIKg4nqla4tb0rRxbye4 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2me1r43j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:30:03 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C8Ofit018900;
        Tue, 12 Sep 2023 08:30:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2me1r430-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:30:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7KEFt011980;
        Tue, 12 Sep 2023 08:30:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1s2ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:30:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C8TsLC2490988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 08:29:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB872004F;
        Tue, 12 Sep 2023 08:29:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2BA120040;
        Tue, 12 Sep 2023 08:29:52 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.106.137])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 08:29:52 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 2/2] powerpc/fadump: make is_kdump_kernel() return false when fadump is active
Date:   Tue, 12 Sep 2023 13:59:50 +0530
Message-ID: <20230912082950.856977-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912082950.856977-1-hbathini@linux.ibm.com>
References: <20230912082950.856977-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UxbFGUvTXedFlQ-ChYzDpnEe2M9Mpmm9
X-Proofpoint-GUID: o_khCojcZJKu_5niZqqqK8-MDfA0OPBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, is_kdump_kernel() returns true in crash dump capture kernel
for both kdump and fadump crash dump capturing methods, as both these
methods set elfcorehdr_addr. Some restrictions enforced for crash dump
capture kernel, based on is_kdump_kernel(), are specifically meant for
kdump case and not desirable for fadump - eg. IO queues restriction in
device drivers. So, define is_kdump_kernel() to return false when f/w
assisted dump is active.

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

