Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6C7B66FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjJCLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbjJCLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:01:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2230.outbound.protection.outlook.com [52.100.0.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DA1CE;
        Tue,  3 Oct 2023 04:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVd8fMNvlWPb9MTh8x6smn/UKJ/vv1N5bwLkdfTGWLQcrUjpgKu+QmImYAL4L6HfA0CQ+YixAEw2kAZI4qeGAyP7tAaF+5kdcNS9mjzTEWK9e2z0bGMNtpvToW7mTShLoVpR86/0mKw0OEkf6x5poKT8cyF9uoeUZYRFNMBWHl1LbWCS6qSrXby0JMzfd/mXIO5ZXgppyDvDhCpYqbC1L+NQ0DjgV3i7afaMY05jzBDGlETJ13pIN/1WjrwicxqBYbugED62CCK8SB4Cq7vO8QjLKfs297tZEr8u44dZdVhuTBYEqTyEZncGHldb+mmpBxx5Hlyl2o8J8hiOv7UINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=SQJ+hyHYTm4h4+BMy2P8X1A3eUwlAXZhIX+WonyHnxTlxiDwuRlcCYqcPdBwi3UbnG3sUeFBkXFwd8h5VVHguqMBXZ85aG2VpqCQ6Y3oe/a5osHz91cCQ+NWDak6kRYOdqDMhS7yhMqP2Ec3UjFc37ssjjjIsZSElkyAlXUFWUp0h/o9038jskNedth/oQ2k8xY8k0n1zUEjUPAmO8Tx+O2Ih4eAvKiYUCIaIN/Aygr6Bm8Jgh5XsV9dkkACWBO1nkJFVXnhAGM82rv8oJzwcFwsDe21bDPGV3CqT1BedSgBMTKjoVPBlmAhDv0yEmbyWc6V9s+P2zkCNloUS0TrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=VBiq/o0Y9Ul0X6dPB7y3NkR342Peu8I6IR0cSjgfaZdiY0grI0HEFW+HFvPUbt1QLlAYRox1LIYtnR+PepEWDsMXAgPQTPSJvO1FjnLGwaIxyAhDg50YZOUhJcqrE9wChCUzjrDPY5lxrNTeEBzjsRRyuPAv/5VJjvqoI+Dbw6w=
Received: from SG2PR03CA0110.apcprd03.prod.outlook.com (2603:1096:4:91::14) by
 SEYPR03MB7191.apcprd03.prod.outlook.com (2603:1096:101:d4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Tue, 3 Oct 2023 11:01:38 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:91:cafe::ad) by SG2PR03CA0110.outlook.office365.com
 (2603:1096:4:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Tue, 3 Oct 2023 11:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:01:37 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 19:01:36 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 19:01:35 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 1773D64741; Tue,  3 Oct 2023 14:01:35 +0300 (IDT)
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
Subject: [PATCH v4 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Tue, 3 Oct 2023 14:01:28 +0300
Message-ID: <20231003110130.229711-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231003110130.229711-1-tmaimon77@gmail.com>
References: <20231003110130.229711-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEYPR03MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae5b161-c3e5-4dfd-f43d-08dbc4001d46
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zhGdFJ1UrURuPtqkrPHy494xK/GP4gsD063zdHXkdu1wZY9CszJdnz+kn4K/?=
 =?us-ascii?Q?ic2zaCV0gLL4UPkLFoKo6wYmci2Earf9RaETrZjHVioIWoCT+PLd/xTvHzBI?=
 =?us-ascii?Q?E8GJfxu1clpzYgH8VlmRXV5Nfa8MQ/RPCajAaGsXsviC9h2mKSoC6S49PbWo?=
 =?us-ascii?Q?Ni/GhXaLfryTYvF8bM80R0hDibcZOVBaeRXw4m5xC7z6tb+Oyh0W/RJrIuKX?=
 =?us-ascii?Q?/0TT4jxtPLFpRtPBz5BJiVV59jRuX3fGtPPr/rTsjD8STxdRbwPu2PRENigh?=
 =?us-ascii?Q?a+289gvQHFlDEXSLQUp8tefzsMaURww0quSpqJNm6Xvo2FHtQmjNMmAcDJcc?=
 =?us-ascii?Q?Od7ad0BkUJpACx+SMcu4/F6GjIPeEKn6NQEwUntL08f6fgzyPMKtxhi2bzRS?=
 =?us-ascii?Q?UMrT0swIQADILBW2ANnJKSMruIplKJ+Zm/mj2a0jB/1mtswOwmuhSRi6PBQY?=
 =?us-ascii?Q?QftRg20ych73hFYteLAcNbqQ63AhtR2p09QDT+I+G8RmpYYxJ4+bgJiwfs02?=
 =?us-ascii?Q?Hjbz4qgubUwdhndhob1y6s61MslsFowTSO40/HFy5XoayX4f7g3PIZnVZJcK?=
 =?us-ascii?Q?QJChOqNukPJnEnR+omU5EujaYs6OXy7MhRACQW/dyC6F6CEJQSScFp72UWtJ?=
 =?us-ascii?Q?n2lYz7wkKO8LYDksH23ylFBSEOXq14Lc87K1V/chM70Iw/ivoOUStSi5j8aA?=
 =?us-ascii?Q?Rz4CbxOTCGnZE3T2Jn9hCpJKStBq+HnVVvvJpi9cY+xMSVgq4e9K27/LO0FY?=
 =?us-ascii?Q?klLCsvuJn5So+hETy+F7FQsMtS/ThkW18XZ/KX6BzmuTMqThKJvxgmlo6wjJ?=
 =?us-ascii?Q?5akwEWrrP+zs3ELBgyDUhSv0Mi7ZVkySBS80NDT0z44Cj/9eP9JgD6XMvo7r?=
 =?us-ascii?Q?57bTqu/Nhg+B14ilKQ7eoh9o0jPTFo2gYYRfmCAwCH8fv1qzM983aIBxC1M5?=
 =?us-ascii?Q?kwn9KtX37Xe7RcJzx0HFDtpOlLPyh9HNI+rYCirLnjw=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(5400799018)(186009)(61400799006)(451199024)(64100799003)(48200799006)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(40460700003)(8936002)(2616005)(70586007)(6266002)(34020700004)(36860700001)(336012)(83380400001)(42882007)(76482006)(47076005)(82202003)(70206006)(54906003)(7416002)(316002)(42186006)(73392003)(6666004)(41300700001)(2906002)(5660300002)(8676002)(110136005)(1076003)(4326008)(26005)(55446002)(81166007)(356005)(36756003)(82740400003)(921005)(83170400001)(40480700001)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:01:37.2353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae5b161-c3e5-4dfd-f43d-08dbc4001d46
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7191
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

