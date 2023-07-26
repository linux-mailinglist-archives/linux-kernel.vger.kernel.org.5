Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDC763565
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjGZLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjGZLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83D2D43;
        Wed, 26 Jul 2023 04:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sii0qku6Dq0XT2I1nKR7Y2oYHoHNqe/xbFLdl7m7mJ1Qb714bQ6E1AG0047M+rjsVA6pIO3HOrzZnweoXABZ+vQm7sdJNUmZSoxiMZbBqhAdCIVut9j6M6y10xfaf3arzQUl0+fBoManxyKb1aXOLjeDHl8X9sVvJ30et8FK0nP5XB2qwyvkfFNS6tPtuzjNA/2gIlZtf0ErFvXFexVed8rWInuiPp9Zg4wOG3n+fvwzV+/X+5pa8gd/LDh4vzfm8J7mi3xZnSgilTl9jf1SJBpiJIR52wbIEVp7Lz1kKS5eBMnlBVYdSIoMN9johtix4FLUksKUZhRjoS8MdSKzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgVqVbMpfc3X0caBRh7jZLKtyw3vW+LrBwfbZKx+AJk=;
 b=HhWqlWOBIgCWkxFHwxhYDkhDc6TSo4Y5qOw/qJucLfnefKQ8F54WN0DmDjNoiBalPp88pCy2R+EYVw+Flps+hfetiL8ODfEji70PgPLLUOGXHN4JfivWwm4WbFwn4llaaBd9fNY+lV7lFjAOSuIWxSsGpqPGO+NQiODiI1ptxWW7Rub61opGIVj7r/MPxaqsO6MutoODtB65ANwR6fuHg8VfRG0fGmPCnjDSbGolbpkMJ0y+wJ1CfowqqwVODZllCO7VzPdjCC0t7MUyO1lB1ELdj5qQnzJo8nz/OgcUsxokqO43illkEJj3UJ8CikWfnegQ3Tm0E2p80oCyhuqUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgVqVbMpfc3X0caBRh7jZLKtyw3vW+LrBwfbZKx+AJk=;
 b=Ir5zKxdD+nqsz0hXhk0B9T6sxC7InTz3+/bZeIuXeNcK7xzFHF8fzbahJRa113mYFlmMAy2fjum/pyQznE8egyDcIDrlTPVluo/PJbM8szPY+38WU+C4+F7FaSji5xHxt6ThVE9qWyiBHSg1M3cvXpIAJ/TKInL9D4jYZE/XtfiReg+sEbYZYRuZgB+F0jEqeShjdsjf3PeVT7IJgGoZhltbSeMX73IVcBc35jDqER/afjPoBFDcApN5ZbAM6OtKN8MLBZ1sIZVI+lTFFgabohD/XnMRGBGl3b+s2tSvtGFLmiws26FudbZuLrK/qVwM8QZFpImTFVPDp9F2t/pAGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/30] usb: ehci-omap: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:10 +0800
