Return-Path: <linux-kernel+bounces-119499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C588C9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0801F82367
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50461C6BB;
	Tue, 26 Mar 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W8MD0xOy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20317BA0;
	Tue, 26 Mar 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471636; cv=none; b=Qb4QVAN1Diq9xgNCU/YURUus8xzCLdigcDs6oAnZKNgjbDRgq92KIZYeBRj7dnkeM+euPU/nPmTrCXKZWbtb40GZS88O45jpZpe/+ufxY+H2Lc3+4i19UXYJYaXSArsavdK5oRJjEbpymU2/nvD3kNl4g4JP409wi7U9BJnPLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471636; c=relaxed/simple;
	bh=Dxc1Y9DEWjmEAUQcAuJqD4/uaanYXhVQFUYqIQzbI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/axkosc2ZFvPNcO81QTx3M6ADbM/bnXJbP+SX8h3jPDhOLoEsOA2/9bXUctllp1rZXjaaqqAt5uablsQTBbFOY37tOIOOy3p5QjKAC8tLXDPbHMPvG9tGIhPl9H0O6r7W76EMcDzboFqCbET4DWzroAS2vu0COv+Q8DVCEgIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W8MD0xOy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGabSn018343;
	Tue, 26 Mar 2024 16:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pfYAziHimuLD6Bq9AnCRElxIv/lJzmInAejaT3HQHeA=;
 b=W8MD0xOyyIcMZWjo2EO9NjYLSEHlGsXi5QFxAg2LAn/+eIQBOYwHtrdxaRnQDDZoqjuT
 m6wFBZdmMPbOCbivgxZ7NDTO++51xNE+glfHSRGuYaq2OmjVai3sDD5FEpS381JEeWss
 WJQLJC+aviOhzoJWfSixueJPD/XvnJ4mfLpSnC9PbDMHIL2+x4cNx2/GxU4ZxiZDrokI
 plCt4+quoidNVDM2O9VNzvYNfioFE3SK/aP1OY1YXsZa1kWYOoeV42fa6v3HVNVpwY9B
 5wC1ogyipUGpyDVUcCBeHkZFtmkF6ZzdvFj7CaVDQlbvEWn3AgaRwy9KbNt+Rorq5aMp aQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3xm7rme0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QG3Shh025458;
	Tue, 26 Mar 2024 16:47:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2awmrt2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QGl8jO41288382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:47:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 136FC58062;
	Tue, 26 Mar 2024 16:47:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F7C358057;
	Tue, 26 Mar 2024 16:47:07 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.173.44])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 16:47:07 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Harald Freudenberger <freude@linux.ibm.com>
Subject: [PATCH v4 1/5] s390/ap: Externalize AP bus specific bitmap reading function
Date: Tue, 26 Mar 2024 12:47:02 -0400
Message-ID: <20240326164706.29167-2-jjherne@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: SQaTNaPgxObLA2WesQSkXITqstTjNWAF
X-Proofpoint-GUID: SQaTNaPgxObLA2WesQSkXITqstTjNWAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403260119

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


