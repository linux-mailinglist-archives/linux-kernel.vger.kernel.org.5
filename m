Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00976357D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjGZLmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjGZLl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929D270B;
        Wed, 26 Jul 2023 04:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE3rKxiMdxa91tV5J9I2kcTRsfsnJSgyogGIaFtwH2yxlkU/SD0ML41ByAaW8nN5505uCSxOYdn1PxaKyfh1KRSlX7HjUxSMGC9vegGiJMZ4K1AY8RZUxJk0JRM3pXboS/NWnvSea1VVfgiJW1J5avdFs4CVqiCWbSLEAhKjTSZ9fjzWt4+o5CK59iBsoHkj9G1kWHZTzLurwHfwC7xHcbTxk/zH1HweS4HmR6hds9iVB9vQ8Il8sFC+FE/JF7F3SQuYa1WsKqPHXbXZw3fJ8iwszwgrUuhEgvrRud3g8Octxiwh4/jyI7TaRJa7V4u36+lpcbY9sIHwfAj020k3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzMK2ZTWQqeEp762bPuqcoSy7wM66j2IA1G0Fecpu7o=;
 b=jMPdjRUwlfQ9P/FPX3Cx+LtMEjte9o6cPhJ7Z256gRSSyy2jrShm+zYvl3et9LqK0fDJ5ncBEmYAY5OZ0zCtd7bqR9b1+XYQqrku4Px5Gc0AUTNBVGvKtL/OPM9OfDWrQ5h89oJQNJxMNH0rNWTlNBA6dWk0cz15RYYU6ArjbiNL+EobWdv6BFOZHW7TDzqP7zlSTWPblk3f28zrW8bZ3i855A7HdzZIkDg4mDo63rsJzcs9XA4nbdNIXowU6mVzNIrBv/0iMCc2c3K11GrE7pXhOLvA1lazQDi/hHhDxQi0gdVftmxj20T2dPcKDzGU/Ueti+NZECNL5hMak78dOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzMK2ZTWQqeEp762bPuqcoSy7wM66j2IA1G0Fecpu7o=;
 b=JmoeQqmQOeFefJtDSSJrYHV/fq4+6RNN445W0rZa7LkCT8/JRm0dvFVHD9zp2255f72+SRPNxxlBV/W7sOqIz6hCVeBYPO/Fjyxzvoci5uF/ln9TVzKANRlZatZqvkYFNlBYe9yuK8OTS8lX2h7eaxNS6W6WLCr0QiBcUf7nAbGlIvoX1p9oxBgDaukUgiUGQv18kT5EpMY28L2NSvPv5CRpACWGWOShaV6+YV+CMyIhTJa/6stkxXji2DFhomRPYUiOx8bFf2EyWvYXC9zyfvM7ZVUo65xlOJWd6OF8CmMOo6oFH6GFA9LEVo/kCk//H/u/lM8dVPPgejcA6kXfww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/30] usb: ehci-st: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:14 +0800
