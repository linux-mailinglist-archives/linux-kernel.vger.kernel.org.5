Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC5792F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjIETgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbjIETgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:36:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3EC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:36:26 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385J8YQo017837;
        Tue, 5 Sep 2023 19:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zSl9C1uQUGnKUHKEYd/N1SuSlXkpaJd1Dr30fySsTbw=;
 b=K2qtowmp56LqgqpurHBpKkueY6QiqMooY7KVmqpLZaYKDVaOtX5ySMawVYtbrDy+Max/
 gy6PPUdCpMyNVBQjpA8jt5uWBMrKMwIEYH9eK6XfhPX/bJ23jevdTIj5SNmoeZ9w03GT
 vJUcGlIrMRxMch6Fp57TdP49n9dYKWGZRscYLeOn6waefUKFQDigHU/QGaf9xD5iGS2H
 YIgNLrg0tEDqDO0uB4R2YWyPCYUwYuOGlpH56Dv8tjVSzeYI15fG2dA7Ty5mZrrmrsS3
 RCZYbCziy47xe4VE2yqO9r5ExoZ+5iRy+nRfQc/m7L6KHmOUlWBHEAFW/AlJ140T5lJ6 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxa0krv9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:11:31 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385J8g4t019024;
        Tue, 5 Sep 2023 19:11:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxa0krtdg-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:11:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385HrPlQ001610;
        Tue, 5 Sep 2023 18:36:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsnayr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:36:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385Ia7XC7144106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 18:36:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D715F20043;
        Tue,  5 Sep 2023 18:36:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1C4020040;
        Tue,  5 Sep 2023 18:36:05 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.114.159])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 18:36:05 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 1/3] powerpc/fadump: make is_fadump_active() visible for exporting vmcore
Date:   Wed,  6 Sep 2023 00:06:02 +0530
Message-ID: <20230905183604.568996-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m_EEdtmtcBJ8Bl664_L4-tA5VIHaGQBC
X-Proofpoint-GUID: Qhq2VodxAMpkVdX0kxPKylqYNsCnIhk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050166
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include asm/fadump.h in asm/kexec.h to make it visible while exporting
vmcore. Also, update is_fadump_active() to return boolean instead of
integer for better readability. The change will be used in the next
patch to ensure vmcore is exported when fadump is active.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* New patch based on Baoquan's suggestion to use is_fadump_active()
  instead of introducing new function is_crashdump_kernel().


 arch/powerpc/include/asm/fadump.h | 4 ++--
 arch/powerpc/include/asm/kexec.h  | 8 ++++++--
 arch/powerpc/kernel/fadump.c      | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 526a6a647312..27b74a7e2162 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -15,13 +15,13 @@ extern int crashing_cpu;
 
 extern int is_fadump_memory_area(u64 addr, ulong size);
 extern int setup_fadump(void);
-extern int is_fadump_active(void);
+extern bool is_fadump_active(void);
 extern int should_fadump_crash(void);
 extern void crash_fadump(struct pt_regs *, const char *);
 extern void fadump_cleanup(void);
 
 #else	/* CONFIG_FA_DUMP */
-static inline int is_fadump_active(void) { return 0; }
+static inline bool is_fadump_active(void) { return false; }
 static inline int should_fadump_crash(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
 static inline void fadump_cleanup(void) { }
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index a1ddba01e7d1..b760ef459234 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -51,6 +51,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/reg.h>
+#include <asm/fadump.h>
 
 typedef void (*crash_shutdown_t)(void);
 
@@ -99,10 +100,13 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
 
 void kexec_copy_flush(struct kimage *image);
 
-#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
+#if defined(CONFIG_CRASH_DUMP)
+#define is_fadump_active		is_fadump_active
+#if defined(CONFIG_PPC_RTAS)
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 #define crash_free_reserved_phys_range crash_free_reserved_phys_range
-#endif
+#endif /* CONFIG_PPC_RTAS */
+#endif /* CONFIG_CRASH_DUMP */
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_elf64_ops;
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3ff2da7b120b..5682a65e8326 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -187,9 +187,9 @@ int should_fadump_crash(void)
 	return 1;
 }
 
-int is_fadump_active(void)
+bool is_fadump_active(void)
 {
-	return fw_dump.dump_active;
+	return !!fw_dump.dump_active;
 }
 
 /*
-- 
2.41.0

