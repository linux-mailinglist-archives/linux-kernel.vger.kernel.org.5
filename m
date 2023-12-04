Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44580426F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjLDXOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjLDXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:14:50 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2048.outbound.protection.outlook.com [40.92.41.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85401D3;
        Mon,  4 Dec 2023 15:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP8EmOI7YDDj6jKJsF+1kNrQr7R+2hnUJU2lYAlLv9X90hedjG6mvcEO/SYxkGTd9SmYEgDsZWX4b4J48sFLVMz96EQwbcoDnEl7MqX40GgW/iLyvBYzZwBcjSTcTJiSp4miVGrjazPS5iLFspsNG18ZWk0ia0bm/BmqCHFzwXL3hOBZm7MeXg9A1UJ8PhFamKj07IcGy8WHasuw6HJo1XKk5rPwNLFgyafxL7y9Jj7vYxYLUaUdBnu/wRzo6dc4qWks+Bl9NJr7/dM7g9ClNPT/gdTVJ0ykMXfIttVdG2cZmRyoSz3USOzVxmiKNZwAU+AVpYG04s4pTfEQQNIYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otEtPWKaLLn8O711OEWI8Yf8aFxHuf6I1jhxfZzXOGk=;
 b=VhcM6U1uo6CfMTeaywrBsdDRQag1vFWPddvYalqDwOPaAudzpFBXQnaWCEE6tu8mhzOFOIcGP8bnYGv7NvDwCSuKqHPO47sGCvybpXFrX59j+ichK3+0Ww17m7YSM8GAOLVb3yG3SaHNZg68iXOAtjtwWe7CZWEOwD9KHzNmhASOPZl7mOX7HEPWsDFeh0Jmqx+rc+2ZVzOG0+jfd3w470/XYr47+NKWZ//JE/QvaXWF9GwMJEk4WvPZHdpMLf++vprFUYnvGgVMmWXKV0hHzSSXxYYqELIYQsNVJ1CnNJzt4acSGNjmZ3EM5ITXn6Odw/CRy/eL5UWsVlHfGXMzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otEtPWKaLLn8O711OEWI8Yf8aFxHuf6I1jhxfZzXOGk=;
 b=nwUHoIh6Ya8HcrWfWKAVQQ5VnbPWuRRpqGEkI44ub9eJyYmfLDfm2RZicQ9UzxaQWiUTcYsgTTJQXscEpFybuOTS/0hIOw+l4zAU8rp7WNJlwklMklbfjoGrcMaHT7P7+i8NOoXFCyX7cSLDQfBsEWuOYpfvfAPdyjPIMx9fWgHrquIH0JUUUan4cZxTaOR8n+1QdD00O9w3gRwl3WExB9MNyISRkVLQwlzDxAwFP6NI6NU5LBNGUG91oE7wYVKx0assBGidpv4IgWKYof0mkr5CgdoR406f++OYc06kbPMUdBb1RaSgOYcotRFCMfFEs2ayq+2/m8ch4XELpX0E5Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB6170.namprd20.prod.outlook.com (2603:10b6:a03:4e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 23:14:52 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Mon, 4 Dec 2023
 23:14:52 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Tue,  5 Dec 2023 07:14:51 +0800
Message-ID: <IA1PR20MB4953E67DA1BD6921DC6A8789BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-monorail-boxer-82c77526e764@spud>
References: <20231204-germproof-venue-6874ad902323@spud>, <20231204-monorail-boxer-82c77526e764@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Rmu9e0qwIGHaV+oP7ShTTQZhbeeTBm2RHIr42d5FqF8=]
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231204231451.56687-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: c48a6948-8230-4d42-00bc-08dbf51ed1b8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3LYAPsnWFRuzJeXfcp4IZj9WBoyo4nUdDi8facOfb8n59Y7kNCOIEdhIZ5SEw5zutvxGviJcSdOkBESRXIK5fMeKVQPMdN22b+Kvlk7Q5R9a8N20n3f3PyygdcdLI17yjLLmBT3edmi8+KMHh3PZ3YJkk7nrdIT0L3Wiwp4OYm8wJmZajVeKAbOOITXO93M0lGS/jZRFmL9IqwYqZIWHIJgPAMP8KX4pfAV6/D5Xw9MaShDMgLJZhIDe7PkkhiBnxMAstRfCOBukZ80yEy+DBrbNhfn485eYONRsnI6LxbKJ9uYEsxajN8MgxZrSma67M+zmAraxgxmcv1xbwTKFBvCS3F0ewT0d9LsvqX8MpWr5xdjGEamFBY0YnfZUQTIY29lR3eSDOwu/nGG8EONTMvLSs2f29WVK+TBMWdy7OZYObbiW671KBfAnlc/Km/q5MJ6vJ3PmkKHeUFY29RFX724THboc3HF50y1dzIbjugwGfZ/d1OvGjmND5oLZXxSqCjb3axc6Y+shhxS/DiC9GlePN8pYmQKK8y1B9rwkQgTtjfCEYblO/BqBXdfAIUavk4UXOrYm1X/D6o4xq3sbvJcxgV4zJN4xfaOJpXIQzDwYFnWlCaSxFQZvb9pfGrnENgtZyMzkkhWrJhM2JiSnatZkrVlA2poaE5bJ+CI73E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsFZbX5YR/SdRxL7LHy7BC+lNOdwCqB7WiogP5B3Q5cykO14A2tL1/wQP/ui?=
 =?us-ascii?Q?/z7kC8J2zCdtlgKnc+odQ945SmJOhtGjTr8PKzE9eWNeLYtQFPfsb8Xv8JYU?=
 =?us-ascii?Q?Sc0U7ypx38jnMTBlCYo3Uq5jaFXtjam5epGr5m8zu1Ir7x6889rrx/G4hF7y?=
 =?us-ascii?Q?i6zTdcKqgvSxK2O8/Y4kt/EbvhrrsgRcQ7RbSbLQUmKU3e/9MUVa79dH398A?=
 =?us-ascii?Q?5mxyLMUR1wnHYEIaMOh31Nu771OauySBVYW2CInUkfpeSnfKKs9CAQftk/yP?=
 =?us-ascii?Q?BCYIQyT9HPWVbYxF2iISUA7jMwi/Uf5iCtnCbiph3qTw7x79XbYGVRJDiudG?=
 =?us-ascii?Q?Z+rZZIYzOPm3jCS4JD1Pz9uq+RSzTz84jQ1/gzLO8W9WijDgW/J2pVVNxTFv?=
 =?us-ascii?Q?MGvn2XUfkgy2tfb+dPJ0EHN+aiDNsUEzj4R/WmkFE/HNyif5dNtIP8hWPwEr?=
 =?us-ascii?Q?ug4/fpR/dlLrxuI9y8MaWtt7fy//ZSi+59jYZJTFDTqgneJSbkZ+/QkHN+xG?=
 =?us-ascii?Q?iMJt4EVdCcFWUBMiX587xAcHE6/dpRaE6Xk7AnFflu/zLlLmC2u8L50vlDGQ?=
 =?us-ascii?Q?xna6owUHE8+QVANuMbnrN7Gt/BUZKi2WwojYom9bgxh0Z00gWJ7k0KFU4cVf?=
 =?us-ascii?Q?5+DHgPqxpGFJ0CxVG5VjC0rUXoKhDyRp6P2t8LF7TP7Nh5t1+eCM1e/Epx8d?=
 =?us-ascii?Q?N2hQHm1XHkDCv8v9P4QzurkvqwDk2jjgf3zqp3rivvX0ljYWUk9TBOMA9eF9?=
 =?us-ascii?Q?jmBJ6PogodIBnbIz3XvM8gmOZtAdxM3rezlsCpxRQKlA0lr6Vqn0gjvn0q2r?=
 =?us-ascii?Q?gnq8HFUfYOLaO1Yl4oimKJ8XlmwFHoRRPw/uAfGhcgR6mQD5EyIT5vhBmq3v?=
 =?us-ascii?Q?vG7kDxm8xaLlIXR1H0M5Q3F/1PuVo+kMu3buDqWe+SnJt3sdQDZC9zxDATbC?=
 =?us-ascii?Q?RyemwH9KQtLvlw77wzdq1O/wbsT//BcQNy88F7sFPvLOFvLVYTFXzVl9PbUi?=
 =?us-ascii?Q?pYdyKVCWuohK8ED8+su5BmC+Ac+Uc9GERIO9yRLIfc8c5UEXxIJMEm5fatoL?=
 =?us-ascii?Q?LkaCRgVT6maVgUUY1LcUrpfEHcoZyROebI1DbRkxAVel0qKdUXms7fJFZw3m?=
 =?us-ascii?Q?fDTDJ0/Qb3nEX1Wm/M0fDmVHuvdoYZkeDbYPJT07CRRuJ712jbhYQURLma6G?=
 =?us-ascii?Q?YP6xQzTPZKJR8PDircJOlyOAlAltPn6OZODcbtSghRgwIYqksInL0+SHcOw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48a6948-8230-4d42-00bc-08dbf51ed1b8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:14:52.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB6170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Dec 04, 2023 at 05:39:09PM +0100, Daniel Lezcano wrote:
>> On 04/12/2023 17:18, Conor Dooley wrote:
>>> On Mon, Dec 04, 2023 at 05:51:08PM +0800, Inochi Amaoto wrote:
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
>>>> Also, as T-HEAD aclint only supports mtimecmp, it is unnecessary to
>>>> implement the whole aclint spec. To make this binding T-HEAD specific,
>>>> only add reg-name for existed register. For details, see the discussion
>>>> in the last link.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
>>>> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
>>>> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>>>> Link: https://lore.kernel.org/all/IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com/
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Although, I figure it is going to be me that ends up taking it.
>>
>> No, I should take it
>
>Sweet, I'd rather you took it than it went via a DT tree :)
>

Thanks you both for taking this. This is good news for me.
