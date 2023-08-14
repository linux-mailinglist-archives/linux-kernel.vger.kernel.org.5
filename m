Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC577AF90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjHNCeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjHNCdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:33:45 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2137.outbound.protection.outlook.com [40.107.249.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38842E65;
        Sun, 13 Aug 2023 19:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTi1dYas0QXAP0qbOvkO1v3fWH+OAJozqH3YyVa6+L5xtELs3v4Byxr1Y5HdBdrQe4jJAMSFnUFpzIoUXoFawYTqvB0cF05sxgNF0Jw29tfZbI4ZGf2SbH5pO7qQSGPMh4b9JpOicW7HWAYiZfk4dlX6sEeHDWEhWZFqS2GR5rfopoD5az1Bh+OOzaGD5QEb692xh0bsUczupb51v/ATSLXWKeYpztigYpYaeYpNghgS8I5l8nmi5eeLvqgR/MR88fvQXMujqaOrPFovMwnD2+w6OmtaOrEc0rm5oZRJqzQ44diUyBEjFxN3VJ9NcCe9pc25rjzrQBlg1UQkgKtbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h3RCDDjOcd80OhiXQOF9okLjuhqzoFntP3tIs8+as8=;
 b=gecuXKr/SKjqAec4dJIG1YOgPkv/3B1w8lW1jk9ahNKV07yPJ8By2Ifs0TAuswxpg5XMpuhGOjfkNf/kV+DIU9I4Kx6XuxsKplYGc4sHlS3TKjnRHyq0YzcQWT7hH9Ld62X29oImdUODUrcWvwgCfkPAuLLdK4G/SQfkBMpvZOndVSzsDY8uu6drl88V6FfnJGCBEZIYZj3rvAupDkOQ+rImtUu6CWsbVW2xMXK4o8r/q2+rFPNu6a5dxz5SzI8xIMvWGGB57qYkWZi4BOlqG4AS452sMJ1ECY1v3K5sISyqfagSJNdSHA8NepMquxPine4spwTKc92bhOnAWzIvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h3RCDDjOcd80OhiXQOF9okLjuhqzoFntP3tIs8+as8=;
 b=Q2NLtFutjK2hGnibYkW5mPIap5Ug2YTbM4gd5M6K/kNoetZ+uXlbR3UzdxSYAbYZ6Vq7ufFeDkU6z0s4hZp1xir9k5/mu0aJ9OTh1naJf01AKMeUvrtKGjqOzOwFM9lFNzo7i+LDjcaEbdf6FmYNnS1tnYjALdtmE/GElhDwwiNLw0vJa2GK89TD2dml6KAAau7aiKrKi/X5sXly+YOdQcAlg7qvTPABQ1v6i7HP77+eNQzeZgbM/ctz+q7DE0xxyuHlpB6W+UQ5csO9rjKe/APOh1D55R56UXENDVAGLU+mYVJQ4CmaRFPlitwHyR0UCM+dxwmgWzJ2TSbOCpvTJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by AM7PR03MB6401.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 02:33:40 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 02:33:40 +0000
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
Subject: [PATCH net-next 2/3] [PATCH 2/3] netem: allow using a seeded PRNG for generating random losses
Date:   Mon, 14 Aug 2023 04:31:39 +0200
Message-ID: <20230814023147.1389074-3-francois.michel@uclouvain.be>
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
X-MS-Office365-Filtering-Correlation-Id: 758c8409-bcfd-4d6a-db73-08db9c6edf17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrFTjdc65uCr+hWCtGHKoaylpt6VTXWkIXe7L8kMV4bFC5IVfYGjUQMm3JpW+4MoQEUF0vF3zc4Mh2hKAJeymWgULd9r/F7GHdy+4SWD+arL1VylSC8a32EbLS9H/PK6kovE4GQikAS0q2Utq/RjjjPkJHzAfkNEzG/PWseJR+J7klAUsPLKJXFD3asuCgjHJsP2xeBDjEXDHpyq65cuhAbNigIres2bOBk+wwlB9Wh74PzeW9LX7BWq9VMCXGOZ3GH0ZyPKfLbcRv9Pn7bLkk0K7reOETNBmoyhmv1T2fT/5hr9HOxaUl5EQMFy+dc8WBvlOScsyFsvU0tQ66Niyf28sVElVkNCUqXYJZNQEWFcNLSTML5FET50gqHVysYoFZJGrTke8SqFHPc6li0k8vEJ1Lyr0h9cme6BsrOfu8F7igE+fON7IzwtA52svuVEDYE6+udpaCNS64FQpbhEEbPNZVWVDLhgJsexXuvbs023HrR6dS/nTiPiJVs/QldMxi0PtATDFR3IkVktuokUJN+7r/mP5DlBmitbNeBo4ncfyTSbsxz+VuulrsUCJtKImnlUwmsFAJnaYCWph9T59TqEByST3pALv+PEMAjxM1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(396003)(366004)(376002)(109986019)(451199021)(186006)(1800799006)(38100700002)(52116002)(54906003)(6486002)(478600001)(7416002)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(786003)(8676002)(83380400001)(2616005)(6506007)(1076003)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJpNXdjNTBTQ3BFRFB2c2NaYVE3eFA3VkY1V2RZMkhUc0VEcjJkVUlqdldV?=
 =?utf-8?B?VEhFVDRVNklrV2xER0hCcTF5azFaTENEZXZ0ODR0UnNIUU9jMlJBZG0yTkdD?=
 =?utf-8?B?eW9FNWkzQkc3NG5MZU9CQ3RvQXBIajJ5MkU1Rjg1cWl1bE5qb0VTK25UNGhR?=
 =?utf-8?B?dXJOWDQrQ3ZNQ3FXQVluYkFKR09aT1J6NGxIb1g5ZWtJeVQzNmtEd25mUEFo?=
 =?utf-8?B?TG4ydWYrRUgrZStIbnBxS2hCRUZ0dXQ2WkMySWYrUHBRa1d0VGE1UzlYQXNU?=
 =?utf-8?B?SFJRMXZTUFZtQjZWNGI4dWNXTktIZGE2dHlaODJra2h2NzVkZEluMXpnOUlW?=
 =?utf-8?B?aGowVElzS21kRE1NbEVJYTFXcEJ2SGxvb3V3RTRDYjIzVkU4Y0RHOFJqOWNs?=
 =?utf-8?B?SloyRnBZNDVTRzhidnIwL05rV3l5WXFGN1pFTEFWelA2WmsyRHBYOTVTOHNI?=
 =?utf-8?B?WjlOR3N4Z2hJcW4yZW5UM0FpTGZObjNyQWtCNjByMUMvYkJxaDM2dXQzNFJz?=
 =?utf-8?B?ZWh3M1hzanpESTVROHRPN1ZOWEo5dkxjbEdCMXlGRkFvYVJxLy85ckE0TDhW?=
 =?utf-8?B?YnVvaHlPWlE0RnpMaDA2ZkRNTnBlMlFFamJJak9Zb2F0bCszeHo0Z2pQb01l?=
 =?utf-8?B?bDVmSnJSWGZjNk54NXd1dS85R081US9yUUpCbm55ZWN4WkNobDRCU2sxKzZ6?=
 =?utf-8?B?aFNYQVlsRUZVVDUvWmNaeXBTNnk5bXNUL2ZKV0hLUE1GYjlSbEFwdDF4Q0k3?=
 =?utf-8?B?RFhXblBmendQaVNrbm5yQmdnZHNORVhETEFGSUY3NWJvTUljUVYxakZDcUFH?=
 =?utf-8?B?aXVPVy9Lcyt6YTExWGFQV3MwQWtiNTZ1VlU1Z0dJY0hCUCtpRDB4NWx0YVc4?=
 =?utf-8?B?R0pkRmgwdFJkNG9CM1JDLzF5V2F4YVZTOUtDdW5GekMzOEFYUGN6OU1UcmI2?=
 =?utf-8?B?eVdYY01JSmY3Q2dnN0hJaUYvMGcvWmo3K1pyeUdoUHprNmlITGdWejN1UnFS?=
 =?utf-8?B?MjN5WDkxREUvNUVJdk1veThld0pDVUR6WVBLQW50RDVYS0VIUDgrYWtRS1Bk?=
 =?utf-8?B?MHN2YWtvdFpwL2lwSGRHTHN4bmlwYkJiSitrS1YrUGs3MFBGdU4rYjFiSXZq?=
 =?utf-8?B?ejNCbDlFYlN2dmZ0dk16L3dLTXVBMEpVU0ZQbEtCSTFYMGxtcUQ3TlVKNWMv?=
 =?utf-8?B?dUVNMFkrRWUzemFOS1hnQllJbkhCeXdONDY5S1lXUFVnS1NpUjhiYTJqaGlL?=
 =?utf-8?B?aUI0L3cyaWVNWFRHcUFXTlpWT2I4WElUOTZEMVYyUjVYbmZPUndWaFV5VWo3?=
 =?utf-8?B?MVZhcFJJcVdSazVnV3IzTjRtZ2Mxd045K3NZSUQ4eFE5cFFKZHNSTzIrckh6?=
 =?utf-8?B?ZSs5dDM5OTdkUEpuaGcveUF6KzVUWlFMeVZQMCtrRTJhTGJpQXBxb0JVTE9h?=
 =?utf-8?B?QmRFRkh3ODY1KzBvVDBmU0RSVUdpclBLWWcvTVFzM3ZEWjcvMDBOWWcvTnQr?=
 =?utf-8?B?QXhMSmR4OXhha1ZsM3o1UW9Xbm9TMGlWZ3BzVURhaUtrSGt4QUtVcnpSN1ZG?=
 =?utf-8?B?TGV1dHQvL0x0dEE4dlhOd1N1MUxWUTQ2MXUybTUyRVl5WDgyWlI4R0crU2lN?=
 =?utf-8?B?Mkk5OFV6N2dFMG5wam5uNWNHdjZIQmFObXJaNERHaVIrTUhkMjlybUxWTzRM?=
 =?utf-8?B?c3F4Z3lpeS9ZWGpNVFZzUWh4SXRRdU9QRDErMkVLUEZNYkJ4YXgvcFVTeFd1?=
 =?utf-8?B?VVc5bW00SWQ5R0IrbiszU2JXbjlpS1Uyb2FKVVYreHBhRWxXeldmZ2JJNlRT?=
 =?utf-8?B?OUVrVy8vbGxGcHFyMlRLVDUwOUp1aExlSHRQTWdRR0RaQjAvTHE5YlducFNm?=
 =?utf-8?B?clFmOUhmcGphQU4ySFVJS3FOdXQ1SUNMR0pUSElmNXB4V3NHRE05cUFGSSt4?=
 =?utf-8?B?dW9pYkt4dSsreGZaZ0lGVEJoWnprRVdEbC9vVk5zYWJCcE9yRnVkak5ZQUxz?=
 =?utf-8?B?MytVVFc0MDRoSStRVG5vdlJJWmx5VnRxL3RoWnk1Y1R4cDZ2U0tKL0hjUFJ0?=
 =?utf-8?B?T1hBM2ZESjlIQ2FZZUM1OUlxODU1ZTQ0S0ZaUjJTUnNOQkY2eEF3UVJpNlNE?=
 =?utf-8?B?ZnFpanAvZUtzcW13OWZiMDc4WlFxYUE5Mk9ubm1LelRnZ2c0cEZjVE9tT1B6?=
 =?utf-8?Q?YVl1Gxqv5U8lo9rqeSWdmvaJssQqNrAcfCIDyfUJw3Co?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 758c8409-bcfd-4d6a-db73-08db9c6edf17
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 02:33:40.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjA/3vBAT1Ry1PKTBllTH0adz/AK4oh1/I/JjM66gEhQCYpPWezcZjQndUzo0WRbO7sruaxXTSxMpv0usdeZSC7bfkV/1EtmA3iTqp8jJko=
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

Add the netem_get_random_u32 function to sch_netem.c
and use it to generate the random loss events of netem.

If no seed was specified by the application through
setting TCA_NETEM_PRNG_SEED, the default behaviour
is the same as before, i.e. it relies on the unseeded
get_random_u32() function. If a seed was provided,
it relies on the seeded prng attribute of
struct netem_sched_data.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 net/sched/sch_netem.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d73596d0e912..1190782ef79d 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -154,6 +154,19 @@ struct netem_sched_data {
 	struct disttable *slot_dist;
 };
 
+/* netem_get_random_u32 - polls a new random 32-bits integer from
+ * the prng.
+ * Uses a deterministic seeded prng if p->deterministic_rng is true.
+ * Uses get_random_u32() underneath if p is NULL or if p->deterministic_rng
+ * is false.
+ */
+static u32 netem_get_random_u32(struct prng *p)
+{
+	if (p && p->deterministic_rng)
+		return prandom_u32_state(&p->prng_state);
+	return get_random_u32();
+}
+
 /* Time stamp put into socket buffer control block
  * Only valid when skbs are in our internal t(ime)fifo queue.
  *
@@ -207,7 +220,7 @@ static u32 get_crandom(struct crndstate *state)
 static bool loss_4state(struct netem_sched_data *q)
 {
 	struct clgstate *clg = &q->clg;
-	u32 rnd = get_random_u32();
+	u32 rnd = netem_get_random_u32(&q->prng);
 
 	/*
 	 * Makes a comparison between rnd and the transition
@@ -272,18 +285,19 @@ static bool loss_4state(struct netem_sched_data *q)
 static bool loss_gilb_ell(struct netem_sched_data *q)
 {
 	struct clgstate *clg = &q->clg;
+	struct prng *p = &q->prng;
 
 	switch (clg->state) {
 	case GOOD_STATE:
-		if (get_random_u32() < clg->a1)
+		if (netem_get_random_u32(p) < clg->a1)
 			clg->state = BAD_STATE;
-		if (get_random_u32() < clg->a4)
+		if (netem_get_random_u32(p) < clg->a4)
 			return true;
 		break;
 	case BAD_STATE:
-		if (get_random_u32() < clg->a2)
+		if (netem_get_random_u32(p) < clg->a2)
 			clg->state = GOOD_STATE;
-		if (get_random_u32() > clg->a3)
+		if (netem_get_random_u32(p) > clg->a3)
 			return true;
 	}
 
-- 
2.41.0

