Return-Path: <linux-kernel+bounces-137187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5789DE5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDFA28463E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFD13CA84;
	Tue,  9 Apr 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSFgDaUd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20413C9C3;
	Tue,  9 Apr 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675248; cv=none; b=Gusmyndb4OXzfhUpwFwpCrPQvc6+NZzgQc+ps5OxegTUWjHrSN+UvJPPOqsRb4Lp3wiqB/qHw4bwJn2hDYT/jdethVv3qpFo0y8RRdKNtVviBsqC9XdtMdg+NuVloIvoHKTK5xxqhRKAJaDDoDS62Do6yP8VZ23liPI+uqxeOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675248; c=relaxed/simple;
	bh=Fr/7Vk+42GlrQK5lyg4HKEM7UAJHjX9Lce4HDrPk0cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNB/nz7V/CoXpohIOPllN1H/9hAvSNGVE1PGwKso5sVU5SD8++wW2en4SpDf5CNOSciXTc81ZGbo7FcE4cn0Nx2tK7xNpOQ1biSNejK0Y/Va8yAbFIZU7unEDnxhtIqmDKdV5QT+mPNKNSVP593rX7R17SuUc9LANmMYa88T0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSFgDaUd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BXpcU027169;
	Tue, 9 Apr 2024 15:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : reply-to :
 mime-version : content-transfer-encoding; s=corp-2023-11-20;
 bh=ADojagcKuzpE+KHCFjAYBG/GaH/BcFxdSuinTPiEx78=;
 b=YSFgDaUd9R08vJyXaNNqHAtjImTSsrneId3SLgoaFoSEefaAajCnxnct62cVMZHEZIEH
 lUnAy70aOE71iG5uosjsC748KJ5uPZjkALf+rMWsj5uvy2cQjmwbay902vDOTqFzb5S7
 jYlwD5o4oKfp/TVeqRixOy3qZoLCJ0xD2GqQykQs8zIhwficiR2SAhagXJEbrd1ETnGm
 ZfJ+DkaMrZOBe7UHBBWg61skawIoPX4GztZuZXgywNBaKtdI/vqxWNcUSY3wmhKK+E7c
 4fgd9WyKh96LjcJ5kaZ3gJluwUczETjHYcVD7WLyLqI5HmrMa8gv+wbGI19pVCOFza7y Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf56wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:07:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439E5MVC039988;
	Tue, 9 Apr 2024 15:07:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud4870-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:07:18 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439F1w6q031745;
	Tue, 9 Apr 2024 15:07:18 GMT
Received: from mlluis-mac.nl.oracle.com (dhcp-10-175-24-232.vpn.oracle.com [10.175.24.232])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavud47d2-5;
	Tue, 09 Apr 2024 15:07:17 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan.Cameron@Huawei.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rmk+kernel@armlinux.org.uk, miguel.luis@oracle.com
Subject: [RFC PATCH 4/4] ACPI: processor: refactor acpi_processor_remove: isolate acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU
Date: Tue,  9 Apr 2024 15:05:33 +0000
Message-ID: <20240409150536.9933-5-miguel.luis@oracle.com>
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
X-Proofpoint-GUID: 4t9WjYmlI0fwn8f5L_G8oSP9tktfBByP
X-Proofpoint-ORIG-GUID: 4t9WjYmlI0fwn8f5L_G8oSP9tktfBByP

acpi_unmap_cpu is architecture dependent. Isolate it.
The pre-processor guard for detach may now be restricted to
cpu unmap.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 drivers/acpi/acpi_processor.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c6e2f64a056b..edcd6a8d4735 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -492,6 +492,14 @@ static int acpi_processor_add(struct acpi_device *device,
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
+static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *pr)
+{
+	acpi_unmap_cpu(pr->id);
+}
+#else
+static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *pr) {}
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 /* Removal */
 static void acpi_processor_remove(struct acpi_device *device)
 {
@@ -524,7 +532,7 @@ static void acpi_processor_remove(struct acpi_device *device)
 
 	/* Remove the CPU. */
 	arch_unregister_cpu(pr->id);
-	acpi_unmap_cpu(pr->id);
+	acpi_processor_hotunplug_unmap_cpu(pr);
 
 	cpus_write_unlock();
 	cpu_maps_update_done();
@@ -535,7 +543,6 @@ static void acpi_processor_remove(struct acpi_device *device)
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 	kfree(pr);
 }
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 bool __init processor_physically_present(acpi_handle handle)
@@ -660,9 +667,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
 	.detach = acpi_processor_remove,
-#endif
 	.hotplug = {
 		.enabled = true,
 	},
-- 
2.43.0


