Return-Path: <linux-kernel+bounces-6315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B049A819715
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A67285870
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC55B8C06;
	Wed, 20 Dec 2023 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="cAd5MnRU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E88BEB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsbgso7IyRJ2bBcp4R1OhPrV9UC0y4R5NcHpWyfbuBx2+1B4qxuQNZ7glsSqr61VtF4wBQjp8kZStuzI5DCtoxMSNjsEJqERwqVvE8HRUObgayhJ2DFFstWriDPATPU4UADEZdj50BPq4RTIYTnh3rBV5BwL579G6gktFASpy4IzNg6CPuUurysOW3thtb18lQuofjOtFSlDdzy6FWi2Jum5XzcSF/8gTtKIItf2psUAMbpXt6UTCMufa9kex63QkFA/fyBtTSmhpbzPiVRo2x662uVg4Y11VXmehz7HuXfr0qcJ/v8mL9JswMyTldPYur1VKLV5KiCOt1d/1S7/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lqpvVBmLO2iCAsA/gU0OrmaPVh5OdqDYeNUy5jxLYU=;
 b=TSMod85yXR+AN4Te9lG8z4HAmQVUINYA7v6l9SNIqMi3KKbUbAmZauU53zTRd84TWaJ1VbnZn+JNtYuHLTsWnVsUz8cBjbk84vAGyCDeYw1dZzKFv38AMyuKXwjS6qi3sw0wm39yiVm2lX9IIu66N9IIu5PZClf3AklV9ZACc5uK157JRCHhO5wduTM77+c7SL8FksY9DTp9cCsgUZpGnX1mVCXHAxSJHJ700vNr4NeNa4hEsM3XXIGqGF54G5KhYVHPmYhF+eFC1s3ft8brQpU1jUQROJ2LI4/c6tHBiaOYuD7WR0oBhtmQMD0iOnR+ghikhCigvP/b8w8kXepDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lqpvVBmLO2iCAsA/gU0OrmaPVh5OdqDYeNUy5jxLYU=;
 b=cAd5MnRUClTqy8St9ME9tMxyU2fXQmAXCIWxTwEgDe14c3AGxQ5BDywqY8ZBj/LBFBGc2MBwzk3rkxIYJIuPjRcUOC6CrrXbmNB9osf841dCBSl3YExXTMIr5vh0OVRl8xvj4m2kpaHxbZwDqhgQeDGG6+VQiMrArm46nHXoIr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ0PR03MB5741.namprd03.prod.outlook.com (2603:10b6:a03:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 03:12:27 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::8362:a405:a3e3:5f12]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::8362:a405:a3e3:5f12%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 03:12:26 +0000
Message-ID: <aed87c60-d802-45d0-a430-52fb9e7bedad@synaptics.com>
Date: Wed, 20 Dec 2023 11:12:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Could external jtag debugger trap page fault instead of kernel
 handler?
Content-Language: en-GB
To: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 catalin.marinas@arm.com, will@kernel.org, sumit.garg@linaro.org,
 daniel.thompson@linaro.org, liwei391@huawei.com, ayaka <ayaka@soulik.info>
References: <b8ccbd62-7a0d-49eb-bc32-c48e59adeae6@synaptics.com>
 <daac75e5-bb80-461f-a77b-939a184d3caa@arm.com>
