Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3A7ACF87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjIYFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjIYFkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:40:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EDDA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 22:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGzpZ8XKG+vg/Bg0EeCepJ8psRmHZRafqEfbzXnWQeSx9aQOgXGGwdU/Wck29/8+cs2sBXxE1IASukZLXBVSizS5D4oFGo9+8x4pHTrXDMtqSaobTTNSfispuIhPp/2DV9EefRaPeDsf5Qig5t2U7wluQyN+bxakTqSN5uEZgmRWn2oEjMP4yl8lqoGVhlQgrNyIPyM43IFhDrmytt093e2CPg4i5h2i/yByn063BG87N6woDf+hyIqpwHIcdWVXNJY1k7BXVBImQU0wRJiawTzNnonqZr5J9/r/P2NI0XlDPXjIWua9HBOx/+Su+K4qHXgJ9OQiiZ5FvPfAAdxE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLZjwHCqxtqtwAOAzCAZlFmluMrshZGbAe89Uw2XvFU=;
 b=PccDhUOadnniSPUz6pyPW5OcnD8TUDXDhcUinZPE7cTiDzYb9av9iaGRcqsk+ZldwEuMq8mElwT52TNyCe89kGaNmjwukt0NEXTneDbLQjvXzmV5oMPfax0DMeh5C6lvcoFRz8TL3HWtYmUSnM+deEQyoQvu8SQdOamKpzhgny+NJeieUeqkAwIg4MwBy4HdQGziB2KB/uk4cksRzhj37JEuv9Vcp4qIysS9Hoc9L3aZNV5cirdJ6IKEmLKQMe/RDwtrgWVLGs2WG7jf+7iGDgSTv7q25WIK/UlaCKQ54Fo8FhuPHI55HiZ579blYFtUZ/txyB/7d8R0TnsbWXtW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLZjwHCqxtqtwAOAzCAZlFmluMrshZGbAe89Uw2XvFU=;
 b=k0p8a+6mtVlS6QnNBhD+5tNAyaAwPcW12Y0/apYi6ut9Y5D8LX9oOMgCQoXqaFss7TEQYzN4eIuzEPplI+OEXA46D57tRZ+FAr8fJo/pyZbtCf9FO/4ni+uKQVUwt2qAaG+LlacWa9x7XIfyG3OGqE/FvCMDrkdfDjOwPyO17f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SN4PR01MB7407.prod.exchangelabs.com (2603:10b6:806:1ea::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Mon, 25 Sep 2023 05:40:28 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d686:ac07:89b3:e724]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d686:ac07:89b3:e724%3]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 05:40:28 +0000
