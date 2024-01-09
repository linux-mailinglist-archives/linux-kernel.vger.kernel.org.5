Return-Path: <linux-kernel+bounces-20908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABDF82873D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA8528651C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434738FAA;
	Tue,  9 Jan 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YTQ4z/A4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517226D6F9;
	Tue,  9 Jan 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409DcCAv008166;
	Tue, 9 Jan 2024 13:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=5KzBx90TWSMeNOkqrM5SYJyiVmds5T3TK+9/nMMYzxw=;
 b=YTQ4z/A4LZ03zRtsT+K6/50FMRbmW1mFpSekd4Vp89zv002K6XkRo9hde41TG7XzaFmr
 wYJ5PA19l8Wo2jDwiXw5idx/FUsvvjqKMoGRcpIqeKFBE0jFGooc4ZqDUcWBywcns8Ak
 EuwJLaAJkinJtb0IBrYHLXZ2rwZfMupwLxoTeSBdx9JTZWi6oPgTkOo3d5N2cir21mev
 icqmu6qaqI6t2cZu4JZncPcwcH91LRSpPSlE6tp3YEcpL3W0UJ8hXLkCK2ZEdhGQ9H6z
 e0S+Oc25dqvmoTyot1/Rb2VfQaUZgknsjUG8ooZelDUGcP4yRNf1UjpykrvtI09HG3m0 +Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh76tg1uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 13:41:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409D1SJ8028052;
	Tue, 9 Jan 2024 13:41:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vgwfsjt9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 13:41:08 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409Df8Po28574362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 13:41:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158BC58055;
	Tue,  9 Jan 2024 13:41:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94AA75804B;
	Tue,  9 Jan 2024 13:41:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.140.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 13:41:07 +0000 (GMT)
Message-ID: <e4c5630fbd56ea57b51df50c4c7b0e865e89f4b6.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.8
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Tue, 09 Jan 2024 08:41:07 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BJ33rv1GRimv8pFPzoRMJTaiWb-fQuKN
X-Proofpoint-GUID: BJ33rv1GRimv8pFPzoRMJTaiWb-fQuKN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_05,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 mlxlogscore=768 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090112

Hi Linus,

Adding a new IMA/EVM maintainer and reviewer, disabling EVM on overlay, 1 bug
fix and 2 cleanups.

- The EVM HMAC and the original file signatures contain filesystem specific
metadata (e.g. i_ino, i_generation and s_uuid), preventing the security.evm
xattr from directly being copied up to the overlay. Further before calculating
and writing out the overlay file's EVM HMAC, EVM must first verify the existing
backing file's 'security.evm' value.  For now until a solution is developed,
disable EVM on overlayfs.

thanks,

Mimi

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.8

for you to fetch changes up to c00f94b3a5be428837868c0f2cdaa3fa5b4b1995:

  overlay: disable EVM (2023-12-20 07:40:50 -0500)

----------------------------------------------------------------
integrity-v6.8

----------------------------------------------------------------
Chen Ni (1):
      KEYS: encrypted: Add check for strsep

Eric Snowberg (2):
      ima: Reword IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
      ima: Remove EXPERIMENTAL from Kconfig

Mimi Zohar (5):
      MAINTAINERS: Add Roberto Sassu as co-maintainer to IMA and EVM
      MAINTAINERS: Add Eric Snowberg as a reviewer to IMA
      evm: don't copy up 'security.evm' xattr
      evm: add support to disable EVM on unsupported filesystems
      overlay: disable EVM

 MAINTAINERS                              |  3 +++
 fs/overlayfs/super.c                     |  1 +
 include/linux/evm.h                      |  6 +++++
 include/linux/fs.h                       |  1 +
 security/integrity/evm/evm_main.c        | 42 +++++++++++++++++++++++++++++++-
 security/integrity/ima/Kconfig           | 10 ++++----
 security/keys/encrypted-keys/encrypted.c |  4 +++
 security/security.c                      |  2 +-
 8 files changed, 62 insertions(+), 7 deletions(-)


