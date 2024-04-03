Return-Path: <linux-kernel+bounces-129879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2489718B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CF0B272DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C4149017;
	Wed,  3 Apr 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vb6APOBp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6A14882B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152138; cv=none; b=u75ZYPJmDEZW/Hs0MwhwRhzlmKxQdk08dJdlPgkHJHMRUdb29jqY6bhAw475rN1eQefq9P/Ji9PWkoKRwpRvzSnanuhadqk0gnRaS95o6IkO1CiR19reC/hV0vaA46vSJYE9AkmjdaWUnl0D+LGbjfDB+ppV0L4B/Ii6Yleoisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152138; c=relaxed/simple;
	bh=9YX2yhCzfAJegJoFXC12+a3iew99VIhPK/Z/r6A4cGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMRqj1roUwFHdPiP0KzuvsvHyJYt4vkZaaYwvEYS4ySB3Ggl1TdYlX4D5hEywx1ahoMCVZhOEfIsxLt24Mq6dr7VVDkjM+NoAlLTNP/9lBVSPU4FzTBCYVpPYTT48OJZKzwJEMawJM81m9L5ozjZSyezoq2FW29FnB9vhFtb2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vb6APOBp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433DUXwT018108;
	Wed, 3 Apr 2024 13:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4W4KUIzxuSN+Xr+nkXb5WLxVOa7Pee4oM+/d+NsVcJ4=;
 b=Vb6APOBpT9c+aFLHPi8pwNWkZ1F0iTG0n4BCrK2PwS57Z343Z1C4jVsDeoAYJUl9s5Jq
 QFoGOYjIhUDZPgYAInwKjWvtoeGjBF8BhqMh+Hz2NPaufx3BO8tmfZjF0ImY0SxvJzM7
 8/RXYR3dcso4eH3Jsu0n2/+wis/T4W0SRScfso33ff8GE88YQ9sg0pWHgUEH/IYYX6jo
 eHtf7qxHgMU5FdRkFxUXKAR5qfczqLIQ6V5RjfcglWeIcatmFpM8oVWacc4fav9iBEW9
 e9IPFYoQqhDk31amQpPfd51y5UTMO5f6maocAFvAwxurHFM1OKvU39EoAfEJWPKhU0nZ Xw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9828r1ev-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:48:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433CuU7L002249;
	Wed, 3 Apr 2024 13:25:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmnasd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:25:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433DPmjQ33095966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:25:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E9F20040;
	Wed,  3 Apr 2024 13:25:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2532C2004B;
	Wed,  3 Apr 2024 13:25:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:25:48 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] kgdb: add HAS_IOPORT dependency
Date: Wed,  3 Apr 2024 15:25:47 +0200
Message-Id: <20240403132547.762429-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403132547.762429-1-schnelle@linux.ibm.com>
References: <20240403132547.762429-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f9976-4sLIEDDPovhnRoM57L60Vf9wcQ
X-Proofpoint-ORIG-GUID: f9976-4sLIEDDPovhnRoM57L60Vf9wcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_13,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=792 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404030095

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 lib/Kconfig.kgdb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index b5c0e6576749..537e1b3f5734 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -122,6 +122,7 @@ config KDB_DEFAULT_ENABLE
 config KDB_KEYBOARD
 	bool "KGDB_KDB: keyboard as input device"
 	depends on VT && KGDB_KDB && !PARISC
+	depends on HAS_IOPORT
 	default n
 	help
 	  KDB can use a PS/2 type keyboard for an input device
-- 
2.40.1


