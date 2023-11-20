Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8817F1BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjKTR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjKTR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:57:09 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2103.outbound.protection.outlook.com [40.107.15.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953094;
        Mon, 20 Nov 2023 09:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5V8TqNtP9BijMbt/rTTWZhXT79KRh/gSBbud6pUkZPsa56g1OFu5I0yXSfqJAaQcdofiaUqAe9NisuyZ0kLBUazdRbJmii5bP6d9U4WTqFXVSSLXWEBwbR3uXLFKSyHRnh4K5Vp1U/j8JgpJ53Z/9F7uoeOXuUOqtxQ4M5I4pBdjCN7DTVSpbC4tOsSaZrSKkOe1P3dA5RaIntgzwutpq5HtoRidTYmnlet9t79HoFwP2m+KgbA3Z6W/rxAmU5p8Y/K424HHgZK6uFro9rlDABwpqtl+FCKke43ph3in4+r0tCDDqGdHgc3q56/O/qSKS1xg7Rk0ta8PXNUALRgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqp1SXYMHIr8+z4EAlVFeLvAfszvFKM+T/BByC7A5a8=;
 b=aL4aZqYf/gmmfxEUxSVONJYO9GoMdrOM9hKmNE2dAcEn6/mWoby/K5QKCQCBwSjj+GASqQ4tsi5IsrC7HHWP6ZAKMGhbkFXsBS9/XX4DLXCRCQeVU/c5WhQKtKKnEsfiss2B7AwVOi3xVRS1PZVZFCa80kOMYD3UCBlVejFJUkmwqJwmhE39BrK+Rb7bz3yuC+mBZS9UKNtjXIrrKNDdDiD2dz69FRCKqENZWqfCUyb7s+HfDyncJAevy/ymWO2d9+C9OB5avnepAdIdvWS/UGazviixE+ywYgvA/ShtiYGpP8babjfLQGm/jK1Bo18tcz4W0rjfaaLLtOXmI2LIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqp1SXYMHIr8+z4EAlVFeLvAfszvFKM+T/BByC7A5a8=;
 b=WnIB3K6TLwUQnfMaYHV32L0GAJB+lgAP9IzbeQBZsxCPWgnQXAzsdvkcmpifXI1nUL/wau9UR8LFqdTgPQ+MWsSWoVgRoYmb9d98cuixvFj/FkKLZ7MFN3dRswzIatcMmwIFNEwtni78SyJqpl25mjvp9CfQxQpJGvSKY5zopYM=
Received: from DU7PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::21) by GV2PR03MB8606.eurprd03.prod.outlook.com
 (2603:10a6:150:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 17:56:58 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::c0) by DU7PR01CA0014.outlook.office365.com
 (2603:10a6:10:50f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 17:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server id 15.20.7002.20 via Frontend Transport; Mon, 20 Nov 2023
 17:56:57 +0000
Received: from esd-s20.esd.local (debby [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 19BD47C16C8;
        Mon, 20 Nov 2023 18:56:57 +0100 (CET)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
        id 0AFF92E473E; Mon, 20 Nov 2023 18:56:57 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v10 1/2] =?UTF-8?q?MAINTAINERS:=20add=20Stefan=20M=C3=A4tj?= =?UTF-8?q?e=20as=20maintainer=20for=20the=20esd=20electronics=20GmbH=20PC?= =?UTF-8?q?Ie/402=20CAN=20drivers?=
Date:   Mon, 20 Nov 2023 18:56:56 +0100
Message-Id: <20231120175657.4070921-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120175657.4070921-1-stefan.maetje@esd.eu>
References: <20231120175657.4070921-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|GV2PR03MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ec95e7-d778-43ab-ae6e-08dbe9f216a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAsdNxjyGGvbKtxpBZgFxPTSzVOSD154cg2HS2pnr6ayErBMXELn9QcMZ1kOD/0jUH/uIfREnuUNCTkiX5KxkEMRAuz0e21UIXoYWO4QUVgmcPhdu63+jdDmTShCoMe52r9Z3WAs4I7vvq7jtmBQavwBna4Ri1Acf9hs8xXfG/vGkXL80t0QqHZ7DQwyvpQtph2IBaR8sJ+Oxe2++93rWRACBWxVVUpDrO4vpxGv2u/0djaro1YaYNbQAXJpnPGo3TDFhIPTNfe/MmWQzpuFoqYn3jkbW4K2lKIv9Pj7Zbu6QRfnaysqCTuEnfCTs0h78CBqjLcpAtGyLz9r1kdDBf0AKCae7kzJGKnAKkpXq/UzTkviKiTsL45v3bQDoKz17uP/j48k03FQ5bSV8UUHHKduddssPVPOx0p4rL5NOLP6jHmKQ/SzC3Odkjw9NgHvNYz3u8xsv/ITepfNz7vuwxujG0hslKmASmQzO7Ien+5fFqWxIPokB9CYD4eTRrO99AHKSPdYfL9FGFm6lqpHhqFaE8ZXYaNZtNzQkocQsypz3JzTiwW82DpNi7omzZpKNzK88Fowsh8HB271UPuSWXnZcQrs79iqUaDS+TgtIKST582q1Tq0SbHpfDTAjgv17qec2mBDW/tPyWAZaP2akY/EnyjRBHpu0tjOqBwr8+WkSg9f2ThKi5X+H87BwplgeFqQ761wqetacq2K+yticg==
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39840400004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(46966006)(36840700001)(81166007)(356005)(26005)(47076005)(36860700001)(70206006)(70586007)(316002)(42186006)(54906003)(40480700001)(4326008)(8936002)(6266002)(1076003)(2616005)(336012)(478600001)(5660300002)(4744005)(2906002)(86362001)(41300700001)(224303003)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:56:57.2859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ec95e7-d778-43ab-ae6e-08dbe9f216a1
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8606
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself (Stefan Mätje) as a maintainer for the upcoming driver of
the PCIe/402 interface card family.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03011d7ee087..7db1bd399822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7753,6 +7753,13 @@ L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	drivers/net/can/usb/esd_usb.c
 
+ESD CAN NETWORK DRIVERS
+M:	Stefan Mätje <stefan.maetje@esd.eu>
+R:	socketcan@esd.eu
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/esd/
+
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
-- 
2.34.1

