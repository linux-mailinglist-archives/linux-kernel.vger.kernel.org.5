Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A212377AF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjHNCeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjHNCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:33:46 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2137.outbound.protection.outlook.com [40.107.249.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88205E6A;
        Sun, 13 Aug 2023 19:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3bUURx3Q7oMX8U4OA7Rq9C0MjRyNDpEWHQp1Eo9QwcgjD4oonEpUn41SiC4GEPY3yBTJ66IwpEp24CH92flEJsLe5JyvNmEZPNzM+xyNFqPitcmnLzY5tr+31vm2YtwxoNAOALz3h1jzSrkWAiSeTc7K1puUkzn/DYsbmICTp4lHjS05MO1O3xmIqiPKsmH6XlsgPSkS9FOAa808QmJw/T8HGMMrdSEE5Vz+IqQCMJXohnoLJ1n6d1ARDfgNpwrafGxVVJB9bbvEGVxLrOO+cDS43xf30b3+KVrjtla3nsgLaLOFQlk2Wsc+uhm8lifH2f1yvc2xUKk7Zq8UVBf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXQ7z+YagN8Wp8psyy50/HCrblIP3jfo1TlJ7CbWP0w=;
 b=PnSl5065lzEYdrhpS7WEiIrQuS3zGnVt2YW7cgIg9IRfS7XyICUnJmMsYUdL4BLcDHRbw/si4BKqfGTTkNTMBVyJfulJMrOSDzyROIl4u65+57d3ZaGTi2B2+PANYvy/8p+LHMq2VTxLvC1M/auk/fsIg0dN+jHtNFvi5PDndcyXT5XNtDB9p0Ri846WEslUZ1/GsF1pul5IMPY0qP0H3qqp3gIOCwUpq1xuSMZixoWs2SIyTKod4tNTgR48GVoZJdBPAJRl3moHXRA9/jDK7Gwrt1fyNRERsgU52lvlI8pSxQPGOuf2B3CX/HCbG+JgEe6neWU1A3dnDM+SUvViDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXQ7z+YagN8Wp8psyy50/HCrblIP3jfo1TlJ7CbWP0w=;
 b=kgCcvIRDx1swvz0BkFOw2jitb14T4PnxUi8XvxVG/uHvE+YBJcLTyuPaVigUm2LV0gVYoDea5rgWIQwnOoI8iG0qA8QJlmuiudYhiijzVhWAluv4TawuEOXOrxYOEvNFNO9q15TYfDcJHsSbtDVzXMtTLuqujtJ7D96aZr+aj1O1TumBKCDlmy8S/8rdcYl8NktQV4rgUw+HwAcCXaZ8knhOAzzfAzKq8C5jwVOHq+ZHe2FRGpaxQ84l21B/znwn9cFQ6Omekg+dZVVg14GPOEgXql9XlK1tgi9Wgj9UEjg2ut3Q2+Uiivl/yHHtNMNueSs81hdMV6OxaZbWI/+mvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by AM7PR03MB6401.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 02:33:42 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 02:33:42 +0000
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
Subject: [PATCH net-next 3/3] [PATCH 3/3] netem: allow using seeded PRNG for correlated loss events
Date:   Mon, 14 Aug 2023 04:31:40 +0200
Message-ID: <20230814023147.1389074-4-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814023147.1389074-1-francois.michel@uclouvain.be>
References: <20230814023147.1389074-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::21) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|AM7PR03MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: de3925cf-077f-4b37-3e76-08db9c6edfe7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wwy74dh7FerVwqWqXAYQFX8HQlXEP+yB2bfHkNFJWaYo7QTyMGXCcUUSY8YsQ1ZCISBVHD4lfhMZ1XqnoNAGya74KLmxfePwOvtSoubrY9xJgb9M48ObOwYR3gLEDTXSkXLGjLkIxgNB0cbkF8dcaWyP1O+S9Y3Nh91lJ1A0dSl7XfnT0PfDM28EN6GHMT421+NYWbzzm5wNJGnHP0Ae68f3/BfU5WAaDWNgVfO3kWwQVT5BEYNbvUdsP3y6gleZ2wL1WgJwrqbyjK4mhCC9GCplSOgQ5PpQ+6qIadjMhK0fOrlgNCHZoutlLxNnAAeGaYgTvUhw7YRqxuF65kRndBt3tHwGQjoTn05o5RlmkdrBgkgerajDGjGSimAMdxQNXEogT+Yz1GuKWwPBVOphVmgbIqoF8HfNHnGuTUqoJclBXwBcpKRl39yCB117pXiPd6xaF80wg7vNyr/aidDK3FwMAOVZzl3ALtgDDh2r0+Xpb3y9vrL2rDTSlq62d/cnFSacqR49gbExxet/JcDPvQIQ+N1oDITyQh4vq/PLi6i9q2v+LvRIyXGoFiLyxWUZaMKM8iBTPiqZ9FrzL9BFFeZTxd6tiX1wGMZiXACRDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(396003)(366004)(376002)(109986019)(451199021)(186006)(1800799006)(38100700002)(52116002)(54906003)(6486002)(478600001)(7416002)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(786003)(8676002)(83380400001)(2616005)(6506007)(1076003)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhWeFV2UXBqU0xYcktZL21NUkVydFpiYkFYejVyalFrblJWc2lVSGVMM0h4?=
 =?utf-8?B?eHgyNzdkRTlHZ0NPak92ZUJQMll6RmYwdytrUzNIWHBkYklDME5xVm9VYzQ3?=
 =?utf-8?B?ckxLVEJsSlJFWGlnU2dDMlplL2J5ZkFia3IvaStIbVVWUTR3enk2eGNwM1ZM?=
 =?utf-8?B?dHpCYnAxWStPV0FCUTN5NG45Ylc2YzdGQUxtS1NkTS9UcVVzNktIMGhUVXlC?=
 =?utf-8?B?NzNqVnVHWDdYbm1vTE1tbWo3YjRMOGpPSEVEOVNiZ25WV3NnOWt3T2NOTnBX?=
 =?utf-8?B?cTM5K0JQaXNBWHBWUmJ0OHJZa1cwTXdwSlNINTc5WVhhejcyRHBpd2pyRDZw?=
 =?utf-8?B?cjkxR3lDcUNKL2t1NnVsMFdRazc3K0FJUkgraERzRmtUTlNHWllFSG1JdVpx?=
 =?utf-8?B?Z0xHL0hIbmRCM2hvcG45YS9SY1BvYnU0N2ZQWVRreldWTmZ3VkVaV2ZIbmR4?=
 =?utf-8?B?eURDUmJvcnp2Vk9EMkxweWI3WlRZN1dTOE9xaE9rbjFyb2NyRjFCRnQxa3Vp?=
 =?utf-8?B?YWwvaXhGYUp5LzVWSUVOa0ZyWUl0bjNkRFp1VkFEa3daTTVuZnJWT2FzWW9j?=
 =?utf-8?B?ekFubWdNN2NHUW5FU1hkK1pkS3pkL0ZValMzWDR3a1grdVBxcHI1YjRBcWlx?=
 =?utf-8?B?bWE3UkY5Q2dGcFVDTThKdmtrM0w1c0ptN01BYVEvUGdLTjN0YUJhOWVOYWNK?=
 =?utf-8?B?Sk1hYTBnK2ZveXdaWkl1ZFZRN0hFbjB2V1lDWDhUaWQ4N2ZWNVJZQVRSOCt0?=
 =?utf-8?B?RlhGdWZHT1hTSmNONllNYm1ucjZ6VWpDVjJFK3NQdE92aUlTQjhVMHFqeEcx?=
 =?utf-8?B?Nk5CTVkrQ0c5bFQ5K2FKMlFxYnJLQzB5RDdKbk1JRTRidGkwVitQZmxHcS9y?=
 =?utf-8?B?aDFLa2FSOFJUZlR2NlhQdDU4ejNtYllPR29scVQ5OTdpS2MvcVF4YWgxejQz?=
 =?utf-8?B?WUQzWWdJTXhBRFJKZDB4Nzg0NGN1N1p4dkU3SU5ROTVJOHJ0YWhVUEJQTm1m?=
 =?utf-8?B?UUdoc2VKaGF3K3BVMUJCUjQvcVRlYjFzaVNSR1pUTEdmL2dLSU54aCs4VWFi?=
 =?utf-8?B?Z0J0Q1N4c2pEdDgxbHBvZ05QZkJlcmsvYzd6b2JOM2tKd3YwMGJBbXpVaXdr?=
 =?utf-8?B?MDZacko0b08rcTNPcE1xTkh3eUdGRTNCem50U3pwY2JUaXZCR2lwaU1Ua3hH?=
 =?utf-8?B?WkZvbGRQOVB1bXV3NnZFdEhyZTVmTW9rVGIwUXBpVi9GRnZSOStEL0dsR3VK?=
 =?utf-8?B?ME1tL1VtTSttb3drcERSRC9PdzAreEJUZzFTdVJVRG9EMWxnYm11ZnVLdHFn?=
 =?utf-8?B?R2htbmxsQ0V6M1JOWFFwVzhZQXBIamFIMXBVa3M1VnVlaUZvRCtGdWU5dTkr?=
 =?utf-8?B?WWd6bklmWm5uMlBKN1NKOVplRFI2OWZaUFhuNCszQ3MwR2VUMjNSWEQ1VW4x?=
 =?utf-8?B?Njc1Zzh5NjVwVWVEUWdMeXRoWmdTYVZoWFlsRmtoem5LdHpMU3A5YkN4UmEw?=
 =?utf-8?B?L1RnYnJDTWl4QXB1bzlSaXcycEVyOHFxZ3R4WXN4QzZKRStUNmZ6dkNiUUQ5?=
 =?utf-8?B?SmszbjlmNlljcFFZSWlYZEpvdEhOa3VybE9aRWhIUFJlWThiZnpzaVY4MXFl?=
 =?utf-8?B?MVprZlpDQkNDLzZNVldCYXRSdFJmODVGTDdqTkRWT0Vvb2s0MXNMMWFaazRM?=
 =?utf-8?B?T2ttL3ZJT1RTZU9kU1kxQmFOS1NqSkJidDR0QXhEcUxDdjVuemxHb0JoNDlx?=
 =?utf-8?B?eWhNVjhoUFNYWnQ1Wk84ckc0bXcyRlRNQUF4cUgrbjNKMk5NK1VoZWlzVldw?=
 =?utf-8?B?SnphcktuVjFvSUFXZjRiWllDS0ZKUTRkcW8xaDFETFpVeFpRV1RlRUFTUXFi?=
 =?utf-8?B?emhVNzRERmwvQU5lOUZxVjNSQWx0QnVyNVBqeGJmcFRLcG5VWCtTV3J0b21z?=
 =?utf-8?B?dm9uY1dIaS85OVhuUVJMN2VpVlhNZ2t0S25LTkd3S1NSTEpLRFhXNnVZWGMw?=
 =?utf-8?B?cUxncjBFUkp1bDlNL0FpRjNweTlRWERPNENIVGN2YXp2QTRlK28rdWlUSG0r?=
 =?utf-8?B?NTZYcjFTWlVyOGVZMVU0NitobEJ2Q0pabDdsWkJESUh5S3Y4cVE4emJyTWY4?=
 =?utf-8?B?eGUwTWVDaGh1ZkwyeEduVnMyZ3puaWp5d1k2VnYya0JMZmVhTHh2TmhDK2pa?=
 =?utf-8?Q?IgPxXIrxNTsjw4hZ/YTxUogM/MXgu7VxhoPi1Q454uWX?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: de3925cf-077f-4b37-3e76-08db9c6edfe7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 02:33:42.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VorOM1jOtVKTowHUv0YtjE5vDi5yFDxs4VZbqbkZJDwPAOxIh8H8/2cIFRyJ563FhoT2R2q9/5GrbxbKTiFi8qr3KZcqGGlYUH579fUbk/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6401
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: François Michel <francois.michel@uclouvain.be>

