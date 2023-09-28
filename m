Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E677B1013
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjI1Aex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Aew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:34:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2091.outbound.protection.outlook.com [40.92.40.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F468BF;
        Wed, 27 Sep 2023 17:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqphrEeZMHuXCBFSmZvapu2TyO/I6ivzbc0C2nZDYLm3UxiAbzRqzG4h2kreQmFlu6cPJWFS4hEdtyYgARjTCL50WHE+aa8296NE6dxQH43ZReMVAUS/p3GPqndjGvfYZ4zEtYTOSvnw5RQHAwGZAkgM7sMAsD1Hua7DliQfi++NlPlP4Z6haJfmi+yN+Qf43XIX+tio7LeRRlYykLt487jM/RkqXT7EBH/yLncyzOoADiqagi3nwZY7uqk4ohd1XLl77xfTlNwi9tc4c9EtZ1iqE3a4+sSHtVLh3gHu8SKSWqQUAFi9KKQAsvSnuFcigTfqqXN3bTr07Alh0h0v0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk6uotVC+CFzBXiqmhSXjzvTEAkppreayMTjAU2iE7c=;
 b=hj+fiVPWz7YOolFD+0viMg77wlfMUsEpTplfbumA4XjXNKadKcJTZR/bIiDF4DULar4RCkQ2veFHPHYp6xInj13i+iEmbY6CarsmPhW1ywHH3uun5/9gTEggMpRqy4kgzU+io30YSs9TH9BxX9gtBrBwI26r1jaO2vkK4vEXkBUOQLNks5mObHyx95zRWG3m3lxQ63XfvUDGwL6ElH0YE3H7z3Qz7ZTwN6DEtoBMG37N1mjrkl8XM0B6RY62bKXlHk66NATlbt0qqpDzRrDm1sIT1URflfWurWkvaMfUBXHQqulF8r6wINbWc8PuWDMGvVUxKZV5mB29NAyLwsJrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk6uotVC+CFzBXiqmhSXjzvTEAkppreayMTjAU2iE7c=;
 b=AUmfe0zwjmBEWPRO5bg9YLBJWP9GaJY014vDMswufUyF+GW1tnF03uontvSlTByC1Dq04tdb+Th93T4O9nXkUlKLD4G78kn3U04909vPaP59QcSHpnWhFQdUMN1drvmxDCpxpuqSoc7tRkHrybFi70nuSYP8b0xE/7zZTDnWm0YUcIDLJNs3Yhp24lP21ZsMOsW+pP4x6enzixKC/uEhsGUdDCIZnhrnZ8pb/2Ny9Nfb20IbgvMX6W6V32y+0AucQ5Z0lC3r4cse9T4YHz+vWkTCTesgfWPIB8nTnTXcaO2eVxJkJa0YQZeI0cK3iuqaDofbCPvB+U6j024ygXCTFA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5139.namprd20.prod.outlook.com (2603:10b6:806:271::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 28 Sep
 2023 00:34:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 00:34:47 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Anup Patel <apatel@ventanamicro.com>,
        Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: timer: Add Sophgo sg2042 CLINT timer
Date:   Thu, 28 Sep 2023 08:34:42 +0800
Message-ID: <IA1PR20MB49534EDF586FCC784C81C5ABBBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927-uncorrupt-bronco-72e35232b1cc@spud>
References: <20230927-uncorrupt-bronco-72e35232b1cc@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [s4GznsRWndDRLMihdOhiXh6eCWukxJnHkqftgG7LaDM=]
X-ClientProxiedBy: TYAPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230928003442.56637-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b09f5ab-f577-4287-d8fb-08dbbfbab777
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vFQ8Ruo73HfDyl6FpeOxYMv7cbLOFKrsuryXzUnFR14t1PMRwpM95aW/IsdIMHRzcjY9MXpb6VSt0Gczl7xs4G3Kzl+70ruSUhjGJFzTPoxa/LyTx7VGN9Tr4t8Q/YR56nKWXRxmVbLtWlFSARDfbQhD35cQ7mfulnJ41fxV2IEUFyhaE6x2scI452UmOueAsioDgN/2MqpTKqMy5Ikd1FhvHmEpaRA9LYaQ/yso6VmPqTDv6B3erpcyUn0+s6THDpA79JiZ9mOVOkCY1kNhVwNNBbVdJ+GI7zJpEu3QdQm8iWqWO9SJ1u7GnO+mCHBtihnXcXBlNqHVS87JL4WICR+DClAVbVwxowTBl9GUc0wvBoy1w/zb1oyXyNFgiVdNSSgUtRqc82hXlOrMC0Fwp4QnPhxV13tRg7KpPlqi3CuFsMB1UXPFKPhROjnMCC41MLHBs44bI2CUS3FM15mk5Ardx31XnppYceOw/ejL3Xi/Z80tOV6hmLMZX4lzvaNbyhLMiVmU0g5pZFq1T5NzpWEc5VNCGCUTsuUo6pvFWCv58CUi47L6mF3BnsoBjP4uGQMW4yCaVlr9RQGfbTUwrN5Fdq7JJ0r/FAq3vT2nAIm0KmXQyscNMIIqxHz4HWQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzjoF62WZuH/iHu9tKWXtFSL86SzES0qFuokWyEd8NDohr0OH3YGhHF7/eQW?=
 =?us-ascii?Q?HzuBky+skxgE+xDki9Aj58D80g4Ngoh63KJYu7963f7UPv0W2/3kuMTpjpAq?=
 =?us-ascii?Q?JCdr/XZ7i0GMV24C1fHH37l+uO5Crx5sR5abXypP50qJ2VzYLo1Uxdd2KfDe?=
 =?us-ascii?Q?DPE2OqlaY0gClu/2KPI+TJKEvugAE9VwHAqWvf3jyhwyph0JXrZylW8QnE/i?=
 =?us-ascii?Q?kIRRuA3h76PJ3rNnn+0C2XdaU0FwVlTZTuibM7UfSNK4zGcp5aVdGIJGKJYf?=
 =?us-ascii?Q?DjkIBAHW4i3+IT+jVu0LrIzDTR9dHlKAX66E25UaFjypnsfMpH7Gt5WsEAqz?=
 =?us-ascii?Q?jP54XPRuV+hokXVuwY1jEbTlnCyoKUyv7SXT+o8nooe9eiyEkiqAcCKY6EIq?=
 =?us-ascii?Q?V/ZNoSNu2mbKLEBOjo5lmuyhJJOdr/d5bIaLQq+ASiA1oTkyDbeFxMIQTGbB?=
 =?us-ascii?Q?S17nrmDVSoEEyLZwePlzL3pTGAIwTfgWtYtUH9d+ols97gFyzHtMWfujVIzw?=
 =?us-ascii?Q?sLFoTmEMdp40cN4eKoeGIuWWywFuHkcHwsm9bJz7jsNl4UDTXEky9SHoLVV4?=
 =?us-ascii?Q?xjypsKceDCamBojvj3wxNN+KH2e4cTCjUq2yfSqhFM34N87txm0zHPM1VWY3?=
 =?us-ascii?Q?lelkgcxElTw1jxzO1+aYGxxOwwIiteDIxRNGS5H1Zy0MOVFLrBhfyZzVhSQH?=
 =?us-ascii?Q?R+wYed7XRhPyh+0IOaRMMmSmdln65WeMdB7CYJdqATSBsXd0lOGV5hbX333V?=
 =?us-ascii?Q?GCL/EaGYa06kQOJDiFTOTUQ48VDcBSVo1B+RzBClwmM7Mrbq2xdShMoJSfQ9?=
 =?us-ascii?Q?egyrgyq1XWndeXAbwjohar0HNNGmQ0N92/9SpjbkVbsQN97IckyKme9I2wHs?=
 =?us-ascii?Q?G2iRROVz1gLLqcAHoDSE4/ogw/9sLDXmxW9Vgf5nKG1MwUThZF4DPiy2/rKx?=
 =?us-ascii?Q?WuQOo4GDbsVRUVtC9XGNrVjMKMVr1gSPRBLyL9li3ZE7/47J4x3feAyZ0z9d?=
 =?us-ascii?Q?li5GujxQlyvgn+pHA/EiGV1q8L5RPcLdzpNIjplFLFdULNdxZ+uw6jcc5JPU?=
 =?us-ascii?Q?e3AgMBg+dHADqmiUGtkGwqOY5JOpvH/jr7rkL1cxvCmokFGun6YkUJSBqQ57?=
 =?us-ascii?Q?s0Muobn9vBd+mXqlcyqiTSjRP0RHc5QCRJXxLQMHpaiIE2glhlcH+zxG+YyZ?=
 =?us-ascii?Q?IONPnZ6Nwn8pObhHm6yhJ9WI6V5t11N4YMIbuT/irX7G6nFu7wbtDyf1t0A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09f5ab-f577-4287-d8fb-08dbbfbab777
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 00:34:46.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hey,
>
>On Wed, Sep 27, 2023 at 05:01:37PM +0800, Chen Wang wrote:
>> From: Inochi Amaoto <inochiama@outlook.com>
>>
>> The clint of Sophgo sg2042 is incompatible with the standard sifive
>> clint, as the timer and ipi device on the different address, and can
>> not be handled by the sifive,clint DT.
>>
>> In addition, the timers of sg2042 are mapped by per cluster, which is
>> hard to merge with its ipi device.
>
>I think the description here is kinda poor, it needs to be explained
>that this is an implementation of the not frozen & likely abandoned
>aclint spec.
>

Thanks, I will explain this.

>> To avoid conficts caused by using the same clint compatible string when
>> this device is parsed by SBI, add a new vendor specific compatible string
>> to identify the timer of sg2042 soc.
>
>And this whole section about avoiding conflicts is not relevant, since
>the binding is specifically for the timer. It'd be better to mention why
>a single compatible cannot work for all elements, than bring up a
>situation that does not exist and would be a misuse of the binding in
>the first place.
>

Thanks

>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
>> Signed-off-by: Chen Wang <unicornxw@gmail.com>
>
>You only need to sign this off once. The iscas one looks like it
>probably is the relevant signoff?
>
>> ---
>>  .../timer/sophgo,sg2042-clint-mtimer.yaml     | 42 +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml b/Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
>> new file mode 100644
>> index 000000000000..5da0947d048a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/timer/sophgo,sg2042-clint-mtimer.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo CLINT Timer
>> +
>> +maintainers:
>> +  - Inochi Amaoto <inochiama@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: sophgo,sg2042-clint-mtimer
>
>There's only one of these, so you don't need the oneOf.

Thanks

>Also, is the clint here not a thead IP? In which case, you need to add a

Yes, The clint is a thead IP, like that of th1520 and allwinner D1.

>second compatible IMO. That second compatible then would be the one that
>appears in opensbi etc.
>

As this is a thead IP, maybe use thead,c900-clint-mtimer is fine?
If so, whether we should replace the "thead,c900-clint" with these separate
DT to describe the thead clint? The DT binding said the thead clint is not
compatible with the sifive clint, so maybe this is a chance to just move
them out.

>Otherwise, this looks fine.
>
>Thanks,
>Conor.
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts-extended:
>> +    minItems: 1
>> +    maxItems: 4095
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts-extended
>> +
>> +examples:
>> +  - |
>> +    timer@ac000000 {
>> +      compatible = "sophgo,sg2042-clint-mtimer";
>> +      interrupts-extended = <&cpu1intc 7>,
>> +                            <&cpu2intc 7>,
>> +                            <&cpu3intc 7>,
>> +                            <&cpu4intc 7>;
>> +      reg = <0xac000000 0x00010000>;
>> +    };
>> +...
>> --
>> 2.25.1
>>
>