Message-Id: <20230726113816.888-28-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8499fd39-ddf3-4163-b055-08db8dcced16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/XZ770PhXC6vkPEO+Kx2ieyJN+wP7LoW3xd7VFzg9Fxgatc9IeObxDfGG/60xlMHOTuhgnmLU+BBQ2WC+oio9BJYbNWRaECHqY9fZEYpA6QTyNo1wJzBlwUrg61Wyj6JfKcjEo28Y51qkfUjyqnGRzYs5Muu9YYakYghIVGW+BqE6q/AfXoxyAfUZoT6UI7HiZV8PQ2QRjalJVhQD3Krfq/nROMX0kJJbCt8Rb7nZyEce2HpkmvZpmMtoTcR2z1zq8IJdH+LS27pGbyoZ6omAbEDcUza51Kal8hPKqhHFqeKvyIN3ZdwNPFqVk2d2XUi68VTSG3IHoU4/D689qxdxhnWsFldueGx77Ug8cQq01/QGUnGzBy8KhLKHeKqFvVwkhYfNfHq9x+jHP9QD0rWqWFNeLx/JJaSFTWugoiGmLZO2NuNvuQb8+JEUJCoHIC5FyYGAP26ygh57QNY2R6jZ6hCZGhF02yI/b8aSoUa4tlBcGPR6bDKyuF5Ndbu/zP5qn7QKi3NuoFFGpX/bps2UuzBif99e4LEiHs5q/VWz9UxBSba0nVoUrSM3aNU0XCbTdCzSf0bzYLvo8xEJ8BnjgHW93BTvnscgVx4p5Ex9/bYC7hiLzQkw790Q0Lk81C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LobCdko0s++Jgkq2ZXj/KUuPYJOJJLTWr4B/CXOFUNEemoaxW2ar1UNKjYYf?=
 =?us-ascii?Q?5SstIOVuX36N1EPvkFcarFcN277wJr+CNU86rZqYzrflcQRwlQta7FwnVnuh?=
 =?us-ascii?Q?c6JEUU0BL1+jInVOVpR98I2J+0QigfwD153cwCNOXaUJZfi8s6XwxNtRhiQw?=
 =?us-ascii?Q?jNqhOFFWK2ngdZxXf1/PiUP96JHv6TsOwlGm5UTf1kf2z1lnFiWOj6AV6gZ1?=
 =?us-ascii?Q?TfYbcCto8srFuP+15kyg5XOctnGaOmAuWxX1vCFP6PmVStG2pfzVtMGpqtH+?=
 =?us-ascii?Q?l9LVZ4mm00H89wuha+S1QW3tEPa07VQcfRX8MkcsR0yHhEn5IeTPP3qZ9NUO?=
 =?us-ascii?Q?uzDnrC40duMeyaMAGtFJQ7jYXVAhg1SlaZ1+Upxee/MEwoEchiB2y1iTwNQL?=
 =?us-ascii?Q?x92bMq+VW4XToJprq4hZw4thwmsDn2uGz0u02EVN60zkBm060ttg/Qpbz5W6?=
 =?us-ascii?Q?34OsUpl9HUNIRDZbNGc6Yei9AcKf7Z5LhoHFUmprXCki5ehLvyG3HYfDxfE3?=
 =?us-ascii?Q?SCnIQT+aYoZ+0TjgrLLDULMqcfQo7mC2avz9uj0pAFlLIThtRy+dexPbuUcE?=
 =?us-ascii?Q?JuP2vjcUuvKTBsWZyPfTfgImZQT+SoHmKsBZ0ctzfWWHkE8r4odSJp/CLfHn?=
 =?us-ascii?Q?KSDGM+aEQZcYYDvQY32zFz8ko1dGYr4FTLk5vQolDtOEOrn40yNL52u5+u3P?=
 =?us-ascii?Q?A0b9WlBDl5KGHLYnrkt1koCYpZKi4Za2gy/j/4SgHUD81rDH49te3+xzgH3D?=
 =?us-ascii?Q?1jPgiKM/0B90ANeFFEhUd5MpFVqUVhR90q4fKQu7fozLMeJ1ELlQ3VmyiuMA?=
 =?us-ascii?Q?P7pmMPdfxJpzpowXts2t+tmtDhcOP/LdZ/Mb99QeIvceWeeJd3X9pU4n2ioS?=
 =?us-ascii?Q?RqGPpmfcIOcSEO+7ZXyMUdBzQCj4P/uz3fXOfx4noAWFeyOp8ghkuzAZpcVu?=
 =?us-ascii?Q?zpqdij8NSCm4ntrm25dIAak5Gm/dRtUQgfKwbnxkOaAHIrTofhSMFDZgo42x?=
 =?us-ascii?Q?0jA+6vkfjiL5jF1uw5ahM9Zb3UC8VV7ZnMvAeiCmAH1HEBl50bHDC8musi0l?=
 =?us-ascii?Q?DxPntW2P/BDlb9pBMJbVEQRnz+13vXTh9XflyZta5tZEnGKkBi9/iiJcPvH1?=
 =?us-ascii?Q?jC5xbIpb8D0Rj6DYuEhvs6ZaGZTN9tbEl/4JV8vS/rVmp+ym4DUsOMekXlkJ?=
 =?us-ascii?Q?EUBmGpFgYwV1YN/GLm+tZEwFvLB+/dXHF7bHuPERalHPRqLELftnmOXqHzBV?=
 =?us-ascii?Q?H9Tk4YZq98vReL8/2OKU7jGdEZvrAWSh6EPlaYB2FcUxQcK3VnptOMNIcee7?=
 =?us-ascii?Q?2GXPvBGm6OFNAN45aU9sRVrsoDzZn9OIAvidm2N7ikodEGWixLPABkPW8V+q?=
 =?us-ascii?Q?/sfM/NU3jpcJ/vE7WgioHladNDi5PYG1q9WbiJv0mnDiz37Gg4avPWAdzVs6?=
 =?us-ascii?Q?dwE2zOyAEpyhQgHZlBPlfZh+yy2vvuzfSKJekXD7YKN2iN+YsBEuDcQN21xj?=
 =?us-ascii?Q?biqcaA3mr87+PqgX888u4bTm1dqDrkF5mYpvgS2JH1vUoKGFqWlB9u/b5ekr?=
 =?us-ascii?Q?ePXHTkz4BKXAaYij23hr/fe+B/8ucEn6MKUfu49E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8499fd39-ddf3-4163-b055-08db8dcced16
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:09.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxV3iY8qeWG5mBSz4ZJfgjfcd735ebgIsxSuEFMQN/4RpfTUDum5dxa1uY0BHr47qHq9QwhW9/E5QtCXnPuL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ehci-st.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index ee0976b815b4..2dbb0d86daaa 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -158,11 +158,6 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0)
 		return irq;
-	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res_mem) {
-		dev_err(&dev->dev, "no memory resource provided");
-		return -ENXIO;
-	}
 
 	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
 			     dev_name(&dev->dev));
@@ -222,14 +217,13 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 			goto err_put_clks;
 	}
 
-	hcd->rsrc_start = res_mem->start;
-	hcd->rsrc_len = resource_size(res_mem);
-
-	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
+	hcd->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res_mem);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
 		goto err_put_clks;
 	}
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
-- 
2.39.0

