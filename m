Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A047CA65C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJPLNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjJPLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:13:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A383
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyXRdC99XknicOhGilUFB3goauQgifql6bfPx3T0ogbJGWQC5OYcsvkBY0jIZprlxZ+ceMBR+X7AcD+ItPU3ypHf+G9EiLBRy3QIT6FxbRTpYfS5OXwggnQtGIpnrpRsMeKoaBljVhMd/VZEkmzM2GhBbkWr5lXZUf2NDwsEqr+ndxAZGan+fvoPPRpow82x93ErtdvIGTDQFwx2d4iqSOvODp1hS0eFVox7iXPtxb4ALrMz9IQsILaithwwG8NXHn5YxCO4wHN8ZMsIXpyZqSA/IrKdVVtAw+adwJv0YUNirRQ0XHGLFua3N07IGQwvwp9Qu3pn1xEYGrzyVndQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3VnqeEYDcFCm7NWLa6MTra1tc/EbEowVY0FMuyQ7Ro=;
 b=jK+vLUZe/QZG4FWEe02uxZdILl4prf2aCGTIHbPGIkqQ6a2e6+RgwYXpnhciD7jxsROkEsAgzHfWO0qsrFzG/oxS1nECo3kh8smWA+dDcqKcUdTTXH+tq3tWeGQHjRaWF107DWuiYiwr+/wSik3PnexGLFgpbrikXsrrQBAssg/QINKJTvokBJwy6mgb32UwnMGwvPXvWcYEopB7Mo3HTdaF5PaTdaTxMhBot9zlrQwAPHSFer1nV6unsT0AoHhRXnEAVb7927YOBgtxMuWOIlMuBcQtS89PbyTT00auKAp/y4BVL5S71cYzLkXGpqROcSgbpO8Uc2jcxKQKLIt/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3VnqeEYDcFCm7NWLa6MTra1tc/EbEowVY0FMuyQ7Ro=;
 b=uhXsdX/19QEjx9bMCEZw6qrEwjU7KwYGzoU9A0UdOM36JgNdgA9BfCtRDrExrhk2zBRu9bilNfhx68KsyC02sJ8sByewzLRYp7aMTBpyalgdPRM23OYAt921o/PqhBCcfAahr6+dOIy1qQ2pdq72dUOe0ZR0g2BbdmVXQTK4370=
Received: from PH8PR20CA0013.namprd20.prod.outlook.com (2603:10b6:510:23c::27)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 11:13:32 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::37) by PH8PR20CA0013.outlook.office365.com
 (2603:10b6:510:23c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47 via Frontend
 Transport; Mon, 16 Oct 2023 11:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:13:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:30 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:13:29 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <nava.kishore.manne@amd.com>,
        <marex@denx.de>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <sai.krishna.potthuri@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Subject: [PATCH v3 1/5] firmware: xilinx: Update firmware call interface to support additional arg
Date:   Mon, 16 Oct 2023 04:12:57 -0700
Message-ID: <20231016111301.13369-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
References: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: ee47c35e-6b4d-4acc-0b40-08dbce38ee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYVmk2whIBxpfQOxJLlyh513RVF6fzPzEoY+mwTreEg85d3H9wX/OWlwtW5g0VVnllX3un2WW6W3zsqnM+Cxff1aYF8GijmJLt6pdkp4prz6yn85xRTUgxWHvcvdAphcBfolRBbnX/s/dUYs9lP35CA3Ey0FT9Ad85H7XNUq126jUV4DETXWYzO/XC6jjxxsLye0NAdKYJs70gPLZL0bRnZmclJzb0XJXDzdCuLE9fbLb6gTHiCVlfCA7HxSxN/7odDl8G0zEN2bXJIDIKtBiHlpiIiyWSg7+UPDnJ48XKHDZaPtyHTHMs9h/QNkKhTAlEuFcTL9BpzZCHQFK7TgHJrmE6sm4DS8fJ93NHwTcGdBejVLQCEiMSbF4PwFF5ZaTRnyQQ3Z/cAFmFeq20iVOc0YZxSPhXVy1GkckCoS4e6scZfzzKGXNf39CubpYMLn8ZrXHs0AGKQmMoD1/Be3jSop13rmQOxqb0VWfALPNv3wZ9AMAx26J8l5icbnIJgKVscSYLMVslK184T976EoKVI/oP0jfgfJvFu/eRkEBmLZA7+KkVqaX4KHmr588cBFLBFgX/q8x8s228LVfS/Cm/xMVjzHpRC94KzAE5428aBkEVYmW8+ql2f7P6+70ssRP4JO3ZtLxTOuwEldLUy0Bsot1wc2MjXNfzcQ8If56eW7LtNyjUKcMxYIQ89YS4gU2KKtkYQtn0wSI38kY022YqWlWS8L3nHrwr3Z5Ndk7AdAYuVeib1BqhE790ALXBtI45dZ3FILLdx7I4r5MuSQD0gQiPW+dmqGv3pEvBDVqzo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(81166007)(1076003)(921005)(356005)(26005)(2616005)(82740400003)(110136005)(47076005)(70586007)(6636002)(316002)(54906003)(70206006)(336012)(426003)(83380400001)(6666004)(478600001)(36860700001)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(40460700003)(44832011)(40480700001)(36756003)(30864003)(86362001)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:13:31.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee47c35e-6b4d-4acc-0b40-08dbce38ee8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/firmware/xilinx/zynqmp.c        | 217 ++++++++++--------------
 drivers/soc/xilinx/xlnx_event_manager.c |   2 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |   4 +-
 4 files changed, 89 insertions(+), 136 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4cc1ac7f76ed..d535ff46c847 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -106,8 +106,7 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	}
 }
 
