Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C5787B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbjHXWUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbjHXWUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:20:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC41BE9;
        Thu, 24 Aug 2023 15:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFwgPY9EgTZ46ncLdSgDmnb3VQaoWAxV8EfU9oLtJCD2MytnTqAC3fQ1YdHo2/1YPx7CLqq6KG/yVrATCQfnWh29nkSd8q/in46mfXOYdOO5BKDnGb2bgOxmojNSOJhLACZFKZkpc2k4sKf9d7MmYA9kGpbyS6+3qAYPEnNpJQM2WG9XiubdruApuhCY1SfiFhTdYhrjCVCkEAroWAEJ1tMwhDCO1Mwiv2gLulayMLy0zWkQPDz2jI2WgPpJ2p1RMQc2I3E2juVf9ltU0y9c3HL1OHsTTV3BHLG+K/3HNIN1Utlm2K3iy2fkdeysob+EA9uwmU8stykMB0al0ZuszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KJtETMXXi9N6QnRqMc6+9uYEkEdp6jX/xna7WGUSKU=;
 b=BcfGUq9sVNNkiqGpdv4fYXS7con+PJc681ocJ+E7MrAxPepfzY5J3LCD4oRogP8kjZ3aqxhkGYaBQGDAnOvlEa3ptyejimOcaY2uVBkg2XaZ0CNMcWDec8DUZArsCr/aaLfOTQFbU5U+jskVHHl38sDuNtfXuhvJuPdEVVVPaTawQ1MoKfjdAVzwQsfbWRfhSBR/yfdhBBNokE9nCLZ9JN9FePM6jTcGd5QEW6epppak2yL/bWGBVcaQ+S4lvSFL8iSRDIK698003w34OxorZT/j+zxcMFJvTTM9LLF/f5aeXuR1v6AHrwQVuPQuT6D0YMwSkdIjfBYYlHphUcgyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KJtETMXXi9N6QnRqMc6+9uYEkEdp6jX/xna7WGUSKU=;
 b=H6K+IA7KhnSHgyQA7x01w+k/jRAjh8hpjByKT8YAbmXQCnT5xpry7eFdfNUEv7jYexRtKrF02NAxwEpqQdgOSdTGBFfG4wTjVz6NL1Qvww2yO+cuVVjdJ8EwXEhjO7hHV2kSDloDiWjwTC2CyofyOLQkbvuRcXi7MOEXtPnefzs=
Received: from DM6PR06CA0017.namprd06.prod.outlook.com (2603:10b6:5:120::30)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 22:19:57 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::51) by DM6PR06CA0017.outlook.office365.com
 (2603:10b6:5:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 22:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 22:19:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 17:19:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <john.allen@amd.com>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] crypto: ccp: Get a free page to use while fetching initial nonce
Date:   Thu, 24 Aug 2023 17:19:32 -0500
Message-ID: <20230824221932.2807-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824221932.2807-1-mario.limonciello@amd.com>
References: <20230824221932.2807-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ff0bfa-d0de-4885-e880-08dba4f03f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9xmz1cZ4KPikVLMybtMNMr3ADLxSHkXE9KTQuzQETKW2ycVBlHTgd25svFcbDxOwUUYZhD0OvEmucnvVf6M2IHXD3G1x2LFltsDUPCylSCoAl6EPk9DTr8zAkq1MTeJgbk5T/61t6bFGaVOhqv9hYK1D6ZpjXOP2ROCGmvGEdd0NaWUJq++Vy4SakgLFqCqHxs+Uw03HCsAFMSphovyh7zAwP99A3aQj1V95VCn8Be2xb1NsvTejcRLPAx2hta0pxMhMU/ozL8bk7FroovoHFRhto3ivoL49IhN3KqOdw9dz0vIlLfbQkqgfzw9rFcN+MQf1XKnJaiZ480zTG24QLCcYriPwufwMgNi5iu/8d/lW/TULU7oh/rPjVDf8VsHr7lpiNTEYb/de8Dys6isKXvJrJXJZHekrzdU/9lA7+D4SkeKBNpmw5Is6Y8krd3VL9aD6827n099rotXwTbs+htUL0J6Bh5jOQMCGnvsLn8+dcktpUFrUVSvaTs3KELwD88qs0xjwZiRn5hKPtquWtaG/JnfdP/IYlAEjef0MwxrdcmMcFmBYg8ydAA49Az8KynY9sAZ/6VL3uxdZEqFVud105AyHXpjEvk/qDKDyk4p+L03sV1Rxxcdmj8A4WZO71I++Z2Nnh2yXPr5He+zi6W7QrNOXlZQRWah5VICHk3pWNBjCGYMYc57y8I2aGN72tw9re/TJ52JP3B6gIH7JhjZRgey+dl4gPVbOFSNOXEsEZXzhl2iz6ffyv9w82J+nO1H+lbNQGxXrN0KwCKA0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(82740400003)(356005)(6666004)(40460700003)(81166007)(7696005)(40480700001)(336012)(1076003)(36860700001)(16526019)(26005)(47076005)(36756003)(83380400001)(426003)(2616005)(41300700001)(2906002)(316002)(8676002)(70586007)(70206006)(54906003)(110136005)(44832011)(5660300002)(4326008)(8936002)(86362001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:19:56.8014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ff0bfa-d0de-4885-e880-08dba4f03f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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
request a zeroed page with `__GFP_ZERO` to ensure first nonce fetch works.

Fixes: c04cf9e14f10 ("crypto: ccp - Add support for fetching a nonce for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Use GFP_KERNEL | __GFP_ZERO to ensure accounting works properly

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
+	dbc_dev->mbox = (void *)devm_get_free_pages(dev, GFP_KERNEL | __GFP_ZERO, 0);
 	if (!dbc_dev->mbox) {
 		ret = -ENOMEM;
 		goto cleanup_dev;
-- 
2.34.1

