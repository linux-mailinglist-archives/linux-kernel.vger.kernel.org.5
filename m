Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648027A6AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjISS4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjISS4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:56:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62BE1;
        Tue, 19 Sep 2023 11:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEEcQs7fSsgvn83o8oOJwRGBUb9Wk8xJGbQsfKgny2wsoIbF6lROt4hd6kJ/O9LUZ2kIyJ+b4tkneYDWuIWuOclFgppvM33wC5njeH9acJ+V9gHYHD5UKrohderusC4Efe+b3qiZBuGZCfW/TMnL/BLTB5Fi166B4GQuJMWi/f3hkoE5iYseMB+j/Ahgc0JV8iS6DxHHlR1RRZMTGVn6c7qlOlqgaDudw1ifpZ0zJNjHOpD4UNcVVAtzKS2slIRJYg7o85hQPAkxb7XrkM2O4i556VInnXO9MhWdH4ITPL1YXoynsjm6HB/Cpw+0GYvQI6CjYjuHrhQuJc4v67qfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlhNZAtbmqtVVwaD9Optr7RbcBXrRtDCBWAOxQ8QF8k=;
 b=Ht5jgTJSKpNEaeCjKaD7uu9RGu/4D58eYBu2z/Yg1uqC68YHFRpA6QNCAOAwJNI5gV/bM8vhnWyCSoQTSzv/R3iFlj2Ep/eN24YdPOkzjr3Lqts/YSTs1Ygdyl2jrBE0QPypqOpRXXV6Dziabvb5M2y7WaI75hk1haqazdcqIfS11OgmVGnmysuAupEdGXWp8GumO5tFwB00VbhDsfpYb0exp5rbiXGV5R2yhXd1Rbib40fuXwZuRu5qXbm3ne2Qpy+Zoda6gQippwgROV/R77Il36hPg+Hv1aKywKPrqL0BoNUJGf+upEAdpjGDMUho0dzDKJb5ZVM/RFRxMQs0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlhNZAtbmqtVVwaD9Optr7RbcBXrRtDCBWAOxQ8QF8k=;
 b=FP1p6Vmxn+L1dg/AmeupNGpfVRcxQmlMuA4DYOHsSJfq2ZgtDm6eMr8DqBhx4GyXmuB02/hOmlhEqC0bPzlXrExAVQQceXvQxJ9BfSGyAIj1xWDuTwnjos6C+hYj8AoIgEhBGC7FpV8mx0sKO7Gok81NMYJE+qTc3mBGz7LdRKkQyExy79OpDFqzBjeFtDkrpNFiyGS9QXf0ZDNsozAhV2UnNgYas5Qx54unLb2lSx5h5rfr/TYGoSgJ35ngeSdkKRzfY1Z1SsQ1LAp7fF++vjoOIohW0um9HPHtUEbdRGr9jdOUMy5EkftkDardt5KqprPHtFTuw8EO9jUlNXEn7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 18:55:48 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::95aa:442f:2a27:7cd0]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::95aa:442f:2a27:7cd0%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 18:55:48 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     "Nabil S. Alramli" <dev@nalramli.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, saeed@kernel.org,
        kuba@kernel.org, davem@davemloft.net, tariqt@nvidia.com,
        linux-kernel@vger.kernel.org, leon@kernel.org, jdamato@fastly.com,
        sbhogavilli@fastly.com, nalramli@fastly.com
Subject: Re: [net-next RFC v2 0/4] mlx5: support per queue coalesce settings
References: <ZOemz1HLp95aGXXQ@x130> <20230918222955.2066-1-dev@nalramli.com>
Date:   Tue, 19 Sep 2023 11:55:36 -0700
In-Reply-To: <20230918222955.2066-1-dev@nalramli.com> (Nabil S. Alramli's
        message of "Mon, 18 Sep 2023 18:29:51 -0400")
