Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EC7E6AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKIMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjKIMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:36:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE622D59;
        Thu,  9 Nov 2023 04:36:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jawHYd18qCmR5/JuAbGIlQqrirbs4+bcC7vzDEl67ml+JSYijXeCQWc9drgw2DV60DosPUXdfl6j3y2lO9FuULFINENwZq9rFR+nQQeI64tSHeehU4aGHHqg6quXun8i78R5G0OGSaAvYd26RaIn70CmAvA2Z6CunNvYghctalxRWqnLygimWPBYSykxiwmSU/b6/p4PLMbyW9xACku5VN4fO8Tl4TgnVDX4uxHmmdj1v8bJcZyorTF/vYRxn6RsrEUxOBl8PLlomPVhJC8ObBD3ibtFXaIPQZ09HjWt9QH4ocUjcHbnFiqqj8Ot2t6Yi0iuv4LtRXsSQb7rSeFWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkD04HxgpRGiYc9+lSUHYR2nmHdzvYq/JR8z6G1+3ts=;
 b=gXd4wpHuqOyyxcerZO7CimxFStO4UWYdQLI3zsOt1/oNUuWlGS9gl6rn7o7BzmgP2tYTihBirJWtaacbvp0H46k5iPmCauZYG2w05T2ld6AcW2/daqAj4Zcea98zYyJAkBoQvPivWilZizo5gmZ1m0eMDDHFkulryN+r4gABu+d9pd67rtYe0BccGHoHXKvj59/ujv1JQKaP45SHBFVgKF3VXReIUYnW4hRFKfiz2OP4Mh8zO+vNHsUr11iFEfmaYuN4giMfl9JvY6bFzjyxQEjiNMS94Ge6X/2cSyZjti/jvASbgyNKctcShKA95Wv8tmEtopp3KudG+8smED0JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkD04HxgpRGiYc9+lSUHYR2nmHdzvYq/JR8z6G1+3ts=;
 b=kMGfKk6awqHA60jaKBjZbnkUy76HqO/cmFTt3u6VWFFN+iJVFqu22pDr08l7XaHkAG0CEwdGr8yZIzfP07Ys0pOX25G4C/El+5tAZ0VLKagKyF9DlAhUKRIZykFTZ6ax9iwSnH3xyaM0ZcescovxWT7prfTgswXcLmhJwMIw6/A=
Received: from MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 12:36:49 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::78) by MN2PR16CA0064.outlook.office365.com
 (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 12:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 12:36:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 06:36:48 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 06:36:45 -0600
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH] serial: uartlite: Use dynamic allocation for major number
Date:   Thu, 9 Nov 2023 18:06:40 +0530
Message-ID: <20231109123640.1740310-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: c7adf5b1-7206-4069-2299-08dbe1208b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PF46qEESESBlU9uyKGL92zM6yhZVk236dVSlFV/g3yWw0prT8LJfAHXpQqD/9UwxxjKM/gx0hne3FIoZsi23JuGvgnFaic1uwZsBhEFMrdbDbO7hImnqyvAWGuOL7JQ71ehARYLsyecuYjAEzijDy6JY6lNxzPyW85+0HlGbpkZ5ppUleuUem9TGcEL+lJvpo5knS9NqceXWDlJ+Dx0vpG0Gwy8HBq6+/zFp6gqeU2jp5mUDGXYLgiuguxz/r6AMF9oiu5l2jefLX9fMKPxZ+oVtgAbJBmmrxZtC/JAVNyGRrA8LlkxswZUWsSedhoceGtam3DIv1dDvt9TJAp/8n7IAuEK7/JXIyWidLRN0EhaEYt8yBnxj7PWChNc5SRZbHzPBYDk+ThwaKL+YCt/S+XlBDF1BIrvqdk736+ZIJH2iQmumjyTijnDEwPAF45v7lYyB9Cj8k0+RWb/8PrSYK9IL0U+BqM3Aah1gTYZai/Fbb25IIfzixw+yXVEncgXMIzCKEu9UOcDbPcdm5mcDxm910p+2YCoLGWs1BF9ZCFyCdiU8C3mK01Qiq93nxjjA1sw0kDEytXlVqyDtVwnnOI4E8F4U1iY7m8x2kcoXa0mW8jNf/HHnAE8EDDc0p+oPtBRPItzHZn0Hsc69wqgRLMcdwi+9mRg4+WMwFK23qIJnQFhe1eqDm8YdYXZFEKZHyzrns147oqhc06b8gp2LAAnsPSdww/8iLDTD8SxJn0YrHIY5VQpNQkvUc8Yk6LBzew+kkdbdSy2VTxSr2Lsp6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(26005)(356005)(83380400001)(8676002)(4744005)(36756003)(8936002)(81166007)(82740400003)(36860700001)(4326008)(47076005)(2616005)(426003)(336012)(2906002)(1076003)(5660300002)(478600001)(40480700001)(86362001)(6666004)(40460700003)(966005)(41300700001)(70206006)(70586007)(110136005)(44832011)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:36:49.0554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7adf5b1-7206-4069-2299-08dbe1208b0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device number 204 has a range of minors on major number.
uart_register_driver is failing due to lack of minor numbers
when more number of uart ports used. So, use dynamic allocation
for major number to avoid minor number limitation on 204 major
number.

https://docs.kernel.org/arch/arm/sa1100/serial_uart.html

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..c80ed0373b44 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -24,8 +24,8 @@
 #include <linux/pm_runtime.h>
 
 #define ULITE_NAME		"ttyUL"
-#define ULITE_MAJOR		204
-#define ULITE_MINOR		187
+#define ULITE_MAJOR		0	/* use dynamic node allocation */
+#define ULITE_MINOR		0
 #define ULITE_NR_UARTS		CONFIG_SERIAL_UARTLITE_NR_UARTS
 
 /* ---------------------------------------------------------------------
-- 
2.25.1

