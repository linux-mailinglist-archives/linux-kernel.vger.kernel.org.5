Return-Path: <linux-kernel+bounces-25034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C977982C667
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38E81C225A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B209168D2;
	Fri, 12 Jan 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RHiEW1FA"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF5168CC;
	Fri, 12 Jan 2024 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2xNGFAU0UBAG2H6nQoBoiR8fJBsA8TRgfsYGXNzdtElfN1TbFZtOwAbif+629c6hrWZ90Rd12HgUCZ2Op/mWDny8TJm6F6fWyBdYPd7m79mmGnKYUcNVpi0QVFes9BM7QefszyfY6aqyMt/vnAvvV/X+yyxcXun03IY+hksOe1vQT9eeiENuIAmcHxj0O6D2473cJB0p2sM6+oJlqV78GKqWYpEUJfRaXYgzroqGXFLqZvMlv4bt5BHgzRxu45cKcHpR2X2PDW5JnMc2E0UGvjIbx+/0xW5JiPEIVwn2506rKHIXFi/4Zr5IrTh5QlnX2COrzM2d2h0+csOIH1NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOyc7CG0rhRV5kMQpUgr+WYQqD83C4DKg3DTMgJLmbc=;
 b=MV5SeE6p2FUtcz96iar0B+7LFvcgvRUvlSXR1cs+RaXcaahMJyk9BzU1m3haGFdOFOBVlLdWTZjJ75dTWRVimTfdZMSdQ+kbbYYkY2+zWu8wEP/or0ihgkoqoZ8sZF46eohdhnqjdsN6pU02ThC8vdoKJ3ZFXI+VyuT7uxcr2mnI6GMoGtWcXPezFoA3GBR07984sXzfcD8psSELEtymOj+T1CD6Qq9XNoq+jUK5zOrfy44p3wWFnvD8y9s7TG36E0fJwyL/NpPqykLVwH9ZrKirDy1sSMa0mUfpzPN2tgk+/CTywYYtxVPUmscrc4I4wXQ4+e/4ak63flCl1E8fWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOyc7CG0rhRV5kMQpUgr+WYQqD83C4DKg3DTMgJLmbc=;
 b=RHiEW1FAEum5BV4cz7P84h7SitI+pKWOYC/SPrDuh596JX2nM6kZJphldNHTsdEKXPJ8YXpJmtQ1u3yGhbNJLt4a3vQ0yZpCYxFGkAfHn8tfEPTHlIe7F8Dj1Ps5yPneB4UVODRfLrakb7188xXzm8T6f2s3eveH9LLj0oW1Qlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 20:38:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 20:38:27 +0000
