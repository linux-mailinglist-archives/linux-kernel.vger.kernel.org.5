Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3987AA834
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjIVFRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjIVFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:17:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2075.outbound.protection.outlook.com [40.92.40.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7918F;
        Thu, 21 Sep 2023 22:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUB5slVhuME6g9EaHTBkDBiJSyg7a29FC4N3kgK2STFqDNbGUaa7o3rDAJKLiK1wfiAB/uvyPDldgg1JbZuvUjW+iH+QUQhokVrSRrUx8EJ2f6W86uv3MCja7I5IWXlnSyUTpDm27/kSlVKY5GSj/skOP8Bg1H56qMmhq2VmmQT3gBUGdMLOtP9cNv6+Cg/0vOv+0Q/1vaLQYbV5ITJ4hkl9vj5VR4ESAs5wcfckjRxIeaNxXcAlNSwDAHUVH/dgUJ48+Kdqn/4Yr9Iu/c0/iRSGI/OH46wDHtDCXbW2YQnzm5IGIsQpAnfyqf7Fi09DMCgpQz+TS9hHpKk5BgC/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD4BLs26vobSSri7AQGCY2GUyFMyL8gjki2dHbJ/pKw=;
 b=kpdQsoSwh6MgLMCyjI7NvpdNokWLVD6weadmIOaQ2eXJMek0LpH1X7/IbLA3lCWgvzx4X9NUQEag0c+d1klARnBxQxFB/uyqGMwQJbCmrenBVoncqf6mOR6U5h+UYqndsKMNTA3dTZ7BtOzQZZ5WmbnQ4itXymStGTmeby6pJp0soqshUvTsrLNWdXmsTieCsDYYQegPkANXWqH6A73mgasGr+K/RYD8PWeaxFMdN5KcdEJmMlm4ApekBxGuV6N5Oed29QvCeJwQOjH5vxdCtmZEdFhDgdwAZp64x5jJjFknn7U+giWxePW++mDH7+ZpXfys9NtpQw/lsajGQTz61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD4BLs26vobSSri7AQGCY2GUyFMyL8gjki2dHbJ/pKw=;
 b=eXJSFv5r0IzjiVEKFIV6BefhAxPGvUtdLg961yefPuYxWwchXzL2hd4OTDkdSYGl6Brwh6g9VxPnTEG5tensDVw+q5XbrioIHH8Zupv0+YplwLW+RU/d52NBN0wzDYj/NuzVoCpyJHccf16jJNimY4IZZ5sybYx5WSX7QHBQJTkXPWl17otB/zOxJxnC5PAOPWHK8zxNeVCk/Ims2qMZghQeH8JhdiTuH/YuUifA7KuivuHfPqmt7X9yGyLOo752YBLFmLtnVPOxrh8W+KonB/340mjBBBJrsmBO/4zxKPO40vMYU6b/Szmxhh5/CEXVE/WVpo7Yh6NuIqOwdpg4Ew==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5664.namprd20.prod.outlook.com (2603:10b6:8:13b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 22 Sep
 2023 05:17:01 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 05:17:01 +0000
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
Date:   Fri, 22 Sep 2023 13:16:35 +0800
Message-ID: <IA1PR20MB4953D983915AD8E35FD3E51FBBFFA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920-992a56b66366f3c0591a6a94@fedora>
References: <20230920-992a56b66366f3c0591a6a94@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [2pN40UUBm1/G+N940wNCYJE6oncjwZUc3/+mEEEgvzk=]
X-ClientProxiedBy: TYCPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:405:2::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230922051636.30743-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 01267ccb-7f6d-410b-8045-08dbbb2b248a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yujMIR3hYweCWQLNscOY1aU6zILYRML1ZHBV3cF1ZxKXkVn/iOYf0PaT90uHB7qsOWvXXwWa9YHTU62rH3o7ocZab0knJRm4VDijy8TNwNuuWyK9vx8/26z4JxXScgBSGLpbIwrX+hHx2PLQRJYRG9JVrX4ne/fwAolSBn7PwTlMtrx4N60zGn4Df/Fqi97UCYYafIYUKyhZ/8QuGuzIakAxFL+Rj8brTsPOIyotsXDw/ivUK5r1ZBvVYuE5b38ODhI7BIJCY79p3WNSpQj0v7kodrGndTSE2EgUwM/QYblss7Ucup+0gXMF8sn7rBQtzy1ZEy4dnVcaNooej5fZFdi5Zwq65DUh/BZZhSs7OpCGTGWa0T98i2gJk/tAIeFImIGzUcN2B0Xaa/aPsvTv/PeN7UYn+RvjunyAwRhTjH+bBrBREIM4TRZNwtR70ppY+se5gRo8FeOWELpQL+jgflvhHQQl6LlOE99B7Nvd3f1duJ2P4qv80GYSmmKRrBTte5tlNFVkr6lRBqp1THUyNW6Xcqj9HqDE2/5J9ZnXlaDsCzgPtwKNqyaaIX8SCLfZ3o7vN9/iNglzizE+4TUEguCPJ9NJF0iBiIeJFzSWxmx3jpq15RwqgGM+Xtl7gZCmYHZsn3Nr9f+gAZ+Gw7ec76r3LRpA/Up4mqtQsyi0794=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmR4dVRmNzZUMlF5dm1tRjNSMXJtMVBQb2dad1lRZlRycXBHM0ZHdzN1MkFa?=
 =?utf-8?B?ZjNLcGtYWFBLL1pGUStlTGJvek1VWlNzd2had1ZERUx6ck1zOTBXT1ZCa2dP?=
 =?utf-8?B?WkgyeHhkSnpQRTBOU1pzVEZxUlU2S0pkR3A4cXRkMGVMSUN0a1R6L0h0eFM3?=
 =?utf-8?B?NE1nRktER0RxVFh2MzViN3VqYTdGZUxRQ1FtemN1ZmtsMlhBQjVzQmdvRVUy?=
 =?utf-8?B?QnVsOGI1ZmVJYVp6MWFUdTQ3MmRCTlVJaldQQzNNM013cGhEZkF3cUMrcisw?=
 =?utf-8?B?SGJBNStCa3diVysxNEpXYjRTK1dKWVNIMk8zdVNrd1o0QzJyRWhEL2tydW5r?=
 =?utf-8?B?VTlvdDVlOEp2VnUrZG9ZcmZ5bEQxS093aXVzblVuT3lMVko4Mk40bUFncEFC?=
 =?utf-8?B?YXZIRDFoSzV2TENIM3k2SVZyUjR6dHRGMjA2OUdoL011RWdQNW5nVm85d1dM?=
 =?utf-8?B?eE9tSHdpMWh3TGdtajhsdW5tTUhVdm4rZ29RY1U0a1JYL25RbCtVZlRaL1Bl?=
 =?utf-8?B?aGM0dFhJRVFncW5zS25iU2tXZy95ZmYyV3N1bFBPdlgwMzZVWGh6VjNTVWJK?=
 =?utf-8?B?bkYzZ1I4VGs1WEkrZk1YRmpaWFJ5OXVTNWtIQVNscXFhSzN4cEhmZm9oc2Ji?=
 =?utf-8?B?RlZSa0d5ZXhDMEdYSTNJanAvNmR5U0Q0WVFpQms2OGJ6R3d5am9GenhTOHpV?=
 =?utf-8?B?ZFlxajlUTTlGaE84czk4N1FOU0kzSUc2a0RnYlY2OHZlSU5YRWFUeE5MZHJn?=
 =?utf-8?B?aVJZL0N2emliVFFoRzhlOEJENHMveGZYUjNjbGZDSjF5TWVzcmFxVkxTVk5P?=
 =?utf-8?B?ajFNZ2VkdnBmMEZIcjROV3IwSFZvc3pVZFNVb0NUVFlLWGVRbW5HbHJQWnFq?=
 =?utf-8?B?dzhNZmhJWUFveFZsRnU4Y2NLSTU3WUJZMVlLaTRRcVErbnJ5TThRRXdSSm91?=
 =?utf-8?B?M3RKWVNTVGdHN1plUXBPVkFSeDQ3VFh5NlFKNzhNd2RNOXBDSmNFSXBIelNC?=
 =?utf-8?B?ZHEzUFJaQjVlUEN2YVVuaU9ZVFQ5ckFUc0VXVnJTREt2T0dCOVNLYWg4VXpH?=
 =?utf-8?B?ZGlrUC9sR2NWV2RDRE1xUUdzcnpNdWZQZGRyeVRFMWFQRkUrQ1VxYXNlUjJ6?=
 =?utf-8?B?LzYzdGsvTGNYWUdyOWhGTTdmMjNTTG1KQXNyUHlKRXEweENxd29TakpOSUI5?=
 =?utf-8?B?ejBmUUdHbXhZK1VvUjluT3FxVVRMV1lFMDZwN1BBRHRvT0YrTTQ3a1pQQzRO?=
 =?utf-8?B?VnU1dnV6ZTNwRGZGU3BYVkswZzJvbTlMVGpTNHhTWjQzR1FGUS80UWkzR2Np?=
 =?utf-8?B?RXFRSXZuOFhZOEFHK3FINWNPdWtuSVpZdjhoWnlLZURWTmhEQkhNeXZ6ZnBL?=
 =?utf-8?B?YjkwQnRxR0JFZW5TUHM3dTQ3dDM1NVJxSGlnTy96MGtmV0JqOUZCdWN6dVJ3?=
 =?utf-8?B?bVdacllXZHhYZEZqa3pkZnpqMldaWVEvTG9HeThjeXByWG90VlE5b1kxYm10?=
 =?utf-8?B?MEV3cGkvdnFBUlRKN0JaQWsxbFJJTEszeldVMlRKTm11QzhzK2sySUxBRWNv?=
 =?utf-8?B?K2VkK0ptcGo3NHNhZFNId3JOKzEyUWJjb2orNHZoL3Vsbk1pZW9RemQzazlL?=
 =?utf-8?Q?qDi06AVIOucZNQl8Q5NKY3UypmHfCJy4kJlnA1d1T+o0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01267ccb-7f6d-410b-8045-08dbbb2b248a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 05:17:01.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
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

It seems I have missed a point. I wonder whether it is better to add a
"aclint" binding firstly and then add sg2042 to it, or just use sg2042
specific binding? If use "aclint" binding, I wonder it is OK to add
thead quirks as compatible specific properties, or left this to the SBI to
handle? e.g. T-HEAD timer is not 64bit timer, and we should identify this.

>What was pointed out, I think by Samuel, that the reason that this may
>need to be split is the fact that there are many possible MTIMER
>register ranges & possibly sswi stuff too that would need to be
>differentiated.
>
>>
>> Regards,
>> Anup
>
