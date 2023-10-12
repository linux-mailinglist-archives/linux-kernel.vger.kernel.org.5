Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5C7C7A09
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443055AbjJLXBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbjJLXBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:01:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2215.outbound.protection.outlook.com [52.100.0.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E2BE;
        Thu, 12 Oct 2023 16:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3b3Xn8X7IEMJzExZUtREnm6mbA9WCm5Xv+9ZzV8I4YD/Yc/bnC0XBaVc28fT9/JMb17713hbk5N5HEmZipHRuCyqOC1kSJlCdqhC7lR63n7K5t9hEIa0LqCKyyqr2vJbnHACz8DOrrRiV73cgk5hlcJm5cZ+JY4gLxpm03sU6lpFkLMJp8VQf9pIj5/eVPUHp6NyUePZvR4nMuvVLr7kpuY/p0ah00fyOnFsShAjRpbbakzqJEOddDl9FQ2RewAmdXQ9L3VDW5arMfr/ICVoO8bnGuM65WxbvkvJ9LLWqFUY4ylhFTVMz3486fQYFSgOaCrRAAzdpcPLGjRJTWuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=bpup+z4OInu9rz2Vkfs3bD0MW89uhJy5W12lXu/uXsqR9YQDK8Cz+Z0C4fym8TdPjBL0Xb9dYBmIA/Lq5KXQlkTCV9OeqPN1qR89dMlJjjM+ADqEn+HJX+KfjQ2qjzeMqqx7SxceOejoPdU4xE+D4e0xEek0U9C5FkrHlWlBjdlcodsVG2Nsmt3Yi3i8xAdq+dmvOxi+vpIOKGNG9t/2CVdOO66xQTaM96wmWfdFxLCpDIAqMCtUrcqqMgQUYJBrtYE9RbGuoHGU7X9WdC4PcnbhL5wMf9pIOjWz2P2eVgybWyEvkkI6A8xvQ/M4yiUeTYgNRcgo9IBvcYT5Ljyd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=JK9vgISSlGgy7qLw/IQiWnP12Qa+t6/3RhqqUe1quelBG9o6b58ttRm65PjQwuPdlcdNZZjAkt5rF//Oz0B6gg5kR+qMKgTR6r1CUGf9QaghWtG8Uz56QesTrJG3WASMQkVOhHcRLUCUPf1lHnxlMPygTiiNdIdYVEfYHwAkoq4=
Received: from SI2PR04CA0013.apcprd04.prod.outlook.com (2603:1096:4:197::6) by
 TYZPR03MB5501.apcprd03.prod.outlook.com (2603:1096:400:c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Thu, 12 Oct 2023 23:01:04 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:197:cafe::3d) by SI2PR04CA0013.outlook.office365.com
 (2603:1096:4:197::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:01:03 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Fri, 13
 Oct 2023 07:01:02 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Oct 2023 07:01:01 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id CF58168E71;
        Fri, 13 Oct 2023 02:01:00 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C9BA621CFCC4; Fri, 13 Oct 2023 02:01:00 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v6 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Fri, 13 Oct 2023 02:00:55 +0300
Message-ID: <20231012230057.3365626-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231012230057.3365626-1-tmaimon77@gmail.com>
References: <20231012230057.3365626-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|TYZPR03MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: a27f68e7-531f-4357-ab7f-08dbcb771bf5
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eGhjJ/aQ8XX3fyMCD/uhH4aTaPAIXjGbWWbaGo47Z56p6vqRhH6ITB1jFVr3?=
 =?us-ascii?Q?yaJrd8YnUKzK6dFnypH6Ldc8d61c9LIdbsxJbZBWxjqAc7CSRxUhVDI702gz?=
 =?us-ascii?Q?yZcNcjvS6LCpUnLe3r6upe5xCsAUzUiG3WWMbirUyvkSHJu5M8pPcMdAUtty?=
 =?us-ascii?Q?ASlyuxmYeIZXMMldfwVEHPKDRl3qMPyyD4jN4xG8EhAxAl9XBIuChGror/ci?=
 =?us-ascii?Q?QT1tGDbqxgVGeybK/pIHOrsuuZvkHO1bhux+3PzYup4Df/azk/gyXvHQDdik?=
 =?us-ascii?Q?RexEH9xRYGrHsBABa8iFLpJud5usxparhZLHptcgPj8sL2eJnRPrnq9JVR3q?=
 =?us-ascii?Q?e8ca+aDpuU8ZzJlDmLKC2fZ6bqKAovkpNoBMpRkTp7YoERZu2Z4PgZHdpceX?=
 =?us-ascii?Q?M8hhMQ5EM8s3zdIq0FyaOzgBL34McWUGDWNu4dYE01uA2xAGaQ7out1OPVY+?=
 =?us-ascii?Q?lFoRFRPXXj0HIrYlW62M+IHtlgTWjWT1XdXkjP+vb4vWN0+YKWu2UkfSzGNg?=
 =?us-ascii?Q?h+nvM5rH1OxcWLRjo9kr6IktZF2aWx5pt67uGW+5YqgSaXj+CxhX7hxzogia?=
 =?us-ascii?Q?0fzstNMKPVkKeDlX+hQlPuPBD3c/ZsTHw09Tf5aaufn961A25iiXQvdUv/42?=
 =?us-ascii?Q?qTO5DxPh5347YEES4QewZB9e3m2oEzZOKLJfhe3rDM/XfYb3en18faV2jkoC?=
 =?us-ascii?Q?1D2giUy5Oepme0U9lmSePyvqz58HC2CFFVAFdJGs004Oad2Qnns52KNM4Lsz?=
 =?us-ascii?Q?atirF+p5hDmHDKFxzune05RNbv6wGhWHYVdhR58UKE2F7onWFPryP8ciThwE?=
 =?us-ascii?Q?os24mb9tWbYVhErvX8mT1kL4b7M9Lt6lE4sEKa82QF77L2NEvmxj1XGt02Dm?=
 =?us-ascii?Q?FQLEPMt9wLpeUaOrar3OpX9HLJFA+pomyal8p26mK55sQR9DRRK6QuB/8O7K?=
 =?us-ascii?Q?mSpIiuZiWNntKu3vseRX7yu0xu5O6D3pBT1X7xwfaEg=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(5400799018)(64100799003)(61400799006)(48200799006)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(36860700001)(34020700004)(26005)(40460700003)(83170400001)(42882007)(6266002)(73392003)(336012)(40480700001)(81166007)(55446002)(7416002)(2906002)(5660300002)(4326008)(8936002)(8676002)(6666004)(110136005)(316002)(70586007)(70206006)(54906003)(42186006)(76482006)(41300700001)(36756003)(356005)(2616005)(82740400003)(1076003)(82202003)(478600001)(45356006)(35450700002)(84790400001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:01:03.3376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27f68e7-531f-4357-ab7f-08dbcb771bf5
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5501
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

