Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E277F22EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjKUBLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKUBLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:11:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2109.outbound.protection.outlook.com [40.92.23.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6091;
        Mon, 20 Nov 2023 17:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT52z2gjrLYNs/6ylnHbbGCQFKRJyx7Jux5N29+M/DiKqkTTX30gIVMloOTZGRHXjQC9mmKdL0E43oRuI8KHvnvhOxxBAM5t4OEWRogTDcwh260jevte1zfbzOjWwKrh06ODSB3D3RgRSpj2yZFyaevZ2WKoMYxYFMOZt1kaO1seYaXXE/aQzBHUgrv2ESlpCtLIPfS3evBQq0wr8sjSpBvjhFBk0270cNr1FRdvdp5MFgM3Du3FjTA56QH+oB/pbdi+57VBkQ954khp2D0teFjxYlClCxi0Bugh4bbzO+VMRluoE7n/EzYVPCuSXGOkVrywDvw7HSfqnNGItk5Xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE6vTLMTycYZkEOX8nJkedvHnWo11AN0EIK9DL3cvaw=;
 b=cLMkmjm9hbKiSDPn2cFBQcUaBdqpcV7IZdaejQv66gwgIqvwKLsDqtfGYI5LVEhiWwSgGG5nVgSevDzk0FPEuK5LJ9qjIByiTrOvUwtqeRCjh4zCnIEiQSMtbGhK/U/T93HFbzeec9McZMVIEZpKE1gknCrzPXoBbNXG4Khb/YhU94w3ZCVFhchgCWyHjkQpAK4jb1GV5IawtrrpzJ3U7tYJV9qFOpeanDR+QsOzFxBD2J9ApXApGdnzapP5zXfQLPwvtFdWM6aFM4+AVNhrozt9uLJ5sjz5RJ2XA321kiyWTB9adr62P7trFX6jPVfMaxYDqyzAopGLwff0PpHwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE6vTLMTycYZkEOX8nJkedvHnWo11AN0EIK9DL3cvaw=;
 b=R7Zexsm1+oe2cUSlkn1QLUNOLuDOYOhHJDUtHdsS9k76MVgLxLosDL6TzvHXzvJfEIXtK/7PsCJ6v9dWkE3lizGm+k/4SY41NSBcSrO0RhB1WQPnzB8f2fB0GjfCcV7XGgaXJ+SiFDTOcozCvHobMyPGLtZuAP6Q63M0YJfGM9cDfTdrM9O3VG1y97izutQ55rZJjm/HYwrKcRX5I9IGr5heRCgkdGnpY0Bw1v/2eMZT9dQTz5Nb2fLCZ7aVbgGq7F1m9lS0bHP3th/NvlfLDZuREwCfKHabw+oDopf0ecoE9sOKWyKrpjoxBBw54zDT9+ujtaqxInU6igsorG1byg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB6984.namprd20.prod.outlook.com (2603:10b6:408:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 01:11:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 01:11:31 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
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
Date:   Tue, 21 Nov 2023 09:12:12 +0800
Message-ID: <IA1PR20MB4953D36ABE26822B62415500BBBBA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120-banshee-traverse-554723cd9490@spud>
References: <20231120-banshee-traverse-554723cd9490@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [8yZbIqVQVrk8zM0htbFr+EOt5V1vtkGVjzsAs9ApD5E=]
X-ClientProxiedBy: TY2PR0101CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231121011212.44318-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: bb01f040-386a-473b-8232-08dbea2ecb95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Su6JpApkB1+3onQbaZz8yUQ0uJpW1jQ4ESiNsf1UyU11uZctuZDs5TYFQa5pytiqpkRdxUdARn7PhmaLjOLKrp/4yrh3clar+ljh/mB6PWPQ/DLjX3sON8gHfgfWjUu8DtHrXtb25YRqhKwrymJMWunimTPndqJG0H6EW3IVUSTw3QXSohzARVosrtkHqejP6rA/SIwoa+9wt2YsNBD4MgJ3/0C6BmX9ECclJsSj1hO0c/wbtAHIqSMs33qHM0Lv/SNLOzUyTokYXo/OV8ogcL+gn7Wh/zwA/BXq6mc2O9q8JVcZ8QMHOoSkRumZcpsaAA6W6XCgVyv/ctDc3L0SOHhgNXu/mciybdLVvbY00WjWnsXaE40cAQav1M2rgckzX7JxGehDmJXhWGaB483LNPXBIkzJtm/xZqSXsbnR32gKHsHLkegtOmAytSKadhUf3UIR61zTSdST0EcZ5uCH4UC+xKZo8rbVXdneNeJMVYcK4z0rk9uCY9KC2mAVmIwA9OPn2Uuvv1gDZ78UNAlZrSAS7rthq8EjNsE+zfRC8KPpYjxug5u0ikVZV4kyysyjusMrUJjz7y6jVlao/zXbtFdk3OSVXuOqgzvPcfMxI+YttyyqVWtNPU62pBiIHKAej7CikCEIaS5EsP0zRSuPiFt+lVCHGkNT6Fssek6hhN4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MR3fbXsiFxMEBN7I9AlxHKmXKKoXGs68Gmko6Y5SlKyK9mT7dSDI/n98WTCd?=
 =?us-ascii?Q?DO9PmzXrjQoTGw3OmzFgZ45WDekm++tGevtxsg3lBKY60kiXt6OkEvzw/E/S?=
 =?us-ascii?Q?7SAJnRGumQEWGE00CbIEyn6xBRJVWQ2Rc4uI14l3AYuYCZCLZ5ZoKsj5/2kr?=
 =?us-ascii?Q?8h+spMO4Yu4psNaSakVQ+CnDygaR+GdoqBex/8rZPvYE1pjn7z6JNhMLxCM8?=
 =?us-ascii?Q?fyIww42EF8LDCyOGRTdkb4c1p8uWd9OfMrYMcQ32W7HtTZ3Rai1whedTBrbU?=
 =?us-ascii?Q?rmKpGPcn35GZD6x/RnO/DXz6TO1PNnporiA1oj4hVveqTcpvc9heLzbSI7hp?=
 =?us-ascii?Q?8C6yCuroJ/q7D0O36aCzijnEd1bDCjnDQmOGiAgscEXtxVPkKV79pYwkazpr?=
 =?us-ascii?Q?lsNk/FMA8SbfZtlaF60LpBFLW10PxYGH5rMjLiLVtvtceI2aepi3ItNO9P2u?=
 =?us-ascii?Q?5FlSZO/xkX9hG6Off5fTZTZbwVmTXIwySlzJEiLhBrBXTpeEQ2ryLLKGeboh?=
 =?us-ascii?Q?2NgAHA+A3HvWGWXZjYYCEK5I2PVRemfH4DC6SOqGKfv9tIJdJAawL+hAd3va?=
 =?us-ascii?Q?bTeMeYQn5kYC3hs5PsxT5FwhMlB2WKz2O5Ur/YFb5V/8RgpATuQWoY8cQQg+?=
 =?us-ascii?Q?uTZGiN17p8lo+tckDZ8xtHoRJ/dXIaDBIrXStyk8EyWlgZbDMiQXYE2Nu+MO?=
 =?us-ascii?Q?n0Ny+GW8M2JhDHNYuBmhE+AezTRFAQBwHbFcVuwf5JfVq4hZDAnt4Xwcp7Mq?=
 =?us-ascii?Q?zriGMr/bqpNYl4OncdBMeI+DzIhvBB5Ic1F1wmPwmCR23YFS9t5piQXh4Z4R?=
 =?us-ascii?Q?witvc8+XcaOqx0qSW/1wdHj0K+QRy7iuUnHzFdU6MDIwNVrewbqF86jCoMWK?=
 =?us-ascii?Q?PFLkGW9UsHzakyseS+Ci+iDrPSNuny2T5tNUkakWnj8OGfirbVMqtmMd9yfJ?=
 =?us-ascii?Q?b+1KnQKNX6tf8Zn1yxKCBKKZJQGuDgEK+4Ne8vjZpTJYHo81oto2gn7zl/K3?=
 =?us-ascii?Q?dgNzJvyb2Y/wH/CrWiRnYoAfegz7NDFjZq+DOCDmeCCh5MdgdUtywZjJJx9x?=
 =?us-ascii?Q?S8eZzUwkNwwf0SMP5oZGEBEtRS1Dyuv2XOeXlsJZgSHKiaIiIcxI6UJezSlf?=
 =?us-ascii?Q?JmeyNnu92R0j03cV3uyfGfN7O2wjHELyTNb+G+5W0eIjjjDDbZagnatzCq1Y?=
 =?us-ascii?Q?EufW4DJ6ug50hJjemg7MqOSPE321zPXebS/0R362RMvjgfnSGlnbWJNT7Ak?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb01f040-386a-473b-8232-08dbea2ecb95
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 01:11:31.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB6984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Yo,
>
>On Sat, Nov 18, 2023 at 03:10:26PM +0800, Inochi Amaoto wrote:
>> The timer registers of aclint don't follow the clint layout and can
>> be mapped on any different offset. As sg2042 uses separated timer
>> and mswi for its clint, it should follow the aclint spec and have
>> separated registers.
>>
>> The previous patch introduced a new type of T-HEAD aclint timer which
>> has clint timer layout. Although it has the clint timer layout, it
>> should follow the aclint spec and uses the separated mtime and mtimecmp
>> regs. So a ABI change is needed to make the timer fit the aclint spec.
>>
>> To make T-HEAD aclint timer more closer to the aclint spec, use
>> regs-names to represent the mtimecmp register, which can avoid hack
>> for unsupport mtime register of T-HEAD aclint timer.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
>> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
>> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>> ---
>>  .../timer/thead,c900-aclint-mtimer.yaml       | 42 ++++++++++++++++++-
>>  1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>> index fbd235650e52..053488fb1286 100644
>> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>> @@ -17,7 +17,20 @@ properties:
>>        - const: thead,c900-aclint-mtimer
>>
>>    reg:
>> -    maxItems: 1
>> +    oneOf:
>> +      - items:
>> +          - description: MTIME Registers
>> +          - description: MTIMECMP Registers
>> +      - items:
>> +          - description: MTIMECMP Registers
>> +
>> +  reg-names:
>> +    oneOf:
>> +      - items:
>> +          - const: mtime
>> +          - const: mtimecmp
>> +      - items:
>> +          - const: mtimecmp
>>
>>    interrupts-extended:
>>      minItems: 1
>> @@ -28,8 +41,34 @@ additionalProperties: false
>>  required:
>>    - compatible
>>    - reg
>> +  - reg-names
>>    - interrupts-extended
>>
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: thead,c900-aclint-mtimer
>
>Is this being the c900 compatible correct? You mention in your commit
>message that this split is done on the sg2042, but the rule is applied
>here for any c900 series "aclint". Do we know if this is a sophgo
>specific thing (or even sg2042 specific), or if it applies generally?
>

This can be confirmed. The thead c900 series have no mtime support and
there is no evidence that they will implement it. So I think it is OK
to applied this restriction for the whole c900 series.

>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: MTIMECMP Registers
>> +        reg-names:
>> +          items:
>> +            - const: mtimecmp
>
>> +    else:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: MTIME Registers
>> +            - description: MTIMECMP Registers
>> +        reg-names:
>> +          items:
>> +            - const: mtime
>> +            - const: mtimecmp
>
>If it applies generally, I would probably just delete this, but unless
>someone can confirm this to be general, I'd probably leave the else
>clause and swap for the specific sg2042 compatible above.
>

I suggest keeping this. By taking your advice, this binding has actually
become the binding for aclint draft. So I think it is better to preserve
this path, otherwise adding the mtime register seems meaningless. But if
you think it is OK to add this when adding new compatible or converting it
to a generic binding. Feel free to remove it.

>Otherwise, this looks like a better fix than you had proposed before :)
>

Thanks.

>Thanks,
>Conor.
>
>
