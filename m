Return-Path: <linux-kernel+bounces-4899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C3A818382
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7481F2501E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E211739;
	Tue, 19 Dec 2023 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nL/EnZSl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D80168C5;
	Tue, 19 Dec 2023 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsMNrxLG0nSt3DYvlk64oxxvpXgrG2iX96a5B5bXQkmdoJ7Qxl/qyRVAY6fjBd3CiA7phtJra8fgxa4+9K2d0aNY7q2JhDszioL3F6R8mwT9CTz9G6XB5nXdn22H8KKAmHBXfgM43tI8HvoaJ2EC36XaKJNps6Xtv0krkwGhjTund5DIaG8KLyNSwYXlycDA8Iy4oEQp86jHGmaA3AUmuwW2CUzuWEHRlhLzrZHGONmg1tynm13wxxKKPkZbwiw5Hu8CbZo7nfZklqx8J0m2yrsTspAQuZcT4tn6Uid5lNRff27bFdn3IWYOhGLatSy+b6Gq1/VACX6LotAtNe0G1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xTL/EFpDweU1C4lyRIvdNrye2m0HJfvpHAsy9Ox+e4=;
 b=Tnnp9xBMq77TVLgRroswdFlqiJCmNivH6Y7idvlwlDAZbSKqmlZd41ASbK0I3k+geQXWop3gZ1yM2oD1jOxh8Hta5YSInkqJW7j8FHf3zKQEzMuytS+eXazxwBjFJvbBSn6NK+muPJvKg5RnZqYh71xYtB0OUcgvlxRYchvEaG6OiGBV8If6exd8cEGK0bOAHtQ/3HfqFTPUe3enagbSgtTrpkV2knJP6gofh8M8dPqHE7ZCnvINMDaxRwK4YPjz5lEn5SpCZ6eafaJxN7O4Elm1F4DMCkd3bWVJOJ0svgtNbSyjL0AdauFva4PAztVwsPTUrsh4cPlEf8LucQE8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xTL/EFpDweU1C4lyRIvdNrye2m0HJfvpHAsy9Ox+e4=;
 b=nL/EnZSlWLf5cnS6ViFWzGunTbDxSIpZLW9xNlG3fcFr/0bht2KgrtLHP3GcqOQbtKrLVEmmhQci7XJ40SsblGBh9zk/mFIe6mdaxCzftSF6RXwocMmeKC4YgohfzanXSnxBiN12sPZZ2nojuvTnPBxHewmTxuNoXcgt3Puk5T3lmOtbb3yr7u5b1tk7Fv1bZgU5dUVUhj8qSP3XCFkDvaUTP2ddV03fzDBoQdkw8SeYJoOFQicE+W7xI3mVaNuV+qSd3h2wMx3pNoK0ADqo3lvqJ9mavaHJBIQwufN6SdQLO+SksAIIKVelExv3lBrngukWG08eOiqTDiFswdsOWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 08:35:47 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::7f6d:9dd0:95c4:3194]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::7f6d:9dd0:95c4:3194%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:35:46 +0000
