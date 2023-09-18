Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46587A50D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjIRQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjIRQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:39:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D861FC7;
        Mon, 18 Sep 2023 09:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPPORKZYKgw5tds0bJGXEUIL0INRexU8Rezjk1CHFBWuyEOL2tgOkOwSkkCJMikUhGn4aOwHwknHiHXfDFAdIEdyaRL7kxrKi26s6np8d5HgwM3BDSHnseOxLWbvHP2gk+tVT9NrspTPEBn1yUe+CAjtNc5ikWzOnvYt3b1ol84I95lTmNQ6vMmiBtk6zUasxvARyjQy3c3fYzqhKEdtH2lWMGgwJxjiOYItsE7BuluiAoK9+T13Lal4qmO4aPqhT5LEMHxYifTo3ht2aLnSZRGXEkb8zl2dfQhOiMlGDyrIz2iURiwoInn48YQrFaLp2uiNbSb9PXNwyTHeUF97gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha7N9+kxyJqPvCwXnGMv0DWCxgnCvthjbFMurCUrm2A=;
 b=nuNnFaJpiM6I8/Zqq6wtGNjFf0q3qc6kgF1QU4m5SacfYZu/cNJQZ9f749uhb4s1waGzZJP3fEmtNqYjlxeoKyBgVwbcVDkhbXB2PyoXG3uCIhXUiOgeE01s89tLWKT1Curx65RzBh1t8WneqXe4vz9iG2x8vcs0LnMZtyjrdWiW88vC3Z4ZNO8VgkZ3KvyF4q0aBThGgTa8XlKvLpzqQV1F/jcXMz1fGOt4jYdnUye+zqWHd1yNaf1HiNPWOtaa8H7tmPBOgP/ieXK6wtHjSjxZCJ7BZVQQ4oRmY0x+Pry95dAGkddHf13ZBAayisufTqJEl4F1YKBcbm8jPD24LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha7N9+kxyJqPvCwXnGMv0DWCxgnCvthjbFMurCUrm2A=;
 b=h2+d4cl9QhYRvg1/FhXGua25t2Gm1G5vJwcMFxHbbhlgcMirfpRGCNT288h8aZRncXlXxq6wt9tLtBqLHS/KPmSXcFolUkuweOFogLf9fwa7GBsC/Bnw44lY7M8kuo+Y/AfHb8lM6mH6yaB9gg3ekx1OQa9QJZYR4GjLJ5DbYfA=
Received: from SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31) by
 JH0PR03MB8211.apcprd03.prod.outlook.com (2603:1096:990:4f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 16:10:33 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::d9) by SGXP274CA0019.outlook.office365.com
 (2603:1096:4:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 16:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 16:10:32 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 19 Sep
 2023 00:10:32 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Sep
 2023 00:10:31 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 19 Sep 2023 00:10:31 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 04D366473F; Mon, 18 Sep 2023 19:10:30 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Mon, 18 Sep 2023 19:10:28 +0300
Message-ID: <20230918161028.264650-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|JH0PR03MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 3567cec4-9447-42c5-f97e-08dbb861c8fd
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnmq9tjTVF/lhN37NrjTx6bW4zghbYyAott5tM5iCK661S0CA9FmHl1PgAS24TdholOg1DEXokSsb/TzuIIGaMHP/1JHTBTiUOexLTNlTZ23FDzc/prxZESrkGJidVHqAQW6u3Fak4R4PVUySzoMbfBFa52iCOSbpv7iufecyYtbm1Z6F+h2iZjXyRPZuB2dLBY8FUUlAMfXDScaA6g4PW34d1V53Aq5HGKx8vlqBAbuC/ItVMuKiLXhFIBP5xobDbV+jYf4R5QgqlozdX7ytnho4A5P6JPy/G4yJxYc+yAEzrwF5IfnoF6dRyq4OYJ5YmALb6M1edGDR2ouB4KR8RPc29jCIDDKxE+pILAKeXD9V/OaCfufxLtmFkOFq7/ZHRbjHbyq+jxjn7JG0HgC02CIw8KBmnwmwsW1kdWOxFiED9RSNd3OAkgD6sThfz2gExM7txe2xn1xWr2RznyePSbvWkdOZqNLUOrZrwKUX+xiRAuALnA6FAY/frZvggGb9rGldDkXv5pDmsUcaOaIsxGSwrH0iR1ljChbRLY911FzMnbk9fhq140UlMLf2LaT6qGazbj6q3u+GdTvldZiFVxkTyO2DcOmvkTeH1Q0gS1c205YzU4+xXQJtPwIAsbm4p9K5sKSKehLE6XD804e3RhQuFE/PDRkN7i1gy2APaKam4JrtVxbLKc9+tbgJi8FYKXMR212TLCLJDbz3XcF6+ybVpHRRGYdC3fwQqSpWhyW+7xmjQl3G3EDFPNgG5VPOXKYFf69oTtSSWmAXSMtnpszaMOhEY/6113XGU9gfqzZTTBSUqg0FN3tccOtPzOabs7o5t/9wvE4PXjxFNV5XGChZQl2jHmU9rnTM1mxP3SFyTgBNHGF0G/kSHgzvmzr
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(186009)(61400799006)(48200799006)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(4326008)(2906002)(8936002)(7416002)(8676002)(47076005)(356005)(26005)(478600001)(41300700001)(81166007)(36860700001)(5660300002)(76482006)(70206006)(54906003)(83380400001)(70586007)(316002)(42186006)(83170400001)(336012)(6266002)(73392003)(40480700001)(42882007)(1076003)(82202003)(2616005)(82740400003)(40460700003)(36756003)(110136005)(55446002)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:10:32.6170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3567cec4-9447-42c5-f97e-08dbb861c8fd
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8211
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

