Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7577CA62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjHOJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjHOJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:25:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA410C;
        Tue, 15 Aug 2023 02:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFeUtSrFztyVMr/KcpWMdzPOwvtzq5Hdkca9HV6yUxbPixUUtDRF9pZ9drQCFoIxhgSF4dLmiHLLA0UE7O7Vn5FlKC1fTkaGzcjux4/nf9he1zk/R1BNvoioG8K2OabvaQWq58tUKJ1ACBqwsGtvh8rjE+3GaAWYWMSBway3AlcP4kS9Ou62mn3XqNsfbqiK3cg1NHbxGytB2peWPxhaqsCybKwgtnPyg8H4SB7i71EECQQE5Tl2LZpFVOjSH5P24wTTN1Y+BmvhEXOQORT2VUeDpNzOVV4iN9ALRuOQ1V2gPx6X1pMb9Uad4guh7FvaWSykdK0eMev6lGYw1lHpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C12dRi5OfAHoQaEVlByZI5+EGSzPCGfepGxfTu4oLwI=;
 b=VQpGR1BWRGt3xdebYvNsOYfbSW9SY0nUxJ2or8ihxs3yQtDOmti69ifXind1CRSJU4lGJ5ldKKUmNRhLT5sPReeg0fDN0bVs5dZqRFLjUxX3x73nFmYJZA0sQpSDMCXuZW/I4RO/FdG7c3SVnwVjM9NWmZxzLUFUJ57nW35tYr1p+52onjIMqrRU4YQGDUuskAqZgrwHfyEUjiS4pqt9fQYCUR/SMGBfX0GZ3u8TgMf4IHDyh31qmpCFMP/9/XuwbAYmigfRpH6eoQzLpbgm2lU/PbbUFlpS0SdA3p12oWRUL0iibYn+3ci3ZTWNNJXF6XN4vqFmPA6pRLs3sZdWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C12dRi5OfAHoQaEVlByZI5+EGSzPCGfepGxfTu4oLwI=;
 b=eLxfeN0G6xoIWTNvoHvsDn9adgeqU46MXjyUwoIhnkhDsVPZV2imndFnaI9B/eghGdIxcCrFIsFxnwbwaOi8jMvAP9PGeCyP5BOd4hMdFYEu8aCFR9Hoxv4tsSagXyIAwqW1dCFTVA1zUZCT1Awjxgv+jxaVcfXtuHx+te5nHkTEe6NzLZi/+CCpewOYcPdPFp1+t/NSjzrWftEYWkAHlKnKb6LOHRgDbJ/WSIpJiffB/DrSZ9TMSTt3Ke2Ao34qkAgublpT0x12mK/wffG4Kfypya0RtkUr9SA/XmJ2Ir4CHsVou1myNIaHjMkDp6tSk/g/kXnfaIn43N4GMwUYcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAXPR03MB8228.eurprd03.prod.outlook.com (2603:10a6:102:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 09:25:07 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 09:25:07 +0000
From:   Francois Michel <francois.michel@uclouvain.be>
Cc:     Francois Michel <francois.michel@uclouvain.be>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/3] netem: use a seeded PRNG for generating random losses
Date:   Tue, 15 Aug 2023 11:23:39 +0200
Message-ID: <20230815092348.1449179-3-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815092348.1449179-1-francois.michel@uclouvain.be>
References: <20230815092348.1449179-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0131.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::10) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAXPR03MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: a3278012-e065-45d6-994f-08db9d71840f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGiDQBfWMA9PTRsT4dYKQ8h30joX5PHma45KImcAKBhXbie9qQma+EKpLvtL7vAux0hktIY6f+lO+AypxLwrCDotv2RVU1R3yk7wcSSflVLj8joWDFh34c0Y4jc/VLIUt9L+2ZN5eDO7tPjc/Nx548JI/Pn8grUKue3FNDEeYlMx4DSpRyLJqVPTYNCk6I2TtlFWm4KCyzBGc4LfXDSecNUkNwqU0tzvV3RvaGaQ5DcSgqPvD4Fzgk0w1cgcU+FEIOzfkovbsnXlwdkh5dlZsGem8K9WIOI0f9ZqXoTxjOqqOe0K70muagQMYtJi+iIf0xorXt4Uz9ajC+QPMw1bUZZi0fgREvSHKsTmDGnmUzcIIOJXIdyiAeot0X/LsrZOH/lXjn6M5n2Qm1bgo6pQWlB2SRORwEESjoWaJBj49ltVpG3GQFSVO0HDsAttyzKEXGDfYG6cboAy2CwEWsqpK10AGz6vfOOB6mjIdFGzQVpMiInmgkxda2n1GbImcP6EnXabGdms7/bH1B7lfi0hEhZUDdjdMGxHxAS6DvqlI7z67O5bvm9DCMNf++nEdts5whgcj82TtrkZRuE8Fd1GCjj/aX2NyOVsiVps+z6fW40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(109986019)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(66946007)(66476007)(54906003)(6512007)(66556008)(316002)(786003)(8676002)(5660300002)(4326008)(44832011)(8936002)(38100700002)(2616005)(1076003)(6486002)(6666004)(2906002)(7416002)(6506007)(52116002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRWN0RSMElsL0JhUm55TkVoaXA4QTByVWtXQUZhWkdPNlpIY29tVTlUMkl4?=
 =?utf-8?B?R1NDVDZDMHBkRCtoSmZkQmpiVU5iR09Sa200aWVub3VTNzlWN2NQSEEzNEs2?=
 =?utf-8?B?cENSeWsxb3NuSUNzWnpHUXFiVVFYVVcydjVFUGQySmlxMWtWZ1NUalltdWFt?=
 =?utf-8?B?bUhDQ2FIWm9iZERPQlI2VnFoNWhEMVV6QU5iaFFCaHEvU2RKMWViblY3ajRQ?=
 =?utf-8?B?M3J5bVNFK3l4cUlOU2ttWTUwRURzRU00WGhtOVhzdGZlVm1sQXV3WnJYUDQv?=
 =?utf-8?B?a1VPMVc3NlZqdm4vODFES0lxWW5hVVpYb2R5c2wyalF3c0o2aXJSQlArWnRx?=
 =?utf-8?B?dUc4bDNnNjBYRDlwUEJlNitvLzV5MmZGWDIwS3Q2QjZLTFRvK2xKRXVjNHpt?=
 =?utf-8?B?aWkxNTBYWDRNdDJ2VnVzWXZ4RmRkMUNtTFM3S1FMWHpGNitxY3AremhERUdT?=
 =?utf-8?B?d3RjbSs3RldDbVhUVDEwOWhTMUU1aWxMZHhuRGlmY2lvZDJoRzUwMVZpWDF2?=
 =?utf-8?B?NHZTQXRPV2JYTnNoY1JYUldENC9DZmZvdEgxSlg4U05OMW9aZkNJb3p2RVQ2?=
 =?utf-8?B?M3g2Tmk2a1kyOWRjeWRaRlU0cDNCTit3RFVEVGNoYWh6MVROSjRYMlA2WHNk?=
 =?utf-8?B?bkdzcG1zT2N5ZDVWRDRZUDhVNnhLYlliV0U5NVFEZmRQSUwwcDRyNVNmVldH?=
 =?utf-8?B?MWF2L0tCcWEzcjVBUXJOR2piT2w3VTdoNllPcnpFOTJhQ2lSY0tWa2UyRjhV?=
 =?utf-8?B?cExES0Vqc1FYMTdKUlVSVU9NSFhVOHorVCtjNlUyRG50OHJuWEZlb1orc2RF?=
 =?utf-8?B?NVFNL1BqYWdTSkc1SnFVWEZUa3B6UERqaEpObDZFTHZhRk4xVUVXQUVLNzRI?=
 =?utf-8?B?MkF5eHlINlVPWlJOUmY5VlJaV05MWlJEaFQ4SEZUa1oycUxFaS92aUJHMXBa?=
 =?utf-8?B?RkM3SlZUWU5jWFlZKzcwcDdoUGJ0OWFFZHdtbWU0WjNaSVdJWnJwTi91bTVD?=
 =?utf-8?B?akEwUlZmVy9ZeE9DYjdOZ2ZCVHphUFZXSUJWWi96YnN1UWFtL3NXV1o4MERy?=
 =?utf-8?B?U1B5SVdycVNINEdjMGtnNjRhTUR5TEFhNWFDSnAxcnlLWlh2blNXZFBzbnZr?=
 =?utf-8?B?MlRmY2xkY01XN2Rvbmx0WDFKbS91NC9jWWxRVG02T1VvZi9XbmgwR2xzTHU0?=
 =?utf-8?B?UVBxZFNIOG5IUTZGWEhZNzU4c2tPN1g3TUlUQ3VNQU9aNXovQWJRVE5lc09i?=
 =?utf-8?B?MDRhN2M3L2RLT3AwekVjYng4elNoVFcwcTA0SVJPM3graTdqbHlnMUZlTzli?=
 =?utf-8?B?WmZPOTBuZzlzR1hwSHhhV01GRjFxY3YwYytzU2RVanFoUkNpRWo5TVZGZDVW?=
 =?utf-8?B?eTNXa3lDanhWUXRBb1NTQUc0M00wK3VzdHdkZzBVTzZVV3dQTEtUclZwS2ta?=
 =?utf-8?B?M2xxMDFaM09VTFJOKzZNN1hrQk53cjJ4YmtrSStka1hmdzAxWS9EKzVVNGIv?=
 =?utf-8?B?T2ovSXNWa05KUStlVUEwRjgzK1F3ME5EYTJlcWRjcFEvQ3VrVEZWcjJ0SmtS?=
 =?utf-8?B?SmlKTm9HMFRNMjlSS3I5NVpzRm1XWG1FZEpDUFlOZ2g1V0hObHhzTEFoOGNH?=
 =?utf-8?B?cTVRQnIyTjV6T1c2QmdWNnl1anhNRE1QRExwdUZzdVVZcW9hUm4rTzdXbnpR?=
 =?utf-8?B?d2ZqZzhpMC9BZjhCb3VUZTIvZ1NNd2p3Q1pVa0psNHVhbiszakRPa2xvTGFU?=
 =?utf-8?B?QmdBRk11aWJ1eEtGZ1ZjNm5PaUxMelRCTno2bEk2RVF5ekxPTVNkdU9qbEwz?=
 =?utf-8?B?UWlVUEtUQ1NNVGlCR0lEc3dSREY4SVZZSVp0K2Q1K0tnLytsbXhGRXRNN2h4?=
 =?utf-8?B?VldtREw3Skp5dVJmUkNvbVZHYldsSFdvbFJhZEVVeFYrekJhUWNtRWYyb0d3?=
 =?utf-8?B?cUdyQjhORm5zVlhmQ0V1S0dOeTlicUYvcGNwQkdBZitBRUU4WlJ3UzdaY0FX?=
 =?utf-8?B?NnJJYWZrZzYrY0FEL1YybmxPbXJycW16MnVNazQ2ZmgwZUZBbndCZUs0RkQ5?=
 =?utf-8?B?MlJlajJ1MHhXVGRva1BxcmJIeWhmSHphemIrRlNZbG5xUk1lWTAzN3Foancv?=
 =?utf-8?B?UWpjS2hwSjVnTFpZRkQ0K1FxMnNrOTExRFNzdVpQTHpXM3dWdWd3M3JLRjdJ?=
 =?utf-8?Q?CIkvMvzXuM6o+2pmG1EeA+o2YWHKw7b6drkr23WpIKKo?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a3278012-e065-45d6-994f-08db9d71840f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:25:07.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IfItba14aDu+DiSmTZX0HhqWcLiXfxLirMkmNdUe9ixkT4vAWTSDdgJmKj/TsMUFdM5ike1ixwC5BxSqgA+5QsaX2pmDeOUUoZ2PEgcfdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: François Michel <francois.michel@uclouvain.be>

Use prandom_u32_state() instead of get_random_u32() to generate
the random loss events of netem. The state of the prng is part
of the prng attribute of struct netem_sched_data.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 net/sched/sch_netem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 621c6acfd644..8b54b1005a10 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -206,7 +206,7 @@ static u32 get_crandom(struct crndstate *state)
 static bool loss_4state(struct netem_sched_data *q)
 {
 	struct clgstate *clg = &q->clg;
-	u32 rnd = get_random_u32();
+	u32 rnd = prandom_u32_state(&q->prng.prng_state);
 
 	/*
 	 * Makes a comparison between rnd and the transition
@@ -271,18 +271,19 @@ static bool loss_4state(struct netem_sched_data *q)
 static bool loss_gilb_ell(struct netem_sched_data *q)
 {
 	struct clgstate *clg = &q->clg;
+	struct rnd_state *s = &q->prng.prng_state;
 
 	switch (clg->state) {
 	case GOOD_STATE:
-		if (get_random_u32() < clg->a1)
+		if (prandom_u32_state(s) < clg->a1)
 			clg->state = BAD_STATE;
-		if (get_random_u32() < clg->a4)
+		if (prandom_u32_state(s) < clg->a4)
 			return true;
 		break;
 	case BAD_STATE:
-		if (get_random_u32() < clg->a2)
+		if (prandom_u32_state(s) < clg->a2)
 			clg->state = GOOD_STATE;
-		if (get_random_u32() > clg->a3)
+		if (prandom_u32_state(s) > clg->a3)
 			return true;
 	}
 
-- 
2.41.0

