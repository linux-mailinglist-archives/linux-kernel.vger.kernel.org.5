Return-Path: <linux-kernel+bounces-28324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4982FCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCBE1C28440
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40BF3FE54;
	Tue, 16 Jan 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Duh6G9At"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226DB3FE31;
	Tue, 16 Jan 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442122; cv=none; b=OF+0yADKVWLf/lX7/sSqJIaguUIdeTQJiIpS0z2uQnne/d0+8knSEH+V4ni+NLQ3RP3Gpj8PctUegEW1D7/9/6hboVIKC7PaCjHXy8wMAxFO0ydgIcQhyAgJEZsdtTiHA4O5iFdanB669vSly2pJBfSytE/Vq8ax5mQ8Uy2OLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442122; c=relaxed/simple;
	bh=2kMngdY8XxaVbjjDWUSvjo23NQ0hWKVAhB8Afjw9Z2Y=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=Xw5Luq9ilb+c/J1o2eMbm2Qu9OK2oUP35U072S5BR8zgoGdIqBKV434FtnqvsLCf6WpFLbD+b/I4R3ACXJXIu/lGkDyMpZPCheU+cpg4dVlUA47BMHP+ZxDO605CgETUcm/naF7W2f8mRwCo2S2p/oku0W8g4QSudwkCKDavBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Duh6G9At; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GLqGaM014432;
	Tue, 16 Jan 2024 21:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yvYg34V1aSxXXxCa9jhpXGi7MKL9Geldai0x1AhQ2Pc=;
 b=Duh6G9Atwwj8hlDB0t5/XhQirIxKuRowJc5tc6zpjRlla7w/pInI2tPr0vezvtAr3KUQ
 5phhypEzWwCY+WEFTUH7CDNWPTAzbECFqouXQjbfckfU6PLLcjCXqWjVhT7Qhc/oJXeS
 ePkGHEfVeM8M1UPyQUDqpNZEsgu9zZzy0EQmhR5cVIxjlnY1a3ZEVpOYEnNUZqGhHt/W
 v8D7Hj5klK9iXd9ZAW6q2IK2gof1HWLI8+UEWUrGBlm6Hl0ryrM6ruOrzme4MLXChG8x
 4yCO5YRg9OOXVQR5YXBD0u7k5NK22H9CAPWAacqCl3bYl0mfccc+hJt6DQntgE9J/+vp LA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp0uk2f4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:55:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GJ6uTr008536;
	Tue, 16 Jan 2024 21:55:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5unhbnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:55:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GLtEjX20120134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 21:55:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC9C95804B;
	Tue, 16 Jan 2024 21:55:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB38258055;
	Tue, 16 Jan 2024 21:55:12 +0000 (GMT)
Received: from li-894d004c-2c43-11b2-a85c-d8bfeb5f0009.ibm.com.com (unknown [9.61.126.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 21:55:12 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: brking@linux.ibm.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        mikecyr@linux.ibm.com, target-devel@vger.kernel.org,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: update ibmvscsi_tgt maintainer
Date: Tue, 16 Jan 2024 13:55:09 -0800
Message-ID: <20240116215509.1155787-1-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vUXZxRlK2EjNgxk-lNMKbHmU3_INNj88
X-Proofpoint-GUID: vUXZxRlK2EjNgxk-lNMKbHmU3_INNj88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_13,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=797 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160172

Michael has not been responsible for this code as an IBMer for quite
sometime. Seeing as the rest of the IBM Virtual SCSI related drivers
already fall under my purview replace Michael with myself as maintainer.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 391bbb855cbe..1ed1aa7b21eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10226,7 +10226,7 @@ F:	drivers/scsi/ibmvscsi/ibmvscsi*
 F:	include/scsi/viosrp.h
 
 IBM Power Virtual SCSI Device Target Driver
-M:	Michael Cyr <mikecyr@linux.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
 L:	target-devel@vger.kernel.org
 S:	Supported
-- 
2.43.0


