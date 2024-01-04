Return-Path: <linux-kernel+bounces-16714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B48242D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6DDB212D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2CE22337;
	Thu,  4 Jan 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GV10Xjne"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA72232E;
	Thu,  4 Jan 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/4mI0obpgPCfUyjCrCeTFAW8FIA9VTy7QFtFXYluMZ/iLrSOiPZg0WEvGRuRzHtzBT+NX+jEzRmy/U2hp+iHvYQlqXJpWwRWC/8Ml0lvmewNirj9Bew9hdEkTOJZcCvOvooXqXSgGKjWTZMt+9iPE9N8QUkJFv7Ay19Gw8umzJTIVgvCWidgRPdNM+xm2Rpv7HiUcNUIYD9VsrlrHt2q2MAgL2E2vQj4YMgixOE3so0nzczvvbmd01Mra55lAKhNs+ERnFgUt8OvrLTQupNyrLdJyFBrz1M3yZHNourktiLm+cAQ9rTeGfwVo9ZVRK2qNsoiE2BQttvzH9B+9tkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2eaFHQ70lU8AKmYZJzEro0RtOux318vRyRxAP1gJOk=;
 b=mHD8Yolp8vtMqpBI21sr/drgcwTZLpEev4mI0C4gCRAEsJrC8JcQO/Hc5FlfBcWvdwZ6nA1xRz26E7jKognsUmcbe+CTnBwoL0nZllrQ6uJHEdZ7d7ofTNxHvNj7EYAVqQfVSrlfsF6dJUhTGOa3YU4YRrmbYib72b+rsIB/+LaZZ8tZiDoyOrepCzUzAGc5jI8Zw4Q6VqdIHujRvFSSCuQzDceBoQyR/SpxdrqRz3azmLO8LhWqowVlVOYb/p64GgagNmCYzOVSHhmHZjF+p8V8Evgxffqggj9DhK4yyOrDCzEfPjwNGhHIG1cWHZah1LeVGP0/Lo/jpqPLn34Fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2eaFHQ70lU8AKmYZJzEro0RtOux318vRyRxAP1gJOk=;
 b=GV10XjneFoKiNu3AeYGwB11fjdCuapb98fe7cgPtn44WBc0tyHrtExoRpB9ZweWzdukTv0uotmSv+mejUFnMGC5sSt3CYxwkhwkcvOVfrSxKugb+SmSjScGKh3nU4OB2NJkctnVGQi5TWe6cuMzcv07h7Qta3eXHrLO0aBYliXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 13:43:29 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:43:29 +0000
