Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DB7FEA24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbjK3IDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjK3IDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:03:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2013.outbound.protection.outlook.com [40.92.22.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C1A3;
        Thu, 30 Nov 2023 00:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4jad+Zs6i7YqbvRc77g4pIPYkBZKwLDdwBd/MyVjB8yaObbGDMxn6eRVDsXzG5GjiIIIqF4Cxfe2plMU04hXqVjS9DeaaHUgWAVNdQz2iCdd0JMmh7ePppqKmVPtSM+8rYZn9EqV/Sg6cD2r2qOrovpOwlTwIgtocSAtezIAaMVYCH5ZISgzwVvgpTmPYS6QIXKm7vmtbsDAtqjol1WGEevRuYYoPY4QxuWuiaAnTRJHGtI7m2vf5hydZLxDhvtr+cbQl1eicG6FAPpxq2+s0eKIZtVO2xChgqQm0WvvSXS7OF4f/dlDt2dI1DelPpCz5DbYbNTH5mMLh5oWpcQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dHVeCB19/RNZ0NNu2FkGDYgfbGYa4q9zSdAIjDNLUI=;
 b=Yym+lEnk1W4wazG7UO6Ci/G/KKl27okxsLUVSMkghoNU5wIjmOac81IKYgW2G0qlk9sfC/AuYL61NMFEeLJWUIZ1zCALaesIMc2KdZ2bf5+p2dgNVSU0xq+ueGBeR1+2DBVNhkRJqEFXLKeFgvHCVnGu19yyYfiNnDfvCz36Vi+/3cwX8efs83204OYAJzBtgSHmE1IMD5FLDwPmvYYwnziLMwrAIp1s+scRSeC+TxVuWR/nEs0elEPzgBkeTO40JIbdfQIuhIsh3VfKSXWphViie9roh70V0JBt2XJlDQS20hLIvYNS1Ez1VTgzAMemPJjhmy1W5xzWhF7W5c9Rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dHVeCB19/RNZ0NNu2FkGDYgfbGYa4q9zSdAIjDNLUI=;
 b=I/9Q5iVwSqOFHoPezg6L/2m4vIorvkZuWe0oiYlFgkR5AOumlDoMwkj/vpLeT6yKMNWnKHo1SgtC/lGceGVm9vkZMMCEiTDZVW/OMMe7YtRsI6036x1nXRrOD8DFsK+QljFD96pOodq+HG7NW5nyaTOwVKCQYONS8c9P8SmrqartnlbCcAIvams9fg+/wdEBv9XeQ6/PmSgJuW+R3Ue+33w23AAcHYlupFQ12M5lihXivEsFiLgwDOzO2rEfFarsnx9gkXZTCLNJLMCf5WfA6+V1i2p73n823rLffIlyi6CC/0JAIFoDzXDrZVjSBialTnxaO2DkiiuPQ4SSFv0etg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6351.namprd20.prod.outlook.com (2603:10b6:510:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 08:03:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 08:03:48 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Thu, 30 Nov 2023 16:03:46 +0800
Message-ID: <IA1PR20MB495347868C7646C29022017FBB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953840B83BA1F3675BF9A5BBBBAA@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953840B83BA1F3675BF9A5BBBBAA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [oHBc6CW9/w8T9Y2rKU+fCrC+fIHAzYO/I1dHgpqpXFQ=]
X-ClientProxiedBy: TY2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:404:42::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130080347.320174-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: f343a4fe-6727-43d1-1db4-08dbf17ae198
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2VJW8DfMOg+IRbPwErAd7x6Z/eeB6F2UrFKxogYa+3A8PRVu3QCkkijR+oY0zQ/c6PnF71z2dvTwDA5uH3RIBvNPrC8o3DZdsKhuZuY6SoSQ2nI4R5u+uFWa2jyhBrisvftB6eY5sErsoq8mCC2w4iOUcGdQ8CD3fhrMrdJokZZ6SlNsVsBL1VWRMS/FLwVCC7hahbTKs0ZwMSxUNFeOnKY9zuxAIghp17ccxP9TAIs/9FpIvBIIQuI1jRLm2nblrUxLGVUkI+m+v76bhNP56bACsE7UNvNlkhgebenekq4eujLNxHmBdJzSIX/zfaOczIrH4BWZl/MlNL/9kd9/GqNDVm62lhd1AkuAhOR6fBwFKCx1AJGwLvtUJX/BH8DW/lijEhiOVGib7m/5Ii13jQB8FA+JfDAvdjWtD8Plbz63eUi85q7bAQI9LIfvvfl8Ym19aLA6YzGOAhpDT63eZPoXGhEY1vawXfFj8duKPot/oVB4PbK3I0dBo1VLe6x+ovmf/BowE6mjk/I0gGJ/wH+2Gyjk3xJTSstylgy0rxhijr/Y7BSukCsmugUQm285L97WaHIITIIIVntyB3vs1zOQ02Ft6RJ0K596xCN02Dq6fx+S540PJS0WJ0P+vPXgd6yK628h86m/tTZPkvK/l8jP2IalPGv54flp8hojdo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FqxwepRyGrm1Wx1/oTJUH0JtDpYzLvOFy9WbLn+/8PiOvE0v6rL2Ff+NuKS?=
 =?us-ascii?Q?VIdHEm1ElRp/ht2ocb28UQjlq9H+vohqpE49f4EYlbLMzNxSb2B7TQTbh7Wa?=
 =?us-ascii?Q?aiaftmnC1nI4TdOaV3orCrOP36VVIFOT5BmB/PnfiK2sppZG6MEHJwSi6ws/?=
 =?us-ascii?Q?tn0rP5magd5E4tKn/VUEZ0+lNmJLzocK7a15aUP8WkKScqrk4ATA+9AyxVpy?=
 =?us-ascii?Q?tL8Qt79PtVIn4goMp1bIf05uai+RKHAuemoh/41FSzFYvNn3nvByDzfRaQ6D?=
 =?us-ascii?Q?TanDfgGjKkU7s8IPFMazCEU5n4GRZRI/4MLjyqYAkZIR/PYsxOrMm1BZTQjq?=
 =?us-ascii?Q?BXEOG+H15IlZ6w04yOdJExQHeWGUUphEZ+OXNZxoo+Ajz3rIs1L5UfZXqe29?=
 =?us-ascii?Q?muHjuj29xun7v3Ym24ax71kn6i0XdADXL8Pl0sLb0g/Yb5wsZJJIR1F8HkAO?=
 =?us-ascii?Q?rqjCBny9ob6m3WUBLwHwJvDWhuBDx9f746Q0YoguABwmJ5k3PsTuTUnORS+0?=
 =?us-ascii?Q?HFYVYGB6N9xZ0KKi0A+T5KL/QjshdWDcxv7zCjASl4jmT+2E2wk3nHTzS8Ry?=
 =?us-ascii?Q?+EA1+8cfb3oJG6P8RFe9wnfPkr2vvKnDOmCa8S9Y9qEbRHaBxmMewFLWEbDk?=
 =?us-ascii?Q?gb9+pnVxFl+v6nnrgYL3OxQN91if1w+T5aeWbPQOL1bo2YtE2TZ94phBuOOd?=
 =?us-ascii?Q?4unvtPLaf5Rw9WtAdFL0za3xVExAP2NN6WBQx45Zh9euXAYD+SIP8edfgPZv?=
 =?us-ascii?Q?KzoO0IRhcLeu7DieaDEr+uiLCMzzL8hPjN6tqYcwOn9imX8Sk74VYLDbkUbn?=
 =?us-ascii?Q?38UgSKoF5f6oQd0/FcNcJvc33LBOBr42Df+cYXAKzMzttl7aD07hDw3Knber?=
 =?us-ascii?Q?lkGzxTQS4WNcp2I4jMHh4thTwtbMI2pOKzq1ZdImalTqXq4aTnK7O2tdvaoK?=
 =?us-ascii?Q?wyRO40SpN1TNjw3/DkZ5NHw5LDonQi/g4R3nl3lnGH4DRWPLBXKrUFjFNmAS?=
 =?us-ascii?Q?Ql7fJ9VYKgjZWriGskyIcD6GeJM+3MA/8eqpC6cj4elscsS92PAlY5cNskBM?=
 =?us-ascii?Q?iXqSMH4lJ37zuxO8FoPvYqlQ7Z1aqTefGF882u3IM44DOpYNemixI17A2euh?=
 =?us-ascii?Q?BvN6ger/DdmGGmB8dW55nVrgCZEevFq/H2cbT9pBju+JFec4sel0DbTZ7Rd1?=
 =?us-ascii?Q?aH5NuqEzlvBNh8oTNrDQprcvilwtcDHhkYbb4689XCKgPPvDTRk5Uyzbkq8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f343a4fe-6727-43d1-1db4-08dbf17ae198
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 08:03:47.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6351
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
>> On Tue, Nov 21, 2023 at 09:12:12AM +0800, Inochi Amaoto wrote:
>>>> Yo,
>>>>
>>>> On Sat, Nov 18, 2023 at 03:10:26PM +0800, Inochi Amaoto wrote:
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
>>>>> ---
>>>>>  .../timer/thead,c900-aclint-mtimer.yaml       | 42 ++++++++++++++++++-
>>>>>  1 file changed, 41 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>>> index fbd235650e52..053488fb1286 100644
>>>>> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>>> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>>> @@ -17,7 +17,20 @@ properties:
>>>>>        - const: thead,c900-aclint-mtimer
>>>>>
>>>>>    reg:
>>>>> -    maxItems: 1
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - description: MTIME Registers
>>>>> +          - description: MTIMECMP Registers
>>>>> +      - items:
>>>>> +          - description: MTIMECMP Registers
>>>>> +
>>>>> +  reg-names:
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - const: mtime
>>>>> +          - const: mtimecmp
>>>>> +      - items:
>>>>> +          - const: mtimecmp
>>>>>
>>>>>    interrupts-extended:
>>>>>      minItems: 1
>>>>> @@ -28,8 +41,34 @@ additionalProperties: false
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg
>>>>> +  - reg-names
>>>>>    - interrupts-extended
>>>>>
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            const: thead,c900-aclint-mtimer
>>>>
>>>> Is this being the c900 compatible correct? You mention in your commit
>>>> message that this split is done on the sg2042, but the rule is applied
>>>> here for any c900 series "aclint". Do we know if this is a sophgo
>>>> specific thing (or even sg2042 specific), or if it applies generally?
>>>>
>>>
>>> This can be confirmed. The thead c900 series have no mtime support and
>>> there is no evidence that they will implement it. So I think it is OK
>>> to applied this restriction for the whole c900 series.
>>
>> Okay, great.
>>
>>>>> +    then:
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          items:
>>>>> +            - description: MTIMECMP Registers
>>>>> +        reg-names:
>>>>> +          items:
>>>>> +            - const: mtimecmp
>>>>
>>>>> +    else:
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          items:
>>>>> +            - description: MTIME Registers
>>>>> +            - description: MTIMECMP Registers
>>>>> +        reg-names:
>>>>> +          items:
>>>>> +            - const: mtime
>>>>> +            - const: mtimecmp
>>>>
>>>> If it applies generally, I would probably just delete this, but unless
>>>> someone can confirm this to be general, I'd probably leave the else
>>>> clause and swap for the specific sg2042 compatible above.
>>>>
>>>
>>> I suggest keeping this. By taking your advice, this binding has actually
>>> become the binding for aclint draft.
>>
>> Right. It seemed to me from the reports (and the commit message) that this
>> was a configuration choice made by sophgo for the IP.
>>
>
>Yes, that's true.
>
>>> So I think it is better to preserve
>>> this path, otherwise adding the mtime register seems meaningless.
>>
>> Yeah, I mistakenly thought that there were cases where we actually had
>> systems with mtime and mtimecmp registers. I don't know if that was an
>> assumption I made due to previous commit messages or from reading the
>> opensbi threads, but clearly that is not the case.
>>
>>> But if
>>> you think it is OK to add this when adding new compatible or converting it
>>> to a generic binding.
>>
>> I'm a bit conflicted. Since this is c900 specific one part of me says
>> leave it with only one "reg" entry as that is what the only hardware
>> actually has & add "reg-names" to make lives easier when someone else
>> implements the unratified spec (or it gets ratified for some reason).
>>
>
>Adding "reg-names" is necessary and does make live easier. It gives a
>clear way to avoid hack on skipping mtime register in the ACLINT timer
>definition.
>
>Now I think the only problem is whether the "mtime" register should
>exist in this binding. IMHO, adding "mtime" seems to be too much to
>keep this binding vendor specific. It is better to remove it to achieve
>minimum change.
>
>>> Feel free to remove it.
>>
>> I might've applied the other binding as it was in a series adding
>> initial support for the SoC, but usually these things go via the
>> subsystem maintainers with a DT maintainer ack/review.
>>
>
>Thanks, I will also wait for feedback from the subsystem maintainers.
>

Hi, Daniel and Thomas,
Could you share your suggestion about this ABI change?