-static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
-				    u32 *ret_payload)
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2, u64 arg3, u32 *ret_payload)
 {
 	return -ENODEV;
 }
@@ -116,25 +115,25 @@ static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
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
-				   u32 *ret_payload)
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2, u64 arg3, u32 *ret_payload)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	arm_smccc_smc(arg0, arg1, arg2, arg3, 0, 0, 0, 0, &res);
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -151,6 +150,7 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
  * @arg0:		Argument 0 to HVC call
  * @arg1:		Argument 1 to HVC call
  * @arg2:		Argument 2 to HVC call
+ * @arg3:		Argument 3 to HVC call
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function via HVC
@@ -159,12 +159,11 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
  *
  * Return: Returns status, either success or error+reason
  */
-static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
-				   u32 *ret_payload)
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2, u64 arg3, u32 *ret_payload)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	arm_smccc_hvc(arg0, arg1, arg2, arg3, 0, 0, 0, 0, &res);
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -184,7 +183,7 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
 	smc_arg[1] = api_id;
 
-	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
+	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, 0, ret_payload);
 	if (ret)
 		ret = -EOPNOTSUPP;
 	else
@@ -299,6 +298,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
  * @arg1:		Argument 1 to requested PM-API call
  * @arg2:		Argument 2 to requested PM-API call
  * @arg3:		Argument 3 to requested PM-API call
+ * @arg4:		Argument 4 to requested PM-API call
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function for SMC or HVC call, depending on
@@ -316,8 +316,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
  *
  * Return: Returns status, either success or error+reason
  */
-int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-			u32 arg2, u32 arg3, u32 *ret_payload)
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4,
+			u32 *ret_payload)
 {
 	/*
 	 * Added SIP service call Function Identifier
@@ -334,8 +334,9 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 	smc_arg[0] = PM_SIP_SVC | pm_api_id;
 	smc_arg[1] = ((u64)arg1 << 32) | arg0;
 	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+	smc_arg[3] = ((u64)arg4);
 
-	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3], ret_payload);
 }
 
 static u32 pm_api_version;
@@ -347,14 +348,12 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
-				  NULL);
+	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0, 0, NULL);
 	if (!ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
-				   reset, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num, reset, 0, NULL);
 }
 
 /**
@@ -376,7 +375,7 @@ int zynqmp_pm_get_api_version(u32 *version)
 		*version = pm_api_version;
 		return 0;
 	}
-	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, 0, ret_payload);
 	*version = ret_payload[1];
 
 	return ret;
@@ -399,7 +398,7 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	if (!idcode || !version)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, 0, ret_payload);
 	*idcode = ret_payload[1];
 	*version = ret_payload[2];
 
@@ -427,7 +426,7 @@ static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 		return 0;
 	}
 
-	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, 0, ret_payload);
 	if (ret < 0)
 		return ret;
 
@@ -459,8 +458,7 @@ static int zynqmp_pm_get_trustzone_version(u32 *version)
 		*version = pm_tz_version;
 		return 0;
 	}
-	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0, 0, 0, 0, ret_payload);
 	*version = ret_payload[1];
 
 	return ret;
@@ -507,8 +505,8 @@ int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				  qdata.arg2, qdata.arg3, out);
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1, qdata.arg2, qdata.arg3, 0,
+				  out);
 
 	/*
 	 * For clock name query, all bytes in SMC response are clock name
@@ -530,7 +528,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_query_data);
  */
 int zynqmp_pm_clock_enable(u32 clock_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
 
@@ -545,7 +543,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
  */
 int zynqmp_pm_clock_disable(u32 clock_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
 
@@ -564,8 +562,7 @@ int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0, 0, 0, 0, ret_payload);
 	*state = ret_payload[1];
 
 	return ret;
@@ -584,8 +581,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getstate);
  */
 int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setdivider);
 
