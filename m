Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522887A1B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjIOKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjIOKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:00:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DAC4211
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkifi0GJX4ZkudSgYSqd8exJfohB8wdooXEmmLiSBc20ssTjQ6y0ui3WdkrjyetHspoLXXOGccQjsP7TwG0FHgbW9KKVuAW83Q64FDgKWOmrcNWga/Rjn9h788e80pLJKi4Rxzm8PpQJ6o0/zfbXGtb0xlU8/WjkTdwZ8jEeviJAySBhP4BimAPdqEo5lcZ1F54YNagokyl/Psk0aEGXw+JjOXWYNFaw1zXnOSBU6fe8YsI1/YGoF9eBIZcYdXrs9fhcSE954x1AwQnOlvzwN8AsEJmrjct1waDBSf/8nVc45fZopgjjsIyTg1m082qf/31ew1/6y7iGqbgt47B6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKOcWeWlh7aAP0IPLVHtQ4ziYZXa+0dnVwgqBx81bSQ=;
 b=eOpZtpzVIXx8r7LNngO3HwWkzNrLK4ynduU4wg/3B7XRhwJiqjE9VJNYq2QWA107O7J4q834xd/jAXbmMcXuENIMsw/G3UaIH7DLGpf1c0hksFyhJfmZ3tF7J+RZlwaYH35KyoQs8DqkIOJFVtVwb44owkqxfwWYfZGhJADH4XrlAONZkGG274yGXa72fMXISnrWEQeq5g1pcIa/FYVB8G1MYCqaDP5YYaI+6rDbKjMxE4Fwqo72h+ANtE/3q4KQHHs4meVyAP1oKLL0wLcOD5/xnjEWwNI8+tAwMfCzHU6pXIqRzcTSdJgqo7rE1zR9h/MRMLPxMl8T4aeToWVepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKOcWeWlh7aAP0IPLVHtQ4ziYZXa+0dnVwgqBx81bSQ=;
 b=WHtpfGNJma3QeWUWvmaWbkO7gWaiupH8z4od68qiXbK/qeeEQPtUDzxyNnUdP+df9s5deLy4KLROsN35LXz2FK9UJxlyOBvkvcS8q0r7zDmhTloQ1sVB+I4ntt6KkHHISlq5rSlyPLWtcGK+vK4H9hnWWLpEtqw0FLceIpeD5B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 PH0PR01MB8095.prod.exchangelabs.com (2603:10b6:510:291::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Fri, 15 Sep 2023 09:57:58 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d686:ac07:89b3:e724]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d686:ac07:89b3:e724%3]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 09:57:57 +0000
