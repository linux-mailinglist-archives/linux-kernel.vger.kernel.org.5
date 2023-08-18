Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2E780561
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356168AbjHRFJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357998AbjHRFIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:08:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79989E48;
        Thu, 17 Aug 2023 22:08:27 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I57d4V028882;
        Fri, 18 Aug 2023 05:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zQ4ZV5K1bdnTPKV5NsQUc1byk1vtYyfiLQor5t6FJ2o=;
 b=jOYvmhY0UhmrW1sb0yINPFLTmBYNXskWcaSH6VvSgpk9ASAnkojuZP+iukWwvuu0gEZ6
 LGOH/9GMNeeuvMW7EElKTHoXgDakmJVexi3QXmLxxnaLVV7/F6Ubzc3ox0c+WW25PUJ4
 s8nzRgY1lSyyZUqExG3LF9arItng94anN1gTRdDxBeos1tI8eeNKfsDzPHV1cQJ7U2lH
 SwVnTuVakTVaGXvsAYVG+rnDAuH76fpcb1t1Q+NkFU/1sZGQ0fGc1ZjFOuv6ac1/yh3V
 le057wWyQx5q0IvqQ9sORvTVhDIqG5dUDc5hdb42Rb58MbeimC2w/dV0b9Bx40kD/EbK aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj20ur5hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 05:08:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37I57nnH029681;
        Fri, 18 Aug 2023 05:08:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj20ur5hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 05:08:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37I43xMI018831;
        Fri, 18 Aug 2023 05:08:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq423t4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 05:08:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37I581lD26935868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 05:08:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A95F20040;
        Fri, 18 Aug 2023 05:08:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F5802005A;
        Fri, 18 Aug 2023 05:07:56 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.74.199])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 18 Aug 2023 05:07:56 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 18 Aug 2023 10:37:55 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Enable generic cpu idle-loop
Date:   Fri, 18 Aug 2023 10:37:37 +0530
Message-ID: <20230818050739.827851-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VtksZ_e5l-_iKvMYKpVpTFlPNpi1l42A
X-Proofpoint-ORIG-GUID: SAzGTLYVjM9Nt2VVAas-tQa4a_ff2Dgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_05,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=561 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This minor patch enables config option GENERIC_IDLE_POLL_SETUP for arch
powerpc. This should add support for kernel param 'nohlt'.

Powerpc kernel also supports another kernel boot-time param called
'powersave' which can also be used to disable all cpu idle-states and
forces CPU to an idle-loop similar to what cpu_idle_poll() does. This
patch however makes powerpc kernel-parameters better aligned to the
generic boot-time parameters.

Signed-off-by: Vaibhav Jain<vaibhav@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/powerpc/Kconfig                            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 722b6eca2e93..6b657ebafcfb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3738,7 +3738,7 @@
 
 	nohibernate	[HIBERNATION] Disable hibernation and resume.
 
-	nohlt		[ARM,ARM64,MICROBLAZE,MIPS,SH] Forces the kernel to
+	nohlt		[ARM,ARM64,MICROBLAZE,MIPS,PPC,SH] Forces the kernel to
 			busy wait in do_idle() and not use the arch_cpu_idle()
 			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
 			to be effective. This is useful on platforms where the
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0b1172cbeccb..574661403800 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -193,6 +193,7 @@ config PPC
 	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
-- 
2.41.0

