Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04B786796
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbjHXGiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbjHXGh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:37:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2127.outbound.protection.outlook.com [40.107.100.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D98CD0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqhI49XEXup18mwQYLv6QSuo6iNH656x+8AziKHHUSs//8t/8Swb8l+Fr+z/vZBPokEgHiT7S3HouRCt1kKwgGgD435ZHPDJCHQMDm2ogh34Sj2EOrXQbel/Q+9S5GxxtOBCozPytGmTbZtf8RIFjqbomou0VYINIetbLzKSy+FTNoKuxqUX7B2IH70NSWj5lJ5TY0vKFXDZkklP2UIdPK5AaCS/W+wKwRq/yXrHsGAmpIcJ1wwh2TRMTdoGuuMGgq2yur078cJHt9Cx8H+J7nDj00AZMmtwNYFHsw1dv5FdbREwHdU01FyI7/oKDmoG3tG3Uk6UW+wys88LWBgaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgx9NdV9mZHTUdSh7klcZ8m00mXRmsT5SZW0x+/XwYA=;
 b=DyrMSw+JC6ms4xLiw5kxLhVW7tPdG7y4807KAx6w3kuwCg5PZ4HT69A4MvKt9BlGTPbtUmc3joyILdVhxfPkFD8zf7XOBjKV2WTJzO47pzVVRjE/9L3jfP6JR5E3yrRnGnitTLo7I/7DsEZi4BERy5N4UI7eMGkajq9lud4UMI9m0K1mD8U9a8YFefzRTV3hmlssCXXL26cH42xjIqBFvkL8V16c0nq3FqxheFxCwiS2WhVV+v36w6txbvrjEnk5ornLcMzyOcYnLGV/ZVm11VEVziJE4jglljKhi+YtVfLMsmQ+IHOBbqmEDTkyP7dTGe0uqs6ECISvPZUrbMdZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgx9NdV9mZHTUdSh7klcZ8m00mXRmsT5SZW0x+/XwYA=;
 b=c0WEkr0KhlWL0cY7c+ffZRon9B3bWLHiFQ1opK5D+ojx76mKS6zQ5VIU78KQfztVv7O5OOI7o2cmTiKxTx7DxOBBmREfiMurML/p25ro6k67ykmfQvp4EtrHDi1RGEBl07Wkp4Jq8ktu9W59Z9KAZl3hr1DrnStSdkIP8d7svss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MW4PR01MB6163.prod.exchangelabs.com (2603:10b6:303:71::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 06:37:51 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 06:37:51 +0000
Message-ID: <80bce164-4fb9-0126-0ba0-02581be1a0a5@os.amperecomputing.com>
Date:   Thu, 24 Aug 2023 12:07:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] KVM: arm64: timers: Adjust CVAL of a ptimer across
 guest entry and exits
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com,
        Christoffer Dall <Christoffer.Dall@arm.com>
References: <20230817060314.535987-1-gankulkarni@os.amperecomputing.com>
 <20230817060314.535987-3-gankulkarni@os.amperecomputing.com>
 <87bkf6oyyt.wl-maz@kernel.org>
 <0c5fb304-8c69-80c3-6f1e-487828554244@os.amperecomputing.com>
 <86il97ff17.wl-maz@kernel.org>
 <946b0fc2-3264-d7ab-f5e1-7c9e76db6ebf@os.amperecomputing.com>
In-Reply-To: <946b0fc2-3264-d7ab-f5e1-7c9e76db6ebf@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:610:75::33) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MW4PR01MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 7824e58e-3fff-4e0b-2c3d-08dba46ca397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37KDoUiwxdRVQbg13rv3GU4Q2fYE1jA8AvldcQgGabGekOzvw65qWQ3WMuRFrV+BR0Ah7MbihqGVpdKRwV4tjSxIN43sP/CqdjdccRPJWeN+sdIonRhZ2z3uik0Psd0I97zTmmXgVSD473wmNPc+k4KuJN7QsVcqMI710yX9TC02Qda3v+biQVYCJoy42c5Df41v2SLQVIp6mz6+DsHeqyx+P+kfn3maBLaZPYLiNyM/BngOD4N4Lbu/YhexhVxOAFced60ZddxsRE4oz92wzvDYbW6qJJMLGOK//CHGp1SoAdIQivDhOH72p+NnaJvfWEP/wSkmRfgeNfhbSWAY4GfNMjo/+sUQiC1Uz7aMrxCsbDRDXalpLwVLoHd719gQ1USKjxEawxsYX7VHQCdnlSvth5yvuvYPEkAnHcGdO733zsoMnNwup4FZKvZU4qH6URR+1an1UXC5ELsHFUSGajIQNyV7CRTr3+QG8GPkEUk8kOgvDuDqLTo+55X5Syr6ONV9jK7BMnm8xCnc4mYChmBXDxbrQsO6iZVPafLqEeae1Q6JEncCKnyeKH/sFNclTIeT7PB8rC+AmPhurqLSD8iYO6Y0zduk1zXE1uWX0KDepGn2jTuRQsiQQeJVHF1G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(66899024)(5660300002)(4326008)(8676002)(8936002)(83380400001)(26005)(6666004)(38100700002)(66946007)(66476007)(66556008)(316002)(6916009)(478600001)(31686004)(53546011)(41300700001)(6512007)(2906002)(6506007)(86362001)(31696002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFQWDBSMHpwaXcwMERWS2QrT1owdUhsU2FLem5sS2tFRzEvMDVyZzlKU1pE?=
 =?utf-8?B?aUlhcmpuUmdOZStZSnhZYzVkK3J0UnJrd1F1Y0owQkJvdjlUM3RLQWEvd0Yz?=
 =?utf-8?B?Skl1UUtMeGlzV0lWeXB1eEpFUWUzalpqMUtCZzdJTHY4U0VGUHltN2tZc21j?=
 =?utf-8?B?WFdhK2srZ3NhOEtFZ3hKbGNNWWhsak9GSmZlWllweVVqNnFBc25EUk45THRN?=
 =?utf-8?B?b1RyODQ3bmwyNmdla3JiZm9aMTlacEw2VzZmRVZTbjg1NTlRU05YVHRUaVBk?=
 =?utf-8?B?eXlxMXNGK0tYSm1IRzFFV3JqdHM0MlEzNTFpaExYR2E5T1BBT3ZZakRzenVN?=
 =?utf-8?B?NGdJNm5EY3IzdXZ4eUZRNGdkTi94NjhkdlRZdGtjY1I0TzRJVzc5bVBhbkV2?=
 =?utf-8?B?dmFBTjRoVkRoWW9lQkljKzVQZEY1UXRNL0JFaHNVbmUrVUpFakYyOHZoMDVt?=
 =?utf-8?B?dkRTRXZIYWVSeE92VWdsQjJuZDhDcWw5U0E2ZEpsZC9iajBuN2h2elg2WWJp?=
 =?utf-8?B?TlpqemRXOGkwUXRWS2lwVDdYNTNxVks0bTFFVFRORWpBVWJLd29rK01NSE1K?=
 =?utf-8?B?b0JnU1JOSGJEL2c1NlpPWVo0cFdUZ2JsR0JRRU5pSjM1YkcrRWhKWTd6RFlC?=
 =?utf-8?B?dFZzQk5CaVVadWZvUG5EUXpxMnZEYmEzcEdGMEwvbTd6N0tQMzFDY0xMaTJv?=
 =?utf-8?B?cnYwNW9qQlJ2ZkUzcHZGdEZLZ2NxMHZUdlAzaHZYbDEwck5NdlZHYWtPaFo2?=
 =?utf-8?B?dUsySkFmK25zSW8zSFpGaGF5VkZHUWE2c3F3TTlWVXltd3FleEs0VnZhb3FL?=
 =?utf-8?B?YTJGSHRWaTZLR0xZNWlXRG9sYlVWNkt1SlFvdXlqV0JZZkRhaGdKZmhvS05m?=
 =?utf-8?B?eEZMSmxKcHVhbnJiazltR0plTnpHd3c1NHZZZGhMdU85U05IRnplYm5VQUxa?=
 =?utf-8?B?OWwxQ0VYMzJLZDNjZmVTWVlCSWVWcStFd2tsc0pDdXNiTEU0THFiYjRiRmF5?=
 =?utf-8?B?aktEYmtMYzZka1d1bEliMzNMSFpXeUQ3VDV1U0ZWeW8rcHVuU3o1TnROK25r?=
 =?utf-8?B?dmRvNi9md0xoaDlFRFdkRU5ud3kwMWNXRUtnZzdLdnNHb1pHNVRpRTFnWXp0?=
 =?utf-8?B?blR5NWZ1YVI2NUtMWHgvbjhCL3FLVmVYTm1ISUFmZGVtOGo0cm9lN1o0a3Q3?=
 =?utf-8?B?UkdmZVI0U0pxbGNkTnlOaGNrWHhLK0NYTWRCU0NSZnFVd3BzeW11L0pOQlB4?=
 =?utf-8?B?MnFid3BpN1J2Z1A3WjMvTno1MUJkbVFRRU1TNC9vWXN6MGgyTDJiVHZjQlk0?=
 =?utf-8?B?TEcxK2RYUFU4YXplNnZHYUFtZVVHSUlBckxzSkJwWlozaStjYy9NT3lEYkJR?=
 =?utf-8?B?UGVjT0ZiaTAwNGxuMHgwelh4dzZUUkQxT0VDcHJpY013ZUcyL1M2TnBDZVor?=
 =?utf-8?B?YzJYUUZkN29JTWVFVnBicit2WHljelcyaloxMTgvWk1SOE4vZ0RSQkh5SEVq?=
 =?utf-8?B?ZDJhRVFnQ0FuQU1BZzVCWjZsYVFKQXNsU1M2UGNyUVQ1ZHZFcDZvOXo2NWFE?=
 =?utf-8?B?KzFBT05DbkJZR1FQaWhuR1JxalNvN3A5Sjk4QjEyTCs0MVNuc2NlOUN3ZFBt?=
 =?utf-8?B?UjFoSDQvdy8yWDJRZmxOVHZLSWlqellLZGR0aXFBcWtvbEpuVUszU2xnWEtL?=
 =?utf-8?B?RjUybVUxdmNxWVVpbFpTVWRWbHRoWEhnbUFTOGxrRGR6aGJ2aERKQ2JJdjBP?=
 =?utf-8?B?NWp1NGloa1N0Y0hWUzFVRjRGMkdDdFVLTUVQdXhXZFoyOThkM2VlNGdEYUJC?=
 =?utf-8?B?OFBPT01MNUQwUnFGVnV5Z1pubUZNQVdQYXZNeUJ0VnBhdzJ6UkthalJhMWJv?=
 =?utf-8?B?UnlCbm0xVllJcmc0TUZkdW54VmlqU3lxQ3ZmRGJNVDg0VTFHdEJWSDVHQ2tL?=
 =?utf-8?B?YklDSDBpVE40VGFXQU1QSG5pZFJrUUtuR1hZeDBDMkppaUpkMzNZcTRUV0Vs?=
 =?utf-8?B?K1dDa1B5aTRqN2liRlNqVDNzZlVCUW9jcjJweFg2Qzg0WmV2UGZyN3dPK2o0?=
 =?utf-8?B?OTI4QWdIbzRvcllLWDRKWEh4RDgyc3JxNUUwNTRDS1NaSXNDbkZRakZWRnhp?=
 =?utf-8?B?YXVSQ3dQZWRLbEViTTFaUGl4SFU5Y0tTOFgzbm0zajZNU0p3Y3F0Vk85d0xk?=
 =?utf-8?Q?posz9FVaAhUAGCOvsNKF0O/DwAbp5TZBzC5LAQ7Z846p?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7824e58e-3fff-4e0b-2c3d-08dba46ca397
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 06:37:51.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yZbjv6MhAAjI8Dw4S70lR7jsmFZN8sME9QXjV5EM8wBHfsiOCl87gEais+Zk22xk671UdMaNKnOsfyW85TTZSug0CFEKvSR7KmI6gHgafSpr345yeGDsr0aEMfMMRnR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6163
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-08-2023 08:27 pm, Ganapatrao Kulkarni wrote:
> 
> 
> On 22-08-2023 05:46 pm, Marc Zyngier wrote:
>> On Thu, 17 Aug 2023 10:27:55 +0100,
>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>
>>>
>>> Hi Marc,
>>>
>>> On 17-08-2023 01:57 pm, Marc Zyngier wrote:
>>>> [Fixing Christoffer's email address]
>>>
>>> Thanks.
>>>>
>>>> On Thu, 17 Aug 2023 07:03:14 +0100,
>>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>>
>>>>> As per FEAT_ECV, when HCR_EL2.{E2H, TGE} == {1, 1}, Enhanced Counter
>>>>> Virtualization functionality is disabled and CNTPOFF_EL2 value is 
>>>>> treated
>>>>> as zero. On VHE host, E2H and TGE are set, hence it is required
>>>>> to adjust CVAL by incrementing it by CNTPOFF_EL2 after guest
>>>>> exit to avoid false physical timer interrupts and also
>>>>> decrement/restore CVAL before the guest entry.
>>>>
>>>> No, this is wrong. Neither E2H nor TGE have any impact on writing to
>>>> CNTPOFF_EL2, nor does it have an impact on CNTP_CVAL_EL0. Just read
>>>> the pseudocode to convince yourself.
>>>>
>>>> CNTPOFF_EL2 is applied at exactly two points: when SW is reading
>>>> CNTPCT_EL0 from EL1 while {E2H,TGE}=={1, 0} and when the HW is
>>>> comparing CNTPCT_EL0 with the CNTP_CVAL_EL0. In both cases the offset
>>>> is subtracted from the counter. And that's the point where the running
>>>> EL matters. Which means that CNTPOFF_EL2 behaves exactly like
>>>> CNTVOFF_EL2. No ifs, no buts.
>>>
>>> As per ARM ARM (ARM DDI 0487J.a page D11-5989)
>>> "When FEAT_ECV is implemented, the CNTPOFF_EL2 register allows an
>>> offset to be applied to the physical counter, as viewed from EL1 and
>>> EL0, and to the EL1 physical timer. The functionality of this 64-bit
>>> register is affected by CNTHCTL_EL2.ECV."
>>>
>>> As per ARM ARM (ARM DDI 0487J.a page D19-7857)
>>> "When HCR_EL2.{E2H, TGE} == {1, 1} or SCR_EL3.{NS, EEL2} == {0, 0}, then
>>> Enhanced Counter Virtualization functionality is disabled."
>>>
>>> "The EL1 physical timer interrupt is triggered when ((PCount<63:0> -
>>> CNTPOFF_EL2<63:0>) - PCVal<63:0>) is greater than or equal to 0."
>>>
>>> As per ARM ARM (ARM DDI 0487J.a page D19-7938)
>>> "When EL2 is implemented and enabled in the current Security state,
>>> the physical counter uses a fixed physical offset of *zero* if any of
>>> the following are true:
>>> • CNTHCTL_EL2.ECV is 0.
>>> • SCR_EL3.ECVEn is 0.
>>> • HCR_EL2.{E2H, TGE} is {1, 1}."
>>>
>>> In VHE host hypervisor, E2H=TGE=1 hence ECV is disabled and Ptimer
>>> interrupt is triggered based on PCount<63:0> - PCVal<63:0>
>>>
>>> Since cval is set by Guest as per offsetted PCounter value and pCount
>>> is not subtracted by CNTPOFF when in VHE-L0, results in cval becoming
>>> much lesser than physical counter(bumped up since CNTPOFF is zero) and
>>> timer interrupt trigger condition is met falsely.
>>>
>>> There is no issue/impact on cval due to ECV, however it can be/is
>>> manipulated to handle this on and off of CNTPOFF/ECV.
>>>
>>> IIUC, CNTPOFF and CNTVOFF are not same as per specification.
>>
>> I owe you an apology. You are correct, and I was totally wrong.  I'm
>> truly amazed how wrong we got this part of the architecture, but it is
>> way too late for any change, and we'll have to live with it.
>>
> Thanks Marc.
> 
>> Now, to the actual patch: I think the way you offset CVAL isn't
>> great. You should never have to change it on entry, and you should
>> instead read the correct value from memory. Then, save/restore of CVAL
>> must be amended to always apply the offset. Can you give the hack
>> below a go on your HW?

