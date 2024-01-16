Return-Path: <linux-kernel+bounces-26910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE082E7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9705284DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8BE111B7;
	Tue, 16 Jan 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="/dwxtNob"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4F10A39
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNjpazYO1E7qaz7aaOG7W7FIpatG+7ZqOSLBztg4TFwU8xjz7UnZfeHduqHNn1oNnTnzjMfEmGgpyjZTIiszVn0BGcgMMtJHqF1iBRDpdEMiWXM4sGb7GoGorSXVDmbt628ah4MwsVwkUlQe4xP7V2D6bHdypKLEzvpPwq6AJmcIs2jjW3r2TeHofCemIOCSLxqnk1upJvuDDq2bNB2yXIe6H/TDX0SbsugsP96pKYUYqCRfzq3PgQLT2GxiKevpW40DJlSkvjUtFLKK7AbWxIny40DOi941TEVcBkTOMdIz3f4pU4wo7Eu+JmxcN1/cACNtqHOmVFro44nRA86xTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaWPd7WEmKVVIMbAZTqR2lNCJVRIikKTszywO4roMGA=;
 b=Rx2gIMu8vONnSXLrAbmU2B94TnvKsfGhBHpt4JbXCYRw5H1TWhDyjiPcmxEWWCu4soJGsG8L/o1ojWNXBhiH+Lvk0JNDU9xF0KrVbgeF7VJbng8getQTfqyzwIgTehSdRnSxMsBhB7WdeUChP0aqpmPCZrqOrH085V2WmPoZBHD7DM2zVNU1Sc1EhFgFRQi26tsZD1vydi9UKs3Koi/1uSDjT3zNudd6/Ta5NkTg6Dn/OB7n4VnQnChQciwPUPale9oHcfZ044zD1IRGL7AGrHMfPD24rjNbiKaTR/qLjdEnb2BcVvodrEWKZ2a/jTC+NKnFCoGs9dC03zvXWNbjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaWPd7WEmKVVIMbAZTqR2lNCJVRIikKTszywO4roMGA=;
 b=/dwxtNob7PBIPjzXDE3PW1iriz2Hw99L1oHoQqEl9QJTGSgxIvq5gSmuTsIsXLD58zNUERfBxxxKebriWTe6b0kJDvTsu/6fUmnSnFoDUzQDwgOF29N7aVHT67tdbQCOKo7cSKC0Ws5oVuSHTM4iOenoaQHuAvQcERblmrpxoBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CYYPR01MB8262.prod.exchangelabs.com (2603:10b6:930:c8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Tue, 16 Jan 2024 01:47:32 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7159.020; Tue, 16 Jan 2024 01:47:32 +0000
Message-ID: <068cfd1c-8bf7-4123-8f23-49d9ec27de2e@amperemail.onmicrosoft.com>
Date: Tue, 16 Jan 2024 09:47:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: implement arm64 specific cpu_to_node
To: Mark Rutland <mark.rutland@arm.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, patches@amperecomputing.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240115095931.53765-1-shijie@os.amperecomputing.com>
 <ZaUajJbKGywgC-AX@FVFF77S0Q05N>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZaUajJbKGywgC-AX@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:610:e4::8) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CYYPR01MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 13067c52-5e82-486d-9904-08dc16351aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6WNePH+Xpr5wfzSAsNh/IifBt+BAF5lsDIRfXoSaL10ZVoSOQrSGS1aiqnhenZNlyAxUXXrWc4sCyU6P8mxj/hz5kXIsWexDJ/zPheeZWOyrz9MX8WYQPGGWU151kP9r6VdNY4Qo7cdrC1jUUNHa5ZP5mFoKHF1DRqvxfxIXsowJWaDXeeAV/szpEaQvAFUFfC8tAfNoVozM83lptKLRIdDbxLsHu0N0ZJlS9Pf+YrYzkGFSR4CNDvpgjvBPJ7WFEr+uNTjb0NuKeSwK2e1FtmdJsUHmaTq9TlPrC8MPJqofZuiCKq7V+zbtNGevIrtP/jmcKGaRxwKyfO3CBxRJ2YK2K27La/oS8EH9P9XGWC6gKQPGjb3SxlXeoEcEtn+vbsi8zIP6Nc2S1NajOu7IKDUXq0JDlyCtfwOhcn1wQjZoHON3NwHAeRMeR6atHO+YgYhNJJQ0/xV/V0rYmpaeCXly6JYnD4VwFH6ebpIbAKhTfts4/3oqLV6Clvy0xitlUNrM0dr0OfngU84kUewGxSwWExu+TchhGf57Ma+Mu/itwTDvPPEG7uJIQzm+uG171DiC/VCRBcN4OyhJgxUt22tc+Uf/WFDpvpvuo1QICmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39850400004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(66946007)(6506007)(6666004)(2616005)(478600001)(66476007)(110136005)(83170400001)(316002)(31696002)(6486002)(66556008)(42882007)(26005)(966005)(5660300002)(8676002)(6512007)(41300700001)(38100700002)(4326008)(2906002)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhtTWlmbCsyZStNTlNVWmlCUFZZc0IxVWhhY0p0R0FVNzZ4RU5RK1ZBbVlC?=
 =?utf-8?B?U2p4SDRKZVh0WUdRM3VFRE1PK0VQZDFVOEhjcy9vVGwwb1d2S0pIZWEyRnlH?=
 =?utf-8?B?OWVuWDJ3QlBDeW91N05kK285U1AvMENoTlI4c3Foejc0eXhrZlFkREZyUXN3?=
 =?utf-8?B?VDM2SzlRNXliQ1gvTTZPai93YnlXRVZGN0FmWmhUYVE3cENmdUY1aTJlWm5Y?=
 =?utf-8?B?QTZCRHZhczlNQ0x1Vk1PVU9MdWFPd3JlSHlsWlZRZkNNN1pXMmo5VHhtMmRP?=
 =?utf-8?B?S1BzRHN5QXduZXdvb1JSRnlOZW0wSW9RV25MV2Eza3h3MW53ZEhjMjlhWWY5?=
 =?utf-8?B?ejJFbzkrRTBPelVDVUluQ3VpbmRHR0RKVnd2NDFZQkpyODgrUmZkMFRFSGlF?=
 =?utf-8?B?VE0ycVZBaW5Cdi8wd0NpOUVBU0xYV3gvT0VTV1RycGJuVDBYTHJaeFpvZUZJ?=
 =?utf-8?B?em9ocm1XNXpneDNnaVJIVEYvY2w2TGpBNjZOaWRmc0lsUWMrV25Lb01aSWIr?=
 =?utf-8?B?dCtWQ0NvVU9TNVNEaHVXdTV6MDRZT0xXb2NCVW1HaG85MTJjc0tqVWpiV0Uv?=
 =?utf-8?B?dUlaR3grUXMvbkpvUVBnNjdkZWd2UklSRTkzMWdETlpVNGtndnorcTlnWkIw?=
 =?utf-8?B?bHB1cWZJNU5EMjJrMEdEN0JpRGtZWTdadDBYZkw4ZTNzR0c2ZTA4K2xodjZr?=
 =?utf-8?B?emdnZGJRTEZ5eXlaUFlHS0p6dHFKVzhNY3hydHMrNmhPNUxTWEx2enErRlB5?=
 =?utf-8?B?M0lTOStrT3JHajE5WDJhdUZVeUw0T2didnJ4cmVqcEcxQ2FNOXFGbWZjTFBB?=
 =?utf-8?B?TXNsSFBGL0piSmVPUk0zRlUxNVhjc0ZLdnNCUHg1Y2I1Q2l1TjRvSmpvZmZC?=
 =?utf-8?B?a0t4N0Q3LzdCRjlmTWh5RkhiaTNVYm5xMVJWM2ZIR0RoOVNYTlVwbE1UM1hG?=
 =?utf-8?B?R3NzUDV1L2VkVFNYbnB1Tm5CN0dFWUN5WGYwSCtyRndXdzY5amdpSGlPQ3hn?=
 =?utf-8?B?TFY4bGtMUHlJQ2lKWWo0RWZHcVduODJESTVWd1RyaVhBZ1ZrejdUVExpSllt?=
 =?utf-8?B?Vjc1SUVGU1JES1pWc1Mwc1kzdWoyNjJyd28yN3gvRE8rZ2M1aHowR0lDZ0JV?=
 =?utf-8?B?WkovaW1neXpTVlVJZU1tMkQxT0t6NDJRNkJjREhEdnBGSG9iY3B1Q29vblJV?=
 =?utf-8?B?SStYMmVLZDB0QWFrN2EzOExaQnYzU1hqYnphQ25jWDBRdHhuTmgwNFNiN3p5?=
 =?utf-8?B?U2d3NWQ4MkgyV2dDSTRPQTRLTzY4UVhwM0NYaXcvOW44c3hUMjNEYUtEbnJK?=
 =?utf-8?B?WTZ6bndNTTBqb1ZZV3VNNml2K3E0bmkyaytRaTQzQWpaVHRHMC8yL1Fra3kw?=
 =?utf-8?B?OHZTeWtybnkyN25PbGpra3FGUCt2RUZ1VkJLY0tmMjdhMTBqcTlBWTkxbzNC?=
 =?utf-8?B?ZXk1b3dxb0o2OVU0RlQ5ZXZZd0dKdWY5NEhHa1dDWWRyc1FUaklZYVFpQ0ds?=
 =?utf-8?B?U3FjQjZIT0tMKzNBUGF2bUJaQlNwS2FHT2cwMGd0SHp1M1hsZisxYVVjUktG?=
 =?utf-8?B?b1RuaU1aa2E4amFCTHpjNG05eE92QjgxS2RuRUhHbVJmeFlCTnR0Sm5XT0pH?=
 =?utf-8?B?MVNJeFRFWmNrdWM0TjdyVVdLdHlQcWh6NHBhTEtwNnpuZ3ZLZGVQM25ZZ0tB?=
 =?utf-8?B?L3VlUnIvak5ydzZQbkJrY2dJQmEzWWx6K2Ywdi9CejRTUzd4dDJ3aUd0NGJQ?=
 =?utf-8?B?dSs4NGdpczBsTW54MndOSTZSRCtZcUNNdFdQM1B1TTJXTnpMT2ZRK2JPdWxq?=
 =?utf-8?B?RUN5S1V3ZXExTWE5TWJZRmxlMFRYY2h5RFl1cENYQXdacklZa0QvTFU0S3Zn?=
 =?utf-8?B?dzlzVVRuVFA3TzhCMFIyRUs4QS9VWnl4bDFxZnlJS0VXL2hieFZEYUJvNk1v?=
 =?utf-8?B?UzF5QURZUkJYMktsWGV3YmZZRjdxekNSdVczNHlMcENabkpDYkozc0pyRitW?=
 =?utf-8?B?TjZMdzZ0TjBJMkt3eUdTcU1kSldkT0xmNm92UjExd2VlTDd6N0RzeVZCb1dk?=
 =?utf-8?B?VjNUcnlmeFZhSXN0OGpKSWRVU3JQZW1qYnN4WVEyNGp5VTRjQmhZbWcvV05U?=
 =?utf-8?B?ZmNBbmh2Zy92UEJXSHM0NkkxMldsT3VYTUtlczVZcjh2Z1UvNUc1dXVSYnRo?=
 =?utf-8?Q?DqCFsb2tXRstefIwDopjDRg=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13067c52-5e82-486d-9904-08dc16351aec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 01:47:32.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm5fgnyYobMV+G6c+RvloReiOBYwdUUARXRfgDgSMZmywQg/UB0G9G1NdbvKv0BstL1foqJAHHkZ0jqzpQy6BMLJ2el/lj1H7lMoJtFUCGnWy4NO7cxb58Vp9LZOCxYt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8262

