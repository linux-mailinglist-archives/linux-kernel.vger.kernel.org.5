Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F27D06FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346926AbjJTDim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346899AbjJTDii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:38:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF5E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW9OTafeUF0X2nHoVZsKVKoszVlC2+YZLX/ANMPmro3WWWO8IpoXG2CyEyQTuM4gZxR8AefgmYxC8g7k9o9suZ4P1hjuIsevqzpSyQi9JBuFTD7ucOrln8yAaLGZXD5tLBhhjCo1lBs7ecIHwVYsvFbAUjBwvpHgtvZuWKj3tlzn7Qoiode++HQWA0vIv/LR8NQHeAYH8EhMf0RVS8Q2lkdgLqVczf4Ju0TM8C5seLgrwzSUWsA0gb8rrD2FuRehtKPDexQTghsJs4HF4M/qaZ6iX5MvAYS3U9o+NFpe89kzTZ+9+pbBRq/IZKTPVaDBoqAeq3ovWKzxezy+iTYwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSfbQIq5Uk5H79TvUUKFoJ7I9IjeZF2Q7qjWVZNu/cA=;
 b=YOBKNYNyCz/79I633H1s3sIo9vOCxUjoEex//fXJpy2DW91sQWhqqamDcFUTRwG7CJyg9ISa7XYYVo+LagGzJdsBs7XKZX5cetUHjTk+ATqnNc4bAGg/epMhnXPw04kBbt3+b0vzDdJSdFhIXappIbsigivNsnZZRSQDv9HeQ6Md9sRskXipZ5Lf8m3dRsCwQGC1mujG0+THELy3kK/5NOL3bS1Yy7G3QB8Yi0szhQfWM5KQpwJxgkw1qUmADce2r/FH14VgSaogi+9q6CwVh77dwZJs2FyomrN/mXdbRIPFApIYL42i4dJkMdSereb3BP60+iGD2w3MgnjMCsxvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSfbQIq5Uk5H79TvUUKFoJ7I9IjeZF2Q7qjWVZNu/cA=;
 b=rJMEcJRRnwpeViuT9G1417sUNFNLiefW9qjR7Kvw2kxISh04+W037Kal9epqZlybuwoECAxqxhJP1C/+cA6PJbb0STL7lUfIqBxfvsfEEkQKcetJib1DRqstA2YpshrSzaz3aHLSFp8Z/QErOJrEP0q6vKVCernqmpRHc4VFRxs=
Received: from CYXPR03CA0042.namprd03.prod.outlook.com (2603:10b6:930:d2::21)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 03:38:34 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::96) by CYXPR03CA0042.outlook.office365.com
 (2603:10b6:930:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 03:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 03:38:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 22:38:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <dlazar@gmail.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] x86/irq/i8259: Configure null pic to have one legacy IRQ
Date:   Thu, 19 Oct 2023 22:38:06 -0500
Message-ID: <20231020033806.88063-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020033806.88063-1-mario.limonciello@amd.com>
References: <20231020033806.88063-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2672187f-1f53-4e9b-073a-08dbd11e0975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCUAWl408taUZ/bwXchzsI81/cj7Hra7jq6eGHQfhbk5i8Zv5+lVhsX8B9KYD80Q2mkVzg+pu8tPbEVGH2OqPPEKX1SuWhunitDxaOpBQy2MrBw3hlYk8DguygTKifLDr1QZvBRJgKaC59V0hBZNV5KXXZuD0rb5MuNwNkv1e7I5J1KVCn3qFamcqEAcI0mP74OYg4tlauzVIuW+yF5IPbnqZCOownmH9SJEQAUQz7jE5H+U2bsRve03cK02iP1aNYmUUaMY3rMs33d9EsxyfhlrmWymnbtrAHOOPxci2b1fp2KGA/p04UIk6BSlZpQSQ2WsHk5itzHMnTqTzuJULeZg8lCCo7LvKZeuuPXYDUf0uSjOBoAqdV3M7E/fnvqOQMWpTjMLpc4JaH8yZh6qhD8/H/cPYX8OV8Ga5Oi46vnsfG3310c1qBo8y/j/WfiFNtmWxE5TQA60ZEcMNSz17DHTec/LKyYErXZyeuH0FqDTntzAN4wTJ1aFyIQgbqIPs3Vj6WfVA4wJFTTmkBGDlPKhBzTE6Dx8uQOL44wfbJI+fooJeQh5kosY01WDcRXV4mNdnq6l10ZhK8KYs3Sxz1LfOcCWc72oQlx/CzJdTEKKhOOFxGL8dKpGdUxGXD2iE54plr5RC8YbSl0kxqS6tCMP8ptQEJOrEHArz6dPW3ut862oFSjOMKmWEmuo4CryUmlvJu6pjblMNxQNllUSCQ4JicLsviUuMaNR8KQQ/QBJBhz73Ki98HW5J0UAFbV9ZPDU+eqxe1PL0bIfFGZCog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(81166007)(40480700001)(70586007)(54906003)(426003)(110136005)(70206006)(1076003)(356005)(316002)(336012)(26005)(82740400003)(6666004)(478600001)(16526019)(7696005)(966005)(36860700001)(5660300002)(44832011)(86362001)(4744005)(36756003)(4326008)(8936002)(83380400001)(8676002)(47076005)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:38:34.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2672187f-1f53-4e9b-073a-08dbd11e0975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system is configured with the NULL PIC, the system should
still be able to set up the timer IRQ at IRQ 0.

Link: https://lore.kernel.org/linux-kernel/878r7z4kb4.ffs@tglx/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 43c1c24e934b..885687e64e4e 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -424,7 +424,7 @@ static int legacy_pic_probe(void)
 }
 
 struct legacy_pic null_legacy_pic = {
-	.nr_legacy_irqs = 0,
+	.nr_legacy_irqs = 1,
 	.chip = &dummy_irq_chip,
 	.mask = legacy_pic_uint_noop,
 	.unmask = legacy_pic_uint_noop,
-- 
2.34.1