@@ -604,8 +600,7 @@ int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0, 0, 0, 0, ret_payload);
 	*divider = ret_payload[1];
 
 	return ret;
@@ -623,10 +618,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getdivider);
  */
 int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
-				   lower_32_bits(rate),
-				   upper_32_bits(rate),
-				   0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id, lower_32_bits(rate),
+				   upper_32_bits(rate), 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setrate);
 
@@ -645,8 +638,7 @@ int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0, 0, 0, 0, ret_payload);
 	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
 
 	return ret;
@@ -664,8 +656,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getrate);
  */
 int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
-				   parent_id, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id, parent_id, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setparent);
 
@@ -684,8 +675,7 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0, 0, 0, 0, ret_payload);
 	*parent_id = ret_payload[1];
 
 	return ret;
@@ -704,8 +694,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
  */
 int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
-				   clk_id, mode, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
 
@@ -721,8 +710,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
  */
 int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
-				   clk_id, 0, mode);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0, 0, mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
 
@@ -739,8 +727,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
  */
 int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
-				   clk_id, data, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
 
@@ -756,8 +743,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
  */
 int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
-				   clk_id, 0, data);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0, 0, data);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
 
@@ -778,9 +764,8 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 	u32 mask = (node_id == NODE_SD_0) ? GENMASK(15, 0) : GENMASK(31, 16);
 
 	if (value) {
-		return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-					   IOCTL_SET_SD_TAPDELAY,
-					   type, value, NULL);
+		return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY, type, value, 0,
+					   NULL);
 	}
 
 	/*
@@ -798,7 +783,7 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 	 * Use PM_MMIO_READ/PM_MMIO_WRITE to re-implement the missing counter
 	 * part of IOCTL_SET_SD_TAPDELAY which clears SDx_ITAPDLYENA bits.
 	 */
-	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, reg, mask, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, reg, mask, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
 
@@ -814,8 +799,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
  */
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET,
-				   type, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET, type, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 
@@ -831,8 +815,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
  */
 int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
-				   select, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT, select, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
 
@@ -847,8 +830,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
  */
 int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
-				   index, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS, index, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
 
@@ -863,8 +845,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
  */
 int zynqmp_pm_read_ggs(u32 index, u32 *value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
-				   index, 0, value);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS, index, 0, 0, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
 
@@ -880,8 +861,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
  */
 int zynqmp_pm_write_pggs(u32 index, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value,
-				   NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
 
@@ -897,15 +877,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
  */
 int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
-				   value);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0, 0, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
 int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS,
-				   index, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS, index, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
 
@@ -920,8 +898,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
  */
 int zynqmp_pm_set_boot_health_status(u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
-				   value, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS, value, 0, 0, NULL);
 }
 
 /**
@@ -935,8 +912,7 @@ int zynqmp_pm_set_boot_health_status(u32 value)
 int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag)
 {
-	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
 
@@ -955,8 +931,7 @@ int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
 	if (!status)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0, 0, 0, 0, ret_payload);
 	*status = ret_payload[1];
 
 	return ret;
@@ -981,9 +956,8 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
-				  upper_32_bits(address), size, flags,
-				  ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address), upper_32_bits(address),
+				  size, flags, 0, ret_payload);
 	if (ret_payload[0])
 		return -ret_payload[0];
 
@@ -1008,7 +982,7 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 	if (!value)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, 0, ret_payload);
 	*value = ret_payload[1];
 
 	return ret;
@@ -1037,10 +1011,8 @@ int zynqmp_pm_fpga_get_config_status(u32 *value)
 	upper_addr = upper_32_bits((u64)&buf);
 
 	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
-				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
-				  lower_addr, upper_addr,
-				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
-				  ret_payload);
+				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, lower_addr, upper_addr,
+				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG, 0, ret_payload);
 
 	*value = ret_payload[1];
 
@@ -1058,7 +1030,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
  */
 int zynqmp_pm_pinctrl_request(const u32 pin)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
 
@@ -1072,7 +1044,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
  */
 int zynqmp_pm_pinctrl_release(const u32 pin)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_release);
 
@@ -1093,8 +1065,7 @@ int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
 	if (!id)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, pin, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, pin, 0, 0, 0, 0, ret_payload);
 	*id = ret_payload[1];
 
 	return ret;
