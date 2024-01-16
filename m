Return-Path: <linux-kernel+bounces-26612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53982E428
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302851F22A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E004C2F29;
	Tue, 16 Jan 2024 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibhGvPpf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588C385;
	Tue, 16 Jan 2024 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDZq/FdGsmemRnW5TEMnvE9Q40a6oqaz8xB9fQSJL463CGA0b1DIgU2E9XSp0HNAKQke46bnqxiEv45ROnqtMLQXeGOYwGyvG13RIxIqQNEeLPaCb9X283wRk88bXIMy560jkiHZdijrJvU80kWyfOrKaiuhRNLU9spWwLN6SEbA5VX7WAaVO+y1OGJldq/wNB7dT+z+0mnh+JayHUuEMQdgSHTLDheM6/ue3edhHoi30cU6pMwGzqXt4j64RyV/D93C8BM35GKIjj/R3lmI4pLY5O4oolMzyAppEgfYFIjYuYouc8AB8JgY1AJket+hMPmUWP1g3WplPh6W5t4I9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHCglo/YLube/SYCajMoG/pwxBS4nNeYArZ574qNgwc=;
 b=dckgA+zKAVHEtIyxB1IGN85rE66GdP4AQlZkZqgQIpCfuDVxUn6pVozlG6QXv25x45AtX7ydM8xOH3ZEBwm89a9WjpDIxUIEpFCqxDxswA6lFqfxTyRzxBzH6UqUgZzY7szRxpqEVFozFrzMacDQKhRqJK03malir6Kd+JkyLiEho9+T0HnCzsBb6Ueq9a/mANup+/TMesdlrRou+h3dabfKzQZG7X0sU+yWFEug+PqUzO20jB5GGa22Kfy/IQOyNkIYhY5QtE3l1V+Yc1bPrWlm9ZxtYs7+UlCnzWf3l2IEKCqaEXJkjf/164Zy395HNv0e5u8atsRRhJy9qIYQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHCglo/YLube/SYCajMoG/pwxBS4nNeYArZ574qNgwc=;
 b=ibhGvPpfDMuRpd0oqbgkDTnnJ9STN7ieNx6otC6+ufLvCtTSNuZOAunX5hQyW2RIdC3WJkWA1SEwDHlKF3B+OVfrrErw2uSU2bB2RAHHcbuUE8XJ9DNk9YbuoCZlQkuRHPYTEuzdUKJG5nL9XLMB28UG+uH/mz/w94dwbx810/z7OrPBlNCSk6IWIrnNKzS/fUpBhAvWg1mzbgvr+gC37k2gMc4BNEBxpdGOdacOiKjegFdnjd9Z+uKn861Ah3T95mRk2utI0IUWbxedm1OC2j/a0P5h65V59YKx8dwPgP1fjXzsuCVoGBbWdriyjocwSu9Ubx9bDPT++mbqWfKCIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 00:01:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 00:01:31 +0000
Date: Mon, 15 Jan 2024 20:01:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Shakeel Butt <shakeelb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
Message-ID: <20240116000129.GX734935@nvidia.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
 <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
 <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