Message-ID: <ff458bae-2681-1464-d68e-f9d04098c8b4@os.amperecomputing.com>
Date:   Mon, 25 Sep 2023 11:10:18 +0530
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
In-Reply-To: <45a2d1c6-821e-d55f-f59f-c214a11e0df0@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:930:4e::20) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SN4PR01MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7932e687-cb94-47d0-028e-08dbbd89ec89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02cWuXYzE7Db3Vh6QBIuzIJWIePJDLKU+q2vX1Sq12l0SMglPunVVBTDPtEMCwn3ttycfEGofmEmS91AS9db3Z7k+kha3Ofy2pNM/FhiT1ePKSDNls1aasmlBGnQ7VNIOa3rFynP25UnYa/19Va4Sf1u9K0C0Xfe3ixneOJz3usjOrKJfbfXG5+qvy63VXAVxarNBeOLr1UXnlEImi4MjB4x9goI/o2+uYZm+z7HG85P2SXkgTbG7CqPlYdzvHwpU9WrJdwcRgLKrUlaq/MGI1NZzXTNNfHoufz69ubknK5nJAcyZRh1Cy1VVA5YAPAZnCmbkxj6jB4ieajVDgleHwv8jJXs0eQZ2EhDtnzQRto/DjHjGtOa7tNktKgK1yp/jrgZEWDwDkQJhKQi038BkCgLf0w9GMYDuNDdamiB3yQw77KSgoaXSgyfjepmvCkZIjfW94H6RC6MOWlfvii4tAT1cGBRmninMsFSg6oCjnzbCIjBuyPG6bpjdZ53zN3yM+ypecYnfbJvyT3ewPeH8AOGluDXTtFyrCr+wdtEOZTuQmS8tKJSdqc/ZxQNSUiT9xd/vnHCE7z7jC20iLpgxwtISvNMFezpYf1/ZEYEVy9Bj4cBIJdxLoc7GrBAl7FB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39850400004)(346002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6506007)(8936002)(8676002)(53546011)(316002)(6916009)(5660300002)(31686004)(478600001)(2906002)(2616005)(6486002)(4326008)(66476007)(66946007)(66556008)(26005)(107886003)(6666004)(83380400001)(41300700001)(38100700002)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNFNVRCbEc5Z2N6YzhCUnNoU2Q5a2lQd1g4eVh4MWtqUU91Y1FSTGIwdTVk?=
 =?utf-8?B?U3IreUpTNEpaa2N6OGt5Y2VNeWRTM0FQTzE3ZVp5Z0RSN2V3Y3NETnQzYnJv?=
 =?utf-8?B?WjlCZW1nVTRaSm84eHQyQTZndllPVHpoTm5HZXpRTmJXbVpsdmJxZEZKM3Zo?=
 =?utf-8?B?Mi8yS0xCc1hHLzhFbWVnd3puSHEwYmFYUDJ1WWNDbDR6KzNxdUdyZEszeS82?=
 =?utf-8?B?Yks0YWNuSVM2MDhmTnZsYVdEVy9TdTdNNXU5T0pJQjM5QnpZL1hkWWpHc0sy?=
 =?utf-8?B?QlN4Vm1MdVRUNlBqMENZcnd6WXhFMkFVcWtTTEFQTnlxMTduT1ZTREx3bDVh?=
 =?utf-8?B?TWhCUTFGbXhEUHdVSHk3RTlQS3NwV0xKYUw0QllPSlNZNjVmNmZPYkNFNFZ6?=
 =?utf-8?B?WEZIaE9oSks1Y205OTVRVytTMncvcTYvcUZjUU54ajhURkpOK0IwaUhxa2VI?=
 =?utf-8?B?dXNxZUlDcHNzYkZVeURqSzBBYjBhNE1EdS9FWGRBcWpFbUJ0RGxTRklxQ2tm?=
 =?utf-8?B?OUhqMk5IMVEySWxadUlXeGhYRUl3RCt6WXltaTN0QkJ5UkNzQXlSRW5TSkgr?=
 =?utf-8?B?N0Z2WXJLSGJnUmRHTDBnZ0d4OE04RFNvK0tsd3ZXdG9JM2FqVG9zUmJ2dFlC?=
 =?utf-8?B?dS9ydVVKK1NmbkVUc3NmMkRuY21RN00wc0Z5RWxDUXdoUmNNSStmQzBZK1JI?=
 =?utf-8?B?MVN5SjNtcFdUQnp3c0lzZlZVamE0TXRkRnJuaGhYQnhibFF1TGFUaU0yN2FT?=
 =?utf-8?B?eEZTNS9UMGFaKzRmaU91R2ZZWTJpNTZUMFJ3OHdueDVVeUsxNnFkRktMUlBO?=
 =?utf-8?B?ZGphNmxWSG5RazhVVHhFY0VIVkt5K3dtVlE1ZkZtK3hBbFhacG9WTU9CZXV5?=
 =?utf-8?B?TFdFSldOT05wLzJEaFRySHhqdHd1OTBlcGdUOHNwZjluYm5FR3ZFeEw4YjJY?=
 =?utf-8?B?cE1zdjVabytRYnk4VjM2VEVwUXdkNGRzLzVLZXdHM3ZUK3dwaWl0QlVpaE84?=
 =?utf-8?B?SWNaWS84RnYrOERodFZJZk0rZzlLbDRzS1AzRVEyQ2JtcENlSHdLMU1FOXVo?=
 =?utf-8?B?NzRiNGtaN09TN21sdFJ2VVZlT05BeWYxcjdSUENhMk9ZcDM0RUVxR1d3T1Ux?=
 =?utf-8?B?NzZQOFBVc080K29NR0xqRXNoS1FzRGdPMnlqcllTM3gySzFlc2tBaTZ5SHlY?=
 =?utf-8?B?ZEZtTzVaKzRNNnFZbDVEL3RxLzl2SlQzdHY2VllIcXQ2RkxudlVCb0tPVlJD?=
 =?utf-8?B?eE1GZjdpNk9QV1hZcWl5clZvVkxkSnRuallUNnZneFNGdis5RzAzZ21STmE2?=
 =?utf-8?B?MnhnSk5iWG81YTJGV244cjhJdWdWeDdVd0cwQWtnQ0hMVGt5NDc1ZHFyZ3ZY?=
 =?utf-8?B?eXlOdlMzdEJnOVVlWmNnM2gydS9aQmthWEtZQmlxTURLem1XNXJxZTZFWjUz?=
 =?utf-8?B?dHEwRnJPWjduWGFrSDBibXNKVlNtSW4xSWNmWVV2OGZwTXFZbmZtbXhKMlR0?=
 =?utf-8?B?QmxWUUNLRDJDNGp5OHhFNzV4SUFxR3ZLZkIzTWFTWWRZMUhrdSswd2E2Q3FO?=
 =?utf-8?B?VzZzZnpjZEdhUDNUMjJ0ck5mRXNGRmJ0RnR5Skgwem0rdDJlNFFHcWJmcFEw?=
 =?utf-8?B?akZoL0REalZoTkFYcXlMYThwcHQreDlmOTF2NXUrMDIwY0c1VmpRdlJ0QWZi?=
 =?utf-8?B?cGFjdDR3NElkeWM1RW9MSjUwM1podmVjaWswblVjQm9WWmw2OW5NUE8xOEpR?=
 =?utf-8?B?d2ZlYlBwbDdYMmhRdW9vMWJycThWek1aY2hJYlNDYTVuNVE5bFkzSW0yd09R?=
 =?utf-8?B?dEkxMHdyRUFsVzlPaXhXUUMwUkhOaXFDekdHeGJLc2tiTXZiMlNGZytZY3ZR?=
 =?utf-8?B?OHFXSExNRVZrNWhiMVdFUk13MVQ0bXlHNXdQRGNqemNJYXZybzU2dDlyaEZ4?=
 =?utf-8?B?K043cXRQRmRJM05PNnZQVFBtQ3F5SFdTQVI4Z1FTdllwUC9jRnhlM1Z1QVhs?=
 =?utf-8?B?OVVBMWZxNUltN1ZHRS9RSk90Ukp6R2hac0pJQ2pRMXNWSGxZbGRIcmtNSngv?=
 =?utf-8?B?bEZHV0ZnUWtjZHdBaW5BM0tSQ1FTY2RLTDZxSHk4QXRCSFcrcHluUTZod2Z1?=
 =?utf-8?B?THJPemJnd2NQOGdISlExZzFmTjJ6dmR1VzRVY09yaGE3c2VjU1FBVFkrNEZo?=
 =?utf-8?Q?MfpKbnYVOTsn5Oi8KLgQG+I8+XFIBJzVgrYYm6u10lYA?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7932e687-cb94-47d0-028e-08dbbd89ec89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 05:40:28.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWNOrAlWdIWDcHN9FVyYq+Ipl1zjiTladfwcedw0ScibwDN8E+9vxzb7/Ze7QOK4koJFaLqsJhOt+CTsEfx3dktHbZO9xCcxdyWJ5cO6osIyrLeDCH7IvpR3heOk3Uef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7407
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25-09-2023 11:05 am, Ganapatrao Kulkarni wrote:
> 
> 
> On 24-09-2023 03:18 pm, Marc Zyngier wrote:
>> On Tue, 19 Sep 2023 07:15:44 +0100,
>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>
>>>
>>>
>>> On 18-09-2023 04:59 pm, Marc Zyngier wrote:
>>>> On Fri, 15 Sep 2023 10:57:46 +0100,
>>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>>
>>>>> This patch did not work.
>>>>> After adding changes as in below diff, it is started working.
>>>>
>>>> Thanks for looking into this.
>>>>
>>>>>
>>>>> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c
>>>>> b/arch/arm64/kvm/hyp/vhe/switch.c
>>>>> index b0b07658f77d..91d2cfb03e26 100644
>>>>> --- a/arch/arm64/kvm/hyp/vhe/switch.c
>>>>> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
>>>>> @@ -117,7 +117,7 @@ static void __activate_traps(struct kvm_vcpu 
>>>>> *vcpu)
>>>>>                           val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
>>>>>
>>>>>                   if (map.direct_ptimer) {
>>>>> -                       write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
>>>>> +                       write_sysreg_el0(val, SYS_CNTP_CVAL);
>>>>
>>>> Duh, of course. Silly me.
>>>>
>>>>>                           isb();
>>>>>                   }
>>>>>           }
>>>>> @@ -161,8 +161,6 @@ static void __deactivate_traps(struct kvm_vcpu 
>>>>> *vcpu)
>>>>>
>>>>>           ___deactivate_traps(vcpu);
>>>>>
>>>>> -       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>>>>> -
>>>>>           if (has_cntpoff()) {
>>>>>                   struct timer_map map;
>>>>>                   u64 val, offset;
>>>>> @@ -173,7 +171,7 @@ static void __deactivate_traps(struct kvm_vcpu 
>>>>> *vcpu)
>>>>>                    * We're exiting the guest. Save the latest CVAL 
>>>>> value
>>>>>                    * to memory and apply the offset now that TGE is 
>>>>> set.
>>>>>                    */
>>>>> -               val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
>>>>> +               val = read_sysreg_el0(SYS_CNTP_CVAL);
>>>>>                   if (map.direct_ptimer == vcpu_ptimer(vcpu))
>>>>>                           __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
>>>>>                   if (map.direct_ptimer == vcpu_hptimer(vcpu))
>>>>> @@ -182,12 +180,13 @@ static void __deactivate_traps(struct 
>>>>> kvm_vcpu *vcpu)
>>>>>                   offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>>>>>
>>>>>                   if (map.direct_ptimer && offset) {
>>>>> -                       offset = read_sysreg_s(SYS_CNTPOFF_EL2);
>>>>> -                       write_sysreg_s(val + offset, 
>>>>> SYS_CNTP_CVAL_EL0);
>>>>> +                       write_sysreg_el0(val + offset, SYS_CNTP_CVAL);
>>>>>                           isb();
>>>>>                   }
>>>>>           }
>>>>>
>>>>> +       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>>>>
>>>> Why moving the HCR_EL2 update? I don't grok what it changes. Or is it
>>>
>>> This the line of code which flips the TGE and making timer cval ready
>>> to handle the TGE flip is more safe way(avoids even corner case of
>>> false interrupt triggers) than changing after the flipping?
>>
>> That's pretty dubious. Do you actually see it firing on your HW?
>>
>>>
>>>> that you end-up with spurious interrupts because your GIC is slow to
>>>> retire interrupts that are transiently pending?
>>>
>>> IIUC, If there are any transient interrupts or asserted already,
>>> anyway they will be handled when irq is unmasked.
>>
>> That's the idea. But my question is whether you observe spurious
>> interrupts when not changing the ordering.
> 
> I tried with keeping the ordering (i.e flip TGE then change cval) and i 
> don't see any issue as such. IMO, it is better to have cval updated 
> before TGE flip, anyway either way works for us.
> 

Please feel free to add,
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>

>>
>> Thanks,
>>
>>     M.
>>
> 
> Thanks,
> Ganapat

Thanks,
Ganapat
