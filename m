Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F387E7A59D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjISGQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjISGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:16:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1CE115
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILT4lNRCCvulLPb9BJybkJPtBtOUj71Y6AnTi2LtrTemKwsnGKTWSkQCyNuWUM3CPkwpC+XyhwYDZbFi80Hikf1RCbaoJNbzPvaAo+LakK7HNiXOExkTCE++RN7SocdqKqizuz3dbfkgc50657oK97/8RPkItjow6zNcBxZuwwQQ3TZfvhlIoyfLvUDwbWPTxagdyACH3BKRnN6nM18WIku5/QLZcT4Ardtyg/B5vH77WS7NKlLLffuenAHxW4uf6ZMINEGslWoiPpd3kjUjHh4bnyt9Q3bVAEa8w4hg9Pm3A+V0pjY3KxZaof1Ogu1+CSa/RpHSCvcYmJa0dQyA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxoFpU40mFrwhrAZwd74nVyOsWtRMCj/iABkbLW12XY=;
 b=Z+MNxJ5v1nxvsD8tcvdzTbbW7fxYkP2BDLpuRF5eGyTi+QQfSHOCJuorwmzXnSFdgxrqyN3CDmn00EmlpMhJl8Qi1gj45C3z1SBVzUzaB1gtuLeDe6ZCmC7HuccehFJT7YXzVU3fm+S9M6bn7VDSBb2aAJ+oikNTJ0jYSw31IttG4Y1wrN9mksx3alanbbueJIvJkiCHoi4mxSk8S1y/sHhUYMTRhUqkQFo00IyxBOs/A9bEewin1peTRax76DEhaHtWT1UxGIFLkqNbXh6dZo/xfVKQutgxSOC6RX4Jf/eAyqMmLQulWQhjyEHhFQ1nGwg5poM++wMYKtWkEHeEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxoFpU40mFrwhrAZwd74nVyOsWtRMCj/iABkbLW12XY=;
 b=Q+RbF7k/yES3nUK6T5KIJgH9Wi7hDCTNaZSx6WsPj4qNs2F6p6Y4UwH7JsR5H7+soWLWhDEa8um5wIsUFoH0ofMfullMeyRx/lm0Zk4hmaiN/8fjxzcZv/HEoEyeMQJmEhSVa9KMQTriMtGtkVHUrT5ojXl+oh7TEF6SoM9S4a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB6253.prod.exchangelabs.com (2603:10b6:a03:290::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 19 Sep 2023 06:15:55 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d686:ac07:89b3:e724]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d686:ac07:89b3:e724%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 06:15:54 +0000
