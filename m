Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326147B5B75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbjJBTlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbjJBTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:41:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2216.outbound.protection.outlook.com [52.100.223.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0E2AC;
        Mon,  2 Oct 2023 12:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwILTPUvJd7hxrBT+7uFibQZPQ7SyJEIr3SoL39GzYOHGGY0oxgPIU+ofBmSnUjGhQhRBt/ArEJvyYlwTjjxJU2TaX7N7BKLE2CgVW5fjHPSpDloSEC53F//m1FfB3LV9cDbWOUFpQ2aIMklxULbZbjH518w/F2h6isauOgaso9bulrTym4pqcE5JkFfDfcbftJ1tEDLGcwaiT7U8sh8yecNOUQUNpNus6UfPN1fLUr2ZUHZnCbAc8slZlWTV3vJ8aEXaaTOZOWid6QrW7RPLpAeXU4dQln4zpcIoRB6Jlpd9UcAykYNzO0GatNUfxNB9jhy9ZalNp6V+vbJUjaz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWOMOUmkK4cicx9KIoUJU/XuPMlWhl6tysC8B7TKa0c=;
 b=i1GntVU3eA6FVbvTKNnZRojpBhg9tMmmXLInNeAexh9/8/FBzRng6vP6Ium+Ngx80VUuNT4BqyWod8DbnGf053+WxgxwkR0nNeoGRpUdsHXo+nEyFmNPgJhi0uci1hAsbZhQuVh5dHJA2NkVdKM1yofyHozT+7rMEwN7aehL7M8gJndi4mRV6atKu7M/ffeNACzny1+RXLv/hUbYIhV+StIS7pJmYaGtJ7/b5UbUYyJEHng132PO7Qjy3Nuzc6Lu3Z6/Mj0SsPdGqqKZ+mC/CHIUKMTY07/5wRVyFsJxmWvcM5M2/b/pyDsHbDli4G3xOJ1+2vSZ5oWTup2hBUDlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWOMOUmkK4cicx9KIoUJU/XuPMlWhl6tysC8B7TKa0c=;
 b=A/o9EWHkjrEoGpq3y++MiLZvxyWaMljHJh5PvUhYypgasWtKpxrJRgb9GSpJ+XDXpiVvdimnxB9CBT0WjNuzOIz5UWfSxB8N8PnF1RyW2TPY3V+sIZNT+yU6ZX/Iej3E65lm6AbIXSE8VCDGWaGguTVOlFFLXiiClxCtXjxkiB0=
Received: from SG2PR04CA0201.apcprd04.prod.outlook.com (2603:1096:4:187::23)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 19:41:42 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::b6) by SG2PR04CA0201.outlook.office365.com
 (2603:1096:4:187::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 19:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 19:41:42 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 03:41:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 03:41:40 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 03:41:40 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C31006473F; Mon,  2 Oct 2023 22:41:39 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <ulf.hansson@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <adrian.hunter@intel.com>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <pbrobinson@gmail.com>, <gsomlo@gmail.com>,
        <briannorris@chromium.org>, <arnd@arndb.de>,
        <krakoczy@antmicro.com>, <andy.shevchenko@gmail.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 0/2] add NPCM SDHCI driver support
