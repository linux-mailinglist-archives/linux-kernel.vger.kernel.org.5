Return-Path: <linux-kernel+bounces-17944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C488B825578
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD3B20CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2232E3F2;
	Fri,  5 Jan 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GR/wG6Zl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D92D7B0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQTmbHGQwKlBbFWSZo0KTTlhnS9fVkrpDdYDPIjYCsDDdnXz8G0Rtn4+JXtNzN6xWXENQ7AxKktglMeIdMtRO+LijgjrsfYPsXai84kbWO8AbbJtKFhj+fuB09USM1LMsoG+H4SrwaA/o0XboLM+H7GEeEBndOlT+GlkT+igbWTov82NKiBP/sNw0hH9KZ+gC/PniDZ+/LyNjkSy58ft2a88kynxvcYvUwQi9ULI3sk6bWjHAgRUYv39q9K3nY3xVCnx6IoNKKf6Du711p1hDN/kkF0JWsUh0+4xRot2kyhsPGmypZXbryyNpdbOOOTlKWKQhUsAECz77FtPRKOHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs5L9vJhbdpPT8WlXPTAd13tumnbYMXl31aTFtxCgmQ=;
 b=cYrFUSul/1ZR0armGtcJ0JYd6/H7bmtv59srbjAOSA+Rab1MlNjUzPdPrV2hAjgpmVBPtL2vmAKFf9bcpf8ahK7fxRwIrWgUTtuiviwmw9TJOryupeWj0u1hsMgqNknkiPOJwFzB2aHaDGys4IMC5LCr0gknQavx7STv4HLdXdf6WQtnCgwGTzO3hm2g/MloQ1b82tctIK/gzTkeHqcHU6mxKoEd/lv4S4auiY6pHY+Uwdz0OY3rbUEasIftC2QT3FD4FU0vkPFkfPVEi8wro65V57WU0dKwEhCvhuRHldj2wAqfHI3Jo9dU2mWRjGsNfEyWx8rVBUjkv20mcnFNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs5L9vJhbdpPT8WlXPTAd13tumnbYMXl31aTFtxCgmQ=;
 b=GR/wG6ZlMax/og/DHQzII6cE4IUzWpzRyF0CbvCvXPCCB2l5yLGXJccAWUXMw1hKql9E0AMhkXwXbtmHI118FspUzLzmfhVCyaOn0eGANB9q8xpRDlCAZqP4hnitfD34zjijBHE0+QLcC1n4RMZl64fo16hHKZR7+8pRbdn8OsRRF5xJQinSUsN/RWNU1rERylwsZRzWWI7GMVTJCGVNXj5Owl6TmlblnQ9jl8smO3S2j4hnUXw2HzYdpZKNeLc6TFJZueZwxq31fwcyezKvWdPffTyzojmjt6y6aIfPylPqldZD+9+ORe5uAyVbSt7LjA4icjAoedoJTyW9muqycA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:38:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:38:11 +0000
Date: Fri, 5 Jan 2024 10:38:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"pandoh@google.com" <pandoh@google.com>,
	"loganodell@google.com" <loganodell@google.com>
Subject: Re: [RFC PATCH 3/6] iommu/amd: Introduce Guest-ID struct
 amd_iommu_vminfo
Message-ID: <20240105143811.GB50406@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-4-suravee.suthikulpanit@amd.com>
 <BN9PR11MB527634DAFBBACC20DD691DD58C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <09d009cd-6366-4372-9534-4c637c56b3d7@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d009cd-6366-4372-9534-4c637c56b3d7@amd.com>