Message-ID: <38722ba7-b7d9-368b-f946-b6c0c0a661b8@os.amperecomputing.com>
Date:   Tue, 19 Sep 2023 11:45:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] KVM: arm64: timers: Save restore CVAL of a ptimer
 across guest entry and exits
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, Christoffer.Dall@arm.com,
        eauger@redhat.com, miguel.luis@oracle.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
 <20230904114218.590304-3-gankulkarni@os.amperecomputing.com>
 <86bkeadzf0.wl-maz@kernel.org>
 <ec322123-bfe7-6019-7f35-de326ee7b6c3@os.amperecomputing.com>
 <8634zben3d.wl-maz@kernel.org>
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <8634zben3d.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:610:10e::11) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: c385e5b4-3116-4cc3-a38b-08dbb8d7e151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dz2VG9nz3dKriSt0QPK7t/rMMbU2CvDXpb9bDIe7ZhLE8eeIl4s0mejPnCUn8Fn4hT5OA0s6pIpledYbjPs/1oA4kfKlywY9jKrAW6uBQbEA5nxFQ+kex6vrwASdYEH+xfk6ppD0gXrQczDYQkcG6YTaK406UZ9v+5P93qTcNyWmMI0CA4wVTN8JKP2My7kbZZe9FO7YiYh4Hb4QYFMenntNz9OSMyBhd8WeHvW24/XX4sgs7k3gHg28BalR4zppM+698B3Je2NZgGeqAhuhH7PWcyvXEy9ufv/LrdIW5LvcFi+ShNPnanMv4N20f+w7i5Z/kMYy7p891otsof9yPYADU9vHWu5NRBX1ULdbJQGHrPGj/cE7vPNnGdBoEX6OlvNXwbg4aU98xPAdhRFa8iDPapxcRCjhSgnj76qOmQddqdptSRyFWVVKY5IX3gSVvNzjE+RoN+pGqxGFi/aHjq0e1uSzIiZxgMH5UcFa6W5T1dPNMLYvgyf7cnRQ8IHy/M4yR3mr312DFb18zP3f0CyULfLcTkTgaRDmw/HY0scOSYNV4wlIDT/1oSByZ1vOixyJM+96OfjcaAq5AXDV93LP15Gans7gcToHvGsasRAYBQOG4rbGLiADUXUIFepA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39850400004)(136003)(451199024)(1800799009)(186009)(316002)(6916009)(41300700001)(66946007)(66476007)(66556008)(478600001)(6666004)(38100700002)(2906002)(31696002)(86362001)(4326008)(8676002)(8936002)(5660300002)(107886003)(2616005)(31686004)(26005)(83380400001)(53546011)(6486002)(6506007)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGtaOTNMQk1hbHZySDAyc3NTQjFDbEs1YWVvMC9xRW02Y1k2VmVHVnk0dk9r?=
 =?utf-8?B?MS8wZVhaY0QxYms2cXlWUHFGSG8rVkswOWV5QlB4RGVyUDUvQ3RYNHNQVVhM?=
 =?utf-8?B?aE9rcWE0ZUl0TWRlZ3ViWDBwc2dxaTFOWkJoL1FmRGhDQzVTQzhaVnlSWFJp?=
 =?utf-8?B?d2lhVTdvTEF1UGJMWmxQZkNIYlk5eVQ1VjhvNERsV05KNmlWdlBlczk1ZGcv?=
 =?utf-8?B?U05Cc0lSdWxOOE1DNnVuR0hpY3NHdkNXSVQ4M1poL2huWE1iVENJbklFLzVK?=
 =?utf-8?B?MXdFR3Z0L2VtWnpVVUwvdEN6T1R4Q3BoYXh5azBoSnp1V1hJWGo1RXQxTmph?=
 =?utf-8?B?MjFycC8zT1R5bUgwUitUY1ZubVdGL1RHTlgyUmJsUUdKSXd0bGYwKzlsUEs0?=
 =?utf-8?B?OWZUZ3RiQ3hkOXZvZXlENnlnaEN4ZnljMDd0UnBtc3lYWWhjdHl5QTJ4QTRL?=
 =?utf-8?B?Tmx6MkQzWlhmQ2lsT1V3aElKOVhjbXJabWkvY1AyNTE1cy9GcmcvRFBjZXRZ?=
 =?utf-8?B?S2RBMGdRQlk2VWwvTmZtcjlQbEh6andndHFrZ2RXaXZhVnhCUXF0eWw5bi96?=
 =?utf-8?B?Zk50VFlFL1FBQXBabGxxWXF5NnoyMW1jMldIekppeHJ0TStoRk5MeGdCNjdF?=
 =?utf-8?B?WSs2eHl1cm9tQ2RVdXhidzNrYjM4c2FPZTR4Q1lPeHFmSGMzcDJveU45S21q?=
 =?utf-8?B?RHpoOUtZeGxTaUFTQVgybkRnTUF1bFFzcHBjaEIvOXp1cjZDYzVHYWlSL1lF?=
 =?utf-8?B?OW1aUnh6d1pyYlN2TEpTeHJwd3VhV1RXRFJ0UGlEV3YyT1pYMmc5NWxSZ0pm?=
 =?utf-8?B?QnVaZW5xNjZWOGF0dkJIMjAzN1JUYU5mTGF5d3N1RDJtQzMzNmh3SXRQclNN?=
 =?utf-8?B?RUZuSDAzVlJ3MEQvN1JzWGwwemMzL0JMcWU3eEwxRkt4TXlFS0YwdnVlMENu?=
 =?utf-8?B?QlIvVXNoOEd6WHNtaVFHYVl6Ryt5aVNhSlE2WXVMZXluOVBFZU1Jb1lUeURB?=
 =?utf-8?B?TTZTTVNhTlFmWVZXWHowZ1FFT3lYK3JVWjAvcXpyaDRQeHMrclRtVkNDaHFr?=
 =?utf-8?B?L1c4bUQ1R1V3eTlJZDhTYThLY2h2ZEd6QVE3RVdSMjBFeG5TeE44Z0FPT3l3?=
 =?utf-8?B?blVSNlphLzQ4bEMwZCt2akxRbjEvWDZOejhqcllMcFkwZXpVRWpzblpURHhm?=
 =?utf-8?B?NmJaTk5Ncnc0dG1QU3BydnhBOGZIcjhIZEpYR1FKcU84OVVMNFhSbm85djls?=
 =?utf-8?B?SkVJbG9TeDRxcHV1ZWxJblhBTDR4MXIzMlNsRzUrcFpZNjNZMGZxS2xEVlJw?=
 =?utf-8?B?TkMzdVpzNGtjenlVYzFyY2t5MDNTR0lsUFg1ZVdqYXZ4L1NKUTZ1THZiWU00?=
 =?utf-8?B?MnV0elY3cEJFLzg4QVJoZFc5UHdBV212amRkRmJJV1hYODBvWDVybkl5OUxx?=
 =?utf-8?B?d3pvcXpTVG1mMnUxWUpmU2xFSndUa2JOSlRjWkF3Z0VrRk8wdXYwb0RYNVpF?=
 =?utf-8?B?RzZNRGlSY3RJK20yU1ZVUXlzbnoyVVpYRDdBNjVhb0VFakNmUFppRmRHckkw?=
 =?utf-8?B?d1EvVXd0UGhxUFFEK0tOWVBwQWkzcGsxNm5qbHZDcFVKU2tYMUJOZHd4bWZz?=
 =?utf-8?B?RHRhck0vQkZKemw2YTN5R0xzT2xOV2I4M25OZEVSQ0pPNWl1TUxLSzdkVUM2?=
 =?utf-8?B?a0ZIb1l0dmEvN01xNTZkd0VLMnhTQzV5RE0zT2xidEk0bFRZU3ZoZWViRGpW?=
 =?utf-8?B?Z0dyM3dnT0RreVRya2lWT0wzVVdmQkFLSm9yVjd6YjFMY2xRWng0T2pOdDhI?=
 =?utf-8?B?bEpWQzArR0hJMkY5bmJWQ21pWktYVmRRdnVaTDVZRXNsUllKUFlIQm1KQzI5?=
 =?utf-8?B?bzVSejc5ekJaVEs0ZTk3Znd1OE9XN1FnWmVZYkNvbXd0cE4vRGo2QUMzZTl6?=
 =?utf-8?B?cVBVVHQxb05QeGFxOXF4S01WN3FXVXVpdjdNOGZwamV4LzFyeVVkMzZtTEpK?=
 =?utf-8?B?dXc2YXVXT24vTmJOZUF4eG9KUjVMVTYveit2YUlzSERQeGlCcmgxM05wUkUr?=
 =?utf-8?B?TmR6cTNncjY4V3pKaWh0RnIvNXFTRzJ0MzJuWkR3aU5MWVB4anp3TkFKZVFI?=
 =?utf-8?B?Mk5MeFRVYlIvVHEzam5EUU12TUc2bzR0Z0JvWVFMdWFOMnltdGlxeEN1NWtm?=
 =?utf-8?Q?thxQ4Z02p7z3o1mXJI07mZU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c385e5b4-3116-4cc3-a38b-08dbb8d7e151
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 06:15:54.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERqoKR8TRaZYhNMgvLmWYruBaDUsHYUsumGgEfvYD7z7GiyvCbL0MWjH8SzN0ZJCRsC6YGb6jb3hLNptobF66leUMs417aeVCntsTX0ucXeSE9CbW6Z3/mMMp4dvOTjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6253
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-09-2023 04:59 pm, Marc Zyngier wrote:
> On Fri, 15 Sep 2023 10:57:46 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>> This patch did not work.
>> After adding changes as in below diff, it is started working.
> 
> Thanks for looking into this.
> 
>>
>> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c
>> b/arch/arm64/kvm/hyp/vhe/switch.c
>> index b0b07658f77d..91d2cfb03e26 100644
>> --- a/arch/arm64/kvm/hyp/vhe/switch.c
>> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
>> @@ -117,7 +117,7 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>>                          val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
>>
>>                  if (map.direct_ptimer) {
>> -                       write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
>> +                       write_sysreg_el0(val, SYS_CNTP_CVAL);
> 
> Duh, of course. Silly me.
> 
>>                          isb();
>>                  }
>>          }
>> @@ -161,8 +161,6 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>>
>>          ___deactivate_traps(vcpu);
>>
>> -       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>> -
>>          if (has_cntpoff()) {
>>                  struct timer_map map;
>>                  u64 val, offset;
>> @@ -173,7 +171,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>>                   * We're exiting the guest. Save the latest CVAL value
>>                   * to memory and apply the offset now that TGE is set.
>>                   */
>> -               val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
>> +               val = read_sysreg_el0(SYS_CNTP_CVAL);
>>                  if (map.direct_ptimer == vcpu_ptimer(vcpu))
>>                          __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
>>                  if (map.direct_ptimer == vcpu_hptimer(vcpu))
>> @@ -182,12 +180,13 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>>                  offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>>
>>                  if (map.direct_ptimer && offset) {
>> -                       offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>> -                       write_sysreg_s(val + offset, SYS_CNTP_CVAL_EL0);
>> +                       write_sysreg_el0(val + offset, SYS_CNTP_CVAL);
>>                          isb();
>>                  }
>>          }
>>
>> +       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> 
> Why moving the HCR_EL2 update? I don't grok what it changes. Or is it

This the line of code which flips the TGE and making timer cval ready to 
handle the TGE flip is more safe way(avoids even corner case of false 
interrupt triggers) than changing after the flipping?

> that you end-up with spurious interrupts because your GIC is slow to
> retire interrupts that are transiently pending?

IIUC, If there are any transient interrupts or asserted already, anyway 
they will be handled when irq is unmasked.

> 
> Thanks,
> 
> 	M.
> 

Thanks,
Ganapat
