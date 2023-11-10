Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBCF7E8088
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbjKJSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345795AbjKJSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:26 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8F3C6DC;
        Fri, 10 Nov 2023 08:13:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlF5B1VwxJk65FKPPcw42ItGABlGeosmT2zMRdHTp53WQkx3819LnuKhlknga//uG7a9pgSU15sBdxwM1Q2TKoASdTp3/KveSNR0fHRvaUx9j43lXOgMICJUpXQm0M1lG6IRZPa5JpJCPltWNH16iC94DG7loLkxsfru23MU6Gn6pYAfnpWBhycGfS+Ymm7uRfQTB0b02UKk83spprPmdlS0FhCrYfGvQavsyMwPBkO01qVOK8kSVhILJISgzkeYPBcDtbTbQw/i+rRGHuHJArNvuLnQSiMlT8Ozp7a55jDjSdDFZmUwCCGG7kWHTXspe/zDE2nUB49mAyAx8b8MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hilBLmloGI2KW5v4LTvPpRXcsATvidr46sHBmznin9g=;
 b=nXSHWG6yi8OcCi8/5TLyg0M3tJTHH6Pt7aV9iZeTudoxkZAdprNxzCoTTcsvehHjHFjoPApdf0yejMVT9gadlvmiIXfnOfgPQnfljiY00P5szGKOegUtKhX02haQg45L2FtZlYDbt2rCkEFa+5LlhrURox9iWparMQ+Vdbr7pn0WYpTyDooFSZYRTladYAnoQETU+fngjU+zMIIMwY505MwedRmvuCuXeN/AwRyMyQryPT5IKrmY3NNbgTtz9sMyNA5zG6z063fS5qthDZhaS8L5CxkjRPDFvFUXTXP+bDB+JJWIZmDZvyGNzgJJtd7e/y6H6uJJRnObqxTv9E3eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hilBLmloGI2KW5v4LTvPpRXcsATvidr46sHBmznin9g=;
 b=FDsqhMtHDgkGONFUmJid8NGtWNCeKfsGCUidELSXloN5ownIrHOipjc3I1vO44kHep4sVs8t+vM1r+8WaH76Ng/qrHqj0UcguTIfJVDnM/RQ3mjYgMyYGUo23M+/09zQ0/A8YAXJF1SAoOJPWuTPnu/UvvqKhOJFoEnmr/CRhXN+CbuxQ+vXe3Z9mfl4t6deFPNLE1U75Y0JnV4UmjFHaZw9GENtxQsWDQWYZuS6NJqgPovixlsTQ6aoz1YlKMo7c3lG3GPxirCY1oRFii/oe1q11soBq8QGpdLT3GOHdwHS0Y9gNhWOd/81b1T6XPaARSKaDrug00j2diqeNukqrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 16:13:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 16:13:15 +0000
