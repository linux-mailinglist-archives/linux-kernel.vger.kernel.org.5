Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C987B4AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjJBB6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:58:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A55F1;
        Sun,  1 Oct 2023 18:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd/5bcBH9eshjzu9/TH0WpJwUW/NK5G6NMwKa9/nmqeXFpBqF3ZJ6dAy6x85QodR4djvNeu1Fh6kIc3xo6pUlG/+6igew9F70qrPSZtk/wJBo0bsFtk43BDikscKpi3+8mnc+zTkYeOV343rM56o5r3qrXSFaxXd3P4mlKtjWgmZHHahsd5upTCHobWLyKXAFFvcS7vQMlxviBelpRK04e8/iEiLSnVO+Ij8Uqb98h5QCvcJSPvIx6Elmr+SJgTjkvgBJok3g5HC21yCCFFcSr2dsdB7EucxLZldAq9ejl9pPduSvSfdeiTQExpuKQgsf/gbxRJSrPJorDCkeKCU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rN0xugcHEdl40amAZLxWgN66eO1OsQTzLQZPVJL8a0=;
 b=fXmPQS2jO7qDS9xFw3Qp0r2n8zcSlaamHZRB93sSJAA3olM41MxZmuCTkCLIhiKHKo95nsDFqQUPrtGVNraTU2iMpc801C3yRj5Z0YS3xtffO7Btn8ptJQYn5FLf+vwE+sl4Xskzin/Rgp1VQn+ckfgARtproJB96sBF9IowapXU907VXR892lm7hJ+gnXmEECDZmlbAMqPJzTpxTCTShuvweyyjZ5iktxWag3gtxoCY3SOrcDcfDL77mv+vIBsiSZ9Vobtj1JQibnEzGLdDo/eHUAE1Af32q5JoAStxKNvfxgtngUmbET9oNUDtCF12s76h7Z9Jj61srovusIo9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rN0xugcHEdl40amAZLxWgN66eO1OsQTzLQZPVJL8a0=;
 b=JFHbPiYKpTmxQFgMf7TzeCwZxG3LNNwLlhRn6djX+OJFCJClC0j0lPPBXzRLl9HDbMek2w5XFppXA3vd1xS5pKknvpX+CXuIIrQAxZDnLHJXGTAGKA/+Mi8HGaFGS2GEsPS9OlNWGqpJHFH7qCj3FU9JClPGoIVEQ9713qVhddM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4788.apcprd01.prod.exchangelabs.com
 (2603:1096:400:279::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 01:57:58 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 01:57:58 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 3/4] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
