Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E787A9038
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjIUAol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:44:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2012.outbound.protection.outlook.com [40.92.21.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BEC2;
        Wed, 20 Sep 2023 17:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht1U54h6CI+VanUPzslGP9xAqcADrEbbwb//N56FEQnCCQch+5i+x67nIwtUVoaCxxhFY67OdW2f202agi+f8wTp3o0lmIZQG8x1s8NndpA65C4IUvisQURCoqby+DmBGv1LRt1wJzVYbhNkrPz1cF9Sp48IEuuhh2011wZttmoQCr33Lj0DppNMnC9cE0OoDAMAeyci5fuIOlt81A/tiPEEvkHi8sXPt2psit/ReQ2fu4+TJKkMqiFjCB1PPD7l9lkm/ep50UyOfmzRms3eFBn8snWb+y5xfUr0prt8XmAlib3wEQecSwR2s5G/rOhMuUHzeGJbtZ2CJ8OCW4GX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7eaY63vlMU9mvANAaLj0qwv7RcooAhlZpt0Glq9CsE=;
 b=DGTyzJNbCIGsJOnBbxcq7JhHNECf69DMWxe1Az6BtSFsqyapk8MwplI7iK2ITAQ77NV3PS4I8rdhNblhX2jLaknb9unWtGub62POwDq+SOZJHI0RDc6glvzghPo3Mxs5aRMagOZ8+/IcmsMAuYBeEqHkE4WfnLpvuCO7MVRtipVUSKvxfk8sWECUOg4UbQT/Qj0F/ZNAYUrnGulXOOe/uFQO7EYpoI+gxm2rWL6jVls0Wgl+FH3fV9ty70smTREDFSrjnqZu65lEQnLr9WXD0T2Y0+YxQRGCybRP/bfHNRLIsMGXR47Lgk/KDChznLtT2gkR9V+zNqL1FL/0SJCfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7eaY63vlMU9mvANAaLj0qwv7RcooAhlZpt0Glq9CsE=;
 b=OknTMT3VqPROf7G+2B3KVKkTBRRxDFnK20bX0wZCwxVHjAqiD1Gp/c+MQzqUL3RhmdTrCv3FiM+NT2hIZ0NGAXRT1DZqqZM0M1uK3cgX2uNLGqY+AqRvKs56i36b8hNE02/7/3aWIrJqzs+Fdiq42ppslkQAdEf/A2yinPt69kKpVIRQ1U7tz5uK1oLlXSoWEG8DiXlz8eeQGzdf+ef2Fx6bNAQpUh7vgH7B8RkqZe1W+pZpl4WnbdiSA9UUh8y3yRSk/BDjCu/778KW5IGIBIomYUR/0Ny+Rp2T7OWOMIK36zZAfPm3oilqwqOVwVleIuSmAMC1QxgRTq8ygtudtw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3775.namprd20.prod.outlook.com (2603:10b6:5:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 00:44:26 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 00:44:26 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Thu, 21 Sep 2023 08:43:47 +0800
Message-ID: <IA1PR20MB495358928C0DCF5854C99584BBF8A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920-53a04651c08acb0796dc63b4@fedora>
References: <20230920-53a04651c08acb0796dc63b4@fedora>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [G6N96ikoBgAoDG+JkNNT9Wqk7TkD63QhQv0J/jGiT9E=]
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230921004347.10143-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3775:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c3e1da-3859-4460-aa4c-08dbba3be7d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmPX6QrAMZD9CybT5lE8Dnee0zUPtwsofIfrgDPY6/xgozg08AY6fDK5DjeN5LXlFkEqbiKjhF+VBHHKd0iiI8/cRYyyXmFbQwX1pfOqLSxpLV4Gl2yoaT5PEz3RG2Lz3TKcTdSblvTs0wzesnfr4sFvM+3mwV4bt6OlZkasRP74KKxTxbzdwRIpqlMn/evtQmIz74IqbCbLvFApn+T55zSxO9GnlIg3cgR3jPo98Gzkxz11Mf/MF2m8FDEZJdHE/zMcoVvUI02ZeI20gJ37vE90MiDwr2TEfQ2zEePrROCXA3Ng/B8EsNfY/zY38zRW+aYcaO9RfrpXU1D2dedpC3yRfBQ1Zi3y2Zmhv5rJX1kiOLbG9m688zXZwHhMBJQKwTKZGxoVQo/EzWNUpc1e/M6eKPfHDF518Awgm/IWAZns2Lg+tSVXMYdXXkS7qESq1jsArMR86/0lSuza44KYtFZh8mjy/hyJDJJMkzI34YTt1c3Rmp5O8Eau9K9GSLCTxKJyxpw5xcBF/WlRhPpFCZeMaMkI2idu7JkBW/l+XEfNUslSH3HSIK+SJjjnxY2+NT5m+RQ+snEZn2w3u5RJ5AhH4BJ+VJR7mk7Sc/ftzCfpcdS8SOdUz7EUSFIy6Mk2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qmCV0NgkIoY5qlKHhdHLuEmumWfiUiI5FouPNGCfOmoZLgYniiqityZbcpV3?=
 =?us-ascii?Q?Ka0ZZQQcfLKTes5B1PzPSHXLZKTYeHYPFQvU/agzCIAO4WcjixxbiGg8Y+pf?=
 =?us-ascii?Q?9oQmXFKCZ4EkaSNWPqzmaPMMvPw1rrYNjM/AtU+ApgnaqY/yYN1zO4NCTaBj?=
 =?us-ascii?Q?A8kf5wqk70CxOYfV/tuBGKm04TNRFmsQOTEGRCqEuJXDTySUy+YU+cELs3Zq?=
 =?us-ascii?Q?pXaqFTc9qdOBLcmvw/6TgkZn1Rw/OwEfKGzXpHs/kM6MFC9ApdTbKX4Itxz3?=
 =?us-ascii?Q?YiDqbnmMfRFjEnkOV5FwpYvF/ojusW7U4fQGOmhpRiWyZx8xDtxXe9tTzLLV?=
 =?us-ascii?Q?KTphfV5a+17S4TZmKlAydFNJvtpd8KWkkXn2zaXqBQGfA11No1zlF/rG746+?=
 =?us-ascii?Q?1TFb+130IUoxqtdnkhLXc54hqX95AYrK7hR3aDpnrdZ7pbvSulVCAQ9q6Cg+?=
 =?us-ascii?Q?cvaW26HRtA8WA/tUlwFha3SvuurRZT0dBHJOVu+bwfFc8DdFhC5mm5YOMpZL?=
 =?us-ascii?Q?gpzBDMZgd0+G+ztlAU1DpHcX1Ekkt+XP36Dl9CT1ltQBuIr/J8HIZd5G/nrT?=
 =?us-ascii?Q?pY1hJ2scMHtAV1zCLJgRpmla/KchCtXcntjY1rfhA4buDExk4KxENs40cymV?=
 =?us-ascii?Q?jSZTdA85jD3uVBLXXU/jnudZ4ivVV2vCDohbJpDZ/PIls42SOeIO3vpEG7dx?=
 =?us-ascii?Q?P2sYJwkhbhNO05SxGM8w8PrbBzbcrqRKahtL5davUUNzk4RljUZ86S0g9fPO?=
 =?us-ascii?Q?TOcpM/jXwW/9OEFoMM4Nh2A8tsRO6ZnbeSgD7cnhwwiUQUGuJPi4ocOXsASC?=
 =?us-ascii?Q?z4a3nAt72oI2rQjGokVHZsQSg9M2p1w/07Zmvu4HQ/fM1MF3k+XUvfph8GyA?=
 =?us-ascii?Q?il29a5ZRuwY5qQA2eKs+XOM4YD9s+7wtDk5ai1cw+onmNC/ATB6Xuws4XYYr?=
 =?us-ascii?Q?8l+ojxm2irjrAwLHz7m2Ks0XLtubrzZmM/nj2uwqKXMx7JAP0jSjKDZN9/kQ?=
 =?us-ascii?Q?KLoZovH54Mf7kE+2MKLF0waq02QW4TbQVasSV+2UE34O++SgYxTnFiNfpxQK?=
 =?us-ascii?Q?h0vfK/laIhTInDmiq4ZYcJQO2rfIKm/Ojum1uJcqvJywNB8GK8ZPzDJKmQVm?=
 =?us-ascii?Q?2tRShwl/brr97yeCptjDkwceHGJfpusqczbzA5CsMYJzRhHplQEhDn352Ucr?=
 =?us-ascii?Q?wLvrPJDmFX+JRR+jsBPVGDN7oJwQvECNl4Iz1RxONTZjf/IleHVShslZA4w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3e1da-3859-4460-aa4c-08dbba3be7d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:44:26.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Sep 20, 2023 at 07:24:21PM +0800, Inochi Amaoto wrote:
>>>
>>> Yo,
>>>
>>> On Wed, Sep 20, 2023 at 05:08:41PM +0800, Inochi Amaoto wrote:
>>>>> On Wed, Sep 20, 2023 at 02:39:39PM +0800, Chen Wang wrote:
>>>>>> From: Inochi Amaoto <inochiama@outlook.com>
>>>>>>
>>>>>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>>>>>> the timer and ipi device separately, and do not allow c900-clint as the
>>>>>> fallback to avoid conflict.
>>>>>>
>>>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>>>> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
>>>>>
>>>>> Have you ignored Krzysztof's comments on this? I don't see a response or
>>>>> a reaction to his comments about the compatibles on the last version.
>>>>> Additionally, where is the user for these? I don't see any drivers that
>>>>> actually make use of these.
>>>>>
>>>>
>>>> Sorry for late reply and wrong message-id.
>>>>
>>>> The clint is parsed by sbi.
>>>
>>> That needs to go in the commit message.
>>
>> Yes, it will.
>
>Thanks.
>
>>>> As use the same compatible, the opensbi will
>>>> parse the device twice. This will cause a fault.
>>>
>>> Then only have one compatible with 2 register ranges? Then your SBI
>>> implementation can use those two register ranges to find out the base
>>> address for the mtimer bits and for the mswi bits.
>>> I don't understand why this cannot be done, could you please explain.
>>
>> That is a good idea, but now SBI use the second register ranges as
>> mtimecmp address for aclint. And there is a aclint-mswi in the SBI.
>> Maybe a change is needed?
>
>Yeah, I don't think the model for this in OpenSBI at the moment (and
>since I checked, in QEMU too) is correct. I think we should re-do things
>correctly and it'd be great if things didn't get merged to those
>projects that end up being objected to by dt-binding people.
>I've started keeping a closer eye on QEMU recently in that regard, but I
>am not super attentive. I'll try to be better at that going forward!
>
>>
>>> I also don't see anything in the opensbi repo right now that is using
>>> these (nor could I easily see any patches for opensbi adding this).
>>> Is there another SBI implementation that you are using that I can take
>>> a look at to try and understand this better?
>>>
>>
>> This will be sumbit in a short time.
>> Now we only use it is sophgo vendor SBI, which url is [1].
>>
>> [1] https://github.com/sophgo/opensbi
>
>Thanks.
>
>>>>> Why do you need to have 2 compatibles (and therefore 2 devices) for the
>>>>> clint? I thought the clint was a single device, of which the mtimer and
>>>>> mswi bits were just "features"? Having split register ranges isn't a
>>>>> reason to have two compatibles, so I must be missing something here...
>>>
>>>> Sorry for late reply, The clint consists of mtimer and ipi devices, which
>>>> is defined in [1].
>>>
>>> Yes, I have looked at the spec. I went to check it again before replying
>>> here in case there was something immediately obvious that I was missing.
>>>
>>
>> I think nothing missed.
>>
>>>> This standard shows clint(or the aclint) has two device,
>>>
>>> The wording used here doesn't really matter. It's one interrupt
>>> controller that does mtimer and mswi.
>>>
>>>> but not one. In another word, there is no need to defined mtimer and ipi
>>>> device on the same base address.
>>>
>>> There's also no need to have two compatibles for the same interrupt
>>> controller, so I do not get this reasoning. What actually _requires_
>>> them to be split?
>>>
>>
>> Yes, it is one, but can be mapped into different address. So I think we
>> need two.
>
>Not two compatibles though, just two memory addresses that you need to
>locate (or maybe even 3, for SSWI?)
>

We may need four (mtime, mtimecmp, mswi, sswi) if use register range.

Anyway, I will use a vendor spec implementation as a temporary solution.
I hope this will be corrected in a predictable future, and we can use a
standard way to resolve this at that time. :)

>>
>>>> So we need two compatibles to allow sbi to identify them correctly.
>>>
>>> Why is it not sufficient to identify the individual memory regions?
>>>
>>
>> FYI, Anup. As I have no idea for aclint implementation.
>>
>>> Thanks,
>>> Conor.
>>>
>
