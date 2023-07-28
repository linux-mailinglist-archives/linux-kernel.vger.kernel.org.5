Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A57669DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjG1KIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjG1KId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:08:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71A35BE;
        Fri, 28 Jul 2023 03:08:29 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SA0Lvr012992;
        Fri, 28 Jul 2023 10:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=dbBAn0k53uJ/BYXDD1DSxFo2/rut5EHR4rRggL0FDjA=;
 b=q4Ougy3EiG2RiJ4L85kAt7R7qM1BOFBMzLOhrofnzA0fZtKDM7gc37HZ56bAktMzIUHv
 J99759gYbBiLsnEdYZq1bq7hpnOApevF0d8wUpBVnNsnPWaOqfGAnKXcXxgeF9DbInSd
 /OOo2LRGE+XVDvv+86kyhua9+kdJm/yJIDEVxpTEwMpIGN4Y2sxeljNfMR1sOvypSK8S
 2atS8B0WGYEN1XhK6gZY6vZhdLxmwOEKwgs3qCoeNVUFhG6HmJQpoPiSq/7BEYq93jax
 UfjCsh/nvS94E9Z1RVwhhXzk8Eo3dUxHb2Py5tG5EPz2gqSRyHF9+XEKNEDxDUjZERx1 Cw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4bhn02rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 10:08:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36S8mH3i014370;
        Fri, 28 Jul 2023 10:04:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0styn8xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 10:04:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36SA4ebU44958338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 10:04:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE91920073;
        Fri, 28 Jul 2023 10:04:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9F4620065;
        Fri, 28 Jul 2023 10:04:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Jul 2023 10:04:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 74D19E08A8; Fri, 28 Jul 2023 12:04:40 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-next@vger.kernel.org,
        Anastasia Eskova <anastasia.eskova@ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] s390/certstore: select CRYPTO_LIB_SHA256
Date:   Fri, 28 Jul 2023 12:04:30 +0200
Message-Id: <20230728100430.1567328-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ITAXG5ig_Gbi4DDwOZgR5G1e8C13PZiy
X-Proofpoint-GUID: ITAXG5ig_Gbi4DDwOZgR5G1e8C13PZiy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build failure was reported when sha256() is not present:

gcc-13.1.0-nolibc/s390-linux/bin/s390-linux-ld: arch/s390/kernel/cert_store.o: in function `check_certificate_hash':
arch/s390/kernel/cert_store.c:267: undefined reference to `sha256'

Therefore make CONFIG_CERT_STORE select CRYPTO_LIB_SHA256.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/8ecb57fb-4560-bdfc-9e55-63e3b0937132@infradead.org/
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d9d50a7a2016..18bf754e1fad 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -516,6 +516,7 @@ config KEXEC_SIG
 config CERT_STORE
 	bool "Get user certificates via DIAG320"
 	depends on KEYS
+	select CRYPTO_LIB_SHA256
 	help
 	  Enable this option if you want to access user-provided secure boot
 	  certificates via DIAG 0x320.
-- 
2.39.2

