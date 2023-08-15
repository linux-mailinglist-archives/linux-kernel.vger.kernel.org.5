Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599F77CA63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjHOJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbjHOJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:25:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22224113;
        Tue, 15 Aug 2023 02:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpXiEVEEYhsHomZjvMCNej7PZQxkVE6J8e2+dLD0LkT6xoczmeZ9A78bxUjaMqUXDIv5P2V+QRw6mmdc+f1T2XKeLMZOlgK55yxNen0GJ6GKsSo4kFCdsqVVIiSUkolcAcUg7i5zOjK5w1lNhth4e6vI/JDT18iKtHHFnsNg3kAmYMSMwZ/WiQ0855Jn96/SKt2rAPN0aNxzsFcA04Qat/TPA/P1Nvq8z3JIBjmD4vwiIByU+znLEBdR0yHtABbsrEEv7ovw9WEa/qclEFl/+LfPrm4IH1O44JcZNCYOEipQs6v3XZP1nzdWTwNfxz9l4GS4UjgZylW1h1xHtJunGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVSxTxsXGoF6gCI/UoMaOM/NQ0mLsqhPdqXDddOq32A=;
 b=ZrJLhphx6Gq/NlyfLIGNPIxCq+u5XA9CJIsTg9bYg8UxRqTIbbi7Ekaz1XLeQLeszTtVKROO9yB1uayCxHUUVb8Cr0RM0lvK8q7ma71PCoJ9gutOmEYZb9nMuxqFDiEqiYGH+A65814iBHDK/cLjM11uFsQTyyxpObUodkF9ORIVkaG65bDK8mwV5uoo3doYTTI4nkQ0jPzPWnjs9rLLS6jvzKLv+WNu3Cln0NPa8qCz3qJFU1y+Jgj6xSgArP8wfFHi+4Ozh/cvZ92SLp+WU/JLVxZwnNLcnsSWwjOMvOHNOOS/bryIUY0gCA2e/ZTGR+Iphom6B86Vz11Xj9kxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVSxTxsXGoF6gCI/UoMaOM/NQ0mLsqhPdqXDddOq32A=;
 b=WTblzMMt/F5genKzkq4PSSqJeUx1HcThUtKZsRVroJuxakkl8LgQx9U0GK9OI0jLb4ZShBO7uTuzbFeRUS4tUjSKlzRJ7P7b3zinGTOuHXbAQtYrvX1GK6uy51tCy3D/iIKqUCQvvyWPLeqB4XO7IOWstErMTAqOZ4VkMyASgamSxtgZ+K8AJSNlyZxyN0aBsquhcVMxmHdWJ9keKRlA6tJffWsqNpZR4bzJic/gvbn/N5vCaRcfylavAl+ThavoQsSpwQ9CLipjXxGDk5t0KuCeyZYmrBD5KIJj8HjXlUJlJ2d+B/03Krs3+SpjzP+ZrVbdGDmLyoZm9nCUbZ0yJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAXPR03MB8228.eurprd03.prod.outlook.com (2603:10a6:102:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 09:25:09 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 09:25:09 +0000
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
Subject: [PATCH v2 net-next 3/3] netem: use seeded PRNG for correlated loss events
Date:   Tue, 15 Aug 2023 11:23:40 +0200
Message-ID: <20230815092348.1449179-4-francois.michel@uclouvain.be>
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
X-MS-Office365-Filtering-Correlation-Id: a89f4a7a-4891-4afd-fc44-08db9d7184de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8HGxmzX5Eb87x15dW8vIzgtP38uK5whGxvE5TacZKCixdpX7IWe6r2OV84T1FXewR5PKkXMixSrB8f8W1cDYM+pfzZqP4gczhW0GxrQ1bRAv16yAk06KBXyUY4Qt+nG9UZd34KlQ36NgkWpoImitDxUpHDgZIYgSH36UBZNtK/h+ZLytMzaQ3F9xAxjwbQrL+oYcNR70Xw2pCLms0913jLiQtjMLmuSOodiIXaoCGrEDrY3oVwqk6KCW7JjAhSlI4Va1vVTkeQDbVsxfHHE6+MgXmIERVPTJPkekVliUSHaLBD5WJgboOR/QAV60rJAhEBKhNu+zjPa7AYfBpiAVycL/lxxrHCykucFzWAQWE3lreej+WwuYfRBy/+RMUCQQ6uCxCwKCJCtLSjkqsnWnrmEHwyz7mYT7NbfTk7V79gtY1ZF+Rmi7ja/U16mcgMFl5Nh4sC2WLF9jRdLCIA0iKBpLzS5WXdkgpzDzFJG3ylhrw07m6we1G47VSusIyy+o7I3EqIBPCRzi8AuJ6bLdmoDGGILdznRJKugeOsAzldMDTWmASovmv/ngjQUoVb0T2T2xCjnoPnz9kxz1BVZ/yo3iyFFrWwVcjpzcG1X55U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(109986019)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(66946007)(66476007)(54906003)(6512007)(66556008)(316002)(786003)(8676002)(5660300002)(4326008)(44832011)(8936002)(38100700002)(2616005)(1076003)(6486002)(6666004)(2906002)(7416002)(6506007)(52116002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VDTzdvWklZY09Ub1ZnMklmblZtL0Q1Q1VTanBQNElQL1FMaUFlcUZPc0Zs?=
 =?utf-8?B?NUcvRDJRb2NSY2tHYzlaN3FnWWhnOVNhOTcxSEo4NXJyOWMxcmdOMjNVZ2xZ?=
 =?utf-8?B?ZDNrQ0hOSXFXVjJPb0lxRmRZaExBdUdwTVFJbERhSHdlN0x1VGxrUFRuc3Vk?=
 =?utf-8?B?d09sRkRRV3ZwOGJkL1N2QkpXT3BiSWR5MTJVL1ZjQlc3ZHVaWFc4UlVBM2o3?=
 =?utf-8?B?U2xBWldNS2lmQ3NONHNZQW5OVVNVWmt3M3ZDUE1TdDN6S3hrUzUxTnk1UnhO?=
 =?utf-8?B?WmdhNVJNWU1oTk0rcFBOekhMeGVCMTVHZnBzUU4xc3V1aklBdkpFOEhuZysv?=
 =?utf-8?B?UGpoams2QVVDT0JmVkttMGxqVWl3UTRLQ1BnR2pGZWMvQVU4L3pCUFNFZ01I?=
 =?utf-8?B?bHh0am1iZ1FaSUxYVmdlUzZ4bzhIRFNkeU1YaWxOTy92NklZVTNuaWhwV1l6?=
 =?utf-8?B?Z1duc2J5NkFKS0VFa2pGVzhrdHpKZ3VXUWlhbFRWZHZlc3ZQR1lzTTFjTWNt?=
 =?utf-8?B?Nzk1NnVTTXNORS8zTlpTWjJpelN4dDJiUTA3MkpkajdKYWJuMFZLYnluNGxT?=
 =?utf-8?B?emtpczdQY1NZUXlLTXpXTGFudmEyQUR0Wmc5bEdsRWdkeXhWZGl3ZW9lOGY3?=
 =?utf-8?B?aTgzSXMxREREdFZDRHR3QmlWMTFscWxramlBTlRRVzh4QVlmL0pGNGJTZjFk?=
 =?utf-8?B?Mis1M3lEczEvVUFxYWpXRC9aNnpTdzdvSUJEbnQyVTBTaVRFcVZkcVd3MEMy?=
 =?utf-8?B?OXBRaGdQTDdBRUJkNW1jOGxDekVKK0JBK2l4QmRmTDl4OFkvODdvNmFEc1lh?=
 =?utf-8?B?MFlrQ0hKakdvYTFLQ2NDMFpMaG1NRlM5c0xKeDdkajBJYUZwdEtBOWYzdmJ5?=
 =?utf-8?B?azJIOTBickZGdE5GT251dURWcjYvbHZlR3g1WU9RQXROQTBIb0d3T2lqdFdE?=
 =?utf-8?B?UkJ1TUlVWHJzcUsrWmpiWXZyVWt3SmxGSTBiZFBoRVEwUldpYStDNExyTXBB?=
 =?utf-8?B?aDlVUk9qVVlmSlhGak5iNjZmODZKc1RZTDZhTmR5WnBSQjBIL1NBT3NoOFF1?=
 =?utf-8?B?V0tuMnlwWm13ekpuNEV3aXlEVzNKR0tPR2tPcGFpbXN6bklnTFlrRkFKV3o3?=
 =?utf-8?B?T0xKK0x1WVdjZ0w1RHlNRWJOeHRDOHk4ck1lNWFlZ3JTeWZ5SktmUnVxZ3I3?=
 =?utf-8?B?c0tBNnpMT2ZHQmZrb01WTkZxK2dWUXplMW5EdE4xdGxpMUxiYUVpUmgvdkE2?=
 =?utf-8?B?YnZjT1B3MkR4dlpPMzRvMVhway92Z3ZFa0E0MnFQd3dzUHA2Z2lkUzk4SDZy?=
 =?utf-8?B?UVM5ZnhaTXBMRVlqM3BLOGhYWlVpNG9FTzhNOWJlOXlrODFwZTFsNzN6c0Vh?=
 =?utf-8?B?QmFzK2k5ZkZGRXpiaEtQZzV5NHkxQWQyUGRuSHVrd2Nqcmc1VjgvRTNET3A3?=
 =?utf-8?B?MlZERlZKZzROd1ZjbW9KS3NQZ2NyYlBUTU53U3NJRTJBc1RVcldidDJROTJu?=
 =?utf-8?B?LzNOcmhSM2hwYTI5OVErSm1SeEhCMmdSNjFXblpLNGpHb2VHRFVUaFZmZ2dD?=
 =?utf-8?B?ZDlsNkdOd3RneWw0VVdNN2FjNldScTI5YUgvT1cxcUtVTW5tKzB5WW5tblFw?=
 =?utf-8?B?SVBCTE1PekhubDNFOUxNMGUvYlpYQnRodW5Oa0tXTFprR3RXUlJhU0pHdUF5?=
 =?utf-8?B?dXhaRzVXd1l2cFZyN2FLVkFUOVJRL2d3aG41UVZjaWcrZmJNaThYbCtDbFhp?=
 =?utf-8?B?a1J3cTE4ekhxK3hQcHQrZGIrcUR0cnpXcGhPYTQ4Q1pMNGNRNFN1MGdteE90?=
 =?utf-8?B?UnY4VkxPUG9nYzFxWmRRY2JNZXE3ek40UE1mRCtucHI4STEyT3VYekgwWGJS?=
 =?utf-8?B?V1didXhtcSt2Zy81U1Z2T0ErSi9ZL1RTZ2pIZDFOSGQzTnAzeGJWY1FpRHZm?=
 =?utf-8?B?cjdjMCtvenB1ZDJnUGJJeXhUUFZvOWNIeEpyUkx5ZGZTd24zaFNPTUo0eE9K?=
 =?utf-8?B?WG1admtIdnQxS3NOZGhMQkhnV094L3gxN21XeGVrVjYrRHA0ZjFTWDVOb3Nz?=
 =?utf-8?B?UjVYVDRBL052aDBKK3BxdnIrd2l6bEpjb1lTMVZIdXJGT0xnKzVKencvdDk1?=
 =?utf-8?B?aUNOckc2UlJ3K1hkd3NDa2tzOTh5em85S1VZSzRvOVNuY2NubzNSbmlNWWQw?=
 =?utf-8?Q?kK8ZxyZOaAm03xZry8+6IrMKOh58TfR7PvAMBvElXyA/?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a89f4a7a-4891-4afd-fc44-08db9d7184de
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:25:09.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXP6oNFOpmtwX7UCpOFScE9ce10vb6TBZcW+RG0dWn6p7P5mConRIwqcz22Qrrx0EgpjV5lMoXHfO7EpeC6o3txVigytAaWIkh0i3fD8pYQ=
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
the correlated loss events of netem.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 net/sched/sch_netem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8b54b1005a10..4ad39a4a3cf5 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -184,15 +184,16 @@ static void init_crandom(struct crndstate *state, unsigned long rho)
  * Next number depends on last value.
  * rho is scaled to avoid floating point.
  */
-static u32 get_crandom(struct crndstate *state)
+static u32 get_crandom(struct crndstate *state, struct prng *p)
 {
 	u64 value, rho;
 	unsigned long answer;
+	struct rnd_state *s = &p->prng_state;
 
 	if (!state || state->rho == 0)	/* no correlation */
-		return get_random_u32();
+		return prandom_u32_state(s);
 
-	value = get_random_u32();
+	value = prandom_u32_state(s);
 	rho = (u64)state->rho + 1;
 	answer = (value * ((1ull<<32) - rho) + state->last * rho) >> 32;
 	state->last = answer;
@@ -295,7 +296,7 @@ static bool loss_event(struct netem_sched_data *q)
 	switch (q->loss_model) {
 	case CLG_RANDOM:
 		/* Random packet drop 0 => none, ~0 => all */
-		return q->loss && q->loss >= get_crandom(&q->loss_cor);
+		return q->loss && q->loss >= get_crandom(&q->loss_cor, &q->prng);
 
 	case CLG_4_STATES:
 		/* 4state loss model algorithm (used also for GI model)
@@ -324,6 +325,7 @@ static bool loss_event(struct netem_sched_data *q)
  */
 static s64 tabledist(s64 mu, s32 sigma,
 		     struct crndstate *state,
+		     struct prng *prng,
 		     const struct disttable *dist)
 {
 	s64 x;
@@ -333,7 +335,7 @@ static s64 tabledist(s64 mu, s32 sigma,
 	if (sigma == 0)
 		return mu;
 
-	rnd = get_crandom(state);
+	rnd = get_crandom(state, prng);
 
 	/* default uniform distribution */
 	if (dist == NULL)
@@ -455,7 +457,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor))
+	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -498,7 +500,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * If packet is going to be hardware checksummed, then
 	 * do it now in software before we mangle it.
 	 */
-	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor)) {
+	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
@@ -536,12 +538,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
 
@@ -645,7 +647,7 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-				       NULL, q->slot_dist);
+				       NULL, &q->prng, q->slot_dist);
 
 	q->slot.slot_next = now + next_delay;
 	q->slot.packets_left = q->slot_config.max_packets;
-- 
2.41.0

