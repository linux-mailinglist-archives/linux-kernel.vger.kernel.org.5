Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637687FEA93
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbjK3I3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjK3I3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:29:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2039.outbound.protection.outlook.com [40.92.21.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ACD10F0;
        Thu, 30 Nov 2023 00:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc0tBwpg/ZdzqGBY4sADoowzVDOZyBXXOkXpIm16krdRBYiSvYhO/hIxbyfP6YwN/lFm2RCtPqxPPzVFyCn84YYZp7Qe/D+vmqdmcs+iKi2pjC3fR5LtL+Ge7OQhR6mfcNIlw1sgCaA73CZ2KLSToLV0mtpRvAeYZMEAPKFztqHRvwNw1t4xVXN812sgPbBGe99aTjSd2IlGoyGNYnv8wm0lE7G0sguB7CCk08o/TTuviFCriolDyjDk3LV7YGtK+0vBeu41P3BIcXN5PmjWJT+13qR4uuhIkAqTam10/EX8yvg9XoqT/PHrAtE4Y2OzUeIIrSP6BIHMiNSkIo1R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuS3J0Mb2RKzFcskZ/u9lKpG1xUxld7DKBvalFR5ETc=;
 b=CoLd4zrKs7xt0p5fi1IlE1VcmxNUhFVQ+hZiFj1pxNsICMOEQu+AG/WlvbZarYN7yEDkWxrtgbDIYhx+AlCF8gVhJheFMRWaRujbUwDOPH8+nJWXi1KB1bVy3kskGjva8MOLVvi027rupp0SRT7bIRFYSl6dBZGGgS2T/a20L9PjcuFdvaiBWneAeeZhusSMs61jipCF9ieuEs8niK56VNUNqc7dgcbecdWY11JUBrGoqsWC6mTU5obszmmy+SQW5/A5g1IFlcDBtnumJ94dNhckaNZ6sEXzcBFPaiXWzuDpTFD8wJdnj9YayahKSBEF/LSBDDLZwTgdXO+mDyuFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuS3J0Mb2RKzFcskZ/u9lKpG1xUxld7DKBvalFR5ETc=;
 b=ei71DpBgglKmI2xbQn6yIpk0JIqGpQ3DsyOO9lQUEX3eLsGIk8iTthqwoR6EV1mPmxpfIqjAkM8elYBh34AG5WTV6dPr9rVinbR57B0gvpfcTrbM0q5Lfhbtaa8xknCn42MCK4uuwIlap6iMZNlGm1vJr3foCkrNvA8xyMzQIQdk8Y0Lwt8PMFcPDr1sT8m6XHS7bT9tYKxUn3hPsXRIRtsqVUFE0rABZSVR13lUDgmIMTNYvAbA+FfvNnQ0nrUyGs8GVxEwRPa21dOY1+ieVM+bcKm0pzjQKWOssGf6XYZqRUU4VYHap5sxZNQrGXgQlxjCY9nsR4Sf1vxmZ5xYCA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV2PR20MB4677.namprd20.prod.outlook.com (2603:10b6:408:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 08:29:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 08:29:24 +0000
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
Date:   Thu, 30 Nov 2023 16:29:22 +0800
Message-ID: <IA1PR20MB49537364BDF1ADE185CA8FE4BB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZWb6-LEkyh5RRpcP@APC323>
References: <ZWb6-LEkyh5RRpcP@APC323>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [EBa3r4hqDh0RrCv7sIxmB+P9fF6W+5EBDmKKlKMZNfo=]
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130082923.329153-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV2PR20MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3eea9f-f97b-4dec-37bf-08dbf17e7561
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xisGXSkcn1uetDq33P2fZ8q455etabpBOtR7zrHsBtZfNJ9AOW526dIoHAXI4vDRJXYR9PVgKdP/RBenqVDdFrV02oVndu24TcYGBB33KeI+xsQ5yK6C/rj8VJjeeEzNCMOE46o4J24CVNdTSu6prKKLHW/7gMH6HHw3ZSke6FG0LT8tWKCkVsNq51eh/LGAKwreJSYYtoApROJJajk7SnufPUpvxS0np8bCkoLgwORe+2HRszVLhQYYj8DI93mcy81ohsyHCmdA51qA/bURIRPDlfZTkKjSfGOO3TuiCLPGkL3GvdOXM4gaBVwnCNFNOOL9I/Zl5tzuFRpLzk9CqmRb16iFLWMoiFu8if+WJizx/4m33qmEKD1RNneh0tVOp6JtmEQ01InwnNufS3/ewtr+ZBI1VVbPpqp2o85Hjcb/F/DRAWgc4so35ZRpeWTrG/egGCFRtL5zh9XnbfTgxTCNIEmYD8Z+DXgvjbnamK7wPpAC4pZ6ZjJKchMBfnjbhgaE/ZWTb7sBhczFd7qSLF30gTalc1q/EAVkBvMk5rZFD5BKca+rMcjjALSZhLhVrmJ47mBWP0jVQx/rZu/XC6IhHn7+1Nz3T3i0F+TPihUvImNiOkBgsosDC7KiRZe480fiVAgJl0giT5FgV3aMTnbOoeiRbCqmwxDe3fYkEhU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExRSXhmenZtUms5SEpiekdUODRUREROM0NIL0EvTVBWbDV0YnBremhrZWNr?=
 =?utf-8?B?VmtSZWJldlhGbWI0M3hsc0lwUG4zV240L3BRdzJXTnVpS2dOVjloNE5NUVlx?=
 =?utf-8?B?SG9HVFRDTWgwVDI3RHFkZEVNTVpTWDZyOHplRmMvOXpXVWZLK2lmdVFzZGs4?=
 =?utf-8?B?ZDBSc1FUM1BiY1VPdWZhRVZ2cUFBdUx2L0pKNlVSMUQyOHdubkFIdWtKd01N?=
 =?utf-8?B?bGpJdG85ZFB3TDZ5WEhEc0ltVVdnckNXMTZkNGd4a25mZlFuSXRWVWJUR1Rt?=
 =?utf-8?B?bXpqWXRjRGtTTVlwcU5tWld4M1p4NzJaMzNlWjdEZlhiNjZjYjkrUXlwK2xT?=
 =?utf-8?B?MGJseVJ1di9zWTkrSWZCdkdYbVQxMVh6R1h0dHFnTHBPeFpLNGp3QjA3ek0y?=
 =?utf-8?B?aUVZT1JtVlExbmt6ekJ5d0pET05DWHo5eStPdzc5cExDTVp2TXZwMk5CMVE5?=
 =?utf-8?B?RmdodCtFeHpuazVYTXZrZWlUaEFWVFFKQjc3ODhEVk1yZVNqbFNBYWtsR0RL?=
 =?utf-8?B?Zy9PUUQ1azFFRk0rVXA5bW9QRnY5bXJ5RjV3N2hweERXdks4OUFoc2ZIL3gz?=
 =?utf-8?B?YTFwTGM3dmswbnFBWlp3aHR5VkNyTGMwTzJVbGkvMUY5K3g2bVBOTjdUaHl1?=
 =?utf-8?B?eThuUjlpSWJIWG5aRGJkaisxZ0xLODBlMDBIYlNVUDZkRjNSQ3p0eForbVZ5?=
 =?utf-8?B?SUxqbnpjVnZ5TVdHSkk4S1lnU0Z6b29TQkNuVGNpK1NETHQxMXU4azNxMjh5?=
 =?utf-8?B?ZGhwd2JrUGhodnVwdFpFTUkwVCtmMExIOHZ6MEdacU1EaTVYOFdtakJBV2Iv?=
 =?utf-8?B?bWxteS9nd2VZTVI4MEZyN2VLYlFNajNyVmRCQ3dDZ2dkcC9qQVMxbXJmak12?=
 =?utf-8?B?bDRSK244NDVURTFmK0JRakpJT3lIb1JneTAxbmxFQUNDZGh3MHNVRmtCank5?=
 =?utf-8?B?QjN2eEluUm5HY2s5dU5XQ0hwa0U2Q0FDVjg4dy9qc0ZzZlp0UUJKYXgrWnNL?=
 =?utf-8?B?ZVBTVGYrZ1BYUUhOQWpLWm93UktBcmd5MStOOFdYRFY0cjR0YW90Z0s4TTdM?=
 =?utf-8?B?OU45Y00vQmVvanVnUmhuSm84enNKSUhMeG5LSUdkbUc5OGFKWkZQTTB0QXRn?=
 =?utf-8?B?VnNzRlJjYkFaK0krSVBvMitIMk5PVFo1MU04QnN3TnY4VHpxUXluNWhqSDBU?=
 =?utf-8?B?cy8zdFZQQTlQampGTmV0TCtrZ1ltWUZBZUkyQ2tkSW5WQis1VXZGNDJaRGc3?=
 =?utf-8?B?ZnFyR2txd1dXalNqNDFLQzI4YjJieXJ5ZmVuTFFrbTJ3NGM3bUFpYWREZ3RJ?=
 =?utf-8?B?eTd1Uno4U0NoOEw2NW5yQit0Y1hROFcvcHhGS09kNldpZ0VoT1N5Y0cxVVVH?=
 =?utf-8?B?UU9MMGdTRjlXMlRadng2ODlRc3U0SENpS3Q0bnJ3QTZTV1pHZ0xzeStQSE1Q?=
 =?utf-8?B?N0czbC9FZndybGljTko4NUo3WGpFZktvTlRZeEtQWno0aHkrb3hrTXExWGV4?=
 =?utf-8?B?NUtvTnh5OXJkRkVBRk90S1lDTC96RFFDei92RWF3VUxXcWc2TVc2L1ZwL3B6?=
 =?utf-8?B?aFgwR2VvUDI4K3hsMmo4c2NyTlFJbnU1cDdKOUpDbFMwVUtkdTNWQmhrR2ZB?=
 =?utf-8?Q?zXKwDrWghnBg2h9P+9Lq+YQmkB3iGbEKZW/ow3LnF1cA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3eea9f-f97b-4dec-37bf-08dbf17e7561
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 08:29:24.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB4677
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
>Hi Guo Ren,
>
>On Thu, Nov 23, 2023 at 05:14:30AM +0800, Guo Ren wrote:
>> On Wed, Nov 22, 2023 at 8:17 PM Yu Chien Peter Lin
>> <peterlin@andestech.com> wrote:
>>>
>>> Document the ISA string for T-Head performance monitor extension
>>> which provides counter overflow interrupt mechanism.
>>>
>>> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
>>> ---
>>> Changes v2 -> v3:
>>>   - New patch
>>> Changes v3 -> v4:
>>>   - No change
>>> ---
>>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index c91ab0e46648..694efaea8fce 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -258,5 +258,11 @@ properties:
>>>              in commit 2e5236 ("Ztso is now ratified.") of the
>>>              riscv-isa-manual.
>>>
>>> +        - const: xtheadpmu
>>> +          description:
>>> +            The T-Head performance monitor extension for counter overflow. For more
>>> +            details, see the chapter 12 in the Xuantie C906 user manual.
>>> +            https://github.com/T-head-Semi/openc906/tree/main/doc
>>> +
>>>  additionalProperties: true
>>>  ...
>>> --
>>> 2.34.1
>>>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>
>Thanks for the review.
>Would you share document about T-Head PMU?
>

Hi, Peter Lin:

You can use the following two document to get all events:
https://github.com/T-head-Semi/openc906/tree/main/doc
https://github.com/T-head-Semi/openc910/tree/main/doc

There are also some RTL code can describe these events:
https://github.com/T-head-Semi/openc910/blob/e0c4ad8ec7f8c70f649d826ebd6c949086453272/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v#L1123
https://github.com/T-head-Semi/openc906/blob/af5614d72de7e5a4b8609c427d2e20af1deb21c4/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L543

The perf events json can also be used as document, this is already
applied (with more detailed explanation):
https://lore.kernel.org/all/IA1PR20MB495325FCF603BAA841E29281BBBAA@IA1PR20MB4953.namprd20.prod.outlook.com/

Best regards,
Inochi
