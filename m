Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8137A8F38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjITWV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:21:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2018.outbound.protection.outlook.com [40.92.19.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18CD6;
        Wed, 20 Sep 2023 15:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrPDdy/t3ShL8zXp17zZr33jFBcann9HMD841F/fxxpr/AvfiL01WFZZyZfOFVB6ae6oRAV9tWdUjUCvXqe1RuVGn3nxY+tagi3ORBkeIW5yeQLmu6wLQqmQFgzlRwPAj0odRmm5u9Si10zwNbniTa5N57IxRdKC+nyi0CecWspaDNoAqmSHowujreWaor5Dl6CW3ybuReqGN0r1YEACq4XCbUiiAvAQcEO/1wKUdB4uqGrcMhGuCD2vmPWjfmSifLseb9X/kQHu43oNXkebVLJF8JGZ9VlVt1h184KmDpvcvABtOBUwsiOsBbnLriT3KIjWmaEXBsVNtj3kgSJgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/SjzU1WZGGPI//CTri6AQ6g5/d2Xomw+KVu629KzzM=;
 b=Y3DKGleBiNcap8qbC4/xC/M5tpHVUfH/sHUBM3VtNC1joWpTZhwvXQt0WLNCMO91u9FzQAfyGx6KsAcNPaOp+PySeJWn4vwp8+f5E1GRIJ/ozUAcqPaM2ZFX3nGOhS4Sl5Q0QV0a+becoypBTfkvS8P2Bu1CNTJbQ+6kZa2x+ocLx1/fkM4AnBoHwABzEYKmmC3/kSSnIuKU9QKsuik3YPig+3rn9hjK9XyPs1MRHWVNTvmZdPFvc7+9oCGk1INMzfb+gYKRBv5Ka1w3F9Ukm6mtUD7+Y+fUfPTLBXSfxo3TVlALeVDlHChVbg0lfFd7E8J2kXLpmWxKFaELBSjYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/SjzU1WZGGPI//CTri6AQ6g5/d2Xomw+KVu629KzzM=;
 b=RFpyFERDCvhXg8hgQFsyK4M8HMGlZtIT+yoGCUrDkOjCmYjFJkIflnHjCoXpbQ/tDpIIxFAgbYn7sYDHVkd3I90rZNhQO6AU+sYq0g+68oAh2x/UDbTHLuMajr2XPZOVF9I7lKKcF9Y29I2ECiBUb3uGppJ9dhwc0kfoHR/VK48mBMinw8pz4NjDp4jTNU2HQNYUc0UdXfZsdp56WMFUPemYSjZdI0rrQyUB01Q8+7LixYod0d+Jk9xH1ZhJ/WCPAAfUT6xK4XWbPi+tUgK8Cvb6AgLMlB3iGfMJOIhrwDcTIjgNXiKyRcvdzIOyyf+f28p5XAEr/RzxrimwlNxblw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4428.namprd20.prod.outlook.com (2603:10b6:303:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 20 Sep
 2023 22:21:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 22:21:46 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Thu, 21 Sep 2023 06:20:58 +0800
Message-ID: <IA1PR20MB49531B3B43CCD5F1644E3B81BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920-992a56b66366f3c0591a6a94@fedora>
References: <20230920-992a56b66366f3c0591a6a94@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [+hQ5Ru9z/hKr435Dz2T8P58CyWWIzz5QtLbEye2GuKc=]
X-ClientProxiedBy: BY5PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230920222059.6068-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 79369663-36e4-4cb5-6f9d-08dbba27f955
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Cm+br/KMu+TMzivty4G2CAwE6hBMYqTC92Yi+Ddm0eU1UwOCkjIh5/ymPQ4/CGywZfxrgQGZjkjD5yEiuVh2PlteN5t8LQJ6MGec0zzekJrIzXKctBb9GPjZHNtgCXeXa+0mfubb/FMJ+RrUA+LGs7kjX8jPqsxL5OciY/E+T68Qdx7WUl8Up8IYRUucEb7M7r0ugyrutrIHDxp9bddkhOhh4OF0srUTKrc4HyUka2dHVcJMAbyZb22D/7putHIS52/qW0bGQU2Hzd7LRt7LyZXIkvm8qzjKlBm37s8o/zWQAhcwA5c6WHwkcqhlpYqovsvcCGIBJnY4m+cLmsCaHyfkMplqSaLR0ILp6kCDAesjMr0Wv3E7F3G2NTSopJaFe7UO4VbuaHM/fXXCOTpPLXhKZFSecBe4A6aucZbsIijp0PMrj2xGJfp36kNLs09UG3AQgPdsVvHgdWD98EhAic1Pv4aZ8IroVW1co6AnXnnTkhjR9Ejh5TfIk2Vpato5MxEJTTu2XJ4pE2zWrQorFAIeVW0OQlUrXOAnj74pOWInB8sD/6KZKzjz15fBcaEdCAVrOv9/BfkiwyTBM0og1vlHc3w7iuzePRl5WcyZqRQv/974fFERokcqf1qVnfwzPnaLcZzOR/b8kBR7AcRSehFxHg1RiO+pkye2UbDGIg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU00L1dqNHNEOTRZTEY2ZjRkVXAxRzRKcERVMDFxU3N0ekxwZFJzR2JaV2Zx?=
 =?utf-8?B?T3l0dUxVb01LVjQ1bzNnd0cwd0h5YmUydnUvZGgvcWVhd2RFcHRHcXdFcGV6?=
 =?utf-8?B?ZVZRZldEWTcyOW45Z1FzNjVRcHpNMWMvOVgxNElYdjJPL2RrR3lmZ1BrK1Ra?=
 =?utf-8?B?ekxILzlGK0RmTzQ3Y0tJK1VDalRjdmdFeldyUi9YUW5ETXNWWExiU0xEQmxV?=
 =?utf-8?B?TkxKdWtPaXN2WWZ4Zms1TDNHa3ZHTzNhZHB3TmppRkIvbWt0eTlHdVltT0Na?=
 =?utf-8?B?dG9YRGx3ajdoVENrblVWcFpzajZRQW56OFJnT3FiVlQ5MzJkZ1AvcmFXeG5j?=
 =?utf-8?B?Vm96WXZHbnR0NGRmYTRiZTJ1TGJTUFVRZElsWEJ6cEFZY3E1dXVjUFJGMFZx?=
 =?utf-8?B?U2pDM1pSL0Y1OGpIKzBqL3MvZXk1cnhzb1pqd0Zzbk9GaTNKc3VycVZwU2dW?=
 =?utf-8?B?SU5MNk9HT011NFArRGtJRzllb0JOQWtCQkhQTERJSlhmZHQ2NzFzZVhVTnls?=
 =?utf-8?B?NWlDMHVhdkJXWUNBVjhJbElDWnZVNGxadm1zU05iZ2s5dG5nY1BoNjFnVUZ2?=
 =?utf-8?B?V0gydytGM2c3cTVZT3BFQVZSaVpUc09seGJCZ2ZPTHc2TUhnM0tCVWtuTDJB?=
 =?utf-8?B?MG8zV1A4QVhNa2w3MHNqeEJoSVRRSWVjN1V6YndiYm84SWlRZzZjT3lWRXZW?=
 =?utf-8?B?K0lvaDhkY3JlaUtCNVduTmR0dWJvQVdZNjJxZTRwWE42YXY0Q1JRMk5iVmNW?=
 =?utf-8?B?bExEV3Z5ZEVnekFoMUhHQlJEcE5jOVlya3h5WGtjVGdjT0wyVmlFWVhZVGNK?=
 =?utf-8?B?NXNwU2dMZS9sNEJEdldpNC9ydXJobVNEWEtVSWxmQ28zY0h1emdsYWFoc01C?=
 =?utf-8?B?VUNzSXpMcWJHem54RVFQcjgvVHNHTXJrWnFpdDhycWtmNU1WUUptRkJoSDRN?=
 =?utf-8?B?cnFENU93OVE5UjNlc2ExK0FqR3U3TDZsUkhFbS91c0VCNFZVZ09ta0F2OU0w?=
 =?utf-8?B?bkg5M01tUlBvcTVkTWk1dGxDRGNwaVU2OEdXcFU4bm1IVUZ6akJRU0I2aGFX?=
 =?utf-8?B?Q3BMcEZzbW44ZjBQUnBUVEFrbXFCMGNVSER0T2NGbnF0dzUrMjV2UC9wZHd0?=
 =?utf-8?B?SXVRZmpuVlVaWnRZSjVwTXhacS9naElzdk5JbEVIbTRLK1piK2tOYnF1R2ZG?=
 =?utf-8?B?YjR6SVpmeXlNb1lGSE5FUm9SbHBySUhNcng4SW1WRXdROEJ6OWxTN2d2WXpt?=
 =?utf-8?B?aVpyYVRYSUoxdXRha0t5RThoNFN1VWVhdVR0RmEvSFB3V0hvRFB4YVNDMFBW?=
 =?utf-8?B?Nms3SnhHL0d5U0FkT0FJVVM0MEd5eGVjWTVWdG9jMHRZNHBwRFlBcEd4Qjky?=
 =?utf-8?B?Nk1kY3VBQlU4aWVUaURQcG1jMjlGTUdXSlhnU05zMHhUQk82VEVSTGF1R0hU?=
 =?utf-8?B?YjNZemM4blMwVEZ5OUNEUGFxVEJ4QVFJMzh2Q2FpMk41ZVVrajM2T2xQOHRv?=
 =?utf-8?B?Z2tQdEhuRTcyMUdrS2R1OHIwY0F0NGlBWXdWblZHVXBlZkJKMjFEaENYSXcr?=
 =?utf-8?B?QTlIYVdtVEZlNXdLQ0VnSFJIZS8xNjJJUmdha0JFZ1Y4Mk1WT1V0VGV1NEcw?=
 =?utf-8?Q?Mxds4zZ21mp0XEE2fEG/eCQtLscQOe3hSwwlBEFQKva4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79369663-36e4-4cb5-6f9d-08dbba27f955
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 22:21:46.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Sep 20, 2023 at 08:08:49PM +0530, Anup Patel wrote:
>> On Wed, Sep 20, 2023 at 6:28 PM Conor Dooley <conor@kernel.org> wrote:
>>>
>>> On Wed, Sep 20, 2023 at 08:40:07PM +0800, Inochi Amaoto wrote:
>>>>> On 20/09/2023 14:15, Inochi Amaoto wrote:
>>>>>>> On 20/09/2023 08:39, Chen Wang wrote:
>>>>>>>> From: Inochi Amaoto <inochiama@outlook.com>
>>>>>>>>
>>>>>>>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>>>>>>>> the timer and ipi device separately, and do not allow c900-clint as the
>>>>>>>
>>>>>>> Why?
>>>>>>>
>>>>>>
>>>>>> If use the same compatible, SBI will process this twice in both ipi and
>>>>>> timer, use different compatible will allow SBI to treat these as different.
>>>>>> AFAIK, the aclint in SBI use the same concepts, which make hard to use the
>>>>>> second register range. I have explained in another response.
>>>>>
>>>>> What is a SBI? Linux driver? If so, why some intermediate Linux driver
>>>>> choice should affect bindings?
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> SBI (Supervisor Binary Interface) is defined by riscv, which is an interface
>>>> between the Supervisor Execution Environment (SEE) and the supervisor. The
>>>> detailed documentation can be found in [1].
>>>>
>>>> The implement of SBI needs fdt info of the platform, which is provided by
>>>> kernel. So we need a dt-bindings for these devices, and these will be
>>>> processed by SBI.
>>>>
>>>> [1] https://github.com/riscv-non-isa/riscv-sbi-doc
>>>
>>> Yeah, this is the unfortunate problem of half-baked bindings (IMO)
>>> ending up in OpenSBI (which likely means they also ended up in QEMU).
>>> This T-Head stuff is coming across our (metaphorical) desks, so we are
>>> obviously going to try to do things correctly. I may end up speaking to
>>> Anup later today, if I do I will point him at this thread (if he hasn't
>>> seen it already).
>>
>> RISC-V ACLINT is one of those unfortunate non-ISA specs (like
>> SiFive PLIC) which is implemented by various organizations but
>> not officially ratified by RVI.
>
>Yeah, I brought this stuff up at the weekly pw sync call, and Paul
>pointed that out.
>
>> The SiFive CLINT has flexibility related limitations which makes it
>> not useful for multi-socket and mult-die systems. The SiFive CLINT
>> is also not useful for systems with AIA because with AIA M-mode has
>> a new way of doing M-mode IPIs. Due to this reasons, the RISC-V
>> ACLINT spec breaks down traditional SiFive CLINT into two separate
>> devices namely mtimer and mswi. This allows platforms to implement
>> only the required set of devices. The mtimer as defined by the ACLINT
>> specifications also allows platforms to place mtime and mtimecmp
>> registers at different locations.
>>
>> Refer, https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>>
>> We need a separate DT bindings document for ACLINT MTIMER
>> and ACLINT MSWI because these are separate devices. The
>> Sophgo sg2042 SoC should add their implementation specific
>> compatible strings in this document.
>
>If the spec isn't frozen, I'm not accepting a binding for the "generic"
>version of it. Bindings for this specific implemtnation are okay.
>For sure though, squeezing this into the sifive,plic binding isn't
>appropriate.
>

A specific implemtnation sounds like a good idea, as the clint layout
of sg2042 is wired and hard to merge (ipi is continous but the timer is
per cluster).

For a specific implemtnation, I wonder if it is better to use two files to
identify these device each, instead of one for all?

>What was pointed out, I think by Samuel, that the reason that this may
>need to be split is the fact that there are many possible MTIMER
>register ranges & possibly sswi stuff too that would need to be
>differentiated.
>
>>
>> Regards,
>> Anup
>

