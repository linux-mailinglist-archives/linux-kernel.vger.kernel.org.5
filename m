Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731D7B30EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjI2K5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjI2K5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08DA11F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iit/uK9buPbik49+yDd3TQw7r52rOIXJ/TgdJwIz1xspWlOa4Sh3/WsYAY8275RhOdmKqH7S2Dy5mj0DNEnV7Uv6TfQhhAtQ7DwqybCytyZcZnThLpOsV1v4d8bMeq9tKEVD1oH91e75vsD1oHy+pD1bAcdafrtxeRwWLWp/U+Z26Qu8EbfWKRANhlx7uk+BkQhJ0qnAJyTZgNPFL3PKTl4T4erClr5fWQBtrs7t6fuBFzLAjLZFXFIAotq5MimpckqpxZzf1YPiXIDUxYsY4ahmGLr+JLgSXK8plq6TWVRShOI7ZlojOq65q0GbkMiI8aagBreyFCvssQzybtRAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tX5QeB+353m4BxwSDtL8A+3R0kRLkKdWIHNFYTmrHQ=;
 b=f2tnKxA3m1tkYsd/koIM047vIvOVU1Xivp3EnwQCdiajTbb8SliXkK5quwfy450VA8E96Bcr+vge0tSu/3S0seA3Kg+SJkZvnd/37fDA9nAzNPEeflpYFeyUsw9gxmzsatQp7p5zy63GnJ/8s1y5yIV378P4codPapuz9WdftdB5peiKwrfITADDZ66T+h15nHbvlSt1+iix9SE1jtW7ukjK/4zDo0sqHv+VCyX7dpMwz/StpY/EkNGfjCY/AmoaxPZDJQKXWHopF4zLaMFyEUW3jg3AL1ly3e4eZ2qPcTQwvUCs2fBxQNKCUY0QIymLfRetvyqU35pLckfLRb6gNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tX5QeB+353m4BxwSDtL8A+3R0kRLkKdWIHNFYTmrHQ=;
 b=ePzcezNs9u/1tEBP2D14QK1I13g9oESFF9MDrqIvWnD2/75OkxveWhtNqRJr/NiNqoxFzM/EOSX/p34Nlfa7bqKO5EaER1D5Qc0Zck+XJPR0mqc+fje1UyWNr8qYmW9Pv3Yruoeet0UNicpi3lXAlygp2+HQqSJYEopx3nNg2fw=
Received: from PH8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:2cd::26)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.31; Fri, 29 Sep
 2023 10:57:26 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::cc) by PH8PR07CA0001.outlook.office365.com
 (2603:10b6:510:2cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:23 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:22 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 1/7] firmware: xilinx: Update firmware call interface to support additional arg
Date:   Fri, 29 Sep 2023 03:55:52 -0700
Message-ID: <20230929105558.11893-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a2de94-6d12-44b0-ca2a-08dbc0dade0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ARyGXbSplwY20ZDVEJHXoNjcgthV0ELZlbwYyPmvfg5WFraYiMhX9/vJJg7p9qT3qsHq3wjqSuj5/VdWLyxsOVCWuLUkHxA1NOyWIE9puqE/b3gh/+3qwuv2CPggpBfbTRNM+UT2HueXD4oDsIWz+d8hybYlJRW0DfNDjFxmBLhX9bh1anNav+ttWN9r6gj1PNdnRfm4HwkFq73KopR4Ep4340YrDE5O2Brp5+Gi3LpQO/4iPGA06Z9Ff3Baidcae12YyEl7W3CgAqzgfs1b33pXm67eMWx3/Xzg6mKuQd5WAQ0ipzNX/q+DPhHT66KNy2lA2AOsxeay6l1ObNBhxnjY7H1BvDCdhO+YJogOsbKFBrhrpOWOQrVS92qB7ufv2hnbeaxEDuqCIGSLlYsiPZFtYLlkV5x74JQziS+Lq8nXKJYvSQSuPZMQfwii17Jg02R6u6p8C2/QIFMuiS6S2mnutZZakGJb8lC5F6mxja0wdxmLTcA5il/1MgflHC8CCWIntaaeCYNpgCSXD3fUc4Mqg8BKHcZJtLLaH/No8qv9w1DM81I4ffb0HK3eeEPXfEi2PFvNJdXlovSj49ai9Mo5V68A4nHiFHtcy2MQSKZN8BGh6m1Frcyngp1y5COMz55U5tNlqjE8Y5znPkHnPE6QZaP05+9L0Mmhdh9XE+aQaqM8zyabN+SknG5XbOnKLb0bTuICgui2tuQW+9xxXDxKk+2kcAXJANE+fg+JtvyGf3UDnuno3bmDmwcsZmS+TPw+YuwzFnJqAvAcWLSq4Rfq1zqXyzw4r6EehxEOmA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(44832011)(2906002)(15650500001)(30864003)(4326008)(5660300002)(41300700001)(8676002)(8936002)(70206006)(54906003)(316002)(70586007)(1076003)(26005)(110136005)(336012)(40460700003)(478600001)(2616005)(36756003)(36860700001)(6666004)(83380400001)(426003)(921005)(40480700001)(356005)(47076005)(81166007)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:26.3346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a2de94-6d12-44b0-ca2a-08dbc0dade0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System-level platform management layer (do_fw_call()) has support for
maximum of 5 arguments as of now (1 EEMI API ID + 4 command arguments).
In order to support new EEMI PM_IOCTL IDs (Secure Read/Write), this
support must be extended to support one additional argument, which
results in a configuration of - 1 EEMI API ID + 5 command arguments.