Message-ID: <ec322123-bfe7-6019-7f35-de326ee7b6c3@os.amperecomputing.com>
Date:   Fri, 15 Sep 2023 15:27:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] KVM: arm64: timers: Save restore CVAL of a ptimer
 across guest entry and exits
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, Christoffer.Dall@arm.com,
        eauger@redhat.com, miguel.luis@oracle.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
 <20230904114218.590304-3-gankulkarni@os.amperecomputing.com>
 <86bkeadzf0.wl-maz@kernel.org>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <86bkeadzf0.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:610:57::23) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|PH0PR01MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 840d68da-e4b2-4212-e1f1-08dbb5d23cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FoGeckqAyb0LhKiR17mjWLRCyDfiE6Gy47gOJuqVzIRfkSnQwleu/gPrLkKuSEXy40SxF6RqLY/1eVtwQ9cBvv/KAAzZMFHe/QT+FaUcVn5nU2zJP9XBSVz7088n1BeafV8j3QkyPW7CZna7S+0XD5vUU/1wHe/OHjcnjaxoZ6wFPaADK4AAIwQ2dXn+v5d82tm0+qXV56CZKdXcGEjO1hc9BgbXMQYjnhx9ikaN8wE+II6LHnTsOro5ZsdgBFzdRhfk9MoR+yGEKdbvVJmP2X061gryy4ie9kdBhAVI7j2ynO26Ni50984fDKtOaPWV8s3mVuRd5vp0l2k3u2sRQhD/dCMYaJhGb5hl6ieDfl0IULte3ywOwuH3BUFIkonx7ZySaovMMusapeSDZPKDnIq8hOBgKah0l6Y7JNgzuQ725TSV4vbveBzPRyVkM5FPk1zoPradzYjLddlt9iCN+W9bIVljJeR5ctH2rHW6G4y7W341uVit8jyg00dKmybKOWxATHYkiuqkK5dImVR5TM5xFhEKrsKcdRTctQOCVdZw6zU5T57yLYqApaCpyNQBjyXmRgqDGdUIQ8WLOxIds6/JGYZPd4zVOzso/Q2e13U3RxyKQJhrd0Hg1J1YkLhC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39850400004)(136003)(186009)(1800799009)(451199024)(26005)(53546011)(6506007)(8676002)(6512007)(31696002)(6666004)(86362001)(107886003)(6486002)(478600001)(2616005)(83380400001)(8936002)(66946007)(5660300002)(66556008)(2906002)(6916009)(66476007)(4326008)(41300700001)(38100700002)(316002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bllBWC9ibE1NWE9Sb3A3ZlhVODFHZjhiVUlzNnhIcGRQZmxlY0NBcW9tQjdq?=
 =?utf-8?B?aldGMm5oTmlLTWhGNmRLaW5LYkhzb1NlMW8xOC9vUG05UHRidVo4ZnZKZ2RC?=
 =?utf-8?B?YVJjSW5qNjdKNFVhN0VqcWl6bDJBdFAvc3BMOXFBS0VqQUdjMkh2UnNBUis5?=
 =?utf-8?B?TDNGKzd6dkZuYXpSZGpzbVdiMnU0Z0FNY2pBbWJYTHhqR09UOG1zV28zdk5E?=
 =?utf-8?B?dkM4Si91QWl4RW1rSW04UUVkS3d4YzdzUVdzYUJIODhYSmVVYWtUa2VHcFdu?=
 =?utf-8?B?Q09mZVBHeUJqUU56aUJyUWhIRkVCL3doSkZTVmpSNVNpZ3A0SDUramdPOUVG?=
 =?utf-8?B?YjcwWjBZQlVRMTNXSSs4SDVsQUUrMm9UYUhTSmJkY0xHb0I1RzdmSkpGSlZ3?=
 =?utf-8?B?bjh0anVSMSs2TG1ZTUdPb3FUK1RtL0hhRTRJOUV0TzUxNnJERmxDZmpvS1VU?=
 =?utf-8?B?WnYzeHJXeXVLNDV6UzRZeXFhc2tMa0ZxNlFwK2x5N1pjU1VEYmV1RGZQcE9i?=
 =?utf-8?B?ekM0SE40dXJnekdwMTJPTG8vdk5pdFgxNCs4bUhFSHh5WTcwczlwS2hzYTNl?=
 =?utf-8?B?Q3owV0N1VDd3bGYxTlpXdkpUdFFWVmVQU2FrdWhDZGpSYjg3S0Nia1k1MkMz?=
 =?utf-8?B?QlR3WVBxOEUvRmtMWENPR09oU2dGb3A5WnNic0lMYXcvcW8veFZZbDRwYUN5?=
 =?utf-8?B?aGlzTlVYWHlTcDdQSVgxekJaTEpmUHNla0RhdUU0bC9MNlhXa1pFeUpoMU4x?=
 =?utf-8?B?YWtMbDNXTXlKeWNKc1VzWGVYcUUxOE02b0lHZ3BYYXF1RGc0RHVFRGlKMEgz?=
 =?utf-8?B?R21tU3BnL1ZJZUwyNS8vRnZqSnkvM1l1d1ZVMlNPL2ZXOHJIdXc4elVlL0p3?=
 =?utf-8?B?NzJzVjlXeUtCVVA5UlVWZDJKQmdlKzYyby9EUnVraDB6UnJld250a09EZzJq?=
 =?utf-8?B?dFFQRm42dGo5dHhmampOd1VVUmxFSGRnNCtHcXluU2lxRExWZGxXZG1SaWpN?=
 =?utf-8?B?VVFGWm9nV2ZNZGNXTGlsM0l4S1NZSFhTMi9MNDZ2Z1d4eXk5V21OS0ZCYVBj?=
 =?utf-8?B?dGhBMzNLVGQybllWODZJUjlMQzIvcVYzOWVzdTV0d0R4MkFEbUFia3h0Sm9N?=
 =?utf-8?B?Szk3bmFaMXBmdHlNWjZvY0d1SXBxMktkRVBQZmw0OEVPNHNKb3NVT29qZEZB?=
 =?utf-8?B?SFNTN2FzN0V1eEFmL2ZWUlFyQ0FvTER3SkNtQ0xuRVhPNm9lTjBiWG5wN0hy?=
 =?utf-8?B?MzEyQ2lzalBCTzZWSStSaTZhaElsN01sczU5aHlwQUpjMldqZDhrY1luUUVi?=
 =?utf-8?B?Z242LzhwNk40TVNYUUVqU3paWE92cFNNY2Rvc0ZEcGowWG1tWGUvUkJUcXpm?=
 =?utf-8?B?TlNuekppbWROU3pWR3hZSnFRa0ZtTEZkb1BqWUxwMWtUejFyOTl3OUwxM2Q5?=
 =?utf-8?B?ZUFvaUEzaUNGNU5kZ3k0UVdza0dac1NTS0xEM2lvajFxeTZyTnFMd3g5bmgy?=
 =?utf-8?B?akdBK1E4T1pSeS91RzR3dkpEbmplbkJBYVBKYWpyZlVVU2gybi8wOFpxNHFY?=
 =?utf-8?B?VFJ5d1JmRHhLcGM3UGo1a0xCa1lzazJZR3k0NGxseERFUGR3RVpkWTBYVnJI?=
 =?utf-8?B?OXNFd2RWNHNjK1ZFSFVwaHNCeGwzWXVNaHlXZ0JvZ0U5Mk03czFRcDNFRys4?=
 =?utf-8?B?YWhldVl6bDJacG9XaEhmc2l4V2FXUXBZS0doaHV0L0ZLdzFuckY0eEEzODF6?=
 =?utf-8?B?WC9PQStjSWJmeFRyVzNsRDVZTmNaZ21SYjJua3doaEdLcFBtOFIwVUp6QTV6?=
 =?utf-8?B?UURwMXp5TFRpMWpCSmtwcmFaK1Fhd0IxQzRzVFNGa2NKWEdlajhjMDliRFJs?=
 =?utf-8?B?Tys5ZGN1UnIzdjk1OTUrRXI1aEFZQzJFOTdERDEvSEJQRGFuVWhKMGJReU8r?=
 =?utf-8?B?RWdDRGFqelYwRWxka3V2clJWM3N5STJXWWZKQmhqUStxZXB5ZlVWa21EVG1q?=
 =?utf-8?B?WXZVU0dkcTY2dkdOZDc3Yit5WkEvU3pFRGkxbUwyUmxjbEVkeTBVcFZGRnQx?=
 =?utf-8?B?S3NDLzdjcnB4UWFGaURzZ1pMNzRCT0RJZTh4VGh6KzgxNm1jOXdQbWtuSVBC?=
 =?utf-8?B?SDdVN0ZrdWUzQ3U5dVRhRjM1aExnSGtzVjlIa2I0UEJjaUs5a0FGUVZ3cVor?=
 =?utf-8?Q?cqkubl7JSJqWj5HMwy6mUgrWr+MhxPj4bAzwqfUUqZC8?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840d68da-e4b2-4212-e1f1-08dbb5d23cd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 09:57:57.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib97xP6cb0oJE1mJxZYTX7NS/r0jSjO6UYNYa9VMUllzBZIbZj0vqBzsSjTSqT6P+T8VsOlo/85hGE6nkhQ7hmPVfUOBGiO0+KI53sZkAuJ1D8Omv9WxcGBhnXL0YpNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8095
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 10-09-2023 05:15 pm, Marc Zyngier wrote:
> On Mon, 04 Sep 2023 12:42:18 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>> As per FEAT_ECV, when HCR_EL2.{E2H, TGE} == {1, 1}, Enhanced Counter
>> Virtualization functionality is disabled and CNTPOFF_EL2 value is treated
>> as zero. On VHE host, E2H and TGE are set, hence it is required
>> to save Guest's CVAL to memory and increment it by CNTPOFF_EL2 at
>> guest exit to avoid false physical timer interrupts and also
>> restore back the CVAL with saved value before the guest entry.
>>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>   arch/arm64/kvm/arch_timer.c     | 60 ++++++++++++++++++++++++++++++---
>>   arch/arm64/kvm/hyp/vhe/switch.c | 13 +++++++
>>   include/kvm/arm_arch_timer.h    |  1 +
>>   3 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
>> index 98b0e8ac02ae..9fe3fa6ed98a 100644
>> --- a/arch/arm64/kvm/arch_timer.c
>> +++ b/arch/arm64/kvm/arch_timer.c
>> @@ -514,6 +514,59 @@ static void set_cntpoff(u64 cntpoff)
>>   		write_sysreg_s(cntpoff, SYS_CNTPOFF_EL2);
>>   }
>>   
>> +static void ptimer_cval_save(struct arch_timer_context *ctx, u64 offset)
>> +{
>> +	unsigned long flags;
>> +	u64 cval;
>> +
>> +	local_irq_save(flags);
>> +	cval = read_sysreg_el0(SYS_CNTP_CVAL);
>> +	timer_set_cval(ctx, cval);
>> +	cval += offset;
>> +	write_sysreg_el0(cval, SYS_CNTP_CVAL);
>> +	isb();
>> +	local_irq_restore(flags);
>> +}
>> +
>> +static void ptimer_cval_restore(struct arch_timer_context *ctx, u64 offset)
>> +{
>> +	unsigned long flags;
>> +	u64 cval;
>> +
>> +	local_irq_save(flags);
>> +	cval = timer_get_cval(ctx);
>> +	write_sysreg_el0(cval, SYS_CNTP_CVAL);
>> +	isb();
>> +	local_irq_restore(flags);
>> +}
>> +
>> +void kvm_ptimer_cval_save_restore(struct kvm_vcpu *vcpu, bool save)
>> +{
>> +	struct timer_map map;
>> +	struct arch_timer_cpu *timer;
>> +	struct arch_timer_context *ctxp;
>> +	u64 offset;
>> +
>> +	get_timer_map(vcpu, &map);
>> +	ctxp = map.direct_ptimer;
>> +
>> +	if (unlikely(ctxp == NULL))
>> +		return;
>> +
>> +	offset = timer_get_offset(ctxp);
>> +	if (!offset)
>> +		return;
>> +
>> +	timer = vcpu_timer(ctxp->vcpu);
>> +	if (!timer->enabled || !ctxp->loaded)
>> +		return;
>> +
>> +	if (save)
>> +		ptimer_cval_save(ctxp, offset);
>> +	else
>> +		ptimer_cval_restore(ctxp, offset);
>> +}
>> +
> 
> I really don't want to see any of this code in the arch_timer
> backend. There is nothing here that executes in the context of the
> world-switch until this, and I think this is the wrong level of
> abstraction.
> 
> You end-up doing things that make no sense in the expected execution
> context (timer not loaded?, not enabled?, disabling interrupts?), and
> this makes the whole thing pointlessly complex.
> 
> My take on this problem is still the same (vaguely amended compared to
> the previous version). If this doesn't work for you, please explain
> what is wrong with it. But it has the shape of what I really want to
> see.
> 
> Thanks,
> 
> 	M.
> 
>  From 2516a1410c0d45a7d3ba0523847be339bfcb1e50 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Tue, 22 Aug 2023 13:18:10 +0100
> Subject: [PATCH] KVM: arm64: timers: Correctly handle TGE flip with
>   CNTPOFF_EL2
> 
> Contrary to common belief, HCR_EL2.TGE has a direct and immediate
> effect on the way the EL0 physical counter is offset. Flipping
> TGE from 1 to 0 while at EL2 immediately changes the way the counter
> compared to the CVAL limit.
> 
> This means that we cannot directly save/restore the guest's view of
> CVAL, but that we instead must treat it as if CNTPOFF didn't exist.
> Only in the world switch, once we figure out that we do have CNTPOFF,
> can we must the offset back and forth depending on the polarity of
> TGE.
> 
> Fixes: 2b4825a86940 ("KVM: arm64: timers: Use CNTPOFF_EL2 to offset the physical timer")
> Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/arm64/kvm/arch_timer.c     | 13 +++-------
>   arch/arm64/kvm/hyp/vhe/switch.c | 45 +++++++++++++++++++++++++++++++++
>   include/kvm/arm_arch_timer.h    |  7 +++++
>   3 files changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 6dcdae4d38cb..a1e24228aaaa 100644
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
>   	if (!vcpu_has_nv(vcpu))
> @@ -180,7 +175,7 @@ u64 kvm_phys_timer_read(void)
>   	return timecounter->cc->read(timecounter->cc);
>   }
>   
> -static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
> +void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
>   {
>   	if (vcpu_has_nv(vcpu)) {
>   		if (is_hyp_ctxt(vcpu)) {
> @@ -548,8 +543,7 @@ static void timer_save_state(struct arch_timer_context *ctx)
>   		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
>   		cval = read_sysreg_el0(SYS_CNTP_CVAL);
>   
> -		if (!has_cntpoff())
> -			cval -= timer_get_offset(ctx);
> +		cval -= timer_get_offset(ctx);
>   
>   		timer_set_cval(ctx, cval);
>   
> @@ -636,8 +630,7 @@ static void timer_restore_state(struct arch_timer_context *ctx)
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
> index 6537f58b1a8c..5dcbde57f466 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -39,6 +39,26 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>   
>   	___activate_traps(vcpu);
>   
> +	if (has_cntpoff()) {
> +		struct timer_map map;
> +
> +		get_timer_map(vcpu, &map);
> +
> +		/*
> +		 * We're entrering the guest. Reload the correct
> +		 * values from memory now that TGE is clear.
> +		 */
> +		if (map.direct_ptimer == vcpu_ptimer(vcpu))
> +			val = __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0);
> +		if (map.direct_ptimer == vcpu_hptimer(vcpu))
> +			val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
> +
> +		if (map.direct_ptimer) {
> +			write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
> +			isb();
> +		}
> +	}
> +
>   	val = read_sysreg(cpacr_el1);
>   	val |= CPACR_ELx_TTA;
>   	val &= ~(CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN |
> @@ -77,6 +97,31 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>   
>   	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>   
> +	if (has_cntpoff()) {
> +		struct timer_map map;
> +		u64 val, offset;
> +
> +		get_timer_map(vcpu, &map);
> +
> +		/*
> +		 * We're exiting the guest. Save the latest CVAL value
> +		 * to memory and apply the offset now that TGE is set.
> +		 */
> +		val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
> +		if (map.direct_ptimer == vcpu_ptimer(vcpu))
> +			__vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
> +		if (map.direct_ptimer == vcpu_hptimer(vcpu))
> +			__vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2) = val;
> +
> +		offset = read_sysreg_s(SYS_CNTPOFF_EL2);
> +
> +		if (map.direct_ptimer && offset) {
> +			offset = read_sysreg_s(SYS_CNTPOFF_EL2);
> +			write_sysreg_s(val + offset, SYS_CNTP_CVAL_EL0);
> +			isb();
> +		}
> +	}
> +
>   	/*
>   	 * ARM errata 1165522 and 1530923 require the actual execution of the
>   	 * above before we can switch to the EL2/EL0 translation regime used by
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index bb3cb005873e..e748bc957d83 100644
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
> @@ -145,4 +147,9 @@ u64 timer_get_cval(struct arch_timer_context *ctxt);
>   void kvm_timer_cpu_up(void);
>   void kvm_timer_cpu_down(void);
>   
> +static inline bool has_cntpoff(void)
> +{
> +	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
> +}
> +
>   #endif

This patch did not work.
After adding changes as in below diff, it is started working.

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c 
b/arch/arm64/kvm/hyp/vhe/switch.c
index b0b07658f77d..91d2cfb03e26 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -117,7 +117,7 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
                         val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);

                 if (map.direct_ptimer) {
-                       write_sysreg_s(val, SYS_CNTP_CVAL_EL0);
+                       write_sysreg_el0(val, SYS_CNTP_CVAL);
                         isb();
                 }
         }
@@ -161,8 +161,6 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)

         ___deactivate_traps(vcpu);

-       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
-
         if (has_cntpoff()) {
                 struct timer_map map;
                 u64 val, offset;
@@ -173,7 +171,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
                  * We're exiting the guest. Save the latest CVAL value
                  * to memory and apply the offset now that TGE is set.
                  */
-               val = read_sysreg_s(SYS_CNTP_CVAL_EL0);
+               val = read_sysreg_el0(SYS_CNTP_CVAL);
                 if (map.direct_ptimer == vcpu_ptimer(vcpu))
                         __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = val;
                 if (map.direct_ptimer == vcpu_hptimer(vcpu))
@@ -182,12 +180,13 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
                 offset = read_sysreg_s(SYS_CNTPOFF_EL2);

                 if (map.direct_ptimer && offset) {
-                       offset = read_sysreg_s(SYS_CNTPOFF_EL2);
-                       write_sysreg_s(val + offset, SYS_CNTP_CVAL_EL0);
+                       write_sysreg_el0(val + offset, SYS_CNTP_CVAL);
                         isb();
                 }
         }

+       write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+
         /*
          * ARM errata 1165522 and 1530923 require the actual execution 
of the
          * above before we can switch to the EL2/EL0 translation regime 
used by
[root@eng06sys-r120 arm-platforms]#



Thanks,
Ganapat
