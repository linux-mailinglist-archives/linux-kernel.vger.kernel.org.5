Return-Path: <linux-kernel+bounces-40193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A349283DC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA801C21145
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595451CA9C;
	Fri, 26 Jan 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E45PA3mk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF071C2AE;
	Fri, 26 Jan 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279738; cv=none; b=VpRXUJHSZmwwWcEh/+0OTv/FVX6H+MUuwNYSyIYzudtsHI7d2blXALlsvkioV5VXjNCV+akvgR7LtfVeTOHMyzXNp2aulTti/f+ek8qgsN0/UVykelowkKkqhnuLxnTPxrAVSLtThlJTMyAT63drTicOaSBwlqNQ+1PwSiG+8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279738; c=relaxed/simple;
	bh=lt9n31jv/yU2JSl+0zgED1hlEvS2kU2A0TEdLawFUHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bla9w2tfjiQCcvrP5KDLz4OrLpElFUFRvCWQhtZv/svE4mMighMtl1cy4Q7NdTPthCtzCIHiONCZehixR7UuakYixhj4U8hypBP/+kuOqptL341ZHSceHFPzuA9aMRD/6IaNkcfa/BlX/BjPFAtripAKe+TtV9p8zpKV3lItu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E45PA3mk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QE2EbH026646;
	Fri, 26 Jan 2024 14:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=z/SdZU2JXrVdKagPc451t/XnhXWjlsUg+ntvrJXJtgQ=;
 b=E45PA3mku4WETFSlxTqPg/M2zpuZhyLbGHvsOJR+Ho4E5aFrOv24D81ZHPoZfIV8+Tnb
 l1/aD0od+9DvXxM36xoyqedjN36rWOJ3xbNY27UBzmFUqybvwm8WF55wHPNx2l30KEbU
 CPa1LQWWKPBA7i4BLMksnz+5Vq+atGRWqYXN+YnE5sfjNiag65Gx2NfVoB62CV7a+emQ
 8oXaP2ekC7drrnBBbnbBmNllTmRRUJtbQzCJM4xhKVLCw/uuywYd5GGQtbsJxo+ff044
 pbIUVJKAiUg6yx9/llnY1AFGtPoaD+e4+PA/3GZEZ/Q/1fhEaTWfR14H63lsvuvzr6+e zQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vve53974v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEU4Xo025638;
	Fri, 26 Jan 2024 14:35:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgpk89s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QEZYTO3212250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:35:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEDB15805A;
	Fri, 26 Jan 2024 14:35:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8C758063;
	Fri, 26 Jan 2024 14:35:33 +0000 (GMT)
Received: from li-4795344c-3451-11b2-a85c-ab40c30bcc43.ibm.com (unknown [9.61.37.129])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 14:35:33 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [PATCH 0/3] s390/vfio-ap: queue_configuration sysfs attribute for mdevctl automation
Date: Fri, 26 Jan 2024 09:35:30 -0500
Message-ID: <20240126143533.14043-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p4PrDNSiaUQnyhnwc-unCR_wslib7Lke
X-Proofpoint-ORIG-GUID: p4PrDNSiaUQnyhnwc-unCR_wslib7Lke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxlogscore=533 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401260106

Mdevctl requires a way to atomically query and atomically update a vfio-ap
mdev's current state. This patch set creates the queue_configuration sysfs
attribute.  This new attribute allows reading and writing an mdev's entire
state in one go. If a newly written state is invalid for any reason the entire
state is rejected and the target mdev remains unchanged.

Jason J. Herne (3):
  s390/ap: Externalize AP bus specific bitmap reading function
  s390/vfio-ap: Add sysfs attr, queue_configuration, to export mdev
    state
  s390/vfio-ap: Add write support to sysfs attr ap_config

 Documentation/arch/s390/vfio-ap.rst   |  27 ++++
 drivers/s390/crypto/ap_bus.c          |  13 +-
 drivers/s390/crypto/ap_bus.h          |  22 +++
 drivers/s390/crypto/vfio_ap_ops.c     | 213 +++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 5 files changed, 248 insertions(+), 33 deletions(-)

-- 
2.41.0


