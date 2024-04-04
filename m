Return-Path: <linux-kernel+bounces-131461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57A898830
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2511C25CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3E84FD4;
	Thu,  4 Apr 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W7PJ78sE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F374C00;
	Thu,  4 Apr 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234845; cv=none; b=q/81Kx/2fe8WRCL9rRw8611/UZS7tcYkZFlFqLsGp0b0hyuGC/xBO35J0HlengSyRWG8P+HxLs+LZjDjnnpbqlR7oek11s4xbKR955iecGnzBeh5Mnd6FDtA9H/s3HgXU8bZeDNOa5cUUmT4cpnW+ln4YK63eRYyo79FFH41w2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234845; c=relaxed/simple;
	bh=NW8kvi+2BHITFVUBOt+mYFxtj4Iy0lqPNFnJwICtTus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKt7LU6QvLZsPOAAYDUl8slvQFlG89eY9WxBsuCBHKA6jvQ/Yvo5OXFDW4gouPElux3xDcblkzwiDVheAHJ0QFrBQ13+/aGMphNlCrgaXrOIQzHwjhbwpLpdwi/s4i8FZq3dApF+W+6tmDgsb1Ns5ihbOhrVxdIo1SiSVw4p7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W7PJ78sE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434CTHmr001877;
	Thu, 4 Apr 2024 12:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jQVn546JzbZiayanRErQzkY3/Hm81R6jogeh5ZmF8S8=;
 b=W7PJ78sEmWrrT6TVsUgpxe8BWM8jGwCLIWD4rGQNYiO5yXas5dyjmVKSniJG9rBXyj1x
 5hcB49MurHN4uYy4A3/0jcBIDbvihEgyoBXaG7w+RTnq73r+tJrNLpgYASSYx7l6xAs/
 eOpYn/qUPN+1z4Z+UD1mnTNxVxOdvXO3REWaBllmsgEOYUxPR9J88aQral4ktJJyy08x
 hSF5xzuKz9J2FU1mUnuxIn6gYUue8guBVeV1aKRHcf+BPLvuPlrifeDb4e8CW45k2QAZ
 y4/6F4poz0hMN6Wm28bmxM723jnMCtZHKNNdg8CYWmoGuFDqzpleL4epwlGlK4NPToN1 eg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9v870164-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 12:47:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434ANR1E008696;
	Thu, 4 Apr 2024 12:47:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw45pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 12:47:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434Cl12921037706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 12:47:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E85DB2004F;
	Thu,  4 Apr 2024 12:47:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC922004B;
	Thu,  4 Apr 2024 12:47:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 12:47:00 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] hwmon: Handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 14:46:59 +0200
Message-Id: <20240404124700.3807842-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LSy7Sk7HkctuLrhVQWuDrUbURsjBVDQ7
X-Proofpoint-ORIG-GUID: LSy7Sk7HkctuLrhVQWuDrUbURsjBVDQ7
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
 definitions=2024-04-04_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040087

Hi Jean, Guenter,

This is a follow up in my ongoing effort of making inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
subset of patches merged I've changed over to per-subsystem series. These
series are stand alone and should be merged via the relevant tree such
that with all subsystems complete we can follow this up with the final
patch that will make the I/O port accessors compile-time optional.

The current state of the full series with changes to the remaining
subsystems and the aforementioned final patch can be found for your
convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
signed tags. As for compile-time vs runtime see Linus' reply to my first
attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport_v6
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  hwmon: add HAS_IOPORT dependencies

 drivers/hwmon/Kconfig | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.40.1