Update zynqmp_pm_invoke_fn() and do_fw_call() with this new definition
containing additional argument. As a result, update all the references
to pm invoke function with the updated definition.

Co-developed-by: Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Signed-off-by: Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 155 +++++++++++++-----------
 drivers/soc/xilinx/xlnx_event_manager.c |   2 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |   2 +-
 4 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4cc1ac7f76ed..d102619fd6f4 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -106,7 +106,7 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	}
 }
 
-static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2, u64 arg3,
 				    u32 *ret_payload)
 {
 	return -ENODEV;
@@ -116,25 +116,26 @@ static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
  * PM function call wrapper
  * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
  */
-static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+static int (*do_fw_call)(u64, u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
 
 /**
  * do_fw_call_smc() - Call system-level platform management layer (SMC)
  * @arg0:		Argument 0 to SMC call
  * @arg1:		Argument 1 to SMC call
  * @arg2:		Argument 2 to SMC call
+ * @arg3:		Argument 3 to SMC call
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function via SMC call (no hypervisor present).
  *
  * Return: Returns status, either success or error+reason
  */
-static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2, u64 arg3,
 				   u32 *ret_payload)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	arm_smccc_smc(arg0, arg1, arg2, arg3, 0, 0, 0, 0, &res);
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -151,6 +152,7 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
  * @arg0:		Argument 0 to HVC call
  * @arg1:		Argument 1 to HVC call
  * @arg2:		Argument 2 to HVC call
+ * @arg3:		Argument 3 to HVC call
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function via HVC
@@ -159,12 +161,12 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
  *
  * Return: Returns status, either success or error+reason
  */
-static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2, u64 arg3,
 				   u32 *ret_payload)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	arm_smccc_hvc(arg0, arg1, arg2, arg3, 0, 0, 0, 0, &res);
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -184,7 +186,7 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
 	smc_arg[1] = api_id;
 
-	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
+	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, 0, ret_payload);
 	if (ret)
 		ret = -EOPNOTSUPP;
 	else
@@ -299,6 +301,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
  * @arg1:		Argument 1 to requested PM-API call
  * @arg2:		Argument 2 to requested PM-API call
  * @arg3:		Argument 3 to requested PM-API call
+ * @arg4:		Argument 4 to requested PM-API call
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function for SMC or HVC call, depending on
@@ -317,7 +320,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
  * Return: Returns status, either success or error+reason
  */
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-			u32 arg2, u32 arg3, u32 *ret_payload)
+			u32 arg2, u32 arg3, u32 arg4,
+			u32 *ret_payload)
 {
 	/*
 	 * Added SIP service call Function Identifier
@@ -334,8 +338,10 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 	smc_arg[0] = PM_SIP_SVC | pm_api_id;
 	smc_arg[1] = ((u64)arg1 << 32) | arg0;
 	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+	smc_arg[3] = ((u64)arg4);
 
-	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
+			  ret_payload);
 }
 
 static u32 pm_api_version;
@@ -348,13 +354,13 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
-				  NULL);
+				  0, NULL);
 	if (!ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
-				   reset, NULL);
+				   reset, 0, NULL);
 }
 
 /**
@@ -376,7 +382,7 @@ int zynqmp_pm_get_api_version(u32 *version)
 		*version = pm_api_version;
 		return 0;
 	}
-	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, 0, ret_payload);
 	*version = ret_payload[1];
 
 	return ret;
@@ -399,7 +405,7 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	if (!idcode || !version)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, 0, ret_payload);
 	*idcode = ret_payload[1];
 	*version = ret_payload[2];
 
@@ -427,7 +433,7 @@ static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 		return 0;
 	}
 
-	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, 0, ret_payload);
 	if (ret < 0)
 		return ret;
 
@@ -460,7 +466,7 @@ static int zynqmp_pm_get_trustzone_version(u32 *version)
 		return 0;
 	}
 	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*version = ret_payload[1];
 
 	return ret;
@@ -508,7 +514,7 @@ int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				  qdata.arg2, qdata.arg3, out);
+				  qdata.arg2, qdata.arg3, 0, out);
 
 	/*
 	 * For clock name query, all bytes in SMC response are clock name
@@ -530,7 +536,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_query_data);
  */
 int zynqmp_pm_clock_enable(u32 clock_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, 0,
+				   NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
 
@@ -545,7 +552,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
  */
 int zynqmp_pm_clock_disable(u32 clock_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, 0,
+				   NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
 
@@ -565,7 +573,7 @@ int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*state = ret_payload[1];
 
 	return ret;
@@ -585,7 +593,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getstate);
 int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
 {
 	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
-				   0, 0, NULL);
+				   0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setdivider);
 
@@ -605,7 +613,7 @@ int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*divider = ret_payload[1];
 
 	return ret;
@@ -626,7 +634,7 @@ int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
 	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
 				   lower_32_bits(rate),
 				   upper_32_bits(rate),
-				   0, NULL);
+				   0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setrate);
 
