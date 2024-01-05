Return-Path: <linux-kernel+bounces-17936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E182E825553
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA271F22749
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9D2510C;
	Fri,  5 Jan 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7yn9C21"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F2C18EB7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV0BrutfYSFb4cAbCBz8LAZ7gzJ1DQTck918inKYSBhevnsvhiDtPn/Bh+t7qBXVrf81BJzbZ/Iy7iHXPLIZTqoCl21b4kCy/VI0LA5H9ahd/MW8V52aubJK3DJl9VIjHDFoU36T58IOu0ka8ZZou6MrTprRptDNfbu6mH7XNBd5rhfM4LLERiL3hdmr/3K0gaMT59yMEIZbB0CemxSs7G4qBkggSGBxdINwZDcQ2sEpNRZYE/1LqIy5I7Cr5SGPo6eKdVnCyXriJ2MxIRnod0B1MT0ltFHUBrcJ9lC3qxQeitKjfRmOsY4TQO2QXg5icBBedrVt7tjII/BFwphlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkC9z19jXJSfeSMuCzc2nYwKhe0Z/nLxK4bz/vRS0E8=;
 b=Suq8ZK6ayVeOEA0n7CrvOe3/U5iQ7ZAm9wTDhJbeMeWcF/cGVTlkg/+f2fFBy3EzWPC/5Xx3d/i6Pj09gTZqB7pL0yDnKwj15ME17aG8yH6hnKf2d/6oBxjACU5SJRT3gUcUmCweJ9qoeSSSbgdnNmegtg1Gi1vMpr27PhGVI76GaAGddJdJA2s+enOAcH/B6/2gb1O5s81LSA6pgrRrni1rBfBpY9+HdaXzb/pUS0YL53iLmllG2dUUFhKKoKg2bLH3umdMIdQz3uv/gRgAKPShpsbFLzC7YYpcfLCgjQeRfrfEDJZANCNMMuoWZY/Zi+OY3/NpVjdjaQarR0kPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkC9z19jXJSfeSMuCzc2nYwKhe0Z/nLxK4bz/vRS0E8=;
 b=q7yn9C21vJYwDuNyDIXLmzsU3PWBHtr5XOm0+3KlnWVe5AYZAIYn8yz4OSdtunR+qyoKu04wFYnv2UFSKPi16isu6SzUrD1ekQEHxIndMYf0dv57w8ZjaYZz3qCC0JV+qmaL4u0M8FcKmQYrwzchbs9a31RLeCwzjphzgFZk6M2BUuwtAIGjGLaGSwrCCeD53heF5ya75FQqdwfF6JfDb+tckGxJvJzls1VQxUguV9cl1noblE81AIn3j0DlFbc6x9jP8qwXYNQCzNqzx/CmVBNuograQ8pdVJND1S3FIHp0/uFOrZ6nQrxEC5ed9LpXPdqgGdA2oOS/PLsvS4/D0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 14:31:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:31:03 +0000