Use the netem_get_random_u32() function to generate correlated loss
events of netem.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 net/sched/sch_netem.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 1190782ef79d..da333c3d24ac 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -198,15 +198,15 @@ static void init_crandom(struct crndstate *state, unsigned long rho)
  * Next number depends on last value.
  * rho is scaled to avoid floating point.
  */
-static u32 get_crandom(struct crndstate *state)
+static u32 get_crandom(struct crndstate *state, struct prng *p)
 {
 	u64 value, rho;
 	unsigned long answer;
 
 	if (!state || state->rho == 0)	/* no correlation */
-		return get_random_u32();
+		return netem_get_random_u32(p);
 
-	value = get_random_u32();
+	value = netem_get_random_u32(p);
 	rho = (u64)state->rho + 1;
 	answer = (value * ((1ull<<32) - rho) + state->last * rho) >> 32;
 	state->last = answer;
@@ -309,7 +309,7 @@ static bool loss_event(struct netem_sched_data *q)
 	switch (q->loss_model) {
 	case CLG_RANDOM:
 		/* Random packet drop 0 => none, ~0 => all */
-		return q->loss && q->loss >= get_crandom(&q->loss_cor);
+		return q->loss && q->loss >= get_crandom(&q->loss_cor, &q->prng);
 
 	case CLG_4_STATES:
 		/* 4state loss model algorithm (used also for GI model)
@@ -338,6 +338,7 @@ static bool loss_event(struct netem_sched_data *q)
  */
 static s64 tabledist(s64 mu, s32 sigma,
 		     struct crndstate *state,
+			 struct prng *prng,
 		     const struct disttable *dist)
 {
 	s64 x;
@@ -347,7 +348,7 @@ static s64 tabledist(s64 mu, s32 sigma,
 	if (sigma == 0)
 		return mu;
 
-	rnd = get_crandom(state);
+	rnd = get_crandom(state, prng);
 
 	/* default uniform distribution */
 	if (dist == NULL)
@@ -469,7 +470,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor))
+	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -512,7 +513,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * If packet is going to be hardware checksummed, then
 	 * do it now in software before we mangle it.
 	 */
-	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor)) {
+	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
@@ -550,12 +551,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	cb = netem_skb_cb(skb);
 	if (q->gap == 0 ||		/* not doing reordering */
 	    q->counter < q->gap - 1 ||	/* inside last reordering gap */
-	    q->reorder < get_crandom(&q->reorder_cor)) {
+	    q->reorder < get_crandom(&q->reorder_cor, &q->prng)) {
 		u64 now;
 		s64 delay;
 
 		delay = tabledist(q->latency, q->jitter,
-				  &q->delay_cor, q->delay_dist);
+				  &q->delay_cor, &q->prng, q->delay_dist);
 
 		now = ktime_get_ns();
 
@@ -659,7 +660,7 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-				       NULL, q->slot_dist);
+				       NULL, &q->prng, q->slot_dist);
 
 	q->slot.slot_next = now + next_delay;
 	q->slot.packets_left = q->slot_config.max_packets;
-- 
2.41.0

