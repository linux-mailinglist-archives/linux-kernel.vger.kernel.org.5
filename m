Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166FB7BF206
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjJJEyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:54:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01280A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 21:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCWuOJNoHcV8aybiFqL2Wd4vzxILgtfQA8IuvfN8xROtow2SpT3br6ugIoBCM2nMPOMUo+y8d0hbIcz7pJtk6unLCt4pjtI64G8TDS5SvNJL10cZ3cNdODzTlIkVtQK9KI596TQKY9bLj80QQn522QNmCpu9Otc+LK0C8q33XQjjQrg8rF/SmLCMHiYTQu5bbnqz9JxDWXs1/OmHyDPbT9jIQTDk4NT+Xrm4qiIzvU0KunbGB8MsiOjO+Y/d+9PbVBo7DE2qJR+doqw4n3trVYDy1imqRneTZ6J79oTH+F27U0qKK8+dIIzMRHMWm3/JvmdbgMu4wDK8f2wr5iVTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKXlqFG3d3blkHst59hPydFg4Hz4mSExqmGkGCPBR18=;
 b=mb0WA1FNOXtpF3sU7qed+4rD4K0QD8HW94wIlxCDDu9PpaxCSgzLivYqHDQzYsiRiTnxM9Utk/nKC3lh+M2I4dtcBnpO+QvaigoWKrKCYQRHeQz3t/hU15Q9+MXYhbGPu8ECUjUpnUgFA4sb46OoDxFz7bfqupdhPdjMIDKulPCjjdwk3Q+crrCwkhFqjpOWE/70P+x/qrsGi//sLlOk3JWJsv7iRMEShKu+4KSgaThIjYcdlb4HRMYQsHI99RNTYC7yBnjwjrAiYRPmvQB0fApJ4mqDSk6SNE81GSAsZEp+vpVWxjg+54ojZUci7WrJ+2nXSrCSKceyqVc/ZJqSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKXlqFG3d3blkHst59hPydFg4Hz4mSExqmGkGCPBR18=;
 b=luEmgrodp2GhTQav1VkyCXHyCEni3ktz3jS1k9Ws2m0bAS0kW1AjpeIB68zdkeTPsA14dbcXVCmCVs3+0QytXJxosJLutri/0PYqNvI8c2K6FCQPtcn+NLrFcHfdxJyxyC7Wd2uc08Ob1xu83Gw+7wlrPgxu4JlyobXfXYdmimI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 MW4PR01MB6354.prod.exchangelabs.com (2603:10b6:303:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 04:54:45 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::f4a2:e069:a176:48a8]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::f4a2:e069:a176:48a8%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:54:45 +0000
Message-ID: <921b6925-89bf-dc6a-f163-cee7220bca58@os.amperecomputing.com>
Date:   Tue, 10 Oct 2023 10:24:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] KVM: arm64: timers: Save restore CVAL of a ptimer
 across guest entry and exits
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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
 <38722ba7-b7d9-368b-f946-b6c0c0a661b8@os.amperecomputing.com>
 <87v8bz52bq.wl-maz@kernel.org>
 <45a2d1c6-821e-d55f-f59f-c214a11e0df0@os.amperecomputing.com>
 <ff458bae-2681-1464-d68e-f9d04098c8b4@os.amperecomputing.com>
