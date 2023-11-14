Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C37EA88F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjKNCJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjKNCJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:09:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2068.outbound.protection.outlook.com [40.92.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EAFD48;
        Mon, 13 Nov 2023 18:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUBghjbF4Ur5Pabs+xlALWLjKmrtgU/eShG3C7uNt+Wzi2mJd1Tv0bwOvv/5UPzPX7BQp634fJNMPadtyTGQxxecd1azaHcBMET/taLMn3Bk5j5kzXEs6uEMHGe/m8oW8zGqkf017zJG1Y7wUK6lOva2FqC+mTTfrcOh2vlG0hi1Eav9h5T+Y9diIKNU6ssrGvjP1q2hpvGd15sT7ojLTSWIJsUWkILoB7pTq62mXDaxbDDPx7d1mHkSE1IpAPId3paBK38L6SocF3sNGAWc1ZuWyyExtyqRIoIwnmQ1R+RcGdCcJPINN+IAYzoNdIeoKE5Vydw82Jde64H8DPfV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2qwmDnFRypXNCpA/t4xjNRIo6v8khSI0FhOskWKppM=;
 b=VgsIrx7f1bsjB0E1gJYY7ckbzZ35nNTNOpFO+L0mTIN+sn9/JnV/5oq6ndfEn3dlz5d64kN1kRsj9pDogrLlT1E8ySdRKvyztx4Z4yHYIcWyueF0hRale17wVvFPKqTg9Dem5zkHodAvSYWFAhTRzwYWUd/KrtlTtA7/qOsU58/MOEYF+kwkGCNCaBSQbIOTtKEfTId/JdOmMh3GkNkODvGse+VkJDE9opMZwUd/5DoPWwAG7nwJbN7l8i5V0P+v6UaGu/b6IFp6w7984pF5SwrDZGwPuMkyAV421BIOe2xteq4Jldt/PxNtYYMXJOdP6BzROSVHflWaoV/PjpIT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2qwmDnFRypXNCpA/t4xjNRIo6v8khSI0FhOskWKppM=;
 b=AOEp/o2TUj0sSzhaqYHv/GQim0nExKoRuzmyB1QTNZ0b3hmmN0y13iUGXpcsHwZEScgzZnOOK0RDbXB+xUsbaI8+FZCzaLmPnvcht96eTwQPVPmFTbtRzlSRvfu3lxjyHH0LePK6kRAVO9/U7WOEn8jWRdXPRsOqNpP0er3UsN/QAxYifaLNjpOppjKC+GJgUFPZDqPeWYPRb3/MGJe6XDUpvbNKkGe5h04tj5lDiqsX7faU7Bfp8TsO38sEJTueFUBw4FD0WK9dfn42w6hXrGxc3VGM4Ppgt+v2jupz3T28PsaVj6qnHFryarbR39ugLquoF+DN67KtZr6XvD829w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB4711.namprd20.prod.outlook.com (2603:10b6:8:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 02:09:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 02:09:46 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chen Wang <unicorn_wang@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Tue, 14 Nov 2023 10:10:23 +0800
Message-ID: <IA1PR20MB49538FC509DCB6E100D29D9CBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB49531C1FCBAB0E19CAFE19DFBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49531C1FCBAB0E19CAFE19DFBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aDeOgO6AmmITkwnyRkKoEz2yLi7sMVcJuONfKkKQYts=]
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114021024.60271-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 43853bbf-81bc-4afd-5ac6-08dbe4b6c5d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMfqElp8IEf6lF45C6lbn4d+O8b8kdpikt34Ywu/IFZwr7s2MoRbP2VieuFbxoX9RgzSj5pxujc4wo8IMt/CAVv8f62mDA16isrvQ+78xaOCA8/ss2OqUh4T3ukneR6dfucjuvEeIGcYB5gOBzx9IxzOA7TrXdUU/Sqsux9pUsZ8qH7vxZEReiXg51ovkyUhWqRq2lZa7IOBxk78hl1CzD/HLbm9Tn+lsE29TbcMGtuwL5ML0/x0DB3S0aWG1gL04cD7FzogQgiDKOQ381rwYLSXHyxa5QPlDJvjKOe2DsQDNN7URbs/Se4PbUa1bgFYVp++Yfh/LJVkVsOz0QfJwAWxsW7qXTspkczxcgL8GYCGzQVXBBO2Pbb1OqhS/QkGYbCWwTm0750SRlhw1vw9yEkrkHFxaib/JKFKRKTIw9kDeWgCo+glZkho59lEkv/nunN6NHLaGJYuJpsPVtc8XDphVv+35qd+5wjOb4NBQ4Ks1RyDU6Dxrs7DAzpi8NY70PZMMIaDa+kl6Gbb83sZN0qBtc5frA8pv9xyYzgmXHEv27Ywz/nfJmPXbx9nbHM0OGTgMefbsvtimsyJWDH5aSlcTAQ/d8J1cxJxUnitWOo0dl0sU3hBibcFT4O4dYy9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCqDI6bQ2jAk5ZUuusvBmuPjCOvXF3fabHQ1zD7FKLWesZYB5reAqfemYPaf?=
 =?us-ascii?Q?iV6c0sVkx8P1cYKWf83G22fHzdasOcjFArLHCs4RE6l2DQoD0RhbNenUMzvh?=
 =?us-ascii?Q?oqmVR6OUzRwfKg2ELRR71fBdNj1+9EDOt4bXLetdNujr5nwB8sRe7DM7qryn?=
 =?us-ascii?Q?GLMSo9ILwjq4WzekJMTqQgWqy22eEQV759mbWuc8qY4ImQWsjHtQ2MouJjKM?=
 =?us-ascii?Q?ykVOcxnUiw8NUrlBDt+7lhsuYBJx+ulEgQ0aceYRhcytZw7h9vBPGceiN3Au?=
 =?us-ascii?Q?LYYi11FPwswCA4BEOpeBNFFaFz65EyxTC9AbVueg1rLxIb7UKbfHqh7usvsa?=
 =?us-ascii?Q?WbSoWO4eyet9IQJwhpfOVHaJtnURcGNSGK1MgtUGDY9zPIplCkRHSInNVb4q?=
 =?us-ascii?Q?rJjVYRkm0zwyOuA8azrAuCVnbXu5lIuyw2glEz8JxHfUaC2NWsw+FUlGVw3J?=
 =?us-ascii?Q?lNuWYkR7O1EQ9cxI6C2xGnJ7yfRaao5oEPPFBDys1AycF6i0j1SFDX9S3GZ2?=
 =?us-ascii?Q?slpBFFHo6oQz3nqoL0yCJT9DuobRMQJ0apxBbAd31lqCcg/rHmDZB8R3GFQ6?=
 =?us-ascii?Q?WsfWvWtbwXuF8OWIkeqg5umljVUyjXQ698kuGzum7bnHrRlfPN0pnnQr3Oir?=
 =?us-ascii?Q?EvW3ig6mVgnIrG7Q/H/mDh8WfQ4mlmoBxaZAdXCFivkZOuibdeHTYnTfY7N6?=
 =?us-ascii?Q?UHVEVN6JT6MAHNEYuIUp7ENKcb/pwp+1JdgvSvvTbfMPrqBKbfs5z74Dh4Ou?=
 =?us-ascii?Q?r727/5bg3AKT6boBTWgt4T4iezRVZkuSpF9W6yYfsjfFE9+nzNpbA//rvn1k?=
 =?us-ascii?Q?9Nv2I+Vh0NhIlaJCe/gicvh6RhHfdrHo87qyofRJMSoyKpUKp+4cIzy0NRlo?=
 =?us-ascii?Q?c7EYWX6nREup/JuXxx6Aph1uo5F8fHcAYblNZa5uRb+Wnl1gsZXsdNdRvxAy?=
 =?us-ascii?Q?wtAA5YSbed1NxAKW2weJ5pKFYAflIxgQonlc/lm0UWQTcoofrnle7Bhkgj1a?=
 =?us-ascii?Q?Jlob/OZYlKt/gywAdGhLtFzdJBWfDFszWtVl7n5agFchd0gj64upJyrGyEUs?=
 =?us-ascii?Q?TdX7c706XjzfFkVwMI3Lwyo6cyuHuGw9YS4XZPDelrq3OVdOqJw1aEWKhF6e?=
 =?us-ascii?Q?TBNb5JNDEwUJ7++DunGQ3T7b65apwwUQwOGSCa1GZkAJqafEl1npnisXT4FB?=
 =?us-ascii?Q?kuhaTHwwMq04mu0rTNMaWyCrM7SimhLTDqKZAAw1U4G2Y0SKt2/FWG4P0IA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43853bbf-81bc-4afd-5ac6-08dbe4b6c5d1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 02:09:45.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4711
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
>>On 2023/11/14 8:45, Inochi Amaoto wrote:
>>> Change the timer layout in the dtb to fit the format that needed by
>>> the SBI.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tree")
>>> ---
>>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
>>>   1 file changed, 48 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>> index 93256540d078..0b5d93b5c783 100644
>>> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
>>>                             <&cpu63_intc 3>;
>>>           };
>>>
>>> -        clint_mtimer0: timer@70ac000000 {
>>> +        clint_mtimer0: timer@70ac004000 {
>>
>>The address of timer register is changed,  and I guess it is another change not directly related to the topic of this patch.
>>
>>Can you please add some comments in the commit message?
>>
>
>As it needs to follow aclint format, the timer offset is applied to
>identify the actual timer. So there is a change.
>
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac004000 0x00000000 0x00000000>,
>>Why the length of first item is zero? Can you please add some clarification in commit message?
>
>I uses length zero to address that the mtimer is not supported, so the
>SBI can know there is no mtimer in the timer.
>

There is a misspell: mtimer -> mtime.

>>> +                  <0x00000070 0xac004000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu0_intc 7>,
>>>                             <&cpu1_intc 7>,
>>>                             <&cpu2_intc 7>,
>>>                             <&cpu3_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer1: timer@70ac010000 {
>>> +        clint_mtimer1: timer@70ac014000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac014000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac014000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu4_intc 7>,
>>>                             <&cpu5_intc 7>,
>>>                             <&cpu6_intc 7>,
>>>                             <&cpu7_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer2: timer@70ac020000 {
>>> +        clint_mtimer2: timer@70ac024000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac020000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac024000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac024000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu8_intc 7>,
>>>                             <&cpu9_intc 7>,
>>>                             <&cpu10_intc 7>,
>>>                             <&cpu11_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer3: timer@70ac030000 {
>>> +        clint_mtimer3: timer@70ac034000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac030000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac034000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac034000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu12_intc 7>,
>>>                             <&cpu13_intc 7>,
>>>                             <&cpu14_intc 7>,
>>>                             <&cpu15_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer4: timer@70ac040000 {
>>> +        clint_mtimer4: timer@70ac044000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac040000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac044000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac044000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu16_intc 7>,
>>>                             <&cpu17_intc 7>,
>>>                             <&cpu18_intc 7>,
>>>                             <&cpu19_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer5: timer@70ac050000 {
>>> +        clint_mtimer5: timer@70ac054000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac050000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac054000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac054000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu20_intc 7>,
>>>                             <&cpu21_intc 7>,
>>>                             <&cpu22_intc 7>,
>>>                             <&cpu23_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer6: timer@70ac060000 {
>>> +        clint_mtimer6: timer@70ac064000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac060000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac064000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac064000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu24_intc 7>,
>>>                             <&cpu25_intc 7>,
>>>                             <&cpu26_intc 7>,
>>>                             <&cpu27_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer7: timer@70ac070000 {
>>> +        clint_mtimer7: timer@70ac074000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac070000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac074000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac074000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu28_intc 7>,
>>>                             <&cpu29_intc 7>,
>>>                             <&cpu30_intc 7>,
>>>                             <&cpu31_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer8: timer@70ac080000 {
>>> +        clint_mtimer8: timer@70ac084000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac080000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac084000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac084000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu32_intc 7>,
>>>                             <&cpu33_intc 7>,
>>>                             <&cpu34_intc 7>,
>>>                             <&cpu35_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer9: timer@70ac090000 {
>>> +        clint_mtimer9: timer@70ac094000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac090000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac094000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac094000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu36_intc 7>,
>>>                             <&cpu37_intc 7>,
>>>                             <&cpu38_intc 7>,
>>>                             <&cpu39_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer10: timer@70ac0a0000 {
>>> +        clint_mtimer10: timer@70ac0a4000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac0a4000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu40_intc 7>,
>>>                             <&cpu41_intc 7>,
>>>                             <&cpu42_intc 7>,
>>>                             <&cpu43_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer11: timer@70ac0b0000 {
>>> +        clint_mtimer11: timer@70ac0b4000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac0b4000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu44_intc 7>,
>>>                             <&cpu45_intc 7>,
>>>                             <&cpu46_intc 7>,
>>>                             <&cpu47_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer12: timer@70ac0c0000 {
>>> +        clint_mtimer12: timer@70ac0c4000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac0c4000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu48_intc 7>,
>>>                             <&cpu49_intc 7>,
>>>                             <&cpu50_intc 7>,
>>>                             <&cpu51_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer13: timer@70ac0d0000 {
>>> +        clint_mtimer13: timer@70ac0d4000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac0d4000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu52_intc 7>,
>>>                             <&cpu53_intc 7>,
>>>                             <&cpu54_intc 7>,
>>>                             <&cpu55_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer14: timer@70ac0e0000 {
>>> +        clint_mtimer14: timer@70ac0e4000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac0e4000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu56_intc 7>,
>>>                             <&cpu57_intc 7>,
>>>                             <&cpu58_intc 7>,
>>>                             <&cpu59_intc 7>;
>>>           };
>>>
>>> -        clint_mtimer15: timer@70ac0f0000 {
>>> +        clint_mtimer15: timer@70ac0f4000 {
>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>> -            reg = <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
>>> +            reg = <0x00000070 0xac0f4000 0x00000000 0x00000000>,
>>> +                  <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
>>>               interrupts-extended = <&cpu60_intc 7>,
>>>                             <&cpu61_intc 7>,
>>>                             <&cpu62_intc 7>,
>>> --
>>> 2.42.1
>>>
>>
>
