Return-Path: <linux-kernel+bounces-17899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041098254BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80341C22D19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C502D7AB;
	Fri,  5 Jan 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kD2K6pfV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A6250E5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d82oXRpittnWerC7BwFlviiuu8MoXrJdrrj/Doj/jZxlVY6DxcUjxq08TCGHsvosEKGefkERhVO5n9g2s0kVDpqOprl9sYELMwBKd3Ne2GRzI3N99vDGO4Zl3V1I6RHIJ58L8v9es3DyhuO7qGAJwj0mzasjuNCF1765mHUHMBzqt+YoK33n+sSI3/124Lh4vT4/6DLapJhICzibmWlYthUfUkPYefU616CVRpbE4F+ljKPXv6ZkCxYrCNLv4IpDKMG/OaEHK5+4QiUvLf2sVDxwUrojttHur3dDENbZX+GLMilajrDa+V1SnYyIR1tfLdansb+Ah7U4a3iJs9RlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt10/PxvgJzOzhRN9fQFsEdc2tBbeYmWYCI0iNk3L6Y=;
 b=m2FjSBFDPRBCi6ClfjssdvR/C2kPasMF9kElEy5uAxWQljXrMWtZXK/Dzqj/vffRV4OlOHbT2PUZmiy4sgG9beQbXtfaSuv25shMN4FciNkRAcvwoDqxLvA2yd3cxH6qK2iBoafptTvc8IvXEBBVZCFXneVBLfGmjoYASBKrSU00PqQ9JKvUz7cs+2d9CQwppi7wS6r/hHnRiBnxC8kX6Ek7JGpUgPiqq1+5zltGVStHg/NBwBRmLyeWgQGHFyD6OhZj5Qy+/twnRvO6kdALMa9NhiGC02N2AdWKoWdMcKGRUr5OTx3wGxt0djitGabPCLUx5Y0l6glSRJq7LAVq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt10/PxvgJzOzhRN9fQFsEdc2tBbeYmWYCI0iNk3L6Y=;
 b=kD2K6pfV5pFSkCdNNxww1jsq8OMZWxb4KVtC5FKNNZ/Tl6yPVWpOiYI8RwkZ3JggFso2B6BcspXsB2GWm6mtY40NaWGMDBP1fjVw4+uKgueQ6+6VqZ2v1qxVhaGwnNvKzFEAwz7rRVbsWs+9CbHlDqemvksHNYoKKdpoY272Nyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 13:56:59 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:56:59 +0000
