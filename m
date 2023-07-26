Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA66C76354D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjGZLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjGZLjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:39:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C13E2D73;
        Wed, 26 Jul 2023 04:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9xMoaVYrJH/GrR1aDQuLnoDpV/DXH4fdN67GBGLrbspRGAROxfM3UQT0YwEqf/GMkYM/l/8FXWqzBpt9ZI2xN5GnTsSyry80m5YxqcpHO6ppDMBwaCdPDLOTda+LcQZ3fZw6gwOsb0SGPZ8DA1dhoc1jIvL1xYIOSoqQsgoAgTzv6srqPUJp3xGfQOP6VB32gtT7pQq1KT0dN0VYmQRILJQgtB0NFl6TbeXp2w7aY22F95iCkSoWb7ovSucCQhlWKpHV3VYPUHIZWD1DxJ4Ex9s6bTMGaljfeCpzNiVqfS1ADKT2ofc5iCdy5Rv01xjyGo992QRLo/xyHgAsvBL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC8QRr3SEdUyv6V/mzsB6ZiTd2TxC/JtlBCSiToeSqQ=;
 b=MFjDqyYpRIaf5TJf4kCRAVhPzQ0Jd1GpYl00XvE2bJxZb7eRYrypGHy7SUUhVIZ0FQLVb6StQaY3M3uSQXz2opEQr3NsKoqCUmSyeXoq+25qJkcngN7ex5eKzVg1GpMN7uQ/+a/tZLFsxsHihHGPP71e4jweoIGLgUu8Sk1yrRbyitZ9pTfiHgHg6KIKOCgzc90qd2GNCy6hN634G6VtdWfPjIvmYNnyCVwr7lwvio8sVdBHdMO8n9BmTBkowrtC4ynRpzXH9GY0e80FmQidubzRjJNme1IrqjBkq85ZafFPyj1ZiBjFKE0jS4WcT58QWVl9QRoN6COdZei4LgX79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC8QRr3SEdUyv6V/mzsB6ZiTd2TxC/JtlBCSiToeSqQ=;
 b=KmsqZv92AJo/aaQnqPcI9IoKVF6ByGTruBq44J51tpXzV4xVmotc4RT+hAP9eNzAvKwfjv4s0I3VQnrjk8U0JfCihXQrCIuM9jA0tSq4uO1N7Dl3b2E2LIQSl5KliHH/BN3suc7DCstqE4n3/7kOPirGl013w0xsLe5E9DP4s5pitZntPLZJYnuV2VhSCX8+RNkshCg1vju1Aok3bMb3zFaeV8/4uYfSNEJB9NXNawjZCDFyBd3HmW2o1SDW05GmXToOkenOj5jgUx1axM1g/oyr54QmJsH88rJBSgXPfU05NSWpDPJ2MY/h+w+Do1Wk+0td3adt204HWLNwCdwV0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] usb: host: ohci-platform: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:01 +0800
