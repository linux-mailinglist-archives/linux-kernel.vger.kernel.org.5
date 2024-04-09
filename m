Return-Path: <linux-kernel+bounces-137184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3CF89DE4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356AF294E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856D137C3A;
	Tue,  9 Apr 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNzkMCcP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBB131197;
	Tue,  9 Apr 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675236; cv=none; b=RUQGYJ9PzALa1KrOBh1IOFxNbmoj4NfkB/OWE2LBb8BicmoATtNVPfQn8cPcw3RUsHCOUb1+6699pvUfiNfmT+ouTd3SiAjq9zqWOxybNr4TQasg2pf7qQc4b32VsVWyvL3HgB12j7LSZn4HHaXWIj7HGKCFaQ+9mhB4CuNjXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675236; c=relaxed/simple;
	bh=v5X5ay6bRK+RfiHpqY5h3r7grwaUPVO4lbpVntbmqDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfFj66Zs0lUsYJm092qPajjWQqdK3WGIHg9kjKSJA1ydmzyDk6tyZsPO3qrahmGfE1UyHA4BpoEyQSgscZyEugFtks3LPaQ4fHHNkI4t6t1RWNfB767Xf73syAkSE72xv/pmHUGqgoCIaznTF5IfO7Rhi5G0MkXWrk36/86LKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNzkMCcP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYUNw005163;
	Tue, 9 Apr 2024 15:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : reply-to :
 mime-version : content-transfer-encoding; s=corp-2023-11-20;
 bh=6flji1xebiuIQY9vm5RGgAnfjZP82r1pWe547+YkqOg=;
 b=QNzkMCcPeALhqCrdV0T6bUBT2tVpKsxJ6Ov4SyddO3XnULP/CNyw0OMvJRGFjA2gnfhX
 psW94vCPL1ku4AcMljfuh08QnnofpEB8GtY87o8jUnIFrpgEXlzV8h23Nls/+a60x6e7
 XPb0M/HXTGyGtSQ9uz8rAB7uB8E9mBK0syRuyPEhp0JbpUEW9I0Pds+ThukBtb7R7gDm
 iAGtqLi9S206f+J8yLoZF9v0yFEr4gAEjyS/bxSc5ZbWh4VnETTz3dGem0flGyDxU703
 qUaJ6LrFTmDAr92UApL28a4i4XLxuAV5sNxASWG63j0tQ/h/gM4KlF6vF8ZPpNB0dxUb +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0258vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:06:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DtccH040068;
	Tue, 9 Apr 2024 15:06:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud47qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:06:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439F1w6k031745;
	Tue, 9 Apr 2024 15:06:57 GMT
Received: from mlluis-mac.nl.oracle.com (dhcp-10-175-24-232.vpn.oracle.com [10.175.24.232])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavud47d2-2;
	Tue, 09 Apr 2024 15:06:56 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan.Cameron@Huawei.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rmk+kernel@armlinux.org.uk, miguel.luis@oracle.com
Subject: [RFC PATCH 1/4] ACPI: processor: refactor acpi_processor_get_info: evaluation of processor declaration
Date: Tue,  9 Apr 2024 15:05:30 +0000
Message-ID: <20240409150536.9933-2-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409150536.9933-1-miguel.luis@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
Reply-To: miguel.luis@oracle.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090099
X-Proofpoint-ORIG-GUID: qk7BfKjnExLtSngZjCVAuzkZF39q4ij3
X-Proofpoint-GUID: qk7BfKjnExLtSngZjCVAuzkZF39q4ij3

Isolate the evaluation of processor declaration into its own function.

No functional changes.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 drivers/acpi/acpi_processor.c | 78 +++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..37e8b69113dd 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -230,15 +230,59 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 }
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
+static int acpi_evaluate_processor(struct acpi_device *device,
+				   struct acpi_processor *pr,
+				   union acpi_object *object,
+				   int *device_declaration)
+{
+	struct acpi_buffer buffer = { sizeof(union acpi_object), object };
+	acpi_status status = AE_OK;
+	unsigned long long value;
+
+	/*
+	 * Declarations via the ASL "Processor" statement are deprecated.
+	 */
+	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
+		/* Declared with "Processor" statement; match ProcessorID */
+		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&device->dev,
+				"Failed to evaluate processor object (0x%x)\n",
+				status);
+			return -ENODEV;
+		}
+
+		value = object->processor.proc_id;
+		goto out;
+	}
+
+	/*
+	 * Declared with "Device" statement; match _UID.
+	 */
+	status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
+					NULL, &value);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&device->dev,
+			"Failed to evaluate processor _UID (0x%x)\n",
+			status);
+		return -ENODEV;
+	}
+
+	*device_declaration = 1;
+out:
+	pr->acpi_id = value;
+	return 0;
+}
+
 static int acpi_processor_get_info(struct acpi_device *device)
 {
 	union acpi_object object = { 0 };
-	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
 	unsigned long long value;
+	int ret;
 
 	acpi_processor_errata();
 
@@ -252,32 +296,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	} else
 		dev_dbg(&device->dev, "No bus mastering arbitration control\n");
 
-	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
-		/* Declared with "Processor" statement; match ProcessorID */
-		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status)) {
-			dev_err(&device->dev,
-				"Failed to evaluate processor object (0x%x)\n",
-				status);
-			return -ENODEV;
-		}
-
-		pr->acpi_id = object.processor.proc_id;
-	} else {
-		/*
-		 * Declared with "Device" statement; match _UID.
-		 */
-		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
-						NULL, &value);
-		if (ACPI_FAILURE(status)) {
-			dev_err(&device->dev,
-				"Failed to evaluate processor _UID (0x%x)\n",
-				status);
-			return -ENODEV;
-		}
-		device_declaration = 1;
-		pr->acpi_id = value;
-	}
+	/*
+	 * Evaluate processor declaration.
+	 */
+	ret = acpi_evaluate_processor(device, pr, &object, &device_declaration);
+	if (ret)
+		return ret;
 
 	if (acpi_duplicate_processor_id(pr->acpi_id)) {
 		if (pr->acpi_id == 0xff)
-- 
2.43.0


