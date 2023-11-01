Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC17DE528
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbjKARQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbjKARQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:16:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA14BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GY3qx001742;
        Wed, 1 Nov 2023 17:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MMmX4ETo6qjnMuJW9b4bVn/oCauAwDQhAfeQeOoqMA0=;
 b=O4WkemI0mx6vPCgiGRm4HZJ6wwWcKU9r3AfQ62pSwpVct5N2uH+Z7WiqR4qHkkAhcF/C
 0t1Dth+DFP1gpSUQ5cvODYiabLD17nfxuQ6mF7i1MOaUKbCUyeABNIn0IX/MVICJ+g/c
 +J20bJjFFz/KKJZ9Eb3M6TwBe4pCHd1aeZe9G4YWCLwgvCJdh+nwKZLeXw0IYpkO/Gmm
 maxEl96ZzQD3fewg3cLlkZyGtrPvPSlUXQuuS+MTiDmaXRh7sFUmithgLD9JoFq836c9
 pat4JwHvaBY/sK8jTs8+v6MxSip+96lsSBJzQUgCwbSx3VEK3Xg25G99BFAGudk7KPEV kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe015m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H2pF4038036;
        Wed, 1 Nov 2023 17:16:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrdjxm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvMdKpma+C+tWcc74B454dUVy0oOg+wvrwkknv3jHzp6tWaAoKT1GjPngWLQYZ/ZQuCvSrD5EvlIJUohsBv+FosQOY4xTyijImjOUWP6Dd/ZyZmZzFpUR1V72uldJVLVSH9mKmSbMpPaa02+PMbiiM2So/BaqMggJZGlqECu3toMRim1q1jULDKnVmFAa7kd+CF2Ebjb6xQAeWjBWeqWU/v/U87IKlO7XPkuOcZmZtr6YH3PV5qLE6msdN448qa/madRLWxwp09LdfCHR3yD2deHyQHZuBdlx+hwk5O+Vf55vP87iwSxpHyPwqMhyg9xYWPKNM8edC083+brNOKROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMmX4ETo6qjnMuJW9b4bVn/oCauAwDQhAfeQeOoqMA0=;
 b=S38EZKo8lvV2FfgJIFxARXOcUen5JmZOHr8rrm9u57FqY9gA1DbhnmS5mrCKl5TxY6er1qjOjbbpwb+b0ihikOhQBhIbau1d6j/i0OKtMHw0YNtyOK9rLEqOUaBBha7HKcaDJBlEW05d+urmJ9YKrgC65cAbDgMdCOGjfBX0y1b/COXEQ3Mjb5FPw3FvUbJez8T+KQf8ORZttPgyNDnpnCd2ginx1BCGQuqeFgiLZh6Qo3ezyOBIdYQR2SpGpYip1JLyQ20+Ssb3mwhRZ3Rip7naPjgI7kaq3WANnYlsdM6/7ZtI5WAGi3nODHH8AcrGG23TU7IczzRNQ35j3qn1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMmX4ETo6qjnMuJW9b4bVn/oCauAwDQhAfeQeOoqMA0=;
 b=NR6vBMSoDSNlqOGhZ/9jDYU6HL8gN90q1U0+b8FABXaycYl6ZadhK4+CwO1UQ3cneosEf+j4/LUWv6pTUyzdE228Lq7KvB73T5JeybmWYAfBWoNIvW3oISWOb5a98x13Qhv1QoeEsns2LmMF5D1X/yITK9gCEjff7spF7KvRPBI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:36 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 00/12] maple_tree: iterator state changes