Date: Fri, 5 Jan 2024 10:31:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Message-ID: <20240105143102.GZ50406@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
 <20231213135206.GD3259566@nvidia.com>
 <12c5b705-1387-4d50-8706-cf5c35dcb3cc@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c5b705-1387-4d50-8706-cf5c35dcb3cc@amd.com>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 53409002-5a9e-4a48-aa2a-08dc0dfaf1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vXihLklpCBdoxXS7I7A4R4hZWQ9uwH1U9ua9fTiyvHdQjuVSESokJ7+dtRONZJsoRt+lFuhOrhy6Vp5PpnIwkiLRL5DhKW+xgz2OM+aiDOAYgeD/dC1VsKZNgQc59hy79hqJON8Y1VuOHCtNFC35FjmFyH2P+GgRzE2aRdCHK3fMcvsefNqnnl0xYwGj1EoFIbA2ixpwnSDHddMh5TIFw0UF21Z9NZveWNFPPz6kT6rvYHcDg5ZPZFl/GlLm9d7qumDL+1J78ZM1fWbKr4GQX4J+5xsn0kh4aZYVkQnJSajoOwe17o1oFX8E8w8xBUDlwtTgraZm17VxKapyYHqW3mtzA7I+KDZ466BMmmQUheWutMRK2ATMGTWL2o3Uj+oRLr6lhTenr5ndRClab065QJVOpPkkyxJkNobN/FBGixuE5CHGgKJhUB/Dq2ImMsQ5lwNKUUehLvcgH365PWsAg+pUBwpDiai4elFK4PVxhoefI8FjPHaw5ptIxiMMUMYbsWY2katb4HL7xPqRQyAL1IR134L7W1SMrGHu7sP/lqlOqcX/pH/AFONXAKtVlRhMJFJxJVGAwvyVon3fXLPcVVbTJwOQYy7gdSpttQEE4oQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(2616005)(4326008)(6506007)(6486002)(38100700002)(478600001)(966005)(26005)(1076003)(6512007)(66476007)(316002)(8936002)(66556008)(66946007)(8676002)(6916009)(86362001)(41300700001)(33656002)(2906002)(36756003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jLNyLYGuDUVdQDsJQZdP2B9z2IIUMjWKDLgEiWr0WmNynAeuxrMM8U7liM2I?=
 =?us-ascii?Q?1hflseFUMxQCFyACtD9V2cyC+/x6eqG/ioOE0VYFpK28GGGIVKBnZ4eEIL2q?=
 =?us-ascii?Q?Ta0qxAQD2SV864OqnDQXwKgsJwQ07Upl/5X3CjT27wmnbu6fe4fJ/BXjyoFv?=
 =?us-ascii?Q?976odFM7d7uth8cOlHQAE5bX7/xPh3G5eOfopPFUheExIr2vmJVdftmrp0jR?=
 =?us-ascii?Q?uueIDMsfM+WbsW9ayJrC7x1tv1DvGrRjt20h4NdnNaMeEp+FhqB6NioMeN1D?=
 =?us-ascii?Q?ILsbfDhRvbIuikQJsZspPtyqCtRMfwxeSqitmGIqetUJ3k0tbrOhML7/3K9Y?=
 =?us-ascii?Q?uySZnrYr6cczNA4HFNoaP8kRu+2Bo0GHSp7QzsifgrFhXWjPyAd9z4/nc7Ap?=
 =?us-ascii?Q?7h6Vgne07IXYqmCw78eGJnr+DIPDDTFn11oz0ydZepyBVYsUl/9FCzc/gEHS?=
 =?us-ascii?Q?c4xJDFtVmj0JwQtZcTY1mGidjKeq/e3i4oqFxb2fL9IyqOi0IZV8cY/uwCZJ?=
 =?us-ascii?Q?sc99RdqqBzSKidLFtaQtAJ4MN/pvJkaDnTJupfzwUaJ56GyRqfm+gCDlqnq+?=
 =?us-ascii?Q?ruNXq0Fp2YlXOYO0IGtRMyjyHyocRm2HvMuP9V8wqXlUvQjPONnI4g4vqB94?=
 =?us-ascii?Q?a4RKY9gosNmXBM7+cQvHG6WP8LGNzc7QPvrovNc9/Tly7eXpSmn/QQUbgPET?=
 =?us-ascii?Q?J15TuyQ+neMyzR5knBPr75tUwFSy/xvtCc+uWOieCCvI8mNCDQqK/OC9N0Oz?=
 =?us-ascii?Q?GoSRdZBpkXnNGf42Jg/V5T0ChWZ7miEDecfZR/d0r2H5fEgQVAlD6X++Ebx+?=
 =?us-ascii?Q?yMEO2oUzU3G7oKBYly8eCZk/NjZ84ZZcBTp/ZZt+etdZHeiq53Sr3PDhV0Rp?=
 =?us-ascii?Q?l/aO6QqyCmw7+Ur5xCRY6x+dPzxhVbgNWAiaIJGFrdnD8Yrp57O/6ZjUvS1n?=
 =?us-ascii?Q?8ZQ4cR2uSjzaFTuvwfcsfqrY8qz0+6ugoVuecieqEJeEXZXQ7xzGEQPzgw0/?=
 =?us-ascii?Q?Pk9ZcxFMeSDrtivY70jPGhuMggvqH96m4YdCw3S7pWoePbhMgfZ1NEJUDKBD?=
 =?us-ascii?Q?wWT59gPbttF6ktMGf9vbP9WIGqkqkF4TNtnzB6D/Lk1KxqWGqmPhpg9abriY?=
 =?us-ascii?Q?Hu95re/b9VC4dueVSK+yDWVrvELyAfA1KS8XuRlAZoq1pQHcsPqPBAZa51a0?=
 =?us-ascii?Q?mxno8xMjRlmn3fUh63umoRAxwfS8ccJ7RVpy8NkHmtF7gu6QbUxuV9soaEwP?=
 =?us-ascii?Q?41hztZo0LIThhXxrgEr2Ow+7xit/vhpoTbrtYr3ygd7proqC9ajEE40AG7ra?=
 =?us-ascii?Q?S8akzFYj8D3srgK5uSWX/eNVmtAoPsLvkaFdKN2loFrm8vhApoxRHGepUACU?=
 =?us-ascii?Q?a6ZEGHrbwS+zqHp0irEBtGSrJ1yl6MQ+5PPRQcNV0qSKAuVsKLo3yGsk9ShB?=
 =?us-ascii?Q?o4ryIaHhgcXd481kIlZKObQC6ndolXuAsxhj2tOLyZR+WqsJwGoRvS0ZtXRq?=
 =?us-ascii?Q?jSkLYcTCHOuh4tqkxxzLaJNFKEnI/d/USEqeu0ZXPOCxkoZJG2EPqIfJqKuC?=
 =?us-ascii?Q?SQwTml78sZgf5MzwpuU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53409002-5a9e-4a48-aa2a-08dc0dfaf1e8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:31:03.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kq90Pwbp/Inze7F9MjqtVsOZlGWkhhZdahMt/FF7ghnAI4/BbMiQbRDIQVIBNxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

On Fri, Jan 05, 2024 at 08:38:47PM +0700, Suthikulpanit, Suravee wrote:
> > > +	if (!pdev)
> > > +		return -EINVAL;
> > > +
> > > +	/* Note: Currently only support GCR3TRPMode with nested translation */
> > > +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	ret = amd_iommu_set_gcr3tbl_trp(iommu, pdev, hwpt->gcr3, hwpt->glx,
> > > +					hwpt->guest_paging_mode);
> > 
> > Waah?
> > 
> > This is touching the dev table? That is not right, allocation is only
> > *ALLOCATION*. The dev table can't be changed until you do attachment.
> 
> My understanding is QEMU should call:
> 
> 1. iommufd_backend_get_ioas()
>    -> ioctl(IOMMU_IOAS_ALLOC)
> 
> 2. For parent domain
> iommufd_backend_alloc_hwpt(IOMMU_HWPT_ALLOC_NEST_PARENT)
>   -> ioctl( IOMMU_HWPT_ALLOC)
>   --- in Linux ---
>   ....
>   -> iommufd_hwpt_paging_alloc()
>     -> struct iommu_ops.domain_alloc_user(IOMMU_HWPT_ALLOC_NEST_PARENT)
> 
> 3. For parent domain
> iommufd_device_attach_hwpt()
>   -> vfio_device_attach_container()
>     -> ioctl(VFIO_DEVICE_ATTACH_IOMMUFD_PT)
>     --- in Linux ---
>     vfio_iommufd_physical_attach_ioas()
>     -> iommufd_device_attach()
>       -> iommufd_device_do_attach()
>         -> iommufd_hw_pagetable_attach()
> 
> 4. Same as (2) but for child domain w/ stage 1 table.
> 
> 5. Same as (3) but for child domain w/ stage 1 table.

Yes, but understand it is not API that the driver can depend on that
order. #3 can be skipped and there can be multiple parents and
everything must still work.

> You want the gcr3 table root point in the DTE to be update at step 5 only,
> right? If so, this should be okay.

#3 sets the DTE to point to just the parent domain as a V1 page table

#4/5 sets the DTE to point to both the V1 page table and the GCR3 table

The DTE is calculated based only on the *currently* attached
iommu_domain's for the struct device.

> > Please look at the smmuv3 patches and try to be structurally
> > similar. AMD and SMMUv3 are *very similar* in how their HW works
> > excluding the viommu stuff.
> 
> Could you please point me to the series? I found one but it was really old.
> I might have missed the latest stuff.

https://lore.kernel.org/linux-iommu/0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com/
https://lore.kernel.org/linux-iommu/0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com/

(and the github link has the other parts)

> > You also can't assume your parent is currently attached to anything.
> > 
> > The construction of the DTE has to be from-scratch based on the parent
> > domain and the provided values in the "hwpt". Again see how smmuv3
> > does this where there is one function that builds the entire DTE
> > (called STE)
> 
> Ok. I'll program fields of the DTE, which are related to DMA-remapping with
> v1 and v2 table using the information in the parent and child domains only.

The smmu code looks like:

static void arm_smmu_make_nested_domain_ste(
	struct arm_smmu_ste *target, struct arm_smmu_master *master,
	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
{
        [..]
        // Incorporate the "v1 fields" into the "DTE"
	arm_smmu_make_s2_domain_ste(target, master, nested_domain->s2_parent,
				    ats_enabled);

        // Incorporate the "GCR3 fields" into the "DTE"
	target->data[0] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_0_CFG,
						  STRTAB_STE_0_CFG_NESTED)) |
			   nested_domain->ste[0];

Where "arm_smmu_ste *" is stack memory that holds the "DTE" being
constructed. Once the make* family of function figure out the exact
STE that the struct device needs, another function writes the STE to
the HW visible location(s).

The goal is to be able to calculate the required DTE for the #3 and
#4/5 cases you list above directly without making assumptions about
the current state of the DTE or anything else.

> A device can be attached to a domain, which could be either one-level or
> nested domain. In case of nesting, the parent domain contains information
> for the stage2 (v1) table, while the child domain contains information for
> the stage1 (v2) table. For each domain, we need to keep track of the parent
> domain.

The nesting domain, and only the nesting domain, stores a pointer to
it's parent domain - they are a unit together.

Jason

