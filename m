Return-Path: <linux-kernel+bounces-137185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D389DE55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA5294F46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D513C91D;
	Tue,  9 Apr 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UzIsA1JO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DF137C3C;
	Tue,  9 Apr 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675237; cv=none; b=UcfO5FXBBD6YkhPGYofFEdQFyzIgI/eYw51xgL2pRt/xM3QSzB03RjsUl+etomIJ1RYHnRPP5OfKCV2TsMs6vn2M6BIlGQB0+jMJPEBkoej/RwZpP3mK++x3R5dQpgsmHZjO6zMDIBxZJKYOc60iDl9+WihoMjp2UGO2CwJ2WxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675237; c=relaxed/simple;
	bh=GkKaCNKtD+yJTbUhmLsEYlYnm2psQdcVXTC45xfJ9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBjlRMjYH2SPYneAm2VIgqI7diTXGnXWRUIfyY6U2ZCgISpSs+iMx5Xqdp2H8oHCbq6wmghRs7NOhVB5bAo78JZy4860qG705AuwLV2M3SIyONIygb5APMX1YVE/eSVUj30T+p02jXBZDV9S0RKF0vOcRRGe1t8JuSTMY5j6Euc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UzIsA1JO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYIB6031273;
	Tue, 9 Apr 2024 15:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : reply-to :
 mime-version : content-transfer-encoding; s=corp-2023-11-20;
 bh=V6sBKvwQdVULyOl0ljTolpSlHxl8QLBq8rG46va5X5c=;
 b=UzIsA1JOrSprccNf9UY+IRYpXM302NPuOU3lrZ1uf0UJ3m111Obh1HePNHLegIIzg0pE
 16TnOFi9jExJf7+Vf5f4yi6ESBh1AKhgbX7gWIEDV6Gr1cJc8H7DViBDzjzkr/XCmbPk
 0Ki1w/uh01BWnPuh7IHk5S4gHMJSE15EAu6hcyuws5LIVpVkMZOw3QyTKo6nD1Lkg2tt
 SJBrScdQr5NLEXfmngmxlV9XEfaFCz27cGlBXDSjjUjdJVC7WFs5YzL3YeTh+NMRgHl4
 ePbQAkG7gQyvpG1crJdhxg0oak9cPHc1ckYSpTI8g1NPfQmkuBv8R9N7Ensd7WiIojf6 Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b56ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:07:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DopLj040673;
	Tue, 9 Apr 2024 15:07:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud47v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:07:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439F1w6m031745;
	Tue, 9 Apr 2024 15:07:04 GMT
Received: from mlluis-mac.nl.oracle.com (dhcp-10-175-24-232.vpn.oracle.com [10.175.24.232])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavud47d2-3;
	Tue, 09 Apr 2024 15:07:03 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan.Cameron@Huawei.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rmk+kernel@armlinux.org.uk, miguel.luis@oracle.com
Subject: [RFC PATCH 2/4] ACPI: processor: refactor acpi_processor_get_info: isolate cpu hotpug init delay
Date: Tue,  9 Apr 2024 15:05:31 +0000
Message-ID: <20240409150536.9933-3-miguel.luis@oracle.com>
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
X-Proofpoint-GUID: cV17hYUM9voXWnUWxkkOMJip5Ea1uxhP
X-Proofpoint-ORIG-GUID: cV17hYUM9voXWnUWxkkOMJip5Ea1uxhP

Delaying a hotplugged CPU initialization depends on
CONFIG_ACPI_HOTPLUG_CPU. Isolate that.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 drivers/acpi/acpi_processor.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 37e8b69113dd..9ea58b61d741 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -184,7 +184,22 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 
 /* Initialization */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr)
+{
+	/*
+	 * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
+	 * to delay cpu_idle/throttling initialization and do it when the CPU
+	 * gets online for the first time.
+	 */
+	pr_info("CPU%d has been hot-added\n", pr->id);
+	pr->flags.need_hotplug_init = 1;
+}
+#else
+static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr) {}
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
+/* Enumerate extra CPUs */
+static int acpi_processor_enumerate_extra(struct acpi_processor *pr)
 {
 	unsigned long long sta;
 	acpi_status status;
@@ -210,25 +225,12 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 		goto out;
 	}
 
-	/*
-	 * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
-	 * to delay cpu_idle/throttling initialization and do it when the CPU
-	 * gets online for the first time.
-	 */
-	pr_info("CPU%d has been hot-added\n", pr->id);
-	pr->flags.need_hotplug_init = 1;
-
+	acpi_processor_hotplug_delay_init(pr);
 out:
 	cpus_write_unlock();
 	cpu_maps_update_done();
 	return ret;
 }
-#else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 static int acpi_evaluate_processor(struct acpi_device *device,
 				   struct acpi_processor *pr,
@@ -347,7 +349,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_enumerate_extra(pr);
 
 		if (ret)
 			return ret;
-- 
2.43.0


