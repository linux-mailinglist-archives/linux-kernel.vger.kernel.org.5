Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B715A80F0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377058AbjLLPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377179AbjLLPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:30:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621EA109;
        Tue, 12 Dec 2023 07:30:01 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCEx5ER006650;
        Tue, 12 Dec 2023 15:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=1QnPj8eOFdOKbzBUzJWtWMceQ+m+B2C7k4p3TzuE9/k=;
 b=NcKu09smPX6EeAQwHvpzlXCWxZVWnEp7/qUcgFPq0ARXQKSGIx4UKNgyhZ6i35UJ+HcJ
 i2rRrAZAoP2lPzh6VO/j5Za3S7eTgRNyfgb+AVI1dqdwwMEqZuteSGC7py9b4f36g/XD
 JqLqkdmgoYjwyqHKWJD4/DgTlaQTH4EeB+JAC9iWe7P9Oxb3YYzwnqxJjfEdyTeZNRrs
 rlrGsZ4Yq6RImXZ1Tz2P7sglqnNts0qFtvoPzRKHLpX/y36EYc+YFW30c20RhgnwQNvR
 pE+VYlyQKtyN/7zRRxrfQKEwvYF3+IN+rMDlW1MAelv8wQDBgSY+5AzWALzWldQLJ/Jm gg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxrqckm2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 15:29:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCFPVDx004390;
        Tue, 12 Dec 2023 15:29:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sk9jwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 15:29:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCFTmPE45023712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 15:29:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8015920040;
        Tue, 12 Dec 2023 15:29:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 137DA2004B;
        Tue, 12 Dec 2023 15:29:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.159.221])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 15:29:46 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Roberto Sassu as co-maintainer to IMA and EVM
Date:   Tue, 12 Dec 2023 10:29:37 -0500
Message-Id: <20231212152937.928126-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212152937.928126-1-zohar@linux.ibm.com>
References: <20231212152937.928126-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fbJCglrVMoWM9eTCtOH3EcYo-EPFiKxO
X-Proofpoint-ORIG-GUID: fbJCglrVMoWM9eTCtOH3EcYo-EPFiKxO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_08,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Sassu has been actively involved in IMA and EVM since 2011.
His first major IMA contribution was IMA template support.  He also
contributed extending TPM 2.0 PCRs with properly calculated per TPM
bank digests and included file metadata information in the IMA
measurement list.

Regarding EVM, Roberto contributed to making EVM portable and immutable
signatures more usable.  He also prepared the LSM infrastructure to
support EVM as a fully fledged LSM, by ensuring that the latter receives
from the former all xattrs provided by other registered LSMs at inode
creation time, for HMAC calculation.

Roberto is currently working on making IMA and EVM full fledged LSMs.

Add Roberto as an IMA and EVM maintainer.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 012df8ccf34e..ffaac404d1e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7977,6 +7977,7 @@ F:	include/uapi/linux/ext4.h
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.ibm.com>
+M:	Roberto Sassu <roberto.sassu@huawei.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
@@ -10554,6 +10555,7 @@ F:	drivers/crypto/inside-secure/
 
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.ibm.com>
+M:	Roberto Sassu <roberto.sassu@huawei.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
-- 
2.39.3

