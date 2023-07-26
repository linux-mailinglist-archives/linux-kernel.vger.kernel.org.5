Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA75076359D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjGZLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjGZLvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:51:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58A30F4;
        Wed, 26 Jul 2023 04:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEFDWfXN5O0Cz5cTBA48sjKDcbacDPDYfglgv5iuyc+L1b2M06JCGhKZuH3MnhdYZsL1NTrEyZlY7j3UO4COoR/PMd6ZfOsOKCA7F1aHHV1gQWu9wHMSf6x5IHy80EWw86GBja/uCXv2AUfvK+tlstjPsjP2KZ73PFQhcL7Nwmw4Q3Q10jbulkFnAKUN/bS9XoWcKFQF8FVB8FKHPPMoAAKcPqqucJyI53Zyc8nL8IT3Nmlcaz4d0CtvpaeiSg+AlCIIAPFeNJmCMUcKLj0m9bKtWAQFbSRqAyb0E4E2GR8WCkCifMkAGISeauhwidM2ilD0oRi1FvrAc5xVcD/qbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udfrRT3mkNty33US6o9elrBdX/APzjaf1eoDTU5tPqI=;
 b=TM1E9mgLkQzCbHQT3W7ZAYKmw7z63UUZqFxeQ4c7SPNJGmsMmxaLljzgutMpHSvIQq2lTJlX2L6OiV9e+T96yp7VfPBu2d+MLRUnmyNUwO3ClpfeBXzxkUg4MUCJoze90ClB/XT49ncz/R9fuHFZRHlrgx5FjQusllYkWew4KVOe5eU9AyY5zf9sjF4LxmKF9NjWGHcmg3F4EeLe2hv4srNDOPORqjKD/YkI6n8NnaT/wIokijwaXAGqkjYc5iV0VE3QFccVML1alcBVOKOK0hQon28H5cA2TrUPyFXEYqZihnMiwjpTAB9rSix30+6c+i/tfOjixdNySTQCfvYmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udfrRT3mkNty33US6o9elrBdX/APzjaf1eoDTU5tPqI=;
 b=dGytxnPJa+SQHdr/gtvospiLbuwGcUzZnq7FEKPcz48Dd6HmTDQv0NORKf5EhfSMlSqkCapMqSwYLsgbXyfuRjiOVCgU/fywsgki5rV0MA7UQsCksO1eCpikIezWTWyRngBvbapQGlA10UPjQ8Jw3sH5YbXn+ajaLdz7icUb4ReH3aEHbFvKx00WeB3/SdUnlD5q+vcszG5UUaK7rIFKQN9WaistrsjEgfx1j2wUBe4+SmWpR60ibDvNNhLJnI0SO69QP6UMg9y9hbRQi9bW5LXmHankFpiST5m2OknVlXCbKXKmMypZd3o93dxuBcCP1xs9e5xub/RV5IKTixVImg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TYZPR06MB5027.apcprd06.prod.outlook.com
 (2603:1096:400:1c9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:50:32 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:50:31 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] mmc: host: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 19:50:12 +0800
