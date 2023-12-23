Return-Path: <linux-kernel+bounces-10204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCEF81D12A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C601F26B85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49C1373;
	Sat, 23 Dec 2023 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iODX4eP5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3864ECB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0Qgf9ZQCngzcIJbgcF/YgNLhljcZZ0PI/X5jFf/No9G7fChUT7ZY542lLSVJJ2FgcV1jMr5x6+ym6LV8qZx2l5Opt6BFUMLvf0ww8v7V3/RbYMqBvxe/8lXR78usQa9E9uwtl62PGoq1FTvPn+hDXI9bssrtCUPVaqqQ+zFeNk+G4qFo4Sl3rC8GcfEO0Etgsnx63Izbi1vbT4ijSqB8ZRQM7+104/1HVFzHepD9sLsvbotmJkV+hYSMgxQLwJTbjvc2fdLhpxMSrXFga+dcFBK7fxS2k9YmQNrj7WhTuMQY2WmWuHqyDhKnGYP24kR4CEEEVdp53qKKmuMHp3DtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnfozvaNLJbdTmA+URUbXIJ6MI3dYqBOC+fluEDa+mU=;
 b=e+isczMB3Sb6MqkYQyLxEnJ0seRyzWR+b4Uucj5iFw34LADChoISn8FgfWs4Ofiq8H0LiBwUQKBRzm4tqok2TahwvYm5tThcVnx6yMlSTMSoVvi/NQvXYcGiCQ9ZVSRjDKR30HSSEQ1kOlrqulL/HPsGtiQY1T/XX6r0mpsF6EwwmCGBTNYCUmcfSj4OM3xYOeNMayBWPTIUd3Q9tIpgpvHdjIcd5lHCmZkzZ42kuHtaK3i666VQzoEt//Wr7x1A565ZJahq2uhaxYi0kufdx1NMUAQP9uffSIA0jLIfE2ZAKhYYJYVRBbfS5dPb39SCUTd5dJvMTcOtRKDqzS2FUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnfozvaNLJbdTmA+URUbXIJ6MI3dYqBOC+fluEDa+mU=;
 b=iODX4eP5kj8qdcIo7gW+6TQA1E0dZWaP2dx62gX8xM2fDu/z/xtTEeRWPLAA7wCtchZ36Wcuqn+jU1Wr3q1bgHsnsdWmsoaU/L+BufG5T6C5pIEaDfEN8VkcduPKpaf/1TicnHpJxNwsf9IPHDguE9SRNx1d/NgQ++laInmzGhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Sat, 23 Dec
 2023 02:04:31 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7113.019; Sat, 23 Dec 2023
 02:04:31 +0000
