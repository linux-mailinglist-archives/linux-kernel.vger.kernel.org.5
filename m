Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFE78A5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjH1GlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjH1GlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:41:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2024.outbound.protection.outlook.com [40.92.42.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191F113;
        Sun, 27 Aug 2023 23:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4JH+3wZqXrypw4Sd0sm4muayGYqUt4tv12s6iNTxX0M0HZyfHEHzTo5F+u9SBbxwVQNImW2yRqr4NZCwslv2RVDKeUsQmJ1DUcXbvDNT+Uh/Op1lhC1Qw5QA47OmvqgDfwrrVvpXDz6xJlleKZ/WyCAmntq+XgobjOvAe3tU+f0qs91q6BdD7W+QRW71SiS2z543nrJzJ3Ty9FhbJwOQLW2yOdL2ltSsHMLPaz4xxpB1S3SSLHIs7FHc6Oke5q7Mb8dLAGXjCa0qfwFjLXnEDKkd6PaICHSiXvIshumVu4oZNWTDqo4s6IkGnEX91jlcmw82jZpp45Hlh2bs8oHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2/2BZafS7YDHATxebEm64MQYN00CccqrGLmCQJTk2w=;
 b=cX3I9pGgH7MIqBfiPQ8xVqU5U0zUgXja9UNwXnjTLLorIrBtDvxN3GtuIeuXixWiGdjTo0kT5SSbhv086rgwlNnD8uVjowID7DTxdtLxmFf0kcY14P6p6MmpgmZL2eCC2+FGWCMK5bmleKC2KeowRVSEb4tQGAfNT1zhaovW8tigSkCJ44GLb5eDEWjRkfbjzXtsuGnd2I07oIBknW0SkrC05F4GaEMSJmSl4iWMnEIPavdzS1GgtuMfLPDo3zplzU4f2CH2lidlYpTKnexe8AH0kl2lyQCKEzQ8qjt3int8yBuZ4NmjcMvAaE3C+ODwvEtVXO/q/VQ2Dn+5/BUzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2/2BZafS7YDHATxebEm64MQYN00CccqrGLmCQJTk2w=;
 b=NVPbMdfOtHdUBnl3x1knqevMGtZD946/tqNHll4eYBtjk59y0+ZYZa6gL40K+N8iR8SyFfJSUOwOm3zqtKwMjUVZ5ZaP/G360whqv0QEA1ddzoZVeMZyK4UWJ6VKPWqf2zjVUgZtsQvdxiLr4Wb9ZHXTl1Q7pozNwhjgYh9042Aclhn213jgtjBG+ox8WhBsfxABHkKbFzFx0ap+X0TKwPeJJ9j8YiRR5pMKXyKgqHSs07Gm5ej1PIyq3NC46Wp2xG/MVq7v5kkPx+o5yoTHLbDsYZf/hA/2qMpf8ZoLlV0WqWLaEBIonGs6yVq8p97s05N1laRbNkVCnxc8hFGzEA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4403.namprd20.prod.outlook.com (2603:10b6:303:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:40:57 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:40:56 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
Date:   Mon, 28 Aug 2023 14:41:28 +0800
Message-ID: <IA1PR20MB49533ABEA8426D21C00311F8BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828-cupid-muck-130c4ef218f6@wendy>
References: <20230828-cupid-muck-130c4ef218f6@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qZc1qOEx851zeAq+Y/ScYEYVSL0ul4WBJWm2YEViNew=]
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230828064128.278670-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: f472b9fc-1eb5-47fe-3791-08dba791bbb9
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT/+JuXvcT7GEyFZu963yJA/H5ug1VEKZgP/jrbKmzqbFmsAvFPYx12Y9pWjj1rWTrnMgU4OopfQT3XP7QyE6pI9CK5VfRbFKEdeJdtXk8tNV7QzOkksitWXMw4x5fxISams22ie11ZILO1kPxerJC7TuQ4ZstgW3Moh7/DFQi1YGJNkFq+Rx+G3fH/+yrjyaAAt3F9L8l2xuJ+pqSwHibfyPXwJB7gkqWpsIQd3auKR76fo+auy4QDPSu8XwTr1wSkMy6ZjUqLQMt1bGNH6DTb3AtfOKAU6YwdUp43EgIi8rXyvg1pgsthu2NG1pVYS0/zhZ3f/v2A+pSwBdT31jbNzer2cf8e3Q0TnccSy3VzErumlJ9FydpN7fHY+Z1hrR6Zmeev7VIDQiCcMZg9KqAWbo0euB+8RYKpj391Jlsr3Tc2S/4vuPOaPn2csAnxSSQVFvBz3TlgKkXpzHg76J+ODlSX+StcSXiL62PvyQ8ox3WYM7m3RNBf3Po8zzUJFNbMDbGm8Of7Q69YFvB6dWLJUF0BIobQsHzD64XuGg/3emvTc8QIXlUSBa2Cml8efqft/gmRR3vGuLotxQf7xSzG6lOKF+aaNw7/N+DSJ7k0cwT1MOKGkG5WZDzgmI/ErGfzc5J9vEW4F8Vn3A/TFhTgq6mCADJslt4XggCZ5ZzJvbdbH0waO5jCtxi1gbr5/ZT3egpZTHtcW/FLVVkIuGqwI30KQDPhAR5gNrmf9d08jGyfIMLQlRyF49F+6qY+MYrhf22cxE3e8cL43Fo/kVclYwdGCm1d48IopnMGpjzHaIecgp4HtOEc3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LChF8n/Ux190FaGRJhrCPwMaK6FA8syCh/yv2ZeT5Da0Z93dIM+CeABi+S24kaSNG/0Hpp8uP78cc2KYuipyu98gNnoj19HFLd2eJ1Ntose1jVc7vhtp7YVHA33PpKEnhX/FkETzMxiDVLGeNtKIJO0DWJm6QP4gjF9A8TUR4GggNRQx8uyTAS37BkIQdSEUGwuVxKhrncMAVp9Qqb1hNDnRnZ1y30y9cY4RQuEoewIau68FvzchHm9ekziqUPe5+EPAnqxRTz9OTdhjy8R4jW+7OTyzrvqA+H/AfBaJWpHU6qD+MfL5EVyvRfTr8uet8ILT5+4pntHdcEaX+rNo3ksTngi30/zcot7LI8BjNHk686M074/t4nmEg11VhX17yaTO1GJOqgIbozEGfVPlsmMiAMQI4WKJk9yOBxvyTvNMk+fRlYfRpAGzAIoJ/GwMShwNpQzzAevRv6rQzQOg11FOgVbz6UPEtein0r0vhHyDs1PUCoRkmjUSzBcjebRzhoPjMJE5KvQMAjP8jENYiSgdoNg2z71+HYFQUx31FIbh8ajjf//v11obCpg06W1EmZunDUFihQoBIkPfy08hf+n4IaWaRosnuw8/lg3wNNc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APZ1GI8cW9d2l6ePceBHr8Qr1MnTSWYnqyYaHHlS5OuwHmNEQndn8z+cVEAJ?=
 =?us-ascii?Q?NMT7IMTJrcg0dtptBNr/2UkmXeLt3HD+5HkcrKu5grHSHJCIOm6OcLVnBqA4?=
 =?us-ascii?Q?Ffq6ctAorUUx7z5Ggh+B3pW5qntz1ibU7Ffp7p02P6eUK29I9zWbvSiILoCT?=
 =?us-ascii?Q?tsC+m1esmjMa77OHQ5NZY560T4aV8ZbARh+hL+3Ie1Ajs+ZQl/DEIXOpDBTo?=
 =?us-ascii?Q?EfGnQ2uAZMbht/T+yUfFu6UxjMUgbCcsHJDwmM+gAhtPwMhzIUtLM192HTMk?=
 =?us-ascii?Q?r6Smday0yiRqJSgsS/T0/ot2deRUQXYgO/qw9/wgs31qoCbC3FpqqYHA4rad?=
 =?us-ascii?Q?tY3zOh3qMLe0h8wUwf9EudfWRc+OohmAiW/ayMDBsWBSN37T69Gu273enaNx?=
 =?us-ascii?Q?ZYlQgke46AHMZZd2r0BfPoNBigLau31VaUG1gH8lrpkD/pxcps9TDOCG1i0e?=
 =?us-ascii?Q?nOIafb8vKRnX+Qx5GjjfCfqcksHkbaEtDtfr+sOuv0S2AdprRquVEpdqyrYs?=
 =?us-ascii?Q?nKIGcACDCDaE4KEukXT7mgGiYBz9/KACrYvE9rAcb8EXP6u7cAxLwcOZuYou?=
 =?us-ascii?Q?hWSGRVsIRpOmrMqmQ8Q6Ng+7+v7LtyktYOwNRo8g7jRuHF9yYDkWcMDJNz/e?=
 =?us-ascii?Q?CzpQj94lc1n5WhfM82fOGoKB2FlLDM+NVtSNMIGeJotV4Xpf3Xanjk0m/8Vl?=
 =?us-ascii?Q?uzjJhkDTJkvXgpFWKO7+8SUMwtNJ0P+GYVFAzmWARWDAEPT12VrEBXUCE1kM?=
 =?us-ascii?Q?LkZmi25K5uVfWfDBsUtm0menYYrN+wFIk1bMAQTotKzUrLErnS1PWQy+Ji4k?=
 =?us-ascii?Q?ch3UVTouENULJlKGhABNUfHygWCIqfMFZbdFXO9BC+5Qm5326rDy0xxFi5Xi?=
 =?us-ascii?Q?2rHevkcbPf8NgAU5HUcjtdDNnNvv7wjeHVtZjmCFO6ZCqTSfAXMUqpG76A99?=
 =?us-ascii?Q?TffBrNYDBepyaJf+58uay5MDVlKtmdafb8ZHnL6Hx1l6juxAww4d0AqLgaGi?=
 =?us-ascii?Q?uz2jyEknGSb5h0rZUsDduykYDljXBo11oTQwnMMXfLiwKQs0wz+fzEcP3Vqp?=
 =?us-ascii?Q?e2SUVUUzboazPjieu6ngG035IZPEfB2ojAy0u24O2lopDsrTsosaMjS7tN+l?=
 =?us-ascii?Q?mVQ608m5/nZ2QPh/5qeOBIw2bkP+CUY+4iySMng/WPLx652LNQqvyQh7SPTU?=
 =?us-ascii?Q?BT3aHfeLXh9B1ouaKkSWbhwMhzcrp8IcB8f5hZ52lJD2aueGYjMhfTHoCEI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f472b9fc-1eb5-47fe-3791-08dba791bbb9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:40:56.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Aug 28, 2023 at 12:30:22PM +0800, Inochi Amaoto wrote:
>> D1 has several pmu events supported by opensbi.
>> These events can be used by perf for profiling.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
>> Link: https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L657
>> ---
>> changed from v3:
>> 1. remove wrong event mapping of 0x0000a
>> 2. add reference url of c906 events implementation (D1 only support events
>> described in R1S0 user manual, but event mapping is the same)
>
>Why'd you drop my ack? There's nothing here that'd invalidate it AFAICT.
>Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
>Thanks,
>Conor.

Sorry for this, I am not sure whether to preserve the ack.
Thank you for your ack again, and I will reserve this if no big change
happens.