X-ClientProxiedBy: BL0PR02CA0074.namprd02.prod.outlook.com
 (2603:10b6:208:51::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a16963-6b66-474f-90dd-08dc0dfbf14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xs5Al6zq1kyW0KJyyQqQtcW/ahXnTLt3WcNp1TZzzR0LMGJI3X7rj5IXIyz6nrcP6M28EcWqBvw16wQ9j6+Q1jeFoKZSZBMfMt5OOoX2q7koEsLLVLbUtwJf/WfrBdivoxw+5SCxTomgygXB/0uwXVk5TH1qaS7F5uYAzsuc6ZN6p4Zw/GlU4HN4e88uwxvqDpkVAzDdJ8XcMgYE5MirHVfz9BLu15xNI5BKUywbh23SKmuUqQKElC0BrDtqi4zM91yTmjwvNao6qO+s/3gIjfMN/Rlo0KQizctXy9dCNS8Ayp873+K9vNqMRXxSz/ko/oZXBzt7BAYWXaSJFLNRW80JfahckdorW9WhkNuSqvJVcc71/oI1Z7sJPg0gRtFyjuQqUdCntA1erWsQjg4n1RPBUjIsFqWu34dm5/oBBsUvoHrsXoY4sTknTSF8z0JNEac2NuXsIMuAfbD83TntxtUYTfIrDhwLCPB9a+EubfBFXMHi5w9bXxdhkBqY/vlkUTL0fwZ0zJIF8nvSRL3JRyG12QZayt9pzEXr5voPTcldUqtxDdNOpbl2/02VjG/J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(6506007)(53546011)(38100700002)(478600001)(1076003)(26005)(4326008)(6512007)(6486002)(316002)(66946007)(66476007)(8936002)(66556008)(8676002)(6916009)(54906003)(41300700001)(86362001)(33656002)(2906002)(36756003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IVU3TVbIUU9oACLzTmPyxCIYADDyXn6gvK2jZKJ8d3aGtTtNaBJw2lNF0fUD?=
 =?us-ascii?Q?fhQ9os+HpEikqr1Mo7NsNuOqMpiD9S8wCxGO+0AH3zYCRW2m52ZLSfClfEfI?=
 =?us-ascii?Q?f5etzd5AsIyfgvxmLjlZ2xvmT3avrxM7KzbFeBwpH7KYPfjGgE2ZFyM+Cx7E?=
 =?us-ascii?Q?CUSsP7JhuYRHbyEEa7dBcGO2iQowqbV11Li8IkgJfGVQcxujAxNV1y4rIPc6?=
 =?us-ascii?Q?gGFc4/ttGzXc3O+ns3bPN4cMpwygO13OvrgPgs2mL1wuSc0me3L+9OCRI4rl?=
 =?us-ascii?Q?Pzvg8GBUyiz0xHE1FxWgK6UvoaRs8wgSYjHZ4PMFyR9l5m/OW7T4J+y2dr+2?=
 =?us-ascii?Q?KS0k7M3oubYeijRvnu8bLXQHHGlD5LhXdDyX5j4EOmq3Xaf9VENgnyPZEU0F?=
 =?us-ascii?Q?NrKAu35Ut58qoCAs/s8BAil9dnyUE5qmbNzbDl+Ih7a/8Fy2Y94Ws50ij4Ld?=
 =?us-ascii?Q?OhZ2/tBLX70X/TWk1zFxb5WqmnrK3v70TvqBJfZSkcvxqhe9C7DaF40W4A2O?=
 =?us-ascii?Q?ogtPjF8G6QkVYyvZgJr+D7KlvlxKSTRu1pB3r5F2LfvAI/erM/NbGSoCVXSx?=
 =?us-ascii?Q?nrolaMb0NliLg8m4RucPF9qbKkPA6jX9HQS6vEXMUov0PiZyK9lCtF6gWJ50?=
 =?us-ascii?Q?iLXCZr1Es2Vas5mQ7dthKizyEHboWSaJeAs30nlns0K71ZF2a4sl1SoGOvLb?=
 =?us-ascii?Q?bjP7Q25VP/1wvjG6BolTfqIcGL+poobbjOAagcAHGEsM45w3LMG5EfW+JVUj?=
 =?us-ascii?Q?Ob0LZCzmgJhPdByLGCizUvR61tD+HhzrdF5YDhgHLqR9jTerv8KPE8Zr1wph?=
 =?us-ascii?Q?ZRdQUwBo2M9FJbRlqZiJUH8ix3k3S8b7HNgIO4HNDfL7lQ9YeKBXoeOZ6DT7?=
 =?us-ascii?Q?WOm8EeypBsSLwsCPP0jNJuAd75cjCMeNUQPjzYruy08db4e5N5edxnicILSz?=
 =?us-ascii?Q?cHU1jvQy4rbaESGa+XDTFg6ei5QSe8akKCo+nEu8PnJ/nFtZBFH7RK59F7qm?=
 =?us-ascii?Q?boi49XoohHthkr+PFejg9I9GFSRqGAvPI/laEVTxZXK4x38KqdMx7/7LSNLl?=
 =?us-ascii?Q?OAtvaOornZj/4n9GZBN42ZPqk/SF2HjcjucVbAQhymxoJq/27RDxexBydSFN?=
 =?us-ascii?Q?MJNPicwPZ2h0XVGoB/kbrP/bmoVcKmDDZ86InSLO1DIYRNz6bfj0xw2CGqJ0?=
 =?us-ascii?Q?oV6Li2gvkYB0SDAEhWFMRy4EM5Xva0Nip+N8TcxrxM/NRTMQ0HWKHR1YUGVR?=
 =?us-ascii?Q?uL8R+WRwqGZFcvYIjVtZfJ/u2+Goa7eCf4BfNDuUSJ7Aa8F3akX1+XO9C2pw?=
 =?us-ascii?Q?tkLZGwpZxr3zGdJvEuAJ6wZxLEWACyTttrLBtdprjff4ZQvHrfIDesr31MT0?=
 =?us-ascii?Q?/HfzvaoDEdTV8ZTb7gU9jd+Itx9l8AHGi7Hs8O4SBFqWvk/MBj/rf6+kSdbp?=
 =?us-ascii?Q?FgxYGjexaDS01JkGa/DWh1wM6jnqHQ0qSMg7JArdAtAb5pJPoncbprTXkcEN?=
 =?us-ascii?Q?g9xlB+QmEH55jm2kD5oyqCmZySPZzwzLv8k95vkWsx5YoV42YXwfp3cZFa7L?=
 =?us-ascii?Q?Trm/wq/BzrzCRn5OWiA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a16963-6b66-474f-90dd-08dc0dfbf14e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:38:11.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xx4SxgRg4AP07OqEF3WHgrY8pBGxV7KgPD003yPEooOw+Y8TbLaFkk2WZAUZYXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050

On Fri, Jan 05, 2024 at 08:39:56PM +0700, Suthikulpanit, Suravee wrote:
> Hi Kevin
> 
> On 12/15/2023 2:35 PM, Tian, Kevin wrote:
> > > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > Sent: Wednesday, December 13, 2023 12:02 AM
> > > 
> > > AMD HW-vIOMMU feature requires IOMMU driver to specify a unique 16-bit
> > > Guest ID (GID) for each VM. This ID is used to index into various
> > > data structures for configuring the hardware.
> > > 
> > > Introduce amd_iommu_vminfo_hash hashtable to store per-vm
> > > configuration,
> > > which uses 16-bit GID as a hash key along with helper functions.
> > > 
> > 
> > somehow it's unclear to me whether this series is only for hw
> > supporting vf or broader hw supporting nested capability. for
> > the latter case is GID still necessary?
> 
> I am restructuring the series and might be moving GID stuff until later when
> introduce broader hw support for AMD vIOMMU.

I'm hoping you can just skip enabling the viommu features and still
have nesting? That should be OK right? The SW will manage the
invalidations.

I'd like to do ARM and AMD accelerated viommu nesting together since
they are so similar it will help to make the APIs correct.

Jason

