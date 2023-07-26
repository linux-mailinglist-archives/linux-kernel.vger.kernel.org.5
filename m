Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3376353E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjGZLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjGZLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:56 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137432D59;
        Wed, 26 Jul 2023 04:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9kPtpvv5Wz9q/4gzg2rcq15Q8peJB4xFcfjIBn8Uobhxb5ED7HHoHdTGHs9iO5WXO9mvIuIrzq3beDHzIo/WqiqqZ/AJprV+JPnsgwbPMT9Edi8o0041r3mLZi0Rv1Gcue0hM4ELPwNlWKUZ0mlf6VQTZbKpTPSzSRfY4dbpHgDAsipNKFyo5pmnLXKSmmn+8r9nnEzsno+30Hu01Jt7P2nF6BRl2ZlnTAWG3ZlMbQJMsdpqTps4ncords3O7kf/jCeVUtx64HoWWS8DtGiMUooBkVprskSwFtjqZmjsi5JsJSRBc+cGiH8HkhpYH/r7cofbFRQSuBObVtRgKMa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3EHBd0GLFuqDjEpIfgLCex8PV5q87ULfrJ74sCwY+k=;
 b=BzhNQ0uiBq8dhDvtHokXsCeiuhSOsdZpLVZm74a1Z+3DROSylkidoSFDj8fb2t9eEy/oyjzaXU/P6FooNRz4fukCCdY4FbupdbiNYDFR2zaTZx/Nj8z9m3/tjnjZkL0OPfKNC7tFW8uP8LLq/7B0lc5nrjBhoxrGQdFbjktRGmZFIq1hK9vjfGPA4LjqRir8iZixF536ZGe2lMSy0DxGc5WcWzCJTPBpn0ZSv5MQt5UO1APnTQAK1kTXGlZ5i7Ea4uzeqHmGXU+jBAnDLslDc7ao/8KIZNsKsTOPl/kKnJMI8AWnbdt+dkjOp2eNs+DP28CUa2E4jlLy/Tp3WxbNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3EHBd0GLFuqDjEpIfgLCex8PV5q87ULfrJ74sCwY+k=;
 b=VGYhj+/Nyf/M9ah7WfkhReIQIJ406pTiFAMWm3vP7xYW1LG/X4VCWyh+aNrJITRIRK+mmB81F9iAAStFskqWKoq4mRGvCMV9l9wGEzLwfbIKA3AnNpv/Rqll8hp9xZRfDhoaCsTRK9vxMUnkBrTeqPmVKwEtNCu3MR/PKKwg9sBiiqm9IMrIr/9HH/OC6TZlFaQwPLUSZTJRKgZp2991AbsBdC1B9zmDrJNQwlgsYh66t4t3JJlN1IItw7x/jjHAkeniRH+NUgGLNVR3UsFfoc3eClOnwE9DYvHvkr+9CzUxbHjlDr/5dFUH4oJTx5N4DP3RhV57Fiqnwq+nByvg7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Cristian Birsan <cristian.birsan@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] usb: gadget/atmel_usba_udc: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:54 +0800