Message-Id: <20230726115022.5403-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:f6::30) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: e97aa14a-53e0-416e-8fc7-08db8dce83d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwaedmey6MGB/Sc0fCVur40k6o+njF74DtyOYEzvnX9/adAu/rSgygLNexSy+u1eXd0rMyJkPGr9QXsfRScAaHDvBIc32zO3V+GpbGFiZi5kZBwpULsrwM+myzt7eZSPuhqppTX+X/T81lYySR4zxN0TeSJouQTA4Ih817x+sg3no9/9PWV0gutTbeyahdnCKqjJQOuf3OxEfFDnxTzKHKMBBpfhrVg3c9IhnCsi7RbDyom2YktZdQ3BnzdHr3WVvdg7KIsbKp2qvI9ml9YurntWO2qm2fjlEliFeBzmv+LLLoRrvZjH9ppKfEoAt1tzl8MzVGEHx9M1elkN5rqwZxrKojk/GAlDB6ZA+JGcGU9ugtNlWL0zL1ftK7IinLB0hOevqplDGEN6yn3ABfN0yKGHMOpy4SmldhrZiNdYHKGnyDME4ybal6KxTHP+T607Ov0/F8e/iS0pRouxZn2ysaf672vzB5VbmBhLDqNptc1I41+W0F1KSlsfNhiUZNBgz+lw0MD9LYCYUZ/JLN4dobP4eiVN2KWsA42EbgTCrsSEwUkI8cCbn7TaMdb7PN9465Y9cXLiVEnlYGFqBxY42gWdGA1KdoZo/S4MG99ZWb18yPqE+HSw9QJl1l6QEKrH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(6666004)(6486002)(52116002)(478600001)(83380400001)(6506007)(107886003)(6512007)(1076003)(26005)(4326008)(66476007)(66946007)(110136005)(38350700002)(38100700002)(66556008)(186003)(2616005)(5660300002)(41300700001)(4744005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0okLP6JrmxhgiZhGIyf6XYk66SpGl0IHpec4iRvJ98w7a5BeLIIdBsgYMHKy?=
 =?us-ascii?Q?8ISLwHtkVDnsTbHox9ucIpC5TlzGQgvIrzkipZdF27OSsi4DOCin3Y0tT9eY?=
 =?us-ascii?Q?8y2Lmxb8yBHHLe1qO6NokMtgwBSDUzPChAnq/v6+dUttwAfkF+qlsSeY9glQ?=
 =?us-ascii?Q?5W2CLe7v+IFnBRlRTL0Ch6e1hTpiS7gb2LgHINGKg86E03q8GXLz4Lx06vH4?=
 =?us-ascii?Q?s/HK+jltciAWt/a0kvfggK0ywJvA3eLeZz2A+G60d4oNstuCo5lCpTFXgbG7?=
 =?us-ascii?Q?RIQOMo9KTr57FhpA6ei7KpUbTWcHXLd6Hj4E7e/tYXV4Mqomwk3ocMorzZQf?=
 =?us-ascii?Q?bPUU/QkuAUYghKQbRnTfaV/5yFHaOf8EjsO1aEQI3AX3QdFeOJ+mOS3bjbxX?=
 =?us-ascii?Q?wUTWqElVHxM9g49RmrJYNYDTMbtGENj88kEa3SEkSCpFj+LU/Bsfb7TpCKl4?=
 =?us-ascii?Q?IRERFTZeSOTHRfoOjq7b+4CUpmFJ/92YUTqgCTM8OHX0SyYCXb7y5zXq+iVK?=
 =?us-ascii?Q?BGOJTEYGEM2bYbzy9s2gQbL3ZuJLc017xMRMxQfv7NoCfy4C+1FvE+NbaMgW?=
 =?us-ascii?Q?Yc8zGsdNPmI+QPnRrqpngg+zLG7BuCrRLORabYYMeuUgsJ8f97pYh9Hy2l0A?=
 =?us-ascii?Q?h22yDV+A4IQq17qVKPMvYDMCChELlStJBTgVEEdNABYT9Qmw9NABMsVNn2iE?=
 =?us-ascii?Q?4F0daCmPvIlVetdgLS1OYO5cXK8PFk5Hd16vAaTX6gOcPjyMGC2sc7LTX4q2?=
 =?us-ascii?Q?hFZsgPqxlQOupq9vPpf+LW9TDISxMiok4aTQ+2ejwgHUqyxRuu6/1XUwL6XX?=
 =?us-ascii?Q?1kHWqoYt9WtTsAz9TMgZqUKxiJKmI8Ou153DteFEVJt2+Xefb/3AEtGdLN9Y?=
 =?us-ascii?Q?Tb1TlQsyxgXedkV+YYqS7hWdJ38qv8Lqolf/+yxDhrAEVC33tW5STY0ICN+q?=
 =?us-ascii?Q?Kp1MRyHOQ6GZeVIu63d8aoxvnKlAOpJ6vVd/vk9iUwqHTXhlvCeO2hAhMdbT?=
 =?us-ascii?Q?2Lr3uA/gOAhxDvoONbZQ4VD6ACWTNch0ZkoNhuzMacCG9vl4Im02BE1x9Pno?=
 =?us-ascii?Q?V9wPQo8U6R4Zdmc/JXDzyajTQSlvXr3znAZ9xHLdRuobkN725wSVbLvBzI8v?=
 =?us-ascii?Q?dJF2FEFxsZ/8sDWE9nfhw/7U8EWtxVDB4jWD1XG0e2n6NEsZo2/I63jNJIG8?=
 =?us-ascii?Q?JjgV3C1eqbh5Jw/qXOiqpTx+p6j1Ye0NJd4q/pWAx5RgWQg97w+xf0XdUscw?=
 =?us-ascii?Q?dgJyOPmy/RlR1Hw76B1wQ7j9mAJ4DEr9HPYCQhMtozEbRRN0EbElM2z+BLZq?=
 =?us-ascii?Q?bG/z3E2t5k3SD0OEGkObfJSy5+chd7zE+DF+pdVP/gO/0qc9qMNSNyDdxejN?=
 =?us-ascii?Q?yS6h6NYakL6A66v3sAo1aIgwIrM58nvHkgat0TSyAnfYoQS9s8/V4H6ha0eA?=
 =?us-ascii?Q?FVw0Q/NJaxvDWQyu1r9i3nfl8Eh0lwSnJqxAv/7dTosAf/tGyhsyEhM0ALqx?=
 =?us-ascii?Q?xkr33ShiMEKW1TXBcvT5U4lMl9iHUQyanZl0V0ygDZxKIjmSSKtjVJ2AkvWr?=
 =?us-ascii?Q?/M7B6NEWsD3p8oPxUmrs6PoFWYGgBRwsPNWkYsT4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97aa14a-53e0-416e-8fc7-08db8dce83d7
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:50:31.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJmH+jzlAhQcNqLPlXg5SbugXqTovFeMdvb/iVcuEmhU/6gPKitsA3XaIjV5+Vkp5ssfS2YuPXEaogvEX5eB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that dma_request_chan will return EPROBE_DEFER,
which means that host->dev is not ready yet. In this case,
dev_err(host->dev), there will be no output. This patch fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 829af2c98a44..5a3eefd86931 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -841,9 +841,9 @@ static int dw_mci_edmac_init(struct dw_mci *host)
 
 	host->dms->ch = dma_request_chan(host->dev, "rx-tx");
 	if (IS_ERR(host->dms->ch)) {
-		int ret = PTR_ERR(host->dms->ch);
+		int ret = dev_err_probe(host->dev, PTR_ERR(host->dms->ch),
+			"Failed to get external DMA channel.\n");
 
-		dev_err(host->dev, "Failed to get external DMA channel.\n");
 		kfree(host->dms);
 		host->dms = NULL;
 		return ret;
-- 
2.25.1

