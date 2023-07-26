Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447776345E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGZK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGZK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:57:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98449B;
        Wed, 26 Jul 2023 03:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4svG8MdvNaECJIzRwcnEoSbGoL5tt6Wg2s0lM2/wqKGRK0V8EVMDkntGM5YSaN4uZsGCF7wtsJYMU2OLT3KKKq5HsjxA2Db1pWSdShAd9w1oUVuw0v8zxlqfUhM0MtuOpzc/7kOu/8W26IT6UKH5HGUjt3FvB3SedJGbyqm/WUEAG8rHvuL1ftJWxn+lBqvyyDYQEovN5OH/KydS+4hTHmc28ltRSmmKonbEAfQPgyxrfdO9wVurIFv1hUO6l4c2Y9JqaRITN8QKUJ2z+b6mCC1Q9aoH9PEzPA+zcU5JJHo7ot8SqpvJQZbKemDAp5LG+p0Bfd+PmDCJ6xy+NqhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA3OdibARXaIYIcYP2wvlLIBQKayyt6/79OzY4lzS9Q=;
 b=P2PrdZbERfC7HYmdy0H4AErdSm86oW+d7XpLKqaWZvHJHCUS5ckZKrw8UJYMCj/TqIKVWEo0zJxD/lcyIjWrcxUgkaO27Em5vaHqXexeB/a0tPwtyEpIrOjUvDj34Zt+aKem4Y0pbOAMTyfDeFMybp7pPCRVc65UruEUqLuUghbL2BS7g/HqOE337iL7pt/M7xqgFIGKBERChcwJbvF4s8gfcYsDrbh/+4Cli2OyIh79HdmQApLkFg5G7yR2hYCOV9svIheCHXpJ4fOD0lGNnRigreE69xoeKxcwabhtRXn0eakS4wvpW26+kcttAVueE6ecK0zRZe2eUsudkOeSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA3OdibARXaIYIcYP2wvlLIBQKayyt6/79OzY4lzS9Q=;
 b=SXOmhASIDJAEtTbQXosFSqmpiiJpqwhsLSjYXZ/gM9s2IIZJuYDvIdSxH7k5T54U0U0b4C6ubHldZhdmVBj2vDNS5GUY1iEerY0/MFhTSlABN0rnmBo4XZTMzPszXD5TP6Qicmaf8J5ASyan/QHALeZZOso48TjyxWfE6Hmw+esZss/fF8kELbV5XW6sQELuST5B/JCWyjxilwVZli1YnftCHU/SBe2AjrRfxq4s38ne4J4LH5F2X2BlniluxKPxt+o9GrYts8wMVZ8+9+kO2X5s0Fr857Bzk55L0z/UbJtKNsqvXkDbIJ6pq2Xy6alZPXdM9Uy/F0QniysMg9MU9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by KL1PR0601MB4161.apcprd06.prod.outlook.com
 (2603:1096:820:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 10:57:12 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:57:11 +0000
From:   Wang Ming <machel@vivo.com>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] spi: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 18:54:47 +0800
Message-Id: <20230726105457.3743-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|KL1PR0601MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: bca18843-d94b-45fc-2edd-08db8dc7101d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4at5Wrqz5V7uTHpVMQija3PbVPcRzaAq/poiVA91tyziamXVNN2s69vyBhlZPw6vjcygtOiWD9rgGPJr989mpt52ekYJoAVIenQdPJ1KZq/d7LiG+TxOQw0xHKKc0/c03I9GcKlNz1YSHJC1/viQHJ8kfg4TFqryuzd/RhCTJRs1YdSyUfWJV0BMNDIYRteK1oTNk9PeACauCIW5Bl0W0ZtCfOqY/KlwP/PYO6SAMqliOIMJ8IRzkn4dRhE6czka196D5rR/FrdZyR2sbV6f8LB+NriUpwCR4OLWQnQzTBGfYaSHVUzoaTILOXRpuLw4cRPTL2c1fJhR6TIa1BZq3FTCRkj4F0C1B23tpCOqF7JUe3uyE/unHU9/nac3JP9Ok61h5OzuqkRPzB2OuZ+0qlLQ1DzVlAHM0OiWUDY6Um716lvbLgim3JtBo21UJR9v0e8UXrKREYIr4iQ9Kc7APi4+L5XPlnjrKxJTOGpQYPbyZJU20Uf8voIAjz2WWAkZtVrg090kfX7fcNDW8lLBHC/6sp47Xc/ZmMr3/LLteophgOlEgz/YZA2fNaPGIfCA8HcpfJgXQzdbfWnVBW8V9l25dIc1zZK0tlhcb+1qErQHLVuazTxSudqMP4FnDcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(86362001)(36756003)(2906002)(83380400001)(186003)(107886003)(6506007)(1076003)(26005)(6666004)(38100700002)(6512007)(6486002)(38350700002)(52116002)(110136005)(4326008)(316002)(66476007)(66946007)(66556008)(8676002)(8936002)(41300700001)(478600001)(5660300002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODlC68Hw+EqQ2A43kFACOGZJErcxyEdRRNc9Ziu7Tid7fzY8uTVbX3fFWjnw?=
 =?us-ascii?Q?rx7lPHum5l+8+MOkfo4S1UxXcqIWiOt69egBCW2jTR8ZIIYnTEp4BS3HXRtQ?=
 =?us-ascii?Q?yUOofCENzojRz4XLeURBiSKB2QFAyS+TIrxY/SK2PRWAxA+B55lNegmXoPA9?=
 =?us-ascii?Q?IVb4PilihsN3z2lyLsKjuIFIehFBhqdjlCxVflL64zzBeQ9HhckCrUyFivov?=
 =?us-ascii?Q?bEF+q2vs/1Nm8zf/bf62S8nZJ19IF/sDMlJG5sRnM8fOUgMhECsAbA6JCunh?=
 =?us-ascii?Q?3hzclbxuawJrFY5HcMlrcLoPNISH/RYRWVPn9NzTtCtPO6b+QGqDodcalzzg?=
 =?us-ascii?Q?Ge7FyN1DsM8nGbA24scszqEJ2+/MHcC9hpaJZUA6+dcNy/Pr8PUvhJz4M63C?=
 =?us-ascii?Q?rtajZ8WHB7iN885OSD9+w3CnKOwagw9sNOfEoRZkhP5GF/g33FrrS3GO6aFT?=
 =?us-ascii?Q?CDhFmxpyO+1VAvbFnpxF62eCnmaClF4kAPC1oE0DxYJ6SvRv/cc685ZNFSBD?=
 =?us-ascii?Q?hidB8+h7MA27E2Ip5vwx5cJBca1F0KnZyyTKlKrup9bMRU0letkrZNopkrBf?=
 =?us-ascii?Q?GbD2pseWuYV5IYu1fLDwFFL43ln1gvBw/ViHR5Fbql718DFIkSV6ie672et2?=
 =?us-ascii?Q?E8kz9OrxM7qzoxl9UZwGBB/VvBhuCD8bUXPf+A/Z5Ae/uNlAqFCwKV4gDKPK?=
 =?us-ascii?Q?Po3R9uDjRwnG5xgWwAM/q5SoMwRBmsXltbp61tBptX3p4s5RXic5/oFM/QAG?=
 =?us-ascii?Q?mzuwWKIXSnD4IVW1mvHReTwCRm6eHtXbZ5AH6RaYj0lOQluLPrB7Q5dwo48M?=
 =?us-ascii?Q?Wwq8TgR2vugOKDdYO1e45hIX0bBBqLpAaVwysEBzPfahEu9AW87U1/SdfswO?=
 =?us-ascii?Q?UdUlcG13VrrIdkdalTpJ3lADsgJgeLnciz0N1aBB9oYyvCxhTlf2l0Jc56a5?=
 =?us-ascii?Q?LfLck3LHoibm9Ii+2DBLfawP8OCInDnt3ilmF8wo3QX+NUqSu6Z8ZFNd65Cy?=
 =?us-ascii?Q?m479CbM2cqNJ2wGvMlOCv4iEpuchl525FqRPvgEdITY7PVT8V13StwOmW9nt?=
 =?us-ascii?Q?ApZ0rvfWXWPNNIPn36wwzdFH688Gykw27Nvs9w/Ji+3jl0uzMLHR+NH0Oan/?=
 =?us-ascii?Q?AP8bTGHS+jmv26zbZSYKnVvSsywhw45L34XZcpl6k4XxtVdyeVxZSojvdcRq?=
 =?us-ascii?Q?C0mcSMqQ1hsu+obVSxK4t5UmLSaOgUiQAXLUbW9s4OL8xrlmo55RfP0cfr2e?=
 =?us-ascii?Q?FFmMEdqgFk0b43PiCtnBhP+xJmnPMOGYIGcmuRon5LB1xpHQ43DxDL3caDPQ?=
 =?us-ascii?Q?zZx25xpjjb3DapXQeeRq621nGWaGuUntKeHVKHznb0mek2vaHm4bokV+OEXh?=
 =?us-ascii?Q?vVYQ6b05/3piO+JU8T4Kakrd5UUcoV2c6YoaHMvV4IdRNSL9wD8YMcSmbLRG?=
 =?us-ascii?Q?gFjVIJDvj1LgSkMVWpndNT3pLmuy3/Ha12iiMK9oPKzpB9GCnTvvMVXzheAs?=
 =?us-ascii?Q?GKsgrxd69b/Brk9HWP61ztY8G7AdSFQTYkwx39hOL9miuY2eWoTd+/cUdiN1?=
 =?us-ascii?Q?OSr0cqJCItwKcRCJ+Z1fhTzGU8jU343+KfL9WjCL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca18843-d94b-45fc-2edd-08db8dc7101d
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:57:11.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZErqLtdI1VM/0JgJtdvD52S/OVSr0lzZlybb6SZji+owxDTZBAQPp59jzB/12fR1OwoG4gmHAyycoGPLjNbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4161
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
which means that dev is not ready yet. In this case,
dev_err(dev), there will be no output. This patch fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/spi/spi-bcm2835.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3b253da98c05..cbf025054c96 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -903,15 +903,15 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	/* get tx/rx dma */
 	ctlr->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
-		dev_err(dev, "no tx-dma configuration found - not using dma mode\n");
-		ret = PTR_ERR(ctlr->dma_tx);
+		ret = dev_err_probe(dev, PTR_ERR(ctlr->dma_tx),
+			"no tx-dma configuration found - not using dma mode\n");
 		ctlr->dma_tx = NULL;
 		goto err;
 	}
 	ctlr->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(ctlr->dma_rx)) {
-		dev_err(dev, "no rx-dma configuration found - not using dma mode\n");
-		ret = PTR_ERR(ctlr->dma_rx);
+		ret = dev_err_probe(dev, PTR_ERR(ctlr->dma_rx),
+			"no rx-dma configuration found - not using dma mode\n");
 		ctlr->dma_rx = NULL;
 		goto err_release;
 	}
-- 
2.25.1

