Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF8762E87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGZHrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGZHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:47:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2091.outbound.protection.outlook.com [40.107.244.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585A03C32;
        Wed, 26 Jul 2023 00:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1AOfbuM+7tKYDUxw4VlNM+ojMjV6t31vwZwgdPRRXSTK5aWMv+vsaas8n8/d6WFbhbjodgSzoRTwvl40UjQsYwbZQUZm1VeeUjT2j4x47cgI5/8nc2WsSueccFOkv4a4/7rC++fIRHKlqpktAPxrWWnbikKGO/RTjJiuQFewpTk7TGUhocNoemfPVt9zn/D5SKb8SKEfNu3P5QCQMNvtebgBaHnjMmwpYyzTAVgla5gdMvYvtxmtfF4M0il9T7oVpl36mWVJct/QU+Qgb4vOGzqxdV5RvCet9CHXBBxY5oASRkWKIoYUapB5iQ00NFlWCslkeWaXps5NqgwNRDWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfK5Mqei6tosDyVAsQotaEz4wVcJD/feM3nGjlxYb2I=;
 b=VIY07L9fsv0qOZOZme8UXK7A0yPHqw4b7tARcSl98oR4WPGC+xoThZjPOEHaw0hiRUn5wAWqIm+z49O4lvlcIbHAwTX+0safGbnW9EnYanLVsk8r3FgF/YdDQF37XF6W4rCjMX6dTsRYZCbILj5oXokQ6lowrCtM7VCGJZW8uixRMiFcp9qiCFsK35dMBImsw7oRz1eBDhdVl5PMCjLxWjcUGFIMDX8KKcHEEsQOq3P3kYDBt6K66VF5niMVjgDc1SrdZc4fJo4blvG0DM6m7EcfoHcRgK75RmxF0FdkpKmkTiuGCiHNz9FUR+uk8/VauisL+HtoSYmBLPk7eQJAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfK5Mqei6tosDyVAsQotaEz4wVcJD/feM3nGjlxYb2I=;
 b=tmdxW3C/nHnyH2gS5jvNQhisN7dCt5ywir0HBGZEOuuxP3msZ5us0Q3pfaGEzL5W4pVhw7mINmbzJyQtyfpJ5wOgkFzi7as/up9alkT1pGgZwc2D1htZLNV3J5jMPw/+xbxrujZnN7XIRzEV2ptjox3UdgYV/t3u8IAXi7oO3Ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6540.namprd13.prod.outlook.com (2603:10b6:510:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 07:42:25 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:42:25 +0000
Date:   Wed, 26 Jul 2023 09:42:17 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 03/10] net: ti:
 icssg-prueth: Add Firmware config and classification APIs.
Message-ID: <ZMDOWecss/9F+0nb@corigine.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
 <20230724112934.2637802-4-danishanwar@ti.com>
 <ZL94/L1RMlU5TiAb@corigine.com>
 <b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com>
 <ZL99WfF7iuzeMP78@corigine.com>
 <5a4b293f-7729-ee03-2432-cd49ff92d809@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4b293f-7729-ee03-2432-cd49ff92d809@ti.com>
X-ClientProxiedBy: AM8P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c11b621-5d7d-42ed-4c5a-08db8dabdab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSOM9dkACHaDuAH0Q9EHeJtKrenNEEvdW2qCmRvRK1b/JhRJ2Iwq6nnD6PVFGUqi7jAzzs1tBnt6Tme+/6x/j/N0GhDp5BhMHhujQITBRiU23rBOdc1Oq3lI4xKY1oH/mwO+fXv1GvXgPMJtTONl/C4VEUUTmCnRm6iy5voGC/VvLXM3V+R5rGE2p8VLbcCzLQqgWHduVe0PsbgGToJw33p/t0Bys4mM6DhTGlY4UFWz0Kef3OVMMBYZCnzvjPkKMIgaLmcpnzX7jVOMtWwzRlLqDulv05rQL7BIAfWjz6+CE0gaYPTweQjWhTWAzEw2U+nrnT005/ce2x0Wk8Kq4C2Pn0RsoytxTP7ley0kKtp1FtqIX6dyF7Wm+aIiMSR0gzXmPbRv8K7dY7Qk5kql0wX3ZQ6l/MUIHpeM3uWg0qoNK5nlvvNenFNs1ZstRAvqkdNq6CcHSRtMNMvkmyVJFvVLCycJQpSO1kAu5W0rvu4rXawxQkCRKDnXh1+4uMMq2w80e/0hiCKJ8h26cyLTU2DnmMz5L2R0OZJh8AoeqAcQmY8wZw4He3ONnp11DhK8wXf73Y9aPwXRgcRiT4MRuxfhWpWYjuXRX0VY5jPt2rQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(136003)(346002)(396003)(451199021)(36756003)(7416002)(44832011)(86362001)(2906002)(83380400001)(53546011)(186003)(6506007)(38100700002)(6512007)(6486002)(6666004)(54906003)(4326008)(66556008)(6916009)(316002)(66476007)(2616005)(8936002)(5660300002)(66946007)(41300700001)(478600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PzwdvUX0iNntN7rw0VidNvr5M1noN271byhhEPBUKAVDV9ZTZBAmq2rIKMKV?=
 =?us-ascii?Q?DGhdj3GbpnyLw9wSkohy75hbtZOpdGIGfxndRHlIYvZc/XFi9OKbO7i3gelB?=
 =?us-ascii?Q?ZgJn9Rg2Zv/ikE+0al95Oi3zjigJs7Fp7XS9gkyI5Gi4gZJHJBPUoQ3EXMvC?=
 =?us-ascii?Q?3txFpjYq1OAGB+Yao03oa6Qpl01yQ5fAgrS1fD6kVmjgY0U8wQDaHB+BhE6K?=
 =?us-ascii?Q?YjpU8aH7g7y7w53NZj4QW2vAK62HTwF7c5fy0CmTpIAwH4bL9JLh8RnPxktM?=
 =?us-ascii?Q?DAopyCJlYP96LR3/gzWnQBFh0gPcq5wgAE+G0lQ7aEskC48F4j28V1PQNR3g?=
 =?us-ascii?Q?NZ0V8PCfucwr6clt5fGIWiJ+93qIJNM8JptYSANVBfWjjc3g0dpz/fvsbgVt?=
 =?us-ascii?Q?dID6sZQyS90BIEAHTY4PltJnOWHYkzO/D/Tx1uIJUd0q2FdOFL4M0mBcai3t?=
 =?us-ascii?Q?5jFMgnSNoNjFroM+5wXpBKRahjAfDrFBuYmM2KxPBZXsG+TgoXs1fYl6f3+P?=
 =?us-ascii?Q?8IrBmumg9om47hBVqnz62xIMT1sFrLpxfgb83/w9tu/Rcf83CpUwXLMCNmxd?=
 =?us-ascii?Q?tKonKGlNLcbNJu/Lduma13M13GUFP9gGycwvPZsUP/HYXs0hwoAkU0bQnOUU?=
 =?us-ascii?Q?vYc1GoXNpStb/aqZr8HnZYuJEY2YimpqH6mFEzDldpjIyqRxzzZMbVuYtP63?=
 =?us-ascii?Q?KjicKF150cRfir2uqkNVlng5zyWGGo0KYdd2wu5R6/iVOg6ux2UwFWXVDrgk?=
 =?us-ascii?Q?e9GyCEwfX5ronw999NTFJau0jzfWF7d2itOSkiKg/f8O89FslHTFbIFXMS15?=
 =?us-ascii?Q?pFZWBiLzZpjFmnVJX9ujVcM/SRtvKYrmlVDbFE+Lre2VLLv37YF3/Jd56bEM?=
 =?us-ascii?Q?1p0D2kRnrHTn7J5b/l2K5hTf6NPgaJgFRCp+Qm7xhd94UmygwREVhxf3rMqc?=
 =?us-ascii?Q?nngXyQTwrV/qEbjqUDOBJ9R9fMfzGvvVGUb6raoPLl2Z5heSgpgHtqzvhuju?=
 =?us-ascii?Q?lLlPWRgFezgjAD3BZEAMiXXfgFHrrR+bfBV7tbOJa3hsJjH/HY8IoDzx1QXG?=
 =?us-ascii?Q?RuwqP9r+kKlhO6avSxHU9HfPcjlz9Kyo+9ZUf3bkKN2EEY1Ory/vF3dpT/DU?=
 =?us-ascii?Q?Lbh67jarvJRYMb3KUyGH5wIu7W79w1qL6wFuDB11b51giQehsVxq+oLbwEn4?=
 =?us-ascii?Q?gnfM2YWtQxp9MYGVvGbVJ++nYPG9bdbZUJOow9zAqNKdGAItN6EKFKdO6Vhy?=
 =?us-ascii?Q?+2BIhljfjO/Ws36aVG8K4Run+Ve6AjJmZDWoCikpqOTZe6fJWPqok7PrMT8p?=
 =?us-ascii?Q?/pjRDkuvGepNyCR0mAwYmZaI0Aa6sdpgehW7pypDzrqHhXwMKrk3LauoKZiS?=
 =?us-ascii?Q?X5neREUpDrLhtDRidx67mYLENy0vE62/zZfOTy4Eocf8HxIXBPjgRK18oKHZ?=
 =?us-ascii?Q?TLEAQk8/k04Z48qdU5KXyKR+4GHkE0fDk+jwP1dIsEHPOjurwchAzdseTdJj?=
 =?us-ascii?Q?aWKtxaopgJUT6VPwks//gpaRd3LgC+mFRQgllHdP2yY45S0BUh4i/w8+cjj5?=
 =?us-ascii?Q?McZQerDF3eOgjVaISIwIqikaueTL1rxokvGo70PsXwHhMXpV2g6WnKt33sJb?=
 =?us-ascii?Q?zOSHo2T81O5v7NeWXdICGyjirehzTl0XL+lfr3sSQkbL42b+45q9mc0cNh+D?=
 =?us-ascii?Q?Hhuh/w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c11b621-5d7d-42ed-4c5a-08db8dabdab6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:42:25.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8C33K5u8FiIccNCQpfaxNm904ebdPzBLuKauFfd5kPMOaxGUobyNuuRGc8XOK7x2pXpM3DMhIx+FxjMknt/LPeOmGzOa+pzTSzNhZGuRWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6540
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:28:21PM +0530, Md Danish Anwar wrote:
> On 25/07/23 1:14 pm, Simon Horman wrote:
> > On Tue, Jul 25, 2023 at 01:10:30PM +0530, Md Danish Anwar wrote:
> >> Hi Simon,
> >>
> >> On 25/07/23 12:55 pm, Simon Horman wrote:
> >>> On Mon, Jul 24, 2023 at 04:59:27PM +0530, MD Danish Anwar wrote:
> >>>> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
> >>>> configuration and classification related files. These will be used by
> >>>> ICSSG ethernet driver.
> >>>>
> >>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >>>
> >>> Hi Danish,
> >>>
> >>> some feedback from my side.
> >>>
> >>
> >> Thanks for the feedback.
> >>
> >>> ...
> >>>
> >>>> diff --git a/drivers/net/ethernet/ti/icssg_classifier.c b/drivers/net/ethernet/ti/icssg_classifier.c
> >>>
> >>> ...
> >>>
> >>>> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
> >>>
> >>> This function appears to be unused.
> >>> Perhaps it would be better placed in a later patch?
> >>>
> >>> Or perhaps not, if it makes it hard to split up the patches nicely.
> >>> In which case, perhaps the __maybe_unused annotation could be added,
> >>> temporarily.
> >>>
> >>
> >> Due to splitting the patch into 8-9 patches, I had to introduce these helper
> >> APIs earlier. All these APIs are helper APIs, they will be used in patch 6
> >> (Introduce ICSSG Prueth driver).
> >>
> >> I had this concern that some APIs which will be used later but introduced
> >> earlier can create some warnings, before splitting the patches.
> >>
> >> I had raised this concern in [1] and asked Jakub if it would be OK to introduce
> >> these APIs earlier. Jakub said it would be fine [2], so I went ahead with this
> >> approach.
> >>
> >> It will make very hard to break patches if these APIs are introduced and used
> >> in same patch.
> > 
> > Thanks, I understand.
> > 
> > In that case my suggestion is to, temporarily, add __maybe_unused,
> > which will allow static analysis tools to work more cleanly over the
> > series. It is just a suggestion, not a hard requirement.
> > 
> > Probably something along those lines applies to all the
> > review I provided in my previous email. Please use your discretion here.
> 
> For now I think I will leave it as it is. Let reviewers review all other
> patches. Let's see if there are any other comments on all the patches in this
> series. If there are any more comments on other patches, then while re-spinning
> next revision I will keep this in mind and try to add __maybe_unused tags in
> all APIs that are used later.

Sure, that sounds reasonable.

> The idea behind splitting the patches was to get them reviewed individually as
> it is quite difficult to get one big patch reviewed as explained by Jakub. And
> these warnings were expected. If there are any other comments on this series, I
> will try to address all of them together in next revision.

Yes, I understand.
Thanks for splitting things up into multiple patches.
I know that is a lot of work. But it is very helpful.

> Meanwhile, Please let me know if you have any comments on other patches
> in this series.

Will do, but I nothing to add at this time.
