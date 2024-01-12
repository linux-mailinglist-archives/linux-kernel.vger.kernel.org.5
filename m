Return-Path: <linux-kernel+bounces-24974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8E82C57D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99612820DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F111548B;
	Fri, 12 Jan 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SFefs9+D"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2116.outbound.protection.outlook.com [40.107.96.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06E13AD4;
	Fri, 12 Jan 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdgd8lkMx+v2r5EIahtJiXIV6E3ZhYa7mC2ZAY2SDfHEY2dOTaIySiCIQlRCtZ+qnHyZjRr0ovrGHhgdoZKx9ninKd27sqQBmWs66cSJhpttZraBAg86cXAn0PBqdUfqSeFiocYDfRtro33LI6D53GZ2ZAMNB81lYMjwXSeOcSC/YNo9jLxMBDZE7DqCHMPjgDtTvvHUBNNNWt37CnMPYGIXA9NGikxKW06jdRVYys7sUC2hCYeGzJ9S/jCpO8//ZLd0VNZ1Ao/919GJOzaCKHXmS8aYd4oskM3ZkaW2HRZDAPzK49HGca5CQyVD+IeOkm3dLGaHf9iybY1cLmXf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=simLBWeFkFi5vmBKOdXR0LiWpUH3LhJTfjJg3zrAMKw=;
 b=Ac/ZIQ2i/NjqWZg0TEsF/2slZMWFuKwn6Do+YMa9yX7IGzk4WGL4lETdTmt6y/ZjHB54J0Pzi5pdlzyDeYMywG7MwYRcBShmoOY+836swd6dwKxM+BEJH6t197JE+EZbqsBGDu0/C0CyWGVf19CGImldI5P5wiXXzQqZ9EE2MT2QZvalwOiUHVIGJmGQHUvrxEvfkpfbsU8qWD0L8NVLoBMTkBnQK/yb58Pe7/wHcMbCZXGKW4t0g7sjB9Gv432M2O5FyOJhJMzfAdhVZwbmRS19887a1FbF0d9AapElRjFrO3Bwqh8KFI7vahLIhKi2Ppf0QhDZfmHJV6kW7mslTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=simLBWeFkFi5vmBKOdXR0LiWpUH3LhJTfjJg3zrAMKw=;
 b=SFefs9+DY3k0USi9dA15B9P+Td9vuRPWwVjFufbLZmeYYvelVF6Rw2yhotumSWFq6Pc4L16lu6mzloftlRDaY4IOluD2zawiixwaochHZ3Q8YYMNNg5HOnLsNj7IrHFqre7aT4WdSpJL4hoTbsRHDO74FCzkYXk1shcIl3Pk7ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 IA0PR01MB8209.prod.exchangelabs.com (2603:10b6:208:48d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Fri, 12 Jan 2024 18:33:45 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::7c00:4415:9732:a74b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::7c00:4415:9732:a74b%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 18:33:44 +0000
Date: Fri, 12 Jan 2024 10:33:41 -0800
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rafael@kernel.org, beata.michalska@arm.com, sumitg@nvidia.com, zengheng4@huawei.com, 
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
Message-ID: <sx74toxx4ce2jayhvganvhrbkmoi7dnsk3hbzpcbco5wgxk3fo@2r46yhmsgfp4>
References: <20231212072617.14756-1-lihuisong@huawei.com>
 <ZZWfJOsDlEXWYHA5@arm.com>
 <9428a1ed-ba4d-1fe6-63e8-11e152bf1f09@huawei.com>
 <lnocwcitdbmgcyhd2dlczgdlhtfw4pfot2br2i3hqscnvr3xgq@nuxlauxum3nr>
 <d0f47e9d-6a58-8b46-89be-b3182abb69f0@huawei.com>
 <ZZwAmqp6hcmMF8aN@arm.com>
 <6505bdcb-5a5f-cba6-483b-75c51414a9c6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6505bdcb-5a5f-cba6-483b-75c51414a9c6@huawei.com>
X-ClientProxiedBy: CH0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:610:b3::15) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|IA0PR01MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: a3885f1c-c547-44ab-01cb-08dc139d0217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MC/dAPLCXhZP3j3f1ItjhtdGt2WZ3bak8h1W0DTqXrvni4w0/Malu0ROhgNX9+w3zABhPP+cvY9v3/SfanZ558vGp2d2Ah1UiX+2WDPb1ufB4maGGJD8Dxitb92xr1rZLYGwzVYhLcRgMq0UzaM8tVnHgxFNTLWXKuJhsPhgWtonGdCLCVtPouNJz+gVLMXlaj8+e/rXg+Iv+4y2zi3fcX2+VQ3qByoy4z7VPv8j0tHfJM8m2/dOz8x8KKyfgWUXMy//RyWPleaDu6zPtaL4fW6BDl20NcJ30kGpw/gKvpLHVRh/9COaJaSJm0tT5Ya7eXSD6R/65zwaJB8m239g+47eGCHLAmpI5h2RCXFgORuibZMOJz4VCMXb5CnJtZgiYJf6QCHgYQ+I7jcXTSFgOE2hUOm1TJARDiW2aYdK1s5BamAjOS8bctqtNS6IXj8KC4VrKaWEIMywRdv/yykabiJukmOFJNSv8oVpXL3Uq/7TGhFmtnIiHlviChaMUgF8ZVhb6T5a9H3uwKSOHBffLaXPVWrapi40qQiIdoJUhJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(41300700001)(33716001)(8676002)(8936002)(6486002)(316002)(66476007)(54906003)(83380400001)(966005)(6506007)(4326008)(478600001)(6666004)(66556008)(6916009)(66946007)(30864003)(86362001)(7416002)(9686003)(6512007)(5660300002)(26005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REFKSk9qWXMzN0JLTmxJVnMxeFlQbjkveEdvRTBLT1NTMmJuVS9qeTREL2xq?=
 =?utf-8?B?MHNBTG1jN1dZRmd6TGNmUWkwclEvNWlSbU1pWjRpM1hvRXh4TUpzbnliMmc2?=
 =?utf-8?B?VjNjQkx3NWFRbk5JYzJCNXRpZGYwZjhlaVRSVDJTL3ZwdVdVT3VqSk1RcWd2?=
 =?utf-8?B?YXM1RmN3MkdReVFtaUJXa1dYa0J2VWhFdzNNZWZHdVl2VFNUemp1QzM3VEs1?=
 =?utf-8?B?UkxWVHhVU01LbkNKRmIrd3NYd0JyNXFxbDlVTUh3eThYOEw3bDR3UXl1QTQz?=
 =?utf-8?B?TDl5Z1hqaHpSd0JqWk1BTzdnc0pCbmxqT2VNRUtvYUVtWWxsdStQb3AwTmpI?=
 =?utf-8?B?d2lmaHZmeVFqdUlWZmxLa2dPS01RRlgxOG83YzZmbnJmdjhjaVpKR2p1TkhH?=
 =?utf-8?B?azEzdEl6b3UzR1c4QlhEZTdkWFY3NDlla0h1Tkg3K3NYRGZzZVBCTThhMEVZ?=
 =?utf-8?B?cVd5ZWZES25rNVRZRlFXYWZycWVrdGFXYmwvMzk0U1JwckRHcElrNUN0cDJy?=
 =?utf-8?B?cUZ0K2g4LzhqOERtOUNOWThRRWdpc1drT09ZSlptNlBQd0JnWjJaRDN5YUNo?=
 =?utf-8?B?WGxDN09UN0tPcTVaeGhiWGZhdk9RYzQvS2dIcEVqOXNnSTRnZ3VSb0ZLYitE?=
 =?utf-8?B?d3VKVzArT2drL1hSUjJmQkhHVzRkenJGWmpIdjJkZFNBL2luUTk1bTRSOU5S?=
 =?utf-8?B?TjJzczV1YW9iNjNyRTB2TjJhZXJ4L2tFeGt2RWE4NXBETnZrVXluOW9BaW1a?=
 =?utf-8?B?T2poUmRQaGlwTnVuY2EzQm5OdFduWmczSDdtRnlDR3FySGVNV1g1TTVYT2Jt?=
 =?utf-8?B?Ti9KVjZwYzBZT3VHM1FoRVcwYm5xdUhvYjIrUDh2c01lYi9WZk93NGRaOEZJ?=
 =?utf-8?B?K2ZWV0lkcVlublJZcFFSVk83eGVUSC9FRE5NT1N2MkZBdHJBM1lTd1JSS0l3?=
 =?utf-8?B?akhvSlVaOG9lbXFGa0tNVmxlaG9URFFUVXZlVWhwdFZSZ0o2aVhvM1R4dHZ1?=
 =?utf-8?B?QWs1bnRmaXREKzBOS0ZvNDNrWFNaTzZTbTRFZzg4OFJlOHFUVnhid0E5aVNP?=
 =?utf-8?B?QTQ0QzUvSXRGa1ZJSlRBb0o4eDZFZDdSR0dPUEdVZlhYakcxc3p0M1diMnlN?=
 =?utf-8?B?andELzd5U1Z6SEZUd1FqZVZJVElKY3dDVVVpVlhYbjJ1Y0VxRzV4OURtajBU?=
 =?utf-8?B?VjRaMVpOZEg4LzhucXZhUU96cjBGZjNwdkN5b29WajM4OVNnamhSV0FnV3R6?=
 =?utf-8?B?TDA3MTBMd1FSY04xSWxRRDd3MzJXZCtOT3ZQWHNtVzNSZjVqUDAzVEt3YUtZ?=
 =?utf-8?B?MEV6VHphQkd6OXVIdDFjSE5jUEtJd2lYaE5RckR5Skw4RGhXdGxwNXRTelYv?=
 =?utf-8?B?NWlZQ3l3VTNXTWdqeUkyYUlTQXhaSjl3dm1Nck9VR0p3K3Q1ZTROVjJYYlYz?=
 =?utf-8?B?S3ZxSnYrc25iQ1MwS1VVR29JTTIwTFlQR293Rm9iNWpEaXFhMForeUJWVndY?=
 =?utf-8?B?c2ZkaXBnYkc2WWdrRi9qU3grdXYwODc1amZEeXZ6bFNVcVozSzF5cThQNFlt?=
 =?utf-8?B?NlNxN1c4Z0tjeG1wYWVwT0xwQzI1KzRpeUc4d0w4OWZ5YUNzMkVpdk9uUzFw?=
 =?utf-8?B?Y1lBUTVEWC9sbmZSNU92Yk1reVMvbTBxTXkrbEVKbjY2YzBaR2dENm9KVHhy?=
 =?utf-8?B?alQ0RWZiZE1yT1BhV2VITGprUDdYNkF0cElLaHpIeEphN0E4UmR3ZnJWb0Ev?=
 =?utf-8?B?Z3ZvSENDRnMzLzRqZHlVUktiZ2E2T0prdFFQRVdMTTE4UzBqVnpnZHZSMmlu?=
 =?utf-8?B?V1cvckFvWVZOY29HUzc0dWp4QTBjakI5TEpILy9QV0RmWHZOTXBaRVROWGNo?=
 =?utf-8?B?M1ArVWFkTGR3M1pGRWIzN3lFVkFNa0JYMm82UFc2NDc1RVJiUnZRYngwc3lT?=
 =?utf-8?B?K3RQZi9KcHEzTk9HSnlUZk4wa0s3T0NMWUovV2VRdHk0YmNMTGxvVFdCY0sz?=
 =?utf-8?B?NnRsb0NrSVpSa1lwZ25KcFZIR0tOVVZNMlRqLy9QNGlmN05jZGRDQjNQMmJJ?=
 =?utf-8?B?NlduRVNMbnVGdUJnZWwwNVQvK1lERGZ2bUFxclVEdkVTdXdiUE1aSGtDSUFx?=
 =?utf-8?B?WTg2Q3dGbmVlVjlSMm8zYzZCQmEwZEU0ZEZBQjlWWWZwMnVtQUFxTDFEb2hk?=
 =?utf-8?Q?yhWalRnrupD87sYbzm4kCUsrN4DOU58+bBFsDfZjwQE1?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3885f1c-c547-44ab-01cb-08dc139d0217
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 18:33:44.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNSdZ0gccqkjimgONcuTxTBYB6OiCdpQ9Hdx9dBmeamd1TAMk0w12VHLrJVBNWZEdBNZfRI44TfRupPSB60trZCHfgWl1hKJwld578t/cG50uVxPMDX+RI8VpaXP8gJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8209

