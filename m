Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B669A792EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbjIETcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbjIETcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:32:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B609CC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:31:37 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385JMJY1027528;
        Tue, 5 Sep 2023 19:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=q+b17WGlf8Tf/Vsme2Bal+Z/bYkSI0hbFQ9jixWp+Bw=;
 b=gif63GY+t5CG0mThPMCUS67jEB2v3pfpA92nyp51ArpmlxUhSeVrl36pNF6qTDaJvMbe
 cG309zwOgWl4MSPZZ/W/4+E8fn1ClIr4ukR7FRxT41TfEpYpWkX7Doh0A6C6eDF0qbSy
 DWpAhm5YhOrcMOYGw7nvTXJdOs5CLBeINAtsoVxTiqAg/mInQ1UNLyByQntEtqw05EoL
 NwUQ51RO6ge5tr568MujOQSqQA/FmNGufN7vCbTVEsd54NMN1Y6yGHE6/q/g9Zst6BF1
 mkLMxrLRfEm9s2bZ3JE1IsyeC09FxtAjC3rYGHjqkn3W3Q4E4rFqkt82lquecaTaPbA/ Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxae4gcm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:30:59 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385JNV7H031025;
        Tue, 5 Sep 2023 19:30:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxae4gcjj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:30:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385I0nBB011130;
        Tue, 5 Sep 2023 18:36:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31mdjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:36:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385IaAso41353628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 18:36:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34D5720043;
        Tue,  5 Sep 2023 18:36:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F57320040;
        Tue,  5 Sep 2023 18:36:08 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.114.159])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 18:36:08 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/3] vmcore: allow fadump to export vmcore even if is_kdump_kernel() is false
Date:   Wed,  6 Sep 2023 00:06:03 +0530
Message-ID: <20230905183604.568996-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905183604.568996-1-hbathini@linux.ibm.com>
References: <20230905183604.568996-1-hbathini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5DSGlBywuMoM_Ngx43GKsBSn_VHV-SsD
X-Proofpoint-GUID: 6YIJfTK3LF49t8zdGQV1wjnfg5pV2wEv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050166
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
While elfcorehdr_addr is set for kexec based kernel dump mechanism,
alternate dump capturing methods like fadump [1] also set it to export
the vmcore. Since, is_kdump_kernel() is used to restrict resources in
crash dump capture kernel and such restrictions are not desirable for
fadump, allow is_kdump_kernel() to be defined differently for fadump
case. With that change, include is_fadump_active() check in functions
is_vmcore_usable() & vmcore_unusable() to be able to export vmcore for
fadump case too.

[1] https://docs.kernel.org/powerpc/firmware-assisted-dump.html

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* is_fadump_active() check added to is_vmcore_usable() as suggested
  by Baoquan.


 include/linux/crash_dump.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..de8a9fabfb6f 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -50,6 +50,7 @@ void vmcore_cleanup(void);
 #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
 #endif
 
+#ifndef is_kdump_kernel
 /*
  * is_kdump_kernel() checks whether this kernel is booting after a panic of
  * previous kernel or not. This is determined by checking if previous kernel
@@ -64,6 +65,19 @@ static inline bool is_kdump_kernel(void)
 {
 	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
 }
+#endif
+
+#ifndef is_fadump_active
+/*
+ * If f/w assisted dump capturing mechanism (fadump), instead of kexec based
+ * dump capturing mechanism (kdump) is exporting the vmcore, then this function
+ * will be defined in arch specific code to return true, when appropriate.
+ */
+static inline bool is_fadump_active(void)
+{
+	return false;
+}
+#endif
 
 /* is_vmcore_usable() checks if the kernel is booting after a panic and
  * the vmcore region is usable.
@@ -75,7 +89,8 @@ static inline bool is_kdump_kernel(void)
 
 static inline int is_vmcore_usable(void)
 {
-	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
+	return (is_kdump_kernel() || is_fadump_active())
+		&& elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
 }
 
 /* vmcore_unusable() marks the vmcore as unusable,
@@ -84,7 +99,7 @@ static inline int is_vmcore_usable(void)
 
 static inline void vmcore_unusable(void)
 {
-	if (is_kdump_kernel())
+	if (is_kdump_kernel() || is_fadump_active())
 		elfcorehdr_addr = ELFCORE_ADDR_ERR;
 }
 
-- 
2.41.0

