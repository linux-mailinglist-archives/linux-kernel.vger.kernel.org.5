Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6132C7844D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjHVO5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHVO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:57:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2106.outbound.protection.outlook.com [40.107.237.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C70CE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIIBw+jI+SeUcqTjnpJOJSS4YiznI7ZSTTr45q2t2D0vgttDWVA2PhCBbbf1vyzVB2rAMI+Z3HaV1eJqaZg+gOadJEe+j1t3hzP3lzVwgiMfjWZz8PiYqRsecv2cqLhliVU1WVQmNK4WVQXkPwZCDCMbnnP3kpizWCEpc5VeTpNsLeucaJq5iBNRt4+GAXH5/rt/B4xndkJbb6BlA1w2ZyCJ91HEBxyFpldMLbGP8m6T69/4jyas/iFZblaffO7ZP2THPiGIZBgY/cTG8dkHuzD81KibF7EX056BeNauCNBSCuuA8WVy32LwAiFwGeN/fvH7B+/7hlFzcOOU+ZwD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rzm8pqD+msWaonlNpd6X8kp2WSSsbk+XlQVitTPaN8=;
 b=Ieh+nnsLRkQvKf4Te8r/gtTYLgZFUuPKkhnyPdpHN00BRU+BhOyluyjaVXO7XWzcIQI7qBbvx0FsHfjWc2pni5B1GTbVN61rWcAE2aQw/qKIpurVNUECBQ/n697NniQKa/nWzuSBhv/l+gTDlH28G5bKSHFKMZnHGy5RqkAF+WhcqKPYWBITQ5ZPggashWma2ZUuD62YiY0ULIwiChj4y0K8g0iFzOy4tDUZGBJzaYHA0+duWOP+wlDaLSoUiOP6q5aXKgLxUeAVqA+jQtm2WcTdhwmRI1l863X5lkDsy7JYFaRLYzIqljZf46sKV1u91YWViPeycrBgcOtFGyTLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Rzm8pqD+msWaonlNpd6X8kp2WSSsbk+XlQVitTPaN8=;
 b=Lb5MxHnaP7SBTmcYn+8ikPQHrqsCYimCOdnQrL570NjFf76fubA+dnofR9DXQpGw1u5NbrxxjrAiMggBS9xW0UnAA0OoNmacl0Gqa0/rz2xWxY5FCDYjVRGZfBHP/MgNFpWSikxGAvTS235xTFMKGoTkwRzTYFQEvh9fwJAak4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 IA0PR01MB8329.prod.exchangelabs.com (2603:10b6:208:489::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 14:57:27 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:57:27 +0000
Message-ID: <946b0fc2-3264-d7ab-f5e1-7c9e76db6ebf@os.amperecomputing.com>
Date:   Tue, 22 Aug 2023 20:27:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] KVM: arm64: timers: Adjust CVAL of a ptimer across
 guest entry and exits
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
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <86il97ff17.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:610:75::35) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|IA0PR01MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a0022c-6f53-4cc7-d2ed-08dba32019c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WehCbk2GpBV5Fag2gcE0q9RXysDXzcyAl+BgbUofxjXdM3Y6JJ4xnwxuRslXJrj9oba9Pj/u70zHdMUr8E5hoD8BQLKdvCkl8ELKuNbquQP48++tY4P4NIyJL55S2hoFwI/LQmVNBxvrYrDubUoGhR1F0+AuQKxm5D4w8hJBIZ5SF0kIefbFkvUpLj7aGriaF9ns0/NM9N4E7sPyE+1a0AQOmGPcB67LhbvsaLkV6s/WZVcbaTe6mePI7Oa//xP9Nc0fGHcinjidOIJ2TGJs29YX6+gKNvDObz8wETmu6q1GAI4/OjRkT/EUd+OW5cR3UqBbWxuVDabV0xANDYFaNtkCM3pjfVjdC5U6TLc0onmjbOVPfPeBboHV8xkZ+XF7gu0JqX0OMpGTrZ6IgG3ilnVohnWeUz3qqCQzxoRHXcsKgm65ugRV53t/pTUSBmFI7mnQFZfDtGk8D66+95BTJ9EKNVLd9TfoVsgf8wf162IBdz/eB8bTwxuJamkSxJjz+w960406VtdqtVbZDcIIhAUgjbpgsQr4tgx4bCOxR4KVJMqbo/S0SrQev/tWxWTRe2NuE/fLcN9khUqzm43nkMlOQ4+qClEBM2D3h8AUotkndO4PrsUMrweCZuL7kw2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(31696002)(86362001)(31686004)(478600001)(5660300002)(2616005)(8936002)(8676002)(38100700002)(4326008)(2906002)(26005)(83380400001)(6512007)(66899024)(66476007)(66946007)(6486002)(6666004)(316002)(53546011)(66556008)(6506007)(6916009)(41300700001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFhLbTRwRjNheXJQQXF5TFRuanVGT21xMm1TZU40SDBZVXVHSjFSREEzRjRu?=
 =?utf-8?B?cUQ4aDNHVzRYbkJSK3NvaUFzdG5LYmttR05QYjlBam1nenNzbElXTFVldnAw?=
 =?utf-8?B?V2JKYmlnc2sveGhTS2RnbVVIOXJORFVtQ3psOUVLakpaRDlJSmRIbmdHQ00z?=
 =?utf-8?B?VCs1di82Y1Vka0NwNTBCaXFDa01TWmpYQWswTGlmd3dhUzJ3UlBsaUNyRGpy?=
 =?utf-8?B?YURacEdTMlF6My9NeGY0S25xaDBRWXA4SmRHb0lmbWZZTjNXSDVEYzA1SmZI?=
 =?utf-8?B?WmFZLzZUcmtTRE1xKzZuMmQ1bzhOWEhldGVwRFhhclNVMGJkc1o3VGZmOFFT?=
 =?utf-8?B?NlNpaTFrbitTSjVDMWNpeWJoeTQ1czY1VzFNMkR2WlBWWWxtRkRFTXYrRkRp?=
 =?utf-8?B?UjBYTTA1SHRoLzIycjg5T2thcDRuUkhVbGRabG5PeDNqWGRPY1ZvSUwzUWNV?=
 =?utf-8?B?QWlacnp4SUVDbHREdU9pZ0VYbGRqSWY5aHJ6aE10cndmTWtGY1hjWEhXQzBh?=
 =?utf-8?B?TTNaQ2JMeHRGMXQ1MmU1TkRTR0FpQXpxWUNHUlcweWJvWEYzaGRLSmtYUW05?=
 =?utf-8?B?WHJHTkN0TlhXQWhCMXExbGJ3OFhteE12ZDBEZGEwRVdvNHo3THV1cmVqbmpy?=
 =?utf-8?B?czA0ZVZ2emFQZ2tjUHRWMHhvWlJNVXFqSkxuQW83cWU1aTdtcXpTV0FYNDRq?=
 =?utf-8?B?Zk5GczhEeDd4VzNrQnNvNU9VT2tNWmR3Sm1iRko0WUc2RWR2ODRPaDJmK0Ix?=
 =?utf-8?B?SjdodjVNd3VrWExJdDhwcVJHM25HMVAzY1VYelhQajYrcWpZQldzanV0aFBs?=
 =?utf-8?B?TEFCdktmTnR1SXZSM0J3V3NjalpkSHYzVnQyd285OE1XYUsyQnVZSU5xZkhx?=
 =?utf-8?B?b0lXUS9xTHA5ZkVndVMzMjVwRnhzd0Y3U1pOVnY4VlFZZEg3QjhMVC9Rb2pk?=
 =?utf-8?B?SmowMjZsN2lUdjNzWUpqL2wrdXRXcTgraG5qVFI2OU1ldjFSRHlQZFFrVGl3?=
 =?utf-8?B?VXlGTEVSdjIyR2hMVGdmNTNXOTZhdkVsTzdzc21tZTdDSFFyaHJla1dwUTcy?=
 =?utf-8?B?TDMxZmtlNmNBOE41bWYzdmtmTkw0eXBUNm4wZ0NTVUFXWExXUUhabEpCUG9a?=
 =?utf-8?B?QVNoa3M0WFNYWjFTNGxleFpEaU5JeDR5eW5DRmU4MkZVVmZEY3VXNklXNW54?=
 =?utf-8?B?K0M3NENIaXNlRVVZc0gyZ1Y1MlBqTDQzdXJYT2RFUTJlU2NkSTY1R3JhSzNV?=
 =?utf-8?B?NFdhYnI0Y0k3OE5RTE1XMkp2NU96Vmo5RkVySHNIMzBtVVlmVHEzVnFKNDFq?=
 =?utf-8?B?aUtBc2F6cGtGWit0L0c4N2VwSk95S1ZJMGtRRFZONHZNSWdGcTlNMnBPWFda?=
 =?utf-8?B?dnJCQmhXZGc0UU5OdzBNL2xTcGtVeWk0ZW1naE5qd1BqTVR0UzNoU2VQM1VP?=
 =?utf-8?B?OCtJUVZ4bU9JZU1RbXptSFV6ci9uelZ3MjJYWjVuM1F1ZHBVQmJiMmIyb1RZ?=
 =?utf-8?B?RDhQUktjNkszYVdIL1VhNDZHTEovRVRCYVVVRU5RZy9iZzZIaDZmeG5YSDZW?=
 =?utf-8?B?dmg0WjJHSndKaXNjejdhMklQWElTWWpRWmorQUNMNFp1WDNoNGd0V1psZDJZ?=
 =?utf-8?B?Sis3K0QzQUZpZ25DTFl6RGZOMDE5cGxyWXllVnJyNG5HRFJkZ2IvOW1VM3NW?=
 =?utf-8?B?NHJ2YS9wL2JLZkY5cUtPREg2WTJna3F0VFBLQUtjY1FPdUhLaStjQmhkNjRE?=
 =?utf-8?B?b21xSGVwZVNKd0U3dTlhSjQzcHU2TWw4V2VXbWFLck9aR2NLM3BTOVpuOFh5?=
 =?utf-8?B?eEhRcW9jSEJVQUZJZ3RsK0hJaG8rRzh0Q0prajZkc3RKKzg0dVJnUWhhWmM3?=
 =?utf-8?B?cm1RekdZTlYxNDVtTXJvUWVGUXU4dUtUNENUU3JMU21CalZDZEp5Vkh1VVFm?=
 =?utf-8?B?SVozZ2NFcThGM2o2LzZJb0swL2xkU25JQnZidTVKMmpuSjF2TFU5MVJCOVor?=
 =?utf-8?B?OHlmUlJ4ZEtIbDA2MHE2MzlDb2cxaDJKdkFlaWl6Ui95Nk5jd01ZamtOb1Fn?=
 =?utf-8?B?a2RDMUlESzBPVU9SQ1BvSW1Yall0ZzhtTjhrZVVZajhXU2NTVThLdVZCUDdS?=
 =?utf-8?B?VDJwVmIzSVZ2TGxHeFRGZUw1aGpaVWVXV3M3Qk9lcklMVTRrc0wyeDlDdWN5?=
 =?utf-8?Q?JIiF/Urk2PM/BpymL9p39hM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a0022c-6f53-4cc7-d2ed-08dba32019c1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:57:27.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI7FQcE0BT0Dn2NP/gWlaog3Bk8cpqGi8NijO2nNIGyw5NsapdwZnh9wOKp8JpcJHYV1Xj7hscX8TqEFW/7zGiu++fKJjLrM/25ZyDDW8j57kn+jjYs/zBUzAKY1IiNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8329
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-08-2023 05:46 pm, Marc Zyngier wrote:
> On Thu, 17 Aug 2023 10:27:55 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>>
>> Hi Marc,
>>
>> On 17-08-2023 01:57 pm, Marc Zyngier wrote:
>>> [Fixing Christoffer's email address]
>>
>> Thanks.
>>>
>>> On Thu, 17 Aug 2023 07:03:14 +0100,
>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>
>>>> As per FEAT_ECV, when HCR_EL2.{E2H, TGE} == {1, 1}, Enhanced Counter
>>>> Virtualization functionality is disabled and CNTPOFF_EL2 value is treated
>>>> as zero. On VHE host, E2H and TGE are set, hence it is required
>>>> to adjust CVAL by incrementing it by CNTPOFF_EL2 after guest
>>>> exit to avoid false physical timer interrupts and also
>>>> decrement/restore CVAL before the guest entry.
>>>
>>> No, this is wrong. Neither E2H nor TGE have any impact on writing to
>>> CNTPOFF_EL2, nor does it have an impact on CNTP_CVAL_EL0. Just read
>>> the pseudocode to convince yourself.
>>>
>>> CNTPOFF_EL2 is applied at exactly two points: when SW is reading
>>> CNTPCT_EL0 from EL1 while {E2H,TGE}=={1, 0} and when the HW is
>>> comparing CNTPCT_EL0 with the CNTP_CVAL_EL0. In both cases the offset
>>> is subtracted from the counter. And that's the point where the running
>>> EL matters. Which means that CNTPOFF_EL2 behaves exactly like
>>> CNTVOFF_EL2. No ifs, no buts.
>>
>> As per ARM ARM (ARM DDI 0487J.a page D11-5989)
>> "When FEAT_ECV is implemented, the CNTPOFF_EL2 register allows an
>> offset to be applied to the physical counter, as viewed from EL1 and
>> EL0, and to the EL1 physical timer. The functionality of this 64-bit
>> register is affected by CNTHCTL_EL2.ECV."
>>
>> As per ARM ARM (ARM DDI 0487J.a page D19-7857)
>> "When HCR_EL2.{E2H, TGE} == {1, 1} or SCR_EL3.{NS, EEL2} == {0, 0}, then
>> Enhanced Counter Virtualization functionality is disabled."
>>
>> "The EL1 physical timer interrupt is triggered when ((PCount<63:0> -
>> CNTPOFF_EL2<63:0>) - PCVal<63:0>) is greater than or equal to 0."
>>
>> As per ARM ARM (ARM DDI 0487J.a page D19-7938)
>> "When EL2 is implemented and enabled in the current Security state,
>> the physical counter uses a fixed physical offset of *zero* if any of
>> the following are true:
>> • CNTHCTL_EL2.ECV is 0.
>> • SCR_EL3.ECVEn is 0.
>> • HCR_EL2.{E2H, TGE} is {1, 1}."
>>
>> In VHE host hypervisor, E2H=TGE=1 hence ECV is disabled and Ptimer
>> interrupt is triggered based on PCount<63:0> - PCVal<63:0>
>>
>> Since cval is set by Guest as per offsetted PCounter value and pCount
>> is not subtracted by CNTPOFF when in VHE-L0, results in cval becoming
>> much lesser than physical counter(bumped up since CNTPOFF is zero) and
>> timer interrupt trigger condition is met falsely.
>>
>> There is no issue/impact on cval due to ECV, however it can be/is
>> manipulated to handle this on and off of CNTPOFF/ECV.
>>
>> IIUC, CNTPOFF and CNTVOFF are not same as per specification.
> 
> I owe you an apology. You are correct, and I was totally wrong.  I'm
> truly amazed how wrong we got this part of the architecture, but it is
> way too late for any change, and we'll have to live with it.
> 
Thanks Marc.

