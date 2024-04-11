Return-Path: <linux-kernel+bounces-141236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715108A1B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288612849D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297055E53;
	Thu, 11 Apr 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KdCUFqr3"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67725575
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850791; cv=fail; b=eyI1vV8HZfygGvwQ5abwfEHBvVunxq+H2ez8y2Six0h2Zqu6GmQ547Qk8Srr+Hx0GYnosO4NDVuKnrBOpc+FO1vxhKGWhbGfeBYBlbT2xj/8L61f9TnJnC1DeoYSPfiJXS1/a9e4APxHiunPdW/g3bsqJV3gQYM2B200JBmz+MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850791; c=relaxed/simple;
	bh=IHytnkaCNDT6Qwc29B3D13oo9etG8Ik0+EP0ayKkPCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nr33qXr+58PCcX+hzIOtRU1dEU6wvRJUK4WqJ+zn5HN/CbzZ8dqeY7KAyGshFYIDvv/8HYkM0LxmDO9kWNvl53CzEdwBYn+VA13e19hQsAMBrotoXpkXdbmlz7VDnOC5iMB2B3Mv0zkVv7fg5SdU1nppLDAN0WU2XKnPCu/jRpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KdCUFqr3; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BEdtKp004211;
	Thu, 11 Apr 2024 08:51:55 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xdqc2wty7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 08:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Wl+FJcB0CpbW8iYptGBq/PV4O39OB/eEH9yCbhpUEmUtEVI6WXXq7T7DiCjDrug2rpOZAEYmKHV0IFdkIErssLJdzmySmttKdGQ+iPn9mTSTYq+vAj8a+JqYbfELAamAPO1AljArX67RTb/3gktafYCDnRwW6HAQZb+EUZSONMFk3EdYpV+XOxZ6vqqGAhSqDxwzAK2XmT5WdcseYNcfWIhtiB2LaSueuh/W5ns8wCO7RZduSVTYSMdw5dsAz0sgVm6uPpjEGOGLFIh0bN5MvZobPngQOTrEPaTRk4kZhxjvr/rgwot8ivZbRp19S4u78HGdSeu98bk5dQCRhOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Iiex8RieqOyHl9+g6+ChQ3l0H6gst2x5ffRSST+D84=;
 b=HMicq1taIsrCFX5hlaFphRRcNAm5fZB1/i+3/4LxG+UzFuwuLJCYCuSRcr5kz9XzZJG2jnMBSWUppkL4p8UwWw6FQorbx9XPFo1vlzvsE4NkNkf4XqsPZrB71FN4ZXaFLSiftoxAa0AqjG3FxmO7zeKD4Ea3bw+BdRU7nIlDyrdQkyApo5Jhm9wEJERDqnKRkB/epw4fvKW4wh++/XbEKdByA+wTr54QxrCQo7h45LjJedYcyK6upJG9AWVe4VdYaAYzsl9wpSHeXaT7zOaTNIUnY4vq23+/HqoIBeT9/EbM/zr+2zZNIV+WfYC7q7dsLuvSLbkoB4AlIOWtdz4bGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Iiex8RieqOyHl9+g6+ChQ3l0H6gst2x5ffRSST+D84=;
 b=KdCUFqr3DNQnAU1WLQp+M/XmmUW02Rfqpp/cECBdtH1DwAyu5F4ZSm8g2p98oKvus/rLuK1UCAD+HqMSJ/dFxS5xLphXy3YiAM2JiGusaxuuiBaYPxEFYSOFlv/hQ+oDRDj2ZECTRJjwMQyFEhU3kn8Qy6d37l+7ExKyg1FAdYs=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by PH0PR18MB4426.namprd18.prod.outlook.com (2603:10b6:510:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Thu, 11 Apr
 2024 15:51:50 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::fccb:7e75:f1f7:1c56]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::fccb:7e75:f1f7:1c56%4]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 15:51:50 +0000
Message-ID: <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
Date: Thu, 11 Apr 2024 21:21:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit
 on assorted symbols
