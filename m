Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B97CD615
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjJRIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjJRIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:09:35 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E6B6;
        Wed, 18 Oct 2023 01:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etgcIqMKj/uDzBEoFT++p1Ujpo92OLUCZ7zP08rbct4DQ0+z7HPc4Y+W6qkdKgOObuaQkAi1S/B2MXnp8ImzX5mZAg1NUkEDYIiDmLsgqiFbzw8T5j9aye+GQm0ee7FvJpt94u5xFUmgKVdSllBWnbKyl6yx3kU7+N9XWVdZAD8RihztmP+M6+Y8ntvAo6mqWIGHdqlO76R0oHdDoq0rCkTMRIJxaNbxdmxRbnIyz1ToyxGh3V7JJv+kQi8r02PsM1a8HFUFAiWgdDzX5wbcGqEb0k5kKMC7/qxOZCUgASuszACUV6YNYKPRmX+SSLxprTfyGVpo3PpfFYFjJ0RLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNuA5tqe1+zL1D4/D8kuBzXjhawGhrAa6vwNLsU1DiY=;
 b=edfUD4/XFgZqbvcQRiug8cMmEOBPlSZ3vtp7yLugGL9356eDuiYRrejCSnN+BvR6mzNGEGZj0+XVC4Zl3sNT/LDhFeyrLa40DJyfuXe9G53sZJjlnV7m8mu7Su4JEzF3JYn9FJT9U48dixoSx3S8d0AdhgCNXQ8Kffq7iQDWk/TcZa7d+T6/Zr/02ktfHxBLKocIocDYD3ly2WOtv5P7hQDLxsROE8Kx2FxrsCRtDDSxTIWY4i8/lvI3P75aBQrqfJs8F0q+4s8cS4XUoJacricnF/sebpdyFZ50WPhWlZsqlHLOcWPXVSJQz2qD86WSR8FbATq2BeTGbLjDjfX21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNuA5tqe1+zL1D4/D8kuBzXjhawGhrAa6vwNLsU1DiY=;
 b=AhQ9Fg0SemD1I5bx6F7gqB/QiId1LGIkwdKtJFx3mD6lxFmcwNxVvdVL3Qcuy1I1r+f0cOkFN1DXpNUsWpSmJzLUZaCmAKzdl3J0XyMoPit0FQyH+z5CAaHNtkvKUcJr4mxrpN5OE29B1nsl6lWIkry0+Wsc8/lF5zN3LcG1USc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5501.namprd17.prod.outlook.com (2603:10b6:510:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 08:09:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::3cf6:989a:f717:7c20%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 08:09:28 +0000
Date:   Mon, 16 Oct 2023 21:28:33 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZS3jQRnX4VIdyTL5@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
 <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH7PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:510:23d::19) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c54cc13-28c0-450f-fae0-08dbcfb18c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzmOwDT32dDptlBFxM7ysdq002JvDj/18IW6X9BIb4um09hKx7I997tao36vGxOjmNuMfNro7WvaigTb6AnKiDxE7ZYPWHaFkgS5cLRi8gyBeS0eHjgR7lf5zx43m0fk/RFI1gVjFBOmTOOeW04dOx7l8KXQyqVcBAlBQURIeKJktS2cFdTUtqNO0mvRZPbyTqfg6MyHA/2c+rBcIQjpbDkv5HDuSJ98FtHEKoeV1BNWeD5HbxvC8xrzNW6pseh6HB1JcD+4axTIrh7ZZ9bvbqRnU4WxlrUhg5mpqNWhpl/IdZR84KalCMjpXaBLrfxFnObDRG6Oyc+QjHNuRqNi0NpkEC3hEMNr6K7vWUoifp0A32/VeEdICcC9qlW7QUbjkhsq8Dt5p0a5TagYIOvyTMVHKODLdi9PVPVqY7YmQCY7Mvw5kyr2L6XRBTA1MAdpFYRcAIkNPHHA6WqN7r7BYHrdJ9AlTnYKv1xS0vSzcRzIvgzNXOQy9zw5DiMRKtgDCRf8e8EslXXqA8srDldJQulfp93I9g2UNy3EMxvvGnRod98gi039Uq44RdfpXimk3DBcT8KclLc+vUC+ZVRtlXUbjZkMSymyeTkAGeFkIT5Ta3v81UdrkBioJbD3/xiF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39850400004)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(66556008)(66476007)(6666004)(478600001)(66946007)(6916009)(6486002)(6506007)(26005)(6512007)(316002)(2616005)(4326008)(8676002)(5660300002)(8936002)(2906002)(36756003)(44832011)(38100700002)(83380400001)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DQFqEj+G35VFSgkkKYBNBirMgIayiBtcbCLCgd2jSRjrGOCyvq3wkNLcwRBJ?=
 =?us-ascii?Q?WVKkdhDTzrX6nSLL8NYUw3HgJhXVt+kh6PDPFM3go8XKVqjWV6wVc5kYCol4?=
 =?us-ascii?Q?X7HzvSUNdZ7cwf2RIqM/MdB7LwXxvkulXnNCEVeL0Dckf9RvzKEd1o3thLFd?=
 =?us-ascii?Q?kR5oo04+QTyZFvAjITn6w5shnkWTZvFL1l3BdE5A160Lvvw+BRnlQsN003vt?=
 =?us-ascii?Q?cNRWKLYYpPM9Fe6vw20mk+HxDO45+lMruhDDeRqU/47+xHLXshywvApIyrX4?=
 =?us-ascii?Q?418Atmz39KqgoPKP3Z41QVOJWJEk8e5Kb1uvqmsj1ylHWQ1jp8rC6Q08cO8y?=
 =?us-ascii?Q?LMQZzgvVVLr303X7U45vRyz5mdxv7dR9SrIgnrNG28E2zcn+mqNWDYEGiHrA?=
 =?us-ascii?Q?Rfp90DytcTANiL+7QRPJpf0dcfWhCkrXPGQEcaAjvZ3PsBTiuTfnRe4knj2z?=
 =?us-ascii?Q?CcuZzPBOUHoyRUGMctxEsQLp9kGj1zFhDTG/eJW08zmnuoSvbAd7pjXh1cvh?=
 =?us-ascii?Q?6N3BiI6DD95uHoWTGqao9drKlJZ37NYyAVfmsEdhpKmYpGZ+Y82l4m8EIHMN?=
 =?us-ascii?Q?vCckvPpdPqp5ixDYt0NWJTaAl+PAK4X89Q4QUcIuVw2CVBDRJOTJRkU7z1SH?=
 =?us-ascii?Q?IlWPilZXIuKTM6TywpNac1bDd40xzV1Oo6zxhknCQT8OmhkMxSZg9JRh5ycZ?=
 =?us-ascii?Q?D//X6aW4X5PzQqKF95hMe9HjyMPKFEcYtzFw38HCS4zifrGOxvAN/XU1kWhP?=
 =?us-ascii?Q?RB0et+2YgX2BuznRg0ZZkSwCTP18g2t09oi/YcEV5Izve+K3/FLZgtFaIHDb?=
 =?us-ascii?Q?gYSUP1HmAPwXmCUQ8TgBsNe6xM7qTJo2C3hJQXxUKd0gMH5LS3Stbn8XOgao?=
 =?us-ascii?Q?o6EEDipKxMgXVmLTRrhkrrvDmxCJtHTRvLiFmD1hVy+xyosVEiLpDHTVqhi3?=
 =?us-ascii?Q?YmgIk9trw6DG1YWFrHaUnIyFMio3zvbJWjNhKSdS62tQftHqojpSPr+GbZWU?=
 =?us-ascii?Q?FZnqdc0j+a0hymRSugdmqyOwndDNqr8hdRv3NoMdCeWEDniDDWCY7KtHRlWK?=
 =?us-ascii?Q?MFe2lRC/CtARvnONm34K3+LkAv7BfgAxnER+OOWZ0CLohoKilvskYCeN0bRQ?=
 =?us-ascii?Q?NczB4599WyIg2P04aq8JwGr/FomLXkoM3SHYn2HP28VXWzW1Xm9T9NCNK8vx?=
 =?us-ascii?Q?rDvPFIUJ3StbI4qmGDjVOlidLAJMdOn8YtDC3jaqVqCRiDcDVTZNOT1y3ZDX?=
 =?us-ascii?Q?dj4HjoQBtaEyeWGn5VpXkwhYQPlZLihsDz8TE2JjvZ8IEAOdbGNL4je/fOLC?=
 =?us-ascii?Q?5JBhM9G7WWzUxq1nFJ8Lmqnu16/YmhNHL6AgMZuqWglszy1GmTFMdmc/sjMq?=
 =?us-ascii?Q?5P0O3E1p82XUFQiaJpDekkiwkcG3kesyuO5cS8ydAsr//K+AuT1H5xMUsOW5?=
 =?us-ascii?Q?F5dn3d7+fO6Z8sXIeWMRFRKwOav170uVzT9PG8Shjd5UzeU61S88tOtpFenk?=
 =?us-ascii?Q?+792zvoaTf9SZC/ifLjrldXN+D3EPQwqQYrfNvYVgRBaaV+h6J+c1lX5lT1+?=
 =?us-ascii?Q?EorFFHJu34eXayZKNrqvZcf+llhRCiI4Bd/yDUHzjgRhlSXhRW3+zVt93Iuy?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c54cc13-28c0-450f-fae0-08dbcfb18c77
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:09:27.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52kwi2ZX0BXDeAh2pLv8s4m9733stXfWgf/WlcfhtGaWzyOBAWlu28b82P3vGfgRL6ztRso98A1KMC25buxq5ap0AuEoGdfQvXxD4w986DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5501
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:57:52PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > == Mutex to Semaphore change:
> >
> > Since it is expected that many threads will be accessing this data
> > during allocations, a mutex is not appropriate.
> 
> IIUC, this is a change for performance.  If so, please show some
> performance data.
>

