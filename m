Return-Path: <linux-kernel+bounces-137186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D289DE56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C861F251BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602913C9C4;
	Tue,  9 Apr 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQSDXpZy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E10137C3C;
	Tue,  9 Apr 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675246; cv=none; b=WHR2WZG38k6xJyx6v1ONA5GVZTRrIks5r414OknnPTzvLORQoGOeiHcgE2mVrFQRKnfVpzF0ZO0wNudKepb6809md1LCnk4+tEUmdc62XVVyzMJVPrw3EimnLxa6fhcutPb2bByfnj7olcaSNImJGB6CA7A01Gzg0tsMJpppkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675246; c=relaxed/simple;
	bh=vrZ3tiCXBZGKXJNM3xzbtKkelxd/LhC9LT0HpY49ZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxHMsqL7B0G1bSC2dgyiDHnccUwIJpWgVJpqjb+WK0LAyEzWpSx0dJ0riM/GcEJBrNwerwnErtWZZZ1Y16eycOTURNVtTjOxZIDTwTgU7pS2nhYYO85sDS/1sTFd0fSwIOcI4tzWx5ZSfImEZTGshvtogJrwuyV2r5Ldcbh6w8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KQSDXpZy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BXpZS027182;
	Tue, 9 Apr 2024 15:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : reply-to :
 mime-version : content-transfer-encoding; s=corp-2023-11-20;
 bh=NnciRmIwPTaAFXCbUZhNskjo3Krm+iqTOHCJRaOrZmM=;
 b=KQSDXpZy8Ss/FTXgpmD1LmH0eA5jlyE41KToWiaE0QgieFIJQEE6D+RHMCoF8dLtwalH
 rs9kMzGLLUVeN7RNU+zlteysm8PTDD2NDoN3qf/3VDvOIB8UEe10qUtabXHHOR4WCIOB
 6tKKnDQiTRrRCSZ8ZKGGoQ4tI7BYo1PZS/pewQbG/jHrVUPKW6lxsOCQKAYKp6NQ+6LL
 nEOy/FItBB1rCkTuvoigKewCPQl9Y0hrlNWkOxa19FUO1SUvOWRC9GQybT/Bl6SA0TDo
 bjpFtc5JCdRkfsuVHp2ifU8+8Sc+ZmojF9dmrbuT6vmi2nELaQeboMVI8qV2cT13n+r4 dA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf56wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:07:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439EM5EU040105;
	Tue, 9 Apr 2024 15:07:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud4825-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:07:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439F1w6o031745;
	Tue, 9 Apr 2024 15:07:11 GMT
Received: from mlluis-mac.nl.oracle.com (dhcp-10-175-24-232.vpn.oracle.com [10.175.24.232])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavud47d2-4;
	Tue, 09 Apr 2024 15:07:11 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan.Cameron@Huawei.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rmk+kernel@armlinux.org.uk, miguel.luis@oracle.com
Subject: [RFC PATCH 3/4] ACPI: processor: refactor acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under CONFIG_ACPI_HOTPLUG_CPU
Date: Tue,  9 Apr 2024 15:05:32 +0000
Message-ID: <20240409150536.9933-4-miguel.luis@oracle.com>
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
X-Proofpoint-GUID: sdbUCffTnZ_HAFUvfazlqtPTFw5WQMTG
X-Proofpoint-ORIG-GUID: sdbUCffTnZ_HAFUvfazlqtPTFw5WQMTG

mapping and unmaping a cpu at the stage of extra cpu enumeration is
architecture specific which depends on CONFIG_ACPI_HOTPLUG_CPU so let's
isolate that functionality from architecture independent one.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 drivers/acpi/acpi_processor.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 9ea58b61d741..c6e2f64a056b 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -194,8 +194,21 @@ static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr)
 	pr_info("CPU%d has been hot-added\n", pr->id);
 	pr->flags.need_hotplug_init = 1;
 }
+static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
+{
+	return acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
+}
+static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor *pr)
+{
+	acpi_unmap_cpu(pr->id);
+}
 #else
 static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr) {}
+static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
+{
+	return 0;
+}
+static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor *pr) {}
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 /* Enumerate extra CPUs */
@@ -215,13 +228,13 @@ static int acpi_processor_enumerate_extra(struct acpi_processor *pr)
 	cpu_maps_update_begin();
 	cpus_write_lock();
 
-	ret = acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
+	ret = acpi_processor_hotplug_map_cpu(pr);
 	if (ret)
 		goto out;
 
 	ret = arch_register_cpu(pr->id);
 	if (ret) {
-		acpi_unmap_cpu(pr->id);
+		acpi_processor_hotplug_unmap_cpu(pr);
 		goto out;
 	}
 
-- 
2.43.0


