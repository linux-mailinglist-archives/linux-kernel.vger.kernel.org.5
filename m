Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80280BF42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjLKCiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjLKCiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:38:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43968F1;
        Sun, 10 Dec 2023 18:38:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjcRM3F55jAmp/3nK2tLKrOuFm6XMlYBNhlGzmSjWfQqs5VHVi0RY6N6/cpHn9CokvtMQ5rhaGBaRvw/B5iZqbfXF3L8W6WXt53YhPNaY5md6YXsLZ1H29eJTHIxye+QH8l+1hH2U/DzmEwEGydSL4Lu0jMIwh1v+Q5oyE0Jzl37ztzwG8XhDy5tm3rJQOESBXmkV+YPO6vdHdR9KydI7S5V4oKKIXsj1TNqeyYXXEsNJYKAoo8OHWqgzBcPPwOFkTmQ13v8XhzUsT0wZiz4gmeFwA4Oblmku0xKYSWVO80dCGumhhQjfXv9XO5yq+1VGtA2oKsLCCPl3F/iofRbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6oNSNmFSl3BPSycOE4YaDbu8XnNnc5X04IZqxnaThI=;
 b=CQCObJAxnsThkGfRxhrsO9L/inNWs8RRVN/tdHIVwy2tl98gr0Dg2hPuJKH5BQfor4MCeA7T+LYQl8djkC55IuWcgx/Y6yuGAw5W3EhL2Lg9+vaEcmhJcYtelkvsDG7M57qgR31aolBA/qqXT4VxTZQJ3h1oFKP6yxEpb0Mf1mYQfIMZdq72oyhO/I996J5lt947sMMg0n1byjUSPUZaKlKrXIgrNXfg2Qv68UjsbpqPMs3sow6zFbwen13Z+dnT2rSf1GscZxQG/aJNIeX3ckQ3uG0f4kotC4nWwvH+v0orn5k7DqE4pueXrwMAxO8p9XdNg27nUThBggkjW1ZalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6oNSNmFSl3BPSycOE4YaDbu8XnNnc5X04IZqxnaThI=;
 b=5U6KIdb1Jw2/Mx4cL28DF6w6iGPSORGRr+t4TqmGwmhhl2gxXbwNODLwEBUWCIk2+3dmdcowgZhC8Q8NvO6kH7UDWLQ0CdNaE3sJ9/NRGKiLSSbHFwLTrqMEqQzrZbpN4tsGwghF57nkQg1KFCTpbjLxcXXLaUa4UC7dRsvTAHY=
Received: from PH7PR17CA0004.namprd17.prod.outlook.com (2603:10b6:510:324::15)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:38:16 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::29) by PH7PR17CA0004.outlook.office365.com
 (2603:10b6:510:324::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 02:38:15 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 10 Dec 2023 20:38:14 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 3/4] docs/sp_SP: Warn of links pointing to documentation in English
Date:   Sun, 10 Dec 2023 20:37:29 -0600
Message-ID: <20231211023730.2026204-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211023730.2026204-1-avadhut.naik@amd.com>
References: <20231211023730.2026204-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4b5433-7b04-4431-0b11-08dbf9f23a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgM+EX4WPWOJryhuy94UnZwQvXxL2Ky8BMm43v1QBV+CjpUH84qK1irsUXXuaVcsfTem6IjMrg4b0u63FxOllJsR/u+nKPZYSngNVOWgVypnVXBsyQ170RN+R56uynm5saxSJV7q8ccNklZTd2x5YMVUNQnYAV4JoeUjg4yxxlAXZKr/UXtz+tWjNlD5h5VtmT4I0Ce37AO8lVgZ0fR8REc1RsEKlgJg5YA2a8pw47jmSurOtWliZsXHiUJ7wgP4j6u6Q8iWVxMfQPRudIw4O6YpB0XEcSewTzy20iN/yq+7HvJnFZus3jBB7nKcHZTST8Ue5zJJEztyfYjrTqDCdmtKN+010eSoQ9b0IFOkUJ0BuW0cKkQvggmdMBUfYoM/cO+YOuC7CY3D6NWwURRrFjZShJyJ5dym5KDikvi5h2xKIwzDGog6kWY+zd4iKgBsYliQq99PmMH20s1IJ2nIKgYePs6RrH2MvzwenHroyu32WvoxFxs8s10V5HB2LTe80wLoVl9wSuWHIDdEYB1MKAtcqUB1969/cMhNo/hpOiJDNTBA3F5cYvwLuKtPTjbAamYXSRO32Z3FUUGjQAvgfH8BNP/HjajdbQLE2z8n8bmpPVbwCNVtXJZq7a6RwHrWIsObYlZa6GzREY2vbhesRWDG/N8BB2XBU//aGLfWUDX8Ymcgp9dOfVTEI8wiphu2H09/5IZS0jjOdYjLpGWjCkZwEqzx9Y5KoFqs1rD2MBPjEbYSiKVaafartwdjnRq4KGBNtv706oIvCz3C3Q0RwP2i8Lu+XUjUmQfPUz/LtFfrQPhxn5gEVdQ0XWUcR+n3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(230473577357003)(230373577357003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(8676002)(8936002)(4326008)(47076005)(81166007)(36756003)(82740400003)(356005)(41300700001)(86362001)(2906002)(44832011)(36860700001)(5660300002)(1076003)(40480700001)(2616005)(26005)(478600001)(16526019)(7696005)(6666004)(336012)(426003)(6916009)(54906003)(316002)(70586007)(40460700003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:38:15.5471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4b5433-7b04-4431-0b11-08dbf9f23a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, links in translated Spanish documentation redirect to
documents in English, even if their corresponding Spanish version
exists.

Warn readers about this beforehand through disclaimer.rst.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/sp_SP/disclaimer-sp.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/translations/sp_SP/disclaimer-sp.rst b/Documentation/translations/sp_SP/disclaimer-sp.rst
index a400034e95f9..841c2523e3dd 100644
--- a/Documentation/translations/sp_SP/disclaimer-sp.rst
+++ b/Documentation/translations/sp_SP/disclaimer-sp.rst
@@ -4,3 +4,6 @@
    Si tiene alguna duda sobre la exactitud del contenido de esta
    traducción, la única referencia válida es la documentación oficial en
    inglés.
+   Además, por defecto, los enlaces a documentos redirigen a la
+   documentación en inglés, incluso si existe una versión traducida.
+   Consulte el índice para más información.
-- 
2.34.1

