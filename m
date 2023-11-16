Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B574E7EE1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbjKPNkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345007AbjKPNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:40:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F66D5F;
        Thu, 16 Nov 2023 05:40:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiVgpmT0nLCW5FlPCsbBvc1FH7vmpfsKusL6zPioH7DRW2hngpbkRw6yPYJPPYd7w5nai40cchgEDPy7HhCt7NhIuFvM5b6LbmLv8TrsXLZRoz+WGZcj+YQywqWQpUXwJz8tL3kxBlrkmJjHjZZwqqXO72PIAbugyzrWak2ZwjbEmkKYdnDsgCswN0Vlw0BIzwHiSK9atQ6TllvRB8k1CMC+pe/1u5HvtgmoFcGf7kUkGbMPodF8iqRR2hT64jI21L/5neekSC2empyS8QroWs6HYWdV1tg5D6MUvDzDVYizFDLSB/KctckxnW7Ga62Z5FSgbF9Xh0/EkbH7qyuSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEAF0ZMbiQhMYETIs085NtB0rbDOT3Q1SOqdmZ6gfFs=;
 b=UAmmeCTMcKEdtQVI9o8YERj/rTaZkZo6A85kc8hSAFj6xT7vn+Uk4raeIjr5LxX8lZ8gpM9Nz4RdKXZCkWF1ESUaNe1f4Wjclgl0h0ZfFeYkphsjT0GHeq7QefU8RpRve9X7GjirWm7EOerRgpppo/GAB61LG+J4BopTUWCYfUjLAsI33oHLO3U+TNlz82OcDJkt5N3wSPymeKxVkVsG/xRsSadD5rZNZNwK3a6aYkT3nQYXKHY4vCMVncfoDCmComgke7kqxiGA0PEE/HjpO/4PXhojpgH6VTnCohMrF23YE+2Bx+0gp7yPWSloUaFfnXwh7+CHkzKqIT6f+a2uIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEAF0ZMbiQhMYETIs085NtB0rbDOT3Q1SOqdmZ6gfFs=;
 b=CotQbsJxeJM7RBGs7no4q0GTIFeON2KpI8/+56o90quaFuIOXAL3SuOxWglh6N4TZfI3ROXgnb0c9BYjC9XycaJa9K0rKeyViCmcBNBRW56zxDKdqnpQpDcmCaooicPg1554c83GHbNwbsKl8ZaB5nTtLPii0tBJkaRVQZ2h0Bc=
Received: from CH2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:610:57::33)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:40:27 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:610:57:cafe::27) by CH2PR12CA0023.outlook.office365.com
 (2603:10b6:610:57::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:40:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:40:23 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 16 Nov 2023 07:40:19 -0600
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <christophe.leroy@csgroup.eu>,
        <rdunlap@infradead.org>, <airlied@redhat.com>,
        <ogabbay@kernel.org>, <linux-doc@vger.kernel.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V4 1/2] Documentation: devices.txt: Update ttyUL major number allocation details
Date:   Thu, 16 Nov 2023 19:10:02 +0530
Message-ID: <20231116134003.3762725-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116134003.3762725-1-manikanta.guntupalli@amd.com>
References: <20231116134003.3762725-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 366a859c-f4c3-4ef4-9108-08dbe6a99802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVdUo7gYME2VMf1ZByg+B1LQ9YanvBnU8E5sLHZWhO6Fi6db7W/6RBO1Kv+lIuakU/OsbGibOOIWaE71mHm5PPIKkqiEFLD2DC1rfM2cuQRTnoBVVMDG7yjkuzg8KOacLdSsb7UDMsWAuM8cvneWVUWu7nLscDj2K63edg3Avn3c6HFGP59m1Y1Z7HQ5UxF5n1WS9VTcz3klqhF3zy1CNH9nFgl6Fvfv47quOxUGajc22NSONl0eHDDU5fQ3B6q9G4cLxi0XLB9db1OMoUQhReFZ6amF7AUIYR1TKeEV6zEW3QIIIejtsCtfFHsdKUvlkoKR8cKTTDIr3iO91Eo+HNyHo7dA/fzspMZaZ9PLed4XGTZk07871NS1VqeJfIOxNSCZfbqqk5aYcVYmh56OiE8r3Z7PP9Dhk2BgyVWz3Rh+ANnnR8QeFeYzH8cAsxrCAvxsdVNKQMpOSxRTSb/acW/7RBiRLnJtzehtNvbs3HmRJvfseOBiGqP4udtQVbTQFOonWjqj6zic0Al4hwI9NBMyf39rZsd2DpvZGgQvgNumYWd4xE5a6k0ibzH9lMesCYpY86VhTYlj4Z9YOXxRbm14Oteduu5vkH/Aom2vjPdMg+EgFL2/IVeAOH7U4oEh0zE3TW600VF11Xd92BnQFhLb6P+X9jHnlMUm1De5m0L0ExXjAYC4KTlmstmaMcQDZ4dJ+iWcRrWHieRn8HWosL/8R7VlT1ow8Pvoyb7fc1RE0YGE1v1BtLRenL3ppF9ZZU2FOTru5hVxewuJSe1GH4GIc/UybG/4C586vA0MFo+X8rWSGVB4u18P5oTQNiDXdjzMCe84Lu/HL36FHS4Xkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(336012)(1076003)(426003)(26005)(6666004)(2616005)(36860700001)(83380400001)(47076005)(44832011)(5660300002)(4326008)(8676002)(8936002)(7416002)(41300700001)(478600001)(2906002)(316002)(36756003)(110136005)(54906003)(70586007)(70206006)(82740400003)(86362001)(81166007)(356005)(921008)(40480700001)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:40:27.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366a859c-f4c3-4ef4-9108-08dbe6a99802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe when uartlite driver uses static/dynamic allocation for major
number based on maximum number of uartlite serial ports.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
This patch introduced in V2.
Changes for V3:
Fix typo.
Move description to above of ttyUL.
Changes for V4:
Fix typo.
---
 Documentation/admin-guide/devices.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 839054923530..94c98be1329a 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2704,6 +2704,9 @@
 		    ...
 		 185 = /dev/ttyNX15		Hilscher netX serial port 15
 		 186 = /dev/ttyJ0		JTAG1 DCC protocol based serial port emulation
+
+		 If maximum number of uartlite serial ports is more than 4, then the driver
+		 uses dynamic allocation instead of static allocation for major number.
 		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
 		    ...
 		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
-- 
2.25.1