Hi Mark,

在 2024/1/15 19:44, Mark Rutland 写道:
> On Mon, Jan 15, 2024 at 05:59:31PM +0800, Huang Shijie wrote:
>> After setting the right NUMA node for VMAP stack,
>>    https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf
>>
>> I found there are at least four places in the common code where
>> the cpu_to_node() is called before it is initialized:
>>     0.) early_trace_init()         in kernel/trace/trace.c
>>     1.) sched_init()               in kernel/sched/core.c
>>     2.) init_sched_fair_class()    in kernel/sched/fair.c
>>     3.) workqueue_init_early()     in kernel/workqueue.c
>>
>> We cannot use early_cpu_to_node() for them, since early_cpu_to_node()
>> does not work for some ARCHs, such as x86, riscv, etc.
> I spot that x86 seems to have an implementation of early_cpu_to_node(); what's
> wrong with it?

Yes, you are right. I check the code again, x86 has its own 
early_cpu_to_node().


>
>> So we have to implement the arm64 specific cpu_to_node().
> Surely those early uses of cpu_to_node() are equally broken on those other

yes. some ARCHs also has the same issue. But I am not sure if all ARCHs 
support the NUMA.


> architectures, so why should this be specific to arm64?

I just want to fix the arm64 first. :)

But if you think we should fix the common code firstly, I am okay.


>
>> This patch
>>     0.) introduces the __cpu_to_node function pointer,
>>         and exports it for kernel modules.
>>
>>     1.) defines a macro cpu_to_node to override the
>>         generic percpu implementation of cpu_to_node.
>>
>>     2.) __cpu_to_node is initialized with early_cpu_to_node() before
>>         numa_node is initialized.
>>
>>     3.) __cpu_to_node is set to arm64_cpu_to_node() when numa_node is ready.
>>        arm64_cpu_to_node() is a clone of the generic cpu_to_node().
> I don't think this is the right approach. Regardlesss of anything else, we
> shouldn't have a solution that only fixes arm64.
>
> Why can't we mandate an early_cpu_to_node(), and have the other architectures
> implement that?
>
> Why can't we change cpu_to_node() to automatically do the right thing?

ok, I will change the common code.


Thanks

Huang Shijie


