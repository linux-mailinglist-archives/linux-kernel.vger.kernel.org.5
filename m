Return-Path: <linux-kernel+bounces-145452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C428A5652
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DA1C20F13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A179B8E;
	Mon, 15 Apr 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GugxTYs/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759142047;
	Mon, 15 Apr 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194764; cv=none; b=NQwRv8XThg6JhfQhCT93n/Uk+nuWV1c//8w9EOwMfIlgoSmm2PkjkIgpfD0WmLg/oP5BGEqpy0f70uvOHNY97SlBXOxH6DUwEuLLlz0eEL3voNKjUj/zJ0OKUusjjfMgUzQQZvniUElZKJl/Zj4m3oHTURe1ySUDRGZ9kG9u1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194764; c=relaxed/simple;
	bh=Dxc1Y9DEWjmEAUQcAuJqD4/uaanYXhVQFUYqIQzbI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4mc2BgovSlZw/AgvgKRO0KQevztzsdGtTaceYBfBMiSVCFiki8EwPA+5UICoYTGJNwTwJwp9VRTJwEDizKOO7GAvcMa45JGXg2NGfl6ruN6SmyYPEyeqBiqMY40DgmuAqiOHlVvOCzZXKP8veyV8DWTK2IQI6/ywdrcY9TwIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GugxTYs/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FEOiRO008851;
	Mon, 15 Apr 2024 15:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pfYAziHimuLD6Bq9AnCRElxIv/lJzmInAejaT3HQHeA=;
 b=GugxTYs/JAlt+wY7MGLKeyalswq2/ZO6w4GPe8jeXOWxTGhS37tHCDxutdpQDyIemGDA
 Y72aEPIuQkAh4OzBjGyloMPJU9GSB0ZX0tX3C3952vgZ9GlF8rAh0s39whxl6jtphEga
 y7I8Ones50ObSyFD6ucxJK5Tg368BmMA7eS6Vj0XtMwl18R3m2QpFv3BUPuPH87UyptX
 UmlZIsebBSu4w+ZxRpQgLgAXaLfUXmTs4H0M2xFLdWUlU75GAIH84Iq4nMfhpjtMaV6z
 /XSimjIOVhUC36aa3ig3o5v+aNwaw0Nn13McAKGLSYHLGDHPSfxA/6iqxzgyk7nJOvqu NQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh0btgwfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FF2P4t018157;
	Mon, 15 Apr 2024 15:25:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct0u1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:25:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FFPuiT66257360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 15:25:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A132458059;
	Mon, 15 Apr 2024 15:25:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B9858043;
	Mon, 15 Apr 2024 15:25:56 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.81.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 15:25:56 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Harald Freudenberger <freude@linux.ibm.com>
Subject: [PATCH v5 1/5] s390/ap: Externalize AP bus specific bitmap reading function
Date: Mon, 15 Apr 2024 11:25:51 -0400
Message-ID: <20240415152555.13152-2-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240415152555.13152-1-jjherne@linux.ibm.com>
References: <20240415152555.13152-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: twUKYu7N204vEgHIYo5tToE-yrUrCj5d
X-Proofpoint-GUID: twUKYu7N204vEgHIYo5tToE-yrUrCj5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150100

Rename hex2bitmap() to ap_hex2bitmap() and export it for external
use. This function will be used by the implementation of the vfio-ap
ap_config sysfs attribute.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 13 +++----------
 drivers/s390/crypto/ap_bus.h | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index cce0bafd4c92..1be07197eda3 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1068,15 +1068,7 @@ void ap_bus_cfg_chg(void)
 	ap_bus_force_rescan();
 }
 
-/*
- * hex2bitmap() - parse hex mask string and set bitmap.
- * Valid strings are "0x012345678" with at least one valid hex number.
- * Rest of the bitmap to the right is padded with 0. No spaces allowed
- * within the string, the leading 0x may be omitted.
- * Returns the bitmask with exactly the bits set as given by the hex
- * string (both in big endian order).
- */
-static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
+int ap_hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 {
 	int i, n, b;
 
@@ -1103,6 +1095,7 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(ap_hex2bitmap);
 
 /*
  * modify_bitmap() - parse bitmask argument and modify an existing
@@ -1168,7 +1161,7 @@ static int ap_parse_bitmap_str(const char *str, unsigned long *bitmap, int bits,
 		rc = modify_bitmap(str, newmap, bits);
 	} else {
 		memset(newmap, 0, size);
-		rc = hex2bitmap(str, newmap, bits);
+		rc = ap_hex2bitmap(str, newmap, bits);
 	}
 	return rc;
 }
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 59c7ed49aa02..1db9597509da 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -343,6 +343,28 @@ int ap_parse_mask_str(const char *str,
 		      unsigned long *bitmap, int bits,
 		      struct mutex *lock);
 
+/*
+ * ap_hex2bitmap() - Convert a string containing a hexadecimal number (str)
+ * into a bitmap (bitmap) with bits set that correspond to the bits represented
+ * by the hex string. Input and output data is in big endian order.
+ *
+ * str - Input hex string of format "0x1234abcd". The leading "0x" is optional.
+ * At least one digit is required. Must be large enough to hold the number of
+ * bits represented by the bits parameter.
+ *
+ * bitmap - Pointer to a bitmap. Upon successful completion of this function,
+ * this bitmap will have bits set to match the value of str. If bitmap is longer
+ * than str, then the rightmost bits of bitmap are padded with zeros. Must be
+ * large enough to hold the number of bits represented by the bits parameter.
+ *
+ * bits - Length, in bits, of the bitmap represented by str. Must be a multiple
+ * of 8.
+ *
+ * Returns: 0           on success
+ *          -EINVAL     If str format is invalid or bits is not a multiple of 8.
+ */
+int ap_hex2bitmap(const char *str, unsigned long *bitmap, int bits);
+
 /*
  * Interface to wait for the AP bus to have done one initial ap bus
  * scan and all detected APQNs have been bound to device drivers.
-- 
2.41.0


