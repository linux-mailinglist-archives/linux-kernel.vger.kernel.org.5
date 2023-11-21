Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCB7F2B98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjKULVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjKULVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:21:12 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D8FA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=himWkMewH7iZR+bfqRdkzigd3YDSwES4qo1GviWnaJazPhxX8HjfldIIR2uqRO9gKxe485i4DDInPdu2H8OVuivwvPbkSVaTtjYgEI0LCbLIhBeQTX6L4LJieaZlmRS6OYRS/ETOTv3aR1sjJARUN/KQji5NeUAKH+RINKQxDh9R/l9xQ7KqyD5L3X0Iueememxa0Aqswz6xwBROSt2/v7t0TdloEbQ+z8gQ3YXHDzeTjaeInOOeyuytV+pmFsVpy290/xmg6Y5c/rH/gTzjztPLCcGT94w/6UIEMuA5km7sIMNb36nK2NuZOcb0qs/Y1slpRlOI4ABNuX7CwBNdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWgk+WQznlYQ6sjjDcqVFuKFOFGpMfwpXQmjIKNfdGY=;
 b=IcmygHCFIe1G3XEz6AmghnALwdY5xfAXCVEpxHo20w/4kRqigyb/Q1Nek2kiRXSpINTJGWZ2vrCrk7CwojECjkGmeiX52p/iGgwy15OXL2wG8ieFWnEb5UF9HiXVhPfrFcOTW073T9TfNPkIG0/keb0Pa8X0bCgKHupCTnjFKfDNiMuIUJiWv93K+F8vBrmsZT6X21GXcpK+5EGiufV6PEAXfeUE/DApXc81ivc/hhmeeM8e18XmR0cHAcbbm8zc0hkCmX3MsudyN7uNrJxjBsvsISB46FwHOa6BIv90/okYAxifn9crX9J+piwUgHHjvFF9h/aXmU49Jmt33bQqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWgk+WQznlYQ6sjjDcqVFuKFOFGpMfwpXQmjIKNfdGY=;
 b=vXnkzADAaFyGAbp5H5rapZQ42BOKupyXRbTTI/3X/riVu8HkYjvN2d8urFPEavCzrWRVjnQ4Llb3ts2ELL7LXCtdp2st0DZJYd+139Lp9df9nVKyVkkhkMo+41ISPmjNFw5IHGWKJmM6XwEt7ZQvZwaF6zHv/e2z1hMa3mM/TnM=
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 11:21:02 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::ff) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Tue, 21 Nov 2023 11:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 11:21:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 05:20:59 -0600
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 05:20:58 -0600
From:   Ronak Jain <ronak.jain@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <ben.levinsky@amd.com>,
        <nava.kishore.manne@amd.com>, <robh@kernel.org>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>,
        <roman.gushchin@linux.dev>, <mathieu.poirier@linaro.org>,
        <shubhrajyoti.datta@amd.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] firmware: xilinx: Add support for GET_LAST_RESET_REASON IOCTL
