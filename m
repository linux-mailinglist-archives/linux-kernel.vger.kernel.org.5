Return-Path: <linux-kernel+bounces-22693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6DB82A1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97DFCB24584
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562B4EB25;
	Wed, 10 Jan 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Xq2SP551"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982B4E1DE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co7hrZdMKko9lXM562ipDSk4mL3SMUof3334320mBe2qywzWZMakw2b2dI7sE2Ts1pxqdJHHpoScijn8ALHTjxtz8OUHNtWgtlivAv+kFJTfn5+dT9j/lzbzuZn19c78BAapsP3I9TwDz93qtfHC94lAY9JrpAnzXzuW1lW3i4yziHpdhe8XUWGpvBPg/2S4BUYDA41b7G81Tv2KJrr88H/woi38xexWeruuwihC7DHZIVlhejFZR0Ui8gzYWpaf407gE2y/XVA4jpzB5I3SPuB4CoT8pDsbDuxmKWhmquSBU/aY2JAlIlHzWRLjyXIH5Cec79Dc7srlxk9ku8NHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WLoefbYMfOto6G2krwEAu9H0ADXD6Y/jfrOz/eQid0=;
 b=jv2Ngbuzcr8ZvYPd9uSrmO5+YRhIX/6CVDV0IYgoh8bN+y+/Vf+fUk6EMt/YqB3Ffscn6W3UarxLnU76n1luvvUIyKQzhJNDXoeKd/rhhI/nWTrUZL7lmt2rQ3nDL7dWo8qgslHtHcGQMBuVhmI5HP39L4zxWDdSCufGXHGF5Fk615S0H8Z7+iccMb18p/+AlSM5kRnYHDb6BuJK6iWeSbBYIky0lDikkysDsuYWxlRp57tgRzAc6XpF74HMdEKKkj/WfijC7mLSZfH+dvUb21n7kwjopWEpL/pRvg9IsUabbkHyUGZo/UY8zyhx6Tudy9OaRKqtSk62/KyfJ6lDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WLoefbYMfOto6G2krwEAu9H0ADXD6Y/jfrOz/eQid0=;
 b=Xq2SP551K0VGO+YRidiFIXSZ6lZ206LAoZQfRKF0SUz/IKCWviM+bogBSqE4HjqoKXFW02i8OgduMewcUXEqTrQO4RxBe2IrLhtCff4iE8ZJvxIXqB17CVQPuM69VnJ757e6BS7KilVpcvQqcncttTOLP/52eANOGGpNUMme5zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4443.namprd17.prod.outlook.com (2603:10b6:806:d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 20:12:02 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 20:12:02 +0000
Date: Wed, 10 Jan 2024 15:11:59 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZZ76DzVLGcOY0WmV@memverge.com>
Reply-To: Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZYSB3kUOjCSo28h@memverge.com>
X-ClientProxiedBy: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6007cc-e3e8-451b-e6ba-08dc121868c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GJT5NW+f12RgDTcUlfjE74t6cIyivVnpQTDcoaY2/tyHZVvd1EHO+VvK6aZeqU3IKRxkN3lpO7Is2/nxoe2jF3rpOrLDBpLJXFqFIiGNV4zaj+CqQVzamehgNJLTeqvlqXIxMw3VeJEymbmvP/m55XMizGu+P3vK5eCkL+zeMhDPDk1z2Ihw/ccmy2OXo7Er+NOfiFdDWUKCQ5NfjH7l2aNancsr4bKCQLrwNFXCXzM7mbYO6KOnsZX1N0IZycjvdsPoIDVrIqKt9pO2I1dQqpNVHZ5xaCo71qQuJQUARUQs0NtuSmjPtI0EOi+BjbDT6kyX4N6IP/ot9Rg7IE4DqStOXO/iU3o/F6OW9qoZoPyDyjQ2XMKBDH76YMuC946KxvbAHjRw6Q0ucJeigSIWkJoM90KFSCNmfj3ANItTUzS62Y8woqJvY718lQGdTVtsK2XKpompX/b0YYAdVJX/IbdHrhgr3x/kmduW+IO9jqCyK0JowIBfKDWl8+0QGprVtiIyc3I1q6IiruvmwDWUMV2dZuF/fSMnZEgLhuwbVTJZjizQAZx3JzPUxwDs3W7QpgQrQ1AOXZH9ral21nRLdp0sDbrzrAqrTJt4UIE/PMm5W8kKO9OWGXIq6j4VU6nZO4b32BiP8B3AZoFUipaaWqjeRESQHdAvujlrxoQuk3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6512007)(6506007)(2616005)(26005)(6666004)(86362001)(38100700002)(36756003)(41300700001)(44832011)(83380400001)(3450700001)(5660300002)(2906002)(4326008)(6486002)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(6916009)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QW+cs/tTmP8N5MTHYYQp2ZIec4uB5+yT/oS00FoPwPzNCO6nDgxmw6qXeMi?=
 =?us-ascii?Q?25BBqj1cqMG7HSrrD6zTozVCBg6OlJyVBrZE5VlElXkaNyvA/dW/JsDX6BQH?=
 =?us-ascii?Q?ftxcCShGmtM2EEpB7WA2PgezshGgTPsoJFxV/m8kQmUdpdglnUlK7N8CG7Fk?=
 =?us-ascii?Q?1g7NK/K8uMSZb4cXWuAP6JtMxLEJBZX5SUtgYAw9lqFy2w1Oskccl/BIQ5uR?=
 =?us-ascii?Q?QzQpLtpHHfqy8vPtOiOkJsoDapN6HhzEIDR1pvjvK1V5YKuuaZM8QUug9A9K?=
 =?us-ascii?Q?OzSBixlLwZCbIW5WQ4SC5TjpX+UOy9A4Z120rA6xwlD6GX4aWUTb5UKLc1Th?=
 =?us-ascii?Q?xpKwGBYFC2KIeRL7fgb26P7xA27gBw3Wke8O5DqO59nGwReJXmUOCLSrc2lI?=
 =?us-ascii?Q?Sc8ryhOy1HCq5z65sFBcuhctxagojH7JJcnEBs4OwPw1jM7gT5pqeR8hwqfM?=
 =?us-ascii?Q?8xNCTa9pyvUuNuPS2w/ZK/DSFTcQww7PCLcuIy1S+nnVSsRVHpRbwrcRv/3c?=
 =?us-ascii?Q?EjEK1+0xeOI2eVQCFciaNolMES8RuApBkXLp5d8VHXtmRok0GZsH4zXGhlf8?=
 =?us-ascii?Q?d5ulnjvRPDZ/qNjzp/W57r95vgzZlNgN5sJtjO5ORq0DMPgAPgzRw0gBec89?=
 =?us-ascii?Q?RKMsPoCenn+yHVIoNyBi1E64HhOFJ6U0fET4odzOocVOnfuczAy/5YhVO2Eb?=
 =?us-ascii?Q?p0E0xYLGsoTocxTYwP7egJ5wbEdHIA0ed8/X1pzenz4e/fHT0KVhUX5GBEQ1?=
 =?us-ascii?Q?CobiCCgX55xo8zEp9iEDI9aJCZOciLmamBF7D3Kiic6UFaWrBdUcJNdYiCp5?=
 =?us-ascii?Q?7mF6LuJRogcGpjW86p5o/RG1M1dXwozuUiju0uBgsq+QcgAyGundMamjtie8?=
 =?us-ascii?Q?nQLA57yH8a4IjXruBXc7xj+/0YD1FSJ8MxOn79lnRoUbo7jOwv2ekamqqSa7?=
 =?us-ascii?Q?dmSLw5jt8NI8bt9hAtGueYAP3HyHn6yQrqw/goH8JCuGofGf21j/G/9Izj1A?=
 =?us-ascii?Q?3odTDb9Oucu38pfifX1StDjieiPSI19XtEqkiheu/YSlZ6kxVyP4xx6297C+?=
 =?us-ascii?Q?o7nY6Yz2H5GoPDYmamtz6i5hFzWcHSP3vIijBrB4cxqr/hLTfjH4i0yJEohT?=
 =?us-ascii?Q?1OM1saPhSXWlb/HX89DmdFQhnmfjTxuvv73vkMox5zH5qpw8SwyGktnIqnMB?=
 =?us-ascii?Q?mVwadPcfWm2gBGjyR6rdiRmZGoKDev5/cVIs1fyp/dvAzBQWdqIDmr/jTK4f?=
 =?us-ascii?Q?/SWm+56W8YGPr3cn1/A1gQZakL+tfhismUWWmiGUa/IKqxgOxryCuYm0vOGM?=
 =?us-ascii?Q?UC7FKd7rtfsTPE2jzdLf0i10JmxlmSqG8w4zT5AFUzNogxSRTbvOjaERJ767?=
 =?us-ascii?Q?jWlWO9nz0qEqPcihGazEJNqWhzkTUudp9KFoko1xut4qEQ6kVYGH0JSEcGfP?=
 =?us-ascii?Q?FhzYjQ1QoWpGVSlTX+V/e+j5yxt+y1zR3Zkg3fm0HBT7pvCpibQ5vv7LIt/F?=
 =?us-ascii?Q?Nn8o0RmoKA4Cqu9OMAUoS+cLattOaLNEJjxFlbZv00UFQJQsYzKOFiZxAono?=
 =?us-ascii?Q?LKxiqnJc3WzXpM0KlK+nM1H29jpKBoUyCgASr53u2hAaNA8D6mYkPDmWS9WQ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6007cc-e3e8-451b-e6ba-08dc121868c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 20:12:02.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMdoKQZqRgYicDZcAFwWlLcMsI0qXLOk7FCQ+AlXqGW9wZl86Bk3LQs4UFokDQx3iLGdUOvn4pEBTBJceuA17TRmz0l6Y5s8n1R5UrMCOok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4443

