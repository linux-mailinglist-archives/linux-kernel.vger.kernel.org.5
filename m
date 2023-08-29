Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FDA78CB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbjH2ReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbjH2Rdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:33:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6AEC2;
        Tue, 29 Aug 2023 10:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgWxGvfNS1h63T+7ce1aXMXqLnaotm275S3LAx684c8mom+4Z72Zc4RxKxuJ7t5ZB3ICNcpC2zAvO9oHwwrkm3TtfhYo5MntrnE4cGIUNTHxNIq8KCB1qH2oNBPBW+/28Zva0bNLkK5VoB6Tf4BNna6xHYQyDrhVk8BOsG3STVFydGgrwucvbMAhnlfR8in/cikG+e9BPRdZJBciK8kVdRY81vQf1Fr5SxmrLIzpco6erFQ7lvgr4msWYEdNGnChQpk0z7cFRdMuVGxYDYnrxVP5eitzqNU5LDgNkoaAyO4XM3kYixZhqcUBYYZ9g6GeGeMKNHzi07v/OvosHuJboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYa2Qn6XP3jIT7igpRKKR4n7GoSXQMkt9N/o+t0Slbg=;
 b=JRm00Bn2iXcns6mDWJwfhIZ007UjNV6i78z6kQdnGmxWTlW7SKjKjrq4r0gGDjNME9/5EY7Va17YH1YZEvFGq87AcZ4UOyyeOqhryMWrNYcSz9ApqYsZzRrcvfQpymc2KDVIkcz5DppAtuIonRhO65DHC7My1uX3XXL03llfwPFX2KapW8SlXb46UpOahZfsBO+UHNuwjqHd6edMzc3nUB2QmVJy61NONyrUi6QOYagwtltAJICqUpoArn3/Iobf12aFOqH+AyxtvYFJgDYgsHE0uIpee1qrv10lEGWA7+ckKjMjOAA75N/bXCuvUu5lcCDlzdRY7A8Gpfy0fUeXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYa2Qn6XP3jIT7igpRKKR4n7GoSXQMkt9N/o+t0Slbg=;
 b=PU7uRtNYDinz0mQZmXegF9LbLhGCtG/fVpTekgWclF6SbGox19m0QzMORT3U6WJyXsZI9tl+2ikxVJ9RPaIzq887q9ADlEPtV4SX9S4qLvx2gXE5TyhCDGsUoesPdNUjpJv21UUcBYgxTTEUP4zz5eUmOyt9OWEHegrMN/xyIW0=
Received: from CY5PR22CA0040.namprd22.prod.outlook.com (2603:10b6:930:1d::16)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 17:33:38 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::c7) by CY5PR22CA0040.outlook.office365.com
 (2603:10b6:930:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Tue, 29 Aug 2023 17:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 17:33:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 12:33:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 1/5] crypto: ccp: Get a free page to use while fetching initial nonce
Date:   Tue, 29 Aug 2023 10:07:55 -0500
Message-ID: <20230829150759.156126-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829150759.156126-1-mario.limonciello@amd.com>
References: <20230829150759.156126-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH0PR12MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3629f795-4427-43d6-008a-08dba8b6143e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpjoCgsCHbj1+l4DMc4FdZV99KoMYXPSzQJhUxtjQvRr/HC9C69vejw/JbwEpERzCpB5Dqa14uQ6743KwG99YHJNpamH10J73KrRZHbaB7+92c0MGO60fgcYF1qhIXu5Bzp8mUFD74v/p2xq3w5hc8NWsr+NKRgpNnVhMI8ZRTvzFdDPqzZP+nLvX+aPGmp7D2ytmu52kyG9LnjG9cOSlU9gghnGAAipz2Y78mGgGT5QJNmiX+QlfiEzHh//wl0zCUNBoGgVXoCgLTL1X+4+N5baTWFh/ynd0Zn4Uh6fwz7LYkV2UkFyEJ7TH3pUtg01tGrrxQpdyYilej59iYniGYlvUz3TILAkiUuxWNI0p5dWueckH/FVBwLCW8puw+ARmqaI8YhK635ANf4lc+tpM5EPQx5ffQDd8XV1LQ27YNFuwAsHIadK/FTT0aZ3IaW3QJLW691W0oBzZqmxBslAIq9OLbnxb6URAi1S3iemG4f/XQamhZCkOVg+J3v8ZW3Fja9lBoi3aQb5yrgwfgjBrfQ+RJggS44g97vmVKSy4qlPmeuW5kgvbkS7OI0J2KyDCZODuO9QexU0QotPFp5BPxwbgLMw6bgXhdr/Iul8B7Oq68Rc4N3cmQh8tSjYxbPX6xCCOr4lRxV8DImSP/mtx4b9qYCj53aC4kd67mYLm8niZ1UJtcL3GTvFmyP7mxbEW9495EXr1nBa31SbisjVsy2GVWhUyKvrKqrvGgKp3FFIDSmB6I+Bg0vzKO6qP7SOzPafJgImo4x76+UC2+DUMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(356005)(81166007)(82740400003)(8936002)(6666004)(478600001)(110136005)(70206006)(70586007)(7696005)(54906003)(316002)(41300700001)(40460700003)(36756003)(16526019)(26005)(44832011)(5660300002)(8676002)(1076003)(83380400001)(2906002)(2616005)(86362001)(47076005)(40480700001)(36860700001)(426003)(336012)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:33:37.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3629f795-4427-43d6-008a-08dba8b6143e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 drivers/crypto/ccp/dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index 839ea14b9a85..6f33149ef80d 100644
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