I tried this and seems not working, this is due to timer save/restore 
are not called for some of the kvm_exit and entry paths(lighter switches).

I tried changing this patch like, Removed cval adjust from the kvm_entry 
and still cval is adjusted on kvm_exit and in timer_restore_state 
function, reduced cval by offset.

Please let me know, if this is not you intended to try?
If possible, please share the steps or pseudo code.

Thanks,
Ganapat

> 
> Sure, I will try this and update.
> 
>>
>> Thanks,
>>
>>     M.
>>
>> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
>> index ea46b4e1e7a8..bb80fdd84676 100644
>> --- a/arch/arm64/kvm/arch_timer.c
>> +++ b/arch/arm64/kvm/arch_timer.c
>> @@ -55,11 +55,6 @@ static struct irq_ops arch_timer_irq_ops = {
>>       .get_input_level = kvm_arch_timer_get_input_level,
>>   };
>> -static bool has_cntpoff(void)
>> -{
>> -    return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
>> -}
>> -
>>   static int nr_timers(struct kvm_vcpu *vcpu)
>>   {
>>       if (!vcpu_has_nv2(vcpu))
>> @@ -180,7 +175,7 @@ u64 kvm_phys_timer_read(void)
>>       return timecounter->cc->read(timecounter->cc);
>>   }
>> -static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
>> +void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
>>   {
>>       if (vcpu_has_nv2(vcpu)) {
>>           if (is_hyp_ctxt(vcpu)) {
>> @@ -569,8 +564,7 @@ static void timer_save_state(struct 
>> arch_timer_context *ctx)
>>           timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
>>           cval = read_sysreg_el0(SYS_CNTP_CVAL);
>> -        if (!has_cntpoff())
>> -            cval -= timer_get_offset(ctx);
>> +        cval -= timer_get_offset(ctx);
>>           timer_set_cval(ctx, cval);
>> @@ -657,8 +651,7 @@ static void timer_restore_state(struct 
>> arch_timer_context *ctx)
>>           cval = timer_get_cval(ctx);
>>           offset = timer_get_offset(ctx);
>>           set_cntpoff(offset);
>> -        if (!has_cntpoff())
>> -            cval += offset;
>> +        cval += offset;
>>           write_sysreg_el0(cval, SYS_CNTP_CVAL);
>>           isb();
>>           write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTP_CTL);
>> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c 
>> b/arch/arm64/kvm/hyp/vhe/switch.c
>> index 9611b4eaf661..6e3d3e16563f 100644
>> --- a/arch/arm64/kvm/hyp/vhe/switch.c
>> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
>> @@ -90,6 +90,20 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>>       ___activate_traps(vcpu, hcr);
>> +    if (has_cntpoff()) {
>> +        struct timer_map map;
>> +
>> +        get_timer_map(vcpu, &map);
>> +
>> +        if (map.direct_ptimer == vcpu_ptimer(vcpu))
>> +            val = __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0);
>> +        else
>> +            val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
>> +
>> +        isb();
>> +        write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
>> +    }
>> +
>>       val = read_sysreg(cpacr_el1);
>>       val |= CPACR_ELx_TTA;
>>       val &= ~(CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN |
>> @@ -131,6 +145,23 @@ static void __deactivate_traps(struct kvm_vcpu 
>> *vcpu)
>>       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>> +    if (has_cntpoff()) {
>> +        struct timer_map map;
>> +        u64 val, offset;
>> +
>> +        get_timer_map(vcpu, &map);
>> +
>> +        val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
>> +        if (map.direct_ptimer == vcpu_ptimer(vcpu))
>> +            __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
>> +        else
>> +            __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2) = val;
>> +
>> +        offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>> +        write_sysreg_s(val + offset, SYS_CNTP_CVAL_EL0);
>> +        isb();
>> +    }
>> +
>>       /*
>>        * ARM errata 1165522 and 1530923 require the actual execution 
>> of the
>>        * above before we can switch to the EL2/EL0 translation regime 
>> used by
>> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
>> index ea77a569a907..86a73ad1446a 100644
>> --- a/include/kvm/arm_arch_timer.h
>> +++ b/include/kvm/arm_arch_timer.h
>> @@ -82,6 +82,8 @@ struct timer_map {
>>       struct arch_timer_context *emul_ptimer;
>>   };
>> +void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map);
>> +
>>   struct arch_timer_cpu {
>>       struct arch_timer_context timers[NR_KVM_TIMERS];
>> @@ -149,4 +151,9 @@ void kvm_timer_cpu_down(void);
>>   /* CNTKCTL_EL1 valid bits as of DDI0476J.a */
>>   #define CNTKCTL_VALID_BITS    (BIT(17) | GENMASK_ULL(9, 0))
>> +static inline bool has_cntpoff(void)
>> +{
>> +    return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
>> +}
>> +
>>   #endif
>>
> 
> Thanks,
> Ganapat

