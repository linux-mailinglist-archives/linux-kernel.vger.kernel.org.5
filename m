Return-Path: <linux-kernel+bounces-6382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF0819819
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD90BB221E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523B15484;
	Wed, 20 Dec 2023 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+/BeCI1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC914A8E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1PGQifq5CdrKvNitDdopuv4djwwGq+jifFNoNWJNfDriXLN65rlGb4ZoNlREWkuuhpGatA6j6DUuGE9ni5s0Kz/acqiygiaUY6bFfEddexB7FJtMTG7UXc2d05kMqIzRVMC46XmdvZTJpBz7r8BdL3EWHGSqGn2TmgXBOsx5ADYXyUp7/9lioMmn9EngVTtt1UMRAvmcs2Gsevxisu+4DQH8d91WThXmMUJnY7WHq6LbU5MfSmxvEG8hRqC51uHb7me+AjdDVKsSi0vYNDhodj/iIg3kQMcjJWNBQk+7uotN2N/Pvdv+j68lFDfIk/Df0LuDZ6/Ng/9DoAoua+ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kfsQYCNQ7XNaDBPfx4N3Tktjqysti7t0/Tldy7rsBI=;
 b=gIrPYz43JIj+MbqT5MYjtfXEKJ0LOywvyB8RPdR47KEkem9Wk5wKeAfyHxhewwLKb/BJLHOM22qA3bA3Nsd7oDKtmyKh3bEa9AfveHSG6Yll0gizmpUZ1iTqtU5TiC/F9nPdEax8qPALmmdhDOk3bvULMxJM9QxTghtap6OS2OU3nRlTJbUJRdGgO4rR6TyScF8MBfabn5V4Nt4d1gKOm+nNM/URToec0RBiAucM6KcW08DSb1UgchSPuhyZXEdSkVLXf26Iy0+UNX555Jqg4paSvcedGNlM5+FOJNDU+Yc8vE22gJseVXuFsXP+xYOGBMtrS/vTVGiOueSH8WCBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kfsQYCNQ7XNaDBPfx4N3Tktjqysti7t0/Tldy7rsBI=;
 b=L+/BeCI1h+t/QSIK90nQ9UAWvZX5qniasyGH+Sfzp5rIY6JTPH4l7nP25R5kl2Fa8jQa2AXEVpnKYFK/W+GBPAc619qi3RwWkc/rbYVvXq9QWBC1D2RlI1R/RFwFRpInCQJ+wunTtLx4QqxZZx3xSRSb1HNf/ypLqM27IHsFEGeZRB+XTduvXCW560y53EAcGluu2emV4ZJL/Rrfa118o7lZ3L1dBKiHqoEkK2l9i98MbUVbyM10dOCXKoHzYjfiICPQ1aGACAf9LKJtzLOhKNU6WM5gHDJUw1ebcofqAS9FDnBQulwwDIhQrNb1WNCKMlo1W5Uphze26wcs0kSaug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 05:28:03 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5fef:7167:36e:76cd]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5fef:7167:36e:76cd%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 05:28:03 +0000
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-4-ryan.roberts@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui
 Yu <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Matthew Wilcox <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Mark Rutland <mark.rutland@arm.com>, David
 Hildenbrand <david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>, Barry Song
 <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/16] mm: Batch-clear PTE ranges during zap_pte_range()
