Return-Path: <linux-kernel+bounces-61099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A6850D42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819731C22C51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4D5680;
	Mon, 12 Feb 2024 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QhlgprOy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F120E3;
	Mon, 12 Feb 2024 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707713311; cv=none; b=C9W4sgAMdsNsBG32TDisgNekqQUNF3IsrqByzNkOQgrLgUOlGvEbFWbtzQuLH4T0+nJwdGp1wSgJyqwCegf52sXL+cm8jWLp5ERg5fyTqEfVz94lqab1+EIedLJJJ2QDFjf/IBn5m4s5w/V3o8gRyu5pZM8GklJCf66emVAhfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707713311; c=relaxed/simple;
	bh=2j4VpkWC4R5pcQNZydHEGsOnLT4Cg7pbEmYh0ErBB0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=scl1bUgb/QQ/p/ypLn7jedjy2H3/Wp6/RjwJD7kkE84E0YPyoqlgZq9obBpMVK4Ms+oCYIIesBABe5mL9UEmEKd75EZ6JCxIYveAJFCTviVDhw0wT5ZqM/z/I7wvPxn6+Q2FkofyW7gTBdKOUbUupNR2TFIYPNDNgnKshOSc1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QhlgprOy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C4mJRa017764;
	Mon, 12 Feb 2024 04:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=/cl
	5/cJVjA1AuLY1yXo9p8OLXxbg1hPEuGeYZ+5oyJY=; b=QhlgprOyLYjfnsH8axz
	i6zK42MFJ8oCsozYvlj73cdOYilF59kVRSJ1UbSd4Fesnas+/oHNtF6ZYmHjtOhH
	MfFXM1aNkvoaWAgkoYNLJuC5P9ky5JJK+16f5c0K/Ja7JJmo+PJij38743BHtUMM
	Qg+q/JwWWAtNCyo+TLONtZ5Ybgq6UQwYkp8BU+4hr19lt8F5D1oTnCrzWCsmX2K1
	j0AExSVWqOG5ujVGmzy9oe4Y+Ye8mY8C0QZiwU2i8hQsUBlahBjUc8CBW6+zZk2b
	J6aQ/pCzUWg5OStvLYHeCuCGrTqUvGCLdNt3DiKWgYX/IhtGDHlCwTJ+aZkuTsQJ
	dvQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62jttg5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 04:48:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C4mIl3017525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 04:48:18 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 11 Feb 2024 20:48:15 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Mon, 12 Feb 2024 10:18:08 +0530
Subject: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAejyWUC/12MywrCMBAAf6Xs2ZW8aKkn/0M8pHFj9tCkbrQIp
 f9u8CJ4HIaZDSoJU4VTt4HQypVLbmAPHYTk852Qb43BKOOU0QplmRNKDRj5TRXtYPww+sn2boI
 WLUJf0ZrLtXGUMuMzCfnfRuvxf7Ma1EjOBOVHsn1U58eLA+dwDGWGff8AM2ZjUKgAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_eberman@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_lsrao@quicinc.com>, <stable@vger.kernel.org>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707713295; l=6336;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=2j4VpkWC4R5pcQNZydHEGsOnLT4Cg7pbEmYh0ErBB0E=;
 b=S0gnTRSi9710XLXydakUisJsuwaBXSPFC3s6BXaj31II7kAivvdVvqZwyvomOvTTJSrd4yeHF
 eoxrSFweU0bBET4uzHGIsKcKp46iscFqwkLJE0dw6/tCRfPiFHkHCCm
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XIXesB56Vx-JkBQfwc0OPBtsj4rTKljJ
X-Proofpoint-ORIG-GUID: XIXesB56Vx-JkBQfwc0OPBtsj4rTKljJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_02,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120034

Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
addresses associated with it. These control voltage, enable state, mode,
and in legacy targets, voltage headroom. The current in-flight request
checking logic looks for exact address matches. Requests for different
addresses of the same RPMh resource as thus not detected as in-flight.

Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
request check for VRM requests by ignoring the address offset.

This ensures that only one request is allowed to be in-flight for a given
VRM resource. This is needed to avoid scenarios where request commands are
carried out by RPMh hardware out-of-order leading to LDO regulator
over-current protection triggering.

Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
Changes in v3:
- Fix s-o-b chain
- Add cmd-db API to compare addresses
- Reuse already defined resource types in cmd-db
- Add Fixes tag and Cc to stable
- Retain Reviewed-by tag of v2
- Link to v2: https://lore.kernel.org/r/20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com
Changes in v2:
- Use GENMASK() and FIELD_GET()
- Link to v1: https://lore.kernel.org/r/20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com
---
 drivers/soc/qcom/cmd-db.c   | 41 +++++++++++++++++++++++++++++++++++------
 drivers/soc/qcom/rpmh-rsc.c |  3 ++-
 include/soc/qcom/cmd-db.h   | 10 +++++++++-
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed..e87682b9755e 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -15,8 +19,8 @@
 
 #define NUM_PRIORITY		2
 #define MAX_SLV_ID		8
-#define SLAVE_ID_MASK		0x7
-#define SLAVE_ID_SHIFT		16
+#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
+#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
 
 /**
  * struct entry_header: header for each entry in cmddb
@@ -221,9 +225,34 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
 EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
 
 /**
- * cmd_db_read_slave_id - Get the slave ID for a given resource address
+ * cmd_db_match_resource_addr - Compare if both Resource addresses are same
+ *
+ * @addr1: Resource address to compare
+ * @addr2: Resource address to compare
+ *
+ * Return: true on matching addresses, false otherwise
+ */
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{
+	/*
+	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
+	 * aligned addresses associated with it. Ignore the offset to check
+	 * for VRM requests.
+	 */
+	if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
+	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
+		return true;
+	else if (addr1 == addr2)
+		return true;
+	else
+		return false;
+}
+EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
+
+/**
+ * cmd_db_read_slave_id - Get the slave ID for a given resource name
  *
- * @id: Resource id to query the DB for version
+ * @id: Resource id to query the DB for slave id
  *
  * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
  */
@@ -238,7 +267,7 @@ enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 		return CMD_DB_HW_INVALID;
 
 	addr = le32_to_cpu(ent->addr);
-	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
+	return SLAVE_ID(addr);
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_slave_id);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a021dc71807b..daf64be966fe 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
@@ -557,7 +558,7 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
 			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
-				if (addr == msg->cmds[k].addr)
+				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
 					return -EBUSY;
 			}
 		}
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index c8bb56e6852a..47a6cab75e63 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
 #ifndef __QCOM_COMMAND_DB_H__
 #define __QCOM_COMMAND_DB_H__
@@ -21,6 +24,8 @@ u32 cmd_db_read_addr(const char *resource_id);
 
 const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
+
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
 
 int cmd_db_ready(void);
@@ -31,6 +36,9 @@ static inline u32 cmd_db_read_addr(const char *resource_id)
 static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
 { return ERR_PTR(-ENODEV); }
 
+static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{ return false; }
+
 static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
 { return -ENODEV; }
 

---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240210-rpmh-rsc-fixes-372a79ab364b

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