This change will be dropped in v3 in favor of the existing
RCU mechanism in memory-tiers.c as pointed out by Matthew.

> > == Source-node relative weighting:
> >
> > 1. Set weights for DDR (tier4) and CXL(teir22) tiers.
> >    echo source_node:weight > /path/to/interleave_weight
> 
> If source_node is considered, why not consider target_node too?  On a
> system with only 1 tier (DRAM), do you want weighted interleaving among
> NUMA nodes?  If so, why tie weighted interleaving with memory tiers?
> Why not just introduce weighted interleaving for NUMA nodes?
>

The short answer: Practicality and ease-of-use.

The long answer: We have been discussing how to make this more flexible..

Personally, I agree with you.  If Task A is on Socket 0, the weight on
Socket 0 DRAM should not be the same as the weight on Socket 1 DRAM.
However, right now, DRAM nodes are lumped into the same tier together,
resulting in them having the same weight.

If you scrollback through the list, you'll find an RFC I posted for
set_mempolicy2 which implements weighted interleave in mm/mempolicy.
However, mm/mempolicy is extremely `current-centric` at the moment,
so that makes changing weights at runtime (in response to a hotplug
event, for example) very difficult.

I still think there is room to extend set_mempolicy to allow
task-defined weights to take preference over tier defined weights.