To: Dave Martin <Dave.Martin@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
        Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
 <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::20) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|PH0PR18MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa125e1-fdde-478c-a9fa-08dc5a3f4d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WdHguA+6Buaa66KwUCg7yC1fIt4n0B6rFov1BRJIjRIoULeY5aBRwMxO9/BleR23XWYNXBdKZzzVhn5GHQUeejN0NyOmTM2e5GzS2NBAKygd2GW6EV+9Gr/AZrsNpQ/VDGatKFWWsDFF0yfaqlPP2aZcbzfXZKEJewSOCuLaMFnh/xtya8CIUNqqVCyuWmFHn4Z2YHHVMCk2R/N1mMAZwx/bEkGp426b+F6mAnnIfaudUvo9bx+1nA8f42k/IsSq0Et+75OTZsCR8zGVQuTSvdFxKmXBKhuaePnS09HUpOmnNZWmb881lXOyW+WvpS3LBdeVaBVuxsy6MtIra8o7LFyuQJ3aOccg6MuLR9H1B+Xl43SGsZ3/fEZUXoS5+J7P7XYx11fQLmdHKwNBm0CgliT1dTPVM/UpCBdyAd710u/64hJF6ZIJZiK8LMwYzlTCoFvy4V/cSzdkY/sOqS0ibtOIyv7eDh8JDuHk+HCDT9FlnGS+JavQdcl+kDD3uJluA7bLZ7A0iE1UNVA2Usqo7DmwmXv847TlIRcJaCFDt9uFM0iOhU6BhcNCuh5/rC7hBfdrVB6usDEo0WjRm/+JuYPoBhqnF7d4cZl0TEuRlkUjOqOyIlTybGD5dWdmHmy38OTvcvLQC1CmGddn1L78puUliet8rhpV80HU1n2DIBo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aG9nWXhIeXV6Uk05ckIvdXZxYVBSejNQMENVTTFPSnpOLzI5MEZJdVJDcENG?=
 =?utf-8?B?cUtFd1hxNjQ4VGJRUmQ4SkdJWC84Z3VtdlFsQlJ6T1dqUEhzMVY5TmUrTm9M?=
 =?utf-8?B?Nkw3TXZKNUNsYTRFREdJaUFHZWhyS1JEN0R3REdSSGlvUFBoc0Q0T0U1OXlr?=
 =?utf-8?B?RU1uOElWNzQ1WXJidm80ODZMU3YzZTZoSWk1Nm5xYzR6RktFZ05SSFM0THFH?=
 =?utf-8?B?TFFmQlJlem9qaVNWNjBSZ1Z3bXFQamJKMXZvQzNVNUVCaUV3Yjg4SzI3NlFV?=
 =?utf-8?B?Q252YnFJS3RycUJGZDFGbWx3SXU3bVhnY3dobEN0S1Z6MDUxM1YyS1FJcGRz?=
 =?utf-8?B?QU14a3Y0Vm5jUlFhSmJUUzFvc2ViRkthRXV2Z3d5UDFwbHdxMUFLelBqVXRM?=
 =?utf-8?B?NGxxRVpMZjl0TnRWSzIvS2V4Sk8vZFExeFJSdm1aNWZzeEhOOFBPbXNaajdt?=
 =?utf-8?B?cVgxUlRSZ3dzdDY5V2V6dlpGNzYzT1BJdGFHSldMd1ZWRVRRb2lDbVdyMnB1?=
 =?utf-8?B?dFFDUllGSEFKaVZ6SC9LVWRZaXpQVU5qMHB0b1JjbHlLMzBLRXNXdWtvWmw1?=
 =?utf-8?B?Ym1icEV0cEtHU1Qvb3FpZXY3L0pYamppaVhxVnp6eE5TVmZHOW1FWmx3b0RZ?=
 =?utf-8?B?TERISGZJc0hQQnN0MzNjWmMzVEN2YzBEZHBkOWNsWkxrYWtDd1Vha1FnNmIv?=
 =?utf-8?B?SzlhbThJRzVqclRnOUxjVWF6Ym15OUNCZUVKVlB1emZGb2pqS1lxS3h1MDY3?=
 =?utf-8?B?bHBWd2IzMUdXaTI5RGRVQkJCT053ZnVUUWxBbWpEaGFOL0xoWGRFNXRsakhx?=
 =?utf-8?B?cG9MaUFseVczY2wxVTJDbkx1RXZxcVdBVllmbU9tc1pYYWVMY1JUME1wZEJi?=
 =?utf-8?B?K0t5Si9wMU1IaDJFd21zbUJVWnBqUHJONXBjaHJJNE44VzM4MHVwRThxbUxv?=
 =?utf-8?B?SzhwaElISVlqdHB3S3dMNlFJQ1ByVFl4WU1pSEZKV045WFRWMElLV25Pc2Yz?=
 =?utf-8?B?TEcyWnpHU3I0VTFBYmNCbkJtVUovbHFmcW5VRTZRVFVoQ2phTHh5VXgvSDJJ?=
 =?utf-8?B?Y2hOYlBjckhzUUNVT0d1VjI2cHMvajY2VzNmSndTN2tEUTUvK0JNUm02Qkha?=
 =?utf-8?B?Y3gzcXVCak90QVBOVXBnS3V0cTRxWWdVamFlNDNRb3BWL21GeDZENHJiNDc0?=
 =?utf-8?B?RWJYMXpuNDhrU00vYUlDZFhTTzR1V1lGcHNnalh4cE9wRkplc0pVMkdvd015?=
 =?utf-8?B?eisxZFNsMXpWeUp4SDh4NnQrVzdRNWZob0ptWlVnSlBxZ0FYbGJuc0JyRXFC?=
 =?utf-8?B?YmtvSVpFWkhJWE9QdWxEVFRZNUJQNmNLTSs2S3J1dFZiaEtwZXN1bDJtZWZs?=
 =?utf-8?B?cm5sL2l4L1d6VWJ0T3VGcU9SeFZGeUFzT28yYmt3dGFQbXEyVkROdC9ab1Q0?=
 =?utf-8?B?ZG9Xa0tlMWNLa3pKU25lKzhZQXE3S3VTSU9SR2hKT2ZaVEtjckFBZTRtQXdG?=
 =?utf-8?B?SkVQUWh2by9nbDlhR3BEUURzZDJodHhOaXY3U1J2V3FIWjRxeVYxU2FJVW5M?=
 =?utf-8?B?RVVZQ0RBM3EzYmlYNWVtSkNwTUh6SEprY0tiTlp5aFdaREZOVEhJcHhiZ3Bv?=
 =?utf-8?B?RFE1VXVjZG14aDJXMVFCTE0rRGY1NitUMG5sRk9LSE5oYy9HTDF6VEFmSENN?=
 =?utf-8?B?WWx3Qk03UnJWUVgzNUlUaGhQdDNSU3RZSlhvUFZlRDE0TktOVlQ1R1RMdDN0?=
 =?utf-8?B?aXJDTEk3SThVU3pieHR6RHhiUlB1TzZ5UFZPT1Y5UHpCdGRhNFE3ZEZHNnpF?=
 =?utf-8?B?MmZjYktXUmtZUHAxTGdmRjRvOUowbEcwVHpua1M5NlpYeWdrN24zMmtOSnNR?=
 =?utf-8?B?bWpxT2w4ejM0Y2Q2em5IQTJSTEFxMC9WT1RqTXE3czZxaERuQTlHMmplR0Nl?=
 =?utf-8?B?RWlXcG5MV01DWGZXbVAvMDVydlFBMDJaTzlyMmRxRVJLUlBuL053Q2UwZ0lM?=
 =?utf-8?B?c0lIYlpzNVMySGhPQy9CanBFdloxWVYyZ3I3UVNpaHNuK3dSNHJZY3psOXMz?=
 =?utf-8?B?SnpORk9oOWlrMlhXUDdCSnRyLzg1eUtsc09zb21jZ3dmbVdtVCtSSWhPUDNv?=
 =?utf-8?Q?sQBHxHzI+wUGohlRM3HOqlwv8?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa125e1-fdde-478c-a9fa-08dc5a3f4d12
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 15:51:50.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbzqwEYiRm5wzs+ZUZ39OB3aad3+6GWyAc1OtKqYuZDOESuH1I7mLRCe5Pfhq7o7MsCsr7K2TAOX5BW/FQbeTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4426
X-Proofpoint-ORIG-GUID: ysbyWRyiOQavc4L682Dk0Flif0_MDjvU
X-Proofpoint-GUID: ysbyWRyiOQavc4L682Dk0Flif0_MDjvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

