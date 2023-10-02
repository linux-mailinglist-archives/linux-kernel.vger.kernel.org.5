Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44077B5835
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbjJBQOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbjJBQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:14:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2244.outbound.protection.outlook.com [52.100.0.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A7DA;
        Mon,  2 Oct 2023 09:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAbDCpXfmKq2UfqBew0S4vSkzw5wv+IAhIVf9ROCSZoP94guKulHljHOySJ70RI523xU0YW2Ry6WfRq0UO/9GB/iIQ5hbnHZjJ0bZMc+4gMNYZQbOiXcS/vjVwoCrbVw3uIcxVuIIlcfCPsMKRjAkmpyMVljVSp1ofseu1NZPdeCx+o2H/EDiYX6MEUjl+C8BsSgkYf+fooQF89VGNLSPL4EAOqKGlJGqtHgC3p86bD1pzgbAHsisTA4sESKXMlx44HNj+byYxASzjFErmS4T6WxiQSyjMOIAfz0c4qX4Gz7mshmF+fG6Iu1LZ6ATMtpFsGmUgHaZJz1n8MdtfCKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=PkmidZibhJMbitNePyFBaodswDWf3ATkFOopwTC2SN6rNe5I67cFMbdvZ9SmrNIYCURpEmtuqmk5uKFxKpycRHTnDYOx2owAD/W6W87eExj5QF7ExoEfO7jd9N5TN4uPs31yZUwAmrUeGc0/u+E/8y++9c+2/iD4fdt5sIuaHvrpTaJue/xCVrRjozoUc+G0ODu5gpnK7IcCn/nEvGJf5jfUXjRiSRDWyoJwXe0oJBAPctah2djY9nKwNekMxIfw853vAIaRZCsFRcxmI9sGl4lUtKFT5n+vn+YJdsh5nplTiM3dnFLo/lNOiB672zpSX7QS5Lqzlv00npAYd9F5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=jgFd/MMO9fBC4PvrpGtvVQNUsgX9q4fgGYC34C+xg/3tPD/LbypXKVqzI6aitChtowHEHBzxSWx8MBr3qeFol378HlA+pkyTRsyjUclMGGz4xZ0Bl7U0qXqiCAwomSUHGb782b3x0Zm1uJqnOOD3sf0VoyhNA3kGgqvBMdXVLxQ=
Received: from SG2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:3:18::18) by
 SI2PR03MB6439.apcprd03.prod.outlook.com (2603:1096:4:1a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.24; Mon, 2 Oct 2023 16:13:54 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::f3) by SG2PR02CA0030.outlook.office365.com
 (2603:1096:3:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Mon, 2 Oct 2023 16:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 16:13:54 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 00:13:53 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 00:13:53 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8678464742; Mon,  2 Oct 2023 19:13:52 +0300 (IDT)
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
Subject: [PATCH RESEND v3 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Mon, 2 Oct 2023 19:13:49 +0300
Message-ID: <20231002161350.64229-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002161350.64229-1-tmaimon77@gmail.com>
References: <20231002161350.64229-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SI2PR03MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: af2a3897-5529-4e03-7a89-08dbc362931c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k5WP50EDARRw1Dwe/ppDhQ5hnzYhj7ZQSBZ4IwGRqhQGuYzvesm7JpVMoLRa?=
 =?us-ascii?Q?mVAeo54jInhXveH22iTsm6WMglBIp4A5UEwfbHsug16PlR4rE5uMkmRpMUaE?=
 =?us-ascii?Q?CzijUfRwWWporirBimA3ifwlEGg0188wPEgnZJC12w1ekZimqepeS9hqX44L?=
 =?us-ascii?Q?b62XGQ/jFPiHGCyAzghwfvBZRig6Vz13m/u72LiKgkdKEFmfPmJWxXqMTx8x?=
 =?us-ascii?Q?Yaz5/UO41sGnjORCpkx0N4hLhnfbDx5W6q2X4TThc6WD+HzhErhVaCEQHkJr?=
 =?us-ascii?Q?MMcPSjdhcrr5VwzWqUKHkERF2dAmMxtJ7G3Y8q3QInRjQURLORDiAgKYeD68?=
 =?us-ascii?Q?9WRn/BI4rpOGVfWM1mCtaZDIrwo6eVo+CePpAjeibV5vypCK4xXYxxJIv9Fu?=
 =?us-ascii?Q?hOltB16qijU2y8en1jj3pIVmzRLXwfq1RBABgiLVMg+x2U0hMD6ivOP7KIJw?=
 =?us-ascii?Q?4WlFkWsb9qzSxcWWuiO0xy1Xevy+9A28iSmG52uyViUKvDwtj8QhqWhCw0fu?=
 =?us-ascii?Q?ca0ukZcAhuOxZw3AR/I3pTz6U78WEHfsOqYSyGQDKngRx6x5+rapgvTj9Mo/?=
 =?us-ascii?Q?gT1jLnhqSDjC+TJJ44hbIPSyWVtnvXsM1Lae0ir8fA++c1GOeeLysc7Zt/39?=
 =?us-ascii?Q?mRBEJUhmsLJGRlsq68aDeMSPSF8nQ46ibEUvjjehCcGJEY3cJaUVh72BoHyd?=
 =?us-ascii?Q?G7nNib4baGIMZH2oIbw3FcSwkpt9WtvWPduK4MPfb0OzAEp15KbzGtY0IPGe?=
 =?us-ascii?Q?zZ4795kSY3Np5+t4/UXuWBbbJZbS7WP4vIiFMaJ3nbvoVkpif1H66O8IAqwx?=
 =?us-ascii?Q?EgpEDxLX7ag9D8C2opzGuMAfmnFMgreFs8ufelooVK+M8KLllUEfj6JFaMMh?=
 =?us-ascii?Q?IiNpIcU6B9tOnuoWcBJAyCjkWjNh75LPYTiRM8lFo5umzW6cnrdGXzlx4kXD?=
 =?us-ascii?Q?ddnRRdHUFRZMhzMd7ZkcRWplkaSy56n3pwzv6M0a/no=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(48200799006)(61400799006)(82310400011)(64100799003)(451199024)(5400799018)(186009)(36840700001)(40470700004)(46966006)(316002)(54906003)(70206006)(8676002)(70586007)(41300700001)(76482006)(4744005)(47076005)(8936002)(7416002)(336012)(2616005)(73392003)(6666004)(478600001)(42882007)(1076003)(82202003)(5660300002)(42186006)(26005)(6266002)(4326008)(110136005)(356005)(83170400001)(82740400003)(81166007)(34020700004)(55446002)(36756003)(921005)(36860700001)(2906002)(40460700003)(40480700001)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:13:54.4290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2a3897-5529-4e03-7a89-08dbc362931c
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6439
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

Add a compatible string for Nuvoton BMC NPCM750 and Nuvoton BMC NPCM845.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 1394557517b1..a9e173432002 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -16,6 +16,8 @@ properties:
       - enum:
           - chipidea,usb2
           - lsi,zevio-usb
+          - nuvoton,npcm750-udc
+          - nuvoton,npcm845-udc
           - nvidia,tegra20-ehci
           - nvidia,tegra20-udc
           - nvidia,tegra30-ehci
@@ -388,6 +390,8 @@ allOf:
             enum:
               - chipidea,usb2
               - lsi,zevio-usb
+              - nuvoton,npcm750-udc
+              - nuvoton,npcm845-udc
               - nvidia,tegra20-udc
               - nvidia,tegra30-udc
               - nvidia,tegra114-udc
-- 
2.33.0

