Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD575C32F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGUJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:40:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2098.outbound.protection.outlook.com [40.107.15.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB471F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDSNCsktG+xpYlXt6HSBDNUe+a6tSl2y9BpqXIh3IhG1opOrHhl2us3ebGglctWeKxNtTub9YZEs1nW2cAMdqI0hDB4OTasUPAybTnqFRhb8HGldTU52SyPN3aUM5Ggrw3VHmz5RFEcQWQqBe+YQpNqPvRZHjLZEiX6+6qKKwaFPOmGldGSM0FL85qVT+KPXzpO/T+24iLIhL517a2zpmEzc/rbAiORa2J4iUY4bmNxVSgRGBA+53xFfLifR/DMyWJg9N3fDXZ1lwAMw+DAHVu948Z4BdzE4Y5qh6+RxoVjlACDVVADCnOE9MGgIy8eUvPwzuSj3GVQ8GESF1I/4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohi58xfsfiUuT71awQPFk4LL/zhVH5ETuAtdMTcWgRw=;
 b=FRDhVaItnDIoLNshEwJJ4xT3evwOUFu4oLgxD5B4JziQmwko+4gtX1zJAYnC6Q5cIDWfpiczO2uOyh+77CLolx+39hf+/VV/Tk7ewg+5TORqO9AsVu5H6Rm+Grvf+NFiz9SNvAoMxY12vVagUUrYKZHo8UpE81JB/EdzhX2SF87H0/8aLR0Wwx9gdDqNPYZi6JREBNGEwiZdjIb+0k2F+Dpy947Gp7XaCE8FHrBez3b9KxUMJoT69Af5Aej31SIzoz7X/U+xNK2SLb+FF1cCX8WBlN7pCpgEPFD84jil6nOkxCnXzxdjHiv6d1RyxLtzJ+dYEhSugfJCOhPF+BslbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohi58xfsfiUuT71awQPFk4LL/zhVH5ETuAtdMTcWgRw=;
 b=CVmxuYIsBw48zn+SU6Wkz1DHJ7L4AO1cYNvX/tUzhRfacfxJVphIjnxrjIv/1udNTJPDH/fTUfQXE5BI3nZRtluW8rvOaLuO0TaYdVIxgDKpqP5XNboCnux8uMLenHMlWKKfoGOfWCd8n349miI430keKaTyfW+V+7wMkYCcnoL4MDajKV6ObZCDTqjHBuBZjHpai8sWsK/tX0rDc9w8DAVTxODojT17/vnBTZ+MaFq2ZIBF2PFd2DN8dxvUhLU9JaXgLTMtxvI/CqVr8Xa0Gsi7h+5evQeisdry7IcXbMtWWMW6BN4BkVISDK8/97PTap0V6Il6a4PhIl13HoC6oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by AM7PR07MB6820.eurprd07.prod.outlook.com (2603:10a6:20b:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:40:43 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::fd49:c006:479f:d57f]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::fd49:c006:479f:d57f%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 09:40:43 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v3 RESEND] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Fri, 21 Jul 2023 11:40:01 +0200