Message-ID: <41021c57-33de-44de-a76e-3fb2ef426417@nvidia.com>
Date: Tue, 19 Dec 2023 14:05:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu: Don't reserve 0-length IOVA region
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, treding@nvidia.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20231205065656.9544-1-amhetre@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20231205065656.9544-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::16) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c1a75a-da6e-46b9-a917-08dc006d7f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jGKRVZh02m+klSk7atNu+e9VqvsGDDh3bbRCi1P6sWVsEeXB3HZCjldUCP4/2N+TVtzc2w213JV3v7TJVWRMTwMyw466husIZP98m2Mn5JJ3QMp0VjO7EE3/F7HGax4ZrFIm7PkhUFGKwJm7RUeL3709WKyDo99YDe1y1KEDRERCmZe2NQJ0bshV2gvFDIvlT0DRbyiJ9X+PD4brRHlEopLDVjaw1DRA7SoQe7cL6cqsaF5xENiyozxRK/MA7sLXaaNrFSEVkp6E7s7L5GduFdMPaZ4B2Q2DVKI2mmJvAqRiwOtBXur02d81CHjipNQHxcZRJ9wJSDSbuAnVO5CwAQ3wzyT+In9zx5Zjt8Ymbum8QCMXxNI2WiePknOcZ83sbtqiDQZUPs1/Jw1oLi7TmKeCQtOWgbCF6A/+tKXyMrZnEj/VQk6Kjw5/Ri0PeM23srVvKQDyZFfK2Ujf9NZgA6Dp8/wNyGL+/f3DEi46O+9BMmRVmbhkvBpcDQ9SZr98Ev6l3U88LEN399X7cVcX87sYgXqKA6L2XHXQ+pNzhme2g6+rUejc++cfjSIIiJ3MXlOBsyQ4ALnbrX1bA8i/gG+ZgsMnNpvmkaqEQ/rTesYFxCLw5RoLSkkhLfEKyEftl1gnEgsOBb0xngckgGRZLHJwBaFfiXHhSoOU8RD6ZNk9B2wZ07NbwuvyCkvlSLKB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66899024)(36756003)(66556008)(316002)(6636002)(83380400001)(66476007)(66946007)(2906002)(8676002)(4326008)(8936002)(5660300002)(6666004)(53546011)(6512007)(26005)(31686004)(478600001)(6486002)(86362001)(38100700002)(2616005)(31696002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzhrS3JhZDdzR21GRWxGYnVJY1o0Si8zc3JMd2JCWWdQYk4zTTBMMW5aL0tl?=
 =?utf-8?B?NHZHL2JqN3BKdzN6d3AwZXJ2blhlNzJvOXlDSWRJQkFOTFFSRVF6WHRrMTg1?=
 =?utf-8?B?YlpVL2ZaNGp5MmtmSjM1V3JIcnh5TGdWWDZQdUVqeFNqa2dkdUNFcTM0K2JS?=
 =?utf-8?B?YTI4UHR4WFVlSDNHZmRhTE5iOXBJTFc4Vk1WK1F3Y3IzcmZ4SVVGYlgyS3g3?=
 =?utf-8?B?NnU5OG5kRHNJL2p2UndIWUtVS24vQTR2WTkrT1JNazRUZWFCZEFFWlVSNVA2?=
 =?utf-8?B?L01hMTdwdWIwVm9heXJwdUVJV0NLOENld3NiOE5nU3k3T0xTVTUrTEN6Q2to?=
 =?utf-8?B?TnQrZzE0RFVrWmFtV3JVM3AzWFlpQi9NUWhFbXc5MHNicUZmdFdLbElqR2xv?=
 =?utf-8?B?emM4YWdwaFcydlIxenVlbVdTR0x3c0FDMjZheHdJeGwxenhWdUlFczZNZ1lM?=
 =?utf-8?B?Q3ozeWRCbHl2WHNSbDdmbFFJVTFjZTZ6VGFzZUhhejhSWDVETFk5ZXRWUFV6?=
 =?utf-8?B?d1BRS0FoQVdYa2xQYkNEcnhRSmdTMVV5amQ4UzZhMkpub0dHa2RvSnJnL0E2?=
 =?utf-8?B?dWR5V213NVh5Vi8zdU5ZVHVIdm14NzhLWnE5SUx3OWhwRW5PdS93WCtON2dH?=
 =?utf-8?B?czJuU29mQ3RRVjhlT0dZMmVzblpCUzNDSUlWS01BVUFRQUp4VnlpRWFHVnZB?=
 =?utf-8?B?dTI1UUJRUTcrTHlPRitsUk8zSWhIYUdQWGE5Zm9lT3RkWEsvcXJDanJraE1w?=
 =?utf-8?B?REpOdmRrRlRMaWVDRkpQblBIZDVpeklZaGFXenduZ0ZoNm1LWS9tRXZqOUFE?=
 =?utf-8?B?em0xYzB4enZPbkc1VUZaK3pCWUprYWVVOENsV0k2NWNpMDFCRGNuTG5HSUZB?=
 =?utf-8?B?dmxXeEpqc21GWUJ5T0tzOGZaUCt3VmVCa21NOEQzcVpIaWJzRTBibTJPQndT?=
 =?utf-8?B?MnVoZm4yaGRKN0RiSWphajVGcHd5dzZiT25GTC8xRVloM00xVlhXZnZzMzdD?=
 =?utf-8?B?amZES09KYzhmdFNvS204VGIxeldmRElmY3JnK0NvVFVBR3ZNOXVGQVkveXRx?=
 =?utf-8?B?Vll6VXdRcTgwcVhYbEhTOTRjQXl5QTZzMmpGNk5PM1lPSHZLRjR1QWlpOUla?=
 =?utf-8?B?UEhPcEIzMW0vNEcwN1NzZUlnTTZPM0k2VHFXWG5PbTFES1VmQ3c1T0lxVnhU?=
 =?utf-8?B?d2FBak94ODJRTFRPTmcrNGRBclVwc1VYNEhXVFNHTzk4d0VtN0M0OVc4YjRT?=
 =?utf-8?B?RWpEdy8vRk1jdndzeUhJSCszeVpWemtYUG5pTnFQbzYrcGQ0dEhGM3lDOVB0?=
 =?utf-8?B?VW1iSHFFS0w3R255clF2Z1VwYnU0eDhyMDlOa0dQUVpJQW5JOGxsRVdaL2pG?=
 =?utf-8?B?aWFtU3RCUjBtSHVHTUJKaUFlTTJDbUhJZk1UMnV3OEx2clN3SHFZOGlLWmox?=
 =?utf-8?B?dkNGVkVBM05NblAxT0tHZ1BJeVUvblBmcXYxdk43R290Zkd6SnZwbHRBSHZi?=
 =?utf-8?B?RXlSOGFNMGZ4ZE9WRnpicGE0QUg5SERnN0FzeVhSblMwcW1KYnRGM0VZRFVW?=
 =?utf-8?B?eEdOOS8zWG5ycXUwUXduNnpzcW5WWHR5VlRTa205amdvWVN5QmI1aExQZmpr?=
 =?utf-8?B?RHRzSzFxK0pGY1drcEtiVzJyODEzS1pSclNzR0RkS2c3WW9odlFPNDJLb1Bx?=
 =?utf-8?B?MWJaQzl3TFowSnA2QUVESXY4dmtjaXZseEI3ZlJabC9EZGRtanNPZ0VITUU3?=
 =?utf-8?B?U3doZVd1SFFtK2NJVUFhV214RVZsUnpUYkNXd1JSWWVHWWhVVGpTOEJRYmN3?=
 =?utf-8?B?ODhpNHNGZWFFMFBxUitjVEtJUkFsWU9yU2piMmRoTUF4VTlhRTRlMU9ST0Fr?=
 =?utf-8?B?Z1RxTy93Z2YrQWI0V2RxMnRORjVpQk5TR1N4U2RhUTd4UWpjd1cvSC80cWw2?=
 =?utf-8?B?R1dVY1dvNENWQWtpWFEreWN1MGx1akxSV2NNZUtnWkJWSkIxK2NLeXR0aGtW?=
 =?utf-8?B?VXliNVlocU1vVWxxaGpKWXNET1U4d2JNRXhkSTM3TW9GNkRiejByT1crV2x3?=
 =?utf-8?B?eDNwcnppRXdEUW9aYUorL25SYTBNSXEwOVRDZWlhVzBkSWpNckRQMFNTWHZt?=
 =?utf-8?Q?qGOh1yW17E3X4X5RQLUrvgRz8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c1a75a-da6e-46b9-a917-08dc006d7f07
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:35:46.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64KP/dJwyBnOqx0HqZeLbKzYlP+fC1ccLesVc6WPrawy089jgfe6qm42t4XfLhhM4uFhimr1B4+cvCLfE8ek7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111


On 12/5/2023 12:26 PM, Ashish Mhetre wrote:
> When the bootloader/firmware doesn't setup the framebuffers, their
> address and size are 0 in "iommu-addresses" property. If IOVA region is
> reserved with 0 length, then it ends up corrupting the IOVA rbtree with
> an entry which has pfn_hi < pfn_lo.
> If we intend to use display driver in kernel without framebuffer then
> it's causing the display IOMMU mappings to fail as entire valid IOVA
> space is reserved when address and length are passed as 0.
> An ideal solution would be firmware removing the "iommu-addresses"
> property and corresponding "memory-region" if display is not present.
> But the kernel should be able to handle this by checking for size of
> IOVA region and skipping the IOVA reservation if size is 0. Also, add
> a warning if firmware is requesting 0-length IOVA region reservation.
>
> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 47302b637cc0..42cffb0ee5e2 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -264,6 +264,10 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   					prot |= IOMMU_CACHE;
>   
>   				maps = of_translate_dma_region(np, maps, &iova, &length);
> +				if (length == 0) {
> +					dev_warn(dev, "Cannot reserve IOVA region of 0 size\n");
> +					continue;
> +				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
>   				region = iommu_alloc_resv_region(iova, length, prot, type,
Hi all,

Can you please review this patch and provide feedback?

Thank you,
Ashish Mhetre