@@ -1112,8 +1083,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_function);
  */
 int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, pin, id,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, pin, id, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_function);
 
@@ -1136,8 +1106,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 	if (!value)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, pin, param,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, pin, param, 0, 0, 0, ret_payload);
 	*value = ret_payload[1];
 
 	return ret;
@@ -1166,8 +1135,7 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 			return -EOPNOTSUPP;
 	}
 
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
-				   param, value, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin, param, value, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_config);
 
@@ -1185,8 +1153,7 @@ unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode)
 	unsigned int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
-	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, CRL_APB_BOOT_PIN_CTRL, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, CRL_APB_BOOT_PIN_CTRL, 0, 0, 0, 0, ret_payload);
 
 	*ps_mode = ret_payload[1];
 
@@ -1205,8 +1172,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_read);
  */
 int zynqmp_pm_bootmode_write(u32 ps_mode)
 {
-	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, CRL_APB_BOOT_PIN_CTRL,
-				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, CRL_APB_BOOT_PIN_CTRL, CRL_APB_BOOTPIN_CTRL_MASK,
+				   ps_mode, 0, 0,  NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
 
@@ -1221,7 +1188,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
  */
 int zynqmp_pm_init_finalize(void)
 {
-	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
 
@@ -1235,7 +1202,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
  */
 int zynqmp_pm_set_suspend_mode(u32 mode)
 {
-	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
 
@@ -1254,8 +1221,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
 int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 			   const u32 qos, const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
-				   qos, ack, NULL);
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities, qos, ack, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
 
@@ -1271,7 +1237,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
  */
 int zynqmp_pm_release_node(const u32 node)
 {
-	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
@@ -1290,8 +1256,7 @@ int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_GET_RPU_OPER_MODE, 0, 0, 0, ret_payload);
 
 	/* only set rpu_mode if no error */
 	if (ret == XST_PM_SUCCESS)
@@ -1313,9 +1278,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
  */
 int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
-				   0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode, 0, 0,
+				   NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
 
@@ -1331,8 +1295,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
  */
 int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0, 0,
 				   NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
@@ -1348,7 +1311,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
 int zynqmp_pm_force_pwrdwn(const u32 node,
 			   const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
 
@@ -1367,8 +1330,8 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const enum zynqmp_pm_request_ack ack)
 {
 	/* set_addr flag is encoded into 1st bit of address */
-	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
-				   address >> 32, ack, NULL);
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr, address >> 32, ack,
+				   0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
 
@@ -1388,8 +1351,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
-				   qos, ack, NULL);
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities, qos, ack, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
@@ -1404,9 +1366,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
  */
 int zynqmp_pm_load_pdi(const u32 src, const u64 address)
 {
-	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
-				   lower_32_bits(address),
-				   upper_32_bits(address), 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src, lower_32_bits(address), upper_32_bits(address),
+				   0, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
 
@@ -1426,8 +1387,7 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	if (!out)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, upper_32_bits(address),
-				  lower_32_bits(address),
+	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, upper_32_bits(address), lower_32_bits(address), 0,
 				  0, 0, ret_payload);
 	*out = ret_payload[1];
 
@@ -1456,8 +1416,7 @@ int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
 	u32 lower_addr = lower_32_bits(address);
 	u32 upper_addr = upper_32_bits(address);
 
-	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
-				   size, flags, NULL);
+	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr, size, flags, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
 
@@ -1479,8 +1438,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
 int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable)
 {
-	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
-				   wake, enable, NULL);
+	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event, wake, enable, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
 
@@ -1493,8 +1451,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
  */
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
-	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype, 0, 0, 0, NULL);
 }
 
 /**
@@ -1506,8 +1463,7 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
  */
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
-				   id, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG, id, value, 0, NULL);
 }
 
 /**
@@ -1520,8 +1476,7 @@ int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 				 u32 *payload)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
-				   id, 0, payload);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG, id, 0, 0, payload);
 }
 
 /**
@@ -1534,8 +1489,7 @@ int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
  */
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_SD_CONFIG,
-				   config, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_SD_CONFIG, config, value, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
 
@@ -1550,8 +1504,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG,
-				   config, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG, config, value, 0, NULL);
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
index e8b12ec8b060..2bea1b6bfbd7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -497,8 +497,8 @@ struct zynqmp_pm_query_data {
 	u32 arg3;
 };
 
-int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-			u32 arg2, u32 arg3, u32 *ret_payload);
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
+			u32 arg4, u32 *ret_payload);
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
-- 
2.17.1