Message-ID: <3bd2a660-82fd-51fe-f7cd-492908d90ca7@amd.com>
Date: Fri, 12 Jan 2024 14:38:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 2/2] x86/resctrl: Read supported bandwidth sources
 using CPUID command
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <ba1305bf2a29ce2667d01cf997718126a7ea607b.1705009003.git.babu.moger@amd.com>
 <4c5bb5ac-1e84-4021-845d-cafea5a1fbde@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <4c5bb5ac-1e84-4021-845d-cafea5a1fbde@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:806:122::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: faf8bb09-4fea-4279-b9c8-08dc13ae6e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qnB+7b/6Zkkgg/zaotQWjduE/M9/RPF1Y1QS3NJNtRlmwRAdYNYjFE0rf8ATSrEX/JlEcvR20EcxfaRbxuJJEfJp0lPiXhL2DoPM/f174/SmiBzhCnaGlInXmK4QZLKQqQI9Ox5R51B3g0U7thnC++2ZeJz42cTefjjIquKJ0aNgvrwaeTCSSXHkUiy3r0tAtF3yYw1PQQscUIRSqHJTbWlvQkcF7xHVaTYg8B1wnfNwf/dgsT4huPD4/vDHiwIfVy7rGUH00VlKPtegus7tOcIDMG16jmZjq85TY4BUnLtux7F63dzn4Z4qsV4Qrz9N4dJK7oD95UnuOK1ks1giGOAAbsj8TD75LocnAZ+W3tCkjLF/QMAvpbn+dsjGWvvAG1L5icSuYACqnrwLS3q7WMUfv5L++8H1nt9DePnDmvFhZntT7EZ6iWffqgpIl+vyZ0rJFAM+ahNjqPrumVy+w73iTpb3TmVJ2RjcyaBcYn4tvADUIMmQJPBD43NNoRuruhQcARy8DnyQOpXf5ZHPhNpCljRIQTM90YoLWcQAmUVs0mZv5+pUkf31DnL2uz6gW21s8XtmbXBKoF2Lp+Kxaoig1+58c0gHGFLKr15Oh9Y/vIegODw3NwRpEhCnOJBKI5tgRcDtl7alfU6UmM+GPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(53546011)(2616005)(38100700002)(26005)(6512007)(6666004)(4326008)(5660300002)(8676002)(8936002)(66556008)(41300700001)(7416002)(2906002)(478600001)(966005)(6486002)(6506007)(66476007)(316002)(66946007)(110136005)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3BNODAzdHNVMzIrbnJQc2JIQjZoeTRnTXNoMnd2QUJUOXU5Nk5HSVk3eDJp?=
 =?utf-8?B?aHBST1o5QkV6eVNBeU8wN3Bway9HVWNQYUNrUHplZnpCeWxHMHhVQ0xyRGtw?=
 =?utf-8?B?WUZwb0FRclJ3d2lMYkU5RVd2UjRXQWNWS01oZFM5RUVabU83eVByU3dEQ1du?=
 =?utf-8?B?WWdSZ2dWMG5PNFFvZnIzak5USmZ5QTg4SVFVNWNHa1FldS9SaVJnZXBnUjB6?=
 =?utf-8?B?Q0RGelZLZ3Q4aEl3MlhsYUFsbUdleVovQ0JJcndkODk5aWhVbXRtb1dGS3JV?=
 =?utf-8?B?YmhTaVNJelE2dS9TUkxFOW1jd0FiRnAwQythd2ZNNk9VN2Y2Ymo5UFRoT1F2?=
 =?utf-8?B?dHc4Q0FWL1F0bkVZVzBnbnFtMFBiakFWMmhUS21Wc3V3d0p5YzBaTStqYk5r?=
 =?utf-8?B?clU3elliUVNQNXJsK0F2L3N6cWdnUmo3SWsyNHAwMkRDZzdHdmJuUTl6ZzJ4?=
 =?utf-8?B?NTNwUTEvWEZCaVhMU1hjWTc4YVhFS0Y2VThlNEVEOElOK0hnN0hkQ2tQMkUv?=
 =?utf-8?B?ckxGMXJ2Z2dVVjV2ZGNwalJST0FwVm9EMjdsOTBxeGhzeHJldWRRSVpXd1VP?=
 =?utf-8?B?SU9lNjZlUVlaVUJHelFxNFdTNU15WWllbnZ4RWhEbHVwOWpsMkppTXRtWm9q?=
 =?utf-8?B?Z0poakt6amcyYlBMZmJ1MFhmanFiQ25oZzVlenNYU0tyYmZCalBreFhrbWkz?=
 =?utf-8?B?RFJUaVFYNmp4NXJNL0NlRkRIWkJRSVEybC8rUVBZOVBueHpPVlJicGJVdUZS?=
 =?utf-8?B?TDB4c3MvZmVqcXA3RVJCUFpzMmdiMTFzanl2cjdOL3A2OFhkS3BkeWJYRGVD?=
 =?utf-8?B?TVNoejZLNCtCT3I2a0N4QVAvcmMrcEVkZVFxVzBJOTJpTkxOSUZPVEU4RDBL?=
 =?utf-8?B?WTBYVTgxbjM3V3JGMW84d3BLK3YxNDJaZVBGRXhNclI0RStLZHFwNFVOMEcz?=
 =?utf-8?B?blUyY3dJeEY3bWVUeVRheWVtNmJ6V0lVYVNLL1dZSFNrdS9Bb0NLdEg3KzhO?=
 =?utf-8?B?Qng1UmxGRFcrTVh2NzEydCt4WWNHM0tWUlZoVkpmbXg5cDFwSWlibzVYR1JJ?=
 =?utf-8?B?bk0wMTAzNWVrMW14U2xLdUgvWGVEeEJUN1Q5U2tWUFBSWk1peFRMRzROY2lk?=
 =?utf-8?B?M2VVNFgzM1UyREhBYi9uUXpnTlpUajY3TEsxV1M5MXl3QzQ2SFJFZ0MrQXhT?=
 =?utf-8?B?dmlRSzQwWEx4a1ZRQWg5S3BSMFBEVUpZSUVNcDhpNHVGc2tLek1DQkFpTGZX?=
 =?utf-8?B?ZmRKdU5oSzhlZ01yQ2VHckRyd1FEdHNmRjEwNVZQUjRXYnhGby9HYnlsTFlF?=
 =?utf-8?B?VXhRZ3pEVU1qSWF0WVZxdkdUL0RhbGg5Nkl2Zjhkc0hWL3BSZmp5S3orUGRz?=
 =?utf-8?B?d00zdnBMT2h5ZERKL01uL09tRWNOeHZLRGRsQ2lDRlNHUnEzOUdlN2dlZDBv?=
 =?utf-8?B?V25sZzdvdkxpN0c4ajNEbW9DMDdPVkJNN0xTQWpwMGRpVGtEdTJzd2ZQNzdz?=
 =?utf-8?B?VlZ2WUFMR1Avb2xsZi9MTjJ2VXhya2dZUkY2ZWpQTjBYL04wVW1QdTVWOGNy?=
 =?utf-8?B?UVE2NFFVc1ZlNU5lcnFnZFl1MUdialRScEtxTkVTZWZsMEUrLytZbWZTcTNl?=
 =?utf-8?B?SmJjWDFyekwxeXAybkhFS3BFU25JelgzWS9UdC9ZdXJkeTNsTnRwMkZWcEVm?=
 =?utf-8?B?SzZiUzF4c0wrMHZqQzEzRnZPTis5emRsdkFnc3pWZnlmOWpCdmowZC92MktO?=
 =?utf-8?B?ZGNnajFTRDZmc1I5U2JVMmtFM1J0bWxqWjVBVXB6LzhTaUpVSG83RnBySHZq?=
 =?utf-8?B?Q1U3MGRtclkrdlIrVmRFS1Y1UHFlNWVMeHlnMkN0NjBvc2RxcUVjczYvQWgx?=
 =?utf-8?B?WVo4emtDOWdtenVoWGEwalIyNFZOMUpBZVhYdHRWdU84empNVjN2SDdub01K?=
 =?utf-8?B?OWJSbTNnVzJVWllSUEQ5cDREUmlKU2FEbEtsN2RremdoL3p4TzFYcThoYmZ3?=
 =?utf-8?B?S0lpeFh3eVIxMmVCUUFYZUxCU3BiSElkejFGcS95K2Y3VTViTkQ4OW41TE0z?=
 =?utf-8?B?QnZQMWp0U2ZqdmpPTzlTRERiMTF2dVJGaGtBRW9yNVNwNnRrVnNSRHNQZ054?=
 =?utf-8?Q?g/kUWZ5A7G5R61jVogQj3nLmx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf8bb09-4fea-4279-b9c8-08dc13ae6e4c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 20:38:27.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3xeYlf8is9SbYM6rabzJygRx/4Am+xgXmvcQYQFC4hv/t8iH9nm9ELPRjLR/ds0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

