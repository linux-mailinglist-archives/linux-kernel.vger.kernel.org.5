Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88177998D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbjHKVgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjHKVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:36:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F59213B;
        Fri, 11 Aug 2023 14:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmCLk+VfaGGs4k3F++kl4pltcRTcAQTVuj5DOojwKt1cGeS2W7rfx3b28YMN6Er4mGFkexXo6FD8KjCoDhLnKsM0mA87hpO6pFKJ/SHgqPs14dWJja2vZ9UXwFDle6WXE0GQc02gJ1UkQJEUoP2LJB5sMeLr8mSSqIZLLQZc99DXDg5B1v4vpJQuhr9v1QR3px7fPfmh4eAKFZ2a43K/hvuT2eoLycpcxUJB6g3ZzaAuHTQHZ9j9m35u4FfgW8GXLdRc12RTgezH2MCeplxD2qBBO5TiNLJHB1sCi6+pdV1arb+QSUI9VUjnVUcjJzIg9Fb4MuTh3k1hLxUm0JT4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VSgHk6CJDLKBBNNDMrHxpUJGPu4QG94tc/2AE1YDwo=;
 b=ZM6duFD4DzYrIXI9iM/MglYuvssBH7f1zQ/564C83MjqyLQAAqEl1jgWprBAcLiag3+3v9kuJ43VzeUUzupHngLlXEW+cB8vHxJOr7aIdS5oAjEBM/q4VMKgi5W8ugj0f8R1MHeGc4qwBh5ynnBnm3N1vLaMmtFunVGTnS0N04u76Iy+XO74zz8q2WRG5nwlglLAny77zaLdNJAaynEYZMDjFacXyjMd5fO77Avkw0zswfBHMlcJZGYDE73ZAvxMTFAE84rIgoSy/9H6iUAMpnnhniOhDmZ5gYn9kg6DfOv/D37R5xWAW9hUoMK2PrDmCS1Ac77HoVGxZ1hjxzU5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VSgHk6CJDLKBBNNDMrHxpUJGPu4QG94tc/2AE1YDwo=;
 b=yXg6EcuxgEu8McL/8+8SNMkZNS/Pnkjmkwgt6nMKCB/K4nlur9jfdt50gf30z0trCoGZ0rJHzteIJYP8UjKBvUFLLkVMjft8/8zqxRmBJOJl/DI+ICrMWt6cK2daXb0ghko6pJPASmtTEi0KGmVbtdUg+6apZIz4CwCttvV8eUY=
Received: from SA0PR11CA0015.namprd11.prod.outlook.com (2603:10b6:806:d3::20)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:36:02 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::70) by SA0PR11CA0015.outlook.office365.com
 (2603:10b6:806:d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 21:36:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:36:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Perry.Yuan@amd.com>, <ray.huang@amd.com>, <wyes.karny@amd.com>,
        <trenn@suse.com>, <shuah@kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <chenhq2005@gmail.com>
Subject: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp mode
Date:   Fri, 11 Aug 2023 16:35:01 -0500
Message-ID: <20230811213501.17293-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cd1315-cd50-421e-57d6-08db9ab2f5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+FXwi43BGylHYqaud7YlOo8hVKaMWn4h3ioEO1jxzrwa2sPhm5jcj3g9bnEQCCoPTs98HJebu/7AquGraKoJoer9uwievhoLdbwaLW6MzF31XGbZPcciXZklLgu8BES72TCstmsDRmA5nUfg1NfYAl6Lba73XHLnMu2Mce8YpY9OPh/osvtpYMQ6nXUZGfODA8SfD45DkUE2Ju1PD5wZFhXrI7ggyNZJwDTiNWSZ1lG7HhtywoWPcuBFaxH2ODoxQCn501orwUTpZhUp2RKAgJWRn8F8MKfWJuvlIGZ3U0BYjYyOtQ2JieiUvte9ccv329lh/P21Wrfltz0qYu2Lh1eX72F/KfZxPek5XCA3zgDfaTLdgZVgw4yQtGeGOOwpcmWjCxTxGaGRl4ZP5kOWESnLedh09UMfzmEjm0CbIMoKG95OSyJcLoujirBtL8gtlM9sfm/h6Q8ak25msyfpC5/Tgrl77AP4DgU0yrpba8H1rz81ucHGf0Dt/0ArNYtxzbkD6WvhxhBuqmHmyZ4vTK4FM7MnQk3yh2Zbfw+gnX7L+mPJi48UTuxiaWLRLAhOB9cxpO7shPoIrkkUxFWepopYLTR/z02OuhTt1vK+ZGo6PnKOWUc2M4ZgNzwK3F1MOhOWFZAkrTrVnDYkqebvLjTNx95DYFEVl5XffdS3s2XK6jo7pK+w6+nb5m9caVTtK2KcGsgwcL/4aeCoM36mKkGeKY6nnjHLum01U/pmyz2zoToWv84FfRtA8N3HC5kdiCvVU3hcs6OYK7NOCBsMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(186006)(451199021)(82310400008)(1800799006)(40470700004)(36840700001)(46966006)(82740400003)(7696005)(966005)(356005)(110136005)(47076005)(83380400001)(1076003)(26005)(16526019)(54906003)(70206006)(81166007)(478600001)(336012)(36860700001)(426003)(2616005)(70586007)(8676002)(8936002)(316002)(40460700003)(41300700001)(5660300002)(44832011)(4326008)(2906002)(4744005)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:36:02.3522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cd1315-cd50-421e-57d6-08db9ab2f5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running in active mode the driver for amd-pstate has -epp appended.
This throws off amd-pstate detection.

To detect amd-pstate look for the prefix instead.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Reported-by: chenhq2005@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7f..01c0440efe850 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
 	if (!driver)
 		return ret;
 
-	if (!strcmp(driver, "amd-pstate"))
+	if (!strncmp(driver, "amd-pstate", 10))
 		ret = true;
 
 	cpufreq_put_driver(driver);
-- 
2.34.1