Message-Id: <20230726113816.888-24-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 967eaeb0-f652-47a8-2076-08db8dcce94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voxVoaOTgJUifUca2v51mYz9VRWZc2aHt+iu7ZgmxEToXPWN7daX3rva81iHXSj6RyIzjwE3nRPfdUdMp7llV5tNBLiCCAeMChuJ4PaWIarwmh92InBvTH3sn0rzBJikVsbVOGoaxjczyJVFKUk4YC/gWyY+DyTWCY/USnKM45zjp51sbj1mCEOjoSj5L2UKZmmtCekBvsMMCSX9ZLwgda/1GmpFflfSc3dvm5H/hedTeIDBBIiM3NOkcZb6pRT+RpknQclfMdwftBOhXtwSILTypRbvu5D3RzS4eHrDwfOFdqhEihpuO+o5IYFvV32pAp6DmyGTEVWrMVIL17+/FSC/f05JgOwjsSCM8hZ1Pksks0yOvwFLT46bFNVumwjxnjfoVBWCQzs5rCtjKX91AnpMmK4LTtAwwI3SRA6Q1AR7/AKX8mcO8PkC31DvfxKHLPrZg+jx/+OdaYcMYUrzp6o/9m3+xavTgoP27pgbWsK9pIJ1GWAJQeXjMC6E8w5hFhKu/8s/n7Idtw4uFktKCzbu69n/u29QJ/dufMkfa2zRLvQNq7nWfiQYWznm8LO26DhcsSTJKiYHjBwpFD1wCHgxALM3BelImyRq3+Kh83kpcYeFDuNYIArljIzAMrC0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afT3RuB2o2lQrZ/+EZ06PXM4ZJJOP5boOleY97Y447WqAaq4TpmuqagRY0Q2?=
 =?us-ascii?Q?XBxe+p4pslz2oxYfBDJzLhWTU8d7qm+LOwtisvmFqSVhh56hxG9AXQb+7CKx?=
 =?us-ascii?Q?6fR71GngBTcFUaZyl4RSnvl4khxhmURgV5rJHoTsgSG0QwYdyCYSW5ZWYj6S?=
 =?us-ascii?Q?uTzP/Balw3f4CevpvNG3O1po8ORCPPsRX48+nGDWytxWzKzUWs6rCCojzmCZ?=
 =?us-ascii?Q?GwJDQLQVSho4WUI7GdHTSOX1kaoMJwWMGLFmgKpvdbGDTgEJGBZpACuu3aJq?=
 =?us-ascii?Q?ykZIGkPz5W6q8fqD/sXz+CE9GxBGwGWCxttP89F6QLgUwdToVyPnpvtmxkKB?=
 =?us-ascii?Q?C7sf2R7GD2Ljy3r6SyWBpYCFUpKBf41fUwRxb/E1Y/P4b2KYEUOmCetL8/7n?=
 =?us-ascii?Q?cZjrR4UzKaDYhzRjfjz/RBS7mMfTYnDEqAinTCAbCeq3ilsrvQPq7IbeLKYt?=
 =?us-ascii?Q?UwsybaAUDjILL8TjSpxuv7O2CGCuzp74hHzPBxPB9HwUsERnkNPqv+1j0P8L?=
 =?us-ascii?Q?gQmcnYiakGrxsBgqkBnA6GrtDwHjlYLL+8L9+uSb8MeKPba6y0fSMh8MIpTq?=
 =?us-ascii?Q?GuA6srvFvMYCowhycRtD0FH8BG4RbcMc+IlzhcGChizkFhDGclpxeNAG2H4A?=
 =?us-ascii?Q?loU+D6/hxgjdpEJhEVaFugpk1sOyDCc+xM8NfTWg2SlnDm7ICTFg9TDtOa2T?=
 =?us-ascii?Q?vHcf7sIKISDN6MzmBOmxhaBbwIHFbbZ293skUKtoSWw9CNks3Hq/Dm8sIrp+?=
 =?us-ascii?Q?iK8HdelrwbiLOT4pqnSYCUcBjaD2jPokMCxOdWnl1iRe0gZt4onAXf0WKmoX?=
 =?us-ascii?Q?yA4J6AkjxfSLmaQd6nXaQTAfGe7xNCF/W0lkGygeLUwR5P2Q4KC7kKIwi5tT?=
 =?us-ascii?Q?09c7MxdCAuZzA8XA3d11NFg/UMmf1nQPI0GLwkD+mnMlf0IWwG9I8W50eTnX?=
 =?us-ascii?Q?KSd3cnq4cMYLiSuwhN7bf2ZC4llTfnQv9NkANY3rOcrkvDsPYaedeQUE0EKu?=
 =?us-ascii?Q?mrc2flhjiBvsQUc7wZ+TRPcsjZlD79fiMfbvCoIb4352p8LGgtYX7oBR0XWT?=
 =?us-ascii?Q?3EOH++/moCoRrQKK5Vl6u1jUrYYHjjO5D5FlM3+pUqH7JAqiiwNT0wcCFt1f?=
 =?us-ascii?Q?oLEJBQF8zj81IZ2od3wAHsU5uY0HvCgt8LRbrrU4j9k5CNjuUsvJOuHbvvaR?=
 =?us-ascii?Q?iALM2YGX3ESRzCN3OUF+YA8SFiWnHV6HMA/kKr0abGgCFJXyuXR2a/cn/9Ph?=
 =?us-ascii?Q?ZE5biz0PdqKbdiUC2B4C/i0pXJ4hEaFyt5fFIuBGgY38V9U1vtaTatdUpLdF?=
 =?us-ascii?Q?I8SlFtGN1iFQ2iTzJJAYGjUsrF4BJBUmB+/wZCWiGXh3nbS8rN9Hj5MNaHEQ?=
 =?us-ascii?Q?7OvaChZllVzFcZ1EGj/VFjgb/MWku29qa6qne4d6X4H9bq64B4OKTO/yx+fK?=
 =?us-ascii?Q?xoOg0D5q7Ua6dnVQRdiJ3LJjoMwX/wnQ4DevYNhzcRZjkAknvItMzUXfUlMC?=
 =?us-ascii?Q?OBScpKuVtDA0RF2XZbzursC07oRwGvE5WHghvVVbPjlRFfyicJbRLBtfExVC?=
 =?us-ascii?Q?rKy2qWuDA8YWtR3NquxlFmqItIiIbi5cu5u0GXTk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967eaeb0-f652-47a8-2076-08db8dcce94a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:03.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ythmLuXDxVkt4AQDAWK+5kolqhjS5NkPZ8X/8t44KbvWMzViLFFcuhSFw2/13GeaUkCWzVZF6cWMMXrqmRKyUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/host/ehci-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index cb6509a735ac..b24f371a46f3 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -113,8 +113,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(dev, res);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.39.0

