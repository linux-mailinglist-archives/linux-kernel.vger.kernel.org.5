Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FD81273C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443221AbjLNF5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjLNF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC23191
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:56:53 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE5Pf2V006428;
        Thu, 14 Dec 2023 05:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d9wxIuPcEttKuooqpbXdsw1bqv2JtLrtXjyZWOljfa8=;
 b=UYZPDBuPEsYnBXNn9bIcsLbwH9nOgpX0ngFzMXGcNxOmSNwml9oUQFPdlpZsWmRopKZZ
 G/HiC/7DbSwP8wNuU2eve9evV+t9dkJfA4VIbh+Lm/xmETSgRJZHB9sFis/DCvt8sTpN
 cAFK5uIz5SrkOkF/p+zh6fUc/QXCDsNehRsi7U9HRnocEyRNLXjFy2gtzaUs1rt8bjxT
 NCmjnrF3OUJBQC1rLP5GoVw0wDxTMpd5ir4G2PaBve72fkUln0TJ36eS83hRaUqqBh5P
 Q49xA+VkZv+hhUGLQ2sTqIh4ok1VL9WeeyZD2XArCo7WwrceaPZUBeVv6xltj9ijdBgd oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyp5cq854-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:39 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE5oHZS007026;
        Thu, 14 Dec 2023 05:56:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyp5cq82r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0fBUg014872;
        Thu, 14 Dec 2023 05:56:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kggr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE5uON922151734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 05:56:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B8AC20040;
        Thu, 14 Dec 2023 05:56:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9AF020043;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A020D606F4;
        Thu, 14 Dec 2023 16:56:19 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH 11/13] powerpc: Implement architecture specific KMSAN interface
Date:   Thu, 14 Dec 2023 05:55:37 +0000
Message-Id: <20231214055539.9420-12-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jSCLRD5AL1ZRUh81WentUJPts7nYAd0_
X-Proofpoint-GUID: SH2cEt_NsXZHfXK7AkjEQ-6Tk95O45Ww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_02,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=751 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_kmsan_get_meta_or_null finds the metadata addresses for addresses
in the ioremap region which is mapped separately on powerpc.

kmsan_vir_addr_valid is the same as virt_addr_valid except excludes the
check that addr is less than high_memory since this function can be
called on addresses higher than this.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 arch/powerpc/include/asm/kmsan.h | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 arch/powerpc/include/asm/kmsan.h

diff --git a/arch/powerpc/include/asm/kmsan.h b/arch/powerpc/include/asm/kmsan.h
new file mode 100644
index 000000000000..bc84f6ff2ee9
--- /dev/null
+++ b/arch/powerpc/include/asm/kmsan.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * powerpc KMSAN support.
+ *
+ */
+
+#ifndef _ASM_POWERPC_KMSAN_H
+#define _ASM_POWERPC_KMSAN_H
+
+#ifndef __ASSEMBLY__
+#ifndef MODULE
+
+#include <linux/mmzone.h>
+#include <asm/page.h>
+#include <asm/book3s/64/pgtable.h>
+
+/*
+ * Functions below are declared in the header to make sure they are inlined.
+ * They all are called from kmsan_get_metadata() for every memory access in
+ * the kernel, so speed is important here.
+ */
+
+/*
+ * No powerpc specific metadata locations
+ */
+static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
+{
+	unsigned long addr64 = (unsigned long)addr, off;
+	if (KERN_IO_START <= addr64 && addr64 < KERN_IO_END) {
+		off = addr64 - KERN_IO_START;
+		return (void *)off + (is_origin ? KERN_IO_ORIGIN_START : KERN_IO_SHADOW_START);
+	} else {
+		return 0;
+	}
+}
+
+static inline bool kmsan_virt_addr_valid(void *addr)
+{
+	return (unsigned long)addr >= PAGE_OFFSET && pfn_valid(virt_to_pfn(addr));
+}
+
+#endif /* !MODULE */
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASM_POWERPC_KMSAN_H */
-- 
2.40.1