Date: Wed, 20 Dec 2023 16:25:07 +1100
In-reply-to: <20231218105100.172635-4-ryan.roberts@arm.com>
Message-ID: <87zfy5zbmu.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::15) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: fd27fa59-1bf8-4e84-17b3-08dc011c701a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KyFc7dyqWBrhJpJG2Aue+z4mKaSO89wj15zdm9Le5AddG4AsPXYAn+VEW1ync3ARN6VH3Eb5YaUOxiYoBXXYdVOYz990hg9A61tj23klu7oyuWKpuMi+61WEJuabSu6JycvdgC+tto/wBqxcbG7w3JBcAR61xP8tfqYEe/gbMQLDrcvPkpAP+vf9gtDwoNACEQwAQNpML+i5VyVlzFiKCWfrHMpDpAnWzFveaViwpG6Ros7Sx+PyV5z4AnLhOVuN7dmtQa/CJ+jAzeojRwSe8jFtcfPWzOhkCRC6k46sUICVpxPfvGMmRe9D4vPvkO8xTOUeaElCIyiiaIY0V+xVxR96mWLLHD7ZLqxCy4Lef41Jsr1jmHgxfJxf/p/3WUY7EVJ+J46A5R6YF6fK49xOsT0Nn6zF425ZMuN/Zk19a1XvKk+ZLfKd3h2dIDIuQvEAnamhJv0xbawMR+aiKnXOOCBaLBG1mqZSTEK0Ps3HC/GV9l/+9YxCp4hrifeMB54QPzT8mPjKAS2qac5/qyb0Epl1M7+ovd3/HAOIYX77S/FtYztWdvYV27XU4beilBWn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66556008)(66946007)(6916009)(316002)(7416002)(54906003)(66476007)(4744005)(2906002)(8936002)(8676002)(9686003)(5660300002)(4326008)(38100700002)(6512007)(6486002)(6506007)(86362001)(478600001)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdavYJWiwo7ygiaX0rSAWsMxjvvujOOEYeCQ5qpqEEWft3o0xw0ZbLY5wSSl?=
 =?us-ascii?Q?yPjMveVzgKi+FYWlRdnnuGnTdokhYw1R1sbAOkwrMLb6S3eKSjINb+L9f2oi?=
 =?us-ascii?Q?wLzeKaFU5xWoaqZLEE3Cl/0m9j1V2WMTnIlqiZjfsSRuXM2SVFPLKpi5j+0r?=
 =?us-ascii?Q?aUsZylGuq28epVFlnK/gVSiGnDZ88fU0b9J+3zsvsHJMlra7/2ZqPvE+5kl9?=
 =?us-ascii?Q?FcGY7AuFFjmH0LhsWwtSv2VgMXeIMQPH4DJYnHjIJFuhpr5qAlEr04f6P2Gj?=
 =?us-ascii?Q?W1dr0nbXy3woMjcKqJO7QGCCPfz8DLrkRvvamZ5eWT37rH4Mqik6+sTWwLlk?=
 =?us-ascii?Q?01hbTQxuN7PduNeC63HByPQiJlLzQEb5T3eoH7dkPP0qSs1MSwKjhv5eq5Fm?=
 =?us-ascii?Q?zbn3/bc9vYfvLbaPHoTVFZfxkR5HmZTqAA+aucMc/S45g2fHwgqO30IsmP7X?=
 =?us-ascii?Q?T0etILJPW1qxp4apv8Xy1cVMrNmSsdJn+Xhmq5lwO0QD/yuhSV+jkcQseI9K?=
 =?us-ascii?Q?V141VJu73Mhos6Z4IWqz9gL2+EMyk7Zm9wi3GF9jARFO77MHZvn+JJvqXQN9?=
 =?us-ascii?Q?ogXb+AADDK7QcLyl75I6rEodKFSqls5oWnM7jVNx0Ehlkq5BUGtES5oVCXvl?=
 =?us-ascii?Q?f10g8mL7AyZduweVA73UGi5h1bQRIO6SwHTq6MaLJTKRtYT0z2ZxxG9IhxEf?=
 =?us-ascii?Q?8COsNcmPy4z2mX0sALALKeK4DrpuQRaYYipruU895Pp+uDQHch42kqv5zBm0?=
 =?us-ascii?Q?xcraVBmS1dvdHaBjulRdL2av4Dk7VDgrE+oe43fThb0TaLO6Do6KcFnw7VXl?=
 =?us-ascii?Q?PAKZ8YEbo6CEZejngkh7fAsTCbOdoEYye3hRjMlbFtKxzOjlQT1B3u6Cv5WZ?=
 =?us-ascii?Q?z9MjxX//ZnzSZj17YdevH25AbzSjMCgnvKpqTmeb71K443Ao3n8hYqtWu55Y?=
 =?us-ascii?Q?c9K4l9w1YADBB1XZ3WEyYkW7LGtObYeHv/rV9FJGroyGU7/CpukpWPov53ee?=
 =?us-ascii?Q?64GdtplpIwA93q6GPt81UnGYnKI8qOvhdMUGYZ6J1/f+Q6CnZHYlHZivU0n7?=
 =?us-ascii?Q?qPgKz77Md5CgADi76BcEPycKjnvFMduJ3BcKm7P41DMqHq37Q35D/ifiRbYR?=
 =?us-ascii?Q?Yv3CWpKcyH5vrr5LYW994wOcjdNmIW3Ni3+loyUgdPcD9s95XVrZiP7dD8eq?=
 =?us-ascii?Q?khQijAn8SYVDVd+gWvgpnF0QK8bK9FeJVRMkNyb0zINfxgwVBypMe7sy2cFy?=
 =?us-ascii?Q?J4rKz8gSQUILoR8QYiwmUwkTeyCyEMSwbOmsvbrpXZVSRfiEHvtIzrUacXLF?=
 =?us-ascii?Q?7hMHzLawm2ekDS7XAZTY7IBwOw6PhB5yLJcQtyltMcMPsjvDhfZeTyph+Mg5?=
 =?us-ascii?Q?/7aFlKUAFcNpT20K3DGLv5AhgeSVD2Zg9/nHG3N/tzpDWwhOALDDEZeWXCyR?=
 =?us-ascii?Q?fG73zJqqGbHNsaYDUp5UTRQV7Q/OT3FBkYyBf2R83GUbGIaFI5qKUAl0btZ9?=
 =?us-ascii?Q?CKkGPLhGZhVmjNcX/jAeIw/4ul9Kitn33CqKwAJJJ6h3wBT0/zK9WzM3QYLH?=
 =?us-ascii?Q?Di90oa6CfR+ki4MBHA0n28EDO5UsjNff5kWuV8Ph?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd27fa59-1bf8-4e84-17b3-08dc011c701a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 05:28:03.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxOMgRzaJXUUpK+DV65NtLDo4LZPKdauUVBXJZSyNQ1ZEYONi5SpF29TtW0VAz8lZTvqv1GN74FarOOcmFrMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417


Ryan Roberts <ryan.roberts@arm.com> writes:

[...]

> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 4f559f4ddd21..39725756e6bf 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -47,6 +47,21 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	return true;
>  }
>  
> +unsigned int tlb_reserve_space(struct mmu_gather *tlb, unsigned int nr)
> +{
> +	struct mmu_gather_batch *batch = tlb->active;
> +	unsigned int nr_alloc = batch->max - batch->nr;
> +
> +	while (nr_alloc < nr) {
> +		if (!tlb_next_batch(tlb))
> +			break;
> +		nr_alloc += tlb->active->max;
> +	}
> +
> +	tlb->active = batch;
> +	return nr_alloc;
> +}

Agree this addresses my previous comment nicely, so you can add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> +
>  #ifdef CONFIG_SMP
>  static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
>  {


