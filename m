Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A4773CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjHHQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjHHQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:05 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D072BE;
        Tue,  8 Aug 2023 08:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwheaBlZ7PxchftVGYJwCN3KldjzKTC1hnC42RKFp18qCfVVYmMhGv4Ly5TIElZr1gvnw8RAnGiFXlYnCfv6Oxl0DZkjmkbezd7+EU6L8yqtERI5SuL550Si7BtUcV+5VlyI9PVaAmHM7W0Z3IWUfM2geYfIX6xJc/JejoqBTRY7bsUrJiHTGY4Dvb2YgJtc1DPNosGINb759nhoZxtlwUDwJuSgQ9USh7gQZxkh3hTyx/2du1nwOwNwvYaGbN8eDCos7OTWGYymA3ZtobZqSCsDbwgmnWBuXW5Dyu5/4qDzTIr1zXYp7bcT3L4RWif3bgoS3soDSbFntMxPUTf1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PAZfZfCiuGzfNJVcsl890Sr7GdVY1xi9gw8RuV01ik=;
 b=JuV/9LbTdzfwWNvab4McNxlNV7wZolZqFSdoi0T6JZncSMojCTDaZ9WvBv9MefVlaHOYUxSwJVkhF6oH0REB9E91GZXbgtCmNZhVDLmdZ/Rxr9hO7TNJ2z4jN6mmGs69337oamhzuX3bhyUHDVJ9yVfcBk/JOKJb0vGR0H2OHMYnbx0yb4IZ+tefQrkrbGXtsPV094PvB7wECnqSh5ULMnFJ9nDXJ0lJn8JuhnSHf6KPoYb2VT9lAMjQvRBdWXj9R1C/gQiczb4tI1aTeUskncpC4hJRFHwhTfH3MBWNAEObLmP7GNQZySC/DybED2Ybgx+goz9RTa2ChDVufs9E3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PAZfZfCiuGzfNJVcsl890Sr7GdVY1xi9gw8RuV01ik=;
 b=ljjqzoH4k9T4LWVuiis71OBneTYDi9ROu8S7uj8biDAOOU26O6oyNFPglnAO/+Pbq2pghDt2v2+mT10EZ0mu9tXh29NOig2w4OfgK7BIpCKblW3/l8a5C/+tGj34qHuu9odamwyfW6qiMdZl15piSsFD1TchBB+yiOt0DIi5oBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:55:46 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:55:45 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: caam: fix unchecked return value error
