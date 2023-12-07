Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36AF808BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443474AbjLGPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443464AbjLGPYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:24:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C8C10DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BffXKTOXYYPJyR/y+tKYc5wpS+xWzIulRhSMg53kJJCO3PlP1CThh0fowg6pbuPYVO+dwpFToNR+IreWyyaKLjOx0OiAOLCJokbcXnYBc4ZWrsv4XwvcvG8LqARIolXLcEU8y0UF8W1mXRtqv/73ibhernMCycuO8HZ2FCZD/duAJlJdsrcxC9E5SoKEYWPH9K8R5L6iZiQ1dy1ARdl8IhSQ8xVUanJr+5i5BYCzet/rug5KWMMLqqRT9OYoRjB2phBBKz+WpIZw/3zRxsiyUAImo2w6/PeFKDE+cM4x5RTQ/3M8KzonAJUHZkkefd9QHKcAlJETgKqtKfjFV5qqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRDzJnd0/Q1WgO3rKqWSnokxcNAWSNuC9qC2xQxLmHE=;
 b=Olur3fEtSGThhLWUbBY9AZXqkVmnKMgSgCQbme9WnySVGLPzNoQbkk1gpoztqH98eQJauiB6HuFNlIUCAU2Od7vdXiRX0sU0Gz9evBuFq2mj0YMZwyABTlO37rfTEwRqdvY6mVwZ5XJyN99M2EEaNPD17QTQzGd49c6N2WeXqQuxIzvic1Ce2quXnOrWcxLHE+nFic7wt/HQVVQf5swPaONWDlQV9/rYp+setRETjsXc+VAjzKqmJ+/HbBeDGwzRJTv2FTjKotZvL6Ken5d98xRJciW+H0WBZ16GAq4LjtDkVYewnO7CKQuespWOwF68Y2nUz4D8uYuxDg63C/UCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRDzJnd0/Q1WgO3rKqWSnokxcNAWSNuC9qC2xQxLmHE=;
 b=w0oTQ62gYbNgXR6gLjgmtbz/K5CWroCcxjCNR4Shs0Lgv4Ifh0LpzcWBA6kb6blOdpx/ZfVOFJ1m2caCrBWnnI0RsGyqpMKO5e59K+Ge2KvgIlGxE4Dgd2lEggocfG+H7JI4tSQA5ywZZjIhvE/Oc1HQkZo+fqhGvrMMu2WYLZ0=
Received: from DS7PR05CA0080.namprd05.prod.outlook.com (2603:10b6:8:57::18) by
 MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 15:24:13 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::4d) by DS7PR05CA0080.outlook.office365.com
 (2603:10b6:8:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.14 via Frontend
 Transport; Thu, 7 Dec 2023 15:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 15:24:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 09:24:11 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh@kernel.org>,
        "Ruan Jinjie" <ruanjinjie@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: xilinx: Add error message for invalid payload received from IPI callback.
Date:   Thu, 7 Dec 2023 16:24:08 +0100
Message-ID: <85749bde3e71148533d31ea2092f4514ec347768.1701962639.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=michal.simek@amd.com; h=from:subject:message-id; bh=FTodKPVJ7n4DRmbAauY6zdIkj43/jVY9jg1J+ne0q8s=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTCxxNL9tefa5szkWFTqdflP4Wt/lq63349S5ztFW219 dHMe2v5O2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEuE0Z5qewVTELsK/5suDo w83vE7s02zvfTmSYn8BzKeiZy4fvey7Nv/FugbJUauvn6QA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad5948e-fae7-4162-6317-08dbf738910a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ucYLLfK3xbY4ZvGE/S5Wc6jeA/Ur06VCJIUGyKDHfpsG8yPBrlxuuZmrxWxsdk1TQ7yZduzSKDGZE4Jga4WcnZPq71XHzOmP8q9FU+8RprL6Y7y2yb/ZgQb5IC8MB3SY5gZ1MxyPcMSvtS+7Tw/7qZEKx9RGEOMJ82tQREPL6fVQeaQnsDlxc+6ynGeo5V8auU34X8Kgebuss3OnWoCiYAxl2gA1MLl8LEuOT3kEcwMX3J7EIWtZ/ghnpkrFLx4Y8BAB2TYLrdeb6KgXmX+kxF7m2FAzjJJ0elMUwvEvaqGR7U/cje95wuKTe4ZO5iztAW6vWRbd7m+tdtuauFBDvQeZl5QGa0nqPwhO3kSlHRtwT3WEwFDRHBHSPjsWWOfl4esf6Whru+fI3KNgOhn3MdVUb8k2NBuH6x7ob8QzJXCyr8Z6Pgomuq0Z5hEGXZd0F5WGI2Mh1med9/MUwjNjh9Nde1LPrkhKo1oKynildDSMcpdcfmJvxMzS0F3OycmnhYGf1RSAFYQAzwbkzyoeT8MCG9W8yQDrOQa1AQZKeGhql6xlaUnxrG8xRMWXDcQL5QzvlmwGDsDdvfsF30WGWXyBQMcag9vEHi1CrMrtnEPgW3p4EI+8ChYSVu411ZxaVAzMIepzMmghrlcVgcuMyGe9KblZdWDSPrpe6ZGuZqtLdwwkjURtS0v3dYjxrR7YtNIqouQXgdZphAzg+UKKLTITHkA5yAkVsAAHGcE+zBN7CYab6gwa/zgt2NTgozkjHyyFYS1GFA95Spk2vvDqZvSTzkR/x2qJuYkQA32od4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2616005)(70206006)(70586007)(426003)(83380400001)(26005)(40460700003)(478600001)(316002)(54906003)(336012)(110136005)(16526019)(5660300002)(6666004)(47076005)(81166007)(36860700001)(82740400003)(44832011)(356005)(40480700001)(2906002)(15650500001)(4744005)(36756003)(41300700001)(8936002)(4326008)(8676002)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 15:24:12.5413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad5948e-fae7-4162-6317-08dbf738910a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>

payload[0] of response buffer of zynqmp_pm_get_callback_data()
contains valid payload or error code in case of error.

Added error message to inform user about the error code received in
payload[0].

Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/soc/xilinx/zynqmp_power.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index abcf7e883279..07d735b38b49 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -86,6 +86,8 @@ static irqreturn_t zynqmp_pm_isr(int irq, void *data)
 			pr_err("%s Unsupported InitSuspendCb reason code %d\n",
 			       __func__, payload[1]);
 		}
+	} else {
+		pr_err("%s() Unsupported Callback %d\n", __func__, payload[0]);
 	}
 
 	return IRQ_HANDLED;
-- 
2.36.1

