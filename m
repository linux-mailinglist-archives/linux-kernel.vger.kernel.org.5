Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9426877AF92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHNCeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjHNCdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:33:44 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2137.outbound.protection.outlook.com [40.107.249.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21BE6A;
        Sun, 13 Aug 2023 19:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0h07CZDOC5dnyziFmlQnfBl7KXl8FNDTF9fDtHNHzKDTMWV34CLIfYOGH7dpAwUc97OUW051okCRXqF4NxHtNCDy6epoGDnbFpIX3IXHNn4PVDW20joPBujz87cONN1kMkvYXPNdS6uar//1EsK4pibw8uIvJY7Ojqm8fOyFwzeuI6C4qWphWG0GzZovmHoImyH8JRszRAYew0qyU/X7DRmoFP5qkCvdetKqkZ18m8AKjukBYOgcX3dDjAHHTEmI/Tugwb997n1cHr1C8pNei6JVHMaW+w2Xj3lUQbo8wxD73azfSQdOY5jg/eGG2mO9SxaUBUbU06jV58RV/pQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKCR9gdCWst7aI3v/UET4xE5J1kbpBE7+t3UOunXH9A=;
 b=UUlkIqxWQn7JOu5rLlFnwFDxOhGOKLmTRFek+Qp0Sm3NHcouwiRvvYT5cHTUVS6+HibsBjJA0iiQzNrHZfjNqH0tlHJyhWTcuTd8vDyLnCBdZm+ywfxKAZlLw3CD/hjhvL9SixCuNj85MZIP1w8XiXRUJpeC6tTzabz4pCwrURn3YVAskf3mb+5jVHu50Si7uxn7ZLZ8+ByjrFO+GIpyC83dClUcG/jFKA26Ive884TkZx/FRkbMBCYcbizjGFE64fyF9bz4R9aBrIVtdhKB90o11zXsQzPUf2gqjPQs/BIL8bx2PhQ4y9rYjW+Ze2hkBAV3hrsaEJWa3ptmgzL/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKCR9gdCWst7aI3v/UET4xE5J1kbpBE7+t3UOunXH9A=;
 b=MFAwd+hQi+hko3yFmDTw7VkMaaxomucgPUZjMEKjIq3KctM7f9qaA/Eyx7/ljtRvAahaGvDdgLUPHXINpWAk7FMrUpFI1kWeBQ599jJkP5HINjP5c1EEfONELJEzh4GjQ1h2jilmILwbMZYNS8yy/ERkjNXNdX+olyVpPlL3IeXigcCF3J30dGMDWs68hZ35hq/+I4Fnu+gQlC/1WGWzYRYB3qisyZ5JpRjvRzpTqjymzKbB/uIPSbeeNGp2h85U6Wcai+4xMMqc55US0Rv8ZX2UHRZo+iH+mBkcp0W2qbZ81DZ3BtEzyDv8tIGwNKFgl66puNz5cDPjyRflA2rV6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by AM7PR03MB6401.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 02:33:39 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 02:33:39 +0000
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
Subject: [PATCH net-next 1/3] [PATCH 1/3] netem: add prng attribute to netem_sched_data
Date:   Mon, 14 Aug 2023 04:31:38 +0200
Message-ID: <20230814023147.1389074-2-francois.michel@uclouvain.be>
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
X-MS-Office365-Filtering-Correlation-Id: 90b4c1ac-3153-41ff-5397-08db9c6ede41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1u3fEQj9JEDYClECiyX3FGqpiG+cFYJUtcfDjjSXaPko19a64KaZOhtIfgppC+kaIUlrfh6iLzesS0KVTTF479L/99r5WJt6CQAewa3J0pY0kLkCERL7ty3z4BAW+WgKsrhhlWH9ObrA1mrhELj67VFLjtu8+Sner9swJERkfoTU3v8xbc2GeqK9rhJIPy412g7KBSSQRk4GSfA9do9lM4TQ0wVT/8QVufKqyo/JAC/OtYMKk6OsoNwhSVH0faO810vrYzKs7bZNl56xRWP6cMOBzOmCAwxQRZklYREnf7GKR7+GCotrqauyrRjbGN60BNyuMweOo0FAOySXVJVVvwbK76xLzVWQyYvmITOVNc1wzYwxYwFhBEhS+tGVvLFnQt8nybXi1d/jrb7/fTAhTrfpT4FTA7hpmAP0ew1loNpygX3yCiGGs28xEpji3Vyv9pQLqD7yaMoVOLlR0qfeFXp6wTPNmRsqM3W2f1uFK63LX2b8UpAwJGgp8rWy1+ltsJgx1HypEHnIjfFTbE7XMEek2ptuhOdJFSeO5SNQfU84nmmJEqTLWZ+qbL87OhLNawGrXDiT52VMHjBe6BvEOBH+g1HrrpETGyOF1dm8NA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(396003)(366004)(376002)(109986019)(451199021)(186006)(1800799006)(38100700002)(52116002)(54906003)(6486002)(478600001)(7416002)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(786003)(8676002)(83380400001)(66574015)(2616005)(6506007)(1076003)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tRdjZnamNBTXY0WjZKUTFDeWVlenJtSDdCdWZ5d1ZuVjhyek1PeHNtZllJ?=
 =?utf-8?B?K0p3M1NnZkpqZDh6Tm9MRW9nKzVrNThMd2tlZWlnZXpTaHBaaXQ1Zkp5UVlV?=
 =?utf-8?B?QnNpOFZ4ejdSbHFRRlF6ZXpRVXFkSTc4SXBvbjZMVVVRUUZsRWlaOTFpSjVM?=
 =?utf-8?B?UGp4bDl6NUVNdE5NakVTNmtEeW1RQ09uNjFFcXBNU1FQWkNEaEZNSUNxT29z?=
 =?utf-8?B?Vm0wNm80a0dRWWFyN3BLTFkvM0pST1BRdkI3TlJDYmhIREtvWnpaWmx0NklS?=
 =?utf-8?B?U2plQlV5cXlwQmthUURqMVliQzEyb0lsempMWnE3bmFkSU5aRFRvK1VxMjR3?=
 =?utf-8?B?M2VTYWwwN24yNmJRTnR6bE9rd1pIOVNvbkpuU1N0NnpGQlp0cXJxWE1FbUFm?=
 =?utf-8?B?aFRPWDFDQVo5MVErM2p6L0xDNkt5NGp6VU9NNGRGV3VIK0JpT3F4ODl0WGI2?=
 =?utf-8?B?N3dOVU1QM0dxUUVkRk1Za0hMaDBScHRibXZpaW54VlN0THhCWGNxOWkzeXpp?=
 =?utf-8?B?Vnl3dnFZdmt3bVl0em5ObjI5RVozTlRGTW8veEJDekFXZkFWeHFoTHVtQ2Nk?=
 =?utf-8?B?aU9wYU4rZFlvZm5Tdm8vRHlZUE1IZGlGbXo2bVQ0eWk3alFybE1zZTUxZEpm?=
 =?utf-8?B?emYwUm9uRVRJeTZrMHFlNnA5N0w2TGRsUXZCdXBYbHBOTHhMbXpPeTU1azhF?=
 =?utf-8?B?aUJwM2NQM2p3LzFhZkYzc1B6dkpqZmFDNkwrMTMyWHppZjc2dEIydVNmcHJj?=
 =?utf-8?B?L29CR2VKbGZxdXJkU3BJaXVTYnR1SzdCdUpJZzVxU2RFK0c3Y2tlQzZMdmNB?=
 =?utf-8?B?eTNnZmNqQjF5Wkpqa0sxeEdieDNlWVlmMExsL3hJQnBidG5KQnM5MFAvT0li?=
 =?utf-8?B?amd5OFdPVCtjakdmYkF6cHp4OWRGS1JIUm9qcGpuR0xjMEpxaTlJK2lNQkRv?=
 =?utf-8?B?U3hjRW5zZW1pQllZQTFCeElmRUdOcGxRZXlSNVBDdUs5Q2dKMW1mMDlhRHJT?=
 =?utf-8?B?MCt3Rzg1OVNQVU04OEZSU3k2emltVnpkdVBEakt2cmJjenN6cnRDZmtXeTR6?=
 =?utf-8?B?NllCWllON3ZFL0U5cjU2TjdLMEVhQWFKYnRQWUl6YVJidit1ODVJejZ2NEd0?=
 =?utf-8?B?ZEJCeGIxcEEzZENEZFpVZUpKa01UMEJRSUJxMkpQMVhuWC95UHJDL2M4SWk1?=
 =?utf-8?B?OHhidC9uVkYwYllpeWNJUnN4NGFGU09xdHVOd0taeEN3aUZFSjg2ZmU5NjZU?=
 =?utf-8?B?dVBQcjBucG5lL3dtaGR5bXJvUk5kcXlrQ2w2M3Q0UTExMzJLcTRSUkNJSU5a?=
 =?utf-8?B?R0xlaTRsSDhyZ20wMXpqY0s3TnF2L1lFWGFHSWhwQUwwcTJ5QVVsMjl0dzB5?=
 =?utf-8?B?cnNQSTNMenlJMmhvbXZ3ZUZNL29TQlVqUzJrU0ovb1FUNllHd1ZJTHNEUU16?=
 =?utf-8?B?eEZRbStiU1hMYVB6c0grZnRZcS9VU0NrZVNHTHREdEU0RGVPRERnYlFZa0RI?=
 =?utf-8?B?YmpYYmlYVEJQTTgyUTduMDV5NjM2b2xyTkxob08xZ3BINEJhcW41b2NtMWlX?=
 =?utf-8?B?NVdneFlIYmUrWU0xQmp0S013dExLRDkrVXE3Rkk5bHA1cnVxaE0xMXJrWCsr?=
 =?utf-8?B?K01FaStrclhEUzhiZGhLSWhJRGdTODd6c2lVSTBJeVV0K0JJMEV0cmxDbkZK?=
 =?utf-8?B?VGJGOGF6ME5selhYVS9ydDJrdzZaZnJqNktnZXV2UHA4WGp5b1B0QlRCbkkv?=
 =?utf-8?B?NzRXRFIzN3gycEhwVXpZeVkzZzVZTzRPUTh3VSs2MzFXSXI2eUV2bXVOVU1G?=
 =?utf-8?B?LzJGdFl1ZHRzUFlxQVB3WXE3SVpJSlRKSkxkN1JaOUkwWUp0OVRpZDBkUmxy?=
 =?utf-8?B?dHlxT1lZV215UFEzYkxLV0NXbTFqZGE1RExEZjNTYll6cHl0ZGFRMnVLbWVm?=
 =?utf-8?B?TkpqNllmU1kxSVVEc1JVcGdweDMrbUtUbDJKOTdNVkJaVzVxSDhJYnNhVng5?=
 =?utf-8?B?OFNmZHlYdG1Ja1lwOTVtaWJ3N2tZSE1YOElsNFBvd00wSXFhSWhMOHN4eWlR?=
 =?utf-8?B?eDhSbWlEa3NwZFBzVENaZkNqSjYzU1E1LzhFNGhMQXVtV1YzQnkyV1FqR3FS?=
 =?utf-8?B?QUwyVENKMFFFcUtHYjJ6ZnBZdm15WEdOVHM5cVE1MXRuL3ZmZ1JjV0lKN1gz?=
 =?utf-8?Q?1HYt+0MFcKDWbYmNcMaRDks+yjQW7EDDFoAteyV8Dilp?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b4c1ac-3153-41ff-5397-08db9c6ede41
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 02:33:39.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlxL3fJ25qk3EMXJKepUBkr9KayyRqlp5u2Pe0OOb4Qz7st1RzzTKZd24Hny515FLkI6LnlS49LpCcpd0g0gORnqFw++Qsv2h2Lif3HBPfE=
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

Add prng attribute to struct netem_sched_data and
allows setting the seed of the PRNG through netlink
using the new TCA_NETEM_PRNG_SEED attribute.
The PRNG attribute is not actually used yet.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 include/uapi/linux/pkt_sched.h |  1 +
 net/sched/sch_netem.c          | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 00f6ff0aff1f..3f85ae578056 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -603,6 +603,7 @@ enum {
 	TCA_NETEM_JITTER64,
 	TCA_NETEM_SLOT,
 	TCA_NETEM_SLOT_DIST,
+	TCA_NETEM_PRNG_SEED,
 	__TCA_NETEM_MAX,
 };
 
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 38d9aa0cd30e..d73596d0e912 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -105,6 +105,12 @@ struct netem_sched_data {
 		u32 rho;
 	} delay_cor, loss_cor, dup_cor, reorder_cor, corrupt_cor;
 
+	struct prng  {
+		bool deterministic_rng;
+		u64 original_seed;
+		struct rnd_state prng_state;
+	} prng;
+
 	struct disttable *delay_dist;
 
 	enum  {
@@ -922,6 +928,7 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 	[TCA_NETEM_LATENCY64]	= { .type = NLA_S64 },
 	[TCA_NETEM_JITTER64]	= { .type = NLA_S64 },
 	[TCA_NETEM_SLOT]	= { .len = sizeof(struct tc_netem_slot) },
+	[TCA_NETEM_PRNG_SEED]	= { .type = NLA_U64 },
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
@@ -1040,6 +1047,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+	if (tb[TCA_NETEM_PRNG_SEED]) {
+		q->prng.deterministic_rng = true;
+		q->prng.original_seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
+		prandom_seed_state(&q->prng.prng_state, q->prng.original_seed);
+	}
+
 unlock:
 	sch_tree_unlock(sch);
 
@@ -1203,6 +1216,10 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
 			goto nla_put_failure;
 	}
 
+	if (nla_put_u64_64bit(skb, TCA_NETEM_PRNG_SEED, q->prng.original_seed,
+			      TCA_NETEM_PAD))
+		goto nla_put_failure;
+
 	return nla_nest_end(skb, nla);
 
 nla_put_failure:
-- 
2.41.0

