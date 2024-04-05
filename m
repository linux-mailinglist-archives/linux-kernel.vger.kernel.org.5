Return-Path: <linux-kernel+bounces-132925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D3899C15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51079283A97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5016C6A6;
	Fri,  5 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jS6E/fO2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2716ABCE;
	Fri,  5 Apr 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317801; cv=none; b=kd+A7sKIhG758D3tVeVhNvhAzU4t7Pj4z7A38JsjXYlBai2ejYpjEfMoXws5XBeP+q+SmHscYMuk1ah+TNqLY1tQZ1rLAr1+Z7KRVbgSZtp6XIE9WeUvglf4jPMCcAvIXbn+7fXWqBK+ErH3PlcZj9Kt3b8d7wMHOWhnC1bG12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317801; c=relaxed/simple;
	bh=PIcpPeQSIYT3OojaOi7ZJiQHhKNaRInlfkv3wkwoKZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oLX5Do/O+tGsoifzzKwHylM/luay03VBzjEkiDMQyGYMZ1g0XYa2p6mMLqRVeXmHG4bLKkQz1vqV4oJdZ8E9Wr/1l8+sXmPVJPqIUtIzPFIwX99aXQXL5hrwM5WXS5WAmzhJDZuhBgmtuqybDxDnG0VA3ghEx6mChpPsw51POKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jS6E/fO2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435BSSOY028829;
	Fri, 5 Apr 2024 11:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=3+Lh9mxAecdBGIcwlYpun7XEk9Ey9kS2lJwm5SHNI+Q=;
 b=jS6E/fO2YgdhL3bK4RvYllBM+3Sgjp173IT28pgCejAyosyHF3noI8MFsaJn+X5YFLEg
 jHdQzOmdJbnCHZ4nihEpgNgWFX+qkM1MMwfK7OVeskoG4DCoXvmkLvb0apkmRxr2n2E2
 i1Xm0iWnzuIBV5X5BPc0w1XmzbiN39vdDm9t5nZHEbrm+fFN/DtExn9Muo9oDGCS+uWq
 t8EvSSUR/WpYuj4XecxoPz9mlYYQ5n1zkBbPtUVkk20GDIsjT5/tf0hDyRvgw6L9d9hH
 BVc61hLwneqn8laZZCdm9Ysaims/Gue1vu2SSoSzELIJFUDpU1Ft5EJ4Ii22QrvtZz+t tA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xagetr19w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:49:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4359VwLi008686;
	Fri, 5 Apr 2024 11:49:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epwa73a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:49:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435BnoI411207000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 11:49:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FF482004F;
	Fri,  5 Apr 2024 11:49:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFBF2004E;
	Fri,  5 Apr 2024 11:49:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Apr 2024 11:49:49 +0000 (GMT)
Date: Fri, 5 Apr 2024 13:49:48 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.9-rc3
Message-ID: <Zg/lXGhJwPcyDqk2@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b_WY48pf6Rp6tIRI3sMSMwV-8k8zKtX5
X-Proofpoint-ORIG-GUID: b_WY48pf6Rp6tIRI3sMSMwV-8k8zKtX5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 mlxlogscore=443 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050085

Hi Linus,

please pull s390 fixes for 6.9-rc3.

Thanks,
Alexander

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-3

for you to fetch changes up to 378ca2d2ad410a1cd5690d06b46c5e2297f4c8c0:

  s390/entry: align system call table on 8 bytes (2024-04-03 15:00:20 +0200)

----------------------------------------------------------------
s390 updates for 6.9-rc3

- Fix missing NULL pointer check when determining guest/host fault

- Mark all functions in asm/atomic_ops.h, asm/atomic.h and asm/preempt.h
  as __always_inline to avoid unwanted instrumentation

- Fix removal of a Processor Activity Instrumentation (PAI) sampling
  event in PMU device driver

- Align system call table on 8 bytes

----------------------------------------------------------------
Heiko Carstens (1):
      s390/mm: fix NULL pointer dereference

Ilya Leoshkevich (2):
      s390/atomic: mark all functions __always_inline
      s390/preempt: mark all functions __always_inline

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Thomas Richter (1):
      s390/pai: fix sampling event removal for PMU device driver

 arch/s390/include/asm/atomic.h     | 44 +++++++++++++++++++-------------------
 arch/s390/include/asm/atomic_ops.h | 22 +++++++++----------
 arch/s390/include/asm/preempt.h    | 36 +++++++++++++++----------------
 arch/s390/kernel/entry.S           |  1 +
 arch/s390/kernel/perf_pai_crypto.c | 10 ++++++---
 arch/s390/kernel/perf_pai_ext.c    | 10 ++++++---
 arch/s390/mm/fault.c               |  2 +-
 7 files changed, 67 insertions(+), 58 deletions(-)

