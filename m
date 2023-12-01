Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A88000DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjLABN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:13:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2094.outbound.protection.outlook.com [40.92.41.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7F910D1;
        Thu, 30 Nov 2023 17:14:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPgp6dFhVN3QEGk5RehRNQukzAW42xn0ctVIgnI96pwREQZKv0F0tCu9h0aBmN16Vwj1VBwivd/JSq9nPDJI07dTboH/E59QlPmVvvsSDLHJfL4bZLKv8pTqzkTnJjK4OEUZDn2YMNazpnIMJnr0i511Eu2jyla6AQCaF1LGmc4jgT1GhH9ErsUaIwh4gfHuvrCvsjUySSjM2Wa/1YAKCcEvEshRTbxq21SCoiUhVEhQcA/B0IC1F3kJI96J8kLaoItRS4SgW6JW/39YtN34tVqZG5n1VY5z9aco4siUEmEyr7SrssOdduofUw9ac/7f6VTARg2PAON3LDuFNTDv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo83G1rRJRvcbUMQfZ8EBJAAeEhMUZNNNMzOYViTmT8=;
 b=m+ietNhwn+emCwOZrbb9da8fGtGsKeCn3+0yquW4Tq8rAHZH2z0vGoTaogL7aproHGekRqbck8pG5cjsvwHplkcaMXO2pxzVn3mrPSje1CkWliiGrxiPp421Nh8lBmE2MaJCdcU1FKSScheMpisp3q2l/NXKR99D33T0mboxnxTaAPKxxQ9g15MjX5stEq/nCRNVPP6ylRZO/HtZXtLJKqSX8gPTJOGdzRoGNA5mvdsJWi6gFBEE3UW5gkhbZJlo3WC1N+hQp7MxcrwvYwDuu062DHMVTBt3iXekk31kh/O4gcWyCf1AwMkiEGbmJwAngyZn2PSYfP6zlWUQ4l5arA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo83G1rRJRvcbUMQfZ8EBJAAeEhMUZNNNMzOYViTmT8=;
 b=rKBhE64A9SAtbr3P9Q1NtIqIffLbxFKqi3hP+SpN5HOpZWLMKzmSBmzLcbZw6whw9yuFpg4HKHJBpXtrO61k2jzPFomTpERsp0QkJyJFUtlg7MNH8bhMfTcm4rkgG1luME/2ZhXuT/wR0kTlFM0ktkBr5EPS2P1kOhkTLGfqjt0mSaFKM2eG2Kd69hFodD8tXP9fPx5JEZy9O96N6hcjolk7SoL9RB32MMqEFgfWrqVEZnSkVhjtlzLp9nKZDJw3fkTgczuX7DdR4zvW1iLumn4oQnzH2BGemSu+BS/Ttiyba7kmX5QKsW8mF7SgozfmM42Tw7qkWZCLtU+Wv9VstA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5373.namprd20.prod.outlook.com (2603:10b6:303:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 01:13:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 01:13:59 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
        acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
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
Date:   Fri,  1 Dec 2023 09:14:00 +0800
Message-ID: <IA1PR20MB4953460FE5BF431DD32CD860BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZWhT_VSpl2aksVK7@APC323>
References: <ZWhT_VSpl2aksVK7@APC323>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [O6RBKd2btNqpAk3NbgN/5ICNp+Wi114JSt2L4aapwvA=]
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231201011401.103057-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 70909365-d44e-4e2b-ed30-08dbf20acc2c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gRh0N4KrEWKBS0O/+90zqEpMudlwnyFvBD0FH4+K56Bav0hsxXOtcwz7KO9mPg1SKrd0kSZFJ1OThf7su+HvD2xIJkntq9OvJFPM4U4/jWe5ArVzzm2iuh27HQ16M3sfp2oeSRV5ZTsKNZVzGEDymWlZlI27sKvJOWohSovfi531m5O3tdOP0VefHR9YPzhtc9w09tKXymPTf7ylW8Cxke8aJiQKU42mrtGBvPiedAoN2cabajsucOkztjTRfsUhfLNZUZQvdKt26WAaSv8oeN45whIJ7y0GAYRFh6NdsMdRkupaZW1e9kSPXQspFTHkvyCq91/t++7Zq2wXzScLw1oLO9KtmYCa/JGDiEDeq+FH+A2xd93k7+2JSXPM7l9XObOjB47moI9nrQM0mqX4AiSi652QggQnT6NLcPu8/e5qcEtaTS1hkaIJoZ8+zXzpQXvTmC5aOKM6ev+fAVOb8eI/Uig431ZxJXaTsgCSehgpkKAXolEUszLFe/xjEMwROlrTRCnY3PpvbB7CDwYD6hGgJtj6SqyQJrIrQk+sd6qIqqQuax62BLLGmFeeA3CEnW33r301SoTzicNYWWOPrhYd1R+Ed0al03uEVsWe9n65kI1wN+WpvzMhpq5VMTJOGFpLClWBG7NNkOpXf6YTlOdyYmsu9C8iLwA/lEs/B4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZkU3VMRjdXVVJTMExVSWVJWTRYOFFUcVp1d0VzbjdMQTdXN3VpNFduYmJ1?=
 =?utf-8?B?M1ZaN2MvSGtuM3dHS0RRZGhRWVpXbG90SXAvcW5WR1pPTjdyTnV1eklXZXVo?=
 =?utf-8?B?UGMxemV1Y2laWVh4eVlZSnZEbnpIT1l5d2tVY3lZRFh0Sk9aVWtSZm1QQTVJ?=
 =?utf-8?B?OGNSRldCdkNLWlBiNCsvbDVEd1R4Qy9sNUg5Qm5wQ20xY3RuV2ZsMjljSXNR?=
 =?utf-8?B?TGtYeG1pME0xMDgvUGc5cGxlZzZHVERvanZ4T1JQUzRNWFFudUl2T0hCMlNP?=
 =?utf-8?B?bmczclcvRnFZQ3NTSjZrUXp5UHZaYnNKLzJSRFd0cHFmcUlYQUY3VmN6WnYw?=
 =?utf-8?B?V0txTG9IK0Q0TU5hK1ZKbldndFVaOHVWR2pLQVpacFByOFZJZWJpbTFHa25Y?=
 =?utf-8?B?SnJlZ3Y3QkJvejlWSmhzWWxhSlVtc0tvMW9qRDdOcHFLRFdnNUI5akkydEtR?=
 =?utf-8?B?YnBTYUM0S2c5dkdRZ2tNcEE5NmpWRkVRaW9vOUUrMys3SzJENlcxK1pIWnhz?=
 =?utf-8?B?UTBmazRpSHNmaEZZT3dDUGpMSWhhTUdoR01RUWJwZGI2b09LT3Z6bU1DRm1I?=
 =?utf-8?B?NXFWV2E4S0xUeGJNSVNDM1lYdHovcUdSMXdUZ3ZrVDcwT1VNaFh3VWJrOXN2?=
 =?utf-8?B?cXE4S2JFdERpNzZoUlVabW5OdktOZGMydFJ6a2dFWm5rOVN6K2xVZ1IvVUp3?=
 =?utf-8?B?dWhGNlNpUXJ3WmE5RnRJZE1TU2pPTjNDMFJSR251S1EvbG9HbkxyMld4b3NG?=
 =?utf-8?B?akd0eEpGK29xdWZ0UitUUXc1Nk9uelUyaXJyU2x2Tzh3SElQTGdJRDJ6SFA4?=
 =?utf-8?B?SEJCWDNRQmVKMU1GbURIVlFyTFNNczlUSjNXOWp3WHc0aWs2QXN4bGVNcVpj?=
 =?utf-8?B?RUZpZWRJbENPd3ltWE51d3hMei96d3pud0N2YTRhUSt5YUN0TC83ZUpnc0sv?=
 =?utf-8?B?WHNHSjdiNWU4K2N2VTNUS3RSWUd0RFJDTmtUM2ZJam04elBCU0pEY0lBMWFv?=
 =?utf-8?B?L3ZDd3hKbmt0MzBXSjZ0bDZ6V1ZnYU90SkNhV0FmK3JxUkNtZFg4bDZhVEcw?=
 =?utf-8?B?S0R0MnhtcXltdmF0eGJOb1JWeEpuaktOYzVudWVwQnZjRlhqTm9LUG4vcnYy?=
 =?utf-8?B?VDNGY0tUa2N0S2p5M3BXOGtDQUFzNFBGdUlEYVF1TDlTaVNRRWxPN2FabDVK?=
 =?utf-8?B?cnJjM2wxOWFuakJYUTltTDdWS3J2WitHUGlZT1NpM2kvNmdvOGVrVFhWTkZX?=
 =?utf-8?B?ZXRBL3VWcS92bFZIQWJqcFZIVWRKNzVDeFgzelVRL2luelZJbEx2VjJIRFRv?=
 =?utf-8?B?a0xvcGo2SnRsYTBKdjF5aDVDcElwcFN0YkNCbDBVMDVLSEJJcnB3NlViK0h2?=
 =?utf-8?B?NE9oeEY1dlZ5azJsV3lKQzM1ZnZZcGRQMktrSTk3dEdoS1RKMGpmcUREVEpa?=
 =?utf-8?B?NUpVeHVWc2dsL0h1WjRHa1U3SWZoYUlNS2lRdXlOUkllb0U3a3ZWS3F5WFEy?=
 =?utf-8?B?cDFoQlRwZkpmYjRvQ2Z3VHpqZVN0dFpFTkZHcjBLR1ZQaGRPMzdGR3c4ZGRm?=
 =?utf-8?B?c2pycnVuUUNCaTdWZW1tY2RTNWVic3d2aHVrSXpzYUx0SHRvR0VZU2FqM1FT?=
 =?utf-8?Q?PmhspTENY+DTMniPQiv4WrlVP3wjYLuZ3U6UGLcpqDUc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70909365-d44e-4e2b-ed30-08dbf20acc2c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 01:13:59.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5373
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
>Hi Inochi,
>
>On Thu, Nov 30, 2023 at 04:29:22PM +0800, Inochi Amaoto wrote:
>>>
>>> Hi Guo Ren,
>>>
>>> On Thu, Nov 23, 2023 at 05:14:30AM +0800, Guo Ren wrote:
>>>> On Wed, Nov 22, 2023 at 8:17 PM Yu Chien Peter Lin
>>>> <peterlin@andestech.com> wrote:
>>>>>
>>>>> Document the ISA string for T-Head performance monitor extension
>>>>> which provides counter overflow interrupt mechanism.
>>>>>
>>>>> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
>>>>> ---
>>>>> Changes v2 -> v3:
>>>>>   - New patch
>>>>> Changes v3 -> v4:
>>>>>   - No change
>>>>> ---
>>>>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> index c91ab0e46648..694efaea8fce 100644
>>>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> @@ -258,5 +258,11 @@ properties:
>>>>>              in commit 2e5236 ("Ztso is now ratified.") of the
>>>>>              riscv-isa-manual.
>>>>>
>>>>> +        - const: xtheadpmu
>>>>> +          description:
>>>>> +            The T-Head performance monitor extension for counter overflow. For more
>>>>> +            details, see the chapter 12 in the Xuantie C906 user manual.
>>>>> +            https://github.com/T-head-Semi/openc906/tree/main/doc
>>>>> +
>>>>>  additionalProperties: true
>>>>>  ...
>>>>> --
>>>>> 2.34.1
>>>>>
>>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>>
>>> Thanks for the review.
>>> Would you share document about T-Head PMU?
>>>
>>
>> Hi, Peter Lin:
>>
>> You can use the following two document to get all events:
>> https://github.com/T-head-Semi/openc906/tree/main/doc
>> https://github.com/T-head-Semi/openc910/tree/main/doc
>>
>> There are also some RTL code can describe these events:
>> https://github.com/T-head-Semi/openc910/blob/e0c4ad8ec7f8c70f649d826ebd6c949086453272/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v#L1123
>> https://github.com/T-head-Semi/openc906/blob/af5614d72de7e5a4b8609c427d2e20af1deb21c4/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L543
>>
>> The perf events json can also be used as document, this is already
>> applied (with more detailed explanation):
>> https://lore.kernel.org/all/IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com/
>
>Thanks for reaching out!
>The updated description will be:
>
>- const: xtheadpmu
>  description:
>    The T-Head performance monitor extension for counter overflow, as ratified
>    in commit bd9206 ("Initial commit") of Xuantie C906 user manual.
>    https://github.com/T-head-Semi/openc906/tree/main/doc
>
>Is it OK with you?
>

Please indicate chapter 12 and chapter 13.5 of the manual related to
the PMU. And changed openc906 manual to openc910 manual because it is
more updated.

If modified:

Reviewed-by: Inochi Amaoto <inochiama@outlook.com>

>Best regards,
>Peter Lin
>
>> Best regards,
>> Inochi
>
