Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA17FEEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbjK3MXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbjK3MXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:23:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2077.outbound.protection.outlook.com [40.92.19.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72510E3;
        Thu, 30 Nov 2023 04:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLS5LThpD/4Dx267jd76BLT9UpfVKIbtHrmB3WIKgrlp5VEqge/VmCtQA6UhTAF6EGNxaj2RIAjmqbfRhn7s7cCMveDJ/NSESAptx1sx4f5iMr6mrvUe3VCfYXs6Zjx80ellDw54b+mQ+uCGIGOt1XbwEN1viJXFbtG5dDmplT+stU82VdrJWOC/8escm3bZOipulcHhA+yhNr5VjfDPpOI2KX0kWgYsm+czuep0WTRW4yQVxRYZLAXdTw2tSMslXII6kMKOPFITuUcz/BBx+fAvWJb1TBaNuzNvheXRrfKABg0A53pTqk5V142bkPnyh0BjvgD5xVhj6Zj9b9hGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTueDx6x3QAXcukJ6Z6H1X34mDdEtjpNgKxru8qmG9Y=;
 b=feY07/BKrgt4z2ZxhAF+m4j3bX9ktjv9Tk2HuD60pSyEVnngvYBLh0W/9VxckQc1UV+LnjLHWXY4ZhuqD2rBcSla8dg6r+t2rcUokmuyV9920Jr43IVDBZwQ38Ap7yCE6Y27d8ycHU4S+01qIq9kjT1u11ptU0OvJ86IM/9+t4UyOHIbRNFGGRFLV00zboezbEYPPeuWs/k+xVMs7nX/9Zfw+cp2vPAi30rdMnLH+8IguD6PlY9TH4tOOGkV/d/ajtiwYNqKbxDHTOaQQLPABXpjKQD8fShfjZIjnrdB+f5VXP4XExcnbpAPZHQ3VaQNKvyst6cFZsKnn1tTqKpvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTueDx6x3QAXcukJ6Z6H1X34mDdEtjpNgKxru8qmG9Y=;
 b=bKHqmD3y0OKCHsL7TxWncqCOWC/E9Xjq+nAJkhA0BWIbBhReDmy9i7ABAH1kSBTdrdQ0Fp5ISh5vtm0UtEEfBwPf14b6HUKpzlzVHe5j87MVLToWOM+sL6jAppmeDfevqO/FxbWyswxyIO/umcUI1RqcAzP2dNwZ1ESGSwkHxhQOla2U5knrcOhNNd6G4hUMtmWCtPNI7kxlJMUgRlkRCFqGVoHBOSmJLHEXYOlg/gnJr2SEcrxA4Kc4og8ISMhZFx7JqHUT2Qi0ksootiZLaiip5FgXP5wr/sTkQsiwXd7qQRMGwtehLq3Ak59MicW6jgvdbf9jhbsxTr+wG1w73w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6196.namprd20.prod.outlook.com (2603:10b6:806:33e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 12:23:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 12:23:32 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Thu, 30 Nov 2023 20:23:25 +0800
Message-ID: <IA1PR20MB49535AD6FEEDD9FB76AFF5A0BB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130-shower-award-3cd5f1bba5db@spud>
References: <20231130-shower-award-3cd5f1bba5db@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [GBe5sAesTPhQ1/MDBHk1OebHxvF/D2bNgMiSlRc1Uwo=]
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130122326.374105-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a57a56e-795f-456b-283e-08dbf19f2aca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyb3D8mAOhSTsmnD/Zkz5ELHzqa+9kFQYnLNybA/xJbEcDCTgHQYsnG0BtiX3360oEHMEkdXTTNzVE6UOmk6Mp8Ipdai00yKBY+b0ldsQUZb92NzU5ljiUf5ZNCJ+wFw7fGGLtjENjB2BFgmlPViXhELZMMIyRHZWVlxVjVb+CY5LN7ZdT3hYv2rconLLEq8o8lLzUdMWdkPaCfMuBeCGACiuH9qETNEOFRXXf5Cy9XrdVn02m2sG5fXJoNjOcBLHRICcqO1+sVjt62WdvoC8GNGkYHoXZAGPmjJUdtDH8iX5+J13zrbhcJU4tCs2OyXTjjUcvCqPBN1lYq+Hkov5P2gBmZtsGH1VzWBQFdBA0xbZqSQGKVzsQgYf6peKi2L75iJhK0vREE3+VH9IwcTB9tGCjaAZPDZByOYo94gTVt2atF57SrNZPKCu8BOCMnBJLFAR2VCDnJoJ/w/kCpw5xVLZB+WEDi/VoLncC7iKrEFfCGiklhOEcoLKSihdz30+q1Mean7IrvQFCwROYVNr215V37PEbBkWDQ17Z/aIuYAyrkRipm9PuDTfi4rMKF2VB7epgjtSLgJieUFh0XsZpzieDFKvo8EOfILLJLxRDmroX70BKm2QpOB1hPDwIPyWAkATEcbkYBI2pQTLIaKxxr6gsylp1gK4zhFXXZGtpk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05yNWdOTk93NzZxK1hHaCtoZGpEVlJLNUxxcWJGTjUyWmZkV2dsRDc5bUVP?=
 =?utf-8?B?cUZSVHNHa0F5ay9UUDNBVmtpOWtXeXBvWlNjVmM2aXd0cmpESS9ZWHQ4amNr?=
 =?utf-8?B?Rko4WXpSSi9yRnQrWjZML3hIWXIvcWR2d000OVZHQ2JHS3ZUb2kzRjRZTnd6?=
 =?utf-8?B?Nkkvalo1Q3lub3BNMnhZSFhyZytnL21CTmZQNENTdmoyZjN3SCsySGlMS1JU?=
 =?utf-8?B?OXRZazg5VytlaUt0ZUdLdm1OZXREVGpqaDczYWdtQ05QWGV5UTZFQTVoclFW?=
 =?utf-8?B?MmNwaHdCdC94NnBqdER4YmpkNnFZR3JBSFhnakVaSmxuYlVQdHJXL3kzTkxP?=
 =?utf-8?B?SW5FdnpzbEpNN0NucktkbkUyNmhuTjRFSllOOUVaaUp1aloxN0psNW9GdmEy?=
 =?utf-8?B?WVJlRzNLWE8weGRYSUhyZ1NmYWlKRG42b1daUUdXM1hhb0JadXJWQ1ZMVmtO?=
 =?utf-8?B?OWU2N2Q4d2QrV21rb3lMZXkrZlk5amN2QVVIM0V1RXNqejYycFJia0dqSkRD?=
 =?utf-8?B?YlZIaHhSS0JFZzVSRDFIcWhKOVkzeXBFc09oak1YYm45TU1EcThQNWFkb0Qx?=
 =?utf-8?B?NDhtWjRkVEZoMVRWbUdPMEJpR2VobEszcFNuM3EvQVVWckFjR0d5MkFmVzRj?=
 =?utf-8?B?Um9ERlZYRzRXakd1QTVNVGVTaTlhNVNOYXlYVUlQZzdabUZUTU1mKy91b0VX?=
 =?utf-8?B?Vjl5Y2hqYWxJa2ZZaW5SdlVBUWtraGxBR3hOVHB0V0FVU0dJNEpiWC85UFJN?=
 =?utf-8?B?MjN3UWkrbytpeFE3QUM3VFFGeUdZd0lUdHM2WXJYYmgxMy9zcFdObkhwdTVJ?=
 =?utf-8?B?cmdsYVhqMkE4YWkzT1QwL3VaR0NHUnY0Q2xtWWV5ZlJWQlhVVGRPWThQU3lR?=
 =?utf-8?B?R3gwYWtsUFZpVUdyNVVTRGw1UTljOEt6YWNranA2MDVFYU5HR1d2dC9xSENJ?=
 =?utf-8?B?MkpKQ0IveUpoTHJCK2tSWXFGRS9NZXZXY21UTnJHNU9Kc3VIOTlnV2hISFlj?=
 =?utf-8?B?WU1tV1hEK2RQcXh4NTA1SXFHd3I0ZGRTc0krUlFWK1Z4RmhiSmZpWUZqRVIy?=
 =?utf-8?B?TU9xQkdqSDcyaE1aTE1lVmFnZStkUWlScG9vc3NUSGtyenJYZ1N0K0JmNk1s?=
 =?utf-8?B?dDNDY3hxVHhGdURoeEpzbjNVNG1XRTI0VEQ0M3BKN2l3UnJnL0NnOVQ5Tkhn?=
 =?utf-8?B?K1Y5bTZocUc1OHZVT2c0KzA0amd5RU9DNUlDWmpvUGdsd2NQL0RqTHRDTFRQ?=
 =?utf-8?B?T2FaN0pBK0I1MW5CcWVqakZJVzVWM1EvOGt5TjFJdHF0RWxCTHpINk9aSTBn?=
 =?utf-8?B?NTNPam5HbnVjeDBDRW85dHJybmNHUitVR1hDM0dkK3BTa1hiMjJtc1RCYll6?=
 =?utf-8?B?Z0V3MkIrTTZacHVZcFdWRzZOQWx2dFcvbHNicTVzbnN2SDhFS2dpa3h4NGRy?=
 =?utf-8?B?R0FPTVdZem5iVURZVWp3eUxiNUZtVC9rSmRGUEp6TFJBMzVISXNoNElFajlp?=
 =?utf-8?B?V2hnNFhxeUNLYnpnR0cwWGhkU0tWUTBGTURnZ2xKOWFkYjIvcERxL0FHN21D?=
 =?utf-8?B?ejluSnd0MGJGRlNFNU8vbWZKU3NRVWk4Rm5wR0FCKzlQSkk5d09HZFBvWWtr?=
 =?utf-8?Q?6Pda/5iHCxCxt1VKNxMvNcrEG3ir9WzsGGougdjfVfKs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a57a56e-795f-456b-283e-08dbf19f2aca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 12:23:32.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Nov 30, 2023 at 04:51:32PM +0530, Anup Patel wrote:
>> On Thu, Nov 30, 2023 at 3:27 PM Conor Dooley <conor@kernel.org> wrote:
>>>
>>> On Thu, Nov 30, 2023 at 03:01:24PM +0530, Anup Patel wrote:
>>>> On Sat, Nov 18, 2023 at 12:39 PM Inochi Amaoto <inochiama@outlook.com> wrote:
>>>>>
>>>>> The timer registers of aclint don't follow the clint layout and can
>>>>> be mapped on any different offset. As sg2042 uses separated timer
>>>>> and mswi for its clint, it should follow the aclint spec and have
>>>>> separated registers.
>>>>>
>>>>> The previous patch introduced a new type of T-HEAD aclint timer which
>>>>> has clint timer layout. Although it has the clint timer layout, it
>>>>> should follow the aclint spec and uses the separated mtime and mtimecmp
>>>>> regs. So a ABI change is needed to make the timer fit the aclint spec.
>>>>>
>>>>> To make T-HEAD aclint timer more closer to the aclint spec, use
>>>>> regs-names to represent the mtimecmp register, which can avoid hack
>>>>> for unsupport mtime register of T-HEAD aclint timer.
>>>>>
>>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>>> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
>>>>> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
>>>>> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>>>>
>>>> The ratified Priv v1.12 specification defines platform specific M-mode timer
>>>> registers without defining any layout of mtime and mtimecmp registers.
>>>> (Refer, "3.2.1 Machine Timer Registers (mtime and mtimecmp)")
>>>>
>>>> The "thead,c900-aclint-mtimer" can be thought of as is one possible
>>>> implementation of "riscv,mtimer" defined by the Priv v1.12 specificaiton.
>>>>
>>>> If it is not too late then I suggest making this binding into generic
>>>> "riscv,mtimer" binding.
>>>
>>> We could definitely reorganise things, it's not too late for that as
>>> implementation specific compatibles would be needed regardless, so
>>> software that would've matched on those will continue to do so.
>>>
>>> That said, does this platform actually implement the 1.12 priv spec if
>>> there is no mtime register? The section you reference says:
>>> "Platforms provide a real-time counter, exposed as a memory-mapped
>>> machine-mode read-write register, mtime." It seems to me like this
>>> hardware is not suitable for a generic "riscv,mtimer" fallback.
>>
>> Yes, the T-Head mtimer does not implement both mtime and mtimecmp
>> so technically it only implements a portion of the ratified RISC-V mtimer
>> chapter.
>>
>>>
>>> Am I missing something there Anup?
>>>
>>> It doesn't even implement the draft aclint spec, given that that says:
>>> "The MTIMER device provides machine-level timer functionality for a set
>>> of HARTs on a RISC-V platform. It has a single fixed-frequency monotonic
>>> time counter (MTIME) register and a time compare register (MTIMECMP) for
>>> each HART connected to the MTIMER device."
>>>
>>> But I already said no to having a generic, "riscv" prefixed, compatible
>>> for that, given it is in draft form.
>>
>> I am not suggesting T-Head timer implements aclint spec. Also,
>> since aclint spec is in draft state it is out of the question.
>
>I did not intend to imply that you were suggesting that there should be
>one. I was just trying to clarify that I was not trying to bring back
>the topic of a generic aclint binding applying here.
>
>> My suggestion is to treat "3.2.1 Machine Timer Registers (mtime
>> and mtimecmp)" as RISC-V mtimer defined by the RISC-V privileged
>> specification and define "riscv" prefixed DT binding for this.
>
>I'm not against a binding for that at all.
>
>> This binding defines two possible values for "reg" property:
>> 1) contains two items: a) mtime register address and,
>>      b) base address of mtimecmp registers
>> 2) contain one item: a) base address of mtimecmp registers
>>
>> The t-head mtimer seems to implement #2 whereas the RISC-V
>> mtimer (Priv spec) aligns with #1.
>>
>> If we want to keep this DT binding t-head specific then
>> we should remove option #1 (above) from this DT binding
>
>This part is already the conclusion of one of the other "branches" of
>this thread and is (AFAIU) Inochi's plan for the next version.
>

Yes, I have already made a new version for this.
But in fact, that is just the V3 version of this patch. This is why now I
still wait for some advice.

The V3 version is just T-HEAD specific:
https://lore.kernel.org/all/IA1PR20MB4953B8AC5CB8F8165A09D118BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com/

>> and add separate "riscv" prefixed DT binding for RISC-V mtimer.
>
>Do you know of any users for a "riscv,mtimer" binding that are not
>covered by existing bindings for the clint?
>
>Cheers,
>Conor.
>
>