X-ClientProxiedBy: MN2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:208:15e::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c15cb5-9944-4efb-76e9-08dc16264b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3yIoc2N2lpJ3IFzV8jL5mdtMN/tPHDJIwvCpoq9Quci35R6idHTIARk8DfzpLNnfjG8Sq+CtO1lrer9O4BJAOhbyrJWwNfOQx+G8mXytUPC5col8CZkeUyNa13IyyiO58pc0mRyippeniJ+B6bsKq8j7DqZzUWxWbBVhtuNzGN2J3tvWQmh39ZgO1OmjJ1YrvlK7DfXScxEfqHUSwtwFT+zs0HK0cbX0x5r/Q7uUB9/YpvM/SHnGIqbBuDADAcDqGmRjzYQOtD3/QVeDppBBL+GriqeTLIWsYnQsBodzE7Z0TTii6Gy1yXg406wcyvXb7PzcfH/RoglAMOVa89k3/mIOYLMf7afGLKgwJWDwC3p+g1lKHfCOI1ONuobkoyXIrZRjTQdvFRIFW/CwJMi3bLjXLnP93mKscWfvJU/Jny0nEcVEEjQl6eyjZN5XvzYdXR0DSHewAZ+hrvfDYk2v92HjNa0eTWXUSUKsND9MqP8uqozC5UA2UflZ3hl4YxnlZc13R/ieL9KGgvdGvUEdWiNuadNoL2Ncyul5zzbUIbyNCZHSRXehk9q62hNVrEAC7ItdvVUSkyY5t8Rb6ORIy23neQfX3YV043+EkfnyhKyNt04WEAtNCIQb8gr+yDmW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(86362001)(33656002)(36756003)(6506007)(5660300002)(8676002)(4326008)(83380400001)(66946007)(7416002)(2616005)(1076003)(26005)(478600001)(54906003)(6512007)(6916009)(66476007)(6486002)(316002)(66556008)(2906002)(4744005)(8936002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Shc1x6YHab21Z4iQyIKqelzAFfyGrC6HUjGvhDGCjnqxl9+7bU+n09wsNpK2?=
 =?us-ascii?Q?fEInFY6puASxYhtJSX/v2m8DVLRey1u9Rzmn5nFPG532t7/lXOSe755xjGkC?=
 =?us-ascii?Q?r/UNfudlbbviFzeTlS3bgCdEkzvJSezc7xaxyK+el+ikKg2/zkB9XI9WKduD?=
 =?us-ascii?Q?g660KwK0UMzGU7kFv6rs5UjAszYNYaNlmv6UlVCOQyUTbPVoUGyCqaJllVJ2?=
 =?us-ascii?Q?qNElZEZEwIU6tpoViD2XtbFO2JunSBnLhAz23+84fka/XLyRNRMsYYBIGaq5?=
 =?us-ascii?Q?qycu+zi8aPWnY4/fSB0wgxR51CEVyZuj0pSqFYmLH/Wbg8XUo0GtWyBQCBMR?=
 =?us-ascii?Q?0UIUwgGk0X15fcq45qWXh/SPy23dHybZXNf8IkQfT5FGNJxZ+ORgYlslldwW?=
 =?us-ascii?Q?GQf+oFHIQfqG8kQoRjZTJUBU3fNiGnU8wBcbn62tYF4+lvXPckDm28Wl3F/T?=
 =?us-ascii?Q?YAo44+/jWpO0X+NVB8AwrUGuQO6tDP4/lnRAZ4wfYnjgzDmzWcf6pt3p3jHo?=
 =?us-ascii?Q?s5a7NUYfEFMB1YwcRI7elVHIWQDhFb0eifHBr8gx6lrYpVZ8P8vrmeE0WPkH?=
 =?us-ascii?Q?cnZYnxNvjuxvjGhIypgvf14EpZfsNUnG+vPzfGywKfixZw0S6jN7l0BFusAP?=
 =?us-ascii?Q?swVaomPXwTM1qGFleOePTQ/SL33TI+U7P/lrb9bZuB007qUTVdn141WQ0Y5V?=
 =?us-ascii?Q?ymSl6RCWXaDfbeCZO9ETGziAjzCuwfum06vbPNdPB4MJrOrvggxBQuTy7Dy1?=
 =?us-ascii?Q?sR8joqf9GH6MWit5FnAumg9Q/4K7P4SBm4nPd6+rN8EuMwLczSjILmjiaOoj?=
 =?us-ascii?Q?GGqsNWmB/hbKJzqrRA71vFpYIIfMW5EKUm0iGsRDyEtR3KBlBBvMfG1iJgBO?=
 =?us-ascii?Q?JqJygPFGCIouJ4+fqMxrqhCIBjn4k+j3l8V2c85XcGcC4AGGNSETOYphyTA8?=
 =?us-ascii?Q?ps1MjOuEjv76T7vW94DConZ5lkL1UFfyj4QSSCCQMxG5NWDzhewLTWpZP4MF?=
 =?us-ascii?Q?3hLSqvTS42oXwUrTiCT+vuJInF96agrMZlF8Mrln7ejazWRIO5MUEkuhEj5I?=
 =?us-ascii?Q?4FHboDFUMWE7atItzHHmt43fyPe4sFmcjypydtVPZ7M2YA5vRNBxurELiurq?=
 =?us-ascii?Q?EkK7BeoviKyyqhoa2OgboS+XxcBsCeScTHkvUg6+5mJK/2Wu7uc6sVcxod5v?=
 =?us-ascii?Q?OeyCBtjRCzcRi29hWswlrwwP6H1/K+GjWwgA/xvuaGYoMAPwJbzCIWhwZXm1?=
 =?us-ascii?Q?VDR4pu2LdNczIZHZG5Mg+GMhyQoVCCBxV/y2r50P+XWWJ/2o8fVPRMRHmma2?=
 =?us-ascii?Q?1U08ffnNIV+L5HahVzzcAaK3FOPBkZVeN23l6YnA2HOEnQHrUzhQ/buoFHH7?=
 =?us-ascii?Q?k8fp+23zxpDRsbCzMxrbje3h2tOxh1orX0xYMRK6oxlE3/OiZvYDhv2061fh?=
 =?us-ascii?Q?J2qW43RE9qD9zrLZrZt3xnsLgkyAfBtvodnPbo+xkC4i0BNaDMzINC8IVHM8?=
 =?us-ascii?Q?NoUxosIJZMyvTb9OJnRBGK4rhhlLWt0WugqhZcQ9uhScbTt4etT1Bz4gVhYf?=
 =?us-ascii?Q?ThAmWgfil89qPVfqT6oekZAUrJ2NrE/YQOk9DSWf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c15cb5-9944-4efb-76e9-08dc16264b75
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 00:01:31.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6ttT+3nMoiPZkdv/TsdWykXLaweuwg7vV0Lw+tcQaOZz6K0WsKsIUZjGoKuwWVH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
> > > You did not answer my question that I asked here, and ignoring this
> > > question is preventing us from making any forward progress on this
> > > discussion. What do you expect or want skb_frag_page() to do when
> > > there is no page in the frag?
> >
> > I would expect it to do nothing.
> 
> I don't understand. skb_frag_page() with an empty implementation just
> results in a compiler error as the function needs to return a page
> pointer. Do you actually expect skb_frag_page() to unconditionally
> cast frag->netmem to a page pointer? That was explained as
> unacceptable over and over again by Jason and Christian as it risks
> casting devmem to page; completely unacceptable and will get nacked.
> Do you have a suggestion of what skb_frag_page() should do that will
> not get nacked by mm?

WARN_ON and return NULL seems reasonable?

Jason