Date:   Mon,  2 Oct 2023 09:57:01 +0800
Message-Id: <20231002015702.30509-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:300:5c::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3d243f-afef-47ae-ec4e-08dbc2eb0064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTHf6wGg0U0CqPvFv23yr7pZg9aXybhuYpKf24nORGCMTz6N/44CyH92gfE8QQ3igvyVruTCXU3ywWiocqpBr+RuIaMGMSe8Ig902h4TANrGy0N8/w+q3GHmRho2/f5QYN86flWRnK5ksCZjMdpuvUhWkD2QknlN1FkQvb/LVnr8OgUdlH30gAjGT5KjHp8YYO57qcMnD18MFO7nOdbfRD+7UAWG4iO1UNeQ8HMwALfoaVcIatSs2X/JHdOqkKYyLPFhLd8loV71BFwXTEfA19gpDJ6m4DlMlJU5dAFBKVC77mjLoXUz3Uit1Iol0PGxzy1bMxB1ZLTe7LG+k13bhWYby3jnwVyntfF6TF2Wbv7op/U798VBCo86dNrJV68L9eSWSIT4kpsiI2hWwZfM0bRPROm6hb/1ZwJytLxqXl949IBnbOdTo/IGXSErNs6PlIW8nYmceH0LPiPpvfXccenwOOaAbEjie+fUVk1gkOagUILdymyL5SJO4HI1QheWrpS+fqy0vFeNjW2EJOq43hnX0tn74rg8T8lHFYdM0F2ipkGzrE3ZMSKFivilJ6XRZ82UT1OAKylbPzgjpfCEsMwE9Bo2lWuZ1tgZR9Kc80OfHIm6LvXGlFkZ7IGeJ2zi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(107886003)(1076003)(26005)(38100700002)(86362001)(36756003)(38350700002)(83380400001)(316002)(4326008)(8676002)(5660300002)(41300700001)(8936002)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(52116002)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfAPex8DfKpWPOQV4TnkG34KtYxaW7r4b0IiMXZqDc0klRlB8oRzeOJQW8+2?=
 =?us-ascii?Q?eOXS/Exq1zUfW1JTONKdJpZ9GiSFUci2VHmtxj4ou8aEszAXLo3IOFXz6BIf?=
 =?us-ascii?Q?T1Hi+3HTmyqqApHZkvr+3yp9unUDHvCLmK+XjTwgK/qdW7Q3aHcIcO7bbf8B?=
 =?us-ascii?Q?p7Dnbm/YbDAFyWkXgIG3LhsnhOawzemGSyecu2k6yAuyJkE74mIwL9x1qEKF?=
 =?us-ascii?Q?mx4bNGwSTBqylWf4Mjr84grGwVa9p0q+QX5+d1J5Nk7z6NWiq9WpE18r5xcU?=
 =?us-ascii?Q?8NcxOofR/Huk+2pDwWafpONL/klGlmSWeQs3Upm1Vm+2zESJiOoVPXYWbKz1?=
 =?us-ascii?Q?S9TJIERJ7iplTx0K2E69yTf3Hjj7fAjmeCGzN105XU2n0qOSZTOiVUDH2KK7?=
 =?us-ascii?Q?7EGTLeLj05HQaWrQBg0t1d4gPquj7INws112MgERjvzXsLEQDbQZ+TS9UVEn?=
 =?us-ascii?Q?v/myOacdGsoNDeNIZdCp/qMBe/6mWvWPXa3Yiq0RSR1JhTfF2JpzGcMidYrh?=
 =?us-ascii?Q?xwZlsGtOYwSovLcsiiXdk38SYkzCjFYa044rpFWwFWmd8JLathuJz9/t5hp+?=
 =?us-ascii?Q?n9JCTkI9tC1je4xU8k3VdOk0r7KIUXD7Hkl/g/+hX2Q6dIkAgPm6pFof1CzO?=
 =?us-ascii?Q?7cPyT+LIGCOAvzMvarWb+S7c+D5u7Il8JZVVXpNN9G/s9/vFj+U5sLfNGKWf?=
 =?us-ascii?Q?+uEpCfHz3Or+/+Rb6MIOr2R4hDuq2tD2xC2GzlsPql+cm0slnDCU6+7Wm2oy?=
 =?us-ascii?Q?3TLVHQJgM7NynCnGevZaFGSVECsDkwNN6EXTmsihioCfHEG5UbgYxc+PPFX6?=
 =?us-ascii?Q?VkYuXk1v5KFZt3BUjk0RjAIKANxTnzkf3TTyYSTPF4g9+jIDtDcb8z1Wq1hr?=
 =?us-ascii?Q?E+8CfPF92vHPVO7IGE+c2TyUD3tL6fdYci5CtZPCYNRE61oV60BWvgX7+M69?=
 =?us-ascii?Q?yA/R6z0B81OWe2YlpIhVTskrhgV0oHfKUhBKeUUqJ1jVRkilgzkX3Y3kgZM7?=
 =?us-ascii?Q?bgqt3MckcV9dtr7BGRU6BMAGRruWWpwv7SDMhf9uwg9Zpb06z2k87ARrukwa?=
 =?us-ascii?Q?dt27dSMAUaUYTfnCIGeawwmJY5wgYW3d1udNYMELtW6+Cmw7eJc5kNTAOX3w?=
 =?us-ascii?Q?flWfEJJIvXdGB6120n8zunxH43s2kf0FWBaRnv9Hk/LadkZS/EXrndzVHOnz?=
 =?us-ascii?Q?WJ2hvSbV3XM2R7syKCKpFBwO2kFxSOFqZFX9OShGh+fZgXKgjQ+wEvF1Is9X?=
 =?us-ascii?Q?TC8Kb0/JmClKdEC6KZ5nSSGPhYsoIELWPfdUOQkCYcVCDsB93mc/XndOIvNY?=
 =?us-ascii?Q?pT04ICfo0NOB/f+lJT7sFtyLrsRwy6TMcSzdUFX+IAULNVvXwyZI9kjImslh?=
 =?us-ascii?Q?tIwMFwqUGyw5rjTMjNOPKj/9FsPcYZXMR8Bef+4Pxe8Oq2MPJmsQ1CgK5ESN?=
 =?us-ascii?Q?aATHsktA8OXfTjsDa0Q1auBajKLP62QF7l33kTI3PExHL1rGbR2oNWehEe7L?=
 =?us-ascii?Q?IoW+6PVUxdlzGKUQoWLc1qbLX/ukYC32KzttUPo4nb0iEt7S3+P6H1HcmhrV?=
 =?us-ascii?Q?zNe3OHFx5KlTFuSfSxQn/6DkcuXTYzH69tGroLUq1xpul0KWtGcQltZX/83y?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3d243f-afef-47ae-ec4e-08dbc2eb0064
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 01:57:58.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc6t4fZqM+cLsnvzg3OXEWUkbLXsZ7yOARJA7521pUC+7fqbC1Hr/9KGsexh57J3BzqyYjDELM87mHAtn7uKldmyLvR42L+G9OOz4v4MVhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4788
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOXA PCIe RS422/RS485 boards will not function by default because of the
initial default serial interface of all MOXA PCIe boards is set to RS232.

