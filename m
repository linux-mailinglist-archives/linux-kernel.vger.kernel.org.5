Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9007635B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjGZLzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGZLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:55:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56872689;
        Wed, 26 Jul 2023 04:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwBhFL9LAqOzhJ1oxx1+6a/sSmzuCIoATAnqH/mqTpjZgGRlM+rOhKWgIWKtPeod2EkdfLNQaEWofUfVQdS0algYE27uyFa3dFAOrHwo709ijp9IvD9WtYL+SqU6wpN/Uyg7ND/2L+UhCSARqB0q790QjpdmGX6AH1DtMduXTvHeS1KwUOD4SL4HqwOu12s29J4S2+Nc8u+eP1IRyaIAMqbB983d2tB+9QtKd2wJSryNDhaFo5WSe1CVU36zejRUH/owbhfVpfycxjh0KwTbViGqniaElDxLSktYLgw6Jaca1zXLNQ1P9v4sXWl3UwcQAhQmaBFFoChIbwFT70SgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnfbjeqHD1XwkkJ+9QHWu/ylJ5tMoFoW1waI9EW2pfc=;
 b=cq5peJEcgxHx0TZL2gwM9/QaqQefb8dXUnFy5wbmphfAcCivXWgdHqSSuJY+yPOqkyOyNIMmloMXi5NS+4Lx2VCpmzOvk4y/awaOJ7D6KWmAJRyq1qkLvNztT6em2QEobnKw4WLtsXtq7X/sF5uQhL8TxL/fPFMiM6qP2EnNU7xtKLUVac6saUpVeOeDuZ/erKHkpIS3KpHBNmSeYOOuc8tyRpZeYfgUhUg/DTUcAwXk0BYd23fB268i5qYBWD6e4IgdM2dn6khGQsBg6fOXTgOw1n55gy4RzVQ7On4EW1BqNlMgiwVaVy7XUlB2rOGoqQ/mbl9n4MQOe1AuvQ627Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnfbjeqHD1XwkkJ+9QHWu/ylJ5tMoFoW1waI9EW2pfc=;
 b=gKHPwy5tc/iPQKqz0wux7gOz4sL3KQoAZzRbl16l7EC3d6/4NZWlnuVxGIKv3a6t0JVuw6zHepEKfSFamNlHV9Dqw4/pY6ytFXMPBiU6gDV6P8zA/lw2ryhp7pp+KI7VsqvUSr8RnHAAiLBLRh31tHrVw61TUP7axFSag04lmduu+jyRiY3c7PwbsOvE11rxrqeOccgeqpiSxUXMtdP9ZnNFpTUGmBipEJe5t98eIVBbzjBydscseJUZYCR2lt7pmZZ0hhkBcNX7guZYcM9uoUPXlTnrmFVM3NDpf6uQjtU9voFYq3wz6jl4DOBwmm/JboP73RgDRHtfojDjZFCj8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TY0PR06MB4984.apcprd06.prod.outlook.com
 (2603:1096:400:1ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:54:52 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:54:52 +0000
From:   Wang Ming <machel@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] host: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 19:54:28 +0800
Message-Id: <20230726115439.5640-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:15::25) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TY0PR06MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e02e7f4-7877-4050-b26a-08db8dcf1ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C570Yu9oLTGmqgeqKOCg38n6JHdaN63kHfwMZzLgJXW6ImUbiFMwH4uBJbeT0vRMEXRuIIR9Vp9fakFIJdLDT+yYrcWO9vLGhAS7KxM0FqHyv1nbMVNvwy3PURaRtJ3F/2xpp/bp1XnV6NAJqrE0nUQGvPRH6/v8IVPkmFsUTQHoXQlDLf8YJfT3H2FRViDEO62R75GA9OzBbzicjsf/7qYbUKO1UALsbWG6X1Vc8YodlT/9vsQ+l6ZvcrOuhqq5KyVwahcOQtm3bvDJBtHu9g9d82keq5DrHlGia9mlwXRTS8vqt4bmPxdw2VczagewocGbz7KNFgn6KyDIUyXxWK4cNldZ2O1im2qxtQt3TVfMb1eVRvkRPob2TbsTJWrVnxB0QISyxk7rzb/0NRD73L18ntlsSa0Tq+wNjnJq30hZZ97S9N1f0soiv12eZOYDYEsw4h/c3P/setPwSTM0zF90mQpUVPyxOHyeyXqVk6MjIJuvP/Fn4pYZ1MnTZVOQXhlWy2v0zz/08XMf2Ux3EdVuyeIVgmpYqGEwzi6pAq+WqZ4MVn4IezO1GNryJ7sepYHiCdnkHdLOovwbBU2ZjCExkc+P9vWkyXpmvk7W3cM8qQMO1SHqs/XQHlEhCM40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6512007)(2906002)(6666004)(8676002)(4326008)(66946007)(6486002)(66476007)(66556008)(36756003)(41300700001)(316002)(110136005)(83380400001)(38350700002)(38100700002)(6506007)(52116002)(1076003)(5660300002)(107886003)(86362001)(2616005)(26005)(186003)(478600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0PGqNgNcGGM6RTkMsWF9yS5kdzpKIhA1n93DduMVF5NjVIcV/yJDjoU+y6Bx?=
 =?us-ascii?Q?W/36RwBeKkAl6ciNEgLMTP30AYerMka0AaktAwCHZC9KUj+yDGLqzeE1lNO0?=
 =?us-ascii?Q?ByAMnLcGgw8KvrQI/GgFZtJxsEz+759oDG+8x0aWhhJeHKXo8NAZ9QFPojQB?=
 =?us-ascii?Q?5f1P9mU5DrY7bEeaQAhKWRTUEKxiGxRWcdG4cg7jSSFJCNIk72KuJsDODC7Y?=
 =?us-ascii?Q?GdcfWoVLgADyA7VNigFc9d5ZlKR90Leai8Rpk65UJN8lXg1kRUUMSykzs5q4?=
 =?us-ascii?Q?410rqRp1bnXDFdkCa/lTrWbL8lHUgiL73Lb8wrWGTDR4gJ6Wjw5z5MEsvZvl?=
 =?us-ascii?Q?kulqb6uN10se5r7OSN5H2jh19i0vQ0DL8MY+2UZXr19Oai86rwcZWfDN8FH4?=
 =?us-ascii?Q?OGnVvuzNV+gFxgEROtkZ5yRoHuP3sMm4OlvjJg+b2XO5nTy12IoBioMUsKGl?=
 =?us-ascii?Q?FTilwzIMY1htUryb+fDlNm7Jy1iNmnFvLlfzOxQnasmbmn4mfYEr8jwW9aBm?=
 =?us-ascii?Q?wCcRb6zsDGkWeXA8cs7HTqHhnqMKvTATEJBDbX4KRPTKdQyhpqYd2mHqNBlj?=
 =?us-ascii?Q?TL9GlpmxNWonQFVduaPnMPVRwmD5VzudYIQgcT3YI2JsbzMw78hQF5WJCLcs?=
 =?us-ascii?Q?7LkM6V0SBNjEfSAsLNAI3KW9G7JWByanpxn66KFo6ejCFS3T+r3zqlEfrhb+?=
 =?us-ascii?Q?EhyaEIWBOoSllaXQAnbGixRgJEwFdbmaiCDn2AHBST4GvJfz5sZ/DbgMfuaZ?=
 =?us-ascii?Q?ZusCzorh1TiQCSdyJR1HxM6SJ5F6tPp9Ro5xu6vGor2LTIIKhVqXGquRNkgC?=
 =?us-ascii?Q?PD7Ja6xQ2rrgio8U66RwX0n4qXQXmdPVvayDHDthu+/oitYNdlX78k9OHwvR?=
 =?us-ascii?Q?W3Dt0nAINetKmAt9zLubTKd69YNDAqCDn5barL8wkdbkXNNvCWkY9RbdDeSc?=
 =?us-ascii?Q?AlxYAlAcT53FoWmqCstSLPmPqBbr/UGxeHvfQZKRACxOjqBg77wyER4Wc/bR?=
 =?us-ascii?Q?cLWOqvd2uqOaWnno1RCGGgh6Y6MhrWSMlTOACTkHJH2chCH4ZXW1ytz5GTTU?=
 =?us-ascii?Q?egK9zolIAaKzSvJ3WEHbko0ktFSaorBVGIJ0JQXvJDnmwP3BwazXVbPRdT70?=
 =?us-ascii?Q?DaYdWw3yDnBpsGvCX+QU/xTeXbbpwwVHy0TkpLUaTtOtfHPA0ePq4SpOPbfV?=
 =?us-ascii?Q?55TRFSJ59tpsavZPw1Uc+GXpbzAgJHB909E6V/BkqSKTMhDRQ5uhBnD/oUiz?=
 =?us-ascii?Q?oGXoMuz5ON6jb8wP4n8dOiMugpRAXIhQvuO8J7WSGkv/r5y72j9Mn3hTVlad?=
 =?us-ascii?Q?OwfoVEIXGPQs2dERpjI85SfZ5xvVwZZ3EiD9D3bjJcdgsx9DATdw3JhEpDfy?=
 =?us-ascii?Q?T6SnAXFZDKAV/BH7CkCGVYZEgKqT1M6eYsMC7EBaMnDkkICxqCHCZA2vnLkS?=
 =?us-ascii?Q?/vQVGh16hvNpONu9UuWMuEfDeOGOJkVJR+GHAR3bFyPqYmFlHGzKYmo3Hhjh?=
 =?us-ascii?Q?6+TseALZ7CcoxmKn9vXw70QZiJVfXrSO1aYxDGkjHzgq5ECoXBRLgj4QbGdU?=
 =?us-ascii?Q?jMcCOuG0MODNZEJ3r38dk41Uv0gXXS8McNTxaGUF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e02e7f4-7877-4050-b26a-08db8dcf1ede
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:54:52.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNjnb3qyQqWXGp3eSKWIHmRtroYMq29Qr61nhWXdeAld5jblbfqmiuUk+knTGOc7fS0r7qUSRRHF3FT/VwlrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that dma_request_chan will return EPROBE_DEFER,
which means that dev is not ready yet. In this case,
dev_err(dev), there will be no output. This patch fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/mmc/host/pxamci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2a988f942b6c..4068cdbed7e4 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -712,16 +712,16 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->dma_chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(host->dma_chan_rx)) {
-		dev_err(dev, "unable to request rx dma channel\n");
-		ret = PTR_ERR(host->dma_chan_rx);
+		ret = dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
+			"unable to request rx dma channel\n");
 		host->dma_chan_rx = NULL;
 		goto out;
 	}
 
 	host->dma_chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(host->dma_chan_tx)) {
-		dev_err(dev, "unable to request tx dma channel\n");
-		ret = PTR_ERR(host->dma_chan_tx);
+		ret = dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
+			"unable to request tx dma channel\n");
 		host->dma_chan_tx = NULL;
 		goto out;
 	}
-- 
2.25.1