Hi Dave, Reinette,

> On Mon, Apr 08, 2024 at 08:32:36PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:51 AM, James Morse wrote:
>>> Because ARM's MPAM controls are probed using MMIO, resctrl can't be
>>> initialised until enough CPUs are online to have determined the
>>> system-wide supported num_closid. Arm64 also supports 'late onlined
>>> secondaries', where only a subset of CPUs are online during boot.
>>>
>>> These two combine to mean the MPAM driver may not be able to initialise
>>> resctrl until user-space has brought 'enough' CPUs online.
>>>
>>> To allow MPAM to initialise resctrl after __init text has been free'd,
>>> remove all the __init markings from resctrl.
>>>
>>> The existing __exit markings cause these functions to be removed by the
>>> linker as it has never been possible to build resctrl as a module. MPAM
>>> has an error interrupt which causes the driver to reset and disable
>>> itself. Remove the __exit markings to allow the MPAM driver to tear down
>>> resctrl when an error occurs.
>>
>> Obviously for the reasons you state this code has never been exercised.
>> Were you able to test this error interrupt flow yet?
>>
>> Reinette
>>
> 
> I think this will have to wait for James to respond.
> 
> There is code to tear down resctrl in response to an MPAM error interrupt,
> but I don't know how it has been exercised so far (if at all).

We are managed to test the MPAM error interrupt (on the platform that 
supports MPAM interrupts on software errors). For instance programming
more resource control groups (part IDs) than available, and It appears 
to correctly remove the "resctrl" mount point (though mount command 
still shows resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
), but

# mount -t resctrl resctrl /sys/fs/resctrl
mount: /sys/fs/resctrl: mount point does not exist.

Additionally, a question regarding this, Is a complete system restart 
necessary to regain the mount?

Thanks
-Amit