Message-ID: <0bfb908a-5bea-4d76-b4d8-2127b4536ddc@amd.com>
Date: Fri, 5 Jan 2024 20:56:49 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] iommu/amd: Introduce helper functions to setup
 GCR3TRPMode
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
 loganodell@google.com
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-6-suravee.suthikulpanit@amd.com>
 <20231213135313.GE3259566@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20231213135313.GE3259566@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 49af4314-8ba4-40b5-397f-08dc0df62fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TFQrLVijK1StvrdFoc4UXrF2eLzZXESOXDsE0fNqwl9AagQvzvHjeAJgCdQgInnStKB26/9UmNncUurboB3vAKuZh9EAk7OirHbFkrzYKybaobjf7mz9YCI6PdEChHTzV1YFd66lcLGqp1DToWSxBxIJJCM5JE8R4mrJrBVCZlkG9SpMEWd3MSsgigIZkoukKJ/EyNuNdIpZ0T/cXmV1iqYG43ekWtEP0QkClsNvIGzAhb8EXcmIZXCmkoxmGoo3dpO0bvC/mC25oB6gghKw8mJG+PxAIIi12pfNzCY8UNaeShGULFyQaLxR55Ta5tsfSqTe8xz+yxKOyAs2nJYyqzUlqH6WuO9Zl7NqGPFS+dZibCnwp0OoT0hl1Zk0ZIuj8Y183xXPuF9++zCo+JG2+hs0YQFjilDVewEK1xbN/qbmVCaYAmSJCUbd3OPpqCfs/J0E+xSoXr8NqXTB7I5BZeeFQ1c50WCQeFT4chqiBFQpC+2vSmvm/mL8XD3xlpnMyotPB8AIiDju86Y8vgFZpQB0qsOvxh1LSm5vO8X5hO4Pd+gVeU0ihem8wV9ICYAPCM2rXCbi8pYB78eqx0crfRtA9bY4MMU86j1Mco8Xdxyv8rScuR22Hy5l3PkH+VdExngmKgXVnt4nblmBimncIEAg2Cqw5LLNMLJW+Rsw6Oo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6486002)(53546011)(26005)(6666004)(478600001)(6506007)(6512007)(7416002)(4744005)(2906002)(41300700001)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(4326008)(5660300002)(6916009)(38100700002)(86362001)(36756003)(31696002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1llNVdqdXhtS0xJUjhqV2w0aEhqT2FTUDRtS2xkWTJhOHZ2Uk4vRG9MQ2xr?=
 =?utf-8?B?M2RsWDR0MTlmNnVtTDdJazZJMEY4RDI0NkhaVWsybnM0MGQyTFArSFgyaytJ?=
 =?utf-8?B?QTEzWVppZ21RTnJyS2FvYnRxS3JJWDJ2K01JTnRMVnQ5WWEyQkprd0VBR0FD?=
 =?utf-8?B?UFMwQ21pSHc3YTU2TjJnNnpiRER3aXJGRi9NZDNhV0Jza3BoQjZzQnpRelJo?=
 =?utf-8?B?Q3lOUWpOa0orZ1NxTGhnSEJEZjNIQ1NCUEV3RkZ2aGdvUWpJYjMyeFJKd3NE?=
 =?utf-8?B?OU94QnFSSUFMNmtoY2YwbmFkSWtOMmFsSGl4U01vQWJ3dGNDM0ZScEZwZ0Y0?=
 =?utf-8?B?L09TZDdCMnhHSjN4alhORXJ3TVpiTjdYNExxMDlQaXFzd2xZbVhjL25UcldB?=
 =?utf-8?B?aUd3MFk5aUZ3UXdjTUozYmpjNkNaK2JpNVMvQ21LU2YvcmhLekl4bnJrT2NX?=
 =?utf-8?B?djFNbHVhSTlYZlY1RjczUFZpVUViWXI5UytsVldqUER1UDkrOG8xZTJldm9R?=
 =?utf-8?B?OXdrV1YySFYvSGdKUU1EQ3hVTGt1OG95Vmc3ZDNwa3pHWDhCNjA1NGc3UENU?=
 =?utf-8?B?R2RTQXZubFJubG5kRGxxUjh3YWRvVUg5b25sNDJOMW9YOVFRZ3VDRWNoUDNx?=
 =?utf-8?B?VnlwZXlaT2ljZHpwUmVnWnU3QWtNTkRnV1dLMllFT01iOElhdDZ0WHRKTFR5?=
 =?utf-8?B?NTExbGRZR1RDUDBPRVZjbzRkQzFZclRIaDgwSGhrOUJjcHdLK2FmdjA1azlS?=
 =?utf-8?B?V3FyaFUrblpwb0xpZXVOQUdCQW16bE93eVU3Y0VjaFhLTElYcnQzb2RoU2pK?=
 =?utf-8?B?aUo0K1J3MWRKMmwxdUVFbUY2M0tQTStMV1lyVUgyOWlBWFFjVDMzMVl6aURZ?=
 =?utf-8?B?d0pyUUJTUU9CaTlRd05TdzNQNGhYWWtsTWlOYmRDQSt4UmE2SGlvZUFkQkVG?=
 =?utf-8?B?enMwd1BYNC9xVXYrbktzekJyQ1FqWklmV0dUelRpVk9pUWF6bFU2NnN1U1or?=
 =?utf-8?B?TFZMUHFoWm84R3FWRVdjYmlHeGxsWXhDdFpJWXJ3cUNVYVFRVDF0TFlNeWZG?=
 =?utf-8?B?RFpyWmZkQ05yS1I5Sms4RVJKU1hBREhwR001dGdjdWt1OXJPTE96cFUvcVFv?=
 =?utf-8?B?UkV1TjIvNVFQdEF3b1ZhSnMrY2J6U3VpM01nNzlLMFcxbDNyVWd1bG9WRHJm?=
 =?utf-8?B?S0xUOGVnMkh5bjBpSlF0M045WHJ1T0ZDV0t3bnp1eXRlT3M1eG5Hb25sam1C?=
 =?utf-8?B?QnJPbS9kVGpiQi9qRS9wOFNBcmwydjZsTnVJdlJXclprbHRBckJVa1UvNEk2?=
 =?utf-8?B?YlZkeUVmanA4ckxxQWRZTEVPbmYycnNYemE2UUNBSlZtdjdxYzRYYU5lT1RU?=
 =?utf-8?B?NmNrL3h4dEtHNThyOE9Ld3NOTEl2cG80UCtIRS9JOUtLN0lzbENuY0JaQ0pi?=
 =?utf-8?B?WEx3UVpKVytXU2tqSlNzY1pUWUU3bm4yNjF3eFRIL2g0bEcyUG5SVGM1ZTBN?=
 =?utf-8?B?Ukx2LzVDQkRNNTZVM1hTTGszdVpMVTROejZXTU1DSFhnSUI2S2lFUUdyYzZH?=
 =?utf-8?B?cmdkOFBSZHBRSFU4MTBZSlhwQ3NRMStoei9OaDRuK3ZmT25TZGRRVWdERlJh?=
 =?utf-8?B?T0ZXekJiT1NIdkVVbDZuOCtoMDk4a1NUcTh2Z09JRnNjbjl0eTNWY3hOUEI3?=
 =?utf-8?B?VDJGQTA0c1BuT1dleGlFMUd1SXVtQUVjNmxaRjBPaE9yL3lBSWlGV1czUUpM?=
 =?utf-8?B?TUZaN2dmcjhxZ2JaM2JXMGNsUGNZTGtUNVVFUzlsMlU5OW4yL0x3NWhTVkpC?=
 =?utf-8?B?UnZSeGpqY3NZZktMNm5pNEp6eGlHVVNsUnpYUUh3MlN3cFZZRXg4aTRRUHRz?=
 =?utf-8?B?L3RqYzRuOXpFdFlQelJCS09Ga010OXc4RjZQTHB3bXcySEdnNnpBQnYvOXgv?=
 =?utf-8?B?TmZzZ29aVjgvejhWWmR5dElXTmcvNC82and5QUpJNUdiaVFaSGhJaEhRVzhQ?=
 =?utf-8?B?SHZSTEJCZ01wRUhOaTdKSHA1eVNIempVOG5UWWF5SWV5aWZoN3l4OWtSOUp1?=
 =?utf-8?B?ZlRCdldraWZadWJjcnFtck1WZXRoTmV2YmUrWVpTODJvSk5QZTV3MVgycGpq?=
 =?utf-8?Q?5ewTb9NNVoJp9uLx01YcOn9yv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49af4314-8ba4-40b5-397f-08dc0df62fa1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:56:59.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reDbzSlt9lwmwXOXdFHXR9qOLOyKND+ZRArYjVdiqsA+ASORtbvggWdXIqr47xyV9VfXdd7yhlyuqdvVLSWU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056



On 12/13/2023 8:53 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 10:01:38AM -0600, Suravee Suthikulpanit wrote:
>> +/*
>> + * For GCR3TRPMode, user-space provides GPA for the GCR3 Root Pointer Table.
>> + */
>> +int amd_iommu_set_gcr3tbl_trp(struct amd_iommu *iommu, struct pci_dev *pdev,
>> +			      u64 gcr3_tbl, u16 glx, u16 guest_paging_mode)
>> +{
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
>> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	int devid = pci_dev_id(pdev);
>> +	u64 data0 = dev_table[devid].data[0];
>> +	u64 data1 = dev_table[devid].data[1];
>> +	u64 data2 = dev_table[devid].data[2];
>> +	u64 tmp;
> 
> Like I said in my other email, this whole function is conceptually
> wrong - you can't read the DTE to learn the parent domain's
> contribution to the nesting DTE and you can't write to the DTE during
> allocation of a domain!
> 
> Jason

I'll fix this in the v2.

Suravee

