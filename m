Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4167B011C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjI0Jzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0Jzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:55:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2216.outbound.protection.outlook.com [52.100.223.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF9712A;
        Wed, 27 Sep 2023 02:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6E7BsBMFw4DZG0yNrc54BUF8r/TZy2nj2IyUxUSy9wuhZX2CmPhKJZe89+wtyFfKav4WzWzyw6Vv6BkV6cOGeKdrAXC+0Ey26zNAk7FtTFCi8pnnCK4VTFsjgx4vmkTl15TRwk7E1G4aotH0dEpdL72+5WCEsbmAD5Yi21ccDt3YRftDDufUBDZSyTX3ZNpWFUFYqMrMTsVatSrp352PM0qOda4pJm+iyXEaqGjPwEFGt6+zFyTwavCmE741wARqG3p5sAhi80Az2TqggH53IZpV4gieBCCFeIMd6rQNnpj3D9EKjQM5dp45oIw4nOY+PJaf5Vc6lKNVHgnJjjeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha7N9+kxyJqPvCwXnGMv0DWCxgnCvthjbFMurCUrm2A=;
 b=GfD8f/wsmDfblYdZk/oVbQEcfzQDNYmQ/vSIHL5DZ+DJK8aKV6WYwNItkbHdyaSz+UcEDW1PN/Bi3MBtTpTY8F0jeHPD3A7SrquJgItFVxJ4IdR/uhiiNu9lVXLg7Qep0UWcilKuDvJkgAvK8O6UxEryo7eoDxt0wwJ9O8Bi8AIY2bxWp2ItmicYZos0CAvVn06XxN3E9PeftpRIVCyI5P5ZRka3fNKp+YRpLNFDeazBcbwZmWffh5YsyYZd6cVxJHZ84SkP1sYH2wS1WkQObQ/N2l3f6h1kquuT7rD0Yr6tjoJ4GYWsJvqmvspcMadAmUN/IZeS8IgaJnKHu2nUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha7N9+kxyJqPvCwXnGMv0DWCxgnCvthjbFMurCUrm2A=;
 b=qYE6Zm8S1/h0X6N5CJV3HGBn7Zvkg7n1MIkvFiN/AjWPX37cpBDsEAcvP4w5bQE1CFwMpMMvisDboMmcZVUdDmZhaCET8/RwzMZpKdqVqH3ieaiK64AoiFmgFUDBhaVPSo8YfZ7KNinWhroN1Vc4wzoLk4RyEKLTrmx+IP9JIwk=
Received: from SI2PR02CA0011.apcprd02.prod.outlook.com (2603:1096:4:194::20)
 by SEYPR03MB6434.apcprd03.prod.outlook.com (2603:1096:101:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 09:55:27 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::15) by SI2PR02CA0011.outlook.office365.com
 (2603:1096:4:194::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 09:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:55:27 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 27
 Sep 2023 17:55:13 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 27 Sep
 2023 17:55:12 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 17:55:12 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id AAA5364741; Wed, 27 Sep 2023 12:55:11 +0300 (IDT)
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
Subject: [PATCH v2 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Wed, 27 Sep 2023 12:55:07 +0300
Message-ID: <20230927095509.267029-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230927095509.267029-1-tmaimon77@gmail.com>
References: <20230927095509.267029-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SEYPR03MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: d21184d0-8e6d-4bab-4ff6-08dbbf3fe096
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOxmh0RF/rlgQD+mQ4D3cvbf0iFFnkxQbCUsixTdMOXmrJVqSpD9i2YacOaj?=
 =?us-ascii?Q?t/8b9lnlBeWw6EpQU5QAtn4hTEiY6eEpVMjfmCG4LIJ+bzHRXq72Yyu6dFm8?=
 =?us-ascii?Q?/jCzrDKrrLo/WfCI6QOIkZt1I410Xd8p9Hc+UdBQHRIL6ELm9+Z/4nX/MYqW?=
 =?us-ascii?Q?fLyTzAfWe7gRU0wuvegCDqLaLNAvwIz/kvwBUxMukkt6F32FZPQD8MBTZIf/?=
 =?us-ascii?Q?LxZXD0C9U+yE2Z3OJyyVfGoEaSNpwwbbP/jpkZGv3wBrX5sVB2BlDCifl8Uq?=
 =?us-ascii?Q?WFLj78lao8KlP+XCzpPcm3dr/wkfE+0+x1tb5Jj7sjBdVaQoCaL1PgINyOLk?=
 =?us-ascii?Q?ldu3t0NN40Uevcnl445+MiLBqVGzpcFoA4k6NICflQOxK5FKS++xKp+pGsWp?=
 =?us-ascii?Q?KFNohdjIhd7fy0fLzlHaaOJc3/e0XvrdgKqggSQgUrzYiAyi1Dcp2XZo3NVP?=
 =?us-ascii?Q?5Tnra782ay8QyP+f5LeIAoB0Z/KIAcPSGSuvSw6Wm7jO+9Yf7H5t+C6gCqSz?=
 =?us-ascii?Q?T39sX8dui/JKdWoIVNgThabYVPvlDKcr9A9cM5b+ekNjRrtfV8yganqDGk2C?=
 =?us-ascii?Q?MICeH8wZ+ItTuJ2rVIshcvMpZyY93oe93eyTSJzo2E4NUd9+mTzz/EzUbR/Y?=
 =?us-ascii?Q?Pw7UYnMeOlCxrW4JS9J8acwWIvKUrCsrGgIQWQGsw/t2EQKs3Q5EDwIsuYUd?=
 =?us-ascii?Q?tQ5hShC+3ouE+HVs/uA8TvAiqmLsDYa68r/71ekVi0jng+4WuIziwsBgMm2j?=
 =?us-ascii?Q?tXKOVTPx+qmmLXIYTdIQ3ICL9UWhhzM02u1+GMZ1jS9OS+tPxZmsFcoqlFRf?=
 =?us-ascii?Q?9uNrsDhk3uK0wGeTw0ZQHfhIS735He3ROYVyHR0QIfKZgOZaZI82Fka8aCha?=
 =?us-ascii?Q?r+lPtAUPzOwvB9v+5QWO8R/FzmAguKYmCBrholvoo+qjVgW29A8jYTt3JmBK?=
 =?us-ascii?Q?W9OP4rcnvYw/2iwB/V9KWzUZCqtrulb5O7sqXrF3mKw=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(61400799006)(5400799018)(186009)(451199024)(82310400011)(48200799006)(36840700001)(46966006)(40470700004)(55446002)(336012)(6266002)(83170400001)(6666004)(82740400003)(2616005)(81166007)(36860700001)(36756003)(83380400001)(921005)(34020700004)(26005)(47076005)(73392003)(1076003)(356005)(478600001)(82202003)(42882007)(70206006)(76482006)(110136005)(42186006)(70586007)(54906003)(2906002)(316002)(40480700001)(40460700003)(4326008)(7416002)(8676002)(5660300002)(8936002)(41300700001)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:55:27.3286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21184d0-8e6d-4bab-4ff6-08dbbf3fe096
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6434
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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

