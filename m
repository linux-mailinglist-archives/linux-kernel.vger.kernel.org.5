Return-Path: <linux-kernel+bounces-151235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F428AAB87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F3282D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F679950;
	Fri, 19 Apr 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFtrDPpn"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1C76056;
	Fri, 19 Apr 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519388; cv=none; b=XYnOu0FfkQV6r/RKM/J4mTxWordal97KLhGog7EYYf6VB+DFlTpL1wnhN7eF5e8tbaT4HtkYvTIwpSeYPjeWxXSPS0mQJ51JHadivELg34Le10psq8a+U8xyOcInCPlB0w21/c54/McFxsQsh9plvaqoo8ShOm6nQSEXBnDn8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519388; c=relaxed/simple;
	bh=pVoEBispAuhz1X3KRKt7GjhxZ39A1cips6MmJgeFskk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Wx/dOOMpUGsm/fMHdqgclvi6/Q3w9UDvL3P4zYFoCp0/Dt2opP2ZgQW1vTcueiox98afcwMTGrDnAP3jW+dkf89pJPoO0RFabXt8e0B2eEDXZMvyRyD50b7E6sHLO2srhiJmT+/Og2jVWDcDxnzOeB5m6TNdHU1S0dV2IDQ5JMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFtrDPpn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J9U5dm002818;
	Fri, 19 Apr 2024 09:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=cc+E30QdgRway+asTrkjxwCgKoF2SlLFeoyzKYQYxQk=;
 b=sFtrDPpn+8wtJdtqwXFFdNa/yZ78+UTz4F/lwe7mpvDEdDrn6AR2bwmDwPJe4sDV0SC6
 t+5x6vEjnTsAogVVq5ZnUkNjPrh5nrRUV76iQzsoMkqUvEZr4yHbviDAf5Td3BlnRVpQ
 iJtk9V9MNiWT8rzJCrN+WFq0xA21GxWOWaXxbnqNFPnkw8ZS3jtuKsI2f8UA8XDP8nWM
 /DDVjO4PA9lmchn6xgm3R2QZ4cE8VxcZIMNGaRW7YDwPuAymrDl+c45K0eSyB1aIRfF2
 iVWo+D6lf0JVTFEDHuQ98x+Rxm/YeMXnLBdM3SJuiYoKQvTFx4oDr61+Qrh66rZLnEju 6A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkp0h00fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 09:36:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8joMk022762;
	Fri, 19 Apr 2024 09:36:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbk92ty2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 09:36:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43J9aHa351970446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:36:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DDF32004D;
	Fri, 19 Apr 2024 09:36:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58E2520043;
	Fri, 19 Apr 2024 09:36:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 09:36:17 +0000 (GMT)
Date: Fri, 19 Apr 2024 11:36:15 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.9-rc5
Message-ID: <ZiI7D+RjyM57l+PE@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XVMtfh6PJ59zpa70HxKcQ2wbBTnnts6_
X-Proofpoint-ORIG-GUID: XVMtfh6PJ59zpa70HxKcQ2wbBTnnts6_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=387 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190070

Hi Linus,

please pull s390 fixes for 6.9-rc5.

Thanks,
Alexander

The following changes since commit 378ca2d2ad410a1cd5690d06b46c5e2297f4c8c0:

  s390/entry: align system call table on 8 bytes (2024-04-03 15:00:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-4

for you to fetch changes up to d111855ab7ffffc552f6a475259dc392f2319b6d:

  s390/mm: Fix NULL pointer dereference (2024-04-17 17:26:34 +0200)

----------------------------------------------------------------
s390 updates for 6.9-rc5

- Fix NULL pointer dereference in program check handler

- Fake IRBs are important events relevant for problem analysis.
  Add traces when queueing and delivering

- Fix a race condition in ccw_device_set_online() that can cause the
  online process to fail

- Deferred condition code 1 response indicates that I/O was not started
  and should be retried. The current QDIO implementation handles a cc1
  response as an error, resulting in a failed QDIO setup. Fix that by
  retrying the setup when a cc1 response is received

----------------------------------------------------------------
Peter Oberparleiter (3):
      s390/qdio: handle deferred cc1
      s390/cio: fix race condition during online processing
      s390/cio: log fake IRB events

Sven Schnelle (1):
      s390/mm: Fix NULL pointer dereference

 arch/s390/kernel/entry.S      |  3 ++-
 drivers/s390/cio/device.c     | 13 ++++++++-----
 drivers/s390/cio/device_fsm.c |  5 +++++
 drivers/s390/cio/device_ops.c |  8 ++++++++
 drivers/s390/cio/qdio_main.c  | 28 +++++++++++++++++++++++-----
 5 files changed, 46 insertions(+), 11 deletions(-)

