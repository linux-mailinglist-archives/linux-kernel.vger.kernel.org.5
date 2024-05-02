Return-Path: <linux-kernel+bounces-166747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED28B9EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A911F22ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B216D32C;
	Thu,  2 May 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qY2x1TSb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B816D4D4;
	Thu,  2 May 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668514; cv=none; b=jnvTh93MxrYN6M0lflz1vZ/rEKp8ulpHtbmjeHByqJsqanQpZdtuuZA9sYL08KvDuEfs7pX+ZgWvj+rHLOeGLqSPG05Epu0vD3ZEU6K9t/vnl0p1OPSlTqIwQRSOgOnt7QyDRPC5J+q2rSOIdNh+wVwuOJiJbMrYTdzNXXbl/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668514; c=relaxed/simple;
	bh=vpRit49nMUXS5YYOwQxWvJtcED38KA4sT4n9NimhVQk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UhbFrjaJ8ygNpqKWWjtmzJBFX2Gw8yMAf9fJHuesKTYssUsJY9zG2nKUaZkumkEp1LBBs9h01J9+6bUF2SmPO4wdP/vwCHHs8BXI6JIyVdwi8EouaY5rshgvsy9gaIvAw3gQmh4bK+RKQhWhxhBxIY9kRJmlfR1HFGIS4h1Msqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qY2x1TSb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442GmCJQ029674;
	Thu, 2 May 2024 16:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=k03M/v2D1jWj6cdDUaQmzNG1EN8GKUvDWuy3bRQrFAg=;
 b=qY2x1TSbErYL61mD9sfZsHAuYmLwVc+lDRmgocvHofP9TmL4SfW6kywU7eB08O5yW95I
 PhqzJ5nncBKapnIOIuEQbkwJDZxeCHo85ZhnNsMduRwMWydVigLpxWzkzTak7YawOE/T
 V9uunx4bm3/Tn9u1Sem5K1LarNOCQQj1EyhyFYwh437X8olo6azzkO4s08swwM73HU53
 vdOPJx6dCE6axEfTli1ZkNI6qYJn7aXVBWmwzIlADKUkdGNGL9Aud/16oVYa9VQeoT3J
 HrJC8xklTo/Sh7qv4PnvQQEMLE4uUupy/ICZRKFUqLSdcC26RdDBB6ziHQKFmZroM5pZ EA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvenw002g-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 16:48:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 442EsJKB027556;
	Thu, 2 May 2024 16:26:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc30s2s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 16:26:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 442GQGCl50266614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 16:26:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 842B920043;
	Thu,  2 May 2024 16:26:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F40D20040;
	Thu,  2 May 2024 16:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 May 2024 16:26:16 +0000 (GMT)
Date: Thu, 2 May 2024 18:26:15 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.9-rc7
Message-ID: <ZjO+p5wo9s16F+hU@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tdvYAohF_PcunzoIRMpqdmw0heAuLn8w
X-Proofpoint-GUID: tdvYAohF_PcunzoIRMpqdmw0heAuLn8w
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_08,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020111

Hi Linus,

please pull s390 fixes for 6.9-rc7.

Thanks,
Alexander

The following changes since commit d111855ab7ffffc552f6a475259dc392f2319b6d:

  s390/mm: Fix NULL pointer dereference (2024-04-17 17:26:34 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-6

for you to fetch changes up to 7bbe449d0bdb68892cc67e9f5f1bfa106a3588d5:

  s390/paes: Reestablish retry loop in paes (2024-05-01 11:52:54 +0200)

----------------------------------------------------------------
s390 updates for 6.9-rc7

- The function __storage_key_init_range() expects the end address to be
  the first byte outside the range to be initialized. Fix the callers
  that provide the last byte within the range instead.

- 3270 Channel Command Word (CCW) may contain zero data address in case
  there is no data in the request. Add data availability check to avoid
  erroneous non-zero value as result of virt_to_dma32(NULL) application
  in cases there is no data

- Add missing CFI directives for an unwinder to restore the return
  address in the vDSO assembler code

- NUL-terminate kernel buffer when duplicating user space memory region
  on Channel IO (CIO) debugfs write inject

- Fix wrong format string in zcrypt debug output

- Return -EBUSY code when a CCA card is temporarily unavailabile

- Restore a loop that retries derivation of a protected key from a
  secure key in cases the low level reports temporarily unavailability
  with -EBUSY code

----------------------------------------------------------------
Bui Quang Minh (1):
      s390/cio: Ensure the copied buf is NUL terminated

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Harald Freudenberger (4):
      s390/zcrypt: Fix wrong format string in debug feature printout
      s390/zcrypt: Handle ep11 cprb return code
      s390/zcrypt: Use EBUSY to indicate temp unavailability
      s390/paes: Reestablish retry loop in paes

Jens Remus (1):
      s390/vdso: Add CFI for RA register to asm macro vdso_func

Sven Schnelle (1):
      s390/3270: Fix buffer assignment

 arch/s390/crypto/paes_s390.c                | 15 +++++++--
 arch/s390/include/asm/dwarf.h               |  1 +
 arch/s390/kernel/vdso64/vdso_user_wrapper.S |  2 ++
 arch/s390/mm/gmap.c                         |  2 +-
 arch/s390/mm/hugetlbpage.c                  |  2 +-
 drivers/s390/char/raw3270.c                 |  6 ++--
 drivers/s390/cio/cio_inject.c               |  2 +-
 drivers/s390/crypto/zcrypt_ccamisc.c        |  6 ++--
 drivers/s390/crypto/zcrypt_ep11misc.c       | 48 ++++++++++++++++++++++++++++-
 9 files changed, 73 insertions(+), 11 deletions(-)

