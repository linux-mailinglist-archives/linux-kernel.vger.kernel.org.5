Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBB37F3B48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjKVB0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKVB0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:26:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2073.outbound.protection.outlook.com [40.92.42.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892CDBB;
        Tue, 21 Nov 2023 17:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk3LrDlrPjYuqH4Knk9K7lG2BgLBmUi1Bo7PWgogAtSH5jTmwGoTU6hawtSeuEdM5zKPRl1MXBO0WQqo1ooPndOEGDA8NsC0pK21s0CxURi5KPEU39HJb7e8PLOkfdIZPOCiwvnsftlXfGIB44N6LWD6SY0Wkq0Tj8EbWWDIm+0nj4dvoBwmmmnzKe311MC0W7XV0FJdWpp2j1e6Hbgnv/IfPGRpE+mCleg0K1QwiMurWAedn411y0elPZprMvfnjcCyCbpOBg3nW4SxeC73TMNp9ydekrw+Wao47Dk5IFJ9j6G8lDuQ3HaSelF+b+/AjpTeOuX0d8Z33Luv/RkFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mV0PyFbgRSWX3sWUwxlLUmLdp7skid7mW1wblFed5s=;
 b=bPPuAMKlL9AaRvY+pW1ZkPSJdsAhJMnkpCiGgzo3Vibc1FtWh6LYVC4SNbC9qI9IcmwLgP1gaXewKlETfvCytDMOrZP3I9qqVBXlDpGlXwAbD/s5MejWnMzxDda0YZvVnTgvFJ5fj/aEwnPQUd66Ndk/ZuJc3CHN9Mjiq5rryARHhyfLzn657LnwcRQhtiJJptW9+PS68/a5FuTxAJ0DK7lpQDTVoMmYpigp7pRdi/H+QA5y1rzKItFjffzheCMrVB9i39iviaFfxqDIqAKA427OUhkZNm79svIYd1M9psvjZ4P3PKAoUU3y0O9Vn6aaZjHS0Snsw41TMkm3oEw4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mV0PyFbgRSWX3sWUwxlLUmLdp7skid7mW1wblFed5s=;
 b=T95augztlrUQw4bJ2ljXOKjYJ7dz5hoWe/zGzUrP9/K8USzOT5n2gM74dcnVVfHB6ZSqZzQYUwlK6Z+urZtjT5dMASkaa2aVd4Hu2aSKqMJyZKDNS6XtISPNHKUvqp3qy2PdMilHWjP4IV5LufCsmafFBQOnQ0OQ7kKcs3vdlRL4assXyc5TfRBcKjZ0id4zTysJkr8QvIa+peQK4eYfH5Vk5nCUaCnOuGfpx3aQ21D2gyTbBzif1cVBg1MoWMlVnGu1fae6HGbviE495TC0qk/N28CjsEuQ0cwjvbapMcDgnNYuO4lbcHzGPqCj8BK394OdtdHMhnPznlCxuoCBSg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB4958.namprd20.prod.outlook.com (2603:10b6:8:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 01:26:45 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 01:26:45 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Date:   Wed, 22 Nov 2023 09:26:26 +0800
Message-ID: <IA1PR20MB4953840B83BA1F3675BF9A5BBBBAA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121-vocation-clunky-17e2c77e64fa@wendy>
References: <20231121-vocation-clunky-17e2c77e64fa@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ey1hTHxgu8OTC0h7k6qgnjSkzc+DSqWAT37OEEZqbs4=]
X-ClientProxiedBy: TYCP286CA0335.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231122012627.115573-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 3605f1b2-594d-4d42-d64c-08dbeafa16e4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYqDfgHpk73jOXEqltZAipY18PqaClWGCcMKDqlGRA/OkFmjr3gmalA7mJVa+Rrae9HC552Btv4Zipl8pekGDue/Ab2QYk8pHnk5+eS5/uoY8F852pcRKKD5lrFDR5+4BDrBXcnoRusREbivxWQ0+uQiA8dWaHGiDzoz+jHYKjr3oj6+tT+2ebWKGoqLIIVl5hQXSNW7fk/3bOXfeE77wR5qnY+H9QhxJ/Tuv1CVRF4gk2bgSDQbZBGLG3yq2fKp1JpA2cVURHK5a6XVXa8IyETyvPFshNGq2AIK71Th3y5C9FEkvnN4rOz8FT020saDn3hDtGhJBkZnGnRBXgW81QRgsOQzGpaBRx9vPwGIYA4WmqPERGUM0eljLcLpPj3R/taCJ6oCnpUhA4hpASZIcVrTo6JPAWh9hixXCkWjWjf/V5PNDIRrwrDQQi5clz9+mzc7Ys8834yx1ZdTagfASiAh1UDuHDih8nqmTMMAaieluOGDRBeZROaAxtKVh5GnVAG6z+gY24xOAe0b5pjDe8QUkK6n0RLjdQbaORnT3elo6B+dyqWFKFnqeKgBjbUD1ZLVNwVxGkkBuPsAw/Mg/egG+ktgL7LOKNLwuICp4TC0iB6ZySReHPzIA8i9OHjPs3rbcJSYdcSHO3KeuoX9T7HiDGLVO/mhxL4FJNwldls=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9V0VvXI0bvyjl81YRPq04bBqBFvv5tPnn7bnhGS7LpCZwx/gmt9mh4+ejKO?=
 =?us-ascii?Q?KWYSozTW26Rh6AHFNm8PuS0hRYSsInS3Ap1LEampgc0PmwJ8nlgv0XGcaN7v?=
 =?us-ascii?Q?h2QtXCtlzjrRxXyX02vOgf9yAB7N+hVt08ZIJ5ULktBkxcuF2kDGolfKtB5k?=
 =?us-ascii?Q?V/8Zg/XP21uOM2xUVgkIY4Jwv/czXqWpCHCubpGH/0tFX6OIm1n1joy+j9P5?=
 =?us-ascii?Q?Ns9EsmlMG2tTEWqoopbYZFpvj1wW5MhFO2INrpKeer2sY0VdOC4xUNHFWcAn?=
 =?us-ascii?Q?6ogmebwohQ6Gh7icLlyuTiRc8ztrGR0nu4sTzyyfjECh+J02G75e3RSCMNsY?=
 =?us-ascii?Q?GCZZJSe/SrEqVSyYxMkxBzHVPcIMcc0y1XxbyQqhJ/xXdaRAVOZkPxqdZV7i?=
 =?us-ascii?Q?rhTGYgrQh7H2wMbE+6v9SElspunTwh+IlA/vu2VjLp2qQ/NaK0rbt8cF+K15?=
 =?us-ascii?Q?FAYBj8i78LuwgI8ZUbqv8HjL2f13iZk8ha7k2R1XfPqsDvDqzK5Xw/7PL93I?=
 =?us-ascii?Q?+1fSw+MoCj+gvQOAtR+Aopr+Smr65JtGepTJcNbhy4K69vhyvwcmyIqbQUFh?=
 =?us-ascii?Q?PGQdWOguf1uPsPqU+hmj2y3v/ggQNTeJPgFSVjV1SPWMgJWeVbf5SOZeAwmx?=
 =?us-ascii?Q?mmJqxxL93hbLtnyL7RB4PnfGAehyJFyvHRQ6H0WFP4QcZ5KGTeoUjVD2+C3G?=
 =?us-ascii?Q?a4bsAVeU0yzdtmGL7JbRBhM3M1WarlETlnWepiXiN1RwT0rIvVmnPKjeY2t0?=
 =?us-ascii?Q?dZOVcSmSq3UKoPE/LYvPOU7WFNKpykoZvfXPTb2rFBHBvtHeYu0uknpRgSzu?=
 =?us-ascii?Q?4VEDON9/DIoFstlCO0Dy6bByCrdrUqkpvtLMmN75gTh8IN3edJTPs6vxyEAo?=
 =?us-ascii?Q?sxfctgsYKpHONuIIHMKyCOcE+CRbkoau3p8U0u3VZvVJGRcYwwCHXu3RK8JM?=
 =?us-ascii?Q?P1/u7SPQodkCLZOJfPLFmgJ31Ec7SsMZKVWTzmVStVYhSI2xfBbcxIW4Fhlo?=
 =?us-ascii?Q?jgdOQc8llv09QKqzSlDjQ/rSsWxho9iEiaTm8354cg15YNHze33wNE06RKxS?=
 =?us-ascii?Q?DpXXYqLi7QsTv661dDnxByus8Rxs5LnNBeB47Z/1YMjH0W4G7HwXlly1lWSy?=
 =?us-ascii?Q?D0JBDI5k0XzymkqIbrthLxVUs8VYA7FfdshT2hpFyt3jTcZz3OGWn1BSva/K?=
 =?us-ascii?Q?66LOCqeYoWWKuy5pd1Rjc3nkFyMdVQLxagKmwEapOfiPL/lvWjroMLNjgoE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3605f1b2-594d-4d42-d64c-08dbeafa16e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 01:26:45.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB4958
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Nov 21, 2023 at 09:12:12AM +0800, Inochi Amaoto wrote:
>>> Yo,
>>>
>>> On Sat, Nov 18, 2023 at 03:10:26PM +0800, Inochi Amaoto wrote:
>>>> The timer registers of aclint don't follow the clint layout and can
>>>> be mapped on any different offset. As sg2042 uses separated timer
>>>> and mswi for its clint, it should follow the aclint spec and have
>>>> separated registers.
>>>>
>>>> The previous patch introduced a new type of T-HEAD aclint timer which
>>>> has clint timer layout. Although it has the clint timer layout, it
>>>> should follow the aclint spec and uses the separated mtime and mtimecmp
>>>> regs. So a ABI change is needed to make the timer fit the aclint spec.
>>>>
>>>> To make T-HEAD aclint timer more closer to the aclint spec, use
>>>> regs-names to represent the mtimecmp register, which can avoid hack
>>>> for unsupport mtime register of T-HEAD aclint timer.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
>>>> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
>>>> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>>>> ---
>>>>  .../timer/thead,c900-aclint-mtimer.yaml       | 42 ++++++++++++++++++-
>>>>  1 file changed, 41 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>> index fbd235650e52..053488fb1286 100644
>>>> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>> @@ -17,7 +17,20 @@ properties:
>>>>        - const: thead,c900-aclint-mtimer
>>>>
>>>>    reg:
>>>> -    maxItems: 1
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - description: MTIME Registers
>>>> +          - description: MTIMECMP Registers
>>>> +      - items:
>>>> +          - description: MTIMECMP Registers
>>>> +
>>>> +  reg-names:
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: mtime
>>>> +          - const: mtimecmp
>>>> +      - items:
>>>> +          - const: mtimecmp
>>>>
>>>>    interrupts-extended:
>>>>      minItems: 1
>>>> @@ -28,8 +41,34 @@ additionalProperties: false
>>>>  required:
>>>>    - compatible
>>>>    - reg
>>>> +  - reg-names
>>>>    - interrupts-extended
>>>>
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: thead,c900-aclint-mtimer
>>>
>>> Is this being the c900 compatible correct? You mention in your commit
>>> message that this split is done on the sg2042, but the rule is applied
>>> here for any c900 series "aclint". Do we know if this is a sophgo
>>> specific thing (or even sg2042 specific), or if it applies generally?
>>>
>>
>> This can be confirmed. The thead c900 series have no mtime support and
>> there is no evidence that they will implement it. So I think it is OK
>> to applied this restriction for the whole c900 series.
>
>Okay, great.
>
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          items:
>>>> +            - description: MTIMECMP Registers
>>>> +        reg-names:
>>>> +          items:
>>>> +            - const: mtimecmp
>>>
>>>> +    else:
>>>> +      properties:
>>>> +        reg:
>>>> +          items:
>>>> +            - description: MTIME Registers
>>>> +            - description: MTIMECMP Registers
>>>> +        reg-names:
>>>> +          items:
>>>> +            - const: mtime
>>>> +            - const: mtimecmp
>>>
>>> If it applies generally, I would probably just delete this, but unless
>>> someone can confirm this to be general, I'd probably leave the else
>>> clause and swap for the specific sg2042 compatible above.
>>>
>>
>> I suggest keeping this. By taking your advice, this binding has actually
>> become the binding for aclint draft.
>
>Right. It seemed to me from the reports (and the commit message) that this
>was a configuration choice made by sophgo for the IP.
>

Yes, that's true.

>> So I think it is better to preserve
>> this path, otherwise adding the mtime register seems meaningless.
>
>Yeah, I mistakenly thought that there were cases where we actually had
>systems with mtime and mtimecmp registers. I don't know if that was an
>assumption I made due to previous commit messages or from reading the
>opensbi threads, but clearly that is not the case.
>
>> But if
>> you think it is OK to add this when adding new compatible or converting it
>> to a generic binding.
>
>I'm a bit conflicted. Since this is c900 specific one part of me says
>leave it with only one "reg" entry as that is what the only hardware
>actually has & add "reg-names" to make lives easier when someone else
>implements the unratified spec (or it gets ratified for some reason).
>

Adding "reg-names" is necessary and does make live easier. It gives a
clear way to avoid hack on skipping mtime register in the ACLINT timer
definition.

Now I think the only problem is whether the "mtime" register should
exist in this binding. IMHO, adding "mtime" seems to be too much to
keep this binding vendor specific. It is better to remove it to achieve
minimum change.

>> Feel free to remove it.
>
>I might've applied the other binding as it was in a series adding
>initial support for the SoC, but usually these things go via the
>subsystem maintainers with a DT maintainer ack/review.
>

Thanks, I will also wait for feedback from the subsystem maintainers.