Date: Thu, 4 Jan 2024 14:43:23 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fan Ni <nifan.cxl@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <ZZa1-11632f6CckT@rric.localdomain>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
 <657bd741d2961_269bd294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657bd741d2961_269bd294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 49de766a-83c3-4171-39de-08dc0d2b227e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C8alWrvibIMM6wgXeClth5z5CBVxSEOfsnF1Nx7Vze6BYqfE8Y62fyuZYkAtGJn00RkgqOp2NA6qP6IrNdX2nnDh/jOWMXNZqtpQlCHz7TOyN+828U7irfrqRHquZ668L8vXMBS9gL7i1A52yr76v3xyl87bCIfD3lct95PeEWmUO5LZVTaLRoAziaiBjzv6h9aYqMzrXtyLtEEL3ccvFuhY56a5ufHkqUu5XLd0NtI9UMPH9qbll4SIjfXA0QZCCR/M/W0k9xPJM+dbL0u9ZGcUOQ4Qswd2IzXB2uBiTAPgORqevL+GSRXU24KjcPA2avDl+doaXnx2z/j8PU1SFmJWZkqBuJ4BPSQGb4NUlwVasFh95N1ZgO7u0HhUUgjW2vRR5DIYVZvIacFguIMvgUxOtfqH/0/DGxl206CgeXZ7H8zHY3i7L6mqZEuSutzw+H4SdBpQZ//o1uOXe+t7KV34VBW29nsg5mLdXv5wLkYe69NqA2MQWmQ1ZxHL7UqkCtrd9WRUqMyhHLLwBxuuIS5FYli7wjhibzZP3MtkDS8SkjlgZsnVCciRoSJ9Eh1uJHejXhzVwDqEdA1NraUdEFgA3xt9VjYjhC4azdBrXTvnHqsI5eLMlKqZNSVYdc9ay3ijn7ruMY3jNb8fdMvEjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(54906003)(66556008)(6916009)(66946007)(66476007)(8676002)(4326008)(8936002)(53546011)(9686003)(6512007)(6506007)(6666004)(6486002)(478600001)(41300700001)(2906002)(5660300002)(4744005)(7416002)(38100700002)(26005)(83380400001)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYIMF377hacjKLsdaPsRmFDVFp7ljWrVnkIAp721gbxzHdbUhbXGB2WpAN8K?=
 =?us-ascii?Q?y/f4+5x9OjebU+SH1URv5WLm0j3W/6aW61rNeqzaFbopx7vjt+qhnJugr5uC?=
 =?us-ascii?Q?Dnb/AMiltJJZFYDun6DkShjEmEGW6B6StyMXhKqAU53jSU93/x0xDxWm4HDN?=
 =?us-ascii?Q?qpGz3PFwbmx8Vu1G42lGJgwn3pVcv+toXRfd8v3yKTCWRHwlmFXaMbeBiDOU?=
 =?us-ascii?Q?ouwt4N7X1GBo0+QD2BsnIhgto3iWzIjyBpQ0Tpgznzft78olsiyU4yNx24J3?=
 =?us-ascii?Q?g13o8QztjwHDG6awcqBjwwU7bZM00VRroa9UzOYX6i9QVNQ/8iDyXQqx/7PE?=
 =?us-ascii?Q?bYR6FFhKyVuht0CEgQMVM1FG/NbGjwCtS5wVQwig0u/XIx2bdhxe/NIy+A3b?=
 =?us-ascii?Q?VroTn6F6wozLNlp8fezSMougeRWdzhHuP9dKXV/XRND6+TCv3QM+Hgw1FmCa?=
 =?us-ascii?Q?XBbt9yWF5IpPtBOXWI4zngd0WWiLxaesXuwro/lqronRmRoDjKF3C39hZTdQ?=
 =?us-ascii?Q?9nN92wMpFPmV4Wi7p+ik5D9cyz885JI4KsPQn0OQs2k1qd1XiXuRZGFUEbTA?=
 =?us-ascii?Q?ou92n6OyCNRUDzbZh3cGOt359OinEKPdZNmVte8MjuYH63IvzJP6xYCsROtm?=
 =?us-ascii?Q?rJiHA1+Ch4bMF7jtR6FISG1Ox3rQNmLHPHVMImXPhxdwBiHCFevSGxO/0j6a?=
 =?us-ascii?Q?KFKVzkGyZKQEBwOzJhJJDoNyDSpDLLhKlD1dAMg9gjIxNmJ11kPwWVu6jnha?=
 =?us-ascii?Q?81PQdw9/N3blvIDqzrmgIlvgFQWEKMMAqjKU6fLRY/XVyOxXbAl8AtvFPkcb?=
 =?us-ascii?Q?CFEjGKWwkDrfMzhqHa8O4paVLFnpDYc99XFvW7XwoE2sjyfk8/T6WHBvz2+4?=
 =?us-ascii?Q?oVt4RniCTs0vMh34PNLCp48K/BxihF1ys4Zh6keDr9GXcogoX53qHOWYl/BP?=
 =?us-ascii?Q?G6N+8NektolF4XtDr9S/yeTMwwTCJZYtyWqjYYtSu/eJAXLVhKFkKDs22YwV?=
 =?us-ascii?Q?VlazFO75ExCggdDKuWLr6fuNoUnTHOy5u0Tvx4B5SbJ6utovumFyM9Cp7YCL?=
 =?us-ascii?Q?DDkE5JcHXTz8+H13G6Fxg33qmmJacTqBdC03mml1EgyQFjqhfCJ/ypr61zVg?=
 =?us-ascii?Q?hJgjW37Zo8V/3Q8M1w5DyCh+qSzcxq5oMH6spCf9I7+Ard4UPgZCplii1YKn?=
 =?us-ascii?Q?4X5x84B2eHOoW87ZS4SiW4MFc4bhr9yFRtnmYpOn4oPEpIHY1UO2IfkhjaXb?=
 =?us-ascii?Q?BtvYshzkMC9T6+TVsywJY4UD8BEOG+fhgyief8gYM1k4ifhvyp2XpWs72Gzw?=
 =?us-ascii?Q?eYwESHeabxjvqkV6q+Hr/LGU0uojbhH9o7nAxyIBfxcVrrrsNLw1XIkV732d?=
 =?us-ascii?Q?DiYOfH0Ba0u5JpVTgG/QXPiqBiRlAA5GRhtl/zPOpJ1xk2nRkmBw89SJw2E/?=
 =?us-ascii?Q?ZSw+vb6BwpXnxLM4lyvX2IqwtHN6fnkemZR8D7fFWFTqoLQx4eY/i3/CPtzt?=
 =?us-ascii?Q?Iixa+/j9aQoFwwPDMSZ/oihBhx8Smx0e+tHPt/AQHG4VnzIfiaGud6/XGQt2?=
 =?us-ascii?Q?OY9NAnpLp5qBg6/VzHRpXfRlkPcUVgBsWB9R5NTN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49de766a-83c3-4171-39de-08dc0d2b227e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:43:29.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xPbcvwf8SIZmF40hKQwAOVvneGYI9BHLKUERky7FF8bqfdZJN3/mVjDi68ltdUcfM9RtaiElB6Bs5+35S7Vbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360

On 14.12.23 20:34:09, Dan Williams wrote:

> struct cdat_response {
>        __le32 doe_header;
>        union {
>                struct cdat_header header;
>                struct cdat_entry_header entry;
>                u8 table[];
>        };
> } __packed;
> 
> As far as I can see nothing outside of drivers/cxl/core/pci.c needs
> 'struct cdat_response', so it can stay local to this C file.

I moved that close to cdat_header and cdat_entry_header which is also
defined in cxlpci.h but only used in core/pci.c. I would like to keep
them together but we could move that completely into pci.c in a
separate patch?

Thanks,

-Robert