Date:   Wed,  1 Nov 2023 13:16:17 -0400
Message-Id: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 687f5c30-173f-47ee-4fdd-08dbdafe4db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLJ3Ob8d4xQ+HnA5dsdOYpTHtxDMzuWpZu3OL8//TTSs+2y3OQyCf9GJXLZv4VFz9rstypDHgA6VHiaGvDsuJmJDU3sH7YJ54s0ZMBzRO3M35PhPFgoAOL6oNlSIoC4zoQPN01SAsVuJ9lXH3FUWaQBmEkX8dvV30EzBBJxWEnOr9dqKa5kk/8+b07lcfoVOHKf8EBTAUoYPwgKAYAk3QV8TLYs++rKNeA3oJMG6bY5AaLDcDwQoKedF9sOox98i0wUbV7LlTezsz2s+zPjHHxUdx2T1UBQaOfSBfB1J2X+p3CxXz3Cmb5gJgkZ1r1ab5JMcVHYIjGpOjh289czdNYK+f1ou2qu1gM1XiEN8MCpOJw+ZlDxKAdLagQ6Dl4lcHIPYoEBiqkYlmyfv54sg4KE/QKujLWO3W4tXvYPIvEQJtJulmCLU+baLOh8dQQqyEKqtfDIV5s513sjtuwD/oFy13v0CIgm27D7Q2N3vASzoR+qJdRK1U+pgG53uzadU8mkOrF2Caq3Kpsi+na7LJD9wDUIERkHRpfXZUKJhtR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(966005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HO99oly4l82y25/MhpWKkyrExbu8bvdbpOx2n7Vw5BoMemZQFyPJud9zNoV?=
 =?us-ascii?Q?w4rCTt0eABjO5CnxEMdYFirOx8ZuAtgUAxdOMN+Cn2tWXR208cCvCYgNjfUN?=
 =?us-ascii?Q?aattmd/nwtqTzQ20U1vxg1+WU0hPsT/JT1Wq+OjQ5/bO8s4Sg4VZNYkUVfr6?=
 =?us-ascii?Q?iqmp3JAUqqeM9I7kVOFGnxqulnujZILOvXZaybvleuOB6ANUWf20Km2vOzWR?=
 =?us-ascii?Q?LUfS7+pSe6flQndasRFvMlt9qYbYPKnKDMblGfWicmDgeCWVve2szXADfRHz?=
 =?us-ascii?Q?WoR74zdnrw+QiACuSfExsga/SVyXRAani9QE7PSC4hyC2deN92qrUc/7S2fe?=
 =?us-ascii?Q?9XCBENkWvXQjsg4EjslKVfEO89rNDqi+wqqQljq+XuwSlPKrC8DM9nSQmSMI?=
 =?us-ascii?Q?uhiQDUgmB5oatYA1NhNkmUz1m3VFfYxfmmEy0NVzAMTz+r3DWsexMxRBqeC/?=
 =?us-ascii?Q?SlRbywJQ7ROfUFy+Xj5ccpuRUYn9Kubv62sxsdvsSdnBr/hQoesnZsPvW+5W?=
 =?us-ascii?Q?g/n9177Bu7VF+LOkcokL7/OFHPb3OFP1qYG587Okfx2jx9bVTy4a4WC03k3Q?=
 =?us-ascii?Q?+t1UdzHgJx8kygfuuYqCtyAqHATaHHV7MsW5okhwN1iNtVosO8EZQ4Xr4XQ2?=
 =?us-ascii?Q?/rGn2Qa9wkvQQulivYo3gI5sz1hHMA+9ofIb0K4/8ZRbqsfA+OYJTCDmUKwX?=
 =?us-ascii?Q?f5Bqya+hTb/fOB3THuaYR2GoYuqK4q/x0rLmarMF/WZPfdxoh1zEMfUFpgjK?=
 =?us-ascii?Q?uD6iB0vaFNEydJAmImCD7EWq3GUdunKJCYUz1khnqMiDj1+/jHwp7o+fkaAE?=
 =?us-ascii?Q?4vkhDyiRWjjkCX1/MYa493z4ZN8zV/L4+BpxgneHqamBjJYfzcfdeEUOK/7U?=
 =?us-ascii?Q?UUklPHhHDpjlGKUd59O1/zO5K8mVuDZBrzVcROpDLuBWfgk3FVN08abGVAI7?=
 =?us-ascii?Q?gh5nXA6Uj3YXvhiXhvl6U61OcFOv1SOmWtHWVlsdG1PqP1UiliRRUBbprpZW?=
 =?us-ascii?Q?2W8xdbkvEZtdSU7jekWUhyFz6x4AxssXvRoRfEm9NpNRoc5nAZKoJbf/gn9v?=
 =?us-ascii?Q?FobDpx/ri7Yj6wogsbo6Nf/PyPwdSiUq7XkujCA9h2umLl05Tj9x3LiuXDg2?=
 =?us-ascii?Q?z6CZjLIoYSowLSjIqhV9k0AQNJMYVaMo9NhmfOXTmPiUt7jh4rTgr759VDUB?=
 =?us-ascii?Q?jQbQfmmgkICd/itnnpa8zYF0LiUCbBJcyig3odbk7xpAI4C9NXd5Am5dn9ly?=
 =?us-ascii?Q?X6nQQlZbboR3fxdVYMEJY33GAhz+iRLntWD/RNGB2zwnBrK9POXk7IinSSXw?=
 =?us-ascii?Q?Vxh4Nf2sly9Ly+tVTJK6NO5nyBIMdHUVcjytnVlJqheinJMeKJ4OCWZbIoqr?=
 =?us-ascii?Q?ibjt5xLhs/uNolIw5Sr+0WtO4uwt2X78KDjBeP5rUu8E/mIY+ckeV4NHiD/z?=
 =?us-ascii?Q?ZN8ZaLGbYt3ka/Q1yxbRy7/UR1YZj9hpFkmnYcCviUKfqQYfarOH2uDBQG1J?=
 =?us-ascii?Q?rWvvElQgonzQD2rFkqYyYHBuuUP4LenrEjWZSfm5QjMrfRCsT0gfEjCJnQJP?=
 =?us-ascii?Q?oTcky+5lezrLpNPdcZu/OzXPqNg/dYn0iCRvI5nk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LfmijDtZPcnCrcRv6qnp9MLPHvNzxdwl+vm6TppI4z36wcw+qFo0TD4Pq14wnzSw/VgW4pE8wqQ0VvNbnquKXR2FTmqsazOF1sjBHZ2pa5KKHrYf/YchD7aZ4YoLaZkPnlZGotL2+u2wv1666nIRHGr5aFpcGtgMOyArepfnEPJbAWdXihlW0hD8BOmrds5pwFr2WbTD+xn7SH/ZFzMr25Q3kql7RXOkcV9A1k22X+B+i0A9DqIrVd3oaugD1Ocn68K6mgrk7ye2ARqHoUzTwlUw+oUO3f8NSNUFQa98dRSrb5cMGgk2GOpRwrOsYxcROIPQPU8KLaAvufZyxwE16gCXpGimbyO5B/qlOfMh6H/qiYjT0fcIVG4TQsiVh0u7B9INzSlIlK2fRzPZKWfA0zkzxT9uKgI4BT926T8e0u6B78wKxJVnH/13SLpIVV4WJT1Yuijk2VRMBqaWaTNtP7cnn855QU5OOBCUw1pou7IZjwAnxqgk5rSQ0/xnUSwCIAMLiOETFhWckPbZ9O9e+Jj7wHcI9H/OxLD3u1CkGzNzWd2aU1qdBI8F/PWyUSQHYezlU9r6Z6VApRD9wSl8twfnQQcX+puQitMuOiFfsDIrIzJYALjf0LUpDVqQGrXAeiHI9jkKb2VZJ3QMd+v69OrrCBxXIsTxRzD6iSx7Pig1789ybPynoZ4S7jSj6yg2516Yh4gcq8SkTMcjaby0eoZHJrtQWPf3x3H2kMbhgZ81MR6S91Cc7CE/708oR/RcSVb21DabRpENvv3zkksOg3hzHGkHyzb0rEkdrb1vjFFv/5jcubfOKHamhaN7hH1eZD9RuqhYWPIA/Gfy95lWxtRio8ySOcTUZ0bAesHp0ZCoxRh2IrAYPhzZ2pRRLCCtlgO35neW+afBbnNYUehMVQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687f5c30-173f-47ee-4fdd-08dbdafe4db1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:36.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10fjAsWBJPInZhL0ju1jYDOqYfP8Y7H04Z1jGfNiuC67txBMgNG/p1EwozL0KhsoeRgaNbiSVUa5xgCI2KDDuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=635 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-ORIG-GUID: FsvbHEjE-2mil-uds7CBbcMblgvbtHIb