Hi  Reinette,

On 1/12/2024 1:02 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/11/2024 1:36 PM, Babu Moger wrote:
>
>> @@ -1686,6 +1681,13 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>>   		return -EINVAL;
>>   	}
>>   
>> +	/* mon_config cannot be more than the supported set of events */
> copy&paste error? There is no mon_config in this function.
Yea. it should be mbm_cfg_mask.  Will fix it.
>
> (copy&paste difficulties reminds me of [1])
>
>> +	if ((val & hw_res->mbm_cfg_mask) != val) {
>> +		rdt_last_cmd_printf("Invalid event configuration: The maximum valid "
>> +				    "bitmask is 0x%02x\n", hw_res->mbm_cfg_mask);
> checkpatch.pl should have warned about this split of text across two lines.
> Logging functions and single strings are allowed to exceed the max line length.
> If you just merge the two lines then checkpatch.pl may still warn for resctrl strings
> but that is because it does not recognize rdt_last_cmd_printf() as a logging function.
>
> You can also just shorten the string so this patch passes the checkpatch.pl check.
> For example,
> "Invalid event configuration: maximum valid mask is 0x%02x\n"
> or
> "Invalid event configuration: maximum is 0x%02x\n"
> or ?

Yes. Checkpatch reported error when I split the text.

How about this?. Checkpatch is happy.

rdt_last_cmd_printf("Invalid event configuration: max valid mask is 
0x%02x\n",
+                                   hw_res->mbm_cfg_mask);

>
> Reinette
>
> [1] https://lore.kernel.org/lkml/cc273d98-d73c-49bd-8799-b119966e226c@amd.com/

We spent quite a bit of time on this earlier. Yea. It did not go the way 
I wanted it. Now, I needed to get back to higher priority tasks.  Will 
pick it up once, I am done with current priorities.

Thanks

Babu



