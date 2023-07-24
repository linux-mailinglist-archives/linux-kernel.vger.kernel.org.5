Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900EA75F214
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjGXKG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjGXKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:06:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A97EF8;
        Mon, 24 Jul 2023 02:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlRBRcHO7rdl+Y82+uJBU0S8T2I7SrV4Ril0S3KUBCkn2/DosYJvX8qTI9EY3VbgclWcESod4XEym3e8004aCHuseO9psY/+12IJHSejcqY4tvI5qAmAhXrVwcMP7BanjWrjE4if60KeqITtQi0+XeQunSYPhTeBAXTAPSvqySZd+0OBOgipGKi0B8XRb8YaXXcNIb0ZY1XkRrx372GlsjILkPsex/G9PVvuvVWq2h7JQ/d6EjozpaNOn6J4SOIhgOHtc2WR+5zKaJg6TeGzHpghQQR7NnHCQd+TBsd7AfgO6NrTS6kX1o6HO5Bc+lS5e/YPLmBx+5zQOBKpcdah8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyR1yYOQQ6GWca+58ihAwRpXWn7AOrBkpzdRoia+JgQ=;
 b=Xq4rtp+88kak1+DZIcGiwsrVIHHCCjC0bWd1phrPZcA8QEDiHbxnb6jFAg61DXvb7uMWaE2jt1VoIJSvaw+Y7v33imGTJ9odayd+uA1s7vfiEsEyhubVDTMpUC6r13ebZ9ocI3jNb/SeCo22/EPgpRf0fingLXRb344QQlTBLgeOeW+nvd/wXd02MdGNRJRGt20afZ8globSX4in1jJKYqTYFE4UpGCkopyo6pLHt8nGsX57iwoffqDTJhlyCzVmbEXdX1SHqXF0vttF893efJ0dTHe0UFahCRXxM37fBs0shfBFojkD5zXWFB0wlabdA3gcnxkTo6AsgDMbHdlScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyR1yYOQQ6GWca+58ihAwRpXWn7AOrBkpzdRoia+JgQ=;
 b=YBwxRDvBbQxYlhUPnmeBq9Isq3wTF8+WDKHILPKXlax/w99vmnv5vfkMYPad05YmRTyaevDuqjq1ihYpdnFA4hABoQJpgcKaUz4J2kbTmX65HDPnkIsuyjLWu+StOu8qCq6y+ISXWPyDvBAdPlXhxidPAf9WGTBKLV69aMeo6nzdZDSX4SfbzfFT4I5tG0E6Rq31GHaWp1rzaLkmzjJ4fFSz2MTz+aZhjbw+FOaIlIQtcRhBZa9iUaMIRIEsJtE71kbm7/ASrPFzxswfOtVbakXRtD26uEWAEskWNVD5jPwFYxpfdVC3LByETn6ilkLKgnUhx7RTVK/ftpCgJC57hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4448.apcprd06.prod.outlook.com (2603:1096:400:67::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Mon, 24 Jul 2023 09:57:48 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 09:57:48 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Viresh Kumar <vireshk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org (open list:LIBATA PATA DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v4] ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
Date:   Mon, 24 Jul 2023 17:57:10 +0800
Message-Id: <20230724095712.1541-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::25) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be916be-0518-4546-181c-08db8c2c6f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16Svo6wesYmZfpRJSGAiQ5TA4md0z+8H9JP4cMzzTYxVsPLMh9NFr6zf+Z2cPp1qTdJVOxSrxit7KOsRrpoIqMtvj6KgxVVYj9u4dzRFIc/kPy/UzWV/EyeXjJpz6bXWseUeOFXOUmVFR4TSeSZEC/+D2uGWOhVn0EbKNX6+rbvTsehYWTYKL1wcTKys1LwPKze6FSiVLYqR2Ucv1MeB6e4OpP2yA+/fS/dxsJUEuItnbDkH+og+igdXAHyIGft5S7NJpN6jFTuKbps3xFR+tHhMCtJJVFfHkse7ajhM91VT4tVka7KqFzvkyGiRGUc1YIhC8vD47WazEnODgfPCaWhfDe40RvENbVJXylJPvMQt5OX6YSEFuMdFchdmMJBYl3hNWWz7M7VBJn9TPBBDl+bWwptjcAalnYBaaksmL4bu/3hQcBz/sGB63+pvS79rPJ9UZdTOUT7ML25NHseNExMgHz8406IdvDj75gkUKASPb6uKO4KztIe9tAwmBk4tpPptTgofYpb82Mq7/BXDn36WiabEFk9llkLyNs8XH0QB1hdxx0i7HP/L3/nLj+u6/iu2mc9g/SLvX5dC75FHVEUL+6mHRUOnE9jhLGrmuFX5nbTxSr46CiibwfWxdA6R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39850400004)(451199021)(38100700002)(38350700002)(107886003)(36756003)(2616005)(83380400001)(8676002)(8936002)(5660300002)(478600001)(316002)(66556008)(66476007)(4326008)(110136005)(66946007)(41300700001)(6486002)(1076003)(26005)(186003)(6506007)(52116002)(6512007)(6666004)(2906002)(4744005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+1Q9lI6JcKBDUBj/za7UsGvACn+et7+Os0SGM3NO9MlSm4kK3pQHMXe1BJI?=
 =?us-ascii?Q?ygcrI16Dm5j51b8zXFVe32/BHNeicfhgfpZS5FqfQcHIHTLG1sQlWO+cBSu0?=
 =?us-ascii?Q?GAU7gxmdEs3WFixN6Sh9GFwHYTHJOQS0Emq8JA1uk2Dg3cGKTS4v0hsdLSil?=
 =?us-ascii?Q?oySXOsRArkr1On/aN5YdghEKoVdElGBmwA401bKZ7kPYdEfYeJZtfIjbrfLK?=
 =?us-ascii?Q?v9D5gzgLIrlaG/3WzQWqBv8i4XR57tse2BE0c6H6TGrrqT2DzeOoq9xx5XWt?=
 =?us-ascii?Q?opSrnGnBFS/i1Rbnh5T5fpv2ru//cFmbkbwQ09MILh3V/5fENOM0/ZgqGk9r?=
 =?us-ascii?Q?oYzgynwpX5PUvqBAUm/1hh5EVD1s6LOeoLFYyjZ1HO/+Y3plNXvWnXEQHMtI?=
 =?us-ascii?Q?pP1sgMBBlWbcbKItXRxDulN66WmfHrkMM8vWrwNEKMBmNmGkDCPq7LsgX/PL?=
 =?us-ascii?Q?10Su3qQfJuX8m3cHuGHuJkGwuIIKWJlNuSjAmxhvdE2OIdRoK0zR4lYYcN12?=
 =?us-ascii?Q?FqdQzsONSJ4HOL7t+qiVPYnjXovafHI7WNI9HzZ7dZ1HfRKYCpkdYy7B0G3e?=
 =?us-ascii?Q?npRHKRD9CUZsS85PtCJW4NVvbMwDPKqIkioB02OcjgQGlvb/p5qk88AgWwbG?=
 =?us-ascii?Q?ybunMQuEeeE+1fAhstGtPcwNlxbWWUy837IqLiITIjvQGHNdO4hZIK2Rxch4?=
 =?us-ascii?Q?Hda2s1+HCiJ7LGhOj5/lyRenFUbPBuXOKEwc/5sqE5YsSXhb4l5ByxCICLyd?=
 =?us-ascii?Q?rWtX9AyEv2/7/qpTRImk2zNP1csxShoX235Sn3EJDu923vdVMrJfhRK3rvM0?=
 =?us-ascii?Q?UTxxgsUrBVu4ZFgbYbmAV+irfgd1VMhVq1JpX9gK6JzIFxdrOsbGijLNwMDn?=
 =?us-ascii?Q?5JSiWGGKHsZR64uonKc+yNOxvZ5DSa5PRtOUlr8emcPA95v+tqdWlzHCXGNF?=
 =?us-ascii?Q?79cDSmxk3SQVuxkU74OrmlrFEMKmdw0UlUwsr/AiEwNidZfT5pGfI91czIUn?=
 =?us-ascii?Q?APp+TEMvZFb/sc+MdXedleevsiXk+KCsV9dJBTMQ3IIca/ZPptDUWitvSnnx?=
 =?us-ascii?Q?2/Gh7kSfrssj2LNUwLgRRClQYUKfvj4WOgNKtCQSocq7i1RiVGIQY48QJI6/?=
 =?us-ascii?Q?cf7kuRajYpajieCbFn+LDFcrmbX/sonL6LH3ocUAXhdWteC3y2cCSDLOz7lw?=
 =?us-ascii?Q?uHXpt2m+5X3NGbzQecOicx6kdLYTthPGYyO/2934B3M/0OyNOxtiTq7q84ZN?=
 =?us-ascii?Q?jPp3rf/0qn1et1FovkQYELZdOLk/VO6Re2b0Ryj5MTtxfaOpEB3ioNUtUP6M?=
 =?us-ascii?Q?zcDO0X0IDiT112qSpaWWeKb1t251PQB4KHV5dDZ/nQeS00/o6B0w0hQiU++S?=
 =?us-ascii?Q?mHEfCcLYBB9aW6QvZRh6JVyL9fQSvWUFw0pHtlswFjBY5P59eGRXr/gS08V9?=
 =?us-ascii?Q?KHCHCnDGOJGMJ5vtuNDhkGnvWsNZRSsbQXgG0WoElm0kZ2gpzvPfv9DaodzP?=
 =?us-ascii?Q?Wxmr13NGC+iMdXJh95ORIDQiojbFYAzTVnAvtlRqTLOv7EJ5CWiKRVpxWOLA?=
 =?us-ascii?Q?zO1g0ruwtqf9jzgac4uBJGsPsTYRqf85cdq3y1h9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be916be-0518-4546-181c-08db8c2c6f45
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:57:47.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INfSwjW6coM9M2WcEu3b8ZOLAmxniwU+DsuDlJYyQzvEytrNtMIwMEKgS/Cb5nBBIEkja6O5GhlAbdZRwdgelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4448
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for dma_request_chan() to return EPROBE_DEFER, which means
acdev->host->dev is not ready yet.
At this point dev_err() will have no output.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
V1 - V4:
Fix code format.
---
 drivers/ata/pata_arasan_cf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 6ab294322e79..b32d47112c0a 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
 	/* dma_request_channel may sleep, so calling from process context */
 	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
 	if (IS_ERR(acdev->dma_chan)) {
-		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
+					  "Unable to get dma_chan\n");
 		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
-- 
2.39.0