Message-Id: <20230726113816.888-8-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 522c617e-e95a-4347-c42f-08db8dccda9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhHh08bJpLmjZ/fzOLIqrRfHAt5qAvlYhEN2W+T9Q1+TfP1eGW3EJwzCz3q4GYSImYmK5mwWucWUDvUOD5st18PPaeRhHC/O61hIIPQaWRpMQRQbEKabOauQwlrKbNQryVRZ4qvkstSnC8ye+EfvzPknK+PCEWHKgE5ImaazrfCB2wCrxv8+R0QeqL7KUstMzXBOtK4FqstB4cWcR/WShXp0fgdGmXfUv5vUxCBmoYWozKNgIiWMSoPqVy8KrXbOVL2S6Sa6DQlwvw5uOQs2wQonAsteoI8dUZirZI5o7mi2ou89CbMrnv7Y/yAEHLCdjz8pb3ML05N26r/ygeiKTEk5AojAV0YUiBJoC1OA4N1tWj+t/+gy7kOYgeWMHbG7tSlhlKWQG3BLEmXH+bTVd4CdVTN2kdQrm3Hjd9oIMtpFFKE1sESRMrfUKNLbOgnIFvFUgN5xD1u3pNVsG2rVzKECYjzn1PtTfutJDuI1ekz/KcjnhQWsl86qAXEve3sUKKWF2QqkCLFIE9AG2ZhWYLRcTORhFBYAzfeq04UN34uWphdQrEiv9F/3+QmFQ3GQc5L5Aorc5wxAlzx5vGP5PN+Lxd7VXtNjJ1rqkBYq6Dn887Kk0x+gCZnbVxz8b5D6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQcIc800Di514yuNL7cZ8LmtdaTmxQ/yiRBumB7D1SZrOm97xVqKDdbtWNNZ?=
 =?us-ascii?Q?UgBDHFkbBjluHrcgPyiAyOzVF5rpnvil5+ksDbuUd1c+seZLZzu/5HtfFTjX?=
 =?us-ascii?Q?JAbZw6dlzTwDs+pS3fuklvvCp2v/8bCJ8lrzzsxDgy5EqtFckBdD0MlOL/NI?=
 =?us-ascii?Q?8in8NoLjLVzZhVBTNi2qdirDhKM49cbVcJdkgpyz2NVwriGPxO26tz0N+1b4?=
 =?us-ascii?Q?fMsfARSW4J4NGvIX7pftUzYM8oO6pDVbPi+kkscB9CSwb/NDeq34X5Gdr73k?=
 =?us-ascii?Q?Amq34dLtSfoYfcQqsK3uj/RXMr2N3jUk2GFWuSf4sJSYRStYbCB4qOhRW3re?=
 =?us-ascii?Q?m6xt8V6WaQFNN8e1WcMz/bvUp96Ed1azXdt39vPmp3yfgIZZl3GNoDrY/Gh7?=
 =?us-ascii?Q?IHOald6Eucr3PyL+pFl5LgrimR4VNJA11ztySrsqey0jEjUTlRg3txLkxpND?=
 =?us-ascii?Q?ySZ9tXnFPZUlZGsIxy18Djp4y8Jgj3DPqsEDSdQbIp4TkkG0wzY3KcmMTS2S?=
 =?us-ascii?Q?23RVWmy3IXMz889bkTJaF7nvTL4lbMsUGQ8Gyze6mUDhFAjtCEOk40V/fSDI?=
 =?us-ascii?Q?SoDh40Ai3gaQchX90v6DWn6c1RJbJNKsOlJl18R9mTCr4psG9fHf0bYT6ss7?=
 =?us-ascii?Q?/UzNrV+8PoRnQueGPACoUmQHnZ9eRRkT0Jql4gpz3z6Wxcha2Y0gcoyVgue/?=
 =?us-ascii?Q?Gza0OcCCWOE4wYHqb4A83ctt117ugHTmEXEePmaj6qP78f344eqqJzwEzJWg?=
 =?us-ascii?Q?6IaENzXBc03vYnWEzW7o6hMRKRHNx6sNtLgtmDDXzpXE1XnGuwXJ9hobzou6?=
 =?us-ascii?Q?6/sr/T+gtZKTFoC4/ytjT+HWnP6NrXR9APy0UijLP3yYcXTz4jMTwFaPaLtS?=
 =?us-ascii?Q?8BstBdJ9HdkBWOhx9LVnGO3k+vv7/ch9Tss7llF0si7CFhYtnA+UwRW1Zyn3?=
 =?us-ascii?Q?OWknwaYB62Yd2ANa6ugDwcKBnbH/1m+lg7LbmkhIBEZML7fgy8FuEUNJbG8v?=
 =?us-ascii?Q?5tPhwMC06MEEg3fVmaHcvnak484yBGTbK4CaueuE+ufoZDyv/ThrKEHNjelh?=
 =?us-ascii?Q?/qPC9roFsQjm6vjsxDFtRjvIbtB84rxcbUSSN2dhBhpCSFedYRIhcEYbQavA?=
 =?us-ascii?Q?bKEmBADV4nqOCfxRwIMYEALkZwTtzo+h3Q5A+A8O7FoOfcEeBPyK5nXMsZZA?=
 =?us-ascii?Q?14jQxpQFOlUgFGx520QAAL+7TeZIWJ7Lg32KZkIP59G3nXJvoGovaiDBdwoH?=
 =?us-ascii?Q?wFwQfDRsfjANbmVIsInYJxsb7/PgZVoqP/ZyZuKVHxLXjpjG06TB10JJSdR1?=
 =?us-ascii?Q?WDAhMv+qhdOMYm8N3gOBdhtZz+VZbvelmxAFHvzR1FTtHsyVrTdQ82K+THUC?=
 =?us-ascii?Q?LmyVwBlNFzrG69WBQsICth89TiQeXk7XSqyT8tt2oymtW2b+HH2EODALzYHv?=
 =?us-ascii?Q?M5p1agNxyIAxnxEop8Wb9zfB9Q6I+fC5BTD08gS/IG7m/wJ8ot2u4uN8N7Ya?=
 =?us-ascii?Q?igmwyLz+UBOx6fMTbSLXtEAe4V/2POzFMRyOEf2+fAy+uaIO2If1Fvu5L26n?=
 =?us-ascii?Q?vrrN5yHMgL03bksNxWqaAMzxqy0Uq0u/dnfdXFpN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522c617e-e95a-4347-c42f-08db8dccda9f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:38.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCv/0DSvtTZKzcZx01YYKB/7ITMitUVnnTKD3ufUYGibdy9CSZpgnWjngySUfq+xF8lGmLrVv0DVEHhzxuBnMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
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
 drivers/usb/gadget/udc/atmel_usba_udc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 6c0ed3fa5eb1..02b1bef5e22e 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2285,15 +2285,13 @@ static int usba_udc_probe(struct platform_device *pdev)
 	udc->gadget = usba_gadget_template;
 	INIT_LIST_HEAD(&udc->gadget.ep_list);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, CTRL_IOMEM_ID);
-	udc->regs = devm_ioremap_resource(&pdev->dev, res);
+	udc->regs = devm_platform_get_and_ioremap_resource(pdev, CTRL_IOMEM_ID, &res);
 	if (IS_ERR(udc->regs))
 		return PTR_ERR(udc->regs);
 	dev_info(&pdev->dev, "MMIO registers at %pR mapped at %p\n",
 		 res, udc->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, FIFO_IOMEM_ID);
-	udc->fifo = devm_ioremap_resource(&pdev->dev, res);
+	udc->fifo = devm_platform_get_and_ioremap_resource(pdev, FIFO_IOMEM_ID, &res);
 	if (IS_ERR(udc->fifo))
 		return PTR_ERR(udc->fifo);
 	dev_info(&pdev->dev, "FIFO at %pR mapped at %p\n", res, udc->fifo);
-- 
2.39.0

