Return-Path: <linux-kernel+bounces-23804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B9782B1F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6675C285480
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6673E4CDEF;
	Thu, 11 Jan 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAMKmIBT"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC415ADE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqmNk6aQYWTbr/IclVep//sJO0+hvFR21vEsqVKSKUuLTXhHM39CRRwqi+7fvqajPSp7+Ir+S+3scpcIv7Gu0IPQOOykNujE6x5o2kL1wkbZDIh7NmzrRnAWBr7/iIDhxZ3MZkBtvPyZ7g4AX2twsElmUNgZ7PLUCCTcprK5ILZk3ucqR4EjQ18HGKxFUAYkOqSoFIsfGT0gxMlUkkRYBT5g71N7MXY1+p9YYRzLVnAfnOuF4xdYcIMP3S1lA8AkJfkv6EhoLxI+xRVNemTcZZZkZfvIxGa49NYeLQ5ncTQvyX2tbaBlrNRlT9l15TJftJFXYX8A6zBsCSe2r8Xihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6Q3GacfprGhd6+nXCFuSsj0keRpI48VxzG8bJoGf6Y=;
 b=nE9rWV5HvLt5Nlp3P8gkl8LYk5umttebXx7oeGJNbSBZdER/9cdh6GNQqZgWjkrugnEX47UPvWLl+q9DUJ+7GE8UQIGHDkdr3atW8m3RUziTrK9Ja7L+h6mnNDLcb8ATb+Ia+rYIhPW+OObzsBXHpVnDRLUdlGjivl0xe6tW8GRSybBPZB/t6XCIrH5VVT+O/fnEUxRmjjCaXoPX7UgngPSrWbG0uNHymPrKH3DFFcVN0hA9RRqQsm+1KJbhAwrlShTiH0X8S8do1ImPBUt2/uAQwGgUX/H0qilYtJxtKJrnL0mOM/8Zk3rQTngdA5ETkIrp6TOrP/mJ8aMK1BGbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Q3GacfprGhd6+nXCFuSsj0keRpI48VxzG8bJoGf6Y=;
 b=GAMKmIBT7K0bf8tLfnpen1GPtAg15sn9f1RUcV6BN1TuDPntxGZQoUHQYGXlMjpO/26p0lBAC6ezW6YEvodzyB3h9KqOdtjpw+TyN8A4I4999E0W370QvDM2bV/QYPTggiCYtf8nK/40WBidi2bqVxotd/zLg6+OerX7RMFXxSdxeZt10LO8iOjrt0W3Ab6UfOorRC4I2CfaRI9MfwYzerpCQvPAe6HQ59DICOQTiw/crmC3OMfBgMGgHP2dFbzCLawq8mSrMbw9XHn1KSYZuX3BjZFSXyqqyLLLxUebGgjQykXlfT1f16T2LcAn3IvQO47rGCTHW1qtMm/mKwrFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 15:40:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 15:40:33 +0000
Date: Thu, 11 Jan 2024 11:40:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: drivers/iommu/iommufd/vfio_compat.c:315:17: sparse: sparse: cast
 removes address space '__user' of expression
