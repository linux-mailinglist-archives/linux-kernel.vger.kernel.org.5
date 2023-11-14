Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846417EA85C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjKNBqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjKNBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:46:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2080.outbound.protection.outlook.com [40.92.18.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855DD43;
        Mon, 13 Nov 2023 17:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI1TM/9o0BsF7uNkYn8w84hljhBQ+UdMn2CxGuXy2tbP9IW+ffCNskmSuDpQ0npCi8LeCzIOB8z11hz0ehgrpg9UZ2/1XcVVI2mb3wxvxICt9SZVufImkgdfdixpkwzxjNzPgiaw3C8pUZOJcqRJCg1aNPepyvxzRVqPOtFxldUICmouLIFBYJ3+JYfnRZHkDV5ATV31tuHp0hABs+m+Snz95R4d5XVuoPgSYF5f/5akLO59MLN0nCPWY9hiBEDIUAhMsJNxXOk3cLdSsvqnk6B5cLWaZUm2l23pSNcblPOtToCU1PUn8w3GD+vdg3TqcPhg8qn1lh3WKj6kCH+edA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzCQH025GiZl36nE5Aj1+JFFc1UYZU09ZZZuleNBCvc=;
 b=ccO7kt6/hsGxcAeWNXGwCpU3Tu2WnWTPo2AW0Nc0PRoD5nCEfJB0BLWEMQ7Bmz24rWKCmLRzIm9Ji2VgeIEGzZwKPa4lxQIg4kIp9PMOnU1LKDZp+JEok+Qv4ZCqY9t9Z1QgLAnVqzsg9OVy/vuluuoEPR9rF4bAd2D/YVqSwFpxPb9rVPP26Dn127u7QyJM0mEfoiglKIWouQnP8icQtdNTPD15AchdGVfTfyDFyGxxLR+WjOUSQpezbVZXW92NHFhj0A8Nipw5rzve7GTqB6rst/ij4S8JhhrMkj5L3BFP2ilokqBj20A+msPswokiwFhALSPIm7ap1HqtEeDD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzCQH025GiZl36nE5Aj1+JFFc1UYZU09ZZZuleNBCvc=;
 b=fL2lgjSfd5rewFhDG49gtpI5eKud9qmiPvs/l4SVnJYo9kmpHskrnvY+bsFnHZrNqRXn5GV9o6QUu1/crW1kVkKO3Zuh6t/3bdOVED8ckDeJd31I4A5IWqK2Q91P+6Ni8aDy8iJiByc5LcGTBtLEh9xDXiXk0H7sKdPuEWR3WnaaCsy/+WXIjeo/lA5bGILoeo2jVEvQ4PIFcd7rbSp1Az4Qyn3MIr2wSVes0BuQIETgunGlLK6fhc1a5a6ZbHZLonlRpEkO41pPCSb33f6TWPH6t7U4N/w3HAHqscdaD6H/aFqETIkrdCjjYBLCbPbHHOnzMkRIYZCM5gIeQOae3A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB4388.namprd20.prod.outlook.com (2603:10b6:303:16b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Tue, 14 Nov
 2023 01:46:36 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 01:46:36 +0000
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
Date:   Tue, 14 Nov 2023 09:47:19 +0800
Message-ID: <IA1PR20MB49531C1FCBAB0E19CAFE19DFBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <MA0P287MB03326E8AF2EA63CE8CF108CBFEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB03326E8AF2EA63CE8CF108CBFEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [R+kLlh6KordgOCEMRj97TQaaOfMJnGvdcdIt+/cFRJE=]
X-ClientProxiedBy: TYAPR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:404:14::30) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114014720.55039-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 93545b23-2290-4b7e-3292-08dbe4b38976
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQph/0FjwD6Bid9k/6m8d2ucaR9Gkn+Q0zEr47jUKtuVHGKWOa1e9KAc0c1N14Utam5AxH4GI1JEzdH09F+4QgVZUstAPTULRkceCXjR9h9vggXKNstCpW+27swznRtF4roj3fgZcy7ya5obkxgOGfAZ/qYhAMHvBleQe31BkWFrwFA4Trz9TrVwx1nMfTILnx5f+JD9m6xoezu8Ubn6Potc1t7ZZpmGhIP4QGKDDxHdjHHbxFqyTDZa0amrezoOHnKOZ5fSUO6veA8HRzr5TXCf76HQExlm+/qo8OAwRnlHJCLjtAkLradDOrq4kSNHqb8VoF6ZeV7Ii1ALY7RmjNh5ZRDJUJoArhZKl1NiVEf8L8cBa8J6gHk5H43e1A2ot3j2W9CnAM5zvd19JZm0KJz8Mbiz6GeYWNhAVjwDGB/kB7PPTMAeNpfjo9Pe8PCjvW0rHS58GkKpceleEOUU7ooa4+I+6ffYqAMcZjFWRHNtMS5uWBhpGpnSZrgX9ySWpdZHGJpuK1WmrwepK/eubx6IX9S9qD1J85T/PVaclp8orjTmsOHJgxuSlC6CCB+KciswdNFWy9/BdXFVXdpZ6NbReXSJE6BD7Ta+OVReB5CmPiIKT6V5hWU0yPizPyVP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdGeo4XB324eHBoWLusKkqqjQJFrz5E36ENpoYfqTWYo9ElRvsyU02ac2nW2?=
 =?us-ascii?Q?694KuSLxu5JuGXKvTXZhrU+RcFDbHEC1SRRuh+faBophlvOWeTbj5hgPr2K+?=
 =?us-ascii?Q?HPcz9yk76ei8Rfluz42ua4ezy9riRPvGDCxQ3Gj7gL4dkYT+qpwBl4Ix1Ee2?=
 =?us-ascii?Q?Sa/tDeBhxV6eAZt24IKtcuhFcxiolx68d7pafJdilJZ4rrVLO7bozX+SNM8Y?=
 =?us-ascii?Q?RRYcAX4fc0DqKY3B00LLXuptKdUdgjE1eqxV7UhH5bNyCsTj3mj4a0HZAOk9?=
 =?us-ascii?Q?etRkWhBkE0FzYvTB7uRmx7uVTAqcSuivZcm2Hz8jdOPgHTLaiG0qHmRN7ghe?=
 =?us-ascii?Q?LAW42496092wIDiLUXBWrExwQrXXiuljloOK3wO+gtwgOjJObONNiE1HT9aK?=
 =?us-ascii?Q?Au7/Cs8BEeDcGon8FX5V/Zo9+g2CccHr9H+Vaa2XSeEXMPCBxGTryOspBLbP?=
 =?us-ascii?Q?FpwoRUNQ7ASFMNFnwLizpY4taiZ3X4x0HqWfgdE7n3dQykiaaZg7vls3smo6?=
 =?us-ascii?Q?lyOBJhB9RBbIoRsX1gO4Md6HIud2MMDM34vfdi25VYSRluvBocytLu5acDBu?=
 =?us-ascii?Q?QAeRy16GqpWcAoCnCC5E0BSi2WFXR7hZs/KhZxbRbQb2R1uv8FaVpN6l5Kdq?=
 =?us-ascii?Q?JnlO5MKA/lt55hST7NWOOBFWJmEovvZOjY89MRbtgK2y7udzWiyngxBH7gHe?=
 =?us-ascii?Q?l47CDA56ptjaDLbcpslZ72Eqp2amAlqUXQEc3BHhXjQLll/M0qMVyjFu/WaQ?=
 =?us-ascii?Q?XFq4PXFVJ/su7ki/awZAzMESxqcxJ9q503UBsT52icAtp3HhFtO+wNvQxL+x?=
 =?us-ascii?Q?kVpzTLixzcvM8niBKEo4eanwEYwG77MvRfa3KMVhqM+3r7JxpAUx99HhO/wL?=
 =?us-ascii?Q?lTAjAVU60B/T7dlDGuQJDd5Y8GxSIAr0L4pZIkJyEA9XXES+uozQTeOqYcck?=
 =?us-ascii?Q?sD/+VkKIxfTqX1BJr6z3AUuu2cyaY+SMlvBLBKdtdUiLdF40REetViSHzEmC?=
 =?us-ascii?Q?FF5FrRoABCzTeU5NotSTB9NK9rfJWLExfCL/FkSWCT7Y8i8WostNcIUsw7bf?=
 =?us-ascii?Q?xA8jkHbIu1zN7bvWvFuisa6478uABTl9gApaxMsB6EO/mSr66PXfrbY/uw/p?=
 =?us-ascii?Q?T1QjKyD3Tg3N66Ovm5F9Ng6mCNsfs/gsbOwcteAXGv1itFL4GODAgRa/Lvab?=
 =?us-ascii?Q?91WBHEttD1Xpa1F+QEYfJ2aMD3oeidHVKR6nqCuhDHkW/elRnYFNXkk4rK8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93545b23-2290-4b7e-3292-08dbe4b38976
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 01:46:36.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB4388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2023/11/14 8:45, Inochi Amaoto wrote:
>> Change the timer layout in the dtb to fit the format that needed by
>> the SBI.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tree")
>> ---
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
>>   1 file changed, 48 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> index 93256540d078..0b5d93b5c783 100644
>> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
>>                             <&cpu63_intc 3>;
>>           };
>>
>> -        clint_mtimer0: timer@70ac000000 {
>> +        clint_mtimer0: timer@70ac004000 {
>
>The address of timer register is changed,  and I guess it is another change not directly related to the topic of this patch.
>
>Can you please add some comments in the commit message?
>

As it needs to follow aclint format, the timer offset is applied to
identify the actual timer. So there is a change.

>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac004000 0x00000000 0x00000000>,
>Why the length of first item is zero? Can you please add some clarification in commit message?

I uses length zero to address that the mtimer is not supported, so the
SBI can know there is no mtimer in the timer.

>> +                  <0x00000070 0xac004000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu0_intc 7>,
>>                             <&cpu1_intc 7>,
>>                             <&cpu2_intc 7>,
>>                             <&cpu3_intc 7>;
>>           };
>>
>> -        clint_mtimer1: timer@70ac010000 {
>> +        clint_mtimer1: timer@70ac014000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac014000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac014000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu4_intc 7>,
>>                             <&cpu5_intc 7>,
>>                             <&cpu6_intc 7>,
>>                             <&cpu7_intc 7>;
>>           };
>>
>> -        clint_mtimer2: timer@70ac020000 {
>> +        clint_mtimer2: timer@70ac024000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac020000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac024000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac024000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu8_intc 7>,
>>                             <&cpu9_intc 7>,
>>                             <&cpu10_intc 7>,
>>                             <&cpu11_intc 7>;
>>           };
>>
>> -        clint_mtimer3: timer@70ac030000 {
>> +        clint_mtimer3: timer@70ac034000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac030000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac034000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac034000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu12_intc 7>,
>>                             <&cpu13_intc 7>,
>>                             <&cpu14_intc 7>,
>>                             <&cpu15_intc 7>;
>>           };
>>
>> -        clint_mtimer4: timer@70ac040000 {
>> +        clint_mtimer4: timer@70ac044000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac040000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac044000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac044000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu16_intc 7>,
>>                             <&cpu17_intc 7>,
>>                             <&cpu18_intc 7>,
>>                             <&cpu19_intc 7>;
>>           };
>>
>> -        clint_mtimer5: timer@70ac050000 {
>> +        clint_mtimer5: timer@70ac054000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac050000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac054000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac054000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu20_intc 7>,
>>                             <&cpu21_intc 7>,
>>                             <&cpu22_intc 7>,
>>                             <&cpu23_intc 7>;
>>           };
>>
>> -        clint_mtimer6: timer@70ac060000 {
>> +        clint_mtimer6: timer@70ac064000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac060000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac064000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac064000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu24_intc 7>,
>>                             <&cpu25_intc 7>,
>>                             <&cpu26_intc 7>,
>>                             <&cpu27_intc 7>;
>>           };
>>
>> -        clint_mtimer7: timer@70ac070000 {
>> +        clint_mtimer7: timer@70ac074000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac070000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac074000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac074000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu28_intc 7>,
>>                             <&cpu29_intc 7>,
>>                             <&cpu30_intc 7>,
>>                             <&cpu31_intc 7>;
>>           };
>>
>> -        clint_mtimer8: timer@70ac080000 {
>> +        clint_mtimer8: timer@70ac084000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac080000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac084000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac084000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu32_intc 7>,
>>                             <&cpu33_intc 7>,
>>                             <&cpu34_intc 7>,
>>                             <&cpu35_intc 7>;
>>           };
>>
>> -        clint_mtimer9: timer@70ac090000 {
>> +        clint_mtimer9: timer@70ac094000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac090000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac094000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac094000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu36_intc 7>,
>>                             <&cpu37_intc 7>,
>>                             <&cpu38_intc 7>,
>>                             <&cpu39_intc 7>;
>>           };
>>
>> -        clint_mtimer10: timer@70ac0a0000 {
>> +        clint_mtimer10: timer@70ac0a4000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac0a4000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu40_intc 7>,
>>                             <&cpu41_intc 7>,
>>                             <&cpu42_intc 7>,
>>                             <&cpu43_intc 7>;
>>           };
>>
>> -        clint_mtimer11: timer@70ac0b0000 {
>> +        clint_mtimer11: timer@70ac0b4000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac0b4000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu44_intc 7>,
>>                             <&cpu45_intc 7>,
>>                             <&cpu46_intc 7>,
>>                             <&cpu47_intc 7>;
>>           };
>>
>> -        clint_mtimer12: timer@70ac0c0000 {
>> +        clint_mtimer12: timer@70ac0c4000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac0c4000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu48_intc 7>,
>>                             <&cpu49_intc 7>,
>>                             <&cpu50_intc 7>,
>>                             <&cpu51_intc 7>;
>>           };
>>
>> -        clint_mtimer13: timer@70ac0d0000 {
>> +        clint_mtimer13: timer@70ac0d4000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac0d4000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu52_intc 7>,
>>                             <&cpu53_intc 7>,
>>                             <&cpu54_intc 7>,
>>                             <&cpu55_intc 7>;
>>           };
>>
>> -        clint_mtimer14: timer@70ac0e0000 {
>> +        clint_mtimer14: timer@70ac0e4000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac0e4000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu56_intc 7>,
>>                             <&cpu57_intc 7>,
>>                             <&cpu58_intc 7>,
>>                             <&cpu59_intc 7>;
>>           };
>>
>> -        clint_mtimer15: timer@70ac0f0000 {
>> +        clint_mtimer15: timer@70ac0f4000 {
>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>> -            reg = <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
>> +            reg = <0x00000070 0xac0f4000 0x00000000 0x00000000>,
>> +                  <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
>>               interrupts-extended = <&cpu60_intc 7>,
>>                             <&cpu61_intc 7>,
>>                             <&cpu62_intc 7>,
>> --
>> 2.42.1
>>
>
