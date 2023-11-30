Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26367FFF41
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377213AbjK3XLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjK3XLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:11:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2067.outbound.protection.outlook.com [40.92.23.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCFB1B3;
        Thu, 30 Nov 2023 15:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDWDdYvSCRgicLmSfsRGH9+d2hzz6qpVphF8tx4vJOswfzJS/9CuoA/MmdN9jO7q31AwdmNSxVI5QmbtVOR9lvM6m4QZngJcUzXQQz6Ceak5QUCwPXEijasNniqjsg+jsxIM5bII9+4AGSNEo0XRvDhTzJT+imYxK9KwvyQWGlunW65ytHUxoogdOQdQfs2upXcS1CINlmIcLAShvTK+EUn9/fuLOfGPH0ScE00ee+HrmIyx+sbpd6JY3yO9UEBaj60TOuTpLKGXnSAT/2XSQpPgmTMQ93KBfjm9IxOz9kU/H6ho8sk6YSNEXUB1CKNATONJQQGGuDDpacDxAbCLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8BHqhZn4539bNCaSZPXRguwoIBBdI81N4SjxUZcP7Q=;
 b=RtD6N6ZL9dtgVhqWkKepLudubHDE+UKy3XmwFzMYrfloTdZVJHvr2oR101kIjVd1nzzBPhkS9Ani6XSy9GVELlzoEIekGj9pnb8+oeKAEQ/lWQ28fwptxJObPICxjI91K6tGSov0NNVRjV76z5qmCN8tptCVVhTiuZyyxx/UBWyHzEiZRWXuhHTRC+hZYuFDCXP75w5WYk7dOGT0WVYtQog8YdqvaYn+64FF7kkxr2JJIsZ5/k+j4vIplOT6N2mt5iw5m2jXyEE8GreggxbCFFUwTPlToT6W+kDhkjYOR4kaWhf1tkl7adb/QRoCGir8mDZXMgu+pWLe/y4G4WBqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8BHqhZn4539bNCaSZPXRguwoIBBdI81N4SjxUZcP7Q=;
 b=X9z/nyoiPYsGVOFEhb5X9udEei8ZOdV2QqQj5W0yFBZ9gWjuC51WyNhK1Sb3auKG4XHR3KqgMdLky5cg7+IaRTdz43piMCCaTsfN/jUkMzt3sGnjiq2jkba84+ywE6pD5mx/drqc51SUgF43upTtxVZSAkgFn/ci2z+LaopgYcNymtFvTO11HbnA+5nW0yhtD39TudHTDAWowRoD49ZOffPaaXyrmKLeA0SuBSeMDpqPSV4Q8z0IP9g2aU76G3vNfmx+Y5Rv0w+CNoIDrUXj0ZIk1jFMYIbVD44RRyx02B1yjQWwE4ccn0S2b6Sz9k5jflccz49Qtl9c+GQdcA6M1Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB4579.namprd20.prod.outlook.com (2603:10b6:8:5e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 23:11:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 23:11:42 +0000
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
Date:   Fri,  1 Dec 2023 07:11:31 +0800
Message-ID: <IA1PR20MB495378652B09B37E92D8BB04BB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130-isotope-runaround-9afb98579734@spud>
References: <20231130-isotope-runaround-9afb98579734@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [ncJoUExl3SuevRzpqks02K/yP4DXvlwShqlGCXmGcak=]
X-ClientProxiedBy: TY2PR0101CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130231132.9090-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: a06f4373-8804-4e35-0e7e-08dbf1f9b675
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lruw79LHkd+PYq272i8fkuGmuCThsHqF9UnT3vHV64in58VLYZSC0M9oCgM42UVP/+7PaerSiBGY3V9qSXdWZW22rr1U86D8qpKtXo5f440NrqbTVHN6BH9X+qnfSJnGRuBP4l5emS2Roh289veP/sRh3nG+a20o85uuUHVdJZKc+YxO6MZUXe06zHsK63tPSWxGYh4TR2dPx1scI5dX42l+TYnb0lg+aRkwq77EMJ2Ui6sUYTYQVg1t3YXgiIrhck9gMQ1pNkLgOmd80yBtUalJkrhNaZQsQKVk0/tJ2v+uk4rLFWQBGkcdb3p/HJT2zjuzXFxkswmw9fC5olBEc3THtxvFWOBtzAMe2iLj594Zp1zM4ib0jdwJTyGct4MNIY/j6QMfj5LJCkdtf866ZKHs0DrFpu2JS1bibg38G8x2X+OgLrYyvDzmz7rPMwWFYC+mlk33MruGmTuGInsdYn4eEjBkk7Ol1m1rzAKW+13KdME/gcvB84YYLp2SeGSelXlg/K8LwA2NlxRnS411RFS9RJ8uctUcEZSCpaMXPVLAT/Hl/Sw+ztRGXNXCsB+YE/OWM0TF4e+qpQfYj+hFdF2wpB/BDkmJu5ITh807iLFPyOpPBhD+y2zx4Ek261TcyyWbHEL8ZAOXqTGr9o5ezV6gc/nax/rmY+PR0QugLo8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmgwUHhIeEZjSFp2MTVJSndrbjc0WTMvUjAzU3Ivck56ZXNRYXRBYU1EanM5?=
 =?utf-8?B?UFE2REpnZ2N0OVFUcVdJSms1ZzB4UlozQmt1Qk9Cb21GcHM0bTRzaHpzR3VD?=
 =?utf-8?B?L3VPZ05JSXJwWEZKdDJCaWgvSVFoTGROTGNGZ0liWmd4VmpHdDFmTGhKMXM1?=
 =?utf-8?B?L2RaaTgzc0lMUHc2aHVzUUN2aHhTU2JacjA5UmhvZnNiMiszZS9ZdmVKVlA1?=
 =?utf-8?B?T1FPbkQ3eHRpNWJ5SEdoTmNJVmZweEw2dG52ZVhGYUx1bHVkWjNCcmVvV2xI?=
 =?utf-8?B?SWVDeldRMWVleDZJQWhtb0FFY2RURDIvb1lHbklnK2txUjRabkZKUW8zNkpT?=
 =?utf-8?B?VWY1TkQvMFliMnRxcEJ1Tk1sU3JRK0pKeUI0a3Jmb2R0T3pZYWxjTldGTWxS?=
 =?utf-8?B?cW9ydWtRSlhLNS9mWTdTbStGNWg0MFVRNTdSd3ZaMDkwWTRqVXg3NGFGM3Zx?=
 =?utf-8?B?dHNnZkRLbTA2eVZRSVFweWZCUHVHMmVRRGtKRWVXaUxjMnhTNTFVOUpWU0xz?=
 =?utf-8?B?YW51M3BwbXJrYzhoMHpTT2lIeEVOdlNoWnlCOXd1bk1wQTgxbmlIQ3Q0cGVJ?=
 =?utf-8?B?RTNBdnAzaDYxVEpBcTA4a0F0S3Q4Wmxzb0FoNHROc1pIcy9lZEE2Y1YxQSsw?=
 =?utf-8?B?ZU90K2NOSzhINGdvUFRCV0VmTlRIa0tLbWJDYjRzek9KbUtJVHd5S29VYkFJ?=
 =?utf-8?B?RHlKendPWmV0UXBnejEwdWZsMWd4djVSaTd6ZSt4ZnFiQ0VpaTRucmd1cll0?=
 =?utf-8?B?TmF4bUhVeDh4eERyTXpMd0R3cndlY1ZrTklvNmVGbDJpcWo3b0orcXF5VEhW?=
 =?utf-8?B?RFpYN0hJV0lTTWJETngyalpGRXJoRFVWdW5SNk4zS1NON3V1aHo3cVdHWlY0?=
 =?utf-8?B?NUlhUmpzUXJnYkZBWlhxc05BL3ZaeDdnVU9NZVMzaFNZQy9xaXhabHJoRlZz?=
 =?utf-8?B?aUhlWnE1TEhCYWx5elFwWXFxUFljMnRMK3l4enM2ZlBjd2t5Y0o1WHZsT0Zr?=
 =?utf-8?B?S1B4UVZKb20za0lGWG9QemhUdjFKOGNlTDZGTWRFa0dmRmRGZlZYNUZKVVI4?=
 =?utf-8?B?ZURIOVJHdklFdUxhckNnOUxZUzVWYll0R3poa0JPT0JnOS90OWtyVmFqWU5P?=
 =?utf-8?B?RE0zL3JmYXVrYmxGV0lTQTkrU3ZrM3hmOUxMUnBuS1UzbS8zYnBieE45WEYr?=
 =?utf-8?B?TXdCU0NlM1dIWXl0RVcxeGYyMnhxaFhaWGdLVkdaVEQ1d1o1NFNoY2RzNGV5?=
 =?utf-8?B?a2FWUUdLb3F1VUpaYUVxTE93aENKQW5sNEl5WmFCYk5ZSGtRQnJPYW9YREY1?=
 =?utf-8?B?Qk9lQ0JxRHBoQTdWQUpyNFphRlZRTnpXZWN5K0NSZ05GQmRsUFVCTWxCb2Z4?=
 =?utf-8?B?amQ3TzVPYk0xblVTWnZxdllMeU9jbmU1REM2RFdaaFU3ckFmVFJqUUQxNWxL?=
 =?utf-8?B?ZExuZURKTWJ5L0ppMUZCWEdDcDB2Vmx3T0hyWnJMZDQzR0VuNzR4U01aWkx5?=
 =?utf-8?B?WXdYb0wzRm1QeVM0cWplMG9uZzRqTGE2OHc1WThJcjNPYUZpSytiV0t5Z3JJ?=
 =?utf-8?B?NUx0STBYbDFUMUdoTEcrcmY5ZmNBUGxYb0gwUHFPN0ZYVWxKSmlHZHp2VVhr?=
 =?utf-8?Q?GJj7RzLiRVQ/RbX4hRnOqJQZdnkTedKcKs6RQN/bokyg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06f4373-8804-4e35-0e7e-08dbf1f9b675
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 23:11:41.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4579
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
>On Thu, Nov 30, 2023 at 08:16:38PM +0800, Inochi Amaoto wrote:
>>>
>>> Hi Inochi,
>>>
>>> On Thu, Nov 30, 2023 at 04:29:22PM +0800, Inochi Amaoto wrote:
>>>>>
>>>>> Hi Guo Ren,
>>>>>
>>>>> On Thu, Nov 23, 2023 at 05:14:30AM +0800, Guo Ren wrote:
>>>>>> On Wed, Nov 22, 2023 at 8:17 PM Yu Chien Peter Lin
>>>>>> <peterlin@andestech.com> wrote:
>>>>>>>
>>>>>>> Document the ISA string for T-Head performance monitor extension
>>>>>>> which provides counter overflow interrupt mechanism.
>>>>>>>
>>>>>>> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
>>>>>>> ---
>>>>>>> Changes v2 -> v3:
>>>>>>>   - New patch
>>>>>>> Changes v3 -> v4:
>>>>>>>   - No change
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>>>> index c91ab0e46648..694efaea8fce 100644
>>>>>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>>>> @@ -258,5 +258,11 @@ properties:
>>>>>>>              in commit 2e5236 ("Ztso is now ratified.") of the
>>>>>>>              riscv-isa-manual.
>>>>>>>
>>>>>>> +        - const: xtheadpmu
>>>>>>> +          description:
>>>>>>> +            The T-Head performance monitor extension for counter overflow. For more
>>>>>>> +            details, see the chapter 12 in the Xuantie C906 user manual.
>>>>>>> +            https://github.com/T-head-Semi/openc906/tree/main/doc
>>>>>>> +
>>>>>>>  additionalProperties: true
>>>>>>>  ...
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>
>>>>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>>>>
>>>>> Thanks for the review.
>>>>> Would you share document about T-Head PMU?
>>>>>
>>>>
>>>> Hi, Peter Lin:
>>>>
>>>> You can use the following two document to get all events:
>>>> https://github.com/T-head-Semi/openc906/tree/main/doc
>>>> https://github.com/T-head-Semi/openc910/tree/main/doc
>>>>
>>>> There are also some RTL code can describe these events:
>>>> https://github.com/T-head-Semi/openc910/blob/e0c4ad8ec7f8c70f649d826ebd6c949086453272/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v#L1123
>>>> https://github.com/T-head-Semi/openc906/blob/af5614d72de7e5a4b8609c427d2e20af1deb21c4/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L543
>>>>
>>>> The perf events json can also be used as document, this is already
>>>> applied (with more detailed explanation):
>>>> https://lore.kernel.org/all/IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com/
>>>
>>> Thanks for reaching out!
>>> The updated description will be:
>>>
>>> - const: xtheadpmu
>>>  description:
>>>    The T-Head performance monitor extension for counter overflow, as ratified
>>>    in commit bd9206 ("Initial commit") of Xuantie C906 user manual.
>>>    https://github.com/T-head-Semi/openc906/tree/main/doc
>>>
>>> Is it OK with you?
>>>
>>
>> I suggest using perf event json as event description. The jsons provide
>> more detailed explanation for these events than the user manual.
>
>Does the "perf event json" describe the registers and interrupt behaviour?
>

It does not. IIRC, the linux just uses SBI as perf driver backend. So
the registers and interrupt behaviour is primarily for SBI developer.

For registers and interrup detail, just reference the openc910 doc url
(https://github.com/T-head-Semi/openc910/tree/main/doc) and the T-HEAD
PMU driver in OpenSBI.
