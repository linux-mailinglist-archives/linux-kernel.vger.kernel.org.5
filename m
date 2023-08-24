Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8F787B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbjHXWFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbjHXWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:05:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4124A1991;
        Thu, 24 Aug 2023 15:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV6eOV/Z0uhmhVAlqH9vqhlDusriQxs1tRv2INZkrHTzUTAqjiFyyaGv0nu3LZ6Ktvm2+izkpnSno48NOX+o1UCmzVNrWtgf11TdOTWA/giabD7bBdz1mKuWZ428641k5IN1+pfW9Z+F+wyrEjNBm5BrVDXQGdwYmOB5cP4s+HmGneo5MX7HnVP0WibkWEbSfdlZSKl3T27YTngrypMUtCpcnNtbmojikuGLCLpZfrNfkd9XbpC9HfLgm8bgaaKXTqL/LwSFueAUMPQnfuxaKbq9B1tZ7j2KYHwDU+p5ZskBJMBv/0FX0pimEV2RbkKfuIaxzNpZxoAWQG/l5lmSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtMRqoJBiUDmuCowvMrIr7z72xwZmjYmsdtLouMXnUc=;
 b=RKAY/6MNZCBR9URcvUu3iBk0aYKC1K8DGeaxUggbdTh0QAhfy6vVNQmnKvGM559CVV2fW/e6jIKMKJGAea4Xac+HDbv+Afk/qqr6VMy1YxQhRcooNJYqog7SryfQck1Y9Q6ylZ+cNs62xLiAq3vk6sn7gnJMLO8XIRSwBcbSDoNDB+hDVL8D7oO6P36qzBde5IX3GJKmEngSj20vTnv35DKWqxmVGLBuOFg4FuqOVwr6tSO5pB0rPjMziUR5XZAw0gKzC2bqBdZUtcwtl8YeolvVAdkPGTiddla9TJcnaOzqSPLoeKmcELNCe63jAokmmyiAu2cyQcvF5Nd19f8Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtMRqoJBiUDmuCowvMrIr7z72xwZmjYmsdtLouMXnUc=;
 b=t49LrjYYzY5EYAh5KXJO8UdxTKae73OOV+d22/v39/BjHYeIK2ABPzQCwtm3nqssOyfnwFv2KXt1aTwF/+y7FxXpEEhSmMf98ahH8k8c8CzIjRJXrC0nVAn+3VZiv5Ovi5W944waKIQjxn8qWy/TzQ2x37SckA2yei2DKWlr+qs=
Received: from PH7PR17CA0062.namprd17.prod.outlook.com (2603:10b6:510:325::23)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:05:22 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::2f) by PH7PR17CA0062.outlook.office365.com
 (2603:10b6:510:325::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 22:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 22:05:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 17:05:19 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <john.allen@amd.com>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] crypto: ccp: Get a free page to use while fetching initial nonce
Date:   Thu, 24 Aug 2023 17:04:59 -0500
Message-ID: <20230824220459.2723-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824220459.2723-1-mario.limonciello@amd.com>
References: <20230824220459.2723-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: caabad82-f333-4bdc-a32a-08dba4ee35dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biR0jKtkMw03SEA3QO8fFWPtZWXaFigczj+ijPXZ84L5XygXQh8O0KVL4bTvpwqRCJKBs4lPgRDsOxIIpIGFDOBoeIUvsPASZTaiFFtS1EnYMC52DhfU4n+bOc9+UC1BgbXpi6pDD6HR8DC4gHHMpgwni9o227GyafKarySauhjMozpOH7O2c5a9T1nba3piqRgLFbDc0kXE2/RmVr5DCmualvJaHJ3ow9O2aE0I+mRDimQoWnrMLiiYuer11bqCn51bIyOlEb5eWN+TkRd4OWbCAoFOO8sEwr8QKYXCjQBHQgwS74Uxx+fg/HiD8ijC9PncXh3GI1ua/dDpGUo7/EqaRjJoTx+8shLKb8vbniRW5pudHrmuN7dvZuM9kMdiNiVJ2Wjc01IMFCfv41MgZXQMGvO+OvllD3dyA89fULwJ3kSPshT1Nz3UZ0CwONsrK907ANG2+FLthVzLCpUhx1T5kZcS6fLnvcMDhWBocrSf3HHmPVViQa6ejbL2Tpzv7MiQATiynDogb+Z0Vm3wAfuRRCj6O9algBK+tksOgsPLsZJduIqgHgnOCyGI0AF1Lq1HgB9fkkpFLxYBpObCL4E/rmx8ODwwVlyGDdrgN8m772ILqDqZcyU4lmHuEEpLQmEfp9webEQR1nbWZIV1ub8/tPvMTrkiiybcnfr83QuCOkjQU441NtPxZWyQjVYcIhwKBAE+FrQR4bR3Itq1vroCW7S36PS0sgZoxgR0Qg10055CgtmypQQCzbUfmMWH3caRGaeTzzqvlY6ZgUG//g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(4744005)(83380400001)(7696005)(44832011)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:05:21.4384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caabad82-f333-4bdc-a32a-08dba4ee35dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dbc_dev_init() gets a free page from `GFP_KERNEL`, but if that page has
any data in it the first nonce request will fail.
This prevents dynamic boost control from probing. To fix this, explicitly
request from `__GFP_ZERO` to ensure first nonce fetch works.

Fixes: c04cf9e14f10 ("crypto: ccp - Add support for fetching a nonce for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index 839ea14b9a85..a99b8f02153a 100644
--- a/drivers/crypto/ccp/dbc.c
+++ b/drivers/crypto/ccp/dbc.c
@@ -205,7 +205,7 @@ int dbc_dev_init(struct psp_device *psp)
 		return -ENOMEM;
 
 	BUILD_BUG_ON(sizeof(union dbc_buffer) > PAGE_SIZE);
-	dbc_dev->mbox = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	dbc_dev->mbox = (void *)devm_get_free_pages(dev, __GFP_ZERO, 0);
 	if (!dbc_dev->mbox) {
 		ret = -ENOMEM;
 		goto cleanup_dev;
-- 
2.34.1

