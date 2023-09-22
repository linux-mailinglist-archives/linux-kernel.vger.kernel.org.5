Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE27AA8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIVGNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:13:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252A102;
        Thu, 21 Sep 2023 23:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie1DHzg49H53E3oPeJ02TjLaOmfQIa8nX+ODUtPlsuqFrnePpCczHsm9MY+8glgXj8U+u2EwgHMhUtpJ7/DmpoIpeMpQJVvCW2WgLF8Kx5PLxEVwP3/QDp29HmnvHNv0xtYODqXo2ySjelLF5PndJPT75bN2q83ixKwvCb9iTnZi4UQnFtNECHBXaI5bEmoXx0tzqwOC98DvsD7M/8qqxlgrhGjtmn03FfUGX9jWrasihQkkSf69GZI9nVYi4NUcZpe839j4eFqCrwlXRE8YBXTWIwzHFD/NJppStRoH0wck4GUvT6C73wRNg1EvCy9t9brYMIGsjMcGYN58fE7WDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0GCw/OOAtDYk02YhrFafWRaCj7uejX6fgV14PS83fo=;
 b=Czzn1I2YC3wvrW+pmF4KA7oO0XJmbqDBafVZXCMbqCWlqKPtPxemOynPJQ/mUCfnuBHBghNne+4wifhpBMKDLm06oT6/bMVA3lPmJj77xQPco0HdNFuofFZkJVj1etpTxTQ1wTJCYmUHcZoQwjfIFf1KTpivd/K4w14nVk/28V7p81EBGS8to8P7/3diS8fBV6OgoaHya5SA5gMdVB4UHFu06RkEAa0uoK3CuoRlZFtKVcopNo9U3Mu9nUy3+sKRv2f6coU/Eww/2fDOGk78bEQAJfG/OKnV0iPLzUO0BQt5tGKuV/L1oaeoMa99fWh3RtPYrkVmbx2LXKWCE9IKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0GCw/OOAtDYk02YhrFafWRaCj7uejX6fgV14PS83fo=;
 b=by2IfPkSFG4l6Vqj5aWg/tCfeZT8jzYYEeSWEHK2+7r6Dw+QZz+biEcvLiFuu34eEFenIfZ2tADfjpU//hsJ3dQ+HzltueGSYymQQZBTx9GfmpY0rVQom0r5X7K3Z1r45YkjUi8CPPlhR1vj7iNjGl3dbM2ZZ3OQhMJC6xSAdL0=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 06:13:19 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::99) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Fri, 22 Sep 2023 06:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Fri, 22 Sep 2023 06:13:19 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:13:15 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perry.yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update
Date:   Fri, 22 Sep 2023 06:12:29 +0000
Message-ID: <20230922061229.475966-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: faeeabca-965e-4cd3-1555-08dbbb33045a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wiMpU/RhwbI34w7v2/pIUKBs9VdVYIepHdrx1D0/RZtwT+nHOLWuTHaqRY4YMEvdWQDHxaQb2hEYqVd81GmJeMfXaeXDKZDB9+J8DYN2jORbC8IHzWq/P9qWLJy3GAnG2daVUZJTOzsHeX7qKjWVDcjlS2ssj6w3aSH6aXLIpjb/AJWrLmckF5W3N+mQ68EtFJbRahZbj4gkWIo8X2xs2ua1FTfN2ZwsTo8AHBrMn4I4cZNV4YPrC99lMI5wYY77JKgd0nuuoSc/R28eRjodjjSVge8iuWMpEOkuzvnamOEi9iqkTJpcI5zTdgV8H4jsEv1khnbq5tWAYuDS9joUcJWeqyEd1XRak2JWMTZHHzUT8+tMYlm+cluiOxFd4OWQBbJf6WE624/ePoRHy+9LlUiJi1qOva8X08Hsi5boJijpby488s1rrgJIDArLNVqyb+Mng8udocCxAS+mF0zQj1V6XT6No/3+knrl0U1M+oMTUzH/9ExJAG3IplIpHLbI21YW4t7LqrRCQ2g1vHWxiuQUmRN9ergFuyvFwbEqXyh8nqFbY2QfLJM6cuieralV/iydgb/ZUgurQVv6O23iFhbnAaOJhr1cCksjuAQ7y0G2Whhl3oT4qNf8DfXzrRqYNnjhDEHK/fXg4Z6jOwWVt/KMk2VT64fFMxU6ZAvxbPHwtsnl1DFYlCj61PLGQ2L0xalUJZPipbEo5OGOrG8o2nH0hNH9gxnYQAn5YFbn4bVuDrEksUfeY/Nb/jjfYUJOtu2l9d6WxKbyt7KUcWQ5WxMCPLjyQbQmBhWcoKbtLA1RBQZMoa7EstKfCBHDVPwpWM2ROKoBZi2X0AfSoK0GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(186009)(230921699003)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(6666004)(478600001)(4326008)(7696005)(40460700003)(81166007)(36860700001)(36756003)(356005)(40480700001)(82740400003)(426003)(1076003)(86362001)(16526019)(26005)(15650500001)(2906002)(2616005)(336012)(54906003)(47076005)(8936002)(110136005)(5660300002)(44832011)(70206006)(8676002)(41300700001)(316002)(70586007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:13:19.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faeeabca-965e-4cd3-1555-08dbbb33045a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When amd_pstate is running, writing to scaling_min_freq and
scaling_max_freq has no effect. These values are only passed to the
policy level, but not to the platform level. This means that the
platform does not know about the frequency limits set by the user. To
fix this, update the min_perf and max_perf values at the platform level
whenever the user changes the scaling_min_freq and scaling_max_freq
values.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 60 ++++++++++++++++++++++++++++--------
 include/linux/amd-pstate.h   |  4 +++
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..4839cdd2715e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,11 +307,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
-
+	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	return 0;
 }
 
@@ -329,11 +329,12 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -432,6 +433,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
@@ -470,6 +475,22 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
+{
+	u32 max_limit_perf, min_limit_perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
+	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
+
+	return 0;
+}
+
 static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 				  unsigned int target_freq, bool fast_switch)
 {
@@ -480,6 +501,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!cpudata->max_freq)
 		return -ENODEV;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
@@ -532,6 +556,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	unsigned int target_freq;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	max_freq = READ_ONCE(cpudata->max_freq);
@@ -745,6 +773,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
+	cpudata->max_limit_freq = max_freq;
+	cpudata->min_limit_freq = min_freq;
 	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
@@ -1183,16 +1213,25 @@ static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_init(unsigned int cpu)
+static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
+	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
 	u64 value;
 	s16 epp;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
@@ -1210,9 +1249,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	if (cpudata->epp_policy == cpudata->policy)
-		goto skip_epp;
-
 	cpudata->epp_policy = cpudata->policy;
 
 	/* Get BIOS pre-defined epp value */
@@ -1222,7 +1258,7 @@ static void amd_pstate_epp_init(unsigned int cpu)
 		 * This return value can only be negative for shared_memory
 		 * systems where EPP register read/write not supported.
 		 */
-		goto skip_epp;
+		return;
 	}
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1236,8 +1272,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	amd_pstate_set_epp(cpudata, epp);
-skip_epp:
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1252,7 +1286,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
-	amd_pstate_epp_init(policy->cpu);
+	amd_pstate_epp_update_limit(policy);
 
 	return 0;
 }
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..6ad02ad9c7b4 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,10 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     min_limit_perf;
+	u32     max_limit_perf;
+	u32     min_limit_freq;
+	u32     max_limit_freq;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

