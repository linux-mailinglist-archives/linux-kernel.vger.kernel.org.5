Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D747599DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjGSPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGSPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:35:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F9BE;
        Wed, 19 Jul 2023 08:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAy3bjby50/GnjTu4eJnxh8fWTUWWYZvfbLcGVZX3nkIjMPNQ9keQ7JJ1RKSlvgBsOOQK4z3Hyc8a7Acpva5fqoJjFhg3iF18Bl/OJiQq2Eb+Fj9FEhAue3vtCK9Yef7GyRAyrWg51QqhQFrL0BJ5GarpQ2YVlNdLs+Pe7AQkbBygmiX7d92fiAu2+T49kX1fswCxGYJ2rg0UcfxNlC2Ny8ALtVPIVlridk41N8cTtFYU0FdlUVCrwkN4eTU8c9Goy2e6iOCFWiPpN4vJRF//fe9EIXRRmJzHp0+XN3UR0kayzw62/06YNWbzTqYC8PcNyBc95vtyCE24rEVvh3Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYgkHS6MhJEFqymp4OhhqkicICgB5/roHN4qvz27Hqw=;
 b=DMnyom5XjdQurtrW9j+z0MP3XJ2TLzEjMFtDmEd3zfve/9Dio7FLYtGR8IQLkz18ELUNmnnh3E8qckB6fsoJKgQ6GsKH2JbD/6d+t6YXAYdds2qkZpkPr85WRZafq30e7TvO1VFhHCUy71NLYsv1NFV3JeqnqKPT4URki0mCSLz/KKnU/b0EuQGPGM9xBsu4pWn3HI3kUMUms5jScnvIqQddpWbj8K7cpPvZVvCrivXyjJTMu2NY3k0/2lL2TUscNSitafilGC9ICMzJoVTzwWX2NqxYYdM/NJuiSNBTKup/jaezHRfvUBKFQOnEMW+5IxUYQ9vx1OtMCIt16J8wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYgkHS6MhJEFqymp4OhhqkicICgB5/roHN4qvz27Hqw=;
 b=lFrVZGdC36CEJV+Dw6FFIJk6hoLYy+ryqkKNZsHB1s5UrCobJygrNrZItPL0Zlwm3tiXMuC4lifE+mWtvNsWcfybxTKuduiXQSA4BNzG4Sabz/M4SrST3cBMx2ro8Y5mKjPBgWKPZwNMxdFTzR/8k/bQb2W8/nI9WjmCjdQ5xiDg5DHvypE6B0Ka1qLDk6yy5CRQhjNVRox+seFbcJyFKd1fLm5oRTAdh66lNvTlea8pep83TbVJiY5E3WXjq5o5pw4lpcopbn4rcHmOO40kdHWUEnKmMbY1uslLOaXnS8uO8DOUzxxJfdRwQk90dx2WLx2xOYYeZ93z5RYU3o2oiQ==
Received: from OS6P279CA0144.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::12)
 by DU0PR10MB7213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 15:35:31 +0000
Received: from HE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::9d) by OS6P279CA0144.outlook.office365.com
 (2603:10a6:e10:3a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 15:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT089.mail.protection.outlook.com (10.152.1.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24 via Frontend Transport; Wed, 19 Jul 2023 15:35:30 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Jul 2023 17:35:30 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.175) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Jul 2023 17:35:29 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 2/3] leds: simatic-ipc-leds: default config switch to platform switch
Date:   Wed, 19 Jul 2023 17:35:17 +0200
Message-ID: <20230719153518.13073-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719153518.13073-1-henning.schild@siemens.com>
References: <20230719153518.13073-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.175]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT089:EE_|DU0PR10MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: caa474c7-18a5-422d-308f-08db886dc8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMUUXAiyOHDTzha3T/7yJixzLrIEGn9fVTWa5SSTnfOW9gOVPL8mosnYx/LS8arzP++quTc+jRfeOAn5iOEpevbhgVVl9ytfS1J+wrlfc30YxTfu8tZhcPV08kv5KZQAuPJEylYNTYobQ4F0rFlcjC2MgZDA7UfiasTy/myL2pHrdxI8orGeIlQ4IbLsNwq//Pe8ptoECmpx1Z0PXqyY43ygji/e8DIeXiuesd7fq4oVNApQEfuM4G7opx0EVFodaWoVkHMWm/MGMiTMv50htc6XglMSwc7AITky4fWW4MVOZK5GtVvt/S4PkN8zlSYg5YQzeYBbtQzpdiSSBtIRqgTOd3aZxi4/hloJN5MSJubYPBTpT3itT2DWzuAqw5DyknGrl7LvchIJk6lsvfVwTnJlAoAMXO/d2hqZ7wkw1pDYt11HomfCdeFDwGJ+JuoDE5Ntw5ilhOU9EWEdfI6jwO/FE26z/3VMgK72s8uyoj6iJP2CHf36rEzY8bz75i98LUdSv2laqfXYbbe1H7kiCCYGVOQCtaWNZsLPSNkD0491mi+0BvOrMiPx9t6mEzbP5RREQb7+DjgVoQWmG6cUDvw2zc8UfUmy3AYx3NlTTCGH3OeNYEwQsiWk5BqjKQfTeMZmC6R4vqsVzqApdikoh+fXJ5SlKo8tftj0QI8JE+umX9nmAfBk/rC2Ol48JFx9p8301R7tTtoI5dmW+QjVF7NpEnOEs9PzwJpmVET+EICc5Lm1h/FEc1x4t+f4/oWsHhePLmfhXDDQTw+v1Ev9hP3tp0jw2/xN3i56JPFPHpQ=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(7416002)(86362001)(4744005)(2906002)(36756003)(44832011)(40460700003)(40480700001)(2616005)(47076005)(336012)(16526019)(186003)(36860700001)(1076003)(107886003)(26005)(82960400001)(81166007)(6666004)(54906003)(82740400003)(110136005)(356005)(4326008)(956004)(70206006)(70586007)(478600001)(5660300002)(41300700001)(316002)(8676002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:35:30.5985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa474c7-18a5-422d-308f-08db886dc8ee
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user did choose to enable Siemens Simatic platform support they
likely want the LED drivers to be enabled without having to flip more
config switches. So we make the LED drivers config switch default to
the platform driver switches value.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 44fa0f93cb3b..609e438af9f6 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -2,6 +2,7 @@
 config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
 	depends on SIEMENS_SIMATIC_IPC
+	default y
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
-- 
2.41.0

