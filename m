Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B291777CA60
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjHOJZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjHOJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:25:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5472EA6;
        Tue, 15 Aug 2023 02:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFKpiF8v5T4DApwt84EFBs8D5k5i1CLtuSVUmpvZeHFX0Zl8roAp+ggfzZ8rNtUPg6jOryeKlvr7tSatJD1UN0RerwlH4TajomZIEuqKFKcwq5HFpfiuJOYMh6L357r2NFmRtjWX0dN+RO/BzdMmpk7fsVPFHaqLQDJulzsOttYTnoKFtPAb8V1CNSmJ0pVQ7YmtwzGInuQyGelShxIUUBRp3Y/PyxxhuUxqRpo7++iANVTzt+qMrFVDEdPEudnxtbV8GPPqBk8dktuJNgJuTMQ0/+OvikvNH8ZOyyXzEWqK7LeQ46juXlkQHDnWFhPl/H1CGuMevHLtlmPOHS50wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1DFSkuH+hSRQ7ksVHVevd14Q9mnV3doehOWSRMhJX4=;
 b=NZjqeoTpQHQh61hwlalETagmvlAsBPicZCnvq3jdijnh3sA6seFWqRRL01Rcwh5jsfkb6i7y46noEjyhW6ydAVQINvKu/LXviG36vg8e1IewbZwrHg6nz2viVkRfZzdkIv97Oi6P78O86blxsuW0uuIoUhEAb4EeteJAknuSSOgY4yFUu0/S5eYvTKZEUcPCdOlYf3GBS7CM5zFYPvFODOJhpIxFaT8NFFjYDFMrvB3iAqsm/BRKh2wkK7VSGjXQEPHEZ3aUOC36khzs2EUJWeJgQxERMjf12pRH6exGQyuNChJkYwpbbqyAP2VwAOxPfOJ1Mgy/LiTjoZzXllxUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1DFSkuH+hSRQ7ksVHVevd14Q9mnV3doehOWSRMhJX4=;
 b=aIQ9NoCjYQ055+3S3i1fh3xbl601qkAqhN5yCOhw0rIFkvsfF0mEW/EIUfjBnJgw/lSji79nXLVHwtbSd7SaEoGjBFQrIe6QWfujvw4FEACcEuxsMfxUsFrq8ZucB6SWpkeQewxqPKPVvi0gQKwwM8l8hG+L1eseGps0kjNOYyTI5J8711YrRqBywPePJXv8L424wjRHckFhup6IIKC/1vaQXp2QtW0xT74ugWmMVnS3UGVZHYcwba/q2MNf/YAADbAAZWOnaRI5EUoIwVsyRuKicMfoaH+3MzBHTi3QnM90C90+4wtalldMGAB7zkWWegxoJ5zRQssS7iBCO0NTbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAXPR03MB8228.eurprd03.prod.outlook.com (2603:10a6:102:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 09:25:05 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 09:25:05 +0000
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
Subject: [PATCH v2 net-next 1/3] netem: add prng attribute to netem_sched_data
Date:   Tue, 15 Aug 2023 11:23:38 +0200
Message-ID: <20230815092348.1449179-2-francois.michel@uclouvain.be>
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
X-MS-Office365-Filtering-Correlation-Id: 2f8b5c08-0333-415e-cad7-08db9d7182cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2bUX3Wd2npXh5l8s5TE4zAL/Tr8gS2VDA5WG8kQKzVTFDIg+J+wTmnoX0IezcUlRFdmdQCnND+IrcSUjFoHepaVVnVK7AK7iy6W341N8FhBSEjTNMP6l43DQBXbta0QlmVqc7qyWegjHDt+1WcTGbsK/Xy5VqxtVn18C5fYuI/GNH8gT7OxVO7nY8qJi9cpwf3RdSeiQXGzj0G4k5DyAOHZzLcgL2shC59ve33lMNjjFiX4pcN2MSkw4yR22bOeC7v4XoGsliYHtg8TUkuzYPao9wLpWk73BB6B6oXPmy7CSxi2jVGNGqRgzcL9L7mvgAx5rJY7L42Q0Grr2Nm99PFuV/VG0HA2CTQkV7y9rH2aJuIfuCWhLDMOI/MlhrmWfyrLyvPDyrJwVw9X8AJKd10x9ZJcewusdX/YZIT/m8vFRz6DVpeLK27n+7+Nl1S19rgR+k7Ro/8YfykgZ/xHZcPPahUXQbbdcTBJ1hBX+G3Aj7TAdBB/eHx1ZKjZksKm6Umm7am50X9uyQ75z2p5XyINkPUTHtFWc54aZYxtexwJmx2c8H5t80ZQT6x/XOODxaiVkg2csKXTQquuOF61gEtvfBzOTmBHCWYu3ceQLQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(109986019)(451199021)(83380400001)(36756003)(66574015)(86362001)(41300700001)(478600001)(66946007)(66476007)(54906003)(6512007)(66556008)(316002)(786003)(8676002)(5660300002)(4326008)(44832011)(8936002)(38100700002)(2616005)(1076003)(6486002)(6666004)(2906002)(7416002)(6506007)(52116002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpQT3BkRDF2K0JoTmJ1d2xKRmFEWXRkRFA3a0MwN3FJT0hTUkZwazBqZU9p?=
 =?utf-8?B?QVJuQjhVTzhYVURNTXAzaC9yMk5ZMzBKZ0tpMElsZ01oRU5sU1dnbUM4VUw1?=
 =?utf-8?B?dDBXRElkTzNHN2drdlJZcWQ1ZmF4Y25DeWxkblMwWlJJNXczWUdlQzgzcmZm?=
 =?utf-8?B?T3ZhMU1JZDFsSXh5SXBHNEV2Mlo1Rkt6aGVoa3BMaGpOY0s5di9xMHZZVEJ0?=
 =?utf-8?B?UGFhQ0ZpakE5WjRESVZBNjhFc2FFSE1EUWRLM1NHbjF3QmRrMGxoVTRMTXFO?=
 =?utf-8?B?YnZFZzkwZWRHOGVBNmR6MkZEL1YzNHR0VmJtb2svaitTNWVUTmxUdHUrOGJH?=
 =?utf-8?B?cGQwS3BDS1d4a0dvazB6NWJsVEI3cVJmbCt1bzdIbkFKUE5JeFlTQ0ZESUhU?=
 =?utf-8?B?YzNaVjdTTU51b215SUtGbVI0OTZTWG4zVzJNenZ2OTJHbnNZNDNCZjk2M3Qz?=
 =?utf-8?B?bXBpd0Zvd2M2NnhLdFJYUlg3ZzZwM2hadEwrek9MNEZTMjV6aEE1Qisyb2Rm?=
 =?utf-8?B?bGEzS0JwMG9XYS9Qck56RWh0VDZsVk15NmFMMzA1aGtSZ2p1VkRMZG5mUUtW?=
 =?utf-8?B?VVdqdWZ6bSt0SEFwRi9OK0V4aGlHb1RmWGV0WFlqUnlXeVJwbXN2VlJoajU0?=
 =?utf-8?B?Rms0R0liYmp1TmdqVlR0N0pzVmdDT3daZkpwVjE2ZmxEZUw4ZGV3QmJDRHky?=
 =?utf-8?B?akM4OTFuYi9oK3BqMjBZZEZOUlE3VUpHVFpaLzNiSkpyKzhITmtVT2NSYWM5?=
 =?utf-8?B?ejVSaHZsSThwZlJ2V013alJyMmx1K0JBVng4U2p3MGRNc1RFTC9uTks0U3RQ?=
 =?utf-8?B?Ymc3cG1rUVphbDRmaitLS2tLRDJnOFpqL1Q5KzRrRGljWDVIa2U5VG11S2pp?=
 =?utf-8?B?ZG04VTlkVE8vY1JmZXVJNVpJYjIrNmpnbHRFTWdKS3loSFlmZVlRSlNJWWxk?=
 =?utf-8?B?MXJYbnpnZGNmd2k0K0hJLzFwOEpsamdobVV6Ym9wYVVtd0plT2NYV1pwNENi?=
 =?utf-8?B?MEx2aUFCL1V3cVl3OUMxR29YdUlJZEtwdXJ3NUZvQ0czcDVlSXRmemZ1WWdU?=
 =?utf-8?B?ckVlSnZKazgzQThNTDFzVFRrZ0dIdDVBWm9WanlERllnU1BkZlUzSmhERXh4?=
 =?utf-8?B?amtKLzFSeEExNlJnOW0wVDNxWkxGbEpQSmRlb0ZaV2ZtUzBWUzhOdkF3cXZj?=
 =?utf-8?B?K0lsanFyV1lVcGV2SE1XUy9QS2VOOHRBQVladGV3WnBTQ0srYXdQUkhyc3N3?=
 =?utf-8?B?SXVXcXFwb1ZIVkxGdGFXV1RQMzFHMHhJUmxRRERIdG1rY3gyelh0RWpyR01U?=
 =?utf-8?B?L3RCRVloTjhudjZDZnBtbmIxbmhWaGxzQWw2Ykp4dG5QZ1RKL2dvSHJ0WGVK?=
 =?utf-8?B?T0lzdis2TW1Xd0tVb0tjWHM2VXhSc3Y5azBDK2ZDNFNGT2I4YzIrZlF2dEs3?=
 =?utf-8?B?WGlmZDQyL0VwQnQ3Nm5QREdvZjZZd2dNRWhKcWU1WVpWUHFCTzJSbjA3Rmxv?=
 =?utf-8?B?bEcxalhrUWw4WngrejJTdGQzVzVGRFZOT0ZDOTBiUzZkalBvd3dPOVd3aVgr?=
 =?utf-8?B?QnJFeUZuMzZQbHgyejdKb0NTZHM0bDdyaXVjYUVoQldueHpsT1h2QysrR3ZU?=
 =?utf-8?B?OEhac1B0ZWVnRFZqSm0vYTZUR1lkKzljeGN0Ujdpd3JtSDZHaU5saTluMEJT?=
 =?utf-8?B?MXYxaE02UEtDb2kya3QvbmRxUUlxQUVtVGtZRzJqd3ZGMG1SdFptMVh4cUMy?=
 =?utf-8?B?MVZldWMwZFhOazl5K0RYYUJ5dXVzUy9wS21hLzBXMlhvei9VUVZKNjlhYVdQ?=
 =?utf-8?B?eENZL1ltSnl0YVpzbzlZWkZQQmxhck13SEkvM0VORjVKMmFUTnFwQ0QrOEh4?=
 =?utf-8?B?ay9OMm4rUDFMU2FBWkNjaG9FV0ZvNWROdW1Ma0daNk1obk8vTUpLZGNuMzNs?=
 =?utf-8?B?cDlYdXUxd0RCdmlkTEt4NS9XN0p3WWNYdjVOdDZZVzQxNmhBY0pqbWZEeFJC?=
 =?utf-8?B?bWQvTHR4OXdDYlp4ZXBSUnY0Z1N1dENXdVc0ZVpYZnVvcWpENnY0R0VuMHMw?=
 =?utf-8?B?MGNHVUNVQVhVbi8zQWRlLzBDS0tzd1U4dW5naGQrN0ZCb1EyelJNZENVZ2Mv?=
 =?utf-8?B?RlZlQWdRNXlXdTRvQklKMytxQWx2dVpqR3ZqL2xtUnUxcFBGOFlJMDJHZmNU?=
 =?utf-8?Q?TlMWjFFSzuspqVQjBsJT5/bWZVKE20Z38sOfohbv0/VP?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8b5c08-0333-415e-cad7-08db9d7182cd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:25:05.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJZif9ySnwPVX2ZCKCseejkEk9buxyuGL0q7dLWvd7kDiHKGBm62nR60HtV/G83UE99lvxCDDqs34im2fbHcGN0b+9kW/O2oOQpiXTaYHG8=
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

Add prng attribute to struct netem_sched_data and
allows setting the seed of the PRNG through netlink
using the new TCA_NETEM_PRNG_SEED attribute.
The PRNG attribute is not actually used yet.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 include/uapi/linux/pkt_sched.h |  1 +
 net/sched/sch_netem.c          | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

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
index 38d9aa0cd30e..621c6acfd644 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -105,6 +105,11 @@ struct netem_sched_data {
 		u32 rho;
 	} delay_cor, loss_cor, dup_cor, reorder_cor, corrupt_cor;
 
+	struct prng  {
+		u64 seed;
+		struct rnd_state prng_state;
+	} prng;
+
 	struct disttable *delay_dist;
 
 	enum  {
@@ -922,6 +927,7 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 	[TCA_NETEM_LATENCY64]	= { .type = NLA_S64 },
 	[TCA_NETEM_JITTER64]	= { .type = NLA_S64 },
 	[TCA_NETEM_SLOT]	= { .len = sizeof(struct tc_netem_slot) },
+	[TCA_NETEM_PRNG_SEED]	= { .type = NLA_U64 },
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
@@ -1040,6 +1046,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+	if (tb[TCA_NETEM_PRNG_SEED])
+		q->prng.seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
+	else
+		q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 unlock:
 	sch_tree_unlock(sch);
 
@@ -1203,6 +1215,10 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
 			goto nla_put_failure;
 	}
 
+	if (nla_put_u64_64bit(skb, TCA_NETEM_PRNG_SEED, q->prng.seed,
+			      TCA_NETEM_PAD))
+		goto nla_put_failure;
+
 	return nla_nest_end(skb, nla);
 
 nla_put_failure:
-- 
2.41.0

