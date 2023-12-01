Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EE28000B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376893AbjLAA6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjLAA5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2102.outbound.protection.outlook.com [40.92.40.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79931732;
        Thu, 30 Nov 2023 16:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY1ZafehY69bv3gXgzXM/4iNAc1uWbq0HEGcdSejE5qXFBD+r7flbLX+lN2V92lVzCWhE6Nlm2sx+97+HUepMOidZ4gni0GLKqy2KQ0nYmHUrigpxSJNf8dIbvq2mNd0xyXjrnWdhkrM5sxZK8Mqcm53N0hS7KwyIlg4w04g3+TH+3r9k0VI6mbRB7P3gZkLRfsOPGoAXhn6NLxzRURs4z/lQ39iF9S2QjGIj4jH8iS6a6yVBeG5J0FNl56pM5IYR+VUIjR3SyxNj5FLu/hwsyHOxsVVbDnwFCkglNxZiee6SalqNakS7WnPd4WjrUSY1MWObDz8hBd8Xxf+FnthTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E1XYGOGlifzSJz1VP2C1JHbhRqD3q/E/K5wrzstpSY=;
 b=kstq06EoVs/+oy2nHi2ey/Xb4YsxFUSjIv88tMoEKvXLikWOiddYR465p7U/S1Doz6v1YlaGyY/BSTfUb/rVjX8wFqU39xBbBtpKZFB51aQDovSEckA6Ju2aLb7X4U0tvBmEXTFbn6/p/1nm1t9ruavOcYgn/HVo6Ut0OOxPWcucPPlZwJiiVFG1WYQISnHaqJA7NDSqGGLGFpBalySltYyr3F+mvm4jIoYCco2v1BRB50DivCjUzmWc6RDZd7/jMkqmT27M2xYuvS0M46cASx4tf2D6OpsKg/ZXJJp2P1X7B51IMqIHWuKmP0Fg888KnE5LHu1lE4IakQ3/h25HDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E1XYGOGlifzSJz1VP2C1JHbhRqD3q/E/K5wrzstpSY=;
 b=OjzS6ZG1d1MfGLYllX1bO0hT+gN9wK0nmMfRmZeIcfFc4kgjE02pIBv+i1Rvq1O8iUOQejioVm/RTm2HgqDoFLVCnOIE4mJStRPoiU8kC8xiv7zaSQPnDuaPiRWNziDC6R66WulMkeDiJGCeELMxG2H7KO+6YxOLm2Mcod2/TLelvtjBFsZeo+1B6xxzbkZ2B/u5fB6LeS4wlkknARlppgqsI2gMWuMDoIu+her5o2cj7gMMFkk66kiiNxq/m3sDvrOclLAtEM4ydCNVnPRBiVgi0jKujRcnJvAbfhV5VDkYOA9KwoBsWwZpbqJFOTjH6aRZVvM39gBctFUC71ES4g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB6735.namprd20.prod.outlook.com (2603:10b6:610:173::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:57:43 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 00:57:43 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Yu-Chien Peter Lin <peterlin@andestech.com>,
        Guo Ren <guoren@kernel.org>, acme@kernel.org,
        adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
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
Date:   Fri,  1 Dec 2023 08:57:34 +0800
Message-ID: <IA1PR20MB4953376542AAC1DFC54C2E02BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201-hatchback-lustily-a516298c3556@spud>
References: <20231201-hatchback-lustily-a516298c3556@spud>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TMN:  [PkdI8r2rHLpMmeUCObfb0Fs3IyMK0w2bxdJ2jMqicJ4=]
X-ClientProxiedBy: TYCPR01CA0022.jpnprd01.prod.outlook.com (2603:1096:405::34)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231201005740.57990-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: b34da03f-0b62-43bb-cee8-08dbf2088639
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCtCw6XP3+TQFl2EqihZCF9QGBjJbzVYxoqWm8jc6nil94b+Y1vsIi56yJT1vTGeHzjFXfQeQncDc/mNg72Ng0avYJK25FOfx7A5A6XGOMOulGXD94myPPtRPfnhyYROyFvGzUSMM4C/MaYkUjpkJqNJ2ZOMa9uwGvqjhjoToBsk0heYqfY3ySZygRo5slg6x36kOtRDLN6Pjo0ThHX7ggx/KFxVzaI4Bmd7PysCIiGyAEfxqNrllpjLfkpECUeMHxlpOCZwS9G/GjnUo9n1eqddeeazJ8e8ZDFBqYJsBvj22zYJns1UrnPaZAb1EvKPj0WMIrZ+cn++UBYuk+A8h7RvJJFdbzn3zRbQ5wJoVoJtGNPQ8wehn6nlmMT66iuYFud2RW3f7AeroqfEFhOeJ9fKCkn3MX0ZD142FM+zXoBZufZIUFDAwoNMXzoBhmCu6vTtEXO3rvCtnR40fqYDWhSuORLwf1YM9rqZJDoEqI//oFBIOKOfc16+lKcNMNq2y2Go7VbkynwOOeuaDgzue42Ip9PAKsB5Lk6PBfhnTP6kQvApnhfUKJizg06kYCXiVyBUmWXgYz0fhxcwyTQ43nN3rAKqXOa80qvyfWEI5Sizx6DBGJKX3YVkiqGawcThqxkmvjStGlR5R/W3ioq2yysAStiRzXpQyXp2EN2OhW8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfzIb1J79JyOa+3i401WeK6y5++WRhkERZZo5Jaoiw/EL6Yj9eOx/WKGAm5t?=
 =?us-ascii?Q?iUPMhjG+0dL7jjwhi+46RFloaohyoncaJ+JVaRmWGqId6Kfnt0ddlQkN9rtc?=
 =?us-ascii?Q?Pm9Low+a95VxSrm163NdH2fTyn1rHJLobDtJb/Uj6UVCJ9eXZWhC7lAWuJnx?=
 =?us-ascii?Q?0BAZ5arEHIGnPJ4QRcxZZlEUrjhoBhz5l7mj3dsk50elk9JXRnHudt1o8XNU?=
 =?us-ascii?Q?YQeS7UbWBHrO1qtk/TgaKlrdEXJVu1lS+feloCKSaykIv7wjB6Psahn9Rg32?=
 =?us-ascii?Q?bart7GfC0LkMABbqH86b5EwJ152GRz1N69tpFqx5eEh8jgLMaY+xtNAn5gYk?=
 =?us-ascii?Q?2Aeir0HYxf2vjfPJML9Blnyzz/mVDTfnP3X4x1GSAzdgi9Ey/dGjJNu1TEtY?=
 =?us-ascii?Q?A2c8fLMrcYmdFbsvVXMEvJ/P0ueqEvVrjMwAaGGiPqXHO48hxcoPaIY2RY+w?=
 =?us-ascii?Q?ZxxOAdKt7WiAWMPhC4iQFBv4NNfLn9N7o0/MbMU6ducvbfjhciSM/uFv9f2a?=
 =?us-ascii?Q?qf0dWuwAQy+L4U93ZtIhrRB2qhVagaXnoOYKyzOg9InXPGWFTFyn2KVu3nxt?=
 =?us-ascii?Q?lPzGRbrJ7lIkmF/yw1tZJsOrCGLfcat8iL6ZegUOD7PqREblMp0rWY8yoWVQ?=
 =?us-ascii?Q?tVAlgjaxykPxUxeHI/kFP8Zh2o//qQber+VKKn/6Vx8ONpze/PGPEdGvNns2?=
 =?us-ascii?Q?weRDBcICkb2DMb3WWKQCMT8S2m8ET6gV1WTogfdVcPr5wntYOq9XPVGhwQDD?=
 =?us-ascii?Q?SC9u0/l9fDp/LRA50zgvNlE2oGS6KSENF5amSrioR7Ilmo/JBB6+1f0y713y?=
 =?us-ascii?Q?3FDWkrwTraqRPCfCaoPXoxlcuGhT2uwnMjYstirFL3l1aJqqoVQzokWJnqHn?=
 =?us-ascii?Q?y+vGmH6D3Z4cZdNTx0/xwfNCQFfl9ym6uJHqDCavjI0Bu56YPvliutVFTyUk?=
 =?us-ascii?Q?brtzQN+gk1hRbRnMocNIeSl3VNzkOsqzdUN6GQHoGubIeJ3R7v4FiMTPjE3r?=
 =?us-ascii?Q?jep9gpgHz4rudhXw8+u9WYcYrO2k/Hga2mVVvdaQCvA5zCyWyKdB62VacZ+m?=
 =?us-ascii?Q?C5+coSBWEFQAM2bo6bo1VfYxel36vLYYChlMgAnP99sSFn33vooPg6yxjWh3?=
 =?us-ascii?Q?4d5Jz2bCuO4K++uwFjIQlr78A3dQL79tQs/84ZrNCcNTsN+2x1AzZFs5rH2k?=
 =?us-ascii?Q?IDOtKYmqP7rYNeDUfiqwH3XhR07iwiopMEjeIh0zo6tptrrW+JqoRAAD+pc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34da03f-0b62-43bb-cee8-08dbf2088639
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:43.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6735
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
>On Fri, Dec 01, 2023 at 07:11:31AM +0800, Inochi Amaoto wrote:
>>>
>>> On Thu, Nov 30, 2023 at 08:16:38PM +0800, Inochi Amaoto wrote:
>>>>>
>>>>> Hi Inochi,
>>>>>
>>>>> On Thu, Nov 30, 2023 at 04:29:22PM +0800, Inochi Amaoto wrote:
>>>>>>>
>>>>>>> Hi Guo Ren,
>>>>>>>
>>>>>>> On Thu, Nov 23, 2023 at 05:14:30AM +0800, Guo Ren wrote:
>>>>>>>> On Wed, Nov 22, 2023 at 8:17 PM Yu Chien Peter Lin
>>>>>>>> <peterlin@andestech.com> wrote:
>>>>>>>>>
>>>>>>>>> Document the ISA string for T-Head performance monitor extension
>>>>>>>>> which provides counter overflow interrupt mechanism.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
>>>>>>>>> ---
>>>>>>>>> Changes v2 -> v3:
>>>>>>>>>   - New patch
>>>>>>>>> Changes v3 -> v4:
>>>>>>>>>   - No change
>>>>>>>>> ---
>>>>>>>>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>>>>>> index c91ab0e46648..694efaea8fce 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>>>>>> @@ -258,5 +258,11 @@ properties:
>>>>>>>>>              in commit 2e5236 ("Ztso is now ratified.") of the
>>>>>>>>>              riscv-isa-manual.
>>>>>>>>>
>>>>>>>>> +        - const: xtheadpmu
>>>>>>>>> +          description:
>>>>>>>>> +            The T-Head performance monitor extension for counter overflow. For more
>>>>>>>>> +            details, see the chapter 12 in the Xuantie C906 user manual.
>>>>>>>>> +            https://github.com/T-head-Semi/openc906/tree/main/doc
>>>>>>>>> +
>>>>>>>>>  additionalProperties: true
>>>>>>>>>  ...
>>>>>>>>> --
>>>>>>>>> 2.34.1
>>>>>>>>>
>>>>>>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>>>>>>
>>>>>>> Thanks for the review.
>>>>>>> Would you share document about T-Head PMU?
>>>>>>>
>>>>>>
>>>>>> Hi, Peter Lin:
>>>>>>
>>>>>> You can use the following two document to get all events:
>>>>>> https://github.com/T-head-Semi/openc906/tree/main/doc
>>>>>> https://github.com/T-head-Semi/openc910/tree/main/doc
>>>>>>
>>>>>> There are also some RTL code can describe these events:
>>>>>> https://github.com/T-head-Semi/openc910/blob/e0c4ad8ec7f8c70f649d826ebd6c949086453272/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v#L1123
>>>>>> https://github.com/T-head-Semi/openc906/blob/af5614d72de7e5a4b8609c427d2e20af1deb21c4/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L543
>>>>>>
>>>>>> The perf events json can also be used as document, this is already
>>>>>> applied (with more detailed explanation):
>>>>>> https://lore.kernel.org/all/IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com/
>>>>>
>>>>> Thanks for reaching out!
>>>>> The updated description will be:
>>>>>
>>>>> - const: xtheadpmu
>>>>>  description:
>>>>>    The T-Head performance monitor extension for counter overflow, as ratified
>>>>>    in commit bd9206 ("Initial commit") of Xuantie C906 user manual.
>>>>>    https://github.com/T-head-Semi/openc906/tree/main/doc
>>>>>
>>>>> Is it OK with you?
>>>>>
>>>>
>>>> I suggest using perf event json as event description. The jsons provide
>>>> more detailed explanation for these events than the user manual.
>>>
>>> Does the "perf event json" describe the registers and interrupt behaviour?
>>>
>>
>> It does not. IIRC, the linux just uses SBI as perf driver backend. So
>> the registers and interrupt behaviour is primarily for SBI developer.
>
>Interrupts and registers are the reason that this patch (and the rest of
>the patchset) exists :)
>

Thanks, it seems I misunderstood something.

>> For registers and interrup detail, just reference the openc910 doc url
>> (https://github.com/T-head-Semi/openc910/tree/main/doc) and the T-HEAD
>> PMU driver in OpenSBI.
>
>The former, sure. But I will not accept driver implementations as the
>reference in this context.
>

OK, Let's drop it and left the document only.

>Thanks,
>Conor.
>
>
