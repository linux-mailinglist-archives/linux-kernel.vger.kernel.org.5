Return-Path: <linux-kernel+bounces-27369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF182EECB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B7E1C2320F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1051BC25;
	Tue, 16 Jan 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Th8sIBBv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503081B944;
	Tue, 16 Jan 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USXYMK5iWpQPOjR7H61oyqU4mlKuiFCRUjKczijWV2Xv9gUR4WSS7UaoVUzFnez/HDlQvobWuTz8u/3t0qY2SqL6ujAmYtTcM06CdJtE4B8tAF6mkmuypz+LXmni146IScecTlz7d0wAUbCTWBvT+xUL7Sj2iCuqWVK7etILk8zSJ5N9WTPbZgu798wSznn9ZlmMxs5yaBTAT2M91CGL4atbgiD/yiRGYu4OXpfQNUjhk/lxyj8xuFbarKreCvDgnDXmlWB0YwkBKh72qPutgXlbrIKpcTGvrrMfXzwyZrgQkXIIxYjEZY/q3iRHkt6v11zmrCeVzdEhH/Fkqp28pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAf+5D1fu/XTFqXZW1ylZ/gCZcvqn5DY65aBXODH4Y0=;
 b=OFTrzyFtV0OBuYpdPlcFkrPOeHRlr/sdet1aY+w6uIMcpD5uRu7LO0NGuKrSuTmmSocObmgSxiqUwGkvfD7Z4TiZ2kLqdAnTL8JlVOrO6HqBsXdslNK7jOfKIEtW3S8vC/4KFF+PUTzSYptDe0DbWIf9yJP3rtOnObj+lAzLDmAX+rFRlVQDCM6+/Zthu5t1H3FduG5XHBMSb3S+84TRMASQObysowVXD0s+O2ZikdXYakpddEEyDXAr9WwIC+4qJLaT3BFU9AsOB3wCl0RFC+Okd/L38JphkXn5yL1qNQ6naSAepkaM5VMdW1isNrnKIVD2bqOJMu9i7yCtmEABIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAf+5D1fu/XTFqXZW1ylZ/gCZcvqn5DY65aBXODH4Y0=;
 b=Th8sIBBvfGJu1zEEgzRTkwXpKbXTYrKyBSv2eqi9U+NwQwwhrCQEFaqqTVowhgsIj2iyiv5c7+CK0+WF+j0inua/ld5O+4m1tiMU9lQgHY/A0cVZ1+wkjMX/GAevWzq5spNHtYxtGmDMrWE/Qb45V/ZArPXpqwr85IsPY2rCV0T+Qm+y9GxK07rw7c+qoc40BwOjQV6OF2s5as3ks2pFkB/vH5ODWUJwAo6JyBqxD7uxidJvXGDbopJAHysm7VQ5/rM4CMAcCtyk/O51LN1W6gYTxAfYF4hRwKOSO6eyuC7SuXZ2F3LZtr7SgFoBulUiZrOON0Pu4BiQwnxCfGJwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 12:16:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 12:16:12 +0000
