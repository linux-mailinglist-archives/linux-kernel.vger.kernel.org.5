Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8447C40F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjJJUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:16:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC505C9;
        Tue, 10 Oct 2023 13:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frZ03TcdxTy6npxgcUZtdxuUfzemgAHymxIPG8OcjKb1kIMcXDkeUyH0uimNp/oSj75NLE7G241HTPYhZHQYoUnYatww6cy1dVIVZIktSTuqZjZUe1MWhm3zQBszdmxElCjNtxj0gIgcj0XSwRqW85Vh4p25QdX8eQqzis5ff9brSKGwOJqaGLp0wRbQMj9isPsgu4uGzK1FVexZr5Hf+dBEIjraDT0hlVYsVShRG7bc1HC3lGYVPiyj8v3qx9BRRXG00XvwJGAEt0nfywj8onDo9LSF206pVYGve0rZ/hqEFmg/9w494dVho51WFc2xxHRlWm3CTj+HknNol+uaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kHKDhCkr5K87M0y0HfPdcV7/sPLEooSvIAMdEYh93g=;
 b=gb+mRXu5WDdvowTdLSqaqfN7SwFRNEfcWTmRtQ4tsNm8fbxZf13tEIELq3QCYz/h57InMmz1C/8a2cajXsNbXjsPMd8jzMgZmzqY66VDZUwGfia38HzeZZ/hPDePbWz8OxcGczS4DY3znQs6i4CGM4q733sQDCSf3tLDLyXVIKQAj3uCIFYcr8JWXwRk0vUQ1DPcTomf7sX212VPHJAEmTGLEvHI0TwltY2V/cQI7MFrmLhI6/VitbQOAF2LRXXIAlObg+kTnRtLozbx0fuhcQARkk7ECHHv26WlCrxBjiQwCpldSt+f64lfVSGOP9nV3m96h19Wk9BUAjdnD7YrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kHKDhCkr5K87M0y0HfPdcV7/sPLEooSvIAMdEYh93g=;
 b=Bzx/GvrD1dQSrsYGFFBD/AMgE4qMjkWqkIIMIuGD37EKDjiIKAL+LFWLuvUZRKuQ6m6q58no7sTkSn9Wg85fMgqiKNqhDE53KX8qHU9aIOZ3HbR63bXviLWrYjhOzFezRUstHqdtp+m96tsUprzMnBB7R57MqVSCcmh1b8yNJow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DUZPR04MB10040.eurprd04.prod.outlook.com (2603:10a6:10:4dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Tue, 10 Oct
 2023 20:16:06 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::9b32:e5ef:43dc:4e0f]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::9b32:e5ef:43dc:4e0f%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 20:16:06 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, Adam Ford <aford173@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: nxp-fspi: use the correct ioremap function
