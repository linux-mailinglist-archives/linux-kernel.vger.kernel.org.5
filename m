Return-Path: <linux-kernel+bounces-19119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33DC826846
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A9BB21048
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B688489;
	Mon,  8 Jan 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ikthPscb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F209BA4B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuTxT2T3inRKDKCjr34tkM1kS9AzGckFw6xkbaYdZ2RdwGNiPB9BJY6stkFF9qhCNYniV8hoW44koH9QD7ZFxci5HKh2MW5upBFkuJotq9KYtj9h4jTtnTovQts1XECEEWyJvdgx1IOJ7UlP1jGcWPmqSN2ZX76oR81AyLE2Qe7IqptbeeIGGzcHHgLbcm7SgWXVGWVSEXbbQiYa1DJMqROlx0vxIE3oDVS80DUBYQPKKkx8VIFirg+5LwCca5GoD8TSGjthqXtjT5fxK8CPJ37Oourc1Y8eZ3HFC3Z1WLbNiGvnGw31LD3gjvfkI7/ICy+RIp/dkHASS8q/lr3rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnrLFdLV8HZw2PAmU0dJbNhVpVhF0nrT0ZJaWEj5dPI=;
 b=bbFPF3AZHkjkOBqie/nUDwjflg2yhNrRIM+586/IRRklz34sykXoaKCKUm2tywRTJhqF1btxdQlp/v6XJduLDyg6oniwHvzRJn0X52rexHjZOoPA+/fjFLxFdEuvvmL8BtdB+RUcf8XVs4OcmQs2l//X8jcl2AYLfhts2uOAwGpqRGNhEOCuuypTTDeGqoYHGgsd/WsqYo1Om9dhoggPaALhTkpeFowoFupA3uNNAs5oAIOaRGWqm0URqFnWWuZumTPXKvZ8RnQj2cm7fN0tmJTHhTFlqusYjgglnnY4BnzXITR5EMlvbZilpuQhtHCS29RxFDXaLJJ73r8rVNzAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnrLFdLV8HZw2PAmU0dJbNhVpVhF0nrT0ZJaWEj5dPI=;
 b=ikthPscb+fq1j9GpxrviTQnApLYPI8r45DoJie5txa55FaHHCuToP+XROPGFC6vMgg0Lt51JB3vWBNueYpEFzDK3L6/r2rdyRnJr7sItwP4Yhg3kRpv0eXcjvhFq5xMYMCKcJ4+ElprhLBLqf4IiOBt9kg+/pY4yR3+9hsxOhqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 06:49:35 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 06:49:34 +0000