Message-Id: <20230726113816.888-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7339ea2-34f5-4e07-8b51-08db8dcce0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm88aR5vgotnqpVJQxrYiSXdv72MICZc/+ydxs2A0+3yVkvOU1GuFJtvT87gGaIs0J/EprU47kVqe9gIA4Nsaz3MgMK8BY74U0k4guRSb3ygAvK7nu2aJkagUCQEiuTEijdt4lYh0mCig8uWzns1n70m5JS+KkVlDrmzxy6PA1PI2hCuyp+XCQEVfI70vm+Iqn1sTTGxvJq2DBpFJzy7AUp8VYsvuD++WX0Rr1+ys69JnS1NQD6BdiNYC4xMJB8mnTaJIMf+0GdmsvDtUKhRwofhQMl70mU94XwFF+7QvZ06x6Mwv8f6MjyNNruN1Ap2VGWKBkpX/RmrxKIUsxcZ7rHw9pJN9tu4r71XOpMhSlqb//k0pBFKD6WZXOFQOMAmUZEMsduL2xN/fJoIK0Q3jxDaSSxM+YK5pwhtDk5Olyv40nP+4sl5qWsi9AimXutmlIJcLLV7ymJ4KnWql8cdhPkfWadudWdPbH4+zPZKEvnYH0SBurfITGmXB7q7ODy6Ek1oaK8sXodowea0cU4pgO+BHIAYRqZIQR2NMQMP7T9L7AGXjiX2VBJRaLjlmUPPNg3U2KqahHB24gSSwxGVqoX1xHZd5THrawe3DAMqvEQjOCwICY/7BmVScvTRDFGW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcOuUn8k1/Iaxmvp5KPHpcVmEbN7IDOIi8fgxzszKZFAG6i0bTKw3v4Hn18A?=
 =?us-ascii?Q?3VXeZpZcpbJPUK/jUfU2jOUaHw3fw7fdmypa6yVSEbGgrGcC41b9m5Mcxeja?=
 =?us-ascii?Q?1q9nma6OFZqZWEqfo264xJ9mI309bc3xKq52bNayhEx6u4FBTQsJRJcwWmNo?=
 =?us-ascii?Q?CtRdfVdKvSQ9lxo7SxWUFkkugvY51IhG903LCe6G9O9HDdwo53HHjraGUbXU?=
 =?us-ascii?Q?r/TjasV/MbmNHP0z+3Xf0mBRoESjmKqov0PpOtkHxdNHMYu1S7od8/U21Ecq?=
 =?us-ascii?Q?ntokA2IfU/L3ckZCATyQp3BH0JxCErjocdonnVWUot3nkMPccpVjdj+Relrv?=
 =?us-ascii?Q?loC95071W2IZuEfaye36E8H74ajEUlMIB5apyXEfB/8xYPaf/cUieVKcMBLc?=
 =?us-ascii?Q?HfXtTL2jlnCmybM2dQNpoVQ1dDNYUpyN1FA3qAqlCs6j8CCvtdjNvFgHi6Ok?=
 =?us-ascii?Q?0AR90GsN5fVNBi2d0u6Wsiy9tfcItVl7PjUUEgPpE2UGv27k4joYUmmkrXOQ?=
 =?us-ascii?Q?wUyQ/KyXNMEn81eXVXvHDP2yGd/ZOL2GtFalKICJI1u83htEVQ9LpBZ0ka27?=
 =?us-ascii?Q?g3wA11HHbTxmriChir/lrgnS0MMk+t5wkFAm7vN28RSRSBcIt4y58BmoyNBs?=
 =?us-ascii?Q?PRIPUhvymaP5svS8WH/z0Uoku2ZsJYmLPh14MTCTf4l0ezGKTWVltL9M9q5j?=
 =?us-ascii?Q?vr4yL9BF7dULRYq2UO8sqXF7XG0eSQmF3kL+l6ElgcPM8zwuIyM9BuMEPSKq?=
 =?us-ascii?Q?2MM2iSxOKvIwct4aEFW3MPgSmkbpnyxQs7R2bPNcpdcFPu2AaouqxsaehK10?=
 =?us-ascii?Q?7uekaXkjoA+Dlqyl93+SQZIFvglMubbcZ+6XACU9aymYgAY7AnXOvx9Gej1W?=
 =?us-ascii?Q?+jPIPnFyuqpZ8GhHK0Vfu9eVEVhj+4NSBRARve+XrSC6EErWxyc74zFD24FE?=
 =?us-ascii?Q?fpdmavlOUsiljlj1RIv/PW+B3V7Qw8VZD/7HNvWuoSJgBAsa50LkuK70sDei?=
 =?us-ascii?Q?gBl2S3AJyfabf74j2EOyZCY27br+mPlycSx50hnh4MWrPaAgBYzSPJ40jSx0?=
 =?us-ascii?Q?IBSmznLRj8gm/dXvTZLBpq7mKqlyRfVQa/d+NOqd5LcwnbJX7NOJXZCcKQHw?=
 =?us-ascii?Q?C0DgvcEkZQ+IrF00X2uir6IObF7QapNYnv0SDY/2+3vaHTt0T6UXw3usiaoK?=
 =?us-ascii?Q?V7hERnLbugKEDlgK8M+Y9tPUNyt4VwhCgs66Ar/YWfQQHWfXcWwM+e1/LQVr?=
 =?us-ascii?Q?6OWkGLyyJ9UO2+QUGqGLFC1MxncBoiElYS2l18fDNJg6NbPuqt9BC2wGHAON?=
 =?us-ascii?Q?fv0skn8Zc3RvOVVPZorxktb4ijiryp6Hla/naNHsglqylBZTxRs6KH6ptY+R?=
 =?us-ascii?Q?xXhhMiguQZUmCwL4kdPS4+rPJIDl95jZS6tUSxjUPbAPEXV5Wd9OHYae9lxJ?=
 =?us-ascii?Q?RFXmW0oadodJPzP+cAsCNr9SKDRd8yab+E5RneHAbmw58X3+fH2Lm79g+uMA?=
 =?us-ascii?Q?qjc8+ntdZjqZuxlgQKu+yVtRdJTaj0fE50w1knEude80VGStIok/iD+5eHuO?=
 =?us-ascii?Q?H/0hoRTYN6vUAdosmF/cIiNBCUUrSmbKblS/zZsq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7339ea2-34f5-4e07-8b51-08db8dcce0ed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:49.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Lh/vSSUqcnWEOqV1yYmO6UcsJlQqAJLnQY9v3xTw9pJOEG9N4o3SUSJMFWVn0ximhCQ8TMPIVbFZwZ6vuxi8w==
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
 drivers/usb/host/ohci-platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 45a2c981319e..4a75507325dd 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -200,8 +200,7 @@ static int ohci_platform_probe(struct platform_device *dev)
 			goto err_reset;
 	}
 
-	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
+	hcd->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res_mem);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
 		goto err_power;
-- 
2.39.0