Message-ID: <a5b4c3ba-9d72-4127-abae-8e547b2cca7b@amd.com>
Date: Sat, 23 Dec 2023 07:34:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drivers: soundwire: refactor soundwire pads enable
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com,
 venkataprasad.potturu@amd.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
 <20231221073558.3181911-5-Vijendar.Mukunda@amd.com> <ZYRqEbVADgU4fNtB@matsya>
 <6d98c43d-fb90-4cfa-a22e-8fd6d5a6eb50@amd.com> <ZYVVD2mL5kAePXDE@matsya>
 <0ab000c3-be7f-41f3-8017-28738cf0a698@amd.com> <ZYWvNxpLPUGCGElA@matsya>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZYWvNxpLPUGCGElA@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cffa51-7651-4648-5fb6-08dc035b7fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0QS8Dj2K+mNPwQvRNmEsXLkUdciq0vIoFemV1ORbeyIw2IUfw5620Cd/WhdE3G4n4mGwhd66BW42c288xD9/Gk516u8hNRjDCiqHm39M9ui0103a4+eddQU6xT8fVAJlu2j1M2JcJY4Rj4TvVuESTall6ZL6YchuflGuCqGeNfA3Ye4w3aAfzvatxQGX0mVJZfLQXzlzdl0OI0ez75AX+sGyHhKnBVdEui7w/DPxYXOY3P8nfSxB/pqk7s94eseUd+6bD27tMLHMGYI1CafHAGP+TQw7XnoX5SLnhpvn8mvxrPSTXRt2OufV6ZN1jPpt3OVpDT0bpFS02tcPfC4LMnRTQN6vZdqrvHqp5v/Nd9zjB0G9YuaqISweUpR9oCAS8NE6BCAPS9DEovBe973Xnz6KtYpoHCLTS0gQXTB1fPDapxNAAdC14mNLLeKmLvZ+uDSuNkquzfhmRebWpcZQSljyUM+76AaiBSwLQu7A0/ubOfdONmcJ9QGwKXho8YEga0sBpSRyiUwcIQCn8gv5DdRrm9FH1NKVBtEUMuZ6z9qq3BdeeNN12XdJEqqrljQiDVJr6ZDn9Qe4HLdje0AdsEvhfyj4a63WsLFFg2ZwbKnXWNrxSzE6wdNN7zpryKAiY5oiykH8WHJM2CH4Brp7QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4326008)(8676002)(8936002)(66946007)(66476007)(66556008)(54906003)(316002)(6916009)(2906002)(36756003)(86362001)(41300700001)(31696002)(38100700002)(5660300002)(2616005)(6486002)(26005)(83380400001)(478600001)(6506007)(53546011)(6666004)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldVcXlDaGw3MnFqSGczOVZucDljUTludUhjdWQxbVRYVWJuYTlHSG8vTDJP?=
 =?utf-8?B?dmVGL2V5dkprVlFaVVQ1NzZqeElaT01hT2dzaitvZkZJems2SE5ocE1oT0gr?=
 =?utf-8?B?VUJRNmxSMGY3dnIvN05jd29DNGVCQkFFWTlVMEJnbldXMWhIalJmc0NrZU1t?=
 =?utf-8?B?azdjZ2FhL0VwL2F6aXhObzBiV3JYNWRkRUxUQVhVMGxwQTl5STkzRnpGRkFz?=
 =?utf-8?B?anF5TDVmdnZaYk5MRVYwNm9ycndLTGh4Z1l3QVNzY1ZkaFdLYUtKZ3RzMUhS?=
 =?utf-8?B?WFRLRU5adFVOR2NJV2wyY0xVdDhIYmppUVhKdFc1V1gxYVBDRlBNdGx3WVEw?=
 =?utf-8?B?emJyMjBqN2dMYjdrVkNWZTI0MldCQW9BUUh3clBobWdXS2dVdmkxVHhOSjNh?=
 =?utf-8?B?L0VjMXFiWWtmTmpISjhyTGxTZllwWTgyejZCSHhyZlNKaUFSWElsK3p3V1lB?=
 =?utf-8?B?Nis4cjhvOS9iWHloV2RVWW40eGNaa0gxRks0UnJQN3NYRUVlSnV4enJxeHVY?=
 =?utf-8?B?b3pvREJjcDZUNXEyL0FvY3M4ZUZuTlZpVjZObmJvVDdmNUV3R0V4OHNxbkpx?=
 =?utf-8?B?cTA4YkIwMHBtTkcvdFlEaDJiZEY5cHpsT0NTQnc4d05ud0FKTmdUM2ZXaU5C?=
 =?utf-8?B?c0p4NU5VL3R5Y3JZZENlR2Q2QjBheXhuWmpoSHJNdnR5eVg4eElWZVQvamZZ?=
 =?utf-8?B?anhJcTVnTW1rT1JXVzFRZnlFVWl0S25tekhxdGpPN0JyWFVIeUQ3bDk3L2pG?=
 =?utf-8?B?Q2ROMFRUSEN5Ty9VQXZWOHJNc1RNc09jU2Q5aFJPdnNoT0N6eGJoOW1HZXg5?=
 =?utf-8?B?MXllbzlqNElSRUdLU3lRZWxmRTY3b3NCOFpmTlhpWVZ5dDZpL2pOMTRLck5k?=
 =?utf-8?B?L3FPNHBtTE5TRzZSTTlKWW9OcXpCSXFraGR5N3BEODVyQnovZXVYamtQc05t?=
 =?utf-8?B?Yk1DQ1VyZ0s4LzV5M2prMmFKODJsaXBwN2k4TDMrR1hpc2h4dngrUFhFbkd5?=
 =?utf-8?B?UTJ1NldUYjluM1FkVnpvLzN5a1I5b1NLM3ZWRlB6Q0xYSG9mbmdwdno3Y1ps?=
 =?utf-8?B?eTE3SUZlaEt0bEFxSHBMTVdjcDRoS3Y0MDdCU1Y5dGJRR0Z2R3ovV05NWG04?=
 =?utf-8?B?VDdEQXRtcnhXS2RmYW9DVFk0ZWdZdm55Zm11emUxZ3R6WEQ4akZUTUhkN3J1?=
 =?utf-8?B?eG5VTHd6dSsrdEttb0k5aDc4VFYwQmpMZUlNekpwR001d2V3NzNzYkdIdmlF?=
 =?utf-8?B?YW4zeDRBZVdJanBHVlJwWG5ZT1lKcnlScTlBRTNzd3NMQUVzREswdllCeXlp?=
 =?utf-8?B?SXEzdW5pbGFCZ2hrR1VjdzNIbE44NXlTVHgwc0RDNmU3RTFWdkZJMms1M1JM?=
 =?utf-8?B?UUduNnF1VTV5YWRYOE5Yc2lsYWs5ajE3ck1mWU95VDFaa0dpV05nS0drbjlF?=
 =?utf-8?B?WjRRUE0zTjJoNy9GSzNtaE50WE4xTE9STDloaUlmNy9HbG1IeU9WTkpCSk0z?=
 =?utf-8?B?UHpSSDlxRFQ0Uy8xaCtuT2VudnBnbGZFMndtZnRwR09lVzBvU2d5VVRwZys1?=
 =?utf-8?B?SXZrQlFCOGJjUDFuYnJ6eVpwbWtmV1hqeHY1cDJnVHpiZGlFcUwrcE9QaVpL?=
 =?utf-8?B?ZHF0c25acTFWSnJjVW55UWN1Ky9VenVKdHVJOU43MGliU0hlaFp6dkh6SmlV?=
 =?utf-8?B?aFA5M3loK2dldUNvTzM0RDlyem1VS1MrZUdTWXppS3ErSHA2UVNXcXdHRUx5?=
 =?utf-8?B?akUwM0hWMVozQjVrVWFKdHQ3R2ZpbzNVOXE4eVdHTy9tbHZnUytqWWZLbUho?=
 =?utf-8?B?MmYyYm1pZ1JyWi9GWUIreFczaUthSzJKZFlxcjNaVXhBclNjWEFMcGZVYkVN?=
 =?utf-8?B?a2ZqVjBGVWMvTDVXSGpkUHJBZHBaR1dJZVFNd0VwNWRJRlRieWlqTE92QkNZ?=
 =?utf-8?B?WmhkeFJqVGV6ckp2clNCMFpjSnFidTRLZjJXQ0RjUzRabTNldVloQ3BBR1po?=
 =?utf-8?B?RnFPQStCVE9CNEpZMHZSVXJ1WWU4bEp1SXU5ak1LZHp4cWNtVGQvdzhZWHlC?=
 =?utf-8?B?aHlXMWZZN0pROE8wN2JJSmtYRXlYaWM2eVhwbkZBNUV6ekEwOUFYbXQrSUZr?=
 =?utf-8?Q?0aqV07IpK1c5BW6JA3VCyLfr6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cffa51-7651-4648-5fb6-08dc035b7fab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 02:04:30.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oANxEhy5mzphvo3CzW2JYb79VXXcnyQ73c1PP7XtULgLkCjN7SZBZKnlBTKtzYhSuCCXKqeLQeIZSeDAx9myXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642

On 22/12/23 21:15, Vinod Koul wrote:
> On 22-12-23, 16:04, Mukunda,Vijendar wrote:
>> On 22/12/23 14:51, Vinod Koul wrote:
>>> On 22-12-23, 12:45, Mukunda,Vijendar wrote:
>>>> On 21/12/23 22:08, Vinod Koul wrote:
>>>>> so the code is copied from a GPL declared file to now and GPL + BSD one!
>>>>> Have you had lawyers look into this... why change one file license ?
>>>> As per recommendations from our legal team, we have updated the license as dual
>>>> one for amd_init.c file.
>>>> We have also observed that license terms should be updated for other files as
>>>> well (amd_manager.c, amd_manager.h & sdw_amd.h) as dual one, which we have
>>>> planned to submit as a supplement patch.
>>> Lets change that first before we move code from one license file to
>>> another
>> Will push the license update patch first.
>>> Btw why would you want to do the change of license form GPL to dual?
>> As this code being used by AMD SOF stack which uses dual license,
>> So we want to maintain the same license terms.
> SOF is firmware, do you share this kernel code with sofproject, that
> doesnt make sense to me, maybe I am missing something
We meant to say this code being used by AMD sof driver stack
(sound/soc/sof/amd) which has dual license.



