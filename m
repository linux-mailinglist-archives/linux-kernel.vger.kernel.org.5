Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045188042F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjLDX6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLDX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:58:43 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2099.outbound.protection.outlook.com [40.92.102.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BDCFA;
        Mon,  4 Dec 2023 15:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3uAHHofE39+J39rZ5P6GzwRm32pBAeZ1Hx36ODCP54FrxID+XtGedjgvVBQz8WvNJ5qffEeImEUyTG1t4nVGRNoVqAsmBmXcep7u2otEJ0Q6DB+xSV/UrAgLJ8vNFLpp6T5dYekmnbBBxxAfCySjSPMUnXS+VXmSkRaHlZHekRYE4B+/MFanjc3C4/4doKrl2LPYisE3xoQEXLZmQq0ikgqFPVj/vPmqxebVY7g/7KnTf6RGyEJO6eykeF35Gec5Bg4t/NJVVao7o6pW+pfDKqr0q5ecxzXtB7TTkMYmNezJ0GSsO/Mrhs29cjP/HL4oVgkYObYgsDRII+2Y5yphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm1Cp+VqLVbeyYlxDuFlFElJPdvB0dC9+ifSGDyEth8=;
 b=XgfaEpKdCIrav3kzBer9pjVADZ82OlsH2YZECjLvrCPXH2JtSzfHyhhBVLTil8ToSUqGs4tVI3NY08exXSEjm0k/YLkEByfZx+H9yGk14mm2HAQzq70UUnEricdQj/+6/XjaFBOB+jC4cK9Di2aE3TBY5I/Fs6Sil31tTcjogUtBmn8dGaN3obdIkr39oRB7gnpkqJcV+VKDoSm86CobV+Hbi6WnRLSwTZIYLeTdYkBYTKvc0KQS9eJaMqZdRFm+CRqeXlmSf3fw8bAz3hFEjOZhVFh+NhtqLGK9Hpy8woMAcBu1nPcGPHiPj8hWnPnI5HQy8gZdzAtTEAtz2HAJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm1Cp+VqLVbeyYlxDuFlFElJPdvB0dC9+ifSGDyEth8=;
 b=U9p92FzaIsXehkkHbxutIYFHIDmDNmyhQL5KHRlhKSyAnY0penWY/gubgM923FWfv7Civzuoqzq3+lKsCiemMFMJzZEY4B4TuPHHurhZtmsq3pqjBPQbYIrBab1eTOrM8bKI5qIHOa1TArHxJ4cHO82UTMhTv4lQeEdDc4VTzEB2nL704gsa39Rn5LMy/+ahBcaGAE91zsLnRFUS6K8Tatfa00CF0OdFTdZQPbFThzvsbwHJR+4qyIKkYsltTBeYwekQmbEUwYfTiC6Yyl7/oOuWDsIl5v19lmhCqsbHdhbyoL0dZEWFCmtEPlJZHMHZZUP2DBsynAqCxbosYa4IQw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1287.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Mon, 4 Dec 2023 23:58:40 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 23:58:40 +0000
Message-ID: <MA0P287MB03329CEC490E59AEE970B571FE86A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 5 Dec 2023 07:58:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] riscv: sophgo: add clock support for sg2042
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701691923.git.unicorn_wang@outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1701691923.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [D4XGbn0dJNAfTVE6LE0TT5TIQb8ycxZj]
X-ClientProxiedBy: TYCP301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::7) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <67092374-73ce-457a-80fe-7d53f2173fb3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1287:EE_
X-MS-Office365-Filtering-Correlation-Id: cefdc073-6163-4780-dad6-08dbf524effa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCf7qxc+I95ZOh2xtFc+kbvSRmIFde0UW+bYDD7G/Ih1HFCMXsXLCiK49ib7Lid9cqaKgSaJfnGdUsB8IJHmTbOElX1DN2uMGQ+yQvfvY2HGnp0v3NjSmEhBd6/tcsrmPct8qT2E7EOxamL13jK1SvxzZ0Kac+URj6gUUZgQwkixUHUyaoJMaKyllK5XONoTVZH7fCNzpNfOe5a67LI/3tJ3V02h0PEXW5hApdJRPjADA/Q3gVlM2Ih7eUBgu74H+5hODkAOF/zd7EQrFFTOHhnPHcSWWvy+JU1i4nTlST+42Up/k3Vf3UiIGQ3Z20T2zNrGU3Oe9VFZZqzeXugrAnJWoSfm+ZsTXdQqv10Qf5FbB5cO9Hi0m1veZZ3nWsCphb2gqaQtYjp7s/CJ4uoi5TX5+7YQ6/hHdlsIN59200JcEKGzVTUsc3XOOM/lYH0fX+S91izwYsmjKm3yeQbwdWdR2Zcb5vYjNGN+pDpfDXnKH93VBaP7DkcthD+2dxIf2MN2BIovNlBPFGy/DtDWYQZRgzTna3/dOZVnhPZ3j5V9lpcr5kLFaa9sLcIprjGlsbESix2Kf2sLCwUg2RUhyX3La/LgmURSacKoyPSDQUdp/8+3+tz7tRgbF+iw0Hssy/GMPKzxAOHHlFa9nbu5/Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWc5UWdONmsrT1QyN0VoTE9EYmMrMTRKOGE0RFBUOUpJUVJQSlRaUzNZRmtq?=
 =?utf-8?B?VWpET2lTL2ZZTnJEMnNxSEQrZVlNTnA3RlFTck9zL0Y0dnVYLzBnSEFiT1Fz?=
 =?utf-8?B?V09VcytvUXQyR3haRVUrY0lFc1VWcldGTkJrNEVHYXBCN3h1Q2VkQ0V6SE5P?=
 =?utf-8?B?Mkk0eUt2WFBubk9lTUZaY3Jhc3JWSjg0WSsvQkJjYlRoeFI1Wjh2a2llVXYr?=
 =?utf-8?B?ajF6Mk14ME1jOW5WVlVGRkpOZWo2T3pIUkJxVHczelNvYUhVQmdKR3NQOWVF?=
 =?utf-8?B?OXRGbGpRODlZb0VVZktGaHZ3V0RiUDRBbDA0WksxU3g5NlIwQVEvQnJvOGlr?=
 =?utf-8?B?V3U5M3lOLzZCVWdJcjVUYUdKdUd1Qm5FbUlWSll3cXVlbUNQV0pnQis4ZlVK?=
 =?utf-8?B?Y3YzQUZmNUFnS1NLMlhQd0M1SzZ6QTMxb1J0ZDY5UlBmYm0rYS94bS9LRldr?=
 =?utf-8?B?bE5yQTdsUjRpQVJ1TDQxb0VUZHBGSHc5SGZMcTJVMFQxTFliYmc0Vkw2WEdx?=
 =?utf-8?B?VTh1TWtRUWp5MEp4U29yRGtMM1VTQVBuTklIaE1pTGlUayt6aHRXcmpIUDVx?=
 =?utf-8?B?T1JvNGJSbVlJcFNzQllpWWwzRlVodVZvY2xMKzFOVVR0cEZWMWo0aFdzRzdt?=
 =?utf-8?B?ZzA5bEdxWkJjejlPYXUzcklET2JzY0NTYkpINXF6bzVQWFdJUk5HcHJ3dzJP?=
 =?utf-8?B?QjR3N3VsYUQxRVNkL3Z0aE1FWDNvOE5yU0Z0bVAzNC9GTjFEYXorVk1hRXFy?=
 =?utf-8?B?SVRaVTJIYnMwQTR3cXpjeGtYR1JlTlY2UFIzbHl3SHhXTHFxR0lOMDgwR1Jq?=
 =?utf-8?B?VFdwT1VrTHpVck5pVXo1MTV2S3N5YkhiNTRoRjNJUS9GSFA0c1duaWk3enBa?=
 =?utf-8?B?VmZYSnFnNGFmZTdvZHZ3WHUzTVBkdW8zalZncGFBUjh5TkZmMkQ4eHZvQVZ5?=
 =?utf-8?B?NVRoYXdCcGxiYm12OCt6UDNhMWNzQkEvUnhMVzZUc1NBS3EreVhZNitFMlJX?=
 =?utf-8?B?QWt5SG0xclFydllYeVpzaE8vVi9wcU5SaEl1SlcxbWpoaWpnajA2U3FhcUho?=
 =?utf-8?B?WTY0YjBWUnl1dWVrcDFCOGxiNGx5UENhbVJ3U0RNV2pwV0tuVW05VU5wQzJ0?=
 =?utf-8?B?OEFPSHZxY2VyN0l3dXl6VlVuSThJK1drSVF0L1ZDMGpaWkl3eDBBaGFkUHhB?=
 =?utf-8?B?U05zNyt2alpqTlhBWWQzNkc1V25qQzJUamlFaTVBV2NLVFVWWWJ6Vytad1pu?=
 =?utf-8?B?VW1nSVJBcyt0Y0R3dkQxVjhJOFlxN3A1eStmZFA4YkVMUDhJZXhHbW5sVFkx?=
 =?utf-8?B?UjQreW5rOXRqRkU4UUdWaHRNYnEycy9Od1VTVTZ1aWxVZnJnYWZxNUJibS9w?=
 =?utf-8?B?TzNCK2NHTmVJYWxJZGhTcit4blIyZTVzb0lMTWUvYkVDL0hEemh1dUpKNlhJ?=
 =?utf-8?B?OWtVcHowYkUyNlRFOUVnVEg0cE1GVTVWaTRoZDY0UmdTZnZRNGFkSkhmKzZP?=
 =?utf-8?B?Y3lkeUlkdC9OZG1iYjJORG9Ja3dUb1NzWDRwVXlNVEx5aDdzNUR0VWxoRnIw?=
 =?utf-8?B?cTlaWEVBa2NGMk1HNkt0YUlac2ZtN1ZnaCtEYzJJdXkwZFhTUURBTzM3d2dz?=
 =?utf-8?Q?Svk2cxr4qugyFPo7TrP6j5d6t3y4Hf9pccxNRPMTUZSE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefdc073-6163-4780-dad6-08dbf524effa
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:58:40.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1287
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version has one adt_binding_check error (thanks Rob pointed it 
out), so please ignore this v3, I will fix the bug and send out v4 soon.