Date:   Mon, 2 Oct 2023 22:41:36 +0300
Message-ID: <20231002194138.125349-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|JH0PR03MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f4e12f-faa5-44ec-b021-08dbc37f9a82
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jeFop6wXgGURGi19T0d8ET41Wlr3gBxJnkU1T7d8qgscY7fnY4ftxid5EjE/?=
 =?us-ascii?Q?qw+w2RaneiB3BkLson5MsLzSDXxAu3nyU603P9OGBcr+T2gT376zmKs/XWUc?=
 =?us-ascii?Q?GGaDfmJnTcLlq605aN8vT7ykgTUImE+bo84ZQW9DR0/FYgiCXOcmD9Nf5U6Z?=
 =?us-ascii?Q?HbEvSRnobnwYOkwBAcmSoDHWgAg76qcRrExwDvPhnuQ0+f8upAsiFg8u0Zp2?=
 =?us-ascii?Q?MOGjMo+AxvmVTxi7S5t99Be1ni2GRN8wBFodIEW0ZvtqGLUPKtdT4/uODJj/?=
 =?us-ascii?Q?MMXQMHu2p+ANjZpvy66rN3M1vD5ZHdf4o4oKxcmIKQtBkRhmiT1fbHcbUux7?=
 =?us-ascii?Q?mtRfDPjGW9fZsPzJLFk+yOZnI4D9Rtbe3ngNK1iGzY1fQSi7aVFptKDDSdIS?=
 =?us-ascii?Q?OUbkWKFC8hAGg1/2OJm2NUjp0OBVCFxTxn6UBdn5HzzoBsBO2jp9j4mvTkRe?=
 =?us-ascii?Q?X+gx4XxYXYKZtS3kioOwWKTkOaWw7KTlGhbe4iTOqhQHISuuwyZ314IXw/4+?=
 =?us-ascii?Q?XZrkI5St4g7vj0Z8PJiHbsOFP/6PLaWf1bz9lAR1L50RIjLbB9MOB94Ie6FH?=
 =?us-ascii?Q?7/qN1OogSNrWkZUeUkn1BTEDaTSwW+CeCK3tZOAaHivdLrT2ZaIJNyhQkRmS?=
 =?us-ascii?Q?xVs96cLeBIwdY1w7HZiCwsqTbS6sMplks8Vi3f3zXK1oYcUC6miYwQxbqJcR?=
 =?us-ascii?Q?fgd0W6P+zWx/gW4HoX9g0yo9OfKyjVbOQo1j+SDIDeGIAIfD6RBWwwhqJ4g3?=
 =?us-ascii?Q?IBGf/5ZJzWVVRblpcaCFIntibi92y0dwb1VWna35DqM017BWw0OxBby1s88L?=
 =?us-ascii?Q?pcdX1OVJqqAdcmOjr+B+//DAd6ywAESf/nwVH2HYmxiVGZOQB3Wr9+IRpu/M?=
 =?us-ascii?Q?BW42yXUWeKvmIlzM49rEwdTxe5ibyvc2JFTZQdG9CzOWbePGRaBYZ8qjszMW?=
 =?us-ascii?Q?ymS5kGPYAMkrSDUx+9B16D6iXwn6Btphkf02C4xiNqw=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(5400799018)(186009)(451199024)(61400799006)(82310400011)(48200799006)(40470700004)(46966006)(36840700001)(8936002)(40480700001)(2616005)(83380400001)(40460700003)(356005)(36756003)(81166007)(36860700001)(82740400003)(34020700004)(7416002)(83170400001)(55446002)(336012)(1076003)(76482006)(478600001)(73392003)(5660300002)(82202003)(966005)(41300700001)(4326008)(6666004)(26005)(42882007)(47076005)(6266002)(921005)(8676002)(2906002)(54906003)(70586007)(70206006)(110136005)(6636002)(316002)(42186006)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:41:42.2482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f4e12f-faa5-44ec-b021-08dbc37f9a82
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds SDHCI support for the Nuvoton NPCM Baseboard 
Management Controller (BMC).

Deeply sorry it took that long until sending version three, promise to try
to do better on the next versions (if needed) :-),

The NPCM SDHCI driver tested on NPCM750 and NPCM845 EVB.

Addressed comments from:
 - Andy Shevchenko : https://www.spinics.net/lists/devicetree/msg637946.html

Changes since version 3:
 - Use devm_clk_get_optional_enabled function.
 - Add mod_devicetable.h.
 - Modify copyright year.

Changes since version 2:
 - Add data to handle architecture-specific SDHCI parameters.
 - Change config place in make and kconfig files.
 - Calling sdhci_pltfm_free to to avoid a memory leak on error.

Changes since version 1:
 - Use correct spaces in the dt-bindings.
 - Drop unused labels from dt-bindings.
 - Order by module name in the make a configuration.
 - Remove unnecessary blank lines.
 - Using devm_clk_get_optional instead of devm_clk_get.

Tomer Maimon (2):
  dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
  mmc: sdhci-npcm: Add NPCM SDHCI driver

 .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 +++++++++
 drivers/mmc/host/Kconfig                      |  8 ++
 drivers/mmc/host/Makefile                     |  1 +
 drivers/mmc/host/sdhci-npcm.c                 | 96 +++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-npcm.c

-- 
2.33.0