On Wed, Jan 10, 2024 at 02:11:39PM -0500, Andi Kleen wrote:
> > Weighted interleave is a new interleave policy intended to make use
> > of heterogeneous memory environments appearing with CXL.
> >
> > To implement weighted interleave with task-local weights, we need
> > new syscalls capable of passing a weight array. This is the
> > justification for mempolicy2/mbind2 - which are designed to be
> > extensible to capture future policies as well.
>
> I might be late to the party here, but it's not clear to me you really
> need the redesigned system calls. set_mempolicy has one argument left
> so it can be enhanced with a new pointer dependending on a bit in mode.
> For mbind() it already uses all arguments, but it has a flags argument.
>
> But it's unclear to me if a fully flexible weight array is really
> needed here anyways. Can some common combinations be encoded in flags instead?
> I assume it's mainly about some nodes getting preference depending on
> some attribute
>

(apologize for the re-send, I had a delivery failure on the list, want
to make sure it gets captured).

This is actually something I haven't written out in the RFC that I
probably should have: I'm also trying to make it so that a mempolicy
can be described in its entirety with a single syscall.

This cannot be done with the existing interfaces.
(see: the existence of set_mempolicy_home_node).

Likewise you cannot fetch the entire mempolicy configuration with a
single get_mempolicy() call.  Certainly if task-local weights exist,
there's no room left to add that on either.

