Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9D7BAA18
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjJET0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjJETZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:25:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2219.outbound.protection.outlook.com [52.100.164.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57A136;
        Thu,  5 Oct 2023 12:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz84XqxANPtAsnH2mfh2lDjh9YShfCZ6U0wLHHSWBrfj+YrNoZANYD6Dn5dsg8T4r6PSm50Z9uhvgT0PItsVJH5gObTG+cHDA2FW/vkbxoYLngkjsm5E6ouoxTzacrzEbrX+s9bHFrHXW0k2Gn4JxwhIy1FUfq5KPxq+tSQaJSkuTYK5kCDOMsF5NyYcMeUkMB2cNiBzbYUmCBF4MnAzMm2iUBQ3nqhZ+/Om+fgok6e4kOtNgvpYQXpv3jv3teZoa9teuU5MlyPgFdjJ831PKEguIDKN1mWnRhwj57lLDWnXYAKGq3SdlbHxN0q9CWQkTAWDXsp0MsOHe5rBksKbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=janHLuVxg5V374sU7zA0HAPVzdQlKB50QZo5SXwpsODPCeOvDRx/9HvvrFwRmB+wlsShDYg/5deZRwNrXRCWZ2DM+h59vXArpKL6dBLNzrSIi5uXefHngTrfRx2qMZAe+lTruEacmKij/4fjn3vAxV+mr/qHtSyuRRWwqGHmbsz4is+p6qRSHfdEQYrUiPae/qrQu2B5n9RCRQB6Pd++G5SpIlTNL4dl1ozW2zrIdiTln6UoSkU+C+xPunT6bzP/PpFNMS7y7SwwBm5YxTihdheWHzjop++qT78Ru16u5BSzN332QdnL3AaicigKJCOLachO7QOgrQf2vygtaTYEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=eVBFEZPM/i4P1EzYAbQxDsAE3zveq0crZpBFeSdCUcpwfUu/CJa2vZKbbr9BD5uL/2+yk26STVZwY8UsGZKY70AseHyoUDaLKlw2/NjToB6KssLuWYEVPwAIVKlvw/rNJcgzycS0KzcarvDvvYmeotJEgVBSghGEf22tkZCLLgI=
Received: from SG2PR02CA0126.apcprd02.prod.outlook.com (2603:1096:4:188::11)
 by SEYPR03MB7700.apcprd03.prod.outlook.com (2603:1096:101:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 19:25:39 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::5d) by SG2PR02CA0126.outlook.office365.com
 (2603:1096:4:188::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 19:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:25:38 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Fri, 6
 Oct 2023 03:25:32 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 6 Oct
 2023 03:25:32 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 6 Oct 2023 03:25:32 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 74E7C63A27; Thu,  5 Oct 2023 22:25:31 +0300 (IDT)
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
Subject: [PATCH v5 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Thu, 5 Oct 2023 22:25:27 +0300
Message-ID: <20231005192529.162785-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231005192529.162785-1-tmaimon77@gmail.com>
References: <20231005192529.162785-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SEYPR03MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1603d0c3-00cc-4325-2e94-08dbc5d8db97
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aknA4LBbd0GyF4vT74FLwFtaoEoEMRqrH51Omld1B8CF57s5o7GOjggel86A?=
 =?us-ascii?Q?qJBKHrp8rEtBTUVMmWHc1NsuqFGKsHOXRvj91XloccKZMgb9A115VDJ73JT/?=
 =?us-ascii?Q?w/o468lCfWyJe4O/80ZTrgkwBjJriE/1iTvR9vXAzw8Jh32b7kj5HsRxOQu/?=
 =?us-ascii?Q?44qjNEJJiLO5RvtmpJBNSFPt67WYhzcvw+oYnDG+n3+mGadq7EcPp2AjP0vq?=
 =?us-ascii?Q?gyoSx+iGVaxvU3DIOTGi0Zw1tuNHiFvyFo2cXwmKF/pjEbq/ldsy+Egis/on?=
 =?us-ascii?Q?EslDTgh/+FSUn19N1EH51Pkhq7NXahBsY2clFXuX5oqVAmJl0e/dPReO/dOY?=
 =?us-ascii?Q?iLIUrvW9g7QWu/ECaTLOLTRpuoKqzmafeQEVyDsHUl4uRK86DoXbzxEb7OG8?=
 =?us-ascii?Q?C5hGJJTspQ5W/2cs7vqaAWbDAQKBgRYnLG8/8qIBC2sgow05C/oOZSvpggNM?=
 =?us-ascii?Q?o4a2sZzEyrK+bqSDmzS5/F2dJsFEXNdgQUvO/T4ppMqV35gO5c1ih3GLde6D?=
 =?us-ascii?Q?XzF1VHnvecBsVHEDPcglGQJrVmuC4q7QDel7MpoI6VCpbPs9XC7TMXiqx33p?=
 =?us-ascii?Q?gmsDlngDqwo4VBZtLKDwleNdeOn9hMYNtU5iGd3+SBM51DLJxS3P9ALSAquq?=
 =?us-ascii?Q?cNwFJOC1q017WXyFKhgiANGyVAmPmgPkREQj9QI/zFbrPFNKFmL0NwASq1I6?=
 =?us-ascii?Q?IkUUmnTGUoplfjTH9ZqgkSa738QmCHkLIf42vTAEFKLYBEdaTmsSPUsR66D5?=
 =?us-ascii?Q?rggqMQN4dKeAziTbRPoNYk5AtnfXCSnhVwIhntKZCVlM69yDCHYhjLmj/NNu?=
 =?us-ascii?Q?IBMimyU3ybvOa7u2ZRDgHZh33ViMF2casa+gzkMFhmuV9QVLxLpIvvYiS9Hk?=
 =?us-ascii?Q?tunx4axmOWskzhT3f413h5PFje63FOAR54t+mjNYJpeRm2FrAoOz7aTGwoLL?=
 =?us-ascii?Q?XtqO6UiM9ap8HwkfIh29tCdRcUlcvrSLbSHznWbENIg=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(61400799006)(48200799006)(5400799018)(186009)(451199024)(36840700001)(40470700004)(46966006)(356005)(1076003)(82740400003)(83170400001)(26005)(921005)(8936002)(83380400001)(5660300002)(82202003)(4326008)(8676002)(47076005)(34020700004)(73392003)(42882007)(6266002)(36860700001)(2616005)(336012)(6666004)(81166007)(478600001)(70206006)(316002)(76482006)(110136005)(70586007)(54906003)(41300700001)(40480700001)(42186006)(7416002)(55446002)(36756003)(2906002)(40460700003)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:25:38.9689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1603d0c3-00cc-4325-2e94-08dbc5d8db97
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7700
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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

