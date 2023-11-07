Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3B7E36B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjKGIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjKGIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:34:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D89BD;
        Tue,  7 Nov 2023 00:34:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpDyLvgduCyd5eNoLQ0YBrU0Nwye9py/e/4GXMI9jmt6ZihNIpGXTeG3wOGA3ysgS7eb87JndQse276rCJpFN+D9D3KIGwwGUBmUAnxLbRi9FNsqJTp7wlM4cz9i9jCAxefo849Y7oOE9f3yZKM87R/R7psN5RKUnHmvcrkDBQEHO4TcibCdmhFwMNVl9oWjUofqpDsBzOW1COGHw5ie9zBmZqk/Unq2H8Ca5BBfnA/tNbfslGVLiklxvpI9RF0uyhtg0tBt4iO3fBuZLpBKd3hmaoMbEDruBXgkNw6391Ib4Hqc2PZTY4e3kYZazreX642XL8frV/Am84hEIM91/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb4C+yISxWXE5SS/eS2icUbogl1aN0/PbBEKFdJZZUk=;
 b=Yj8CEyOXiLkrg2g5BDC2zw5HGRXWPLsncUuO0XiC7S6MU07Ia4sKSQQc0lR2owRYSesYdBlLpHuHqADXe+m84jDMY5KyTjzotR6tAidEZ/p+rmZnLhatEn8eyBwMS7ahTHyWgnPm9wTsWqw1JClDem6IPDCLFtZFoflLpGEbqb22SBwy5YsTkmPXEQZZ6kELFxOruXkEN+qcIFx9fVpPMtVbIYYTsrXOR8gmEb2p3A6FhI7vVnvCL9Z8jcIM22hqENvaxO1JlETvrNH4HX2XHggvx+W0Qwg6gzdM4a2ptn6hFdFVL/Gp07TpC6DZRI+YMzreong4XBy36d5tWrRzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb4C+yISxWXE5SS/eS2icUbogl1aN0/PbBEKFdJZZUk=;
 b=p28BswZuj3JOggqglGMg9VYPNS5NO0d+Boz+dp3qg1ithvV0PVDp82VZKY8w3rCVr6Jw1w9pkXTwq0hkj22B9ZcpPIVozDzLrHp4rpsnS6ctmN43JhhVhfXpgf9e1N7EftRp0crBlgX1x28u2F5zsyOdkNBvZokLo5Iq0VqwM/k=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 08:34:06 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::7e) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 08:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 08:34:06 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 02:33:57 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kim.phillips@amd.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <changbin.du@huawei.com>,
        <yangjihong1@huawei.com>, <zwisler@chromium.org>,
        <wangming01@loongson.cn>, <chenhuacai@kernel.org>,
        <kprateek.nayak@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default event on certain Zen2 processors
Date:   Tue, 7 Nov 2023 14:03:30 +0530
Message-ID: <20231107083331.901-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ae9064-6986-449b-4a7a-08dbdf6c4e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBqv0Z958Haq54bnFS2EkRIDCLz4EO5QqfKHsJt8JNm4r7xztPE79poqGE3Obp9fbai6my5lFIerTnGr/vP6mAU1LhsmdmFIRW5tWE3jLUvqsSdl7zrt0Vsk3PDBshtClaby/lDDkbAGdszSpwDmt2CrgJC2xmN2W7C6glDf4TJjdnvmSpLIczGmOw8WOp3Sgz3E7KzlHX5tM5qb2HlkrsyNmOaKVPRg3sNs/NxKQMlfB46Bvj2ezyouHEE81n6J6Qlt7/H7dUCt7VVOlm8tPPqvIdFl7E0Deax6uRyZh5FU4Mj+L0GfIgrZfIr5WzwQ7OgN9n5InV2ky8ZvyDH296aapBQh7KJ9+CZxxmcEraTs4wQnGHpx0WZwApinqUF3TZGMEG7NfpQhYzXnuHKXwshpDlqOu1/jYqmycf9eI02IyYC0a9ACHE5opIbnJsGO+3REfu3Rb5nzwNT2JM9GSH6OzKU04FJ6C7/SmzKpsNCdT9EHUxRKBXsgCmOPIZuGQt09E0WEfTrYdPwGH0fe+si2MY8qrfiF09y4bYLDCdxMqpn/6MS5a9J+O55GLmlu2cKtGCkpd0OPFUTOKGdb+WcjXa6JBUY9sICXed5/Vyxf68QyuUk13Hat0cbpK361KCca0HEILwNlVI+eqegoCzqXN2mA3C9VN/cuBOFzMbp4ZfS27jsGRRbj1MCmKdj8tjUwJ004astsgrUgVwpUMW9psbF3+5fUBBDz0K7Y9aVD2sPnBnPFVuTtMVu5J02fJ2922Qbitgr62JEqDzZWuesNXkVcRsboex/iUcIl0tzk6A5bCg40C2cmZsKEV97D
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(478600001)(41300700001)(44832011)(47076005)(7416002)(7696005)(2616005)(6666004)(336012)(8676002)(83380400001)(426003)(8936002)(4326008)(316002)(5660300002)(2906002)(26005)(36860700001)(1076003)(16526019)(70206006)(110136005)(54906003)(70586007)(81166007)(356005)(86362001)(82740400003)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:34:06.2310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae9064-6986-449b-4a7a-08dbdf6c4e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, Perf uses precise cycles event when no explicit event is
specified by user. Precise cycles event is forwarded to ibs_op// pmu
on AMD. However, IBS has hw issue on certain Zen2 processors where
it might raise NMI without sample_valid bit set, which causes Unknown
NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
use non-precise cycles as default event on affected processors.

