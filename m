Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8E7D4F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjJXMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjJXMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:09:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E1D68;
        Tue, 24 Oct 2023 05:09:09 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OC7Ln0012386;
        Tue, 24 Oct 2023 12:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bg1rFheCeZa27xoXf7HUo6ZtCa3PL485504JQXZ/SwA=;
 b=Ix0SJHWs/BzvfHPQQTFV0MtO3lkMNfnuGf/wags7YbZtJQhVsGbeF2x0N49IIXmK0rab
 AUOK2LEdYNY2jt/P/fvdODbfj9nvoCjD4d8kAcrk4vEuWGmtCvUXnwmN3OhSq1wpUkVB
 KUgniI1oHMeGdxoau2USi2B6zdszaRk8OXQYaAfqz6LFYlZf9nJMr8c6N1xNdpEKtk/Q
 0C9r4aEZwgjvlvn1WYbVGMk+a+Q9YQ2BekDGo8hG9Vvtcug4zV3R5Vu9VA8ADYbrEEGp
 eIad71RpxlR3ZyycVnUT/LXuSeok9di7Rirpb7s0CzT+R+wMpL4XURGSsLtuyXIdyyKf cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txdnar2jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 12:09:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OC87v0018334;
        Tue, 24 Oct 2023 12:09:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txdnar2ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 12:09:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39OBUw1w005105;
        Tue, 24 Oct 2023 12:09:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvtfkf19t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 12:09:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39OC916915139522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 12:09:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E86FE20043;
        Tue, 24 Oct 2023 12:09:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C0A32004B;
        Tue, 24 Oct 2023 12:08:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.164.171])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Oct 2023 12:08:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Raul Rangel <rrangel@chromium.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] ima: detect changes to the backing overlay file
Date:   Tue, 24 Oct 2023 08:08:45 -0400
Message-Id: <20231024120845.942815-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eXeXokjqZ8n6utRJCKuKBqZZkCNtFQ6k
X-Proofpoint-ORIG-GUID: Gxgz7ghCxHShCcPYjJUiLoK8JVWl_OSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
IMA") forced signature re-evaulation on every file access.

IMA does not detect changes made to the backing overlay file.  Instead
of always re-evaluating the file's integrity, detect a change to the
backing overlay file, by comparing the i_version, as stored in the iint,
with the backing file's i_version.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/overlayfs/super.c              |  2 +-
 security/integrity/ima/ima_api.c  |  1 +
 security/integrity/ima/ima_main.c | 21 ++++++++++++++++++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index def266b5e2a3..4d9137ba2293 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1482,7 +1482,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 452e80b541e5..d1c718ef9295 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -272,6 +272,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 				   AT_STATX_SYNC_AS_STAT);
 	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
 		i_version = stat.change_cookie;
+
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 365db0e43d7c..7c8aac81d16e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -207,7 +208,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -284,6 +285,24 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
+	/*
+	 * IMA does not detect changes made to the backing overlay file.
+	 * If the backing file's i_version is greater than the overlay
+	 * file's i_version or the backing file doesn't support iversion,
+	 * clear the cache to force the file's integrity to be re-evaluated.
+	 */
+	if (inode->i_sb->s_magic == 0x794c7630 &&
+	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
+		backing_inode = d_real_inode(file_dentry(file));
+		if (backing_inode != inode) {
+			if (!IS_I_VERSION(backing_inode) ||
+			    inode_peek_iversion(backing_inode) > iint->version) {
+				iint->flags &= ~IMA_DONE_MASK;
+				iint->measured_pcrs = 0;
+			}
+		}
+	}
+
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
-- 
2.39.3

