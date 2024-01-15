Return-Path: <linux-kernel+bounces-26399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9562B82E019
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E25E28583C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FB518AEA;
	Mon, 15 Jan 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rl2YebhD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2226.outbound.protection.outlook.com [52.100.173.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485A18644
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+4zaUfVIK6Ar3Do/Uk67tPAJ7MT4k/IIgpeojlwdApfv2dMqhjegkjkKbB3M8wh4m/DHmz5yoJydEanb6doy29I/9gd7zY5zAEwltlfSWiPCRnx+YZFqdaVepDDU/nsKTmEB5W6c4Guz1Huzf1zFcBi6lV/VZRskjZaNXobpfeugClV4pvYdpjQIEwHl2zhs+lRcrEFUiWHUHVPhqyC/TjwJoJY+afPiPVT3PRdvnOmSSk+TaUSF6mjFIEPe7VGrp/aYT3RpYOvMgL1O2ZjC1X+80rRdsYsuwrl/Ami69x5/tgsyZB6GIsIK6SueSP7tL2Zf1iGvWWQfLj7XrKhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7/hbPBVHC9OGfhPtyanthvgnWbt0Jf8HvmEKTnAQJQ=;
 b=kRy3PjegrX0FZKSMUvCqwjKH6uZo5oQkVWJY37zNhPVppNe4X1qRtwA9vKQpjViJFKw911PdiZeXIynFXt/mRCZ8smonL31v6fW3HktdaNbzErW4Yd2NbD4RiUkLxNYJH1PHKm2mcgGpUAnZT3w4a6LaZh8RjyyuQ3EW2lO+CWF3I/hhi6RTiwkxTmafE7dOUcOy60MUIm9Q+RUJ8BLAAEIlU8zxHij9fV2vUOZm5lMfGw7eDURnmbNtxkqlY259x4Y3tt68Knb6oN+d1CJZfO2RJiYhJkq9cozhXPyvIF10lOpd6EjoEwRkgEx8rY6FZE9qt2y65bkNV2HqOUeFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7/hbPBVHC9OGfhPtyanthvgnWbt0Jf8HvmEKTnAQJQ=;
 b=Rl2YebhDyg3S06E6re0szhPo7p/q+mueOpge9Lh3h3vXqwlEYJ/6KTVnPFvU+dpbNseK3gmh7+gw6cgcyeirowQKhXy+HtkBvj+n1Up3x058jY4SPasKhAovltcWBJ+uKVkWOPzR0UlkqfKFnnhF8KhkUiNCHPzl08i12dUrZBp5j6IJcH5DSLYzcyt4uYmya164u1ahUgywvk4wsOEev5FbHMlhlpmepDmKvmUrasMMbrup1pbW1xaJazR7UUOL576uK0sR2lIVI082Da3mvEQv0ZNaYflIKZIytjKa24GKIQRF/HhQM4CvcREmgEAGGNyjASkG+Uzghe7jll0PJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 18:38:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 18:38:15 +0000
Date: Mon, 15 Jan 2024 14:38:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>, linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Jones <andrew.jones@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 07/13] mm/gup: Refactor record_subpages() to find 1st
 small page
