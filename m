Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA97E486A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjKGSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKGSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:41:10 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2116.outbound.protection.outlook.com [40.107.105.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86EDB9;
        Tue,  7 Nov 2023 10:41:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1UD3k9wzYGMmLnNFnvQAVnvPXICayynMA86+oZ/0O6+GUIerBOgNVsdSCHVs6DDajkgiH6/L3Aqxkg4etgd++GVvQfi7eWNXoWN0AXGdrv1+sMlUaWTe3ntc6elAI6HUHJRavb6lxUhP7f4brSimeiXvEKpqH/U5HOKHAHCeZ+EyPVHJaxmbfk17vudj4cMZ8YUa+QwxgP9JdOhWzBzTt3Rpvz7Xwm2jJCqTi6s7uldO82uAVysX2L/3gOleUnDrUxhdcKwfQdkOw9G4JlmKQWrb6xndJbAkHRUFaCFVYDk2paPQnipLZSYBGM+JhlVvn5tg+gKMMhx+0el7t6IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqp1SXYMHIr8+z4EAlVFeLvAfszvFKM+T/BByC7A5a8=;
 b=n284VvqX5JikOeQDS84OsGCiy2Uni99cA8VnfzADx4W03XJ72sNRur/2a0mehP/g4pCg57k6zlZU/4TEKZjrhGPvSX5Tx7y4RgTsMhAvQFfCcsRzSfJ1GAk4srz6EaV8I/kHcXfRductKxk/f8sN65IO4NpUY/GV57mFfLG1Le+bxHtTjzeoflopl2baA3aTnbk87P5Tm3bs1j5Dv6bEe3uZNJnXD/4UDSdcPCNoqMfLIayeaybrFJN4/qybBwlyhvM29tO5slPxtMNeGdln9yca2QORIkERvoGNwvi+vfyj6ijH5PxUDBgwocr6mQIgnmm1AJ3G5b7bsut/4geDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqp1SXYMHIr8+z4EAlVFeLvAfszvFKM+T/BByC7A5a8=;
 b=vr5V8K85EzagvHNRQvyyT0EVo0yddaqzvscYZgD8fWApSiG4HEDuh9jSZxGtuF/wS89mBsIfRDwOCNyFW1s9YM038OGHeR+ARQlx1QNADD60HB5AP1Q4On/CRRppViEXfIR87T3LNRgnLvmCtHmtOef4wclYpmI2OYk8XcjnHag=
Received: from DU6P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::10)
 by AS8PR03MB6870.eurprd03.prod.outlook.com (2603:10a6:20b:29f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 18:41:04 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::7f) by DU6P191CA0031.outlook.office365.com
 (2603:10a6:10:53f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 18:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 18:41:03
 +0000
Received: from esd-s20.esd.local (jenkins.esd.local [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 76CAC7C16C8;
        Tue,  7 Nov 2023 19:41:03 +0100 (CET)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
        id 6606E2E446B; Tue,  7 Nov 2023 19:41:03 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v9 1/2] =?UTF-8?q?MAINTAINERS:=20add=20Stefan=20M=C3=A4tje?= =?UTF-8?q?=20as=20maintainer=20for=20the=20esd=20electronics=20GmbH=20PCI?= =?UTF-8?q?e/402=20CAN=20drivers?=
Date:   Tue,  7 Nov 2023 19:41:02 +0100
Message-Id: <20231107184103.2802678-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107184103.2802678-1-stefan.maetje@esd.eu>
References: <20231107184103.2802678-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS8PR03MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: bdacb6a0-337c-4b09-55ef-08dbdfc118b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u78eZllUofpJDnuZJLpQGOwlh1Yq9/6B15mJhgLnt5HmsPZBeLBPevvTIoi9cF3fAtq6Ar2QbmX84cPaaAc0lhDZZEf33CRcqWZDBVmhKKiiMsqLVTDDerRjQeVXgy5LEPXqr6Ex9S9FaI4NrMo7CTro7RDTGeYjq1EPOPjY5fp0vT0lFDIq56/i+CY2gdh3iJ0ENK7WmZfDD0TaKo3FPPFzcj7sALclrkDI09y/kVRwptmZvVJn69ogHqMb4BotgGKl7fR4VvAYzS8WJF+ZXQyZ2439uoTxndrHPI7jX4r96JzOQKWcdhAh7onosr42lVmrKQg5iGJMASnIrccjuWwyf0s6lsIKaEeSt7aEZ1xRy1bPcIrDsVIK3Sb0e9xuE2MD9pv8yaf1SWGbJu9PRDUsUmtHA9p9y6dZtnq1quEslOgZ3tzUane0b58wHcGCC5zqzc2uvzquEfvu+6vdcFr9fGNVfTc7OXrIboMX5iKMVHEU+aDeswmveBppq5tCTbec41Gc2G0v/wB7qul7XcOFI4204+V7yCSakspajmYcafZkP1pNfLGvlvJayBK6v1PVT3mA4s0PfmYoE7Vi5S+qUbTNzXIDLuzzFZdjHLeuGJyeVu12QZMgYd88ovlXrgHZKi2APCq8884i7WimxxnyARgbYMFDKTGERrER9L976dDYi55cK+6AwDd5PZDaeAU1sXr9WMUaCRHJYp4aaQ==
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39840400004)(396003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(2616005)(336012)(1076003)(6266002)(26005)(478600001)(8936002)(5660300002)(36756003)(4326008)(86362001)(41300700001)(4744005)(70586007)(70206006)(54906003)(316002)(224303003)(42186006)(2906002)(36860700001)(356005)(40480700001)(47076005)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:41:03.8117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdacb6a0-337c-4b09-55ef-08dbdfc118b4
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6870
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

