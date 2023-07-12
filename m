Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD97513A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGLWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:35:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DB1BC6;
        Wed, 12 Jul 2023 15:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mpd7s2Wt5Pq6d5OS9cDZyNnpq9/kqxaVFqT8hhdC68JRLGkPkMVFf8uWHT9Jfw703ly7+gaNz6vk95OKCUby3See3fsh4jJZeMY+i6SsEWep/tQV2EXGaV+mBojFIMGJyoDpCHGH3etp16XhhqX3C3lcnbpPqg/rFwJt+DK3JkaZTf4yOk5r76Zz8kMajh8p+WQkuN3vmcNOFgIEte+xtaEkxN/y1NeQjfc8yYKhhOovRAqf5JhxgCs/sLBA+hq9ja53Hfwv7HycWTDHHTe0sHqPAyEIg+RD79o/iiGksYwPBw5S44nhlfJ+Ity5D/RrxvjivyWMDK+EKkbodWAGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDY5YbkW/Bu9zezWq4zIh44vQhrojCsnfgBQw2Lr99U=;
 b=DVhSkUWgCcs4LOpCZ2pwWMzk+BO0t+w1eG8kz5GotZbNy648+vAsFIKVN9zKg2+Ns794URRQomYqQQzD40gJnoNo4m91dOxIzwLTP3wlOj2TQKbcSn5Fll88Qzn2A7U9U93wTwIDorv4XuRl8pyeKZU3fmawRYxWOHdrKNHwE6pqtcIersnYueD/r2zEbKnqIwUE+Z6gl32AHJMCVCowcA7raVZ0m6zGIytxsOh6tTr/leJDHJQgtQ0xuyXx0SuMijdDHDZl2l76P9zckdkD3uFUT1x6klCPO8ICoQI3RzQVbn5PS0dZMQOB7gudEQyTI/K5gkRZzqRptLFMGfvXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDY5YbkW/Bu9zezWq4zIh44vQhrojCsnfgBQw2Lr99U=;
 b=RIQXCrxC4adY/nvqN2Hz4RArgpznGpidENLoKpghWlmqAfBkoz0URQF9gbwTgLKgsCkG3xdYExn2iOjKl9UxPOuxbr4U+tPSABCBShhwe3BlrzpKGCSetyRITzEPK+RmHbKr2fxtHe0nrIjhubH4sqtJJCN11bw0jdnE/A/45I17hmgHSCH+IHwoHg0PXomlHat5ZcoYpBZQ0H1raiB1Imv0fYLbaFJvqEi+fMjngjbZJgP8jtjQwMmweOHjeQ+XQfTa0lxrqT3ynYZPAAiy9tT6Qt8U0PhUinSdSzNtoZLLQ3hZwnik/YCOuySwfuhqnX4ZDQ8YMvP7tQVcxNtbXA==
