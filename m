Return-Path: <linux-kernel+bounces-18424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A21825D3F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BFB1F22A30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78D364A1;
	Fri,  5 Jan 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uF3FpW9/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224A360AB;
	Fri,  5 Jan 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Yv5coFaHJfiL4CyoMEaC+IEzKfiT+EmORANB/rKZxoQivTfZHgG5d7VxA/RLnLMJLDm2a9AVwG5a6iEacZkrRaaYGiccaXIrPsm60XYpDmdJYJK31uqB6QKGMSJ8UaLungDrgjB2iW+Dpfsej+7CjA5cAVJGE3FRoNHkvwP/dYbnHg3qf0hz9+vKsu7xs4uK8QCjkYrn4o6XlZwKnXhsprgcSdpQ7YxfqXWcqzvwGk70w08Da7NgkVEdUb1axdWid/xHwNs9aod9WZVe3PSOd/XLuirmKtfwGyB5RlLy3ypLjjDvnPper4Kc3JUItR5obvX/X5oKqIe0YpdFH60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njMk90Q7Nv79qodb4HGzSbLQ6v4hHNgBf/W70xLLERg=;
 b=lzl2NMj1U77CA/+PmPQZp553/XSu9txpcJBBsyq8Cnreoxy36c2phtDAR+AwBfBUrRmA/9KVa/SfD/ZtmvJZ02z8kCknj72ykDl+bR4eihViPyZmE/2F8mp4hT02cXsirf06fDgMsxZ4dvzikrEd1MuqaURkWkG2DklIROGHDkXOgr5hhlzz8WUPXNJ4c5iYQd5bJtmA1c61qWXDIzEwqprIsElBXIgr2VgbGtByZdwwsajRa+/UK80TL+bZ03JZDijEEKWknxHJ9Hd+S42iAbyFDTlpt4yiVzx1bqrQGp6DXDdVdEpwevaooHzE8LtVJe3rZ837jb2VUll5ATJA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njMk90Q7Nv79qodb4HGzSbLQ6v4hHNgBf/W70xLLERg=;
 b=uF3FpW9/l7nFZu5rKiADXeK/+k57QscucCN8ODEnOUEUpU6hzOR4ckqGsyUe19rVE0lJdW5Zld1FcTA6f4lZsTKb0cQ9TslEeiuB8T+EWTvvx4xe8+A7r6uu6A/33MRCnXQbPE39b+rxlvuwEFxdR8p5dUE8lna55LJgV2x1SZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 23:51:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 23:51:35 +0000