From: Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <daac75e5-bb80-461f-a77b-939a184d3caa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:510:23c::21) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ0PR03MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: f793ca90-e162-465a-02bb-08dc01097e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vr8DgvxRxcM6iLj0muth1PGJNcKITUed8mc719CBo4O/xE+vt+hm4u5EJjjEDpYl/bmpSw+RQ1pK4JYlnojI5hly4JHYJobOyXzAEGeZjSzH673haosCj+mJKvaRjQL2PbiBLx022nLsaHHRPHWJX2/LfQsoPFgcVcDV5janHzI8DZclGUfeCjRhHLEmb2FiLrWX3d0tndmhT+SNFv09zR9cat2gJRyWMIjHiwb5g0sE/uVMqWrp8yfTdWSxdJOwhE7ieT1FQZBfw96VpmGhII1oJ/oACP1wry1zN1iHfzSwbjep5tg12hIomu6wCZjebCZWKzjWyOsNF7Bs9wbqptPTEqDuuvzDqjs+OKBlcrzreqrDx3lwH08pefSEHa/1COgVJ0Ke1hYKsiFkJxJGeYmx4JIzgm2woNFBSVqZGUBprZbmoM77WKwEE3JNcKWwnTQpuDLByF5Kv8tpJH3JzYRnrUmQx5qBVXVGlm5p26R/CgKnXpVhFomIS5yEa6t4NRTE4bUed9ypp3O7UoDIdLrqK1dPvlcCK+kwA9/30cV2p/uPZvORpp3drrVaGCnddiNqfaERrB2RW4OoULe3rmwpqXvjs6PFRkrMs3ad8p4ds5T2NGLgyBM2DTkmy38s+YgjG7ELndUUDQojXpZk/SjI4OIMjJ8gA6hkfutylXiXpmPF/5PSyFG4RqXxID+LZ8y4vIOlpt9FXVEVcHoJTexJLd1+cP05TM85OUBzuQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4326008)(8676002)(6486002)(8936002)(45080400002)(31686004)(478600001)(2906002)(6666004)(66946007)(66476007)(66556008)(316002)(6512007)(86362001)(5660300002)(83380400001)(36756003)(38100700002)(31696002)(7416002)(2616005)(6506007)(38350700005)(53546011)(52116002)(26005)(4001150100001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBzd1hVdUphZy83aGlsSzU3eDE4a2ZuTUVWUVNOb2xNZWdoaVpxN2ZsYzA2?=
 =?utf-8?B?enpKRTlDUmh0WEtwUTN4dTBmbmdIcE5lZnpCZTI0cFlUb3BRWFVHSmZkNTlX?=
 =?utf-8?B?MDZ5a2lpdjFDdGZML2VYNS9TWHN3Unh1NFBMYldCalhEbnVYM0VIMGhhS05V?=
 =?utf-8?B?TVJsbXJuYjBUa1BWRVExR2dVYUNNazZaeDBvNUpZVVBLdTlzWDdjV3JYMEdZ?=
 =?utf-8?B?NWZNUXJHb3hXNElHY2FoRkxmZGh1RlhyUndkeUx0aU9UWFVHVFlyRVZ0RHNK?=
 =?utf-8?B?Qm54eUt6RTBwWG8xN1p1RC9aYWRocjVMQU54QTJPQmp3ZmdzKzdMK21nb0w0?=
 =?utf-8?B?TmVaYnYrTTAyK3p4Ulo0QWlrdHlmKzFOUXAyNUN6QVRXV3dhWXZjYmt1bkpi?=
 =?utf-8?B?UXZpL2lWY3ZacDJHVGlUQ0ROZ09WQlFGU095czdqVHRLREhLTklQcC8zOHBq?=
 =?utf-8?B?RE5hMWgyeTlEU3hjOFF3czJhQzJZYk9nVXlrRndtMUhzcTF5SERXRmVsOUxw?=
 =?utf-8?B?ZVVUZUNXYmN6cnVkRVJEa3ozai84ZDJsbnFJTzF1bmxRV1YwZk9RN2lyem5J?=
 =?utf-8?B?SUpXNUNxUEp1NVJIc2VMMnlnenQwZFM2Vm5sSXpEWG5uWEF1RVlJeVVWZlhz?=
 =?utf-8?B?VDNKM3h3U2I3L1FtdGxib0tzL3UrYmxQcUZZU0ZidGxZTG12WWpCd2JVRW0x?=
 =?utf-8?B?K2FPb2VUM2ZLNDNlSjlia2lQVzNtME5rUm9oWXdsaURvZ0hiUEFCTUtzTzNz?=
 =?utf-8?B?Q0cvcW9XbThoKzh6clFKWmNTZ00vQVl4cDFHYm9wbGR3c2oydmdLcE8zNW5I?=
 =?utf-8?B?ajBKdDZKaTRXeEZ4YS9WSEV0QXF3VUx4d3Y5V2w3a2RVdTduZHF2aC9hTnNP?=
 =?utf-8?B?dkZXYlRBUEkyRWdOTGJvcERMZ1dNdjdaamJUd2dzeHoyVXRSek1iVjd3Tmxk?=
 =?utf-8?B?cTl1L1VKdml4Q1h4dlZuQS9Obkdib3MwMXNHK3AwZFd4SFQ4SHRaV2cyalBq?=
 =?utf-8?B?RmlJZHIySkVLSFZxVy95c2lJM0tnY0RkN2pJaWdpYTZPSVYyNFlIMEZDdmxX?=
 =?utf-8?B?S2xWNGt0YmMyRjRHZnpWZjY5RjJBV3FvMGNDbHk1R1VxRllMSkFzaUxzTmpt?=
 =?utf-8?B?VGxGU0NhV21YWURjeVdZR01CSFlyZXVLMW1MbHM4M2tmUVVzaWZSck1BMWk0?=
 =?utf-8?B?MzBwVHZ0enVqOXNkNlNqQVdha1pVR3pqOGFydS9URFo4YUpGNkFJTXQrTlBR?=
 =?utf-8?B?T2lCR1BnckNmRXFVcElFRlR5eTJoSkluL1FZeEpnZ3RLMDFGVEZvbkNoamkz?=
 =?utf-8?B?WlJJdTM1WWR6SFF5U3pENUp5QUgwd2tWbVQ3TDBRS2gxQVZUc3FaMDd3U283?=
 =?utf-8?B?cFA4V2xHWkdBRHJnQ1VBTzE3UW0rUS9jeGFtQmhuR0lYaTg0cDZCaDByeHVU?=
 =?utf-8?B?RFUvTEtFelhOQmp0U004M3JFb0MyMmNld3AwQm4xbmJIVkdhMDJMVGdTUjN5?=
 =?utf-8?B?U3NrUXRwOGY2N2xZZ2haMFZybCt6ZjRiNG91MUFxelJjcG56eXczK0txZjZS?=
 =?utf-8?B?M3pYTWNnd3ZUT1dHS1I5b2lWd0pHUUdzSC9XdGMrczdzNmF2N3BUVVNkdThN?=
 =?utf-8?B?b0JCQitaN1o0ZjI3UDFnYU9Kang0Nm5rV0t2aTIyUlRFSUl4VnpkS0lpdzgy?=
 =?utf-8?B?Nk1aSFBYdXdjT3ltWmFyZDUxVU5nVUxqcGZubXNlaFQ1UXJhbkU5UVNndTd5?=
 =?utf-8?B?ZWRyTEVGWndJUEQwTE1neFlJa0ozeHJiTThjY1JleFprZVZsdG9udldzTkVv?=
 =?utf-8?B?YXhLT09IVENPcWcrRU0zUHVYdG81OVN4Snlqa0pQMllHdk9uOFFBOHdTVUx6?=
 =?utf-8?B?K1YzZExVaVZZM2p5VVdMVGw0bmVJTlh0VkJKRDVqdU0wUEorM0p1czhJcjFr?=
 =?utf-8?B?Mm9CdkUxZHBSemhtZUJmcUxUMjZHUVBnV0pCekhkdC9WY1dlUXY4OGxBR3M3?=
 =?utf-8?B?OFlVbzN6eU5wVzkrT1A2SDN4cTRzQTJXRCtIcDFRQnd1M0pmUEFBYkdiWWhz?=
 =?utf-8?B?YTFHUkRldHFtQjVmR0Nkc091NkFNWlV5VEhKSVBJN3ZNSEkwNFpoS1RBZlhC?=
 =?utf-8?Q?FwU0DfKOxMa4oMoyHdh6BOCnx?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f793ca90-e162-465a-02bb-08dc01097e2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 03:12:26.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS0GnVQR2Ky1Mmqg8yUaeZW85GRyL0k7DrAzVsIdZZVmdD+kqsExCmnecSIl2SxBf908qlvRmGq0v+8aj55jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5741



On 12/20/23 00:57, Robin Murphy wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
> 
> 
> On 2023-12-19 7:47 am, Hsia-Jun Li wrote:
>> Hello
>>
>> I am trying to debug an illegal memory access problem for a kernel
>> driver. The JTAG could trap the kernel function likes
>> die_kernel_fault(). But it won't provide a context environment in the
>> place where this bug happens.
>>
>> I know such page fault is more like a software interrupter, is there a
>> way that I could move my debugging context back?
> 
> Right, you don't want to be looking at the current running context of
> the exception handler itself, you want to be looking at the exception
> context that's stored in "regs" at this point. I've never used GDB for
> that, but I'd hope it has some command for inspecting a stack at an
I think we could make that python script for gdb kernel do that.
> arbitrary address other than the current SP register.

While I think we do need to do something to the kernel. I have not read 
the full document of the coresight. Would the coresight known an 
external debugger is connected to one of its cores?

Or we could have a variable flag here to control the branch. I know the 
kernel could trigger the coresight, instead of software interrupter 
handler from kernel, the external debugger would know what happened with 
help of the python script.

Besides, we need to disable some timer handler in this case, likes arm 
psci timer.
> 
> However, if you haven't already, it looks like enabling
Thank you. I have solved what cause my original bug.
> CONFIG_DEBUG_LIST might help catch this particular issue sooner, as
> you've clearly got some LIST_POISON values there.
> 
> Robin.
> 
>> Here is what I got from gdb connected to openocd.
>> (gdb) bt
>> #0  __do_kernel_fault (addr=16045481047390945544, addr@entry=264,
>> esr=2516582468, regs=0xffffff802937b940)
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:372
>> #1  0xffffffc00802c174 in do_bad_area (regs=<optimized out>,
>> esr=<optimized out>, far=16045481047390945544)
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:485
>> #2  do_translation_fault (far=16045481047390945544, esr=<optimized out>,
>> regs=<optimized out>)
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:782
>> #3  0xffffffc00802c2cc in do_mem_abort (far=16045481047390945544,
>> esr=2516582468, regs=0xffffff802937b940)
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:918
>> #4  0xffffffc00889738c in skb_dump (level=0xdead000000000108 "",
>> skb=0xffffff802937b940, full_pkt=112)
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/core/skbuff.c:834
>> #5  0x0000000000000000 in ?? ()
>> Backtrace stopped: not enough registers or memory available to unwind
>> further
>> (gdb) info threads
>>    Id   Target Id         Frame
>>    1    Thread 1 "vs640.cpu_a53.0" (Name: vs640.cpu_a53.0, state:
>> debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
>> alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff,
>> protonum=0 '\000', fmt=0x258208 "")
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
>> * 2    Thread 2 "vs640.cpu_a53.1" (Name: vs640.cpu_a53.1, state:
>> breakpoint)    __do_kernel_fault (
>>      addr=16045481047390945544, addr@entry=264, esr=2516582468,
>> regs=0xffffff802937b940)
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:372
>>    3    Thread 3 "vs640.cpu_a53.2" (Name: vs640.cpu_a53.2, state:
>> debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
>> alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff,
>> protonum=0 '\000', fmt=0x9f2270 "")
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
>>    4    Thread 4 "vs640.cpu_a53.3" (Name: vs640.cpu_a53.3, state:
>> debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
>> alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff,
>> protonum=0 '\000', fmt=0x20ded8 "")
>>      at
>> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
>>
>> And here is the issue I am trying to debug:
>> [ 5478.863161] Unable to handle kernel paging request at virtual address
>> dead000000000108
>> [ 5478.871093] Mem abort info:
>> [ 5478.873886]   ESR = 0x96000044
>> [ 5478.876938]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [ 5478.882249]   SET = 0, FnV = 0
>> [ 5478.885301]   EA = 0, S1PTW = 0
>> [ 5478.888440]   FSC = 0x04: level 0 translation fault
>> [ 5478.893318] Data abort info:
>> [ 5478.896195]   ISV = 0, ISS = 0x00000044
>> [ 5478.900029]   CM = 0, WnR = 1
>> [ 5478.902996] [dead000000000108] address between user and kernel
>> address ranges
>> [ 5478.910129] Internal error: Oops: 96000044 [#1] PREEMPT SMP
>> [ 5478.915701] Modules linked in: vpu videobuf2_memops v4l2_mem2mem
>> videobuf2_v4l2 videobuf2_common videodev mc synap(O)
>>   pvrsrvkm syna_drm cfg80211 rfkill amp_bm
>> [ 5478.929897] CPU: 0 PID: 6613 Comm: gst-launch-1.0 Tainted: G        W
>>   O      5.15.62 #1
>> [ 5478.937988] Hardware name: Synaptics VS640 EVK (DT)
>> [ 5478.942864] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [ 5478.949825] pc : v4l2_m2m_buf_remove+0x50/0x90 [v4l2_mem2mem]
>> [ 5478.955582] lr : v4l2_m2m_buf_remove+0x20/0x90 [v4l2_mem2mem]
>> [ 5478.961329] sp : ffffff8026c4fa90
>> [ 5478.964643] x29: ffffff8026c4fa90 x28: ffffff8026c201b0 x27:
>> 0000000000000000
>> [ 5478.971784] x26: 0000000000000000 x25: ffffff8026c4fd28 x24:
>> ffffff8009774270
>> [ 5478.978921] x23: ffffff8025f4c100 x22: 0000000000000001 x21:
>> ffffff8025e1f3a0
>> [ 5478.986059] x20: ffffff8025e6d7b0 x19: ffffff8025e1f028 x18:
>> 0000000000000000
>> [ 5478.993197] x17: 0000000000000000 x16: 0000000000000000 x15:
>> 00000055a1955a10
>> [ 5479.000335] x14: 0000000000000000 x13: 0000000000000000 x12:
>> 0000000000000000
>> [ 5479.007472] x11: 0000000000000000 x10: 0000000000000000 x9 :
>> 0000000000000000
>> [ 5479.014609] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
>> 0000000000000005
>> [ 5479.021746] x5 : dead000000000100 x4 : dead000000000122 x3 :
>> dead000000000100
>> [ 5479.028884] x2 : dead000000000122 x1 : 0000000000000000 x0 :
>> ffffff8025e1f3a0
>> [ 5479.036021] Call trace:
>> [ 5479.038467]  v4l2_m2m_buf_remove+0x50/0x90 [v4l2_mem2mem]
>> [ 5479.043867]  vb2ops_vdec_stop_streaming+0x98/0x160 [vpu]
>> [ 5479.049184]  __vb2_queue_cancel+0x30/0x210 [videobuf2_common]
>> [ 5479.054936]  vb2_core_streamoff+0x20/0xb4 [videobuf2_common]
>> [ 5479.060597]  vb2_streamoff+0x18/0x64 [videobuf2_v4l2]
>> [ 5479.065654]  v4l2_m2m_streamoff+0x70/0x140 [v4l2_mem2mem]
>> [ 5479.071055]  v4l2_m2m_ioctl_streamoff+0x14/0x20 [v4l2_mem2mem]
>> [ 5479.076889]  v4l_streamoff+0x20/0x30 [videodev]
>> [ 5479.081455]  __video_do_ioctl+0x174/0x3d0 [videodev]
>>
>> Sincerely

-- 
Hsia-Jun(Randy) Li

