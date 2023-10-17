Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C737CCCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjJQT7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjJQT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:59:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E88F5;
        Tue, 17 Oct 2023 12:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJfUJ/QkFHnH+ic0M5hu+TTqNrOoSU6QVLuo77oXsmQ4jMw2HjqNBW3fKLamU5Lbpf8bteAMA2O0Y1RUl3K0WuEEZ3bya/9lpNVXq2i1oWawbwk95LDZ38K5sS2XoZZVBvONGpTGEmsGPaF3xKOzCWP2NAPysthvre1l4Sgd7wbxFK7sYGAcMyw6c/vo+dLLoF0jhjnOtwAVEsIUQN10/vCyricQm1JGIdNj1rqKC+T45fr0e4FbqnmYDZc0wI+hyWTLmcAW9fLswKb2txbxd/zke3GnmdXUETWUReBtPA/0J4Ks5bYDlM6PdwJQwfvzNDOdn8AmJinZpYLGlLWitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=QMOoO44IVCEh3PoFDIilyUmcleaAisntk+Ikl9xrp1gPBXIXJfIVr8MKimDNOh2t8nOOXoOR4NE6/iFoEOYoDJmDqmgqSfEchw8gpvet2FcTkSSBtNxXjGYd+6xUGRFoWxXEcoZKARzOqBYlh84E7g0xqAKom2hVjQKjW3+Of+TQMha+QyikURSNeGl69CWXLSHgfatkeUh0QJoyzEBMAlU+CJgyUKSmbw3XkZoEm75OIRQPOEuVxgOcmG1W0o7Zs13bTsaRg7T4C831hG7U00OEkN+NL9w0ElMR+x1yrU2/h4MTYzPH9iEkTrAtQp8ip9wtX7OFO06cNhUb1BOQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJPlBtL4X/T/9aSDc4JYtiVWMLfmJVy5DVI0D2TM3mA=;
 b=aKWT/kfqHIC4vdFH1BuwRrYrmLWAq9lNvcv1JtVdF2jIl5T21PSdoicpppnpFjbc0x5c2OjnBGaTc2IE20S9Sy7839d+xIGBG/Ic8Kay817e9yTlq43jlj6UHMPc9kWCbfhRb2stHJL8lZfaKqcHorjtlUYRGMEYs1KRXr8D9A0=
Received: from SG2PR02CA0056.apcprd02.prod.outlook.com (2603:1096:4:54::20) by
 KL1PR03MB5604.apcprd03.prod.outlook.com (2603:1096:820:58::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Tue, 17 Oct 2023 19:59:26 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:54:cafe::d8) by SG2PR02CA0056.outlook.office365.com
 (2603:1096:4:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:59:25 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Oct
 2023 03:59:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 18 Oct 2023 03:59:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 73C0568E44;
        Tue, 17 Oct 2023 22:59:23 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 6457D21CFCCF; Tue, 17 Oct 2023 22:59:23 +0300 (IDT)
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
Subject: [PATCH v7 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Tue, 17 Oct 2023 22:59:01 +0300
Message-ID: <20231017195903.1665260-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231017195903.1665260-1-tmaimon77@gmail.com>
References: <20231017195903.1665260-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|KL1PR03MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 822efe11-f771-4de9-9674-08dbcf4b9057
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdA61Jr5M8K8STQPsRBvhYxfYNobwXbf921hGZY5kPXFk7I29ZtM+Cl7vGTF0+VOhFkd5OQeB0iD9JXPmgXpnt8QLzPLne67yuF3JdOmZoH8WSAbDr1/1/Kw63HAti+Y5CE93ZTGW5BERixV1HvR+gUERQv22Q+2jEP5jrpYDZQlRXamN7a5H9bij+EknGXCtdSj5QY1g0u8FphwKCB/SoZjVBIk1ckA2xi8x9+crCWjhBu3h/0OAdmLrWkDH3LCFmcyu5ZFLg4fMRApyWExROzkChpwmgUA8ZquHejsPwN/W9EGlEOphLiG2XLZrKMn0xvg0qhuXBfVmXtc3xr0A5SCoXN1MyUGMK6yzg4gonfeojp1X9eFX7Rkxj5LPw/m8wrbjISy0SbUz6C5GkDuPQp8TfqfGIMJSQ2aBCmavz4cR7YebPudr5uSkA8AmgdzDuJu8Bmg6/LubjPDvWe0aesJJgRj4qxpKNdWU3vSMRb9gtn9NmJruHg4Yd1brFpg2JuxzGOY2Vzj0Mk8ejip0fKxmdARtFBRRM+LW0JxpWuom8bdFs4BckQ+vk1m1abIgw+J1RhUAzf4g/8VuWmRBFLnAbhPpkLbqYXtKNnyf3is+W+ohI4JFEfly6fJ37S2+Gefd5eAZqrMBSuC+77LeT/Lx3IVwG9xriKBLfeHtItaWfE+QDHehpeIp8Nb8RSV4TBQpBPJ//1r0HxD3xl8/Ol8XDB1qVx7PmY299DcPXLqxXyiQFWU6Iis5ObwU+GVLjhK4xQOW4gb6TJs8zG/x4ysLychdkVr2EGqVg8VbEb9xfRdQ9LwT8/smwvqJ5NVqfvaRxOSgGQVgJAtdpw9iD2v+z9mpYuvALwYg/VfkRK+d0EBo28DHrpkfzMqyCUnrpIZwfre5ULsipMDRceKgQ==
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(48200799006)(64100799003)(451199024)(61400799006)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(26005)(6666004)(1076003)(42882007)(82202003)(336012)(2616005)(47076005)(6266002)(36860700001)(73392003)(83380400001)(4326008)(41300700001)(7416002)(5660300002)(8676002)(2906002)(76482006)(478600001)(8936002)(70206006)(54906003)(70586007)(42186006)(110136005)(316002)(81166007)(82740400003)(921005)(356005)(83170400001)(36756003)(55446002)(40480700001)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:59:25.3119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822efe11-f771-4de9-9674-08dbcf4b9057
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5604
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