On Wed, Jan 10, 2024 at 03:09:48PM +0800, lihuisong (C) wrote:
>Hi Ionela,
>
>在 2024/1/8 22:03, Ionela Voinescu 写道:
>>Hi,
>>
>>On Friday 05 Jan 2024 at 15:04:47 (+0800), lihuisong (C) wrote:
>>>Hi Vanshi,
>>>
>>>在 2024/1/5 8:48, Vanshidhar Konda 写道:
>>>>On Thu, Jan 04, 2024 at 05:36:51PM +0800, lihuisong (C) wrote:
>>>>>在 2024/1/4 1:53, Ionela Voinescu 写道:
>>>>>>Hi,
>>>>>>
>>>>>>On Tuesday 12 Dec 2023 at 15:26:17 (+0800), Huisong Li wrote:
>>>>>>>Many developers found that the cpu current frequency is greater than
>>>>>>>the maximum frequency of the platform, please see [1], [2] and [3].
>>>>>>>
>>>>>>>In the scenarios with high memory access pressure, the patch [1] has
>>>>>>>proved the significant latency of cpc_read() which is used to obtain
>>>>>>>delivered and reference performance counter cause an absurd frequency.
>>>>>>>The sampling interval for this counters is very critical and
>>>>>>>is expected
>>>>>>>to be equal. However, the different latency of cpc_read() has a direct
>>>>>>>impact on their sampling interval.
>>>>>>>
>>>>>>Would this [1] alternative solution work for you?
>>>>>It would work for me AFAICS.
>>>>>Because the "arch_freq_scale" is also from AMU core and constant
>>>>>counter, and read together.
>>>>>But, from their discuss line, it seems that there are some tricky
>>>>>points to clarify or consider.
>>>>I think the changes in [1] would work better when CPUs may be idle. With
>>>>this
>>>>patch we would have to wake any core that is in idle state to read the
>>>>AMU
>>>>counters. Worst case, if core 0 is trying to read the CPU frequency of
>>>>all
>>>>cores, it may need to wake up all the other cores to read the AMU
>>>>counters.
>>> From the approach in [1], if all CPUs (one or more cores) under one policy
>>>are idle, they still cannot be obtained the CPU frequency, right?
>>>In this case, the [1] API will return 0 and have to back to call
>>>cpufreq_driver->get() for cpuinfo_cur_freq.
>>>Then we still need to face the issue this patch mentioned.
>>With the implementation at [1], arch_freq_get_on_cpu() will not return 0
>>for idle CPUs and the get() callback will not be called to wake up the
>>CPUs.
>Right, arch_freq_get_on_cpu() will not return 0 for idle CPUs.
>However, for no-housekeeping CPUs, it will return 0 and have to call 
>get() callback, right?
>>
>>Worst case, arch_freq_get_on_cpu() will return a frequency based on the
>>AMU counter values obtained on the last tick on that CPU. But if that CPU
>>is not a housekeeping CPU, a housekeeping CPU in the same policy will be
>>selected, as it would have had a more recent tick, and therefore a more
>>recent frequency value for the domain.
>But this frequency is from the last tick,
>this last tick is probably a long time ago and it doesn't update 
>'arch_freq_scale' for some reasons like CPU dile.
>In addition, I'm not sure if there is possible that 
>amu_scale_freq_tick() is executed delayed under high stress case.
>It also have an impact on the accuracy of the cpu frequency we query.
>>
>>I understand that the frequency returned here will not be up to date,
>>but there's no proper frequency feedback for an idle CPU. If one only
>>wakes up a CPU to sample counters, before the CPU goes back to sleep,
>>the obtained frequency feedback is meaningless.
>>
>>>>For systems with 128 cores or more, this could be very expensive and
>>>>happen
>>>>very frequently.
>>>>
>>>>AFAICS, the approach in [1] would avoid this cost.
>>>But the CPU frequency is just an average value for the last tick period
>>>instead of the current one the CPU actually runs at.
>>>In addition, there are some conditions to use 'arch_freq_scale' in this
>>>approach.
>>What are the conditions you are referring to?
>It depends on the housekeeping CPUs.
>>
>>>So I'm not sure if this approach can entirely cover the frequency
>>>discrepancy issue.
>>Unfortunately there is no perfect frequency feedback. By the time you
>>observe/use the value of scaling_cur_freq/cpuinfo_cur_freq, the frequency
>>of the CPU might have already changed. Therefore, an average value might
>>be a better indication of the recent performance level of a CPU.
>An average value for CPU frequency is ok. It may be better if it has 
>not any delaying.
>
>The original implementation for cpuinfo_cur_freq can more reflect their
>meaning in the user-guide [1]. The user-guide said:
>"cpuinfo_cur_freq : Current frequency of the CPU as obtained from the 
>hardware, in KHz.
>This is the frequency the CPU actually runs at."
>
>
>[1]https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
>
>>
>>Would you be able to test [1] on your platform and usecase?
>I has tested it on my platform (CPU number: 64, SMT: off and CPU base 
>frequency: 2.7GHz).
>Accoding to the testing result,
>1> I found that patch [1] and [2] cannot cover the no housekeeping 
>CPUs. They still have to face the large frequency discrepancy issue my 
>patch mentioned.
>2> Additionally, the frequency value of all CPUs are almost the same 
>by using the 'arch_freq_scale' factor way. I'm not sure if it is ok.
>
>The patch [1] has been modified silightly as below:
>-->
>@@ -1756,7 +1756,10 @@ static unsigned int 
>cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> {
>        unsigned int new_freq;
>
>-       new_freq = cpufreq_driver->get(policy->cpu);
>+       new_freq = arch_freq_get_on_cpu(policy->cpu);
>+       if (!new_freq)
>+               new_freq = cpufreq_driver->get(policy->cpu);
>+
>        if (!new_freq)
>                return 0;
>
>And the result is as follows:
>*case 1:**No setting the nohz_full and cpufreq use performance governor*
>*--> Step1: *read 'cpuinfo_cur_freq' in no pressure
>  0: 2699264     2: 2699264     4: 2699264     6: 2699264
>  8: 2696628    10: 2696628    12: 2696628    14: 2699264
> 16: 2699264    18: 2696628    20: 2699264    22: 2696628
> 24: 2699264    26: 2696628    28: 2699264    30: 2696628
> 32: 2696628    34: 2696628    36: 2696628    38: 2696628
> 40: 2699264    42: 2699264    44: 2696628    46: 2696628
> 48: 2696628    50: 2699264    52: 2699264    54: 2696628
> 56: 2696628    58: 2696628    60: 2696628    62: 2696628
> 64: 2696628    66: 2699264    68: 2696628    70: 2696628
> 72: 2699264    74: 2696628    76: 2696628    78: 2699264
> 80: 2696628    82: 2696628    84: 2699264    86: 2696628
> 88: 2696628    90: 2696628    92: 2696628    94: 2699264
> 96: 2696628    98: 2699264   100: 2699264   102: 2696628
>104: 2699264   106: 2699264   108: 2699264   110: 2696628
>112: 2699264   114: 2699264   116: 2699264   118: 2699264
>120: 2696628   122: 2699264   124: 2696628   126: 2699264
>Note: the frequency of all CPUs are almost the same.
>
>*--> Step 2: *read 'cpuinfo_cur_freq' in the high memory access pressure.
>  0: 2696628     2: 2696628     4: 2696628     6: 2696628
>  8: 2696628    10: 2696628    12: 2696628    14: 2696628
> 16: 2696628    18: 2696628    20: 2696628    22: 2696628
> 24: 2696628    26: 2696628    28: 2696628    30: 2696628
> 32: 2696628    34: 2696628    36: 2696628    38: 2696628
> 40: 2696628    42: 2696628    44: 2696628    46: 2696628
> 48: 2696628    50: 2696628    52: 2696628    54: 2696628
> 56: 2696628    58: 2696628    60: 2696628    62: 2696628
> 64: 2696628    66: 2696628    68: 2696628    70: 2696628
> 72: 2696628    74: 2696628    76: 2696628    78: 2696628
> 80: 2696628    82: 2696628    84: 2696628    86: 2696628
> 88: 2696628    90: 2696628    92: 2696628    94: 2696628
> 96: 2696628    98: 2696628   100: 2696628   102: 2696628
>104: 2696628   106: 2696628   108: 2696628   110: 2696628
>112: 2696628   114: 2696628   116: 2696628   118: 2696628
>120: 2696628   122: 2696628   124: 2696628   126: 2696628
>
>*Case 2: setting nohz_full and cpufreq use ondemand governor*
>There is "isolcpus=1-10,41-50 nohz_full=1-10,41-50 
>rcu_nocbs=1-10,41-50" in /proc/cmdline.
>*--> Step 1: *setting ondemand governor to all policy and query 
>'cpuinfo_cur_freq' in no pressure case.
>And the frequency of CPUs all are about 400MHz.
>*--> Step 2:* read 'cpuinfo_cur_freq' in the high memory access pressure.
>The high memory access pressure is from the command: "stress-ng -c 64 
>--cpu-load 100% --taskset 0-63"
>The result:
> 0: 2696628     1:  400000     2:  400000     3:  400909
> 4:  400000     5:  400000     6:  400000     7:  400000
> 8:  400000     9:  400000    10:  400600    11: 2696628
>12: 2696628    13: 2696628    14: 2696628    15: 2696628
>16: 2696628    17: 2696628    18: 2696628    19: 2696628
>20: 2696628    21: 2696628    22: 2696628    23: 2696628
>24: 2696628    25: 2696628    26: 2696628    27: 2696628
>28: 2696628    29: 2696628    30: 2696628    31: 2696628
>32: 2696628    33: 2696628    34: 2696628    35: 2696628
>36: 2696628    37: 2696628    38: 2696628    39: 2696628
>40: 2696628    41:  400000    42:  400000    43:  400000
>44:  400000    45:  398847    46:  400000    47:  400000
>48:  400000    49:  400000    50:  400000    51: 2696628
>52: 2696628    53: 2696628    54: 2696628    55: 2696628
>56: 2696628    57: 2696628    58: 2696628    59: 2696628
>60: 2696628    61: 2696628    62: 2696628    63: 2699264
>
>Note:
>(1) The frequency of 1-10 and 41-50 CPUs work on the lowest frequency.
>     It turned out that nohz full was already work.
>     I guess that stress-ng cannot use the CPU in the range of nohz full.
>     Because the CPU frequency will be increased to 2.7G by binding 
>CPU to other application.
>(2) The frequency of the nohz full core is calculated by get() 
>callback according to ftrace.

I think this is a good point. It is possible that on large core count
systems a number of CPUs are isolated and don't have a kernel tick. The
approach in [1] won't work for those CPUs. The changes proposed in this
patch make sure that regardless of the scheduler or governor
configuration, the CPU frequency reporting will be correct.

My concerns with this approach:
1. We will wake up idle CPUs and query the AMU counters.
    a. This may not reflect the CPU frequency at the time the CPU was
    running. For example, CPU was running at 2.7 GHz, then became idle and
    invoked WFI. The CPU implementation reduces the CPU frequency to 400
    MHz when it enters WFI. Now if we wake up the CPU to query the
    frequency, it will return 400 MHz. This might be misleading.

    b. It wastes energy as we may wake up cores just to query frequency
    and then have them go back to idle.

    To solve this, may be we can cache the value of AMU counters; return
    the cached value of the AMU counter if the CPU is idle.

2. I think the acpi_cppc should use FFH registers only if the firmware
    publishes FFH support for both the delivered and reference counters.
    That way the system designer (through firmware) can control if the
    FFH registers are used for computing frequency.

[1] https://lore.kernel.org/lkml/20231127160838.1403404-3-beata.michalska@arm.com/

Thanks,
Vanshidhar

>
>[1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
>[2] https://lore.kernel.org/lkml/20231127160838.1403404-3-beata.michalska@arm.com/
>>
>>Many thanks,
>>Ionela.
>>
>>>/Huisong
>>>
>>>>>>[1] https://lore.kernel.org/lkml/20231127160838.1403404-1-beata.michalska@arm.com/
>>>>>>
>>>>>>Thanks,
>>>>>>Ionela.
>>>>>>
>>>>>>>This patch adds a interface, cpc_read_arch_counters_on_cpu, to read
>>>>>>>delivered and reference performance counter together. According to my
>>>>>>>test[4], the discrepancy of cpu current frequency in the
>>>>>>>scenarios with
>>>>>>>high memory access pressure is lower than 0.2% by stress-ng
>>>>>>>application.
>>>>>>>
>>>>>>>[1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>>>>>>>[2] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>>>>>>>[3]
>>>>>>>https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>>>>>>>
>>>>>>>[4] My local test:
>>>>>>>The testing platform enable SMT and include 128 logical CPU in total,
>>>>>>>and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" for each
>>>>>>>physical core on platform during the high memory access pressure from
>>>>>>>stress-ng, and the output is as follows:
>>>>>>>   0: 2699133     2: 2699942     4: 2698189     6: 2704347
>>>>>>>   8: 2704009    10: 2696277    12: 2702016    14: 2701388
>>>>>>>  16: 2700358    18: 2696741    20: 2700091    22: 2700122
>>>>>>>  24: 2701713    26: 2702025    28: 2699816    30: 2700121
>>>>>>>  32: 2700000    34: 2699788    36: 2698884    38: 2699109
>>>>>>>  40: 2704494    42: 2698350    44: 2699997    46: 2701023
>>>>>>>  48: 2703448    50: 2699501    52: 2700000    54: 2699999
>>>>>>>  56: 2702645    58: 2696923    60: 2697718    62: 2700547
>>>>>>>  64: 2700313    66: 2700000    68: 2699904    70: 2699259
>>>>>>>  72: 2699511    74: 2700644    76: 2702201    78: 2700000
>>>>>>>  80: 2700776    82: 2700364    84: 2702674    86: 2700255
>>>>>>>  88: 2699886    90: 2700359    92: 2699662    94: 2696188
>>>>>>>  96: 2705454    98: 2699260   100: 2701097   102: 2699630
>>>>>>>104: 2700463   106: 2698408   108: 2697766   110: 2701181
>>>>>>>112: 2699166   114: 2701804   116: 2701907   118: 2701973
>>>>>>>120: 2699584   122: 2700474   124: 2700768   126: 2701963
>>>>>>>
>>>>>>>Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>>>>---
>[snip]
>>.

