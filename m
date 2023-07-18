Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C57579A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGRKwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGRKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:52:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F705E55;
        Tue, 18 Jul 2023 03:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN8ZckJnWWS5h3DYMWVjySpAZINcOqiqpzJGVox0nn1C+oLdtr0MfvfoIUC4ONYjtV01iCdT5yOPEvf5mhZ1OvCXFtk47uhTsPcnixbjwqQeTsd4zsXhu9cAz9Qv+Auv86S4sgDr/H/5Y38ujFTX+fJMcgiQoJZCCofLiFzUKHcRjzUw+1JXXufZ05l3T/GcWzXrYRAI7QwVVlY4ukVITQw5K+NYTG2zamJNZdPEU49uDeo7zwUF3hoGtVEw61bwh8aPqPMqc+W8r2qH8dvwt+V5inqRpIR/88kP4bS22LOKqhgbXVDBjBwfXN3neRgicpfrLMwI8XfZQHd763WLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOHWYruqH1wmxUwCOYky9RSKCgy+fQj6FlkVEwfjz6g=;
 b=RiFEKCQccodFcpv+EjkDAVGROKODLxxkvGRxg108jzR5dzzVhz5qZKSdnPVWPkdz9brTgFT6k7Kfe+AkhthR9RBzV+6gk+b4Uz2HX+4FbPBc8zbT6tb+ww6TZ3hgcGeQwoPVpw5BVyxTArFWk3c0J78Ays+x2roMGD1/hfJwNEwTuX3NvYhlDjK7TY9+SDo6cMKhNeSQHRi6CZUG5SpYcIFts569CPdsRnVNfWW1aRdA+XP9xc46eQAOq4R0HrZ65APzSZTXmTEZe983zAS1gp4DpBAu8W3OuEtxaxVeV4FsJ44FebZDzbCOfmTY8BMUALsmAUaH6q0ItHL3vCxAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOHWYruqH1wmxUwCOYky9RSKCgy+fQj6FlkVEwfjz6g=;
 b=wQWHGpA2NctaGbNbl9+Bm316AjNJ6m/2MPpyUsRzGUJFuMb+lSnRbfEO4+Xw+7k46PlDXBcS3oKW7Xmpl0DhywCyPAtD9HdKp40Pld3MW90N4QwvidM1WJ+F4SE+2jIHuOpVts6hc+R4e/XQ5er0sbkOXLsEy1G6hNpTuRt+ewukUItm4Lw1RZ5YTu9e3AZFsqcnyxcIe71YD+ImIgq4H1Ne3EONCSDtlNfG6GmbJU0acUduFFoSBtVZO2a4aRvBVd/UBu2WDQoO+c1Y6TN9yV47x7BoasJqk0c12/Isri6Mlj1cpvn1sO6H8vSBO7ZogjZ92S170gDTO99hu6gfrA==
Received: from DU2P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::30)
 by AM7PR10MB3237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 10:52:26 +0000
Received: from DB5EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::62) by DU2P250CA0025.outlook.office365.com
 (2603:10a6:10:231::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 10:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT050.mail.protection.outlook.com (10.152.5.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Tue, 18 Jul 2023 10:52:26 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 12:52:24 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.216) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 18 Jul 2023 12:52:24 +0200
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
Subject: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver default on platform
Date:   Tue, 18 Jul 2023 12:52:11 +0200
Message-ID: <20230718105213.1275-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718105213.1275-1-henning.schild@siemens.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.216]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT050:EE_|AM7PR10MB3237:EE_
X-MS-Office365-Filtering-Correlation-Id: 089f9b98-112f-4ccd-3284-08db877d1355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8MujpCuAkUEv/TE91I4EFCHjxJ9TZlZ2CZ0/HUlOWJim7y34dxEQ+72EiDg1K1VRJ0O8KOcWCkkHGZMOO0B8he0nR/cP5c2E25mkqmGdIDH9gBmaUfT8bIPSl+jpzh3uw7QPDrjkr7NvZuqFFgmRq00Llex6iIuozSgo7kwt31Z+GnRtCdnl5YK/GvDorUwio5yur74kwN1tgAKnlROvORHQUV51R0FG7P2wGnFYhbP4eLxry8PwBuWhSFpJVEZaGDZ6loHAP/SsO4Q9JOdym3Q1ApILml19R4FKFRp3T2/7OVPksCBfJCNiCOMx/GVGc98UOxu4FL3vFianhMCS0o+ShAFvBGoNheYH0paVvSQdF8knjBxjZSlcVZ9Qqh3jzo1QTUw1GPHK3UVtdn6rBh5SmJyMB1yPNeFw3iGe1+75R7bIQbLLoEAuMu8QhEr/3s79ZSEjcB958jXDOpWhM+ZGc21Kvd9remDIfAvyE05QUrpQ0pJnRJjxd3C8a6WmiUi1fTxo/7CflywQCluUIIw4ausdROkHM8VjuFhOpSdpqHoQJXPpbU2z+gABgo8P3za7+AeQwH4jvrvS82IF7cDYw49sec+FrDvzRabuNK4tK8HMNtzxnz8uc1H38oe84aPsfkqtqIzB0IcANFobFmprSYZX2wi24JmdKjHhR0ywtmNmS02g0aMzrBpG1Phu+DGibUVbBOYm82kJkGhi8j55fZ4K4wp8eM7kWRVp7uLFNrPgilh6ejDhB1od9aviT2dkmVHip3m4IsZKaw+4qE6NRZW82VrzVBWnKVpboY=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(478600001)(70586007)(70206006)(54906003)(44832011)(5660300002)(4326008)(7416002)(316002)(8676002)(8936002)(40480700001)(2906002)(41300700001)(4744005)(6666004)(110136005)(26005)(40460700003)(107886003)(1076003)(186003)(82740400003)(16526019)(82960400001)(956004)(81166007)(336012)(2616005)(47076005)(356005)(36860700001)(36756003)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:52:26.7287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089f9b98-112f-4ccd-3284-08db877d1355
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3237
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
index ee97d89dfc11..ccdbd1109a32 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1681,6 +1681,7 @@ config NIC7018_WDT
 config SIEMENS_SIMATIC_IPC_WDT
 	tristate "Siemens Simatic IPC Watchdog"
 	depends on SIEMENS_SIMATIC_IPC
+	default SIEMENS_SIMATIC_IPC
 	select WATCHDOG_CORE
 	select P2SB
 	help
-- 
2.41.0