Message-ID: <87ttrq802f.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 728c5d07-d85a-4df9-0159-08dbb942096b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRlxDsZcuLK8hL9gIzOV1EONK5Hxo3LBkNB8rM+OEqT98vAqsG5hQruDWm82UzIyIjGaHakSBCAeXv3y3cT0E9A7BTa4iHssJ+HcK2E2VU1drTGFC5UwQTI0hqbQHxXAeojlZTZGZOTHu0+jlsSQxci+ykQXaQTWlI/46kXN0n63HlHU/Ltzmu8f55hIM9/QYu7n2TH9O+p4ybVMwUTjGyF3EO6CKQKByw4aPFgaR/9qgtcuYzwY2ZG8YF7xQUItmTjRDgqwUkvfMt/1cVxOoXJYg9KakK9mPOZ/ep5YMV2Xdy1+7W0vzEPpiMTEWMY6jNDUlr1Pr/0CXArJV4LfVeV2J4U6lwo37wCh60WXzgZvl+Gwz/ljWWjxGOVMMIue9Ed4Xgv5M2a8tFIGr1cXCzFBs0g4bJRYB5xnd81QdqRXtgxEgBkEbGei+najX9Hch7oVb+ziLDGAh3Vh9ADOdfF6Np+7VYkmWP6i88Exh94MvUCfTsD0OUvj76Ydlo4Z7D0KpgPa/TlaNYfgVDweq6f5MLElE3Bokb5yQ5fm0FUD4JLpccUBMfyidfItySM1oKzDPWHKys9PYM7jElbkcDpq5PQX9IYdzzNNi5WfbEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(6506007)(6486002)(6666004)(86362001)(38100700002)(36756003)(8676002)(2616005)(26005)(2906002)(6512007)(966005)(478600001)(83380400001)(8936002)(4326008)(6916009)(41300700001)(66476007)(5660300002)(66556008)(316002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FPpainht6aMGJ6HZeldWKR9ECWWrJ+SJ7wpcrxvV986odaqolAxKxkuGssam?=
 =?us-ascii?Q?2t03pgqF1edsIWGphTal78O6Y7qdFDACINfDbEv8Ynqa8IDQW18wql/qxd+N?=
 =?us-ascii?Q?jht0jnR9bcn4P8trQed3ut5vpZxoWqKtqSRUyNKKRtfWkB5JrbgTz7WwuU6t?=
 =?us-ascii?Q?t328pxPfeOvgRsiXAHQ2iqVCyM2w3jpYBee9ppoW3IB6LLHx+pA83Gi0lbuf?=
 =?us-ascii?Q?OVSQvS6qs22oj/PyLSG3RLOUcvFIoS7Lgo8vRG/2WdmSE8aRe8oJa7dnoCX4?=
 =?us-ascii?Q?HypCQHYnpfARx+tNgMICRB+q/9A7+u14cN48j0EeVndrzTa66TX9XKhtxEzz?=
 =?us-ascii?Q?A1y6N8kStdLuV42LyGWTycXQbBD533lkajDdO7BIXGiihZBbper9TaXOfzMe?=
 =?us-ascii?Q?9mCz72nxFRIuW5+UrdZbIBwZT/5uxhCJimeHi5uR3n3SZ2v0/TeTeyfuI7L7?=
 =?us-ascii?Q?SU6T2D+Vu8bmlvv8D6LkQPHzkGWpxbuxjkybEcAbVrKtCkfwovyzgxycxrsC?=
 =?us-ascii?Q?GxFAEC2cBnCQn1deLGqdLcxPgc6V4w7Sbil3wCOFzgOt8C+pQBqGAUDJJ6Ya?=
 =?us-ascii?Q?56JJBIqUQyBvtBRADdMTeObCMbFBuNnyldEwTLJp/cdfMf1rVz2BvlqmHvy0?=
 =?us-ascii?Q?CUwcVxO3VBrrX0RKwr2fT2OA0u5dSPg62l0lhMe57ecQ9HNhxeFSJAu6azj9?=
 =?us-ascii?Q?NFAN7+BTAt+/w9LNEeODlPfUqDJBI0sFjMjm8P92/OIhdcnkYLZBCjdaZpst?=
 =?us-ascii?Q?SR0+/S6nAriFCbdojhP+0JKvLb6BLEo6hWc+tMN1wza1duA32RNwX3U3cNFo?=
 =?us-ascii?Q?afazH14Az4lVdJRCeiwStlfhdbxLiORBaJw6p0udEEMYSQQqJy/pBPdRNeOH?=
 =?us-ascii?Q?/gFbA03GYOr66Y0DbQt1Jl1RePYjjPMUlk3fM36TTAXRobWnFpPgTsLvO1ix?=
 =?us-ascii?Q?RNUCFfyVfg07MAZJoFFKUS/kXzJywQiFzhqfmNGoCkzE+2PQ6OQwW/XvuX9x?=
 =?us-ascii?Q?3CXcxe9to/N1HPF1ISp0D+Fa3lPOObUJFadJ2XdwwjuaXEmOJkPddqrCn7bg?=
 =?us-ascii?Q?XYPi3DVKZBsrlznq/pJn4J6DFllY0JNnNoAXupCwlCt2GqnxjKZItxbo0lqg?=
 =?us-ascii?Q?wq7+y/ngjqr/6tPZ5JO9woBzIPKHJvMr72xr1MhPFQiCirLY+uFK8AL7Hw93?=
 =?us-ascii?Q?Xy/QR5+GEYFQW5qBx2gAsFfobyinwr2C8K6xWCKAIeaKBf16aUui0p2p0FS/?=
 =?us-ascii?Q?8PY8C4PijXsl6480zPLzL0WAzQxE5oAdq1nyPuecH7TOzd6RKPTQHOfizGNM?=
 =?us-ascii?Q?4rWu7SBAHbPTxe90rxy8r++pGKyunLvK2uQGbK7BG0Kw6RPxamltQOp4Hsst?=
 =?us-ascii?Q?zR6yMvrwt2ilwC/Z8LqQ26WUswO81net5orLHWmWaGB9b1Hk8+P3yu6yUMRu?=
 =?us-ascii?Q?TFZRG08JgkoHzvJOGpdWekku17ojlgBZlO9omkzvPKu1GMPK5uWwnDf1we2+?=
 =?us-ascii?Q?qHdJJA+tK0wf9mhhlIhtDLppphujus+K23J9c5w2gsBaFa8uFaigDuuIoFX0?=
 =?us-ascii?Q?IRykFM3QFJ6fJJOGSstyY0dIPRzHGjstiHcs90J81gBypt+E4qkz1DQ+JO6k?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728c5d07-d85a-4df9-0159-08dbb942096b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 18:55:48.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjR8Hz8C+CrgzNJtm17W/t0Xd3kUTa42UqwAgp8Fj8NNmVxi3AqtMpDOB4+V+jPPKDtWYYSDRmAGMPlgwqiNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nabil,

On Mon, 18 Sep, 2023 18:29:51 -0400 "Nabil S. Alramli" <dev@nalramli.com> wrote:
> Hello,
>
> This is v2 of my previous patch:
> https://lore.kernel.org/lkml/20230823223121.58676-1-dev@nalramli.com/.
>
> Saeed: Thanks for reviewing v1. I made significant changes to support
> per-channel DIM settings. Is this ready for an official v1 submission or
> are there other major changes you'd like to see before I do that?
>
> ***************************************************************************
> Version History
> ---------------
> * v1: Initial draft, individual channel DIM changes not supported.
> * v2: Support individual channel DIM changes.
> ***************************************************************************

We actually began working on a patch set for the feature internally
inspired by your initial RFC. If it is alright with you, would it be ok
to have you as a co-author of that series that we should have prepared
in the coming days? We have some minor enhancements that we think will
improve the general architecture for how we handle both the global and
per-queue settings.

>
> Currently, only gobal coalescing configuration queries or changes are
> supported in the `mlx5` driver. However, per-queue operations are not, and
> result in `EOPNOTSUPP` errors when attempted with `ethtool`. This patch
> adds support for per-queue coalesce operations.
>
> Here's an example use case:
>
> - A mlx5 NIC is configured with 8 queues, each queue has its IRQ pinned to
>   a unique CPU.
> - Two custom RSS contexts are created: context 1 and context 2. Each
>   context has a different set of queues where flows are distributed. For
>   example, context 1 may distribute flows to queues 0-3, and context 2 may
>   distribute flows to queues 4-7.
> - A series of ntuple filters are installed which direct matching flows to
>   RSS contexts. For example, perhaps port 80 is directed to context 1 and
>   port 443 to context 2.
> - Applications which receive network data associated with either context
>   are pinned to the CPUs where the queues in the matching context have
>   their IRQs pinned to maximize locality.
>
> The apps themselves, however, may have different requirements on latency vs
> CPU usage and so setting the per queue IRQ coalesce values would be very
> helpful.
>
> This patch would support this. In v1 DIM mode changes could only be changed
> NIC-wide. However, in this iteration, DIM mode changes are supported
> globally as well as on a per-queue basis.
>
> Here's an example:
>
> ```
> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
> Queue: 2
> Adaptive RX: on  TX: on
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 8
> rx-frames: 128
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 8
> tx-frames: 128
> tx-usecs-irq: 0
> tx-frames-irq: 0
> ```
>
> Now, let's try to set adaptive-rx off rx-usecs 16 for queue 2:
>
> ```
> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce adaptive-rx off
> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce rx-usecs 16
> ```
>
> Confirm that the operation succeeded:
>
> ```
> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
> Queue: 2
> Adaptive RX: off  TX: on
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 16
> rx-frames: 32
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 8
> tx-frames: 128
> tx-usecs-irq: 0
> tx-frames-irq: 0
> ```
>
> The individual channel settings do not overwrite the global ones. However
> Setting the global parameters will also reset all of the individual channel
> options. For example, after we set the options for queue 2, we'll see that
> the global options remain unchanged:
> ```
> $ sudo ethtool --show-coalesce eth0
> Coalesce parameters for eth0:
> Adaptive RX: on  TX: on
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 8
> rx-frames: 128
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 16
> tx-frames: 32
> tx-usecs-irq: 0
> tx-frames-irq: 0
> ```
>
> But then if we set them, we'll see that the options for queue 2 have been
> reset as well:
> ```
> $ sudo ethtool --coalesce eth0 adaptive-tx off
>
> $ sudo ethtool --show-coalesce eth0
> Coalesce parameters for eth0:
> Adaptive RX: on  TX: off
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 8
> rx-frames: 128
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 16
> tx-frames: 32
> tx-usecs-irq: 0
> tx-frames-irq: 0
>
> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
> Queue: 2
> Adaptive RX: on  TX: off
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 8
> rx-frames: 128
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 16
> tx-frames: 32
> tx-usecs-irq: 0
> tx-frames-irq: 0
> ```
>
> Previously a global `struct mlx5e_params` stored the options in
> `struct mlx5e_priv.channels.params`. That was preserved, but a channel-
> specific instance was added as well, in `struct mlx5e_channel.params`.
>
> Best Regards,
>
> ***************************************************************************
>
> Nabil S. Alramli (4):
>   mlx5: Add mlx5e_param to individual mlx5e_channel and preserve them
>     through mlx5e_open_channels()
>   mlx5: Add queue number parameter to mlx5e_safe_switch_params()

We currently are working on a variation of this without needing to use
mlx5e_safe_switch_params for updating individual channel states (our
variation of the feature avoids needing to place an instance of
mlx5e_params per channel).

>   mlx5: Implement mlx5e_ethtool_{get,set}_per_queue_coalesce() to
>     support per-queue operations
>   mlx5: Add {get,set}_per_queue_coalesce()
>
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
>  .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |   2 +-
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 214 +++++++++++++-----
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  76 +++++--
>  .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |   2 +-
>  5 files changed, 222 insertions(+), 78 deletions(-)

--
Thanks,

Rahul Rameshbabu