On 2023/12/4 20:54, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This series adds clock controller support for sophgo sg2042.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v3:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [3].
>    - DTS: don't use syscon but define sg2042 specific system control node. More
>      background info can read [4].
>    - Updating minor issues in dt-bindings as per input from reviews.
>
> Changes in v2:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [2].
>    - Squashed the patch adding clock definitions with the patch adding the
>      binding for the clock controller.
>    - Updating dt-binding for syscon, remove oneOf for property compatible;
>      define clock controller as child of syscon.
>    - DTS changes: merge sg2042-clock.dtsi into sg2042.dtsi; move clock-frequency
>      property of osc to board devicethree due to the oscillator is outside the
>      SoC.
>    - Fixed some bugs in driver code during testing, including removing warnings
>      for rv32_defconfig.
>    - Updated MAINTAINERS info.
>
> Changes in v1:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [1].
>
> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v1 [1]
> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v2 [2]
> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v3 [3]
> Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
>
> ---
>
> Chen Wang (4):
>    dt-bindings: soc: sophgo: Add Sophgo system control module
>    dt-bindings: clock: sophgo: Add SG2042 bindings
>    clk: sophgo: Add SG2042 clock generator driver
>    riscv: dts: add clock generator for Sophgo SG2042 SoC
>
>   .../clock/sophgo/sophgo,sg2042-clkgen.yaml    |   50 +
>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     |   35 +
>   MAINTAINERS                                   |    7 +
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |    4 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   79 +
>   drivers/clk/Kconfig                           |    1 +
>   drivers/clk/Makefile                          |    1 +
>   drivers/clk/sophgo/Kconfig                    |    8 +
>   drivers/clk/sophgo/Makefile                   |    2 +
>   drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1371 +++++++++++++++++
>   drivers/clk/sophgo/clk-sophgo-sg2042.h        |  226 +++
>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  169 ++
>   12 files changed, 1953 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>   create mode 100644 drivers/clk/sophgo/Kconfig
>   create mode 100644 drivers/clk/sophgo/Makefile
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>
>
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