Date:   Tue, 21 Nov 2023 03:20:55 -0800
Message-ID: <20231121112056.1762641-2-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121112056.1762641-1-ronak.jain@amd.com>
References: <20231121112056.1762641-1-ronak.jain@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 578bdaaf-bad6-411b-4bf3-08dbea83f1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jMqIkwmRUpP9XEmTNv8eIoGDP6o4jv5NTEBSr0DfiHaxOY9/1mduKPDJZ2y++m9S9YyRuMZByXoo7bso87MyLDU6trBUDQgQDzUqg3nCiy6V85gnKRbG4dW8nnVYQquUWoUBDm1Y2IfvGqf0V7vHuZ830eV5pKmsY3UigrcCk86zyyig1HNQJ2exrv9Ldj0he957RZzZKeOPytWLhr+G+5QfB213+NgIwhcRoozzT0UVrkOEQaR8LYOoA3XCUBKzVlglyE88EnS5z6/tBcncEU1GUzmOhv/uqo0qqEVaRXg8HvkTw/pyI/r7NhgpjOkyX9lwMa5q/kIaMXrh0e6w/diohdfpr1IJfzWd4e1yxdjT/kixQYyyLT4uiYrWoB6CHzI82p8csUYigONge8oMFmJazoGu/dai0mlyp1hj0BomhkulP4poUZIePDaQenHMOJYAygRtWaQBT1wJJK8y2nJwMLAjPAu3A+YmiZ5RhRbFJkQ6FsvqQmREmuKFmul1Ku/H6Y+uRyFYOvGPHxB3A+HYEqFF8Riyxur9/CroOuyrarRNTqFFdyVBaO1FhTFSMNV83FqZYyCp68BsOoBdK+67Ff66hWWZN64IGLeHnahxyAhU2GlCoIuTv0xa1BxecDSr55/w526a8vDSgZEt5TqKixuFpeohMS4odQvFmV1me8ds329k4WB5SeXVUi1u1IWG1YmrSWp+RtUch3ie/74Eum8NsK1rsMnm+CmJpzROkSE3hCv7d98eb9VROpJAhrdgsxe7IHtWkdcB4cJ11hwJakg8lNaQ1htXw483fk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(316002)(110136005)(70206006)(70586007)(36756003)(6666004)(336012)(426003)(2616005)(26005)(1076003)(478600001)(921008)(82740400003)(81166007)(356005)(36860700001)(86362001)(47076005)(44832011)(40480700001)(5660300002)(2906002)(8936002)(4326008)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:21:02.2111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 578bdaaf-bad6-411b-4bf3-08dbea83f1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GET_LAST_RESET_REASON IOCTL support to check the last reset
reason.

As per the current code base in the firmware, the firmware clears
all reset reasons, except the latest system reset reason. Also, the
reset reason can not be completely cleared as the ROM need to know if
the last reset was due to the system reset or not.

Hence, the firmware clears all POR and sys resets except the latest
so the next reset reason can be uniquely identified and the same can
be checked by the end user by calling the IOCTL API.

The current supported reset reasons as below.

1. PM_RESET_REASON_EXT_POR - The POR button was pressed outside of
the system
2. PM_RESET_REASON_SW_POR - An internal POR was caused by software
3. PM_RESET_REASON_SLR_POR - One of the other SSIT slices caused a POR
4. PM_RESET_REASON_ERR_POR - An error caused a POR
5. PM_RESET_REASON_DAP_SRST - JTAG TAP initiated system reset
6. PM_RESET_REASON_ERR_SRST - Error initiated system reset
7. PM_RESET_REASON_SW_SRST - Software initiated system reset
8. PM_RESET_REASON_SLR_SRST - One of the other SSIT slices caused a
system reset

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 7 +++++++
 include/linux/firmware/xlnx-zynqmp.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index b0d22d4455d9..5815d1e94407 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -909,6 +909,13 @@ int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
 
+int zynqmp_pm_get_last_reset_reason(u32 *reset_reason)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_LAST_RESET_REASON, 0,
+				   0, reset_reason);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_last_reset_reason);
+
 /**
  * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
  * @value:	Status value to be written
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d1ea3898564c..2d8c5e88391b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -190,6 +190,8 @@ enum pm_ioctl_id {
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
 	IOCTL_OSPI_MUX_SELECT = 21,
+	/* IOCTL to get last reset reason */
+	IOCTL_GET_LAST_RESET_REASON = 23,
 	/* Register SGI to ATF */
 	IOCTL_REGISTER_SGI = 25,
 	/* Runtime feature configuration */
@@ -585,6 +587,7 @@ int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode);
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
+int zynqmp_pm_get_last_reset_reason(u32 *reset_reason);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -909,6 +912,11 @@ static inline int zynqmp_pm_set_gem_config(u32 node,
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_get_last_reset_reason(u32 *reset_reason)
+{
+	return -ENODEV;
+}
+
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