In-Reply-To: <ff458bae-2681-1464-d68e-f9d04098c8b4@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|MW4PR01MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a69f300-0b6f-457c-28a8-08dbc94d05cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hv559ipT1QQTChLiByq+Pbyh6teRHcYvCXOLA5dbDYXM3zlsiDmBkZxEJXAZIiUh6wbGEc2kTAmhI+0zmx2TTqMwD4vLjIgOu3efBASkh83SwUVcZTYdWCIuYDPsoNTE+Y5V6YW5GHM1YjeVUEkRORyHKW1AZwqSM7xO1emwfeKHAQFFVMyAuQBOycMBaegxfEqswqQ6IWugVaMYVP2HZK5dPuHW1gqocx0/ew+2sU9tILPRq2TRrbxo+TzDYM4uw0aJQylzsYc0/mzrUBMc04MDj0NmVEX513sUDobt/RuBbHja72rDjtLaTvw1/Zzs8IFuUQIFMZj1VP+Twj772xhv6FDMhE1Lu0Hsy8I8ZSQJyrvNGFGmuhCPfp+smOp9yAstxzVBF7vhBdIwiAyL6tMU5XEZ55/Jaut8Y6fzXkejNhKolqGqXE177zDsN5w1JEhfeA0oOeCMvKxngsBEEZfUbalNyWFgkrIpcpXl/WzVrtVoVz7QG9xtK17ZD9gdzPcA076vM4QJBP/P+ljkvZg0UJM3O78z+XBGMwwancLcVSTtt9Mpl10tKMf7P8B7rCTQB40W2YeOAslpMwcXaQQulDtmJ9ITHJTwYru9/z8hwIfEcIw4oBhNzZ45CA+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39850400004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(83380400001)(107886003)(2616005)(26005)(66946007)(66476007)(66556008)(6916009)(316002)(41300700001)(53546011)(38100700002)(8676002)(4326008)(8936002)(2906002)(5660300002)(6666004)(6512007)(6506007)(86362001)(31696002)(478600001)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGtNVVluK1RERURHOXlNaDY2djRWUnJuRHJHbU5SMTYrbXVhbmU0NDJReGtV?=
 =?utf-8?B?dXliRkVEbnhUTmNubzNQOE5HcUxTMUtuaDZGakI4T2d0WEQ3M0ZtSWxPeEl3?=
 =?utf-8?B?Z2FmUU1KazRwdTBnV1h6ODJ1UUdlazBTVlhHVEhid2h1cGoxdHE1L09uL2Mr?=
 =?utf-8?B?azZqVFhFa3cxVXNYL1dsT3dVbENlQXdLNmxSL21RU1N4QUp2L01GYTFjWDV6?=
 =?utf-8?B?VnJHMk91c2U4TmM0V3VhZzR6cjNweGQzYWpSdEdhTldJbHk4UXc4cUtULy9y?=
 =?utf-8?B?RldHMGRqQU1vMGRjYzVpSHEwOGhBOWNFQ2lwRk8zeVE0ZHFWRTNoeFlQeHFm?=
 =?utf-8?B?Z29zejA5aGVyWTB2S0dSekY3MU12TVoxakszdWpmRUpCNFZvZS9sRlhjWm16?=
 =?utf-8?B?aHJMRUVUWjA3c1F5V2lCWEMxT3hDYWNydC95YU93bzdIMHoybFB3dG1wM2NH?=
 =?utf-8?B?eGtkVzBZUFVkWVlUSGxMdDh3ejQ4STUvWW05ZkZPTnlSSWZrN0RnbHZxY201?=
 =?utf-8?B?cTRvRTVEL1h3Q1NzZE01YlIzYkdHV0h2QUlhQnFzNHVjWkNRMWN5bWZGdVBO?=
 =?utf-8?B?L1VPVnFMb29UZ3VJS2NuWjlxL0xoT2g3dnp4cFBCMWdLd3MzQU5nSUVGbVlN?=
 =?utf-8?B?Y2RzbkM5QzdEQko1Yi8zOXpJWUQrak1teDVEUVNnWjRDaUFQNVdOSThpNFdN?=
 =?utf-8?B?ZE9jdkkvT292TkVHOFlZUkluZ3JHeHFTbTUxSElKZlRWQktRTGhBOFpOOFl4?=
 =?utf-8?B?aE0vanNQdnRvSkVMdlUzdVdTYTJ4blhxcFMvZGcreWlJM1FDa3VUUHpTNXgv?=
 =?utf-8?B?UTI2SXBsMTZ1NFdFL2hmMUVOV0o4ZFVXN0g1aTdaOGtsYUErdDVNOU1PTzky?=
 =?utf-8?B?Z1VNWmJmUjdnS01OZkFmcDhwWWhxMWMvbWNUbmxMZ3l5MDBMYWtBTE1vMFNk?=
 =?utf-8?B?VWFZVGNzRHdHSzhGOHpkeGN3cTUwWitaa01Rb2EvOGxsMXlDQVJrakxLQ2hw?=
 =?utf-8?B?cDFLU0FkaU90TWhKWGUrcE5RS3N4cGF3UTdCTGlhVjhSR2JyR2VicmlSMTUz?=
 =?utf-8?B?Y0NJQjg3RmxadTY5aCtnMlpCeitDV2w5M1JnSGRWM203LzZNNEthR0NETzFE?=
 =?utf-8?B?ZFlnNFdLRGtsVFcvWUI5NGJQSU9Ba0JZVkRHMy9pak80R2N1MXJNQm5rMjMx?=
 =?utf-8?B?dXh1ZEp1czl1SXlaUk5CMkhXWjc5c2ZNU0dRbHl6cWpwcDAzeTdqeUVlZVBR?=
 =?utf-8?B?VllYR2kyYzlzb0pKMmI1eFlKbWdwTTZISXNrTisvdFVpV0syWUE1RncycjRP?=
 =?utf-8?B?M2NSYVhaNDN5bUhrMEVFUVMzU1FGSHlOTmpSVFJuYmsvTHdGNjBnRGU5amFk?=
 =?utf-8?B?c0gwcFI5NUJHRVNzdzBicmNJMzJuZW1UejNqMFh1OElJUWlybnphTzY0ZFZn?=
 =?utf-8?B?R0RyT0VnVlJlUktaNjhkcFdXNkoyNWJMa1FhUU11U0s4UW5rVGZtOVZhVjB5?=
 =?utf-8?B?eXZSRjRXTW9ad2hkOFFtQTBkbDYzdHB2OEhDNnk3akNMWkY4WE5VZ1Jua1ZJ?=
 =?utf-8?B?M3loSEdRaEowRTJPMUxKL0lpend4V0QrQmF2MUM0ZzZKaW5jUzdIMWVEcXNR?=
 =?utf-8?B?Slhaays0OFZRcDQ2ekZ2VmhLWXZPUnZ5RTFCL25ETXBRYlF4Nno3TmNQZEho?=
 =?utf-8?B?b0ZoTlVXbmd5dEFwSEU0c2hrWXZpaHJ3NWEvU214UW1BRmtGV1Y0NnAwN2Qw?=
 =?utf-8?B?UEcyTXFyRFhwaTJNeDY1Ui9NS29qaDhzMys1dGVRa0hWSXBTeVNWWjA1TDJK?=
 =?utf-8?B?aFljUjI4ekU1anZUb3JWejRhRnpYcHZnR2pqT082UEVkVlh6ZHhLUGcrdnFU?=
 =?utf-8?B?N2QyZXVoUDlFSXJ1TkRHQVVtazkrc0ErQm56N0w1dTd0NlJXWisrOWU2dDQ0?=
 =?utf-8?B?ejYvUGtiRWltQjVobVo0V2tqWlM2M0ttSEt1aVJRSDN1ZGR1N3V1aGRjLzUz?=
 =?utf-8?B?d3lLY09vK01uMmJTS0ZMOEJrYmJ0OFZLYVpIOUdjNEpvTDdDUUVhNDhPdnYr?=
 =?utf-8?B?QjBtbkdOS2M0VFZHb2JsYlBSaUVWeUcvSTRPWHpGc2FiRGNjWVJNd3ZtSlc4?=
 =?utf-8?B?MXdHRzM0dThTTW1ZUHVzSkVxUGNnMC93QU5uQmZ0N0l0V1I5aGNFSHlwNnFx?=
 =?utf-8?Q?QmV9HbmUxgZuE3/wED1IQHAfhROfgh4jskIh61jq4nM3?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a69f300-0b6f-457c-28a8-08dbc94d05cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:54:45.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8Q09qcaraJmjMgfgWLPHqYBpvqrFuyWqq4Z2zZN5UEASU/3wyQ1D2NyYMVl57b8CjcUOYId7EUXaKsmNJUNKFcc5O7RL3NGkQol+mesEck1E3VoFbBW8mQoFFw9mNB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6354
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 25-09-2023 11:10 am, Ganapatrao Kulkarni wrote:
> 
> 
> On 25-09-2023 11:05 am, Ganapatrao Kulkarni wrote:
>>
>>
>> On 24-09-2023 03:18 pm, Marc Zyngier wrote:
>>> On Tue, 19 Sep 2023 07:15:44 +0100,
>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>
>>>>
>>>>
>>>> On 18-09-2023 04:59 pm, Marc Zyngier wrote:
>>>>> On Fri, 15 Sep 2023 10:57:46 +0100,
>>>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>>>
>>>>>> This patch did not work.
>>>>>> After adding changes as in below diff, it is started working.
>>>>>
>>>>> Thanks for looking into this.
>>>>>
>>>>>>
>>>>>> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c
>>>>>> b/arch/arm64/kvm/hyp/vhe/switch.c
>>>>>> index b0b07658f77d..91d2cfb03e26 100644
>>>>>> --- a/arch/arm64/kvm/hyp/vhe/switch.c
>>>>>> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
>>>>>> @@ -117,7 +117,7 @@ static void __activate_traps(struct kvm_vcpu 
>>>>>> *vcpu)
>>>>>>                           val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
>>>>>>
>>>>>>                   if (map.direct_ptimer) {
>>>>>> -                       write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
>>>>>> +                       write_sysreg_el0(val, SYS_CNTP_CVAL);
>>>>>
>>>>> Duh, of course. Silly me.
>>>>>
>>>>>>                           isb();
>>>>>>                   }
>>>>>>           }
>>>>>> @@ -161,8 +161,6 @@ static void __deactivate_traps(struct kvm_vcpu 
>>>>>> *vcpu)
>>>>>>
>>>>>>           ___deactivate_traps(vcpu);
>>>>>>
>>>>>> -       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>>>>>> -
>>>>>>           if (has_cntpoff()) {
>>>>>>                   struct timer_map map;
>>>>>>                   u64 val, offset;
>>>>>> @@ -173,7 +171,7 @@ static void __deactivate_traps(struct kvm_vcpu 
>>>>>> *vcpu)
>>>>>>                    * We're exiting the guest. Save the latest CVAL 
>>>>>> value
>>>>>>                    * to memory and apply the offset now that TGE 
>>>>>> is set.
>>>>>>                    */
>>>>>> -               val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
>>>>>> +               val = read_sysreg_el0(SYS_CNTP_CVAL);
>>>>>>                   if (map.direct_ptimer == vcpu_ptimer(vcpu))
>>>>>>                           __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
>>>>>>                   if (map.direct_ptimer == vcpu_hptimer(vcpu))
>>>>>> @@ -182,12 +180,13 @@ static void __deactivate_traps(struct 
>>>>>> kvm_vcpu *vcpu)
>>>>>>                   offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>>>>>>
>>>>>>                   if (map.direct_ptimer && offset) {
>>>>>> -                       offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>>>>>> -                       write_sysreg_s(val + offset, 
>>>>>> SYS_CNTP_CVAL_EL0);
>>>>>> +                       write_sysreg_el0(val + offset, 
>>>>>> SYS_CNTP_CVAL);
>>>>>>                           isb();
>>>>>>                   }
>>>>>>           }
>>>>>>
>>>>>> +       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>>>>>
>>>>> Why moving the HCR_EL2 update? I don't grok what it changes. Or is it
>>>>
>>>> This the line of code which flips the TGE and making timer cval ready
>>>> to handle the TGE flip is more safe way(avoids even corner case of
>>>> false interrupt triggers) than changing after the flipping?
>>>
>>> That's pretty dubious. Do you actually see it firing on your HW?
>>>
>>>>
>>>>> that you end-up with spurious interrupts because your GIC is slow to
>>>>> retire interrupts that are transiently pending?
>>>>
>>>> IIUC, If there are any transient interrupts or asserted already,
>>>> anyway they will be handled when irq is unmasked.
>>>
>>> That's the idea. But my question is whether you observe spurious
>>> interrupts when not changing the ordering.
>>
>> I tried with keeping the ordering (i.e flip TGE then change cval) and 
>> i don't see any issue as such. IMO, it is better to have cval updated 
>> before TGE flip, anyway either way works for us.
>>
> 
> Please feel free to add,
> Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> 

Are you planning to take this patch as part of NV-V11 or going as fix 
patch to next?

Thanks,
Ganapat