Received: from DS7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:3b8::15)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 22:35:41 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::73) by DS7PR03CA0010.outlook.office365.com
 (2603:10b6:5:3b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 22:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 22:35:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 15:35:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 15:35:25 -0700
Received: from build-jeshuas-20230620T084931826.internal (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 12 Jul 2023 15:35:24 -0700
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <james.morse@arm.com>, <bp@alien8.de>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        Jeshua Smith <jeshuas@nvidia.com>
Subject: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Date:   Wed, 12 Jul 2023 22:34:48 +0000
Message-ID: <20230712223448.145079-1-jeshuas@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 891520dd-f3e6-4691-776d-08db832852c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DweiSnRXYxcMUO9LK7Jx6wLXx3bmrWshPSaEa/CXMmze5oazkSBXAVoMJkr82i6W2t/OPYHhNr1IpwkyRwI7592VJwuZnHDD3u3SVH266/+Qv+cRkDiv7u2AWePPt+G3C6mwLQgywnKUl1OyFGotSWbk4BxtINA1O7JJcuJaEhrTPM0VtQTNrvgd2IlGHCIvRQ3XTcdJh9RSnGKViMAREJdTuiuQDLNcFIitNWtKfesfoyS3p+YdfrJuuno6SwDJ0fAwp6nxHzdPrpwtOaZLV0e9owX1Qz+xMxmZaCH28QVv8koX2Inp2VIiQVs9W9klK+2hE1zFcMQU3/cpyygQaTBaIj6JfVZ9v2bCX3EGRXGcuJhbPSxZPgIGe1syqWtNe2L/iDb7zK3mKtvGmICNRRNBuCSb6a3g+yZ2yePDyVStYzVkeCZxW31UdAQ2YfL4ezAizLXH5Sj5Hfnp3q/1+irv3xuD5JT0PlMbyWD0tyii7nmvLwn0U1TSmlf/hV4NOxPjXMA+GsZ+R/yJrTHbpN9BzOEuGkxjAO8qE1qRP7TpZROwD+LbzWeQpulQUIbYwei31RirYYqNzIEMwGMFbqiU4ckj4ZDKQ6MoTHoQOc6az2yjGLuyW5iUshnz27B4kDi2qMaG1TD9cGxIEaekGZ2eMj/RwClwpx7Xd4/UbCqpe5VdfWKsM/geqTxq4ttRaNOZcFWVN8znbRTnx8htMU6DI+EqblbzqoTGim1a0wEPNMlGgQIUQhpcvcMIZbu/
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(336012)(186003)(26005)(1076003)(107886003)(2616005)(36860700001)(47076005)(426003)(83380400001)(41300700001)(316002)(2906002)(5660300002)(7416002)(8676002)(8936002)(478600001)(4326008)(70206006)(54906003)(70586007)(6666004)(110136005)(40480700001)(36756003)(356005)(7636003)(82740400003)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:35:41.2254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891520dd-f3e6-4691-776d-08db832852c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slow devices such as flash may not meet the default 1ms timeout value,
so use the ERST max execution time value that they provide as the
timeout if it is larger.

Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
---
v2:
* no longer add copyright.
* no longer add unused ERST_EXEC_TIMING_TYPICAL defines.
* set timings to 0 if the ACPI_ERST_EXECUTE_TIMINGS operation isn't supported,
  which will result in the default timeout being used.

 drivers/acpi/apei/erst.c | 41 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..bf65e3461531 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -59,6 +59,10 @@ static struct acpi_table_erst *erst_tab;
 #define ERST_RANGE_NVRAM	0x0002
 #define ERST_RANGE_SLOW		0x0004
 
+/* ERST Exec max timings */
+#define ERST_EXEC_TIMING_MAX_MASK      0xFFFFFFFF00000000
+#define ERST_EXEC_TIMING_MAX_SHIFT     32
+
 /*
  * ERST Error Log Address Range, used as buffer for reading/writing
  * error records.
@@ -68,6 +72,7 @@ static struct erst_erange {
 	u64 size;
 	void __iomem *vaddr;
 	u32 attr;
+	u64 timings;
 } erst_erange;
 
 /*
@@ -97,6 +102,19 @@ static inline int erst_errno(int command_status)
 	}
 }
 
+static inline u64 erst_get_timeout(void)
+{
+	u64 timeout = FIRMWARE_TIMEOUT;
+
+	if (erst_erange.attr & ERST_RANGE_SLOW) {
+		timeout = ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
+			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
+		if (timeout < FIRMWARE_TIMEOUT)
+			timeout = FIRMWARE_TIMEOUT;
+	}
+	return timeout;
+}
+
 static int erst_timedout(u64 *t, u64 spin_unit)
 {
 	if ((s64)*t < spin_unit) {
@@ -191,9 +209,11 @@ static int erst_exec_stall_while_true(struct apei_exec_context *ctx,
 {
 	int rc;
 	u64 val;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 stall_time;
 
+	timeout = erst_get_timeout();
+
 	if (ctx->var1 > FIRMWARE_MAX_STALL) {
 		if (!in_nmi())
 			pr_warn(FW_WARN
@@ -389,6 +409,13 @@ static int erst_get_erange(struct erst_erange *range)
 	if (rc)
 		return rc;
 	range->attr = apei_exec_ctx_get_output(&ctx);
+	rc = apei_exec_run(&ctx, ACPI_ERST_EXECUTE_TIMINGS);
+	if (rc == 0)
+		range->timings = apei_exec_ctx_get_output(&ctx);
+	else if (rc == -ENOENT)
+		range->timings = 0;
+	else
+		return rc;
 
 	return 0;
 }
@@ -621,10 +648,12 @@ EXPORT_SYMBOL_GPL(erst_get_record_id_end);
 static int __erst_write_to_storage(u64 offset)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_WRITE);
 	if (rc)
@@ -660,10 +689,12 @@ static int __erst_write_to_storage(u64 offset)
 static int __erst_read_from_storage(u64 record_id, u64 offset)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_READ);
 	if (rc)
@@ -703,10 +734,12 @@ static int __erst_read_from_storage(u64 record_id, u64 offset)
 static int __erst_clear_from_storage(u64 record_id)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_CLEAR);
 	if (rc)
-- 
2.25.1