Date:   Tue, 10 Oct 2023 15:15:24 -0500
Message-Id: <20231010201524.2021340-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:a03:60::41) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DUZPR04MB10040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6672f20b-98a8-4b4f-c1a8-08dbc9cdbb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: an48fRAPvApCfJETzeJz195ZHhjpbH1ZMqENnJAnZsdc47Ew57EiO/gAf5w+VzFr2p61R73m8u8U761q1qj16alY+QOYRFTutBfzVWhIqHjBVnYBriKYrpHRblOwvRSrqTe6T5089HZxY+ZY8mY88yUiSD599Hbbhpv6T8xkETjGemaa6CRY6xdSfDmoUk3MKOxi3URNmaN4D3Zg1mJ6ZMXSWJzdcTAv2xdkDjq84bE9x8czL0bmxG9f/R4yhjWlOlRAePuy8RDqlqD3lxYOIhH2mOdg1MFxhec036pWQGIMgeQzjOHDUZsGCI7HkM2gJa2ZuO14hMt+ctduNhxHukV/iGhTP1vV3gpUrJOUIhMUMo9CDHiP67zZyeOL8kOSHpWBXEDnsz1YMN/v7OdgOWraxerc2wcHWye0X35ORKyN3KhSI62fBOBK8AvnuxN1PrMGKyAT8P5ZTXBE2clUnj78Uq6rz5Pq+xfgWv4zvCLiT23iNeCOM1aVaRtQtTC2TMK6EHschHGjvjewLUBAbCC/0NF8HMi09XzvHsQfOqZEDVN01JWK+y44r8tHAf/WufTdQM5Ax8YmFc468VW18c7YU74tlmYkpLJfpzCR/a69baI6A/wnsjp0JLn7l3oo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(2616005)(6666004)(38350700002)(6486002)(478600001)(52116002)(38100700002)(83380400001)(1076003)(6506007)(6512007)(66946007)(66476007)(66556008)(110136005)(41300700001)(4326008)(8936002)(8676002)(316002)(86362001)(2906002)(4744005)(36756003)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCFo+EcKjLnI7VONz51mKJ7v2hI/DHztP+FWkZ6ytqwydBw22yKJ0z+JM/6w?=
 =?us-ascii?Q?PZ4TWYnQehj+pdSFPpzqFNdDYMTM17xWDmVxWNaOBF05nxwAhtINqm8G3I34?=
 =?us-ascii?Q?ledI1UjJiCU+ZSF7SwjYMZEjiK2L3TyurT7sFy0aHWnbFsL/ScxrUjzdoJrd?=
 =?us-ascii?Q?GeN9nZlWQkV9CNKdKzXgkeCJEoA4N/8dKe4FSMuYUCiqOsk7FLckAUd8DJbQ?=
 =?us-ascii?Q?2a5bxGN0m4yaI0TP+jfYUGfEGkyUJcVey+LIQbA89KRSxpf0GFzGQKLs9ppu?=
 =?us-ascii?Q?Ow3/vlKsJ+HMQXTELwvwaG/9Yxnb+BrVgENqMNnOCSRj13MRW3yLXChtpRzz?=
 =?us-ascii?Q?wv/oQ9y0NAQgcFxPAYUf+8jtrwhcHuszJVBT3fwxxtvn21DZh6Opbq43T0eB?=
 =?us-ascii?Q?O20nqbM/G5GW5PTO7gLCPyDPj6lg/GjDf8zm5uLsMgLnzRgpyMUi8DmtYJPz?=
 =?us-ascii?Q?UiEhR5HEmaEIdqkd3aCB+xlkL4bcy+Xroqwhlqdn1SZo0ZM1TwokC+JJMLLd?=
 =?us-ascii?Q?welH1Q07ywNr+3mrOj4C3JsyXP8XMhFwdUsYBWYsWUFDrAW8um97ugMmkpqw?=
 =?us-ascii?Q?KQ1MsJGfy1wExe4teUsWQQ95vyV2rndv0DePF4Hq2RwjUbQlrQEWrNjgY7GK?=
 =?us-ascii?Q?AMvUTOBIVu8Xld5tLe8dr/q1nYlLhcjNO17OoJz0NmkzByjXPqX6jXmNZi9g?=
 =?us-ascii?Q?2luscMxUmw2tY/vsQIqclyZ796i0C+BPHtMMpbqd67gCq3hblXCWXpAcMF3s?=
 =?us-ascii?Q?65jnmOc+zKLTHIcF2xPgOYB7B/kiNSwArRrgCD+wIgTOxcaI+Hv7xLktMi8d?=
 =?us-ascii?Q?5bjqVtJUWByElfx3xKrPzfYZbxo10bre91Yft3ur1En70fg0rzY6uOWp+j2N?=
 =?us-ascii?Q?3rtcN1UCX/x4bGRfpMYr/Wnwf32D7TbIOn7GIWZoD2caXpii9Z5kYgY35fjY?=
 =?us-ascii?Q?B1zNx9B//6C3DERnKaCo7M0plZWsgLOamAwS0KmMS7KAVKhG2E8aScGLbuis?=
 =?us-ascii?Q?MPI4ew7l2iSM3Vl3Kn/qW+gH88HYRO7TnxoQUNLHRKdO8g2G3EyCY7cCghDl?=
 =?us-ascii?Q?jAOUWs8HJ7NGCbooUbnWrgYhQT7U1i5xYzXSd0jsO10On5zU8dPV3kHcjAsx?=
 =?us-ascii?Q?5cchcUwl+qyVx5yYapLV1n9Vmj1/iiqn3mn+Yc2d+gWRejtPqZEz37sRmlh+?=
 =?us-ascii?Q?3oB7UuZ7Pz2QNsjVsw3o1G6LgeKyogPFfXxAuqUu7kqpQxeHRUSjbtMJ0u/N?=
 =?us-ascii?Q?8AMkebUZmOLCCGWUG5HUYTFp3mo62L2kjwySUqXBzJsOPBP89ucigFOHbKo9?=
 =?us-ascii?Q?LTmM/+0/39r9voDCytYVL+DPbPaoSRKJ9e+h9BH2C8mOkhhwmdO6rw0P23an?=
 =?us-ascii?Q?F8H9pPfneH3pikoGV4b7xzQh330432xRQAQrmElUYVCdUC5ppklWsoWUEQsR?=
 =?us-ascii?Q?+JRIQ+HSV1GWzVtINY1x2FRIwuBURs1vHlVwkmHjRlXD5VRSOixNAJFu2YkQ?=
 =?us-ascii?Q?kkHMOcjn2sOdOVPO2NIihhT/KuqA0Jyb2Fb7Ko8aGL9MmEh8lM51lEexpiTc?=
 =?us-ascii?Q?mWLLl1Vmb3PE8eMd3N4YeUwoFzXI+9I8wbZmLx5n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672f20b-98a8-4b4f-c1a8-08dbc9cdbb3f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:16:05.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZm89lCp8ofylfs/k3cK5T8zj03B8XlfJLDQMWthAbHMe+kZ/i3yB6R7k5acgZq7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AHB memory as MMIO should be mapped with ioremap rather than ioremap_wc,
which should have been used initially just to handle unaligned access as
a workaround.

Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 65408056daa8..e13f678f2395 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -759,7 +759,7 @@ static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
 				len : NXP_FSPI_MIN_IOMAP;
 
-		f->ahb_addr = ioremap_wc(f->memmap_phy + f->memmap_start,
+		f->ahb_addr = ioremap(f->memmap_phy + f->memmap_start,
 					 f->memmap_len);
 
 		if (!f->ahb_addr) {
-- 
2.34.1