@@ -646,7 +654,7 @@ int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
 
 	return ret;
@@ -665,7 +673,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getrate);
 int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
 {
 	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
-				   parent_id, 0, 0, NULL);
+				   parent_id, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setparent);
 
@@ -685,7 +693,7 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*parent_id = ret_payload[1];
 
 	return ret;
@@ -705,7 +713,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
 int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
-				   clk_id, mode, NULL);
+				   clk_id, mode, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
 
@@ -722,7 +730,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
 int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
-				   clk_id, 0, mode);
+				   clk_id, 0, 0, mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
 
@@ -740,7 +748,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
 int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
-				   clk_id, data, NULL);
+				   clk_id, data, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
 
@@ -757,7 +765,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
 int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
-				   clk_id, 0, data);
+				   clk_id, 0, 0, data);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
 
@@ -780,7 +788,7 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 	if (value) {
 		return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
 					   IOCTL_SET_SD_TAPDELAY,
-					   type, value, NULL);
+					   type, value, 0, NULL);
 	}
 
 	/*
@@ -798,7 +806,7 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 	 * Use PM_MMIO_READ/PM_MMIO_WRITE to re-implement the missing counter
 	 * part of IOCTL_SET_SD_TAPDELAY which clears SDx_ITAPDLYENA bits.
 	 */
-	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, reg, mask, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, reg, mask, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
 
@@ -815,7 +823,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET,
-				   type, 0, NULL);
+				   type, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 
@@ -832,7 +840,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
-				   select, 0, NULL);
+				   select, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
 
@@ -848,7 +856,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
 int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
-				   index, value, NULL);
+				   index, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
 
@@ -864,7 +872,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
 int zynqmp_pm_read_ggs(u32 index, u32 *value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
-				   index, 0, value);
+				   index, 0, 0, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
 
@@ -881,7 +889,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
 int zynqmp_pm_write_pggs(u32 index, u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value,
-				   NULL);
+				   0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
 
@@ -898,14 +906,14 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
 int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
-				   value);
+				   0, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
 int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS,
-				   index, value, NULL);
+				   index, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
 
@@ -921,7 +929,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
 int zynqmp_pm_set_boot_health_status(u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
-				   value, 0, NULL);
+				   value, 0, 0, NULL);
 }
 
 /**
@@ -936,7 +944,7 @@ int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag)
 {
 	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
-				   0, 0, NULL);
+				   0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
 
@@ -956,7 +964,7 @@ int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
 		return -EINVAL;
 
 	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*status = ret_payload[1];
 
 	return ret;
@@ -982,7 +990,7 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
-				  upper_32_bits(address), size, flags,
+				  upper_32_bits(address), size, flags, 0,
 				  ret_payload);
 	if (ret_payload[0])
 		return -ret_payload[0];
@@ -1008,7 +1016,8 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 	if (!value)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, 0,
+				  ret_payload);
 	*value = ret_payload[1];
 
 	return ret;
@@ -1039,7 +1048,7 @@ int zynqmp_pm_fpga_get_config_status(u32 *value)
 	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
 				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
 				  lower_addr, upper_addr,
-				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
+				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG, 0,
 				  ret_payload);
 
 	*value = ret_payload[1];
@@ -1058,7 +1067,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
  */
 int zynqmp_pm_pinctrl_request(const u32 pin)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
 
@@ -1072,7 +1081,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
  */
 int zynqmp_pm_pinctrl_release(const u32 pin)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_release);
 
@@ -1094,7 +1103,7 @@ int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
 		return -EINVAL;
 
 	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, pin, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*id = ret_payload[1];
 
 	return ret;
@@ -1113,7 +1122,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_function);
 int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
 {
 	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, pin, id,
-				   0, 0, NULL);
+				   0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_function);
 