You'd really like to know that the policy you set is not changed between
calls to multiple interfaces. Right now, if you want to twiddle bits in
the mempolicy (like home_node), the syscall does: (*new = *old)+change.

That's... not great.

So I did consider extending set_mempolicy() to allow you to twiddle the
weight of a given node, but I was considering another proposal in the
process: process_set_mempolicy and process_mbind.

These interfaces were proposed to allow mempolicy to be changed by an
external task. (This is presently not possible).

That's basically how we got to this current iteration.


Re: fully flexible weight array in the task

At the end of the day, this is really about bandwidth distribution. For
a reasonable set of workloads, the system-global settings should be
sufficient.  However, it was at least recommended that we also explore
task-local weights along the way - so here we are.

I'm certainly open to changing this, or even just dropping the task-local
weight requirement entirely, but I did want to consider the other issues
(above) in the process so we don't design ourselves into a corner if we
have to go there anyway.

> So if you add such a attribute, perhaps configurable in sysfs, and
> then have flags like give weight + 1 on attribute, give weight + 2 on
> attribute give weight + 4 on attribute. If more are needed there are more bits.
> That would be a much more compact and simpler interface.
>
> For set_mempolicy either add a flags argument or encode in mode.
>
> It would also shrink the whole patchkit dramatically and be less risky.

I'm certainly not against this idea.  It is less flexible, but it does make
it simpler.  Another limitation, however, is that you have to make multiple
syscalls if you want to change the weights of multiple nodes.

I wanted to avoid that kind of ambiguity.

If we don't think the external changing interfaces are realistic, then this
is all moot, I'm down for whatever design is feasible.

>
> You perhaps underestimate the cost and risk of designing complex
> kernel interfaces, it all has to be hardened audited fuzzed deployed etc.
>

Definitely not under any crazy impression that something like this is a
quick process.  Just iterating as I go and gathering feedback (I think
we're on version 4 or 5 of this idea, and v7 of this patch line :]).

I fully expect the initial chunk of (MPOL_WEIGHTED_INTERLEAVE + sysfs)
will be a merge candidate long before the task-local weights will be,
if only because, as you said, it's a much simpler extension and less risky.

I appreciate the feedback, happy to keep hacking away,
~Gregory

