Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680997B5812
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbjJBQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjJBQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:14:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2213.outbound.protection.outlook.com [52.100.0.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7161D9;
        Mon,  2 Oct 2023 09:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/bczq0MGh9MD9UNLVGWvDorNrNBNyo47FfR4/73MwMM3xpF1S5mqIVgL0EAx0/eHr5oDmcV0YntlbWOv8gPr5kjEQOE/y+s4hHKFQCnde75Lr++/ZXWM/czRyZmrZj8qTxzaRqxT29dnx0FPcsmIWr7G7X2uSjIFbQ4Ha3xuqMvBvQtqqzm1YogXnq9jXCXcc+fQfCtoH2ZuJmHUCkQMMjxtiBFisFs3BtuB5XdbBtmWi3Xg+GaK/Yz/l0PhnIuori9KilQ8BTqlNfTdCb3nB+H3Lkk67w4F3HyDfWHdHQfuULuMj3JDKYTvymK5eHR3rqoBg96nNLTEwZL4hnAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=QGqIb+ulg6ynp1k1VGKKMZTc0JV+FuhiPgkW8HFDjervTDC5atiYPWeuIEqsKm1lFhlhJKtUedphSFJXQXpzK3+lnrrFb0eopbiA0TiP1RIO0xJ4p4f7Ia1RxH6tMv+ghcAfp8oc695dngLHEA1NahpZzlK0yLR7Gildq2qFrPw0WIxyBNUFPJ1XI2YJSdl8DFs48NwYXsl/m21ZW8AboiRXxLUgVdwRHRLv9kb9yo910r+J9aYs3Cp6+mZua4aq876sSrhc6cUT3H4dwmqMKR/e6PZ00YVYptZmNiI1WP9u8rNACPAPvm96EYI5odyiMuzcWtglIv0/PuEoNxtTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=W4UTtAzVUNbnpy6/iU1ryxnOyNNs9FdX+9xATiHJeRCul/2e5F86hMPa/JoTZRqgVV57BoS+nRozp2K3IhiYyWpqlA7NvdQKgj2CV6bX1kgvtsttMhsZWZpkOxDPMEHiV4plMRIfnFEl3GaVad+UBaFaed6nXF28JHycDia1uWw=
Received: from SG2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:3:18::27) by
 TYZPR03MB7956.apcprd03.prod.outlook.com (2603:1096:400:44d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Mon, 2 Oct 2023 16:13:55 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::5c) by SG2PR02CA0039.outlook.office365.com
 (2603:1096:3:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 16:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 2 Oct 2023 16:13:54 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 00:13:54 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 00:13:53 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 00:13:53 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 7A8F364741; Mon,  2 Oct 2023 19:13:52 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <xu.yang_2@nxp.com>, <peng.fan@nxp.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v3 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Mon, 2 Oct 2023 19:13:48 +0300
Message-ID: <20231002161350.64229-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002161350.64229-1-tmaimon77@gmail.com>
References: <20231002161350.64229-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|TYZPR03MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: abac2114-8589-4f04-75e6-08dbc362935e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qQeSiRa85Vzjt6zJwKiGp+BybZjeRv40yoraAds15JBemtiKuWHEdEEqH3fT?=
 =?us-ascii?Q?QNCQf6lJCjvpHJx1a1Mfxbqt9DYSrMDPpArq68hAsOTLETuCDKJA3INseARy?=
 =?us-ascii?Q?maqqcKCjp4n/zNs2E3juKShKP3poFfd0Desza9PFjFjWh/bQlN6XCyttszgY?=
 =?us-ascii?Q?jF+YGQdFtvSrmT7pBjoz2oIyLWgXvOwIIOef2Y7U5wdTRTexbZOXWJb/LJ5M?=
 =?us-ascii?Q?7ShU1F4upbStWBdEKeqPnmXX5Zrg4Va3Ntk2ZfiGmUrJi5F0oZuANnXZ5ya4?=
 =?us-ascii?Q?hWHWCT31IHOa1tXqMfG8911eAluEV+rVy1+Q6otr5PzuJ+FUOHbx3KIKyXI2?=
 =?us-ascii?Q?XDfhpjGaio6fqEGsns+ntitD26aLwu1usUrD8RkJ4w7ihHkShm+aOgWsRd2z?=
 =?us-ascii?Q?dXK+J0zvd8q4lYDIZ9QqLs5M7LGQ1KAAcMVN+Sr0kWInr6lCGNo+QE+B1der?=
 =?us-ascii?Q?mmfdgLQaCv2EWee1D+E+0zviipKeSr/FiD+yr2OzAesdi96QLUDfUHKvuuND?=
 =?us-ascii?Q?mryKhLZmDJALXCKQAIO3TqSj1FQh4llnIJghGzhSqfntuX1wsZCwZxf1/6Ms?=
 =?us-ascii?Q?mJAbM2OdhSXPj2QZTs3u4s8MbbjXPvhKIl8a2JEyJk9kEds4JbA6ugBZDBkJ?=
 =?us-ascii?Q?wCWxAY5gS8cFfiGa3h44EfuZ7d8/mXlr3iQBkcOmQsSbXWEezeHQGAOQvNnf?=
 =?us-ascii?Q?XTm6bW56Ty85tDNMWQrOCGRW1iSMSlKhibCwPvFQ1G426S7AvFiYb+TwQMHN?=
 =?us-ascii?Q?6j9b1FooIOI9PfWxaN5XKwqpH1rfREBTLkXAiYly5PyXmNtjh1RViH2lItqB?=
 =?us-ascii?Q?Mv0BlsCyounggYoRbFPjfhFErwxD0Ka/VJK2EWjc1wqybVL8xqJejgMufAPO?=
 =?us-ascii?Q?VuuFjQ14O31oibW5aK9vpfM3tDoJ/S6Bpd5pPbpK++fGn1sl4gDWR6QJ0QrF?=
 =?us-ascii?Q?suHFbvkQF6HpzuYAOSbL3yAj/oks6ikV9cJZLhWh08I=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(5400799018)(82310400011)(186009)(61400799006)(48200799006)(40470700004)(46966006)(36840700001)(40460700003)(316002)(5660300002)(83380400001)(2906002)(41300700001)(40480700001)(42186006)(8936002)(70206006)(4326008)(8676002)(36756003)(2616005)(54906003)(6666004)(55446002)(76482006)(26005)(82202003)(7416002)(6266002)(82740400003)(356005)(336012)(73392003)(1076003)(83170400001)(42882007)(921005)(36860700001)(70586007)(81166007)(478600001)(110136005)(47076005)(34020700004)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:13:54.8615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abac2114-8589-4f04-75e6-08dbc362935e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7956
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

Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
parameter to active in case the ChipIdea USB IP role is device-only and
there is no otgsc register.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
---
 drivers/usb/chipidea/otg.c   | 5 ++++-
 include/linux/usb/chipidea.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index f5490f2a5b6b..647e98f4e351 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -130,8 +130,11 @@ enum ci_role ci_otg_role(struct ci_hdrc *ci)
 
 void ci_handle_vbus_change(struct ci_hdrc *ci)
 {
-	if (!ci->is_otg)
+	if (!ci->is_otg) {
+		if (ci->platdata->flags & CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS)
+			usb_gadget_vbus_connect(&ci->gadget);
 		return;
+	}
 
 	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active)
 		usb_gadget_vbus_connect(&ci->gadget);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 0b4f2d5faa08..5a7f96684ea2 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -64,6 +64,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_PMQOS			BIT(15)
 #define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
 #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
+#define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
2.33.0