Message-ID: <1fbdeec3-58a6-44ec-ac0d-400676212f40@amd.com>
Date: Mon, 8 Jan 2024 13:49:25 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
 "pandoh@google.com" <pandoh@google.com>,
 "loganodell@google.com" <loganodell@google.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
 <BN9PR11MB5276BA85118EECCCD89681EB8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d2cc19fc-f8c6-4b3a-ba88-5db947fb1604@amd.com>
 <20240105143703.GA50406@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240105143703.GA50406@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e9c580-ab01-41b1-0fd0-08dc1015f98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KQh/y7soV2kwaKeyC/qJg3+n74PSdfUwQFewSMT0N0M7xfkshj5QuRzY2HScDedK8gwRRYduIvsNmc/F4A1Nu5nFi9d5TXSiVjbiXKE/b+rnB5wAcXHKRdvWpwGv+0JJefTm3Xs1+AYpYGUnx5OYIUmxHrLvgQQV3SorWBQv8nTBWRl3i8AcWC2pk2yBJZw5PiyqTCEoLkNtPF6xvSMGk4+mygcLLTtgA3gnj4BVS3QHELsQxpgdHGscDwa/4NpRAWdUP7en7Sd+7uUtPHgmHZqUGJVybyK63KWIQWP8PCbLz2gxWtc3lrQCn6+5VrtvLtZxFVjgQK6+qjfK2aTdu1axhxvZPx+b/Bz200WM41Ef44ogJv/BtQOgjBWtSCgGRXw1pmYW4qcZikaktddXYsghhXa8nGix3N1qbBvEQwZB2F7df550b5OqG5ir4SlSf8fI7AFvttD5OOTZAaV+dmKCB+uTD9kJKDQjYLF0KWPBYoGhoYkNneSRI8JupqtC4S0GGk5RYxhtQForHDVgXXnAzwahNTXEOx4f+s4RA7BVUmBm8zHhrLBKypjp0S0tqV06x1HSnzLb6k/8mLEVRgV5NjvXvBGwdC6abobYdVPovqjdPbF+dkt5iMRMYL9B1g3/zO8zsIlPv7kl3AmCfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(7416002)(5660300002)(86362001)(41300700001)(31696002)(31686004)(316002)(54906003)(8676002)(36756003)(8936002)(6512007)(2616005)(6486002)(66946007)(66556008)(26005)(66476007)(6916009)(478600001)(83380400001)(6506007)(6666004)(53546011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDQzTXRjMm8vdHc4MGM5Sm95MzhlcEJuczBPVlo0VEdmRHZROU9JKzhmQ0t2?=
 =?utf-8?B?bjU5KzR0TW1CVDZUcm1xVzB6VTc0cEk2cW1RdkhEckh2VjRlWnNMRHp0ZUVs?=
 =?utf-8?B?ZlNWN1VuVGpvb0g5ai8yWG1RTThWS1pPNEZJcDN0VUpNRGFZb0VSZnZiVnRm?=
 =?utf-8?B?blNsK2gxamhMcndjT1VuOXd3MVllSDFYZ2xuOW1DR29Ob1Nnc0IyTXVtVWgy?=
 =?utf-8?B?Rm1TaEdJUU5RUEZYQlZBb2dyNTR0SEZqbXdNME1DSUI1U3VlUzVSUG5Xd3c5?=
 =?utf-8?B?VGhwRDI1MXluQlBYZnhMR28xL0dhaE1tcUcwM21BbDVHWVRBWkNHekZMUlYx?=
 =?utf-8?B?dWQyUHB6enh3UTZlOTBQMThRYzVudDZ4M2VzZXdITzlHNytBcHFUOTJiK0FK?=
 =?utf-8?B?cmhhZXRnS0dmS1VKZy9qYnRQVU5rdU1KNUdMNGhyNHBQM0JHNTg5QmY5UUhE?=
 =?utf-8?B?Y0c1UkNSOFhBTThybkZOWEM0aDU5OGFpYlZNYlJQQlVTUnZRUFZnR2Q1bGRz?=
 =?utf-8?B?MXhnK1BjVDlIWHNrbElxcldmcDgwbDhjNERraWNDNHIwOGhBZDAvb3doMlFu?=
 =?utf-8?B?Ty9TQU4rNGN6eXhQek5jeFNzUnE3ZzRFSm9CWHJKUmJJT0hrbzN2NUg1STRl?=
 =?utf-8?B?T2JrME1DVS9zR295Rkludi93dXBzSTRrbGlieHhPaEkvVW9OWm91OFdHalJn?=
 =?utf-8?B?bmJFallvSkd1aVNWL1AyS1h5aXlWbjlKMlkweWFTcFY4OTJIQ0lGVVExT2lN?=
 =?utf-8?B?ZVBGVGkzSTRiZi9LZi9uTDFKZUFOQVZRUTV6UUp3aDQwU3hGbWZyL3ZlK08v?=
 =?utf-8?B?dEhUb1UwMkRnU2JZZXFmTm4yU1pKQ09kdExzam1CMTVXeVZVWExjMThYcEdk?=
 =?utf-8?B?a0VCeVlTbEd4VjJwcmdrNm45RDN5ZGkxUjFPSjlzOHRqaElYRlVSS1BhUzhx?=
 =?utf-8?B?NUhsc3ExL0lFM0Z3M3JiTHVlM2J4Q01HekIybU9aN0FlL3doc3FOM1IyMmg4?=
 =?utf-8?B?RjNnNVBCR3ZjelJ0bVpnZjllRDV1TmtRMnI3UXJaZUwxOHE5bTJKOHZ1ZHRs?=
 =?utf-8?B?VzZaTnhubHNOOG4vTU9scGhlOExHNTFtb0poTUVFL0V2a0FhTlNuODhEb2k0?=
 =?utf-8?B?eEVJa2hFb2lSOGwzYldpaCtncW92UkpyNkUzT0F0RmtmeW8rY2F0ejNXNFFC?=
 =?utf-8?B?YnliRmtJc2VTZkoxcGt2a3ZNTU9pWjB3eFFCaWtXN2pNK24rR1REWmdUTGUy?=
 =?utf-8?B?MW15Sy9Ra2grT1U2UkdFNmlCS29IUFMrTG9JbUJhUENIeGQ2ckU0SWFtc3F5?=
 =?utf-8?B?YTBQcFU2c0JsbXBJT21uT3BzdjRvMFVIdXdRSzVWVkp3bGVxNVNiSTgxUmoz?=
 =?utf-8?B?cm85bUZkQ2cxdkVwSVRIZ280bGMvbDJieWpoWGtkT0Z5eVo0dFYxaEVCNDJt?=
 =?utf-8?B?WHdSNU9qbWszYmUxR3pCZmZSZTc3MFlvZTYzTDhvbXR6RzQvYUdxUXRTWDBL?=
 =?utf-8?B?Y3ZFR2dvZzZjNnhlY1hWRTduaml0L0FZOTZOMGI5OXIvUVlIYjBjSVhIa01j?=
 =?utf-8?B?RjE2N25iRnVYZUxsTGFOSG9RcDBHc0pNeTJEV2ZjQVB3b1dXYWpJNnpyOGd3?=
 =?utf-8?B?V2hoR2o1eWY3UkxPbnJMb1o5STZmdFROSXRtSnRVTUxoUjNOc21MbzhQMU1N?=
 =?utf-8?B?bUx2RE1TVFdJMmVRQzVHSkRTL1BqTkpJUnpxZDlqVFlLSmdaMU03WTN3ZjF0?=
 =?utf-8?B?S1dQc3MvckdHcW1Fb0lSQU1JbjdHWnFQaFh4aXZtM0FhOTVlbkJGOU9aV0hC?=
 =?utf-8?B?bkVwdnM3Uk04UWtDOWJVdlIzUzU0c1RkcG5vbm1TOFh5TjRYRW5kb2J0VHUy?=
 =?utf-8?B?Ky9qYU96QzY2SDVySWh0bTJRdXFVcjBWVWQxWjVCam45Y1VtYytVVnlpTmtQ?=
 =?utf-8?B?ck1oSDlOQ3FtUEh6U0s3OFdaTXlaT0xtbFA3VEY2UlpQK0xjZEUxeDBYMFNw?=
 =?utf-8?B?Y3VIY1dQdEZ3R0NjbkpKSlNmOW1wVUdaeXUrbTZFOGtqSmpaaXlHQXZrNW05?=
 =?utf-8?B?MXdlVk1jQTRENmlJY1VOdGJGNHErMVBhTFN2OERkS1FKQnA0N0ZKUGRGTWl3?=
 =?utf-8?Q?JeGcQiQ97tcy+x4oDakEeoxOo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e9c580-ab01-41b1-0fd0-08dc1015f98a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 06:49:34.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN5irFBDJ3R7gjEM8+L7IK2jDN3tvF9zqaA47YDWAn1RXY3WXXvaSRYnBDMNfDzdnhNagIKT1uWyf9bjSApyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821



On 1/5/2024 9:37 PM, Jason Gunthorpe wrote:
> On Fri, Jan 05, 2024 at 08:39:52PM +0700, Suthikulpanit, Suravee wrote:
>> Hi Kevin,
>>
>> On 12/15/2023 2:45 PM, Tian, Kevin wrote:
>>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>> Sent: Wednesday, December 13, 2023 12:02 AM
>>>>
>>>> To support nested translation on AMD IOMMU, the driver needs to
>>>> program DTE[GCR3 Table Root Pointer] with the address provided by
>>>> the guest via struct iommu_hwpt_amd_v2, which is passed as a parameter
>>>> of the struct iommu_ops.domain_alloc_user() with the flag
>>>> IOMMU_HWPT_ALLOC_NEST_PARENT.
>>>>
>>>> Note that current implementation only support GCR3TRPMode for
>>>> nested translation, which uses GPA to program GCR3 Table Root Pointer.
>>>>
>>>
>>> means there is a plan to support another mode in the future or
>>> actually the nested translation requires GCR3TRPMode as a
>>> functional requirement? imho the point of GPA is assumed
>>> in the nested configuration in concept...
>>
>> On (older) system, which does not support GCR3TRPMode, the IOMMU driver
>> needs to program the device's DTE[GCR3 Table Root Pointer] field w/ SPA.
> 
> Meaning that on older systems the GCR3 Table Root Pointer is not
> translated by the parent v1 page table?

Correct.

>> When QEMU presents an AMD vIOMMU device to a guest, the guest programs the
>> guest DTE[GCR3 Table Root Pointer] with GPA. Then we need to :
>> 1. Traps the DTE write
>> 2. Translate the GPA->SPA
>> 3. Program DTE with SPA.
>>
>> With the GCR3TRPMode, we can skip step 2 above and directly program step 3
>> with GPA.
> 
> Do you want to support this? It will be hard to do because it is not
> just those three steps (which are easy) but that you have to somehow
> maintain coherence with any changes to the parent page table, so you
> have to hook the iommu_domain unmap as well...

I'm debating this. Let me get back on this part.

Thanks,
Suravee