Date: Tue, 16 Jan 2024 08:16:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Shakeel Butt <shakeelb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
Message-ID: <20240116121611.GY734935@nvidia.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
 <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
 <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
 <20240116000129.GX734935@nvidia.com>
 <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: ce765626-33cd-4943-dd57-08dc168cedeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h7IcwKden+yL1d6GEb6PXSNCkY2vAjNTXYZOUri0QLsIrDumpWZMxKOs0g4aiYLdvG1XwusMP0E4+Ksx26pu/dJaZfVli2UzT7pYq3bigBK74xwCJXdeZ/Gwqey4ng/6XsmnTISNmi2C+RItgX4E0439UY8qDXCf9NuWSPO79O74c+SGtQ/e0kZJeinzDz8LInSApDZ3pK2G3seObk68hsGFDvTDJXHPDyxnzP+632orBM38dmJ+0Aj5nfn31GfuF9cHvkZfdJnXENtuLUF9pvdz5jJsEn/SIHKWW8NY9TweFjYCtwH/5DyeUccXDopEj6VJClTAB6v1wq9w9uhPQaA3j1rXMaX0AQVhe50DySMq1b5z33RDxvAFQwHa1jKZzqm0ukKQbYkxRcUJoThk2HHjhmqlUnK1A1odiKb40iJnXUxo9N9p1/mAA+xMJ/2J87Ksy12jHTeZVX0Z2B8d2qXg0i+Cj8lz4QL1YMaCkmcg8FIo8gOD5uHTjxNgclaaUbWAvzVQqZeujB4oDhpDy9SpAeN4ozdmACsUagEJ4xq/BOidNNKYNid61Auz/sjIpjtfCz0vL69cmYCSPYVkKrYiFVjl8SH/oKM4LgyFThpsO+ocWtuHV/h51G2tTvt+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(33656002)(53546011)(26005)(2616005)(478600001)(1076003)(6512007)(5660300002)(38100700002)(86362001)(36756003)(41300700001)(66946007)(83380400001)(7416002)(2906002)(4326008)(8936002)(66556008)(6916009)(6486002)(316002)(66476007)(54906003)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ybCN4ESvJEolQQM1MBMWaVR5ASfu1Ume5ANDojGflElDbx1qfvs79QhjHKX?=
 =?us-ascii?Q?8cp1aXqhZWj74Gyi7utjiJ5onF2zsPzqsplPsPwaJm9H8SEFpgFh/3BiKfp1?=
 =?us-ascii?Q?K7uvTpY9Y9/Atd8CvWxRTOppUotdMsHJBmdfdGu7m3mGFbzv5NnXiKKrRjLX?=
 =?us-ascii?Q?yEpQeDeoe0LfcqD8LkIajfW0vmG4nwk890mCErXmUsAJ4OS5kKKw0E0s2CVf?=
 =?us-ascii?Q?bvIkqlSKcupq69x71nIIRB8LP+4r+A10muSwPH0PUvxlSF4e1sgVsRo37oFp?=
 =?us-ascii?Q?bizJuef2j8awT2IZN76ApshdQauMOGA9FWpUHu7YAG2dfvcwjaZuMKWz+7Kb?=
 =?us-ascii?Q?LUUkCruqqmyKjW4A8frY08SxNSFH7znIvNEPy6y1N4yydKHhaRaVn3Cr+8JX?=
 =?us-ascii?Q?9c63VvMfXFeNePzKuj+8MBvtesKffEbkcd6agVC0UVp9s2dj9uGPVDJLihnz?=
 =?us-ascii?Q?zFWinxMuZtm1dE0SNNL9oeP7R7XbKLk589TiJDM8wXVSCUmzPB8ybr1Q1iJ3?=
 =?us-ascii?Q?I3qFg5VjHYJdIOq3igscSPj9bZxJyDSBF9bnr35pfowcZrBp0SgbQSBcGWBY?=
 =?us-ascii?Q?PGFWg/0/YcevayMJrs9+S8wG36OBVc2lZp+QHClzgPJWIgmLlJ767gJ2bgpH?=
 =?us-ascii?Q?UvnuelfdGAFCbYHCUQIJsVj95LdAbgyQRJZEBPDUUQzwsfKCBa+ZVkXup9nE?=
 =?us-ascii?Q?r9pCoBImWK+gHKnwppcKU+ztqYuYKikFvk6ZEU+TgwSBGBeXveUYHAJ5eWlB?=
 =?us-ascii?Q?/72XOK0h6PTWWcV+xOv/lcyXCxgQDV+j0Mj67yIF+9I5krsIssB2mZuboopI?=
 =?us-ascii?Q?5z2JTcxlTr4wn6Fbzc7zT1TUXHPsq5xXdzR3iqjEHAfuRcRbd8Fqzz+aycFR?=
 =?us-ascii?Q?HKr7qKJG8QcGOmqRBxf6ndEgHYEMJc/19Mzbi1a3d5UJfn8VW0Eqi/U8AHZr?=
 =?us-ascii?Q?/xEOR7/pseStOH16Xlroqf04tKkeFaNkVFIh3fOabtaSoMb+drxqrPRi/x0s?=
 =?us-ascii?Q?UcbobGWeCgVSY+Dy3gbQiJ7mgpynquxEyoEH4GB5kKDXErVcSrjVNV58Ck2v?=
 =?us-ascii?Q?jDoBYdT/sI7zdwfuG9RdEX3cLDe44RSVks9U/LViSrr2ELRfF/HPUQqBoEmp?=
 =?us-ascii?Q?5KU7lTiMOmE82Z8NLSm3aCqvBpsj7Gbs6DWO4zvRhcYAaeplvU/xrS5lbXq+?=
 =?us-ascii?Q?KSY8PvzmFj9jeHhy3tLAny7MMGBD/CXtBdO1l2rwehwSOioNu0H7oM6XOHRn?=
 =?us-ascii?Q?xSQrka8Rc5mxgjOM5DPCCBDfaRP4W5PfBx2MYD9uzCadpVbzfXdB+QjZstiW?=
 =?us-ascii?Q?PuxcFAFLe2IFlWrOArRrEG/1sO08F8XKDjoJ/RcC3quveJfi9QT82Mmmq3FM?=
 =?us-ascii?Q?W7DG9qUDijbpZcOuAx6KLp57qjFxjhcIDM4rxvQkrir7W5HXSY0cuCPqqoMJ?=
 =?us-ascii?Q?hoOVVj++pEzbTjD9zjkq390pTlD76a2tx3rZJnApuvXAHdg2nSy88ef167P9?=
 =?us-ascii?Q?6t7/3bYtkvOFNHQQ7K4gHlVMlxdAOqK8x/UFPr7qb2cqoGVeElrTY/RCZcVs?=
 =?us-ascii?Q?GZDIZv3+OG8AGdbhbMIwXBVMfAx4xTXQPpWKi2L3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce765626-33cd-4943-dd57-08dc168cedeb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 12:16:12.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysi1jYzSFjReI6xHC3WF9P0WOadl2nzklmfE4uO06bOSGUahImeK3/Kk6lhGGZlL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526

