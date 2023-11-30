Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603747FEEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjK3MQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3MQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:16:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2096.outbound.protection.outlook.com [40.92.22.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3810E0;
        Thu, 30 Nov 2023 04:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHVmPhQ19fk1OC3DPtecWzLAVtxSKfQhRMryMaINBYZ6Bh0CFK0wG8Qat29cpV6DU7y/8r4vmWyrbHqXl9co5SiaLzZqXPBF5QwjVhw+HHtf3d7dzglXNNgts9SW+hvVz7ZwEr1O/UooNLN1sCRPPAyZC4xvKM1knQ4lYBGMdPx8tNucBSOAPHpto8H8A217Op3mGcDJNFzaSpnGsFmIJoUv91XFLrT6snTrpP05pMd+lkWwx9fO5jaPA9CttClDnKchrxwNw25eDOCgMqnNDQ5XVzIDt/cBAgdwhVbthFMlJh+kqZjSzjnFxj2LDNEu1hfYSmcfe1FXeL9G6clQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+M/M9nICUXJYjG/hmaDCxcFvuxVJL7LsPIweNBcjmo=;
 b=O8+2IKPiPsW2K3cD6dhDOoL4Au6ZAiziH7pVf6mVjqsJJWENEfUpWvZaYnfRbgDp4IR9IFtFSzZuks/upsfbdNnFeNewovQBbZHxODc+BCL2+fCZ/GGihiSSV8W3ouuVPs3rSgPEYDA5LOYT+GCDPbDb+YLYL9nL/XYAmDx2oF1uRvVE1/BALtwqlwcKBq4Lkr6v+Lel9VtgQ7zGHXYW3LnkAKYEuKt5494+SC033r5wnM9vsXbGE+tjT2VfFIIQ9n68xTXbZYQTC7PufgpBKOy7jjZNrqYzpsJ8m0ngmXzpgMxWH4bUh0rv8t3fluljUns25+5t7BndxloOLibDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+M/M9nICUXJYjG/hmaDCxcFvuxVJL7LsPIweNBcjmo=;
 b=sbhmQ1HdtGBy0HREo4PpUvkDSUIzMnLEpD8xosYP0yGNlebPm3MAaaAnb75g7E9vdDhB+Luk3GISK/Rv34mUm1YkRiT8qnOpUHUkVNX0Z6a1+evXGGgpnYeit/uyw7aVf8l8XvOcpFn/KwS9/Drya+axrVDPYGNl1qDYcB0vvaFp9z0bUL1QbPMWLoIP4EQx29YAhpOg21hq6D7AHFTHpQpgbZ6FOyx9CEsbR6JG8n+UqFsjAgXGni300wE38mH/1tsTk+H+1EHh3A/642sVAH4UTYIjn/VmfQX5QO9uQHF2OlsNiM/QUP7rOuIGXoKwIsNkhG1tpM88di+ogWI90w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW3PR20MB3548.namprd20.prod.outlook.com (2603:10b6:303:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 12:16:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 12:16:42 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
        acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, heiko@sntech.de,
        irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com
Subject: Re: [PATCH v4 09/13] dt-bindings: riscv: Add T-Head PMU extension description
Date:   Thu, 30 Nov 2023 20:16:38 +0800
Message-ID: <IA1PR20MB4953A05B9162AA2659DE78A5BB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZWhT_VSpl2aksVK7@APC323>
References: <ZWhT_VSpl2aksVK7@APC323>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [mIfqZYRrVxkVYQFgFS+wTBDERuDYG1VI49vmpWfNEtE=]
X-ClientProxiedBy: TYCP286CA0304.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130121638.372252-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW3PR20MB3548:EE_
X-MS-Office365-Filtering-Correlation-Id: 23919dd2-30a1-4421-6388-08dbf19e3637
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTQoCdoH2i2LeG/N07kZ/eXNisTe23G25Bw+0q72Ymjsr5lrpF93R9VT+nzQYjM4lopWcELUq5TCeI5VEn6U+NIWFnfi/mnUacFUfnBOTV6WFFRxCWBgYGxABjG+XV7+A0DPg6aigY+nH1IMWnWFiPBF053OF1z1IplVmOQah3WuoD1zsMJ1BiAdMfUcjj9YJluN5XWusRcnPCVN9eZOAKKySN8s7PKConZv82EshNUjha114/blZJfOVChHZzJy5N3elj98ir0FCsA1wh30scRKVSlt0s9MSfikYbAdO9ysY59M1eoF0iBMSdfxeUhMbEUe3rLRkNRGYzKKCtr67PtRR+DlnzyW0bd9oAmJ7P8eAPh+mqVHonyq/Dv2khZb105jfgDDaffrA03ZsMpnwWpX7qvdwEFfuxIduidahPKG95sl0L7jRijxocSQw1EQISw1Gva00/hW2kCm7MvIhtiMWbHvtYt28I89VyKFBHZN/ukQrVcX3qgU9VgrU7BBDMg5b8jsXIwqyLrHRu9XPzMTitaRhqFZ3SwSY0I0PV+/2ZLFhcLI+SeN3fzJCWqGBexfkfskFuH6RG7rmb+zPrfNiGwhlmi52+7avL6sYu1/ALf8IKuC1izUjnCIBcnYQ0mL29HlGqvtAzD8sspaZYnJ2MqduQemVCUK16ReBZE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFmNmlrMnY4bXZoTGFiWllybjJsZGtkN2p4My9PTk5obUZOU042enpCcE1P?=
 =?utf-8?B?Z28zbWRqWUk5T3RDMTByaGZQUVV5bXJLRmpqdThlbzhuczFXWm10cnE2cFEz?=
 =?utf-8?B?MVZzclNjcXJuNm1rRnNrZ0JJVldsUHJnQ0gzTE5TdnNRMDVYRkw3bVBJQXdv?=
 =?utf-8?B?K2FIcjdHbTNGeUtKeUo5cSt3S3k4K1hSQVkyVTNCQitVaUtvdVgyOG11MFpR?=
 =?utf-8?B?ZjV6dEplaHQxMmZhV0VYRWhzaktvS29WQStJL3FpcDZ4ckpmZUp0eXc1VTZk?=
 =?utf-8?B?TldaVjZ0bFM0MXdFZzB6VTlRZ1ZtVG8vWTRqeG9IMHRCcnBDOURydTIxYUcw?=
 =?utf-8?B?T3pXeG9mdHNvRldaZCtLdVdqVC9tRFdQMDJHRGdBY3JPejJ5UC82SXBSNGpn?=
 =?utf-8?B?WFhod2ZoOFZFd01QcHJ3bVA2RUhQWXJQTFhwWU9wTkxtWXRJOXFabEQ4bkM4?=
 =?utf-8?B?dU9FUGRuUlRod0txbzRJbmIyYW1OL25yQVB6NWViY0lBUG5YU0Q1S2x6dVpK?=
 =?utf-8?B?MVprbzZZTEkxODFEMEhaRlJxY0dzYzBsbk9WNXI3Zm1nRkJWTzFPUVdPT3Ry?=
 =?utf-8?B?NHpiSzJiWTMyMnVjeDYzU09ZNGFXci9DQUVvYm93Yyt4dk9FKzRNT3JaSDZm?=
 =?utf-8?B?OUxVVnJROGlyaXVIc08rTUF4ZHlldDNTWk94aTBxRk1tamJxcC9iL2J2TzF6?=
 =?utf-8?B?WDlTdW0yVDhaMlNyNjNiQzZCTFFUTzF1M1JVVkgyZ1BHZlRJNEw3cXZoUkNl?=
 =?utf-8?B?akdlOWtpWHAydkZ1VVdaSGFaSWliM09BR3ErdytyVHBmQzhaOU1JaGQzeTZx?=
 =?utf-8?B?WldYRmZxS3NQSTJHNnRydExhRDREOTRqV2RYbW1ya3ZqR25Odm5ZVlo1c0Fy?=
 =?utf-8?B?OEw2azdqZ21RY21pZ2VqRm9LL2laSVBjODdDSktKVks5d2hqZFZYSjlWODZn?=
 =?utf-8?B?YktZc3B2QlpSUTFnT2Z0TzRaZmxUcVpvdXhlLzFhNVFvVVB1Z1gxdG5ESHda?=
 =?utf-8?B?TmhzcVBhc0VIajNxVmJSWEdzay80d3JWMkJPQWlUQ2Vzbi9zQ2cvcUNVWmd5?=
 =?utf-8?B?Z2xmN0lTQm1Yc0I4b1FCSkloTFM5RFkrbDlCNGVTblVrVzllMHBvNGdXVFVS?=
 =?utf-8?B?M2xxckpJYkxOT3RCL3YwbGRzcmhKRHBqQ2xyYXRrQUROdG5SVlJpcGdwWDkz?=
 =?utf-8?B?RWNYQnZyMThVZytIZGRvVTJNdmpVbWxXUVZmMmQxdXZaeUJnRTU4bk5EREVX?=
 =?utf-8?B?QS80T0NvSURhYldOaTN6RWtMZEUzMG1OTUp4R0U5Z01jL0VmSElIdXNxU0ZD?=
 =?utf-8?B?c29UNkFPY3hPN0p3dXlmaXhwQVhCQitLUElSY2J5dUtGMGhsd25QVWlNZGQ2?=
 =?utf-8?B?MVRpRWYwMHcrb05rZzJVODF3ZkVtZW1IVTliam1tYlFPNEdhcjJTWHdVaDEv?=
 =?utf-8?B?MUdMS3puVGM5NkZCTHBkZkhhSXJtakxLbnVYdG0xZDJYZ1AyMnlsMlJDNmoy?=
 =?utf-8?B?QlBoUWttYzBoUXU3M1lGT08zb3ZkRDFMaGxGSjNxNkh4WmRLWHowa3ZUQzFW?=
 =?utf-8?B?K3ZVNDAzeXlHRGh2V0swaXU3L3M2akRROHlPOEQyOVZHUzhweGhrR2ZGbFRH?=
 =?utf-8?Q?HL4/t2zz/JQf5ncvoxRmiQWlM0MeH305i3K6vMEk58S4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23919dd2-30a1-4421-6388-08dbf19e3637
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 12:16:42.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR20MB3548
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
>Hi Inochi,
>
>On Thu, Nov 30, 2023 at 04:29:22PM +0800, Inochi Amaoto wrote:
>>>
>>> Hi Guo Ren,
>>>
>>> On Thu, Nov 23, 2023 at 05:14:30AM +0800, Guo Ren wrote:
>>>> On Wed, Nov 22, 2023 at 8:17 PM Yu Chien Peter Lin
>>>> <peterlin@andestech.com> wrote:
>>>>>
>>>>> Document the ISA string for T-Head performance monitor extension
>>>>> which provides counter overflow interrupt mechanism.
>>>>>
>>>>> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
>>>>> ---
>>>>> Changes v2 -> v3:
>>>>>   - New patch
>>>>> Changes v3 -> v4:
>>>>>   - No change
>>>>> ---
>>>>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> index c91ab0e46648..694efaea8fce 100644
>>>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> @@ -258,5 +258,11 @@ properties:
>>>>>              in commit 2e5236 ("Ztso is now ratified.") of the
>>>>>              riscv-isa-manual.
>>>>>
>>>>> +        - const: xtheadpmu
>>>>> +          description:
>>>>> +            The T-Head performance monitor extension for counter overflow. For more
>>>>> +            details, see the chapter 12 in the Xuantie C906 user manual.
>>>>> +            https://github.com/T-head-Semi/openc906/tree/main/doc
>>>>> +
>>>>>  additionalProperties: true
>>>>>  ...
>>>>> --
>>>>> 2.34.1
>>>>>
>>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>>
>>> Thanks for the review.
>>> Would you share document about T-Head PMU?
>>>
>>
>> Hi, Peter Lin:
>>
>> You can use the following two document to get all events:
>> https://github.com/T-head-Semi/openc906/tree/main/doc
>> https://github.com/T-head-Semi/openc910/tree/main/doc
>>
>> There are also some RTL code can describe these events:
>> https://github.com/T-head-Semi/openc910/blob/e0c4ad8ec7f8c70f649d826ebd6c949086453272/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v#L1123
>> https://github.com/T-head-Semi/openc906/blob/af5614d72de7e5a4b8609c427d2e20af1deb21c4/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L543
>>
>> The perf events json can also be used as document, this is already
>> applied (with more detailed explanation):
>> https://lore.kernel.org/all/IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com/
>
>Thanks for reaching out!
>The updated description will be:
>
>- const: xtheadpmu
>  description:
>    The T-Head performance monitor extension for counter overflow, as ratified
>    in commit bd9206 ("Initial commit") of Xuantie C906 user manual.
>    https://github.com/T-head-Semi/openc906/tree/main/doc
>
>Is it OK with you?
>

I suggest using perf event json as event description. The jsons provide
more detailed explanation for these events than the user manual.

>Best regards,
>Peter Lin
>
>> Best regards,
>> Inochi
>
