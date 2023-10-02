Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB67B59BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbjJBRvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbjJBRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:51:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2239.outbound.protection.outlook.com [52.100.223.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7361CE8;
        Mon,  2 Oct 2023 10:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXOlZmBcw7Eahn3x8UkCCO5VOiF+IWolQ9DNBrcHd4Yy6ZzjsLC//LxmKtKtjK+GBK6I7Fet3Od9ru0VrTg21mByudlVhEiMX2mIAEzWMhfU1AWE/23EnGsKC5AjIHvVnHY4c90T0zNGTSvzhuj1YWaj0++99MZhbsOB98ozEN2PHd0a4nycqFfi+y6IIUbbeoQFeuOpLoGiweeAHd4KAnKayLBd3nn2Fjpnu8MvJPniUMmf6jOo0u8HuV3SLJtqQHanupLrPHAesjkT3IWPC8QeXr6f1Ukh4YUY0vEUp0L9+TGRy9mNgFllDpGd67LUSw9c+iLSNKtCRC/CEZeiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yU6Gk1KO4Z4V5VrLgc3foRGA3DYw/pZQL+uemoDsUbU=;
 b=LtCQx0HnyOcJTEfHs504DbV6RQu/Szcfu5ylut3LRF8XM1cprv4ZYigGM8TQkTVIM4ZPNsVsdjlLrdU4KtxZxneQkbvSf/hXe7eHBUOZuN4SZv3OGSN8sc5Xq/X81uico2uIA/JxsIYcNJuyHz+YVh/j3DqpxVhsODCi57BhVl14q+FyYezafom8aJlQlCn8qgW0+h5EonfbWhnh5lJ4644b0eUUJSax1yKdrEKKkdRalCGAHhsWGosMBqWVRPTYnQHQBuWfNr1cVwealHE4RzIO8SigW1Tin+t/MK76uwWL7KPQShEfQST0mnHa6JNLmfMjA86vD/QXBid512XDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU6Gk1KO4Z4V5VrLgc3foRGA3DYw/pZQL+uemoDsUbU=;
 b=obrQjHNzPgfSTXzPn4Er35NAzJPQkNvdYiP6l15nseYtXE3mygF7Uop77sM1DJais7sFfPoX1SkxUNq+L7q1iT4B0O0FLFAFVIYAddxZ9pAAjUTGDhUui9URUqXZWflm3rx8CczsPb+eHDiZgaAIeBMSfqDQvAheExZB/XReHkU=
Received: from PS2PR02CA0072.apcprd02.prod.outlook.com (2603:1096:300:5a::36)
 by SI2PR03MB5449.apcprd03.prod.outlook.com (2603:1096:4:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 17:50:57 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:300:5a:cafe::1e) by PS2PR02CA0072.outlook.office365.com
 (2603:1096:300:5a::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 17:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 17:50:56 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 01:50:56 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 01:50:55 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 01:50:55 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8AE436473F; Mon,  2 Oct 2023 20:50:54 +0300 (IDT)
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
Subject: [PATCH v3 0/2] MMC: add NPCM SDHCI driver support
Date:   Mon, 2 Oct 2023 20:50:50 +0300
Message-ID: <20231002175052.112406-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|SI2PR03MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cdcaa8-38a2-4e6f-b975-08dbc3702138
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HAMR2JnjLZR9O0J9avCfu6j1DIqMrgdLUeWRB23umByQlY5WuJIGGEnj+t2d?=
 =?us-ascii?Q?YxLNvEEfw/EIa4zgd7P/ezFr5qOrDQuM88Yu0BTxSZSMmKzzp8MftaXNHyy0?=
 =?us-ascii?Q?oRHkLDvkioW36wwwLcal8rWWGrVGQNxnfwAXd2qWXLTo8lXxHR0xax25nq+/?=
 =?us-ascii?Q?BWYq+dhnF9yYsr7kt2TANEW5Kcm58eZv7TvO63KFhb4gE/0JE4kCqPed1upG?=
 =?us-ascii?Q?UPbHufHWwPj9y3bDbfIq3LnLz0lqmtllV4pK9piD3NlRlm+9BapJsF+WTubh?=
 =?us-ascii?Q?xv0jIp3a+J4isQEgu1ehuLyKWLPHQ3813aXkZugdw67/bINRfEYi/EcRnKVg?=
 =?us-ascii?Q?mXO7XvGlhMod64YbAuMgAiVBy2d+aTjlRnmwcTUR1WREJbcsCLPfP98IuxdR?=
 =?us-ascii?Q?JoYkvaiJPqgr2GK5VowJ/KlyqGg9HBl0Fo4Iy8wSiKU1WvduL3PosrF8XNWv?=
 =?us-ascii?Q?xrGedjv2SLfNHmCM/zEIKMJY1Ug3RcAXRvkRk5wvQS6gcdJPnPd3f3ViRsMF?=
 =?us-ascii?Q?ewnO6uE8gf2UK+lNOGK5RNZFuF1UyNt+G/raXkOFSjv4zUe9ttc+soOLfhUh?=
 =?us-ascii?Q?hlNSQwW2vAtu/NOuHR8HLR9NMi/aTMl3T/2Oo+cn/Ohj1JAO1E+Lg2jyZkis?=
 =?us-ascii?Q?/AL9srYXFKKTcPHBCaOHnZVvt7HVkK3YbXgKNnYNWXbK6vz3w1wqt6HIBsXO?=
 =?us-ascii?Q?LS9LID/917VPnNYB/0Jq0vfRQWjxZ62h7tYizMQg9YUtUaYSEwj4ZeuwAeJT?=
 =?us-ascii?Q?JUNJKG7DECZhWfupvdcjdDUhlsvkkrPmsoOscFYoGvCOiCrEQbrJJ3hVAUnx?=
 =?us-ascii?Q?B5XF451nrzthrhFIo8SUBMYwg6ZjrSs/C1iodD7nCP0dhyruyQShNCGUH788?=
 =?us-ascii?Q?D3P3fVrGGcXdtfLRuWsZ7RIhORzWtbOf3IbDZCe4kSnIlyaa51mnNF/MnYH2?=
 =?us-ascii?Q?mJHBXzeaWnu+HZKz6UlfMbAxlPnd9U1kSeHvw5bXhaY=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(48200799006)(61400799006)(5400799018)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(6666004)(81166007)(921005)(36756003)(316002)(356005)(2616005)(41300700001)(76482006)(82202003)(83170400001)(1076003)(6636002)(70206006)(70586007)(82740400003)(54906003)(26005)(42186006)(55446002)(6266002)(110136005)(2906002)(7416002)(5660300002)(336012)(47076005)(36860700001)(42882007)(83380400001)(4326008)(8936002)(8676002)(34020700004)(73392003)(966005)(478600001)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:50:56.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cdcaa8-38a2-4e6f-b975-08dbc3702138
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5449
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
 - Andy Shevchenko : https://www.spinics.net/lists/linux-mmc/msg74824.html
 - Adrian Hunter : https://www.spinics.net/lists/linux-mmc/msg73353.html
 - Guenter Roeck : https://www.spinics.net/lists/linux-mmc/msg74822.html

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
 drivers/mmc/host/sdhci-npcm.c                 | 99 +++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-npcm.c

-- 
2.33.0