X-Proofpoint-GUID: FsvbHEjE-2mil-uds7CBbcMblgvbtHIb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

These patches have some general cleanup and a change to separate the
maple state status tracking from the maple state node.

The maple state status change allows for walks to continue from previous
places when the status needs to be recorded to make logical sense for
the next call to the maple state.  For instance, it allows for prev/next
to function in a way that better resembles the linked list.  It also
allows switch statements to be used to detect missed states during
compile, and the addition of fast-path "active" state is cleaner as an
enum.

While making the status change, perf showed some very small (one line)
functions that were not inlined even with the inline key word.  Making
these small functions __always_inline is less expensive according to
perf.  As part of that change, some inlines have been dropped from
larger functions.

Perf also showed that the commonly used mas_for_each() iterator was
spending a lot of time finding the end of the node.  This series
introduces caching of the end of the node in the maple state (and
updating it during writes). This caching along with the inline changes
yielded at 23.25% improvement on the BENCH_MAS_FOR_EACH maple tree test
framework benchmark.

I've also included a change to mtree_range_walk and mtree_lookup_walk to
take advantage of Peng's change [1] to the initial pivot setup.

mmtests did not produce any significant gains.

[1] https://lore.kernel.org/all/20230711035444.526-1-zhangpeng.00@bytedance.com/T/#u

Liam R. Howlett (12):
  maple_tree: Remove unnecessary default labels from switch statements
  maple_tree: Make mas_erase() more robust
  maple_tree: Move debug check to __mas_set_range()
  maple_tree: Add end of node tracking to the maple state
  maple_tree: Use cached node end in mas_next()
  maple_tree: Use cached node end in mas_destroy()
  maple_tree: Clean up inlines for some functions
  maple_tree: Separate ma_state node from status.
  maple_tree: Remove mas_searchable()
  maple_tree: Use maple state end for write operations
  maple_tree: Don't find node end in mtree_lookup_walk()
  maple_tree: mtree_range_walk() clean up

 include/linux/maple_tree.h                  | 342 +++++-----
 include/linux/mm_types.h                    |   3 +-
 lib/maple_tree.c                            | 680 +++++++++++---------
 lib/test_maple_tree.c                       | 201 +++---
 mm/internal.h                               |  10 +-
 tools/testing/radix-tree/linux/maple_tree.h |   2 +-
 tools/testing/radix-tree/maple.c            |  27 +-
 7 files changed, 679 insertions(+), 586 deletions(-)

-- 
2.40.1