We have discussed adding the following features to memory-tiers:

1) breaking up tiers to allow 1 tier per node, as opposed to defaulting
   to lumping all nodes of a simlar quality into the same tier

2) enabling movemnet of nodes between tiers (for the purpose of
   reconfiguring due to hotplug and other situations)

For users that require fine-grained control over each individual node,
this would allow for weights to be applied per-node, because a
node=tier. For the majority of use cases, it would allow clumping of
nodes into tiers based on physical topology and performance class, and
then allow for the general weighting to apply.  This seems like the most
obvious use-case that a majority of users would use, and also the
easiest to set-up in the short term.

That said, there are probably 3 or 4 different ways/places to implement
this feature.  The question is what is the clear and obvious way?
I don't have a definitive answer for that, hence the RFC.

There are at least 5 proposals that i know of at the moment

1) mempolicy
2) memory-tiers
3) memory-block interleaving? (weighting among blocks inside a node)
   Maybe relevant if Dynamic Capacity devices arrive, but it seems
   like the wrong place to do this.
4) multi-device nodes (e.g. cxl create-region ... mem0 mem1...)
5) "just do it in hardware"

> > # Set tier4 weight from node 0 to 85
> > echo 0:85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
> > # Set tier4 weight from node 1 to 65
> > echo 1:65 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
> > # Set tier22 weight from node 0 to 15
> > echo 0:15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
> > # Set tier22 weight from node 1 to 10
> > echo 1:10 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
> 
> --
> Best Regards,
> Huang, Ying
