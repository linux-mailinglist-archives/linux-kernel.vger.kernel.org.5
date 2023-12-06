Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900E8064A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbjLFCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjLFCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:04:14 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2078.outbound.protection.outlook.com [40.92.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F281137;
        Tue,  5 Dec 2023 18:04:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkL7E/Cw2CH2d7cujqyP5CKTQIUJ4wqinOGEHNC95Xjv196zKaHRBF/t/M/GYBxlJ3MrdHAbzF56S0dEu5e6MDXD1PI2fERd8A1X6fqsZDNc5i28kptSCmT7ht+Uqd6PWhZvVuzmH5DJkE21o5eHEO3QUo/K98AOMHQIFsksBSBBw6Vu8xRZuX45rVwqtaERt+PR/ENzqHljn5Suv8IZWo2Rzo2LMdGsmoKEOdHVqroZI3FC7mjfprry9DdHEyBT3BD2A9TnYEKhjybGfAnI2KgR4t0eyl63/N2idobygIN6uQ/nhfFK+xQAMdCyiROtiBwWCoGSbMdAtJG4Wwy3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/Wumsd1KpZz69frpvqqw/nwMWF4KQ0K732C1cuEdVM=;
 b=l4hwoWGV/p8G7g9SmPrQHE9IIRcgVLiCGimrAPGRZKRSBXaxGqv3S2Nz5Eio3Tn4SmryQCyW7lBhkjrffuaIIiWjivUhJ1VgsTrxpzXqcMp/B5fuiDMWY6p11DXPU42KfPZLo3CcOHe+k7kt1T2jX60ngHkdF8PxH31VUmEBRFmv56ro0SDf8ENBMY8rBZNd4OoJq1HbHMKVi0Y8Z9cqX27msLTZ1I0AxKQ8IFsoKm/swSNLGEZtZFDbKkiOMNNlN8OiKZhso9v7qzGMWcSYFF1YBErrFCHlTWupCrgf2PJCbBc7PxICH+wmHhNg+X79l9oDM9v10WL3cJZCgrYuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/Wumsd1KpZz69frpvqqw/nwMWF4KQ0K732C1cuEdVM=;
 b=n0tuFsr9/qD+vReGPHpb9Ukmc/Q8dlRPLcmujXlSxQwTnBsizL4M67Bbgo2gX/HUrlu0iIr7vXNOOfJwQwBBQtxXcFwo3FdkIYPdznZTIKX6M6jpFIpb6FTBMKD4RlNfwweXP5y8YdJgdCTCZj5u1JaIB1Jihf+4EGcqDTj5v2VzSB7AVnhVQcp1+sdOAurkAfUg08EJdjEVWIw0pUubcarDqlR3CgmT0FAbLDFns6l6DbCTf8nvTEbiysCMeGrT86z6swnurTFNdb2sKISIenmo4fVGcQtqujZADAa+PgmuQx3xz25ysxgWsJM+eWB8TKzKxWDeD0E8tHvtNaChsQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA0PR20MB3407.namprd20.prod.outlook.com (2603:10b6:806:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 02:04:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 02:04:16 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date:   Wed,  6 Dec 2023 10:04:12 +0800
Message-ID: <IA1PR20MB4953B8844BCAB9EDB9309309BB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953BFA99F4C91EA525BF03FBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953BFA99F4C91EA525BF03FBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Vtfj9q0zAZBk4CkC4imPpZhnKfS22PHLrHzj4KDDmCU=]
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206020413.332618-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA0PR20MB3407:EE_
X-MS-Office365-Filtering-Correlation-Id: ae84d4f1-4451-4549-c2cc-08dbf5ffa689
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD/CCnRkbcjvWNOQtDJJG3pjk5Nbg9r3semoapCdwodi49+socp2h6AMvxFle3gjnOGFcdt7MuMXISUcTV/2SCBJ03ABPiYF/3o64d00W9b9jb4MgwwJfAn1S1SKQtpaajX8Myb8uaErDISFCR4YoXvDIo7zC36d7aC9Vr8rA65zuaPlA0d727TxXjs8sSdn2B1VSCVtSAaYvDn18UUm7lTZ05uysibkvfQzJX3VpeIz+2Y9eE6u39vJLQ39SzbG1Etfme/gmmqah8Op/K5B8Z+lz5OW7xF5pWPUZ6EelJ9XXvp/Lw9ft84JwaZRUB2nDG2oZNhpfJw2xiNw3mfv1u1+NP70BOdYBYGkIIN4aoGbKNqTrRK9zICHp/bqcmuhD3lRrq/b8gVVsJW7QRSyC/ihlbV854Q9jS9OrChyKGI3o2dQJ+cz/RCrIo7DKAACdxck2Zy3y9fCJT1wJ4Fu6hZAvJZN2HBjCDi4uPtf1xDMh8/J29q2HVq+EGmW4hv4Kuia6nNd2vXNkPxhnetjjbv0pbMUegR1mL6sqsQnm/ijUQ8xz+XLKakCSR0PkEA5q7GNsZDyaYqW3tq+L2jt3URpcjNvLUmFVzewaNLQkR8aZQsEu6RkGGcIzTdnMlrE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySMki7GhOYXHFfHJgKXBSI0mdKAu154x3LIE5IGOJD+9OZPjiZUjS96+ofNq?=
 =?us-ascii?Q?CnKCL1taI2rro3xIIxe3FnYGImDj7ytCJpX32tGOwvnx6h+6D19r8A6G8yRm?=
 =?us-ascii?Q?fM2NK8LUWqRkscUpduExJvQ+XcPPaoYOuSC4g+d+WqJKIEcp+o1VN0D7f4qv?=
 =?us-ascii?Q?VXUbujjlmuq8KJj6qT6GpoTADkQecOdZTaMleNwXmhxEEauLhpmJp5TaprZN?=
 =?us-ascii?Q?wlJbBMXtMeyWdB1R8bfKEp/b5NH4b2fuA1Us74bQCNJHsKg17bwZ5C8fvxIT?=
 =?us-ascii?Q?wKTRv5o+FSnVGVlLplg89Acsna3LvFkhWIAAo4pf3S+1A0U5DxBIr8bXkfRA?=
 =?us-ascii?Q?AgnOP0rCUCF7uRpDyNafC+Bgm/z4f3tpYw6pCZyVcpkuzmfb2IgOQ7Oc/vCT?=
 =?us-ascii?Q?Ib7ndSzY3ctou8Que6Kv1Hsunb4/0dkXyJ12UWONkDCOAPM0WCR1TKJrN7zC?=
 =?us-ascii?Q?m8jzwGN3KpE/m9ZxFYYqMzgFOISkB1OCHupu3B0aFt82Shk4ivOBzOtajkJf?=
 =?us-ascii?Q?hZ2Qo74Y5GfAOlSiWXdhhwjgPp7BZ15ar98GmXQyuCrpGNsC0cUdfJOMu8Nr?=
 =?us-ascii?Q?mVGwt++krkboCHnIElxemjlPLQDBUzGTLzHwGjpUny2YJSNqj/3wJGf9QUjG?=
 =?us-ascii?Q?oe4OKO0RSlGchdDGiHiYlm6ZmZ9Av9YCEJKXSco36f3+IBIMbKFamb230o8S?=
 =?us-ascii?Q?gycd5AOfIxV3xjJeY07xZ3M8ZZ5xvaKA5dM/w/FbooDQoYgo8QHn5/QK2Pxq?=
 =?us-ascii?Q?2AOCni3yl5ch2SfklxFhaVmmQmMD2hbljonDdUcjlrl7BSq33bDDGgYaGq24?=
 =?us-ascii?Q?Ub7CRhPN7tk3ExcZIAuWkfuEoS4JtxhbFQPvcl1t562ureSLRE3x7a3h8fBO?=
 =?us-ascii?Q?pbtcE1uKoxRhSRSVR3NJDyDQxgacqm/eCybzuyYyWTYBmXIg+SkGvH9y0nJ6?=
 =?us-ascii?Q?ykUEif/wFQi13NyMjn9v9WilJU6uVd1Gbf4D50QO2zJiKNUcWgBLhNi4tUkX?=
 =?us-ascii?Q?W2SlorF1ZzaOV0WsnTWfWhB8EoCWHiFEMpqUc8MlNSSZE6IbV58RdMT7Ns5r?=
 =?us-ascii?Q?jVMCTm14vDvLLSVdHuP1tsuepHXENlsmX6slE1+9WEuoI87Ms7ZzgPOWBwXi?=
 =?us-ascii?Q?iG8itBhDlpx/RK0soFySNc343yq2LVnwAnBi7axIzV7ADumz3YF7lkNfPfjB?=
 =?us-ascii?Q?2JrOiA25Mm5CK5tUeazAJYp3bjs/uGCFV3Ifb2mOMQXO4egUWBImfQlw0Ro?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae84d4f1-4451-4549-c2cc-08dbf5ffa689
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:04:16.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> On Tue, Dec 05, 2023 at 07:55:50PM +0800, Inochi Amaoto wrote:
>>> Add definition for the clock controller of the CV1800 series SoC.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>>> ---
>>>  .../bindings/clock/sophgo,cv1800-clk.yaml     |  53 ++++++
>>>  include/dt-bindings/clock/sophgo,cv1800.h     | 174 ++++++++++++++++++
>>>  2 files changed, 227 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>>  create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>> new file mode 100644
>>> index 000000000000..388be5bfa163
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo CV1800 Series Clock Controller
>>> +
>>> +maintainers:
>>> +  - Inochi Amaoto <inochiama@outlook.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - sophgo,cv1800-clk
>>> +      - sophgo,cv1810-clk
>>
>> I'm not reading 1000s of lines of driver code to figure it out, what
>> differs in the programming model for these two devices?
>
>In fact, they have no different in the programming model. The only
>different between them is that cv1810 have one extra clock.
>
>> You should
>> mention in your commit message why the cv1810 has an incompatible
>> programming model if you are adding multiple devices in one commit
>> message.
>>
>
>OK, I will
>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: Oscillator (25 MHz)
>>
>> This could just be "maxItems: 1".
>>
>
>OK, thanks.
>


>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: osc
>>
>> You have one clock, why do you need a name?
>
>I am not pretty familiar with this. I just wrote this binding by
>referencing others. Maybe use "maxItems: 1" is just fine?
>

I have referenced this name in the clk_parent_data as the global clock
parent. Removing this will cause driver broken.

>>
>> Otherwise, this looks okay, thanks.
>>
>>
>