This does not prevent user to use explicit precise cycles event or
ibs_op// pmu directly.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/evlist.c | 34 +++++++++++++++++++++++++++++++
 tools/perf/builtin-record.c       |  2 +-
 tools/perf/builtin-top.c          |  2 +-
 tools/perf/util/evlist.c          | 12 ++++++++++-
 tools/perf/util/evlist.h          |  2 ++
 5 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index b1ce0c52d88d..f4478179c91b 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -5,6 +5,8 @@
 #include "util/evlist.h"
 #include "util/parse-events.h"
 #include "util/event.h"
+#include "util/env.h"
+#include "linux/string.h"
 #include "topdown.h"
 #include "evsel.h"
 
@@ -92,3 +94,35 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	/* Default ordering by insertion index. */
 	return lhs->core.idx - rhs->core.idx;
 }
+
+/*
+ * Precise cycles event is forwarded to ibs_op// pmu on AMD. However, IBS
+ * has hw issue on certain Zen2 processors where it might raise NMI without
+ * sample_valid bit set, which causes Unknown NMI warnings. So default to
+ * non-precise cycles event on affected processors.
+ */
+const char *arch_evlist__default_cycles_event(bool can_profile_kernel)
+{
+	struct perf_env env = { .total_mem = 0, };
+	unsigned int family, model, stepping;
+	bool is_amd;
+	int ret;
+
+	perf_env__cpuid(&env);
+	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD");
+	if (!is_amd)
+		goto out;
+
+	ret = sscanf(env.cpuid, "%*[^,],%u,%u,%u", &family, &model, &stepping);
+	if (ret == 3 && family == 0x17 && (
+	    (model >= 0x30 && model <= 0x3f) ||
+	    (model >= 0x60 && model <= 0x7f) ||
+	    (model >= 0x90 && model <= 0x9f))) {
+		perf_env__exit(&env);
+		return can_profile_kernel ? "cycles" : "cycles:u";
+	}
+
+out:
+	perf_env__exit(&env);
+	return can_profile_kernel ? "cycles:P" : "cycles:Pu";
+}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dcf288a4fb9a..e58d8ac8a77b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4150,7 +4150,7 @@ int cmd_record(int argc, const char **argv)
 	if (rec->evlist->core.nr_entries == 0) {
 		bool can_profile_kernel = perf_event_paranoid_check(1);
 
-		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		err = parse_event(rec->evlist, evlist__default_cycles_event(can_profile_kernel));
 		if (err)
 			goto out;
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..21368421eddd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1666,7 +1666,7 @@ int cmd_top(int argc, const char **argv)
 
 	if (!top.evlist->core.nr_entries) {
 		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		int err = parse_event(top.evlist, evlist__default_cycles_event(can_profile_kernel));
 
 		if (err)
 			goto out_delete_evlist;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e36da58522ef..406ed851cafc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -90,6 +90,16 @@ struct evlist *evlist__new(void)
 	return evlist;
 }
 
+const char * __weak arch_evlist__default_cycles_event(bool can_profile_kernel)
+{
+	return can_profile_kernel ? "cycles:P" : "cycles:Pu";
+}
+
+const char *evlist__default_cycles_event(bool can_profile_kernel)
+{
+	return arch_evlist__default_cycles_event(can_profile_kernel);
+}
+
 struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
@@ -100,7 +110,7 @@ struct evlist *evlist__new_default(void)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+	err = parse_event(evlist, evlist__default_cycles_event(can_profile_kernel));
 	if (err) {
 		evlist__delete(evlist);
 		evlist = NULL;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 98e7ddb2bd30..7267b4fb1981 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -91,6 +91,8 @@ struct evsel_str_handler {
 
 struct evlist *evlist__new(void);
 struct evlist *evlist__new_default(void);
+const char *arch_evlist__default_cycles_event(bool can_profile_kernel);
+const char *evlist__default_cycles_event(bool can_profile_kernel);
 struct evlist *evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
-- 
2.41.0