Date:   Tue,  8 Aug 2023 12:55:25 +0200
Message-Id: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:208:122::41) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6171de5a-3049-425e-3157-08db97fe0489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXDzZE/KIyrxLlG4UOtN/OAZ3UWZXbzy0rnAqb32bq62g2oLvEkjBdcxKstzhng+wdnMH2BkRzlAvwkmPwl4NwNVrjyDzitkCvtW+WCnPaNSkI5gP5PzwyNJ/lb3P2w7KtkkWJ86Ew96Oc4BCxeIZS0Z9wpCLU6MlVrDrl+HmXTFq1xRgf3zSZ34XcFefuhwus1nPIDR29L4atgtYBf9dKY+YqkEtic4r/d1vUXbOoKQRWjPixryu2kb+CI7K83F1HprLPJxMIR4uCct76kJYZykwr630Stt8Xl0krSX5OZTCIgcVBpkt2ex9RGk26JY8fdlhssRT23Q6By99MEjv78+92mGwEoocNaoi/Ve9rpA+GJYOD/KHGpeZg4pCIYq5/w15zDxfIan1PYO0Nkp5xcL1xtUJOSWkuP1i+G9ATTsZGfs3qPT1o/R3bTmtXxdIswiYuH2mcbArqRnVSIclPSaJYto2Z1k5jNA3/uHkSIjgD1Qa70k86eAB9VEqngn77gcaMwOw19Zi04i26xVnXMGfNVmGmZWySOF4lMi219GwyhpKX6NG9tuUSkJq8I+IQjEQQ2aPNSFCypnt8cy85vJj51Ivl4am8LXb/N4eO1nz0gOVOCYhxz8+e0H804k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799003)(186006)(451199021)(2616005)(6486002)(478600001)(83380400001)(66556008)(9686003)(6512007)(26005)(6506007)(1076003)(66476007)(41300700001)(8676002)(316002)(52116002)(8936002)(66946007)(2906002)(4326008)(4744005)(6666004)(36756003)(38100700002)(38350700002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCey8oItM4z5Sh5ReMRC0VECbIjfA4Z+bc9jY7mfqXPNc7okkJfY95LbyND6?=
 =?us-ascii?Q?pKUyDpI9Rk8BMia45n24hByP1m+GvZrsZeUToRQ2duIM0KA2hxq+wlP6up/8?=
 =?us-ascii?Q?C+fcUsWlsOpVlnBqqQgAH4XlyNdyJPvje85SX5mOYbvmSQ95ku/c/eHA1CFa?=
 =?us-ascii?Q?4P/yWTxUI60nTSOh0QipbMP1kAhwMy2ze1Js5PRMbW+crDLUsD0plhGQ94ZV?=
 =?us-ascii?Q?BN6BqTz7sYn9+kjxeR9MeHt0BzZpfMn5h3FfUwm80HD/GM3m454bjIGO386c?=
 =?us-ascii?Q?UxnfqfnGjoZRZwAHCutxPHPxjxRpHIgTwYYknex36iYaoJu+FL0NqNzrv475?=
 =?us-ascii?Q?PrpDWfUTSuHl8RPnDvrYNXXVQ3os4ggd+btMsXbCm7Yt6wVRQRlM0QCpMMnM?=
 =?us-ascii?Q?8NFNmfbr9Rcx5UkxYz65LtOiICljXXY4zrRtEBXFT08KpwVfSK7epFWYkZ7z?=
 =?us-ascii?Q?JXQL29N5Z9vEfN81a0yyHz/FBEh9ypYuiq0fF2atCvpGxzD2Xu/t8epyggaI?=
 =?us-ascii?Q?kYMRwKiYrRgoDZGS1VFXTCee1GEg28BZPhVI7dhB66RXMYjAVpgyZ+cxfx0Y?=
 =?us-ascii?Q?StGOfZ2yVwOuODOwbZKrl1QZ1qgz4HFjJf5U0bid5qFGVaKoDuXnB2TLBgMf?=
 =?us-ascii?Q?VCWz1F6GUIQeSNDrBycHz7Jn0XWtPBtY/AOoLF2Gv8JeP8ThSjiMeZvP2rjp?=
 =?us-ascii?Q?413ozfk9CBo+B72pa7DU3D5gwOo0WTY8Ck5mVBHKxCTEiDekpa3tAncuDH0L?=
 =?us-ascii?Q?5VCSIOd5/Xuac/amxsaGCHCe4P5vK6niyG+ryXTA830lm6hcnpF1o6YMRmY1?=
 =?us-ascii?Q?ZoZA6oLV+ITVbj0tuNSxRKBH4Bww2oXpOwUfWhDvOGSerQEAn51p066xl41S?=
 =?us-ascii?Q?JJBpO9pqnqkf0vzAMhMW0gDmRx5euwJYoKvcnKxiIZZ6fb9xI+rk4d0gVYfx?=
 =?us-ascii?Q?aIAH7YK1JsdrD3P56TU7WpWoKxK0H4He8ZVEkpYeK0XpO8P1aaTWJTxZEjZI?=
 =?us-ascii?Q?Q+ZP0FmRQj9WlHNolqSYyIBSlcyIGpvf+U0P0UXK4p2mEe+tDN6Q0vFyBjGc?=
 =?us-ascii?Q?kRHL4XlVyxLdbUCuIprw48pUavZpSNj7dFGsfT5SAldG0BOaNR6eyXW3gDxP?=
 =?us-ascii?Q?7BaEB4GbvlBq9rZ3q4Id/nEUbskatX1kelpsqclCn42okniShhv8sucvbiJR?=
 =?us-ascii?Q?3rj9K68FusC8JTcgBNbOqF5TZw/Od5rSlisVcfsfKO0oVzw5mm7icOqp4Q5p?=
 =?us-ascii?Q?UajIcY9oAXb53M/ErMOcHzufQ+toMSP3vQ1f/J1dSOqtqeqQPx9RgdnXheZS?=
 =?us-ascii?Q?uZYAm2NWDiLTT4pMsTgQUnkZvu7XjBLicG1IIk/D80RgnfW/2nd+Y7aBfLNy?=
 =?us-ascii?Q?omkF2ncIXhc9AV89NNoD8X+GGKkJXXtGPRBFSK7xat0Q0/PYOnwABJCEsIBx?=
 =?us-ascii?Q?sBN6QqPRXQUQ76vCFnrTKzLLenJEafaB+13Sh0EcgFsSp2g25Dbt4EL5vWR6?=
 =?us-ascii?Q?7A7JYYOcy/OXfgjsj3/e5Hp70IXQUscBjGc08lmFqAmqSn8QX4qE+6f/EBES?=
 =?us-ascii?Q?PK1BTbzKEaDRAZqYg3h1B6s0nNWWxByLMP2ZAyrfKyjcwMXLhRR7O3MK1Nt5?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6171de5a-3049-425e-3157-08db97fe0489
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:55:45.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi1+b2BPp3xRMkepDeODwPMhksQwGaA7Bt4DMtcDdpm020XTwMfEdMgdDQT62Ax06cor6j91jg9RRRUBe7hvhSTjOOIAveTKEgU8bOChxT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Jain <gaurav.jain@nxp.com>

error:
Unchecked return value (CHECKED_RETURN)
check_return: Calling sg_miter_next without checking return value

fix:
added check if(!sg_miter_next)

Fixes: 8a2a0dd35f2e ("crypto: caam - strip input zeros from RSA input buffer")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 72afc249d42f..7e08af751e4e 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -225,7 +225,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
 		if (len && *buff)
 			break;
 
-		sg_miter_next(&miter);
+		if (!sg_miter_next(&miter))
+			break;
+
 		buff = miter.addr;
 		len = miter.length;
 
-- 
2.25.1