Message-ID: <20240111154031.GI439767@nvidia.com>
References: <202401112201.oMA1N8EM-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401112201.oMA1N8EM-lkp@intel.com>
X-ClientProxiedBy: DM6PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:5:60::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab282ed-6583-4c5d-47c4-08dc12bba5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sDAGaXiv2gwzG0vTZli+9JtAeE0zkiR6A85fezoMhkedmooPDimHHvPBZ0fugBAoEl102dPaNjzvGXMFz0N3zjl+IP+xZ03xQvjo0BXZTC5Cv4EKqRcdUs7GCtN0++Z6TXYUICdET6uoqp1HjoF91X3ZC0IuOP0/0aO1qiIp7KPqMAUToFiJ8S9d16N9da0ZrKcsaDMIao8a8iux9hSN67FEBF05PH273CT7hJZZ4X5QOSsWlIKN8lJvkHelx2upRDQab8ML1z0QFSawia6avJdlNjLQq2wUy67hC/SIMtXD51XsEDeTO2pQ6tTdkO3V1CFCC5A+IcVr3EwNWN/i0vo36DojpyjA6MdVnFlfuilZ/oPWWY0IxI7qP6O71DR4goS1vmHkSGWyTZLX1S594tkpk0Mi/IjdlhbyzpPxidDQ/aqbf5ycoKMXaxRjK76H+mz7Mgc7XXSXqZ9XuIeDqF6P487mATuQ25MNPhmduC5Ihmr4+gHteQ17loPDSp8uG0V7w+wpmLTZ/Is4UHioljmoGZJsnPFFEUp4Q/0qOSN3hZO0YXwoBa3MB9kKd+8z8uxUfWQQ3GhXmac9Brs4ADc0KE8e9KEyD/Bmt6IPzaBM8M0NQEhvmlhJrYv5+mcxyDn8qTsFKRVCZxBGTCnOZNRl3QNIjxCY38Cgx+PrWB7EHls9nGzRND1yjFTe0yk4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(86362001)(36756003)(33656002)(8676002)(4326008)(6916009)(38100700002)(83380400001)(1076003)(2616005)(966005)(26005)(107886003)(6512007)(66556008)(6506007)(6486002)(66946007)(66476007)(478600001)(54906003)(316002)(41300700001)(8936002)(5660300002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIeA4C61CXbQr+qvg4J9C/i/8LSXCHVgfUJCcoXbRPvll7UOiH1TSvRF3vz4?=
 =?us-ascii?Q?GJELDueTGwTVv0CvESkhDa77aXBth0YR/Ymg32Z8HwOq7k2DZC8x4dvRNw4Q?=
 =?us-ascii?Q?7IGdKLezJB55X7+SudEWXhzguZ4spZkohl25xOSXdbIBRBDGSFINYKyOuG5h?=
 =?us-ascii?Q?vIXV4yRt+JYdDUXjfLA3h+ApFdVA+f7u8XgzbONwnnrVC0RPFzFplJXQaNJD?=
 =?us-ascii?Q?JBbEMgKxuQ3bDayAam4sp3be1AiIaZThofIJEBg9uJzdLAhtFI8xy8qLKnuG?=
 =?us-ascii?Q?89TvJFSwtfyh4QtnUcTifEsOnsA166ydio8AsMdkdIKuAhqgRw16yiArPh7D?=
 =?us-ascii?Q?ZdPGOkH5hYJVVKPyyzxFDGz+W/NgT7pyqaSDN7W/3OpSjJktIte4GqD6rdRm?=
 =?us-ascii?Q?pcrK89zflMwOH+KmjayCPX2W+INDSdLuB/BJLeUmIPj327PGTrScsYEqvI7m?=
 =?us-ascii?Q?cmdqEc10TKR7nJItgya6yF5fprUi7SJhkitAlzqvzOpUJjOH20Ktsuhve7aa?=
 =?us-ascii?Q?mhBxxiIYQEqioYZ5uXojY0j1jVSWK//GxX/uSN9F+Z2DkBJOpKBBJbq1uexj?=
 =?us-ascii?Q?T4bCYCINtQSSNxqXc4veWkQlOvSIGbnt+uRw/n8Q1ChDXFlVXDVKqvK+uAzY?=
 =?us-ascii?Q?Wa0lux0ppatHn29Pe3mij+QD5RGiigBG5mqhyHy8HWuQpBV4JDJCcxx9S54Y?=
 =?us-ascii?Q?wrBpDTRqj2chuXJKu6YaenHT4SGOkz4fFl5plowx4r8kJtyQtg8DyBXnLWF9?=
 =?us-ascii?Q?N7QQMEpQg0A2gNZ2dL4vnAdAaW/uxRWOcuuRVVbc91S/o8kDEl09N0Oodqkr?=
 =?us-ascii?Q?FDzSYfopw48oWigwxlyirmwD/+r9vV57Cgv/RuGHxzH8X97IKkPLgiPm+mTK?=
 =?us-ascii?Q?aV0tKyoHtXtLVwQI2eXpPJi8tulR48/7u96ZILsMPqkx7/9hNBkBwDDo9Pr0?=
 =?us-ascii?Q?/SmIHv4IdkiYDmfdDHxd/T1s+vXjytITv6oyXLPnpbjVZhAh1VF8wPSj8BlG?=
 =?us-ascii?Q?l/7RkeFhYo78N34k4ytfrmQ8whYH5RsidlgCUkfULJZQM1yNRWKIfmDzjQtd?=
 =?us-ascii?Q?avK5K7RR4H5wtcDjR89UdJsvKcQFH8JaTsnzCniAMLJboPsUp9BX/ht5qYWC?=
 =?us-ascii?Q?ZLSSMhfa3wJm7y3TXR6NywzEEtm2q2Rx0UZv+QvEYPlq6W5MeQDlIW2IP+pI?=
 =?us-ascii?Q?MTSo7+rjuGFLjw2rR+xVc1Gd3yf45oGBXkkynChLTp1a5mmr58n1wniO/vn9?=
 =?us-ascii?Q?A93OQrnRl2oYe4cCsRaf5f1QOCgdj5k5iTnubmaEQ2pNOGcWDiv6W3SJbUzj?=
 =?us-ascii?Q?yFalthPS4XZ6rsEBHAN1+nZoNgrC6u+eShPpAjGEXfSNkTQLgJ/bjsoaoDm/?=
 =?us-ascii?Q?J4Ab+e2i3cFdpCDKWfsvk6GTHz7dNYjbj91tdT4y91ScEe/RhdeO0Z5IpyVn?=
 =?us-ascii?Q?M4XzhuhRMw8DBeI7B33ft28nzJ71FrWAC6UZGl5t7K9gD5DaXC5L0neXhtlZ?=
 =?us-ascii?Q?hpOYd4W5e08OXjXBEAAtJxTYvnqGqA2rDfslmJdFRKjlePbw7SnyBPdZXTLo?=
 =?us-ascii?Q?7msPchqeGYZ3qv6JN0Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab282ed-6583-4c5d-47c4-08dc12bba5ca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:40:33.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CsKy08qgr+/NhaHuJ9Vjujh5tcM0bsnfeQkFbhNd4b8QgCHjhoHGzpQPsI/WqoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

On Thu, Jan 11, 2024 at 11:05:36PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   de927f6c0b07d9e698416c5b287c521b07694cac
> commit: d624d6652a65ad4f47a58b8651a1ec1163bb81d3 iommufd: vfio container FD ioctl compatibility
> date:   1 year, 1 month ago
> config: arm64-randconfig-r132-20240105 (https://download.01.org/0day-ci/archive/20240111/202401112201.oMA1N8EM-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240111/202401112201.oMA1N8EM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401112201.oMA1N8EM-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iommu/iommufd/vfio_compat.c:315:17: sparse: sparse: cast removes address space '__user' of expression
> 
> vim +/__user +315 drivers/iommu/iommufd/vfio_compat.c
> 
>    309	
>    310	static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
>    311					 struct vfio_info_cap_header __user *cur,
>    312					 size_t avail)
>    313	{
>    314		struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
>  > 315			container_of(cur,
>    316				     struct vfio_iommu_type1_info_cap_iova_range __user,
>    317				     header);

I think this is a limitation of sparse, the __user tags are correct
here..

Jason