> Now, to the actual patch: I think the way you offset CVAL isn't
> great. You should never have to change it on entry, and you should
> instead read the correct value from memory. Then, save/restore of CVAL
> must be amended to always apply the offset. Can you give the hack
> below a go on your HW?

Sure, I will try this and update.

> 
> Thanks,
> 
> 	M.
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index ea46b4e1e7a8..bb80fdd84676 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -55,11 +55,6 @@ static struct irq_ops arch_timer_irq_ops = {
>   	.get_input_level = kvm_arch_timer_get_input_level,
>   };
>   
> -static bool has_cntpoff(void)
> -{
> -	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
> -}
> -
>   static int nr_timers(struct kvm_vcpu *vcpu)
>   {
>   	if (!vcpu_has_nv2(vcpu))
> @@ -180,7 +175,7 @@ u64 kvm_phys_timer_read(void)
>   	return timecounter->cc->read(timecounter->cc);
>   }
>   
> -static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
> +void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
>   {
>   	if (vcpu_has_nv2(vcpu)) {
>   		if (is_hyp_ctxt(vcpu)) {
> @@ -569,8 +564,7 @@ static void timer_save_state(struct arch_timer_context *ctx)
>   		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
>   		cval = read_sysreg_el0(SYS_CNTP_CVAL);
>   
> -		if (!has_cntpoff())
> -			cval -= timer_get_offset(ctx);
> +		cval -= timer_get_offset(ctx);
>   
>   		timer_set_cval(ctx, cval);
>   
> @@ -657,8 +651,7 @@ static void timer_restore_state(struct arch_timer_context *ctx)
>   		cval = timer_get_cval(ctx);
>   		offset = timer_get_offset(ctx);
>   		set_cntpoff(offset);
> -		if (!has_cntpoff())
> -			cval += offset;
> +		cval += offset;
>   		write_sysreg_el0(cval, SYS_CNTP_CVAL);
>   		isb();
>   		write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTP_CTL);
> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> index 9611b4eaf661..6e3d3e16563f 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -90,6 +90,20 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>   
>   	___activate_traps(vcpu, hcr);
>   
> +	if (has_cntpoff()) {
> +		struct timer_map map;
> +
> +		get_timer_map(vcpu, &map);
> +
> +		if (map.direct_ptimer == vcpu_ptimer(vcpu))
> +			val = __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0);
> +		else
> +			val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
> +
> +		isb();
> +		write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
> +	}
> +
>   	val = read_sysreg(cpacr_el1);
>   	val |= CPACR_ELx_TTA;
>   	val &= ~(CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN |
> @@ -131,6 +145,23 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>   
>   	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>   
> +	if (has_cntpoff()) {
> +		struct timer_map map;
> +		u64 val, offset;
> +
> +		get_timer_map(vcpu, &map);
> +
> +		val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
> +		if (map.direct_ptimer == vcpu_ptimer(vcpu))
> +			__vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
> +		else
> +			__vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2) = val;
> +
> +		offset = read_sysreg_s(SYS_CNTPOFF_EL2);
> +		write_sysreg_s(val + offset, SYS_CNTP_CVAL_EL0);
> +		isb();
> +	}
> +
>   	/*
>   	 * ARM errata 1165522 and 1530923 require the actual execution of the
>   	 * above before we can switch to the EL2/EL0 translation regime used by
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index ea77a569a907..86a73ad1446a 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -82,6 +82,8 @@ struct timer_map {
>   	struct arch_timer_context *emul_ptimer;
>   };
>   
> +void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map);
> +
>   struct arch_timer_cpu {
>   	struct arch_timer_context timers[NR_KVM_TIMERS];
>   
> @@ -149,4 +151,9 @@ void kvm_timer_cpu_down(void);
>   /* CNTKCTL_EL1 valid bits as of DDI0476J.a */
>   #define CNTKCTL_VALID_BITS	(BIT(17) | GENMASK_ULL(9, 0))
>   
> +static inline bool has_cntpoff(void)
> +{
> +	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
> +}
> +
>   #endif
> 

Thanks,
Ganapat
