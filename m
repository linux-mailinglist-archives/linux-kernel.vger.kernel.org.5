Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE87F4BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjKVQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjKVQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:02:20 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2118.outbound.protection.outlook.com [40.107.14.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7292;
        Wed, 22 Nov 2023 08:02:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ysb/0cgPfEk6vJsWEECgLp9SMpyorNs7TRJlBUnbuYQ2F2YWjKWUppXlDSqi6SAlswFuf1BkzB6ynJcByHX5gyCpC6OwjFR4XKl8QtIsd3hoDxu3PTtSwJ7uXJheyOLyvvG0z9+JQLSCXwplU9UiwV6+vtaRZ6l1kcdXkx4E7FgXUaIOsX98+0KX3i+cvBrM1ZB3CcS0p4P3dpYrwPG8t7hW+1UWI3BDxgamDFFwDl0YvBT5ceM2/DRXqCBXWKSRaFHZXLAw2fQk39YKK5hsH4Pq3fiqWqxWMD76cxp4gb72q52bx1PoL/t5av8gg2CRilz9fgmqsAZcZr0LmUZ62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvN8cJtizRWnTNXSVnlR/KV9Bt99u96yKdNowHZatMg=;
 b=DAX95zwaKBeVH5D7sM9o4IL5dqJbUY/2KEhWJ0C2b9bR1Rxm3prcJIYVW/E36CDhJ0mrl+q+1YlKrjjK/d2rFG8EZOVSmzI32K+ONMt8eGZdI8Ri9oQh/vsEDY5c2XOI2y4ketj0mzAKWnYCugyGacBY59viElDe1f5yIyDselMMG19znrwQ+DdTObpw2kWxF+adOZRr/u94O3FClsgQ+o18qx62QU84Kdb+3IHVOh1MBUm3n4lrGPu2ijRzQmlBvyfiUhg/WCVimRLsMrRgh5xqDjaMr+tK/J6ZtpqR5pVqH6BJddOhQW+fGM3FdaAv7HPG+f4PtBqVr+Ip+WJWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvN8cJtizRWnTNXSVnlR/KV9Bt99u96yKdNowHZatMg=;
 b=vJX8ojB/CkvyM70r7/l7UVbJSPXz0UD7XhIBHJn7zrIU8y805t3kPmnLfPDA6EqaV7jgVAUZ3zMX4rvPK4/ko7ILFTFgy9OFiINWAHNcVLkZR+CQ6903/PfDyai+SRztKQxRkeeJxsnec9VdjfOx23FBG2fo4kyTQwAMHX3lih0=
Received: from AS9PR06CA0031.eurprd06.prod.outlook.com (2603:10a6:20b:463::7)
 by GV1PR03MB10347.eurprd03.prod.outlook.com (2603:10a6:150:16e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 16:02:12 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:463:cafe::ac) by AS9PR06CA0031.outlook.office365.com
 (2603:10a6:20b:463::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 16:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server id 15.20.7025.14 via Frontend Transport; Wed, 22 Nov 2023
 16:02:11 +0000
Received: from esd-s20.esd.local (debby [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 87E667C16C8;
        Wed, 22 Nov 2023 17:02:11 +0100 (CET)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
        id 732702E474B; Wed, 22 Nov 2023 17:02:11 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v11 1/2] =?UTF-8?q?MAINTAINERS:=20add=20Stefan=20M=C3=A4tj?= =?UTF-8?q?e=20as=20maintainer=20for=20the=20esd=20electronics=20GmbH=20PC?= =?UTF-8?q?Ie/402=20CAN=20drivers?=
Date:   Wed, 22 Nov 2023 17:02:10 +0100
Message-Id: <20231122160211.2110448-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122160211.2110448-1-stefan.maetje@esd.eu>
References: <20231122160211.2110448-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|GV1PR03MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6a78ae-0519-46ab-0801-08dbeb74634c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tz63PUk8zIPkS2rnOwBIP1VOhD05A0iwr8z2XV7dNmi6ynYFvrTWXjj7R4wSR5rxVeYbUdSVLsXejch9ggrQ7eSTvYM1HNhtRuKnG6Nwg2jxZzDMFrNIlJ1UuZy/jCTADeWALWJ+yCdJngvarZoT8uUWJrt5S6YLZNVl1jpMNWpKVj3uiiCqrlZk7ldY7IpSH/R1EskpEGFLqur1LFZcmfxu0BBbQQVsF7to6if4mliRSVoHakMmuOM037wd2BalJVe5lJSrcPjEyXtnLQ0D3Gp3W3mur49gEPzSwt/XMh2ZAqgvuNu5KGNICwfmOyT/jUQuGr1QDtfiwMfK01sG3r+EKdyaJ8iDU/EFlrCM/SmMQmLmfAgaxAshEBgDbL8Mz+jvhGpGYIAopHhc4bCTeqRX7Rq3acmddPIONhSX8J0WXpqw47HDvCoOt0LllU32tDgx3MMq6r76jpzadUdc+yZw6yNGNr98rk19W4x9ZzDQKssK1AcbCaPFKBzsV6qMBtswxgp7QZ1BF2F3pELgHkPqFcOb1CSsDndxL/rg4FleBM1JFpR2UTYySjFG5E9DXMy49EbK5YEzvjmOP7orsiWaJ7BmbjK4Q/SBj5i+7GvOd3FZe5g05oN60Mp0ncWigFd0DPDM8eJGDW3/7UafU4KdmRfuK0WXUZ+JkxLsJS8TXg5ALAeSQYc4xIXCDrWy1Uj05p0r7PYWZjqEewu8Jw==
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39840400004)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(46966006)(36840700001)(86362001)(41300700001)(356005)(81166007)(224303003)(478600001)(36756003)(36860700001)(2906002)(40480700001)(47076005)(1076003)(4744005)(5660300002)(26005)(2616005)(336012)(6266002)(8936002)(4326008)(70206006)(70586007)(316002)(54906003)(42186006);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 16:02:11.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6a78ae-0519-46ab-0801-08dbeb74634c
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10347
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
index 03011d7ee087..0c1da1eb7619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7746,6 +7746,13 @@ S:	Maintained
 F:	include/linux/errseq.h
 F:	lib/errseq.c
 
+ESD CAN NETWORK DRIVERS
+M:	Stefan Mätje <stefan.maetje@esd.eu>
+R:	socketcan@esd.eu
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/esd/
+
 ESD CAN/USB DRIVERS
 M:	Frank Jungclaus <frank.jungclaus@esd.eu>
 R:	socketcan@esd.eu
-- 
2.34.1

