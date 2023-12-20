Return-Path: <linux-kernel+bounces-7240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCFD81A3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3946F282CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBEE46B98;
	Wed, 20 Dec 2023 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dU+2mk6T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD174778E;
	Wed, 20 Dec 2023 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKFD6HU009626;
	Wed, 20 Dec 2023 16:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=18XKunUq0YEHNPMhnm27GqmcZ8G4VcKtaHKoYnIUkkQ=;
 b=dU+2mk6TQ1hK8g6X4xfyOpzUaCgRqbXnmbGPSQ0avXFijXxqTn+Zbiq/GY48HGS3ZuxD
 WKvGiOQmFIj4gPYMdMyIRMS4//Cc0YIBTR4l2DMwxRKEPkLeUFAsa2lnsLtvEBjnCuO6
 XfBsr/KjhJhZcI8ZSAi3HKB2x0yipiwq+MfHZgunm/UqZjyZZEw8J2NxPe8LZCkgQmYJ
 yjxoy0fu1VNtJfrfQP/xrTKXMRY34DcIhMGUn78o5jz/ExLgAtfcPERv4kUygm40Y6P7
 PSoQDoGNlaWwG2AMMNaZ8vOjH6qe0hKEXSFpG5Vn47NBKbevhHtlFKtOtF9YhWZLSaC4 Bw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q6hk03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:01:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKEt17n010954;
	Wed, 20 Dec 2023 16:01:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nqas3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:01:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKG1j1m13566618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 16:01:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E20E2004B;
	Wed, 20 Dec 2023 16:01:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6062C20040;
	Wed, 20 Dec 2023 16:01:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Dec 2023 16:01:45 +0000 (GMT)
Date: Wed, 20 Dec 2023 17:01:44 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.7-rc7
Message-ID: <ZYMP6OClkOMkey9l@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: poJC-g1k2ivOh1blCixmTJJYTc7rr77Y
X-Proofpoint-ORIG-GUID: poJC-g1k2ivOh1blCixmTJJYTc7rr77Y
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_09,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=818 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200115

Hello Linus,

Please pull s390 changes for 6.7-rc7.

Thank you,
Alexander

The following changes since commit aab1f809d7540def24498e81347740a7239a74d5:

  scripts/checkstack.pl: match all stack sizes for s390 (2023-11-22 15:06:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-4

for you to fetch changes up to 3d940bb1818325142e6764bff788cbf95b9afb54:

  s390: update defconfigs (2023-12-19 17:37:26 +0100)

----------------------------------------------------------------
s390 updates for 6.7-rc7

- Fix virtual vs physical address confusion in Storage Class Memory
  (SCM) block device driver.

- Fix saving and restoring of FPU kernel context, which could lead
  to corruption of vector registers 8-15.

- Update defconfigs.

----------------------------------------------------------------
Heiko Carstens (2):
      s390/vx: fix save/restore of fpu kernel context
      s390: update defconfigs

Vineeth Vijayan (1):
      s390/scm: fix virtual vs physical address confusion

 arch/s390/configs/debug_defconfig    | 9 +++++----
 arch/s390/configs/defconfig          | 9 +++++----
 arch/s390/configs/zfcpdump_defconfig | 3 +--
 arch/s390/include/asm/fpu/api.h      | 2 +-
 drivers/s390/block/scm_blk.c         | 7 ++++---
 5 files changed, 16 insertions(+), 14 deletions(-)

