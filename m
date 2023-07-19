Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC07599DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGSPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGSPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:35:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CC8B7;
        Wed, 19 Jul 2023 08:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7gDVBVOprph10J0P/CL/WWC4ke4w6ERIGnVw21wAd2ydNicuthxEsRqCB+cMAPWUwHzMtZl6tYaCxaFzBhH/BY4FgKRW9Dayv1irCS8EimYWO08z+OfbGwqaQjcJiNYTjDVqSGF/qRhhay+JyRAf980muQQuz/syZa+eYWZP41FkDA0qz2On50ClY+iGvKZab/g+hCoUSQ/7687T7nQg4C8fs6FjBB/Xqbevnuz4kJlVZ1ekj8TvlhnXMEHzysnyipaJplgU+9ap66VZ9AXfjQZ28WuIAYXgp1zq0B2Kp4IEmGoFWxU2xhGWRGU+dpbEaDZqcgXL3GDR8ZcoikyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iimuwI233p1lJKOpfdYddROMKOqlCEyj5OpcRhIFN4=;
 b=AQcjwMbcbQtK8wjP8kol/VE8bq8kRkRM25Fa5pwXuyJSBGfJhW+6pceXNEdXw+COt3dungZ/uufwAZPrXSsVSengQkPzMo58CZTA29agBkYFyUFPRnz7aK2ULyIkKrV6914RjyXMwo/o8ZoMPoPbl2vyOsLlifSUhhlTqwPiML8jTCsjdqnscdJAcHyW21YlzNJwRBPkOBYl8aDIA1AvSqu5PvbmfndwUx7Rd2IQXHpHVrSxk0OtaMG6IDeZHZuAQoJUERON1x8v9Qpy+CH8eKQq1sZLeRerlSJ/9JbUTbvERgXOu0UoUFi32sRcpc4KJg+EpcMq42tjkyWUFyTl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iimuwI233p1lJKOpfdYddROMKOqlCEyj5OpcRhIFN4=;
 b=a8N/GQqJPJIfPk2t3xpM0ojKvmRlClZvrMXzHUaUtsa9Mzti1rlVZ/6K62qD8VLULk7LR1WOAhwOirOeK/iHxPfDkZPcQXYzYns5Fya0yZYjX/3187pf+iWr9WrBbC2+JdejnEFwgr5wSRcqMMyqWpcqh03vOLPLZNTBVWJH+tGAwKcOjavIqOKA52JmkDCEPtsklerbDvQHPG/oLaxy4kIEpTafcIw0whJpPD5bXX3vQsRDsvNGssw7LzaK7+W1RKLU0yP6Hx5BOz/ml5da4w9RqvM+LjzGNpaiLBimyIekN2ge7R/mip92Yd2ZAb5bRinCpfNl44zPPgTiCBF5PQ==
Received: from GV3P280CA0075.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::24) by
 AM7PR10MB3350.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 15:35:35 +0000
Received: from HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::17) by GV3P280CA0075.outlook.office365.com
 (2603:10a6:150:a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 15:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT025.mail.protection.outlook.com (10.152.0.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24 via Frontend Transport; Wed, 19 Jul 2023 15:35:35 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Jul 2023 17:35:29 +0200
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
Subject: [PATCH v2 1/3] watchdog: make Siemens Simatic watchdog driver default on platform
Date:   Wed, 19 Jul 2023 17:35:16 +0200
Message-ID: <20230719153518.13073-2-henning.schild@siemens.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT025:EE_|AM7PR10MB3350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f844089-60e2-46ce-7a80-08db886dcbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uaM1CEc5L4RnYWA079jlf4vKEBSo2RuHKqTzLAUu0IRkIvbRZIs9iksO3ewh+sbhaNihfK+WR0qxzRK5PJmWMR6fpmkHlZxLo3upab2dObUCd0bsOw3ynAS6MsDdT3kqLHiSMAsJV3w5+uj8YpMILju4bd/U06oP4z9SmaZu45ZF2JmH9U6CXwbeq0yi9+49q5ibL8bRduIwjaz61xNy4mx8eMwvb5o9He9q1kuNAX/lhb345EWzebizkDF3v5SAMIyxuOFQjvGcDSa6BW14xAlWyTkhLHKUODc8fpdoAnUrjDB9WmJtTx23wPVxmrSDBpaqpRu6hans3tjCGV2LvO7qLvTpuoEMxEAEHE3na67naDS1qvWU906HHihmlguCeJL2oVtX4wX+W1XRPunxcYZ9F1J2RTFdFi95A2DVp3XGRj6ervVy0lurOozSO2x3cyUyGQT52r1cWMvUCxmoROnh6Iilj1GKG7ZVeKAaRXGTaEwKOh+G/7JXGnI8Ug9EQuJph5DJHO0rC//dQHuDckiv+O/aUBqNKDhkiimA0Nyp9ws4Rvub6kEkCefrM/IEKh72udQsSJ8W8cBOXxn7gTXHolk3JbWxhygtJmhnmLnbQ8zJZySiL2jPYrLdlQfGmCA6Sm6kwHzlKB/ZHJB0VJPW92WUYowwQkZNdbrC3W+YYAfJDRF9pFRfcxv7UMeLvDOIuXWa+uLwoEMjhj8zUfF17DfBVYr1A+uARnOCQLA55iH0KObBd/cli8DRGAIR/K3KLPOFJQbmLEyiaLE4A==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(336012)(47076005)(956004)(2616005)(40460700003)(40480700001)(4744005)(2906002)(4326008)(110136005)(8676002)(7416002)(8936002)(5660300002)(41300700001)(70206006)(44832011)(186003)(16526019)(70586007)(316002)(82740400003)(356005)(478600001)(7596003)(86362001)(7636003)(6666004)(82960400001)(54906003)(36756003)(1076003)(26005)(107886003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:35:35.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f844089-60e2-46ce-7a80-08db886dcbbd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3350
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
likely want that driver to be enabled without having to flip more config
switches. So we make the watchdog driver config switch default to the
platform driver switches value.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee97d89dfc11..04e9b40cf7d5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1681,6 +1681,7 @@ config NIC7018_WDT
 config SIEMENS_SIMATIC_IPC_WDT
 	tristate "Siemens Simatic IPC Watchdog"
 	depends on SIEMENS_SIMATIC_IPC
+	default y
 	select WATCHDOG_CORE
 	select P2SB
 	help
-- 
2.41.0