Message-ID: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
Date:   Fri, 10 Nov 2023 17:13:08 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH net v3] net: ti: icssg-prueth: Fix error cleanup on failing
 pruss_request_mem_region
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Roger Quadros <rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:610:76::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 3086af3e-d324-470a-e115-08dbe207f1ab
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: um/ZetfxVeF82x7pULHS2LM2OXTODsdfUKpKZ2eDWfR2tQJt9hP5puG4TxSVHtoyLtexcn1Lex4wc78az4MmzSVtW/TJlvY+zP/oOzpvqKOZNZjb84c8XMS1VXGf9/cn5Vc7ArJYt5Ul6a129DuLuME9NbBd5A/o0+nW5xJz6zGWDoz/of0B5FF+tKAHbyObbJpg4jx18tl6e3qFbrzJT/0UeHyMRXxbiCLN8xMUG8QFFkGoC2bvNNE25aGYlk5qZTEYCJF/WchoRozeEjGRWa0duPFbSATXJZWvXBgZMfxdY+cWUqXOsvr2rwh3zptmBrfrMYyT+4cGonhHxTCbuK3Zg3IOSdreDEbPZkMPS10gY6IiTDODPDWdJt/IDVBVRGb8SNauYyLFOIChoipjBTV09utHqrKpJNhvPr1W7GpgZYxFDQRcD4jaeUQFwrawa94iXyPyvERWcr9/Jr1LSTlgKZbCGRePukE5nrm9nEjllGmHmAOL4u2xN+c0Yq4UIorGKhlgmWhYPEHO7doKUyz9G2ZcwkJqYxkR3yPvF971McP79MT596/ufcUmRjYBCKK369rpEj/LnTAa+fyge1mBLx6HP0CHNYwgPvlUwY1eV00mzekISOv1fUaanWk7paIKgxVIH19lXauLndae4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(83380400001)(26005)(82960400001)(2616005)(44832011)(6512007)(38100700002)(6506007)(31686004)(478600001)(66476007)(6666004)(110136005)(66946007)(54906003)(316002)(66556008)(36756003)(41300700001)(2906002)(4326008)(6486002)(8676002)(8936002)(5660300002)(7416002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVcyMjRJbEdvTUxhZDlIWGQ0MUVvdWNNRWJycnI3RXlqL3NvZFpsUHNiaTJC?=
 =?utf-8?B?Q3EzWE9CZzJNaHRlV2tlejVGSElCelRacGx3cDAvbFFOZjFvTURWanFzc3Nw?=
 =?utf-8?B?YTBLUmcvTnh4b1ByTlZrODhWdWt3Z25xTEhBY2ozOGtJRGwxQWdiVEppbXFU?=
 =?utf-8?B?QW9iaFVaWm1Pd284NlVqQm1rNEZ6R0hTQ2lVTU5ub01ZeFJva0Z0ajRtaXlN?=
 =?utf-8?B?U0xHcndBTENZSndWLzE0UHl5bjR0b1ZEb2p3WkJkQ25SSVgrY2pueVpSbktw?=
 =?utf-8?B?c2hYUVJ0L1hsOTVyWlpJZzVhR2hVbFlsSitFQ25od08yVnAvSmJYK3VHazBQ?=
 =?utf-8?B?MVBpZjBjb1c4VmNBTmE0alBabUFjMmRvajlwMTVzeXhFRFRiVzM0RkxQeFpO?=
 =?utf-8?B?ai84dkIveU1yOXRqUW54Q2ppZ2FYMDZRK3hiUmNVWVNSU1dQVUk1bW5DS3pH?=
 =?utf-8?B?ZFJtZ2FLVjZzSTJRZ0RNbWNtaEREQTNjOWQrRkpDcmpoVVoyK2pTS3RFOVQ4?=
 =?utf-8?B?bEVPTjhBWnBHeUtBbHFIZWFwYk4xVXR5a0QrQit3enR2N2N2aFVSK3BDVWd0?=
 =?utf-8?B?OWJEYmQySVlYdkpyeDM1ME81Y0lramNxb3BhdGJjelI3b0ZUUE8xTmttSFdY?=
 =?utf-8?B?VGtTMVo1WDZLcXladGo1NTRlMWlZeHdxK1BIU0tmMUZ6MmZrQ3VDTXhMZmhZ?=
 =?utf-8?B?SHY3RTUwOTdhVDV0d2tZZ2NVYUpTaDVXWGVsOTBxVnRrbE9MR1lDbXErVVUy?=
 =?utf-8?B?eGZTSjRwWUhkUFZxWmJWYk5KMlQ1SUJGazROQ1liT053eUViL1lOQjZUNHh5?=
 =?utf-8?B?ajB1dWl3TWEvUzVaNHU5TkM2V2ZSMlhvYmQxc2xGekUrQk1USnpLT1greHlr?=
 =?utf-8?B?YmRIRGg4aHQrbzdBTkJGUTBwZ05semZQYXV2MTR2b3VvZC9LNHM5VTV4aXN5?=
 =?utf-8?B?SitxOFVlZ0pXbmk0dDdzYkttRytGWjk5NzRMdzAvQS91Snd5N1p6VDh2N2RF?=
 =?utf-8?B?WUVWTnlveHRramQzblEyUVNsS1dDMnI5UjZneE1vaU5hYjZmb05weWdwa0w2?=
 =?utf-8?B?RWNrbk1ZSXgzcGhSVDlqc0tWU2d0ejRrVWYrREp6QzZXWUNDN2gwVkx2ODNG?=
 =?utf-8?B?SlByYmVqY00xUXhtdVZJeEw3QmRiclBINGJIZmIvOUpyOWZRdGY3K3NUOHpC?=
 =?utf-8?B?OXpNbTRSRERzeTY2ZXNPT3FXVDA1ZjNHRmwwMzBVSmhnU3NpcDdvMWV4ZWdw?=
 =?utf-8?B?U3Z5ZEdIMTIycVpWYVhPK29jM1FHY3QwN1FnOVhvaTN3VW1nRXRzZTQ3d0lr?=
 =?utf-8?B?MlQwYkZRQk8yR25jMVNLamhlTzMvRVBqU05IUEtQSkp6NHJpMmpTN1VoaHhk?=
 =?utf-8?B?alJIK1NReHVwa05uTnNGSTFVbnFkN3NzUzF1bEFjMlBqcXJGeGhGNWVnTDJy?=
 =?utf-8?B?YXR3SW4yVDJpK3I1OGZUaEdpL1JYVEZsVXhmOThPb2s0MGdJNEdHNWE4aEZ0?=
 =?utf-8?B?a1Z2ZmpidWhlZEx6b1hQckcxL2hCY1BnbWJyMFdHSmZIeDU4QUFOZlZXVEsx?=
 =?utf-8?B?clpGUXlFdEtjeDB0S3JOMGszMWdSM2RxVnVXc2JQV1dqenkzdThuOGZBYUdY?=
 =?utf-8?B?THlFT3FEdVB2emtVWVZzZU5MNlk3NFZFQjVWZFNuY1Fyc1ZwQ2Fpb3o3YzMr?=
 =?utf-8?B?amhPZFUvS1BZMnM1dWo0ZDZpR2NlZ0d4N1YwZDN6VmhiQW1wclliU05GWXNl?=
 =?utf-8?B?OUZsVWpWaHNFdm5HeUViTXhBRzVuL29OOW0zWW5FTXNVVlZFa1VCbGpGWUhR?=
 =?utf-8?B?OWl5Y0dkSTZERWo2NnNCUU5JbjJmZzN6U21sZHEvZ3ZQVE5DVDMwUXJGMWJh?=
 =?utf-8?B?SEpwT3l6MURUaUxaSzQyL0NJbUUwRE9SRER1QXZqTzFkdkhYMXZlNHRJRmF6?=
 =?utf-8?B?NUlIbk1LaEIzMldqL2R1L2FPd1V6bEpaR3JkNUo3M0xwY1N3RS9tQm9wV04z?=
 =?utf-8?B?eE9IdUV0MXZsN2E3M2VwczlsbndKOXBHTWJPMUxoemN3Mlg2T1BwUGlVN29l?=
 =?utf-8?B?VGcwbGtJQ2NhY0VxZ09jUTFhM2tEeVMyUHlzOXpSZ0NYVXBnQmwrcHpIK1R3?=
 =?utf-8?B?K3dXbFB2bjhLR2NJTWZmN1BNeTdmcTd3REovUGNtV0pGZVhXRDY5SURKQzBL?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086af3e-d324-470a-e115-08dbe207f1ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:13:15.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8SpgSr3WDjhGQjGK4y3hvv6z+G7rFrZGU2qBtAnLE/ngx2byRhQeqxFDdESBb8QiA6WG2No1O2Zpw4ggnG1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We were just continuing in this case, surely not desired.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---

Changes in v3:
 - no functional ones
 - added original author in CC with new address

Changes in v2:
 - add proper tags

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3abbeba26f1b..411898a4f38c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2063,7 +2063,7 @@ static int prueth_probe(struct platform_device *pdev)
 				       &prueth->shram);
 	if (ret) {
 		dev_err(dev, "unable to get PRUSS SHRD RAM2: %d\n", ret);
-		pruss_put(prueth->pruss);
+		goto put_pruss;
 	}
 
 	prueth->sram_pool = of_gen_pool_get(np, "sram", 0);
@@ -2215,6 +2215,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
+
+put_pruss:
 	pruss_put(prueth->pruss);
 
 put_cores:
-- 
2.35.3