Message-ID: <3e1a4b7c-241d-032d-67ca-6eecaf57fabf@amd.com>
Date: Fri, 5 Jan 2024 17:51:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 1/2] x86/resctrl: Remove hard-coded memory bandwidth
 limit
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
 <20240104212130.209490-1-babu.moger@amd.com>
 <5a3624d1-0801-4418-a179-38ea83c40c94@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <5a3624d1-0801-4418-a179-38ea83c40c94@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:5:337::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b392998-23a4-4392-b39f-08dc0e493fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HLZta8cLyAQbN3Fqf4HLprAqe/Jqj2Zhh0y3tyzFc5HutqTRGJFSVEkAOMVvqqGsLxWt0Ag9iUi0lvOYAQG1wEMtMDmCkSofiy7bCTe+9cJD3xRV1blAK54B8ijbGQ+5AvqQpPcwdh26ndmqDh9iJkwE0jxCu3cOZ+s/TuYLno2vKbI+qbPFJUoJmT6T7jvR1o+iafoZmyQ0ZKQpAHExpkNk77mj1sK9CDIv0mPNc0O9SzKymuygKng0/61QCD5dU+jX/uLtP2UJWPSgEQ/yjcGJoOOqNSmVO9gz7QC53IAPg0yWioDrmNOkRKmiUBzBc2RFtVFGwrXUmzcLVtOK9c562qq4BdGit77VxeItDltigXeVIbwyG/c1+nvsGVty4iaGo5Bw/11qGqrNCayuHIZbAIZxhNYfbXNUuD4cKhhmoLijxEMr/bq/604hfZrR/Hk148W55MpRxf/rnJrfmGlCJHxJWqtGRQuyutOutRDXKEa1gsu/UV41xDQl3pp0jcsrHVWI/iZ0KNigXaDOENdf0b6HiBsmTEHanfBo4TpHtua6hw9Pd6tERtNsqa6tuGq0fSF1t5w3IgG2xHFcphod2GM2NmtcOxUKdDK8Xu7LsiqJXbA21JEuaKITc/Ti489wvucel/GfZQ6vel9MQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(66946007)(38100700002)(31696002)(31686004)(6506007)(6512007)(6666004)(53546011)(2616005)(26005)(36756003)(7416002)(5660300002)(2906002)(966005)(110136005)(478600001)(6486002)(83380400001)(316002)(8936002)(8676002)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdMRGxIek0wL2pkS0hPTzdXanIyQ1pEczc1eXowTUdITllFOFROOEhRVzk5?=
 =?utf-8?B?MTVKQ214TW1aek9SbmtWUHhzRUkvVVRBNk1wTURNL3ZGQlN3eVJEQ1NFNjZW?=
 =?utf-8?B?UVVOYkxKM3lST0JGUmFIQVREZVpwdkdUT3NNSDJFMUlFYWlGckVCeE50MDBu?=
 =?utf-8?B?VDB0Mk1UOVhHaG8wSDdodGxVZWQ1cG1UZ2dhYmFKaHpkQWE1UVg5bnNqUHNG?=
 =?utf-8?B?eWoyd2ZYZFdneTJQa1dQNlBTRDZBUjEraVpaeG1hTnRDYUdXVFpIL1EvRERo?=
 =?utf-8?B?SjU5dE82VTVQNlV6T3UvdURjYzgvbGNFdE1oNmJZd2gyc2ZoU3VGd2U0b3lr?=
 =?utf-8?B?RVBBNGtjSGE5bUN0SitjSERSdkgvLzNjTjlSdHdMZkhoNytMbnBOUEdrOVVG?=
 =?utf-8?B?WVlsVkhBb08yRStQYXJlZFpSQ3M4bU5PR3NNV3ZkNFcrYVlNRnNPdVU1WWdW?=
 =?utf-8?B?OFhGUzFxVXFMMktEQU9Fc3FkMXFNd3NhQ0VpNVlJUzJWcGc1bFRVSmJ3Rm1U?=
 =?utf-8?B?UTFiQ0E5UUtiQnA0ak5HNnY2cWVoeERQMGdLQnBqc1V2UC9qVU5hUmZOcGQx?=
 =?utf-8?B?dU01ZjVWUysyckZadU5TR3orTk91cUNaLzBZWUV2OHJaMnFHWWJKMVRJblpt?=
 =?utf-8?B?Wk84S2VOejhoZ3RIUzBhWnh4ZGZvM05DcjZiT0hEeEhpWmhqbFhOZDZSN3Jj?=
 =?utf-8?B?MnlHdlN1N3R4TVV5V1MxcWdpMWhVR1R6YzBWeUJVSlR6RWgwb1NJNFVmMnBQ?=
 =?utf-8?B?WC9mM0lRUEVOSGRhaURILzBTWE9pTDJHV1hyMjBQbHRQYnZZbGxuUW5NVzY4?=
 =?utf-8?B?eUNFWEUzVVJ2d0lHOWdYV1QyZERnc0pnak5IS24yRGIyb3JXZWFXWkpIb1VQ?=
 =?utf-8?B?N0NDWHJScEc5RW5YcDl5WmJ0dmJxR2c4TG9mL2diMzNXcVllbElSUlZRckxX?=
 =?utf-8?B?b1FHR0pTV2ZUR2cyUUgweUlLLzRuRi83MTJOMGM3Y3F6RW5xYUpHZlUvVEJv?=
 =?utf-8?B?cGJUQ01uUkk3Z3N0MDFqQzhTYlh6bmxoVjNyNHlDb1dSOXFudWI0elNaK0hl?=
 =?utf-8?B?OCt3MWhuckNqTHJ6UkdSMWR3MlV3L0o3a3l0c1ovVVJzOWZEV0xoRkVKd0Jo?=
 =?utf-8?B?dWozTzFlU2tUaW1rZlRrODhlck41d29xQUNTem1mbHNLVUNlOUIzcmx5Mjd0?=
 =?utf-8?B?R1ZzZC90cGl3NEFlU2M5OEdSL3Rvc2cwYVdJMVlxem5tWW1oczFnUTM4T3kr?=
 =?utf-8?B?QWRXYU1qUkltSm9ydGpDSU1SWElkVFRWTmcraCsxdEZKanlGOUNBWkNMRHdC?=
 =?utf-8?B?dFBhWmI5cEh5Y2VwMWRLVVdkZUZFVVRHWklWSzA1SnVKRy9WTHNhcFhMMFZx?=
 =?utf-8?B?amxZRFp5V0g4RXFNOGJWM0ZkNXNKOGgrcStFRW1NOVVVUVlDWWRBUlE4bENI?=
 =?utf-8?B?TGRYeEJKdXFNbThTR2VGUnMvTE5lYnVPSHI0MUtuS0NkSFpyMFBhWFJhZUMx?=
 =?utf-8?B?OU9TRkRSVGE3OS9rMXAyWUJnbHY5RWlWQVJOVHBwdURqeG1wOEtFOFpSVEZ3?=
 =?utf-8?B?d1dVRVRrVHNLZ3lHZGNSUFV5Q0R5cEJKc2dRNE5LdFp1VHlEcncyYnZ3akJm?=
 =?utf-8?B?czhhTjNENlQyenBXaXBZYWZrbDNVejFmN2g5MzhvT3lMQ3h5RzJjWm42QnNH?=
 =?utf-8?B?VTVaRDlEaU9lYlkyeVc4MG5NRjFzSm10SFc5SDZUYkdzQzNaT2pJRTl2dHh5?=
 =?utf-8?B?OFZmRXF5Y0Rva2hRZm5yVUxweUhTVWZWcE5kcGVyYjdNbGRvZ2piSlp6Tmo5?=
 =?utf-8?B?Q1RXVzEzMlVFQmdBOWt0c014a3dVSTdTM2p4bHRXeStJRFN6N0NFYUtMNzlX?=
 =?utf-8?B?UWlNMEVKbWhZckxnc1ZrNDRDYlZ1VHdzNExqMVU5czdjd0RIRHNYSDVBSG1i?=
 =?utf-8?B?SGMwTFd3S0lXUTBhcWUzYkpMRHdRWGJxc3kzRVV0a3pGVXBUaUZtVHcwMHJI?=
 =?utf-8?B?Z0dybERGcmY1YXZnUnJ2aU5MdjVIekUvb3F6bEUrcmdVSjhvdVhneFNPcjBy?=
 =?utf-8?B?VngyVnlwNTlHN2Y5Qy9IcWtoS2YvbVZXZjk5Q1lGQU5aWHc4ejVEd3dEend1?=
 =?utf-8?Q?WwJDX0HdnmtMWVmaJi6U9Pjj7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b392998-23a4-4392-b39f-08dc0e493fe2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:51:34.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgzgzuhGXJRKqCb4z/YCu2ZsvjHlIocE4wL/232VOv5Sza3VLCztTTVsaimHt+dK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

Hi Reinette,

On 1/5/2024 3:14 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/4/2024 1:21 PM, Babu Moger wrote:
>> The QOS Memory Bandwidth Enforcement Limit is reported by
>> CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.
>> Bits Description
>> 31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.
>>
>> Newer processors can support higher bandwidth limit than the current
>> hard-coded value. Remove the hard-coded value and detect using CPUID
>> command. Also update the register variables eax and edx to match the
>> AMD CPUID definition.
>>
>> The CPUID details are documentation in the PPR listed below [1].
> "are documentation" -> "are documented"?
Sure.
>
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Looking at "Ordering of commit tags" in Documentation/process/maintainer-tip.rst
> I believe "Link:" should be the last entry.

Sure.

thanks

Babu


