Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EB7EB98D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjKNWo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjKNWo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:44:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2029.outbound.protection.outlook.com [40.92.19.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02593;
        Tue, 14 Nov 2023 14:44:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5yTw4v9cF2/wuk7YVDNITql0CocOOW6BIc2Qm449AHLk14v7XQ/6Xxn+TsBZ+0XZQrEWKjM6xeTqq0cs4lpKG8c0wVwndiwF89a11bz+qZEmSMWVN1VZTRx00nBcFoM26D5odqfujnhzPncJ8aiU2X619gqp+bYGoMye5AzegAAwMLo+hzu3Qc5CTgSyovF4tNU2cxHdwQvFHDoqhCSm7IEPgquVGEVgQq3cLoTaiP7uhlim5RguIXaZUxYllNpPPD52tFOOzSWB4NmWhxnXdyOhJ6XI9NuVWdpkhGm2Jtwg19levvhvNfHDqkutnzxXVlrcJibES+b4dUM7GLRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd3YlwADjs0q/lq9cwemtN8wXinAad7VFsxIJYbU+UU=;
 b=eK77xErvEVQNTGGw4/GS9SjU6rMZaMTwmsZkACzdMOLwkNwZtPDOh70tL+MheANOMHS0f/4qlAv4N/SFH/q6nFMNYBxYtLBusgfR26j206y2aREqH0jWNN1rTg30O/jm89j4BNGaigo/Jdiq63jMuDonWYu8hAXUT+KGPUVK66NkKRTp3A94i+t2rHMUtrlq3akslf7EwF/Z3w2fGz+g8RLd4kjN81LbJovMvIT+/R/loMOz0QhHzMwPOssWLNr2EPChIF96u3oPKBklWb5XZ7dhR3tsOjBSKmw0JQF3H9hQmEVr2SwldT/XtLj42XqyImdZXEhy+xSInOXPb3110A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd3YlwADjs0q/lq9cwemtN8wXinAad7VFsxIJYbU+UU=;
 b=gBPAqp1VK5zq4lZaymVflaVRc1VHBmVki7bK5pmNSlaZU/8pWq56QjKcDkd/XX2zJ/rIgHNXSYnfV5AYj9bkcht4fDuOLrfEoLx9h9+rwiUxRvPpU8ID3izoEP+6ezRPcV8ESTIx4vBH2K+/m1Ct9QE6zW2yW2MWL+5ck08kCj6/P2mfOX/WOjlA+IRZR5covlgO4DgemEi8aXibtl/r2GeJbIfbPHxha+2wmvSecTDAvqcc4boHtcjHuYoHHqtYSNCT4A4VSFVyiyJZZcDvA1IeAMhd4/e7qZ+Kmjn07owO2hxd1CVLc+QKs4eVHcdynoxbuDBW9O5BzGDcqx/jtA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5424.namprd20.prod.outlook.com (2603:10b6:303:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 22:44:49 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 22:44:49 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Wed, 15 Nov 2023 06:45:28 +0800
Message-ID: <IA1PR20MB4953FF1A8D222DBB4E580E06BBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114-outweigh-sandbank-6bbdd7ea3286@squawk>
References: <20231114-outweigh-sandbank-6bbdd7ea3286@squawk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [K/kkuikKH/smAgXDudtx0dGy2oNtA8KzSg8vJA6pRDw=]
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114224529.5599-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbb8241-54b6-4c95-7dea-08dbe5634e98
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbwgObdNqnoklvps465EDUMw2pN2ClQT2HLYur9KRHtNtj0I2Ul91tre2ujLPm2l8bWwhT9ptXVuc6SQj3Fl90Q+7mF2+okAOYPjX+l5alD5EC70hbO4sYRYhoNtdBJHBe8HVmWJDRv12SGnF0I600njS/dJb8NBg6bkuagOnYmYMcqaM1VtKRBNTPy0b6NpEcK8tqSYVojMpVdUA9rVuWPMR+yy/w4wmd8GkMlodbkdMegH8kQKoRwJq4Xo+g1s+gNdwPo3Z7XqClCYotDon9sE3mqj7RQMhDMyInw132BTrXh8JZMTG/5kh8T920Qi2JbYHCcl97IEZ2b0EqY2+nd08HveGRllnE6vSe6sUqiFXK27IPD4W1J2bMIK2xXopomb5AdmEv3JcbfP1PbAAsTDy8aSW+Img5d1BDG4N4QupaGC80nwPPDwW+jS6nDBoM22SFnQG7TjDdaTuLGdDUet2Zds7d/JDXijYp0CpdKO8qoAy4NMf9TdWb2Gck+H+/0UIrvM/wAQqeOJO1fCLKx/7dEjuLN5hV93wVPB2gAjZZv2abMo8qzQ0sivGyIqT34bnVZlXYjQuSjNWZ68VQ0/4iwN8AitvZSeKMAUvs5X9KbbIan1axELqq3G350T
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UByc7474qdYP4QjTCvwCj6Y8HVfcWFyo85uj+18CIjLd+YA3ScntRp+nrGZe?=
 =?us-ascii?Q?F+OVCW1sBibSmXD0dx0FP/S/ElyWO/UWtvcDHV9wAOxyd3pkn8nPa3ocpsZW?=
 =?us-ascii?Q?AuS3+DjmAlc3Qu46VTnyLC8YdhvyMBnSO2Y9zgmuYhl2h+l2JehRzMLk5jhf?=
 =?us-ascii?Q?R8DuDff7mvmA/GMg1H4l9PXS9DI17xNbyu21G6sojlR/tCGyUtTee20vmpUD?=
 =?us-ascii?Q?sjeYkb1W9/TfbEIYYhJhb3kFRGMV+A2tDyI41CdzOmZGiscdhB/MYDS/JneS?=
 =?us-ascii?Q?DMP3qkgsquPG+KclFIicv6+TJ3sE8asPzx8fEDMQW+2TaWXGV4qCXGu7aeW3?=
 =?us-ascii?Q?WN4Ddmonfz8Huf1MQZTfWo/VWEFCGMZud4zHemtwMDU7dPkCnvV5wyg50GpP?=
 =?us-ascii?Q?zmPA9lWfDynm008/JjO5WAZm2fmMDSHzpl0DeF+7RbhcjY4gO/xGqaiKZZu8?=
 =?us-ascii?Q?XEvBhxr9ouJJpRvetCIOqpnLIdJRobNtX/9yxnPvo41mzUslkcwz1M7Ny8z0?=
 =?us-ascii?Q?0qDRksQK1rN+7H5QgDluKaVPFhD340hJ5YOnqAn0jwYEoBjbiALtv1e4EP/e?=
 =?us-ascii?Q?X/chphGeRITF/MJjujk8BZrbq2cFdUt9CUToNjzAenvmOAX7lENCJQHnqOPp?=
 =?us-ascii?Q?M5aseVzS3BqX2bv7PRze5ZI+ITxFreaMVd0TUaMBa2QeQ4hS9WGk9kyig/Xs?=
 =?us-ascii?Q?1GY0lLlufw/9XN/AyTdPdkm9Xu5O6LS7f8gUFRh+4PL8l7hv42pmnjRoOhZ/?=
 =?us-ascii?Q?AM6KKrpNeCLkLbSceoS6xfzd8pHF6MN0P1c7lVsa/EA99Nq5u7E0nEnePm6Y?=
 =?us-ascii?Q?X6VRFT3b5M62WXb2bMqHx7jtKF+9m4IsC3I08Z4U2GmkMtLYLqKtfR9Uedmc?=
 =?us-ascii?Q?l2N8nv5B8ZeHo6pVv1DqDfRV1A4K++VVFQ0If139mMROc3ci/6g9pnFCmIGA?=
 =?us-ascii?Q?uXYWxS+0N3pImGEc2tEQm0yVylNbROp+YRzVZU/9R2uThJMthAZ+kxMIBT1+?=
 =?us-ascii?Q?g6GybKlV8KhCte413KzOX08kj4GwAENeLQxu1CyrZareIwNgC09UGdhAYJky?=
 =?us-ascii?Q?sOOh0/3pd1JPWZIWcgryvM7seg/aIEQwMspNAbQtx/Z+UCgjsEQWZZpwXjLs?=
 =?us-ascii?Q?HdNWJ+Xwobr68jtbo9guDPfo9WZ5rb0d+nzMTiac3YFQDOjpP3nIkAIsReC5?=
 =?us-ascii?Q?2ay1fh9PElSAZDjioHBJUzqH89Jaqz4+1F1kHdLyFZtvc2h9VJ9jHKKOCUE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbb8241-54b6-4c95-7dea-08dbe5634e98
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 22:44:48.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5424
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Nov 14, 2023 at 09:45:33AM +0800, Inochi Amaoto wrote:
>>> On 2023/11/14 8:45, Inochi Amaoto wrote:
>>>> The timer registers of aclint don't follow the clint layout and can
>>>> be mapped on any different offset. As sg2042 uses separated timer
>>>> and mswi for its clint, it should follow the aclint spec and have
>>>> separated registers.
>>>>
>>>> The previous patch introduces a new type of T-HEAD aclint timer which
>>>> has clint timer layout. Although the timer has the clint layout, it
>>>> should follow the aclint spec and uses the separated mtime and mtimecmp
>>>> regs. So a ABI change is needed to make the timer fit the aclint spec.
>>>>
>>>> To make T-HEAD aclint timer more closer to the aclint spec, use two regs
>>>> to represent the mtime and mtimecmp.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
>>>> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
>>>> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>>>> ---
>>>>   .../devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml  | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>> index fbd235650e52..c3080962d902 100644
>>>> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
>>>> @@ -17,7 +17,7 @@ properties:
>>>>         - const: thead,c900-aclint-mtimer
>>>>
>>>>     reg:
>>>> -    maxItems: 1
>>>> +    maxItems: 2
>>>
>>> The first one is for mtime and the second one is for mtimecmp, right?
>>
>> Yes, that is right.
>>
>>> Recommend to add some comment in binding file to make it clear.
>>>
>>
>> Thanks for your advice.
>
>Sorry for not noticing that on v1 -

Sorry for this, I have seen the v1 and improve the comment of the v2. I
will give a feedback next time. Anyway, thank you for your advice in v1.

>you should indeed describe these in the binding, by using the items property.
>

Thanks, I will have a try.