Message-Id: <20230721094001.25439-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|AM7PR07MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb376fa-bb73-426f-8073-08db89ce8d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn+v5LxEJWY7AtzQv4rZxL9kI5LEUS67pVEZZqn48FwHWcg/JXnszu4PZy5cIUOlyoR9HnlV9rlJD3UF2Di6hKISNvz+TxjcONd4MO9P9iyV22v+pBVFkDsSb0hTWr+KWon5gldeaYOKYAZc2RKl21xiMpeAC2X+DLZ9vi8CxOO/NOttYzp8QEPfoQOtOWQq6aLW18oh3yLJ6zWlWuKw/2Rajiu3zn7zLFR8ilr4ZbdpSUL2TJu5rdZX+i71WNOw1dU4mu2QyfQAE9KWGjUUMMS7MwU/IcVuOu+XVLQggN0qmKS1x9z09PYTWu6o3meSTQp1kccc9g8xh3q960/EOHXs1S0jm2d2s47hiX6rx3oMT2YjGWD3eab9IbfyCfvKEOt4Z3AQuZTSmUJFPY/us6MWJoW1oB3f/6BKzfz2898S7+g/TnW1NYrEgKICwa7TCDVxKd1SkL1RUXotXDFarlItxpvNwYpqlefC9PaFTOEoLL4QaHIYp49sBph8u89dy9YKdj0U5wNn1RBHYssq1mpCtIdMs4l0ojIo8PgWDP91W38yvGKkw/0caLq5gofzUzrHp77St0hixS2CrGKDFapmPFrTS9qDUI/qrdIJ78etdK3J/Gjmm3LqGwbvds1jpBEYMbH2H9vAPWiQ+fDcB42EtRh9SQdQ9TFHjGLeSy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(83380400001)(316002)(2616005)(4326008)(6916009)(82960400001)(86362001)(2906002)(36756003)(38100700002)(38350700002)(44832011)(8676002)(5660300002)(8936002)(66556008)(66476007)(6512007)(52116002)(6486002)(41300700001)(478600001)(1076003)(6506007)(26005)(107886003)(6666004)(186003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJ+X208ZODo1Ws823FgNu6YE/o4Pnotiw91PE3qJxNZ97nHQ7Q3+CTvJdpgi?=
 =?us-ascii?Q?ZqnbO7D+3+Q5Siot9yrYwYwkJVYAgJHzQTHXzxZm3Q5S/Viqobdg5FuRbfMq?=
 =?us-ascii?Q?eRW9yVhbZO13QE7k1ujTdwF5DlJqPClmP0f5CUmBie1Zpgr++6o99Ackt3Vs?=
 =?us-ascii?Q?2qfVWMhWxdtTVbiH1dVE6g71FIKZRXYe0189U+WKw86izEGrxlL/LRsI1cdl?=
 =?us-ascii?Q?wqlw0fw4s15O4wZow5YGqjAUoTOFz9A8eLH0zoGzkgS0IcYy411+Wb1mGUGB?=
 =?us-ascii?Q?kzpntkG5HLkeK0xngbfUeRGNU1ZZM27MltHj56LoEAgnITfdxpG71nKwtIqJ?=
 =?us-ascii?Q?c8XYve5KkAANXTYnpBuzwKqJdbSMRHsSx0f7QZbSf8TRALBWHWcIReBvJIN0?=
 =?us-ascii?Q?jEKyXsE8B0V40TGLr8ZzQi2yfYvRZqa/sQOaLtRoKJWw9UYsDpVa30hqca+l?=
 =?us-ascii?Q?W/HQcs1UfdDCXcYMrUBw26oO1gh1jTMrk4KUZ6xoSygGUTOqvYk1z3wFS02q?=
 =?us-ascii?Q?dUXCzwcTP0WC8UOn03hejyHBagzCzFsy4CvcF/r+UK7ONGlXp1lSLXtQN3zk?=
 =?us-ascii?Q?ObKMqNuW0aTeOWGfJGBTsjnLj/9vD0DnC+krRaAd58LpaM8OxxjSt8nm1s5W?=
 =?us-ascii?Q?hGfkja3oHnAaXuIvMtTE19BL8y+6OBs3LuokySdZcKfbU6gUwQl773SUo4Oj?=
 =?us-ascii?Q?QR4oi4Mre8wPxnJs8W+OWJbV0DvIQ/0mw97XENH4/E2xD/ljR5XyzxyyebCK?=
 =?us-ascii?Q?XM1OzzEGqZ4mn1hl0QDgoXKKlXdqRS9/8xz7F+gyi2WKfqj9wYJ5vBjXwg2J?=
 =?us-ascii?Q?at3DDuAiQ47g/y7iTxeMWTBfVIUMGnYAnpHWAeD73e3pbufrO34bXlH7rDYY?=
 =?us-ascii?Q?osi9watNyQTiasrjXabHAwb06zQcELMtEl0GmaLwSPGDBmwmis3dqTDQzgFD?=
 =?us-ascii?Q?ievsFKUtBl/6bYTkyNTVq5+y09TUjFi1F+GgIE8BKw3Yqz1f9DKR5LjVMwdv?=
 =?us-ascii?Q?1RgW/E5Wt7r/JG999Rg0ZXHfH6OlRVbLKe6ypGojzi9+ioVAf+EPoFpJz/8A?=
 =?us-ascii?Q?HTXIYiISM4fNboXCXVDz7LRZYtLu4BpxAe2fDVQyrxOW8Lx6bQToQNUwbHeK?=
 =?us-ascii?Q?Dnh8hNqJasSq9Tue4ctCzqaIPG3mTxTe6aN6UE/DcnCcI9YgfIFiNIr2Lbtw?=
 =?us-ascii?Q?8QR2XAtEjLHOpTIDsS77yUBKR3GXVT+ebzog5r2S+hwFiLXanPirYrBWDCgE?=
 =?us-ascii?Q?Vil3+SrhDbBCPMYeZDV1qDfhA3ng93OlW8j83U3rA5ZmuZmxsByYy2ZD2Cno?=
 =?us-ascii?Q?F0DqvrSyq9a40tGQ9Be6F5UI1IXqUZzGYLeSbZQKHCC5qm6RF5kz2pjjo/Qk?=
 =?us-ascii?Q?AixLZaGOBIJhTHFovNMx1zbpFHKcFRJhzpbjpdJ2hKqxxnuipzSaqA2f3Baq?=
 =?us-ascii?Q?2VpHLhyczmLgCwyc/ZL+2a7IcR38ojn4Hgi7zEQj/eC7wsvYE08NWwr52CE3?=
 =?us-ascii?Q?1Lj8eH2tdDENiEfCb8B60kolsx7curz5/n1R3/Ea3nE5nr61IrNC6FKiF1EE?=
 =?us-ascii?Q?ynbT2RBmZxhVKZDGKr2Vj08WfR3hBmijIwLBVbGJMsOf/Q0PuV8/vOVHcd7B?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb376fa-bb73-426f-8073-08db89ce8d51
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:40:43.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz589xmyCpnfl+2nRty5dV+6cj0bwD9OKdwNgmZFfaMwgiK/mKgWLSCG3tCJZg4CkmkrFKIxp7SiFRob8sF195JkiZRRF5foYyIsFhw4S9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clock-frequency property is not set in the cpu node but in the
parent /cpus node, the following warning is emitted:

  /cpus/cpu@X missing clock-frequency property

The devicetree specification in section 3.8 however specifies that
"properties that have identical values across cpu nodes may be placed in
the /cpus node instead.  A client program must first examine a specific cpu
node, but if an expected property is not found then it should look at the
parent /cpus node."

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
- Refactored /cpus node lookup
- Add missing node refcount decrement via of_node_put(); of_get_property() does
not need it
- Track lifetime of /cpus node separately
---
 arch/arm/kernel/topology.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..32fc1c8d9d11 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -85,15 +85,24 @@ static bool cap_from_dt = true;
 static void __init parse_dt_topology(void)
 {
 	const struct cpu_efficiency *cpu_eff;
-	struct device_node *cn = NULL;
+	struct device_node *pcn = NULL, *cn = NULL;
 	unsigned long min_capacity = ULONG_MAX;
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	pcn = of_find_node_by_path("/cpus");
+	if (!pcn) {
+		pr_err("missing CPU root device node\n");
+		return;
+	}
+	common_rate = of_get_property(pcn, "clock-frequency", &common_rate_len);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +130,12 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
+			if (common_rate && common_rate_len == 4) {
+				rate = common_rate;
+			} else {
+				pr_err("%pOF missing clock-frequency property\n", cn);
+				continue;
+			}
 		}
 
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
@@ -154,6 +167,8 @@ static void __init parse_dt_topology(void)
 
 	if (cap_from_dt)
 		topology_normalize_cpu_scale();
+
+	of_node_put(pcn);
 }
 
 /*
-- 
2.31.0

