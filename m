Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7D796FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjIGElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIGElJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:41:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A26019AF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dALJPD7bLS9S3vz0HEbyxxowuXzoCU+d3zwuUrqytqKYcYX06duaTT0nYakH8ibT9O67kOdwpo0gsyVl/YnkTcGfNmLg0y/tXm95j0GiNXP642vw6TctizqrjGMYq6WA0qoN9SxzJTOfnPSjIf37utTPlQXwHpNpWgFu+wbGImzFG2ZeVGbCZuDx2C0JQhWLmDLPVsKFqNFDMvnqZqs3EAiS/Jze3DcXzEPlp6/LxDYYfG0h6xnOkfcC5rE9G2hn2etJcgWzI0Hm34Fl3G3pKUu0ewqH1kLFylQJU3LHt1ahUG+cZu0HXCbtDVVZSjY5vV0M1UYS1h1hAxgw7rneHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9npfzMziSq3Jb5vgkWFkpsXZGOuaf6whDU9jNC1M8PU=;
 b=e4laFTzuc4llYSlkhVlGTp9PX046LhX7BcnOGjo/oaMIvTr/jIqBRICY2Lai8Z5o/4dQwNzmgWJeG4FXreVieIfz4vxwUIGzy6eFArHWT02KvxtSJGOvhZlm3IHPyV8XfK3Qhn9zNkw+D/ExpedWr1xmdEorOG8ofnvYZrhMjhvdlRvu0gUtcFwhoBue35+0Xd6xaz/ZTMz61VT7M0Cx5JyJm9P74wfGDoVy0HYMJrnw+5xB6tBTdmOJ6rS64k34HsmAvvG4gD+LAWALiymwMzdO76V5f8ejTyjI9oq2TV/T8UPyvR5zD+tmVVVXBsXiARoUYb/NBcDw20Eo3BbpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9npfzMziSq3Jb5vgkWFkpsXZGOuaf6whDU9jNC1M8PU=;
 b=aMnq2PabjjkMY4IWCNWFfLJAB9PB3EOxaiHF2OZHQMfbUN8jlFUCccFZQFinnyl1H874pboHD9CDwMX1ZKL3N9H6naduQLBOwkihySdnlL7dpa38J6eZ9h01waVx82iw6tqwhUmLpEPGMf2AemCYrgLJN2K+eKGRPNceDfxF1cgX9FnI3zzEC0EmNRpqK73E9y4BQRof5Md8GUl9iRNygjXvt8qMt5ilmXPuZLz13fw2MBuJ2PMTDvjF383Oxc1DkxOWqYO4N5nEInlmjiSEKnERNJZrVN2cyLTA8sU4aFOyWb738LjeA9x5wePW0heJuZZbRSaSjyNLF4EE/fTPiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PUZPR06MB6172.apcprd06.prod.outlook.com (2603:1096:301:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 04:40:58 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 04:40:58 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: vmscan: fix get_swappiness() return value type
Date:   Thu,  7 Sep 2023 12:40:45 +0800
Message-ID: <20230907044045.709-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PUZPR06MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9babc1-cbd6-4193-3020-08dbaf5ca120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HThej+b4HpCICkLV9dguUES5OQ8Njt7W0P3dpxqBeITpKfxrLa0yblpIC3j2WpK+TaV+iZIqOjoNCf8Q58YsdQs/UsQkQDBaWZu4oLR4HAQTbQQmIIm9h4sU0JVPeLKI464F8WpOAafW0ODNYhAaEX9jLuwwc9uz20eWZMejeEGDpqh0++fm0q19npU/OrCWsNDnpPHpwGA8UO8ceUFNxnul6zs4MK4ruJ8rISEvnwQlSlm8PlZrOlAThb7bJsOgu9mnhwSnGg5iKMPJZfVHCAQKXJlmGPpLQgRM8W2YaXFhVE6Pq24A59qi3Pmc2qkMSEVr4Q4oIQaKjrqVQhWh9Y3RiPaAeGLYH5WggCToJiOHCT8n6iIFERuYX7e0h1YgW44e99bs7uucB+5UHh0OX3fWLOP1VDFz1x6YkEwH/5dLtupL/QK2WvR2XBSt7EGHe8s6N/NA6ld3uwI1ekln4lS7q+fmHkPhQvoE2SA+hDef2Xa6JYvucpAez6dCK4OGnP3/dPGwl/6jhu+HRcujbcZgE9se+06O/QQff7lArtj/3O4V/5ybMkNPVsj8tLzdYGqKloe6MbWZ0nPH3kqyI5LryLtWKYw9HIPNCEngDyIT/w1ThhHHSxD1zo55ASRA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199024)(186009)(1800799009)(38100700002)(41300700001)(8676002)(8936002)(2906002)(4326008)(66476007)(4744005)(5660300002)(316002)(6486002)(86362001)(66556008)(66946007)(6666004)(478600001)(6506007)(36756003)(52116002)(6512007)(38350700002)(26005)(1076003)(2616005)(107886003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?boyDffe9bcZzQusWtEqv8/r1QUDNIdh6OWCopcxzcUij89lp+hhxNooXIKH+?=
 =?us-ascii?Q?fDWEY5/wXcQelUfyiTu9SVPmkehZPT6YtCVlGk5yPKTxtBsqVCwQ/9D7sqdb?=
 =?us-ascii?Q?ivlyo1kMgL9tetWfjyJ4+CP7+jQD1ZBOjw9erzB/ng+Nd0zI/mu9H/sBvKny?=
 =?us-ascii?Q?w6OhMjfo3f0Dt61byAAodVxwvEaJF4ajmSwSZvKRCvF5RtlbWgFkKB1eLnKw?=
 =?us-ascii?Q?oIFWY7yOLRiEu1CLdKX1KN2ck5UqjCIr2nfd2exQivU/goIqcrbc7qsuQJ3o?=
 =?us-ascii?Q?ug8hawuXMRMPLrWMbRAQLBVE9bCt2pBAsiCP4bYX/wggGp+cN9qdeQEQNZH7?=
 =?us-ascii?Q?9H2+a88A0pRbdDosshZ0Y/yqSnph5wQiSF2Do37ppmDLwLHbkWKfIN96utt6?=
 =?us-ascii?Q?awsrT2cM9XlmjShrSL5HmZku516nBNGppQLVC1W45A2Xvy3eWwohnrJYn4HQ?=
 =?us-ascii?Q?ox7/QgNfhQ073vxzvvYE0rF0X6HKggPtQxLVRP2lPolyH/y5ytMfBwKW5Qfh?=
 =?us-ascii?Q?7gw0ikJDOsTX14PnqKbffcqTNMjwPadrZ5hNl7mgGuEtsD8dkjkJje4dao73?=
 =?us-ascii?Q?B3vfYVEDIQwvJly4MbzaHZcANvow6akcxeePnhVEw0bYZEGxquz+KFgY6uCU?=
 =?us-ascii?Q?BeiIkHNFdFQYfGxdLXa6wLsL4baJHkN5P9F/olYRt7RD8Zpp9fxDSrPwpZJl?=
 =?us-ascii?Q?QCxo9sK64+PjRO3jiuQTPpXgE/5IO8c8ZLVXo6Nj3u/j4zlDGUmUIyWLM6AB?=
 =?us-ascii?Q?dTxUhi1Y2xSjjFKgEe4SMRlPEBSADFnLhOCoSGFHpGwz00tOrj7FFohPZL5e?=
 =?us-ascii?Q?Aj5szlJsyaEc89PLbfEKvDR+Tu0XPWrMLAy+gF9LwpALkQEESDazfMn1WJ/o?=
 =?us-ascii?Q?CMjmtIn21BRRaGbWCrN5g+5vO30ypA9dKUBX2XECsSu364br3H6kr57B3jLB?=
 =?us-ascii?Q?bpl7IUN/So2O2wykOFePA8L6FSGZUjqXGyR5I36pSghnRsdRQPmFT0uVwYwN?=
 =?us-ascii?Q?g3dfObeS4DRKr5mm1kknTv4zdlYiFnyAN9Ib8yrHA7Xk3yADPzjeZW1z+OFm?=
 =?us-ascii?Q?TgEgvlQqa6I0e9n9cCcqQwe1HyH6gT0wvzT56ER+gan3G1Fz0iCf5mPpsiNX?=
 =?us-ascii?Q?iD15uMrymsnLt48dWWqH4mTkg5HDkf8jw3UQmlOAoHGt91xQPJVNquNr+cFT?=
 =?us-ascii?Q?GAMrgqcRWRp2fIwLAbaYA2Rj3mNVTee8iWFI75qzlqOp35rfeIJAwyy13J9X?=
 =?us-ascii?Q?VuVe+rA81MlL7Pdile2qBO8m0Exm07p+vV+YAMuPgTpSUO66ZyjuFW66786G?=
 =?us-ascii?Q?C5TpwsmVNa9+O/rLnBSE3OcyvrA3F+hGV9m3hcNv0+bzfhQB3EeF+bVx2vyV?=
 =?us-ascii?Q?IVSlIWfVjAIYW4w5NbEyBej0jeUy6nUpKsMPMC36F/7KaMsvQxUXj2MJNCCh?=
 =?us-ascii?Q?BcELLRWg3Xswp29bvuq7/A6EoYUCVw5S9D8rW8/iH/vRMgXwHwibnQAu3w8c?=
 =?us-ascii?Q?K8v/QC/klnqvWccQn+16tj7vHASiyjFNuQrabY2X8adc/QB+AhrUw9ahDQY/?=
 =?us-ascii?Q?/t4eK2S2GxuXBcMsf9533osJn4Ta/9EaB5FAcjxq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9babc1-cbd6-4193-3020-08dbaf5ca120
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 04:40:58.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+AeSFp56bAK0Mu+Eac3+9iEb9GruDi314Zvp4h/gQ5PrYfIfN7kO+DP5gMXpNc9CWGspfjXPX0arQu/fVzLGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bool to int of the get_swappiness() return value type in
lruvec_is_sizable().

The get_swappiness() return value type is int, but the
get_swappiness() return value type is bool in lruvec_is_sizable().
So there is a possibility of value overflow.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ea57a43ebd6b..f383e5b14598
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4575,7 +4575,7 @@ static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int gen, type, zone;
 	unsigned long total = 0;
-	bool can_swap = get_swappiness(lruvec, sc);
+	int can_swap = get_swappiness(lruvec, sc);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
-- 
2.39.0

