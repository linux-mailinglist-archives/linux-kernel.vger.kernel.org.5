Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7987D0ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376514AbjJTIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376502AbjJTIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:44:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB2D41;
        Fri, 20 Oct 2023 01:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/CTrKqSGvW6lQwVxBqgo518If8xzHVv6ru3brRr4ATBHefQtXPBo+Ad0L0T3FsSPvmL2F7p4NUVYAW8CiaJXeO9DfslWUTX/YCL1ORoy8wxX9SJ/R5t7H+CZyG2sMEvT8calINGwSX60twfFLf3ce+uFEwUFlayfq+PKeTsDiScQNXpytzrNMYTmtlAIYFxddNR7R8iazmPEEeXM7+ZRU07FC/bBblrmcKZLDkIbsXcIxbbxb9roetO3eAJa0ANpYVRMToWMAsRYm/YxhHvABKYUv3SNWnuzNQbRZDXJ3aktXuwcNiWpxpVlHbRGkq+nKgV6JHQBi66vRUh8cuhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV0FZyonkpUObozelfwSHTvjYkN2DZEjW6NLwLMed00=;
 b=NuKL65UpG5WXf4CLRJYDqrjGVE3oHZuCUXzpEfP6j5XOi7dOalY5AgitAz9sfwuft8GgkvWv3I7yn2tekWe+0FghjwTDB+NEc13UUy/YhvVp04F2Pf4PDGO50P4/suXv87StycKz73pbUrG81N8LVPDTmW+064Ti0OBBEnWqRdERXGG6nfuVAJpTFwUnBeiME7mWKAKPjWHbUIFYbPm2/6eie5bXn9AWMSW79OhTGdN8oSo3ejof+z6WPpQD43IIMib3GO1nXevA6qlNUB1P05WtRp2+fl3kuqLQ2vuVVRYw26iQCSNqU87nt57em0B2bQo2gaAnnoGmWxLneIpQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV0FZyonkpUObozelfwSHTvjYkN2DZEjW6NLwLMed00=;
 b=ILrDihYvV3VWkB7fpEUZAGXGYvQreSoyLkieVetinb01q4MpsI+iwYWy49noj1+Yf2OCS4NWTHd5ZJo92SD2mK9rjlTpsOu2ZnJhac2khujsXbTc1OL31FvfVgOIY1PyHIvYmSM2jR3MaSHL2wKMe6ZtQ0jUGb/kYlO113xe2jouj8elDBmg+Dwq4mOux1tfGKwJTsTNSAVPS+rsVMqUWVny6R+VmZrmq/d4LjG5+6ZUAbwB58GdR6Xy0xHHltcu7UZ1cJh6inErCev8a8LjR6BUJzsXW/mIaTACd72ZxHo+E2cFCaBEoZT77AuAKyDkx4B6iD+Q+VFx1Bl0r8Du/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6553.apcprd06.prod.outlook.com (2603:1096:820:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 08:44:28 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 08:44:28 +0000
From:   Huan Yang <link@vivo.com>
To:     Yu Zhao <yuzhao@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huan Yang <link@vivo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 0/2] check MGLRU promoted without hold page lock
Date:   Fri, 20 Oct 2023 16:43:49 +0800
Message-Id: <20231020084358.463846-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7eeff4-8763-4b46-ac5c-08dbd148c55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/ST7Ofe3xqlhataChgMtooHHbbjdKgETjOenlC7GR0w6ODjri0Yk+vwWUYWO1DqAekXqowGcq3O+0Ar5xknO1h4eiQQIWoczTy51jmURILN5Jk0CYsmFlk2h31obxnWm3tp0qghA5qGERqMJtAiePrGyS0kQLTW5SEmiFDjdL7EeRExz1QYKbE+2zpKC0iTNpVkb2zBZ8WvnliN2PT41WcEqwCc7TSxkuT0qjba6EqTGa0qm/sKSfj0AO3muP310j1tSyDhEsO6GERAQCZCgoFp5YWk982Cpy08yYkBASxBxEQUAKSS3rplsqs3nf/UsiFRMyBLHjDJ3VBzM/mh3wpvu45GmNFK45tGJYnZkn5gmoydcIBfDhyP5zOYdcPin8NwRkyhm0UjR8AjxHOEw06PAIC918IciSy+PKAr+ZUoBVBovn/dVkkIRL9yrIN9q4aUE2BcnDdaNnJ9S1s1WUTR1RBThJ0ISTDn9oA65uJA95vcoyh45IGoeZ1Dyj41IOEHPC/IgsRNbF+FTdDaOITqU6cAcjlx0BU1SctO+IQSwxIXY9n8mzW6Rga5mgitdvxDivoKAf3G+TvOlhGTkpiW78VF4c0PUXMTQvb8NfspwAHkGy4Rb1vcrX0RKonF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700005)(6512007)(83380400001)(110136005)(66476007)(66556008)(38100700002)(86362001)(52116002)(2906002)(26005)(107886003)(2616005)(1076003)(6506007)(6666004)(4326008)(478600001)(6486002)(66946007)(41300700001)(316002)(8936002)(966005)(8676002)(4744005)(921008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/ESa6DFKnm0YvwGnxWU8FBDHlY91VVfn4od+s1k9ij0L+Wj4yyEc9UTKIKD?=
 =?us-ascii?Q?IBexsBebfVddUepLnogv42qGy7aybMNWYksRWFfSOVfsXO/221+iTYAsDFfs?=
 =?us-ascii?Q?GbswTMY4W5i7iSu7+bLuuoRdUfGDOwE10TBCv5G/6tlegdal/gV3JGq6lagT?=
 =?us-ascii?Q?aFwUmu+nP+XVK0NavX0NbRdqdOgSJZRjQXvJcRtX+MUUiCz/KssNQerhs0Oz?=
 =?us-ascii?Q?EPYKBi79s/zMhpeFbaIQYIHcsMUjON3GfXbMu6OcbGn6R29sWUq72HLlwpbm?=
 =?us-ascii?Q?EERy2VO/zBS1pVHa/rrRJPDMVQ+F3owaacovx3How4B3OrKLyQYzdqj/tjXb?=
 =?us-ascii?Q?kwegQl+xujewlXAID/OuJdoH1/gh1sFR2qugNnkITZ8KlfIJjoXxyvXNwi1v?=
 =?us-ascii?Q?nvQwvArsrlGwYQpcu8e19Uks0z060ObywGsmGvy2JvuH8kJc5+NQNp1OUhBX?=
 =?us-ascii?Q?kG4IyxNaf7JkghdqCrePrim/sx20ixkdQHJQ43t/yyQuSCY3SU0/EIoXdoDA?=
 =?us-ascii?Q?ecq6dpSsWzi3sRIsVZCaySZy5ZzhqlJb7KpunItHkkk2gaZ1x5b4d7Wop6Hg?=
 =?us-ascii?Q?g/5vGd+cOOAtzzlHLOtyKenckA++rqHO04Ldx1LX8sDC6aIPAPTA8d9zUr3S?=
 =?us-ascii?Q?7RmUFD4Y2XwrgGGCb74u6M9mPzNbufEyuNn0qPkK6z8JbPOlPxauFH9MIusR?=
 =?us-ascii?Q?/xm6b59JfbXaTeQdenh54FalD0u9ij2fN2cKLG8FQeVJHa2xLqt2mOEai/jb?=
 =?us-ascii?Q?S6gBb1pZ1vU//S4/O0BTtQfmXv598UPj6P9fTVpYZqVsjZXopG8G4DAaWi/S?=
 =?us-ascii?Q?r4JTIu2NN0NmpliSKsSUVjLOAxxTJuETcDqk0QkdlxjlD8/tbmpIYxPThAqT?=
 =?us-ascii?Q?arCv1h0tD7d0544YXDwg6/vQsWX+Srp0c51QD5ORXTxRlTnoIuf/03BnHn+u?=
 =?us-ascii?Q?h9j6BEyKEv+rj2+zlPrRaYyXG0YcLEzEHJqba53n8hNkehP0zwyDfbZ7KzJp?=
 =?us-ascii?Q?krTNiTyA5WmoPLs3EujOZNlyHJ2YdSIQa6C+2W0xdUfhOFiH28qEUm+F3+sM?=
 =?us-ascii?Q?kUWOT/5oFy+Hukzx98Q/+U4B42NnhCkBqo2XfoKFvE9dpdFgo3wSS0GI4Pgu?=
 =?us-ascii?Q?6MtbUWkuUn0WkPbry2I8imz6Aqqgk6EZb1nghvmYquAhVmopwuhwMXrZV1EK?=
 =?us-ascii?Q?keTy7PIx9IziR7TVyoiBC7bOAdrRqM8HWBxMkzNlukoeV5kD22ajAsC+2U8m?=
 =?us-ascii?Q?7mf+6Liv691iEcGjybACWFCtEj4HsCOPoRkE+nf7DLFeVZgYTyToTtet0N+u?=
 =?us-ascii?Q?F3krzZUGNs5gBrUI0hQfoMHTlypUeer8QoYMwayssr5rlnyb/57zSYrjtTEQ?=
 =?us-ascii?Q?DojkY+EQ8qiwNkscHcTqzKkY+OciH/ewWRzR4NSTmprqr0ZFbe5C5vBKqGmA?=
 =?us-ascii?Q?FaJPfGRQ1FDvN/GIqbhtUEbUfulUZ/tHlkqE1WQZNAhJonuMcF3cE/pSGPny?=
 =?us-ascii?Q?cBfJokjRh9qzNtUhM1ZaVQjzESptGWa5jCsiSQGNhqBg6altbwzzLSU7oLGW?=
 =?us-ascii?Q?l6fYoUS6dDg3Mh7W4e3kAz18rhKC3a6uKorM36aT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7eeff4-8763-4b46-ac5c-08dbd148c55a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:44:28.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1sUSvzgUg+RrxhnRoC97YZwD167LJ3mQGBnomr4voYH0NDLe7qv/gS7xyxv2ei5UklfKI9lr2/Hqw868HHEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6553
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add a new reclaim_stat named nr_promote to observe
number folios which MGLRU promoted before shrink touch, and then
show in mm_vmscan_lru_shrink_inactive. Also, fix nr_scanned in MGLRU
trace into nr_taken. (patch1)

Base this trace, here are many folio promoted before shrink touch,
so, due to the high frequence, move this check before hold page lock
is better.(patch2)

Due to we will not actually touch this folio, nr_promote trace is
unnecessary, remove this trace.

This patchset based on link:
https://lore.kernel.org/all/20231018082104.3918770-1-link@vivo.com/

Which have many mistake pointed by Yu Zhao.(thanks)

Huan Yang (2):
  tracing: mm: multigen-lru: fix mglru trace
  mm: multi-gen LRU: move promoted folio out of lock

 include/trace/events/vmscan.h |  3 ++-
 mm/vmscan.c                   | 31 ++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.34.1

