Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A87B5730
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbjJBP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjJBP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:59:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2232.outbound.protection.outlook.com [52.100.223.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E8D9;
        Mon,  2 Oct 2023 08:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6M600Rehy/azHfzHLAAgD1xxGwMpO1SE9xxTgYYamEWniiqM5LOpITEvk+jofI7q4CidO0W2Nn77V7cnOFjDe4XgDtm5M6dG5ZLcmNojQNF5ad9RLeowwMa0yFcBR6FuItOwFhEV0e6HFU2MPfesGhDAlO4OUYJbNFDXZDbzkGw8kXQGtcmngjgCFhotTt9iQ1gOaqWh1fZ8P/3J3OkiNRPzflJLcGRimBhVe12NlUDdEDUr+Ltf912fNyAkfNaeh3awtKlDK4D8M1ApE3zrTyQHlV7PlcUEMc6moveksogGiNfbWGNIYKlchytKNQIFvZUtt1GI+wYsl71Oda0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha7N9+kxyJqPvCwXnGMv0DWCxgnCvthjbFMurCUrm2A=;
 b=lcTxd3KWXihAXw4uOBhrk0VKhAU/SEUV1syXwamwHLPk/A/qsEfO4GFLJS00BD6EX+qtWfo6sMoAyMsHr9WAoMMqEtM3ZvgcWCq3mIZLzPZWND8Jct6TNIHrQuf7SqYkuol1SviuXbSUVqZsAdFB1/zfjCxt6YDFLBDrwv45rQl1p1tYyT67syUrlSBymhZ+JhcS+5DX+EBt0XC0NslgL28p+/0hixJShiK6hcaFDVNntihtXQYWamaZnEgUe8DD3qVYNqMS1OHv3FASkdSKfl8lsYSM9x85ob93Idr5h713KS+aE8CzgNb9bCStQUXWUQ9+wFz8OSqW9BMhlRsn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha7N9+kxyJqPvCwXnGMv0DWCxgnCvthjbFMurCUrm2A=;
 b=rk84jmaJjJB61IeKewWZZW2pJlxDGsSX/b9/6uq/oKBzmxBvkST9Fzt3HL1cQ5CEPcMB6jvF9dpduqoLA4rwMPPpuBrZ3b6FMD/iNW9rTwq6dyVqmeQEn1F6YQFUSjcmsppEVebHDwyDcCAnqCKc+M0lTJhBX3+bFpqGquKMqvA=
Received: from SG2PR04CA0188.apcprd04.prod.outlook.com (2603:1096:4:14::26) by
 PUZPR03MB6968.apcprd03.prod.outlook.com (2603:1096:301:f7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 2 Oct 2023 15:58:54 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:14:cafe::7d) by SG2PR04CA0188.outlook.office365.com
 (2603:1096:4:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 15:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 15:58:53 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 2
 Oct 2023 23:58:52 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 2 Oct
 2023 23:58:52 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 2 Oct 2023 23:58:52 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 3549464741; Mon,  2 Oct 2023 18:58:51 +0300 (IDT)
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
Subject: [PATCH v3 1/3] usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Date:   Mon, 2 Oct 2023 18:58:46 +0300
Message-ID: <20231002155848.62198-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002155848.62198-1-tmaimon77@gmail.com>
References: <20231002155848.62198-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|PUZPR03MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e6cdb2-a410-4954-e30a-08dbc36079ee
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ogH/I8gqTVmYkA47Gb96ZGtBN8qKasaZ1t2+f6+dP17k04FyK2Dhp2/yxqQd?=
 =?us-ascii?Q?r9RpGpBqQdV2I/X85hMPQOVSXitqp+umPVgDPZRijLPL+9T+W9FRSyajqY/r?=
 =?us-ascii?Q?8rt1A+klFjbWLB0NTnOH5+zJoBPJR2wg7jkXtn2xFuA0hWdDt99/AHAQ4YOU?=
 =?us-ascii?Q?ELz206cT96x7LqJuQBmO5vxtOz1nYr2lN30+WtEruAVs52sLn/xPuR0OF0E4?=
 =?us-ascii?Q?b1rbYY5FEKbMaYBnSGLgn7S3HZLFhOIqGc1/pJOVSDnLh4rCm+MjVlOSKUxZ?=
 =?us-ascii?Q?5aXJMDKbZ5oZ44q9ucw06itgaLugV3hYQt+4p+uZMm6dexeekn2n0qMrG80Q?=
 =?us-ascii?Q?q69Xe01fEzQ5TWid/myj9D4Wsdtyu0ViBFPqIF1Krn2Ks9x+gWEPBf0L5kHG?=
 =?us-ascii?Q?y3fT9LKVRNStQ9NGrDsY02xLP/jAzXzw6a4L8cZ9orZfu/2/v673LXPrWjsZ?=
 =?us-ascii?Q?38072obCrK2+WM5BOmFdB4Vv4hxrgcOc5ivgA1/tY0RFrhBu/pkpl7FQHRQF?=
 =?us-ascii?Q?9KWku+MsOcy8x1fb7md8TtxOCTjHVbXBpfR0h0gYKprluV6lMCWGckp3w7iD?=
 =?us-ascii?Q?9SUal4FoI6KMH49026/bcJq9eLaV0bB8SunMoRwHR99WM7lT7ffhE6iVupVJ?=
 =?us-ascii?Q?KZ0J96D46FKTvzC26RJVN4MjSuWYsZmQMPwS867qOLoZw/fs4EYC5Vc8P4bd?=
 =?us-ascii?Q?sNZIp4Npy/+Moo3AD68qiTsAjb2aWD3FTgw3Tu8lYIATzapgmj6arUPVHFWe?=
 =?us-ascii?Q?EsMcgSxtPO+0NezhlMdsORPkLQYM/eSSXpYqDFLdQyI89yTEpdorPSDq5GBj?=
 =?us-ascii?Q?79G/mxaKZpBkp+Ni46XXmJle+r/vGnYWp/AOVRHcKrhupRbbAFgxdSFDfzG1?=
 =?us-ascii?Q?uKurw/QBVs2m9W5WY8lt6UqMZOny5x9xets/JDw+a+CVVzrtJXno5srEqOtr?=
 =?us-ascii?Q?1eSbYYXPA5r8D5QRGFujNOr05FJ3tApLFAC0H1OLGmY=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(5400799018)(186009)(48200799006)(61400799006)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(356005)(336012)(7416002)(83170400001)(82740400003)(6266002)(55446002)(82202003)(42882007)(26005)(34020700004)(73392003)(76482006)(1076003)(6666004)(110136005)(36860700001)(2906002)(81166007)(478600001)(40460700003)(70586007)(40480700001)(42186006)(8936002)(316002)(8676002)(5660300002)(47076005)(2616005)(36756003)(921005)(70206006)(4326008)(83380400001)(41300700001)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:58:53.1938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e6cdb2-a410-4954-e30a-08dbc36079ee
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6968
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