@@ -1137,7 +1146,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 		return -EINVAL;
 
 	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, pin, param,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*value = ret_payload[1];
 
 	return ret;
@@ -1167,7 +1176,7 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 	}
 
 	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
-				   param, value, 0, NULL);
+				   param, value, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_config);
 
@@ -1186,7 +1195,7 @@ unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, CRL_APB_BOOT_PIN_CTRL, 0,
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 
 	*ps_mode = ret_payload[1];
 
@@ -1206,7 +1215,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_read);
 int zynqmp_pm_bootmode_write(u32 ps_mode)
 {
 	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, CRL_APB_BOOT_PIN_CTRL,
-				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode, 0, NULL);
+				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode, 0,
+				   0,  NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
 
@@ -1221,7 +1231,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
  */
 int zynqmp_pm_init_finalize(void)
 {
-	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
 
@@ -1235,7 +1245,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
  */
 int zynqmp_pm_set_suspend_mode(u32 mode)
 {
-	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
 
@@ -1255,7 +1265,7 @@ int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 			   const u32 qos, const enum zynqmp_pm_request_ack ack)
 {
 	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
-				   qos, ack, NULL);
+				   qos, ack, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
 
@@ -1271,7 +1281,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
  */
 int zynqmp_pm_release_node(const u32 node)
 {
-	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
@@ -1291,7 +1301,8 @@ int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
+				  IOCTL_GET_RPU_OPER_MODE, 0, 0, 0,
+				  ret_payload);
 
 	/* only set rpu_mode if no error */
 	if (ret == XST_PM_SUCCESS)
@@ -1315,7 +1326,7 @@ int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
 				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
-				   0, NULL);
+				   0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
 
@@ -1333,7 +1344,7 @@ int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
 				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
-				   NULL);
+				   0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
 
@@ -1348,7 +1359,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
 int zynqmp_pm_force_pwrdwn(const u32 node,
 			   const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, 0,
+				   NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
 
@@ -1368,7 +1380,7 @@ int zynqmp_pm_request_wake(const u32 node,
 {
 	/* set_addr flag is encoded into 1st bit of address */
 	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
-				   address >> 32, ack, NULL);
+				   address >> 32, ack, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
 
@@ -1389,7 +1401,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const enum zynqmp_pm_request_ack ack)
 {
 	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
-				   qos, ack, NULL);
+				   qos, ack, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
@@ -1406,7 +1418,8 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address)
 {
 	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
 				   lower_32_bits(address),
-				   upper_32_bits(address), 0, NULL);
+				   upper_32_bits(address), 0,
+				   0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
 
@@ -1428,7 +1441,7 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 
 	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, upper_32_bits(address),
 				  lower_32_bits(address),
-				  0, 0, ret_payload);
+				  0, 0, 0, ret_payload);
 	*out = ret_payload[1];
 
 	return ret;
@@ -1457,7 +1470,7 @@ int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
 	u32 upper_addr = upper_32_bits(address);
 
 	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
-				   size, flags, NULL);
+				   size, flags, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
 
@@ -1480,7 +1493,7 @@ int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable)
 {
 	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
-				   wake, enable, NULL);
+				   wake, enable, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
 
@@ -1494,7 +1507,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
 	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
-				   0, 0, NULL);
+				   0, 0, 0, NULL);
 }
 
 /**
@@ -1507,7 +1520,7 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
-				   id, value, NULL);
+				   id, value, 0, NULL);
 }
 
 /**
@@ -1521,7 +1534,7 @@ int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 				 u32 *payload)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
-				   id, 0, payload);
+				   id, 0, 0, payload);
 }
 
 /**
@@ -1535,7 +1548,7 @@ int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_SD_CONFIG,
-				   config, value, NULL);
+				   config, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
 
@@ -1551,7 +1564,7 @@ int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value)
 {
 	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG,
-				   config, value, NULL);
+				   config, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_gem_config);
 
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 86a048a10a13..38cfc161a713 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -483,7 +483,7 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 
 static void xlnx_get_event_callback_data(u32 *buf)
 {
-	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, 0, buf);
 }
 
 static irqreturn_t xlnx_event_handler(int irq, void *dev_id)
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index c2c819701eec..52a868a09106 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -51,7 +51,7 @@ static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
 
 static void zynqmp_pm_get_callback_data(u32 *buf)
 {
-	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, 0, buf);
 }
 
 static void suspend_event_callback(const u32 *payload, void *data)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e8b12ec8b060..9e2d8e02d9e6 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -498,7 +498,7 @@ struct zynqmp_pm_query_data {
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-			u32 arg2, u32 arg3, u32 *ret_payload);
+			u32 arg2, u32 arg3, u32 arg4, u32 *ret_payload);
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
-- 
2.17.1

