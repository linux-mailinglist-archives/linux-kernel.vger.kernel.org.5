Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3881273E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443237AbjLNF4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjLNF4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:56:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A894F10A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:56:40 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE5qB70029970;
        Thu, 14 Dec 2023 05:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sWp9Uy7BqjqTo5fm/PGTmYvFDIkuhCSMTHgBiF7av8c=;
 b=ZFN6FyDAwHKynvBUJ+yC+Y926gbDUln0UghvICYkLLayUEc+Z8kzcGc0tihpwKe9yFFF
 q/0NAgLL0rfQG3sjx8xwoWLORHdiqNoN5yP6JBJAm1zlq1iLfLhj420R0la/ep2LttIl
 QE0t3cbBMU4L7vM3ne9cYUmUISjnbNMm1EnH7tiIaFAfkn4cVFKUYnh5cxNr3+fV3bEV
 3kP5WTiBBIlXwuJzvlF70BmMIeogHzFJqCWtxguivRQG090PlPpOPZBV8C8JJOkZHUVA
 9ZABGaRjUhcI+UNXxHS4Qmq9uViSu02O5/7K1/lOeejTTHpnzr3/airHQxotSij4XdNe WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyuxcr247-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:25 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE5scqm002615;
        Thu, 14 Dec 2023 05:56:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyuxcr242-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE2mgWW013869;
        Thu, 14 Dec 2023 05:56:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592dwev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE5uMhH18285120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 05:56:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E261520040;
        Thu, 14 Dec 2023 05:56:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75D9D20049;
        Thu, 14 Dec 2023 05:56:21 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 05:56:21 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 71980605DC;
        Thu, 14 Dec 2023 16:56:19 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH 04/13] powerpc: Disable CONFIG_DCACHE_WORD_ACCESS when KMSAN is enabled
Date:   Thu, 14 Dec 2023 05:55:30 +0000
Message-Id: <20231214055539.9420-5-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zsg8wvQSHNi46tVffV4C7wLdttglGSj7
X-Proofpoint-ORIG-GUID: fIizHTBc_Dr4RfFFPnPnAj4mfXHJs7tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_02,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 impostorscore=0 mlxlogscore=942
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Word sized accesses may read uninitialized data when optimizing loads.
Disable this optimization when KMSAN is enabled to prevent false
positives.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..e33e3250c478 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -182,7 +182,7 @@ config PPC
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS
 	select CPUMASK_OFFSTACK			if NR_CPUS >= 8192
-	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
+	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN && !KMSAN
 	select DMA_OPS_BYPASS			if PPC64
 	select DMA_OPS				if PPC64
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
-- 
2.40.1