On Tue, Jan 16, 2024 at 07:04:13PM +0800, Yunsheng Lin wrote:
> On 2024/1/16 8:01, Jason Gunthorpe wrote:
> > On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
> >>>> You did not answer my question that I asked here, and ignoring this
> >>>> question is preventing us from making any forward progress on this
> >>>> discussion. What do you expect or want skb_frag_page() to do when
> >>>> there is no page in the frag?
> >>>
> >>> I would expect it to do nothing.
> >>
> >> I don't understand. skb_frag_page() with an empty implementation just
> >> results in a compiler error as the function needs to return a page
> >> pointer. Do you actually expect skb_frag_page() to unconditionally
> >> cast frag->netmem to a page pointer? That was explained as
> >> unacceptable over and over again by Jason and Christian as it risks
> >> casting devmem to page; completely unacceptable and will get nacked.
> >> Do you have a suggestion of what skb_frag_page() should do that will
> >> not get nacked by mm?
> > 
> > WARN_ON and return NULL seems reasonable?
> 
> While I am agreed that it may be a nightmare to debug the case of passing
> a false page into the mm system, but I am not sure what's the point of
> returning NULL to caller if the caller is not expecting or handling
> the

You have to return something and NULL will largely reliably crash the
thread. The WARN_ON explains in detail why your thread just crashed.

> NULL returning[for example, most of mm API called by the networking does not
> seems to handling NULL as input page], isn't the NULL returning will make
> the kernel panic anyway? Doesn't it make more sense to just add a BUG_ON()
> depending on some configuration like CONFIG_DEBUG_NET or CONFIG_DEVMEM?
> As returning NULL seems to be causing a confusion for the caller of
> skb_frag_page() as whether to or how to handle the NULL returning case.

Possibly, though Linus doesn't like BUG_ON on principle..

I think the bigger challenge is convincing people that this devmem
stuff doesn't just open a bunch of holes in the kernel where userspace
can crash it.

The fact you all are debating what to do with skb_frag_page() suggests
to me there isn't confidence...

Jason