Message-ID: <20240115183814.GS734935@nvidia.com>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-8-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103091423.400294-8-peterx@redhat.com>
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 99683257-a1d7-44c5-21a1-08dc15f92287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mYcREuzdCZfjB13vIWeG1cYTT0NGWavEP+OfAYw2+KsilukVwEKlWI0OeQKL?=
 =?us-ascii?Q?uJBAKz6yjCI+vdjLbenl80dDgbfufkAgbYoFPwBvj6Rrij1v10ZzcxcX8lc2?=
 =?us-ascii?Q?UphcE/87eja6ARIadnTGTePWh05q7fekho27DS3pTc5H8jz2TX042WWH9+Zr?=
 =?us-ascii?Q?bM2oNvNO72GtKIsSQlhfL6m9G++L8uyzErKxF4wrgSiGwBMg02fRVB3TcUQa?=
 =?us-ascii?Q?+nXTaBFC14tG5UdAP3dnRmXxtwOh4kcLI3ZbqsMMsxa8cahoFPH6bclqtg9X?=
 =?us-ascii?Q?tIinUnu0mLTy/yNhH6JWC4I4+1fLOe2kcTyd7ICExScfd1iQ9Ls3kqHR/USE?=
 =?us-ascii?Q?F130nmJYc5J9gNl1v40tfqqaxtrmIR8k/s8W+elCuWqvTR0RAATyk3J3I2kH?=
 =?us-ascii?Q?ucdEN41blG/ZxijKsSjN7NzKJnr4FzPofCFO4WogwUCzI1Yp7y0RGmjQH0GT?=
 =?us-ascii?Q?LE5q2cokdk+Sj0EBJ+pq7QBmo8JiQrQCphgguBgdDIUZA1PoonNfXoQ7oOm3?=
 =?us-ascii?Q?U/1VqJRC+L4CuZ7sDTDy0elQOpagFKjPJ9IbSKdpSyd9p2T8NLLoroLbqUWb?=
 =?us-ascii?Q?RPvveoSPnWFTHQdtTBXwJd4QxdQEiwJ+ohrnmD3GeEJy+KzCHKbQJsT0SgfU?=
 =?us-ascii?Q?5+F6fS7SbAwwr7rPV2IJQ0WgSzNx7jF4MmfKPz6Ai0LB6aXC/sK4R1plVy7T?=
 =?us-ascii?Q?oZn5/RLBFTgpFGf9WP77fHUjs7VKw/4Y2ZuP9rJ3Fhzb9vKxly5qMLfnhQY+?=
 =?us-ascii?Q?cfVDcPVs1KkcuinKb1A92LBD6FZHjpar9yXKHUFzqWmxB7h2J/UGZLEXx33g?=
 =?us-ascii?Q?/9JU1WvlS4VeueHKZq/dHtvoauMeDjGyOxvGK+Cfd83pQBN+Iwgj/jp8Yegt?=
 =?us-ascii?Q?nkLj1lC8cco5wLBycI2aiZyNc2gGkZZKEOdIv8uqNCVNXrnaig1gx6qLvKJn?=
 =?us-ascii?Q?Rm88sNXBVA1ASYuhQjl9ZXbSUYmVwJvNAQAsYTk10Jz1hFNNCYt0YWAh7nJ2?=
 =?us-ascii?Q?hfsStKfdEds/s7oOdN/wXrbenQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(83380400001)(6506007)(66556008)(6512007)(26005)(478600001)(1076003)(38100700002)(4326008)(2616005)(5660300002)(8936002)(7416002)(4744005)(6916009)(54906003)(8676002)(66476007)(6486002)(2906002)(316002)(33656002)(36756003)(86362001)(41300700001)(27376004)(37363002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qG9dqY9op9CmAUH/TIN9XB5pjS2yrYSTq6yqzafXqZa2fKZZYUU9rH75GlM0?=
 =?us-ascii?Q?lOqZYyNH4XUJlF+dYcZdQ/9WgyGvjR1s46Bb5fcAqSMNDXHri6Z5J8dEXgTo?=
 =?us-ascii?Q?ADa0xmNAAQFkZH3ceOE6Ebj2NkMV+R3dXlyATNloYDmaTjYX+XWuPdEXvE76?=
 =?us-ascii?Q?5xawQeQ1ymGDRQbQzNpc0YtMIZXh/0BM/nEnroGiAXlCXkyO8nEsSA/ZrJXN?=
 =?us-ascii?Q?ShBeVAPKO84TpfebXpgvW8oAuU+az6mYBdpvDc++CuHLf1gu4bi7trDzHgMa?=
 =?us-ascii?Q?ths/8zCeUdUs+RfF5qr/H91ZY4jTyrAPbJe8s1W1EvMSF5jtJ7x16V9yCnqW?=
 =?us-ascii?Q?bGNamYankbuyB6yPCuNQSOyncgSYeRETImr3TRjD01B4q7meIkJJAFUfxOSb?=
 =?us-ascii?Q?TSiPVkDbyWUM5ISZgErYaBXqVCD4H2kOIJNeF6ULJW0yIu7inpEqPAEGaqIm?=
 =?us-ascii?Q?JLQRTeQA/ra0qLNQ0YHo/7hRJnqa0AeOzhwDeEuq21DxGb28CwZ5SOdd0pS5?=
 =?us-ascii?Q?fWobKCirg3gH0ihTPGvhQBnqYLDubLZAd+wl8GGlnMGeMQs7OZXqEr8Obe3T?=
 =?us-ascii?Q?lAp4j3VIzMLORaTMPUn8WAHO3ucFZHDqUr0guiQaar1MbhZ2NUR6hkxihZ+k?=
 =?us-ascii?Q?DQPii/NtnM62G3ze7/2a3DTYWXDbco96sZRB7dk1wdfzRD3d56zIf9ziZz0I?=
 =?us-ascii?Q?4LReQsTXaTchlex3EMQbWhAmw6CCaFpEJWEV4pKDpV3kqEQ2+a9h+vTpkfR6?=
 =?us-ascii?Q?P0HvnNYPw89uPGy+wLOMtyZjh51Pk/mmtIZii7xQvWZDlaCsivcu4PQe6pF3?=
 =?us-ascii?Q?t3mVDF6XZZBpfrvJqoII3D4k8ZLpNeZYYv0SR/Tt97YRUjc2XHKXhkmYjw0g?=
 =?us-ascii?Q?Mfees3OWvVxzqpRlnxXFmv21FUGSn3pG4rDAHkzp8oYG9WkZUSFK/w9cPXQ2?=
 =?us-ascii?Q?A+TAGNwmBGqGvDSp6JFlcY4dtjkN7p5Fd6Q6iOyufPCs/o8AbQs7hvk83P5P?=
 =?us-ascii?Q?VA430ewijonmZVh9FSSW2QORjdnoV/J54cgSP60qBCmU6pONzTgvGiKxzp/n?=
 =?us-ascii?Q?WoE7CAsx3SmZ9jZdzuTGUaKNbD+W51I/Xl+Ao1GZZnKciOsMOsO5mOOisF7H?=
 =?us-ascii?Q?WR7eNxvIKuPgGj/H3L1/YJb8CiQS8u9Pmn9QoJO5tRFsOqaJHZEiPk30i86E?=
 =?us-ascii?Q?NK5Srq6oUmUzBVgWEoPOmFu9fX0lMmfVSI7LWVx1K5J9w4RxVcw149aleqs2?=
 =?us-ascii?Q?2TbUdjYVTP3MvQvqH/ld6r3xdaMQzTC+nvq2vRqEF1DBd0h6EunvWJLsRqAj?=
 =?us-ascii?Q?YwAKwNQBVcBf6dnIHN143u8WhsImqXkCnbRq9qAF4OxUP3dMLj0ZZyc36QE/?=
 =?us-ascii?Q?1rKQA5ei6b0vmpxGzfHFGo0tkZDnhi133xlho4yLGiYSgER35B0aaXu5V+/y?=
 =?us-ascii?Q?Lp4aF6BfMez47ok2iktJ+xAnhIA5ErlAornp/UAadwjPKc+AsBPLglHYV+Gj?=
 =?us-ascii?Q?iMJZ75R4qWCiOK5YrdDtQYCUUY9g4omy8bcze7H6Np6MjS1k/ZWp1kxJfKob?=
 =?us-ascii?Q?jxcleCuYXbAFK4F1kjWznb71bEw29WaOcpkkz6Il?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99683257-a1d7-44c5-21a1-08dc15f92287
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 18:38:15.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3Pa0nJB7662OhoKvuC0NcS0efX/TSnv1rJdKUDcm+0wbVmUXCX92rmqnSVwdeE3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

On Wed, Jan 03, 2024 at 05:14:17PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> All the fast-gup functions take a tail page to operate, always need to do
> page mask calculations before feeding that into record_subpages().
> 
> Merge that logic into record_subpages(), so that it will do the nth_page()
> calculation.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