This patch fixes the problem above by setting the initial default serial
interface to RS422 for those MOXA RS422/RS485 PCIe boards.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 39 +++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a70546ac361e..31bfe5381000 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1890,17 +1890,54 @@ pci_sunix_setup(struct serial_private *priv,
 #define MOXA_PUART_GPIO_EN	0x09
 #define MOXA_PUART_GPIO_OUT	0x0A
 
+#define MOXA_RS232	0x00
+#define MOXA_RS422	0x01
+#define MOXA_RS485_4W	0x0B
+#define MOXA_RS485_2W	0x0F
+#define MOXA_UIR_OFFSET	0x04
+
 #define MOXA_GPIO_SET_ALL_OUTPUT	0x0F
 
+static int pci_moxa_set_interface(struct pci_dev *dev,
+				  unsigned int port_idx,
+				  unsigned char mode)
+{
+	unsigned long iobar_addr = pci_resource_start(dev, 2);
+	unsigned long UIR_addr = iobar_addr + MOXA_UIR_OFFSET + (port_idx / 2);
+	unsigned char val, intf;
+
+	val = inb(UIR_addr);
+
+	if (port_idx % 2) {
+		intf = mode << 4;
+		val &= 0x0F;
+	} else {
+		intf = mode;
+		val &= 0xF0;
+	}
+	val |= intf;
+	outb(val, UIR_addr);
+
+	return 0;
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
 	unsigned long iobar_addr = pci_resource_start(dev, 2);
+	int i;
 	int num_ports = (device & 0x00F0) >> 4;
 	unsigned char val;
 
 	outb(MOXA_GPIO_SET_ALL_OUTPUT, iobar_addr + MOXA_PUART_GPIO_EN);
-
+	/*
+	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3**,
+	 * the initial default serial interface mode should be set to RS422.
+	 */
+	if ((device & 0x0F00) == 0x0300) {
+		for (i = 0; i < num_ports; ++i)
+			pci_moxa_set_interface(dev, i, MOXA_RS422);
+	}
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boot up.
 	 * This hardware buffer is only supported on Mini PCIe series.
-- 
2.34.1

