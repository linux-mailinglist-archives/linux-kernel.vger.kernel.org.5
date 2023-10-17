Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B27CC322
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbjJQM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjJQM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:26:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C771A3;
        Tue, 17 Oct 2023 05:26:15 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HC9juR008253;
        Tue, 17 Oct 2023 12:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qe2gZCMY4DzIcjrCtLl12VhOToj/RK0dgRL0uJ/FQ5I=;
 b=ZfcJA1IFl97eNub3flZx994AHfCc52a8XLtXwK+ixg+fNFQgF9TUGr1A9um7Ir+bC3hS
 amFAyaUQClbHPranGVWe4DOAxuxCdACWxDjnTaGRWwFcd6QKs3B4m+QacJ9BN5gXqP3J
 h8/uENHgM2bhKt0enT/TTbpVJ8rGu0rHx3OvyMs2fVpAfLdACXhcAfrdd6sPQHtcXk+D
 uRYSoB7taxdDUkFc+hyDMnTH3alrfpN/RdHUOQRtcmna8EQQBQiQS748IbNIzoNJYLGv
 c/tc9OWNUJQCQy5GNwvxjM1pkth3etVBtpP7l9sGFAY9gErUPyq4aDfcbbBe8iHCge98 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tst1d0j4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 12:25:53 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HCARAM010454;
        Tue, 17 Oct 2023 12:25:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tst1d0j2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 12:25:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HB7d4i012876;
        Tue, 17 Oct 2023 12:25:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py8ydp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 12:25:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HCPmkD22020730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 12:25:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B741F2004E;
        Tue, 17 Oct 2023 12:25:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE942004B;
        Tue, 17 Oct 2023 12:25:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.43.157])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 12:25:45 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Denis Glazkov <d.glazkov@omp.ru>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [RFC PATCH] certs: Only allow certs signed by keys on the builtin keyring
Date:   Tue, 17 Oct 2023 08:25:07 -0400
Message-Id: <20231017122507.185896-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fQM3WX5OU-ippFqbTpxhX-yDaIOySOCZ
X-Proofpoint-ORIG-GUID: 95M6MI7O38NgjXI3EUUCVF2JRH8TZZw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=958 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally the secondary trusted keyring provided a keyring to which extra
keys may be added, provided those keys were not blacklisted and were
vouched for by a key built into the kernel or already in the secondary
trusted keyring.

On systems with the machine keyring configured, additional keys may also
be vouched for by a key on the machine keyring.

Prevent loading additional certificates directly onto the secondary
keyring, vouched for by keys on the machine keyring, yet allow these
certificates to be loaded onto other trusted keyrings.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 certs/Kconfig                     | 16 +++++++++++++++-
 crypto/asymmetric_keys/restrict.c |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 4a4dc8aab892..2e621963d260 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -88,7 +88,21 @@ config SECONDARY_TRUSTED_KEYRING
 	help
 	  If set, provide a keyring to which extra keys may be added, provided
 	  those keys are not blacklisted and are vouched for by a key built
-	  into the kernel or already in the secondary trusted keyring.
+	  into the kernel, machine keyring (if configured), or already in the
+	  secondary trusted keyring.
+
+config SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN
+	bool "Only allow additional certs signed by keys on the builtin trusted keyring"
+	depends on SECONDARY_TRUSTED_KEYRING
+	help
+	  If set, only certificates signed by keys on the builtin trusted
+	  keyring may be loaded onto the secondary trusted keyring.
+
+	  Note: The machine keyring, if configured, will be linked to the
+	  secondary keyring.  When enabling this option, it is recommended
+	  to also configure INTEGRITY_CA_MACHINE_KEYRING_MAX to prevent
+	  linking code signing keys with imputed trust to the secondary
+	  trusted keyring.
 
 config SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
 	bool "Allow only CA certificates to be added to the secondary trusted keyring"
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b69ea40da23..afcd4d101ac5 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -102,6 +102,10 @@ int restrict_link_by_signature(struct key *dest_keyring,
 
 	if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
 		ret = -ENOKEY;
+	else if (IS_BUILTIN(CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN) &&
+		 !strcmp(dest_keyring->description, ".secondary_trusted_keys") &&
+		 !test_bit(KEY_FLAG_BUILTIN, &key->flags))
+		ret = -ENOKEY;
 	else
 		ret = verify_signature(key, sig);
 	key_put(key);
-- 
2.39.3

