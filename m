Return-Path: <linux-kernel+bounces-119503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A129F88C9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07173B25701
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10CD200CB;
	Tue, 26 Mar 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QjX4/lOh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3B1BC4F;
	Tue, 26 Mar 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471638; cv=none; b=cofWrhbsUj3/kSLCu9SoZcIGxzXcCe7CMRcY2SDCeIitTe8U7e490nlSgjdUr9GO/ewKLO0KbczpoVCIYFG/VRPUGLtBF/L6wQkk0HoWC/ELWBFUF8iusx4k9Wte14hq+XG+c0UZ+MHyMZmF+2K0xySLanB3DJog4NFN1Swg/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471638; c=relaxed/simple;
	bh=9PD+9L0PVL8I44H98mCx75/QxiCwntwIQP0yJEXXBoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgOelhnm5PGJbiI6nGAtg0hZpwFyKvqcKwoAlTPr+oAB3R7UHckEobbmcuxblFu545WZ0U4Bic71tb626LVD5qd+o1DCJl3r8dHFS+/UkgzdLJlzueUqoQfd5WrnLNA0d+/s981MTwFGZWEr9laqLoTCrl9UptrBLgw8Ub96tpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QjX4/lOh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGcG1a007292;
	Tue, 26 Mar 2024 16:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nA44NqsR5fKRH/saS36EU5J3ow43IZqAtKqBh0Egb6o=;
 b=QjX4/lOh3QQThmM4A5F0PL/4sADAAMjmOdFZz5MW05U1EPgv2vYU9YUBtE/Vjf2COD74
 ufz0/1V82DdR0D89ltRipkrrgOBsMG2qMoKRO3aH1hojF2NDa++JvvxGCqzo9/uSm5ID
 2sXVY5ZRxCxS39pHHH+nqCXa2m82BDOL4LzKKuSctUqc2W6gx41vujqCeqlm7wfZZRE7
 NaJYm+fHkzMUij1ur0Q6hwQc2ynQawzm22haMWNt5rfOuq9SqZNdsMsMeO2uMCdAtwsw
 aKDi7e3xsgzjGrWQHbpgonKcEf/4e+U04KS8uZsELK0C0vYIXgYNhppO78u67my7EI26 nw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x421ug0wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QF2Aod013343;
	Tue, 26 Mar 2024 16:47:14 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0h453-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:14 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QGlBRg40895018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:47:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F405958062;
	Tue, 26 Mar 2024 16:47:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66DBB58057;
	Tue, 26 Mar 2024 16:47:10 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.173.44])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 16:47:10 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v4 5/5] docs: Update s390 vfio-ap doc for ap_config sysfs attribute
Date: Tue, 26 Mar 2024 12:47:06 -0400
Message-ID: <20240326164706.29167-6-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326164706.29167-1-jjherne@linux.ibm.com>
References: <20240326164706.29167-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M3-ajsD5t3XZ4CnqKjC7RS7A1DNARgpu
X-Proofpoint-ORIG-GUID: M3-ajsD5t3XZ4CnqKjC7RS7A1DNARgpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260119

A new sysfs attribute, ap_config, for the vfio_ap driver is
documented.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index 929ee1c1c940..6056a50ee841 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -380,6 +380,36 @@ matrix device.
     control_domains:
       A read-only file for displaying the control domain numbers assigned to the
       vfio_ap mediated device.
+    ap_config:
+        A read/write file that, when written to, allows all three of the
+        vfio_ap mediated device's ap matrix masks to be replaced in one shot.
+        Three masks are given, one for adapters, one for domains, and one for
+        control domains. If the given state cannot be set then no changes are
+        made to the vfio-ap mediated device.
+
+        The format of the data written to ap_config is as follows:
+        {amask},{dmask},{cmask}\n
+
+        \n is a newline character.
+
+        amask, dmask, and cmask are masks identifying which adapters, domains,
+        and control domains should be assigned to the mediated device.
+
+        The format of a mask is as follows:
+        0xNN..NN
+
+        Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
+        The leftmost (highest order) bit represents adapter/domain 0.
+
+        For an example set of masks that represent your mdev's current
+        configuration, simply cat ap_config.
+
+        Setting an adapter or domain number greater than the maximum allowed for
+        the system will result in an error.
+
+        This attribute is intended to be used by automation. End users would be
+        better served using the respective assign/unassign attributes for
+        adapters, domains, and control domains.
 
 * functions:
 
-- 
2.41.0


