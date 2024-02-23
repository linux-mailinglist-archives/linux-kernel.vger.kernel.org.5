Return-Path: <linux-kernel+bounces-78830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E46861979
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C59B26A46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E713DBAB;
	Fri, 23 Feb 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lSR6/RvC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9D13328D;
	Fri, 23 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709145; cv=none; b=UOqQi6T3z8x1U8pl6uOPM7P+zNRPtdytCmPl4v9ezPwLIxMdFREfWrJn36uIJearXQ9xbH+1/vjHlTRIXU10G+ypKTMGia0c6PSPtWylo+8a405LsJwMXMN8G7TNWv6Eu7s1LwIOAiudt8I2CmFy6eFwLKg3Zmeeb7ns/sT4xJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709145; c=relaxed/simple;
	bh=2Oj97ZXigw3NHOTXGTBReko+Wf0oXKC+vAYS5vGoLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPZl5iabC+jbiLX1EeAo3Q+BNU66D4RAGte5wdQI8PPjn/hSLmQbKh+Ks2WYigy23bvUUCKseIiGMnReewgETA7OSFVGnPCDFUpYHQpevNXRcXl+gsGhfjJ/DrqxsyGpZGiwtC9o95j6z+gg4ulSXIA8RWt+dqJe86t7c1J8kuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lSR6/RvC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NH2EB6004028;
	Fri, 23 Feb 2024 17:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=qLG9uo7azn8Spvf85HB5malHh/LV592YawF4C3j0NAo=;
 b=lSR6/RvCPjv41OWrHhyI8fovRxptx9Hb2doC9mJjxsYrGJHh6KIxCCZ30cCJ0bgFlP3i
 nAr7RQ0N3co5gtWmDb3fIlarxUimSMznQvnWrSamwTizfdXW97AySX8NEy3vnRIa8Ly9
 /vOnbmM2VOJzLf1PCngsFp2WqczqUNnBh75M7MuZ+bMjihA6hTUXWAA9NK3qBTHM+xUr
 q4UQNQ+wnVMmapWQFyN1g3SiVPoABRUG8Cl0QHIUYTXZi7Dg68+1Sz+xStm74nB3lBFr
 5iEQcgiTauNIWeBfkgpXxeBkYL7+ctONHdAh6YFCu9YsTvHhgILZG4uslvf60LWZMAAH 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weydh8rb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:22 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NH4ATp015096;
	Fri, 23 Feb 2024 17:25:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weydh8rah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGaelR013492;
	Fri, 23 Feb 2024 17:25:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0y3t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPHEc20447788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C4C358065;
	Fri, 23 Feb 2024 17:25:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C5758059;
	Fri, 23 Feb 2024 17:25:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:16 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 00/10] evm: Support signatures on stacked filesystem
Date: Fri, 23 Feb 2024 12:25:03 -0500
Message-ID: <20240223172513.4049959-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: adz9_FKLO_7sPx0R--HnFWd-NzQ4TH3j
X-Proofpoint-ORIG-GUID: jlhMdjhQt0MFenShZKzBd2iqDUXLrelO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

EVM signature verification on stacked filesystem has recently been
completely disabled by declaring some filesystems as unsupported
(only overlayfs). This series now enables copy-up of "portable
and immutable" signatures on those filesystems and enables the
enforcement of "portable and immultable" as well as the "original"
signatures on previously unsupported filesystem when evm is enabled
with EVM_INIT_X509. HMAC verification and generation remains disabled.

"Portable and immutable" signatures can be copied up since they are
not created over file-specific metadata, such as UUID or generation.
Instead, they are only covering file metadata such as mode bits, uid, and
gid, that will all be preserved during a copy-up of the file metadata.

This series is now based on the 'next' branch of Paul Moore's LSM tree and
requires the following two commits from the vfs.misc branch of the vfs git
repo at https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

commit 2109cc619e73 ("fs: remove the inode argument to ->d_real() method")
commit c6c14f926fbe ("fs: make file_dentry() a simple accessor")

Regards,
   Stefan

v3:
  - Rebased series on 'next' branch of Paul Moore's LSM tree
  - Reworing of commit descriptions
  - Reworked patches 5-7

v2:
  - Added patch to rename backing_inode to real_inode (1/9)
  - Added patches renaming flag and function due to RSA enablement (7,8/9)
  - Added patch to record i_version of real_inode for change detection
    (9/9)
  - Use Amir's function to get inode holding metadata now (4,5/9)


Stefan Berger (10):
  ima: Rename backing_inode to real_inode
  security: allow finer granularity in permitting copy-up of security
    xattrs
  evm: Implement per signature type decision in
    security_inode_copy_up_xattr
  evm: Use the metadata inode to calculate metadata hash
  ima: Move file-change detection variables into new structure
  evm: Store and detect metadata inode attributes changes
  ima: re-evaluate file integrity on file metadata change
  evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
  fs: Rename SB_I_EVM_UNSUPPORTED to SB_I_EVM_HMAC_UNSUPPORTED
  evm: Rename is_unsupported_fs to is_unsupported_hmac_fs

 fs/overlayfs/copy_up.c              |  2 +-
 fs/overlayfs/super.c                |  2 +-
 include/linux/evm.h                 |  8 +++
 include/linux/fs.h                  |  2 +-
 include/linux/integrity.h           | 34 +++++++++++
 include/linux/lsm_hook_defs.h       |  3 +-
 include/linux/security.h            |  4 +-
 security/integrity/evm/evm.h        |  6 +-
 security/integrity/evm/evm_crypto.c | 25 +++++---
 security/integrity/evm/evm_main.c   | 92 +++++++++++++++++++++++------
 security/integrity/ima/ima.h        |  4 +-
 security/integrity/ima/ima_api.c    | 10 ++--
 security/integrity/ima/ima_iint.c   |  2 +-
 security/integrity/ima/ima_main.c   | 31 +++++++---
 security/security.c                 |  5 +-
 security/selinux/hooks.c            |  2 +-
 security/smack/smack_lsm.c          |  2 +-
 17 files changed, 178 insertions(+), 56 deletions(-)


base-commit: f89d47833d28f101fce65c7d08c00a4d6f28c1b1
prerequisite-patch-id: c6c14f926fbe37330af6271d26f98e70d1a07372
prerequisite-patch-id: 2109cc619e733c8709250b62d7f1d43461589f57
-- 
2.43.0


