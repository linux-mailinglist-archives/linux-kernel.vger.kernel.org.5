Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9079380A06F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573567AbjLHKL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573555AbjLHKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:11:23 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2014.outbound.protection.outlook.com [40.92.102.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C411D;
        Fri,  8 Dec 2023 02:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl7Brl2xiKpaUCmM/OEKg35eJ+OUn/B+JL71COYnukxlCEeU9Dz//jwP4ma9VtAIQcth+QInLPtRkzMHAo9vIufDFfgM5lsWydHo1AUHh/F877Binkna9caG9ewg+PBvSXKC84jA22VTw0B3E7OgrYezgHa8kSWSREcZQ3atu5WXgVAt5+qVuuOsn8pvfDrmGvsjtLD3gh3QORexxPya0q4yeDH/z57WWzHxVctOE5TViUNaPFVU+amAKkoDy2DLJZchvrqGLPKDpSZrSSk0Mt2QznN8Qzr5J1N5DPKDiD7X3qmKfjRfp1q5YNw4jz7lsyxT5SN/NlNpIdyPR4rtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgYg+otZzPIgXrw6iExNueZiSlU9FQY3CH64r9iMO34=;
 b=KX/1Ra9Fy50vE03j2x/7QlXegQGNI/mqYttGy8kACNAaNuEblpE58K/mia5dF88r0Xwref4GizcjWoTy/2jlOJqwAIfhZjnW7yvgIXdhjZ/2CJh+Mfc92rR5S93iHD2xLz+UfWcFRKPCFEgtHwrfjUg5I2iD1hNnepXIUWH1OaRtK+/RotuuI3y9+BBYUabb4lYflSQPp7SfDgiyozGGXEEbT50K6ClFbO+oCY+h9jQmdCF7CGzqtyS9D1Ib4fHuDptKLPgn2AiXOoNrHjXpJus3xbUtt58kkJnaPbZEwmB2yyTNfEfDTV4MAOAGS5o1Gh7rRro3viROQ6QQ4/jkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgYg+otZzPIgXrw6iExNueZiSlU9FQY3CH64r9iMO34=;
 b=sZwQExpgqyqx9EPvL/A5SFXwre5nayHW3a30vOpW64KvZx03lkA3mcpD5RTqYFGBeNyBSSOlGqThYOCBYEa8LSoAuCZ0RSXckwHnbLEuaajUQYsIaSA2QxtKy07EeY/3NrrCrXnLxn10gE5t/CQdKlAdFbUb4rlNFBEhfz+2ligMsWYA4Fp7i3MHpARaNosMszT7ZZ8DFu3RAr4HTlAPzgEzKTtg+movminyf0NIXAMxGc4x/4ippCHN7C1EjnTLBihIfYeS3WtEFIOMRjwwleHgRskqzt0HIsCA0x2wYB6HRNf2afxpI7lRwRZLqEu5eHsDHgqBqzxTNznIsWPp7Q==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1587.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.28; Fri, 8 Dec 2023 10:11:20 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 10:11:20 +0000
Message-ID: <MA0P287MB0332EEB2858B8B39F151CECAFE8AA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Fri, 8 Dec 2023 18:11:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] riscv: sophgo: add clock support for sg2042
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
References: <cover.1701997033.git.unicorn_wang@outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1701997033.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [e0xQ6LXQxsZe/4PvfhdyNCI4KLKMcBaN]
X-ClientProxiedBy: TYCP286CA0355.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::12) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <d96056fb-cc10-4660-a49c-b307e6856fc2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1587:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e88254-1f9d-4ea7-9703-08dbf7d60502
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdC33G2A5m3pCv+IPz6SNbf8veGbxAwz4hi4RuhYboDMpX0MxgDrp1DhxXwBkB/mYk/ymgojbzYyrwc189La6MsFaWpd2DUacCZwGcmFlhktetpmUxmLtEE2/ochuqIzLVsVEY7jI20eQ3eztkbHEri8TQOBsNGHXqbkwMh1+z+BxCiAlnPT+x5TQXgkFI+dqmBECpmBy4I18kiARXWrlXvEwLMn6JZQGu2s/C7Ys7Vzoi2nm5Y0w+xzVk3dQe+rPLQlxAz+QcffRqalBrbjpfUCEflPr1BrinJS7ULz7YrDislR6J7mqp7Q4FlmbEtNHcpFQJ1vPM7RctSI75RA2G9dYJiv/zNaZWsNeEtZRR0HvsvzV0Eca0hh/UYkZdY6i9/6rkw8rLkr6Dl+1LQz2g3LJ/i/VxSbtmcyYkE9suuOKbcdwYlbW0wp24C9/cfDcT4g/0s6Ct3uXRXcIJtDdl3NGFV8qjrSyph1VxTGG177vR1en2gSBcrgrZT8O9Ap+f7CDND3o7TpDS1QVCaWA+CWuJaTPdQ3XlQkvhx4hJWmt9LE1MpEk+LpXdqhKVT1WwU2rudtAkd9zJRJvOcU2GktTInEslAHJMjsOJH9zlkem3QaT44ju+50WjJkwfQCKwQBZoNZvBMs1Ba2NFrxfQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dKWUZhMWlpMkIwK1BhK2hrM3BOQUhNWVpvR09WQ0dSOTV1clR3TVBXWXZR?=
 =?utf-8?B?SkdneVVDRmEydmw5L3oyV2p2aDZkNEd0VE1aSXhPSHUySWRSVGZyQzFpM2hS?=
 =?utf-8?B?UVdrak1vM1pKWEFyeHZYbTZJRjdyYkFkRUxFN0YyWnRvOW5mTVB0a0lWWnpH?=
 =?utf-8?B?SExSY282WVhiWmxYczB1NDZ0NUlMQXBXVTlWdzhBZ1VwalE3ZUtWVmZnZmlY?=
 =?utf-8?B?aFJOVTlqeWVIcGJRUjRPVVY1VDQrYW5ONXpSKzZTMEYvUmVuSXUxaS9Xblps?=
 =?utf-8?B?THNwd1d2RXRUSXJoOVE5bE0vUllleWVNanIyemNsMkltc3VlRjhOQWh5NExv?=
 =?utf-8?B?dFdhY2VJNWFNSStVU1lYQ3V3NjU5SktPYjVmQmxqTFpxVC9Ra2g4Q0s3OXRK?=
 =?utf-8?B?YnJHNksxMHBCeXg5UlYyTFBJbzdsYmJXZG9kQzYxRm0rQjhKY2dDSUY2V01u?=
 =?utf-8?B?TDJMZXJvOSsrSXlySVBaRVVTTmZxZ2tvYzRGOWdPNUIyZG02SDE0NTdSay91?=
 =?utf-8?B?M0xNODZhSmFCMnhtRzRZRHlPampLTlZYOGZzbXB2QlFtMlNwQktoRnZjOUlL?=
 =?utf-8?B?V1FTUVRWdnJxbktqdFZ0KzNCVWtrcEdObFc4ZlVTTUMyc3BGTmJYYllseTRw?=
 =?utf-8?B?VnlZa3NNYjJXaHdzWCtBUkdSemVkbVNMNHpXd1Z5SW5UTjBQVWtCSjZrTUhG?=
 =?utf-8?B?b2xaTzBmQmR0YVFqcDBEaDU5QjZPSW9DVnk2VDBMSFJwWE5jdUMvZE56Ym5U?=
 =?utf-8?B?eFR0VDdLekszemc3SkNORGMvYTliVGEyU2pSUkdEWElSdkZqelU0VDArelI2?=
 =?utf-8?B?RUwvaXFUSVp4dHMyTzlTdTNzSHBlb1d1RWx3Vkh1Zy9SQnN6SVVUMnRibzJj?=
 =?utf-8?B?aDZBUmxuQ0Q5NHZzb0ZwbXMxZ0VVdlo0M2NGU045SndZWkRjTTRPL3luWGFT?=
 =?utf-8?B?NWFrWldLZTdjWlg4ODhqRU4zYkVFZEwwUXhDWFR0OXdEOHBGQjB1dWZTYXFt?=
 =?utf-8?B?MHk5Rlh2NzZOV0RDZGdneFYyY3kwR1FIekk1U1N3SVIxSHlGS3RBZ2tFZTE2?=
 =?utf-8?B?T3k1b0pVbzVyNGY2NlZoaGlMUXloMnV0Y0JMLzYvOGVLTDJpeXRJZG5MNDJt?=
 =?utf-8?B?U1NXcW9PWFd2ZFNNNHNiS2k5VlozZlUvVGtFelZBSlVUZm5iUGlGY1pzZjQr?=
 =?utf-8?B?Nk1xY3BSMG1IdWtBQnkrL2RqUDErNHQwZm1kdTNCZzUxZ1pNWnd1REFYdG41?=
 =?utf-8?B?TldOTDZxUFJBM256RGMwV1NBYzlscXdFNjJ4U0IxY1M4Qi8zOVh6akNzUG5U?=
 =?utf-8?B?OXhaODRESURKUk5Zb3ZUeVlXalJjbG9MakZSeHQyWHY0VzhlSEFodkJ6YWlH?=
 =?utf-8?B?bFlONEhISnBCKzZ1ZXgxV1Q5OW52UnArT1E0bTc2VkZNYy9CZzM2NmpQMlMx?=
 =?utf-8?B?cmZmcXZ3UUE4d2ovZjFUMUdEMFlLeFdGUThKVEZ5K0Nqb3dKMWp2QTllVTAx?=
 =?utf-8?B?MmttNHJRRUpDSU1qWXZyU3BMOG8vQjJxYUo5N3ZmS0lQZzVXSnp6c2J3S1dk?=
 =?utf-8?B?NzZRMmtZOWEvKzZySnZYRkhEUkJWamN1YWZHSUFnSzdEbFVHREM5VDRNbXBB?=
 =?utf-8?Q?soGicSflE0LpLDMn/avjwCHFagEJc3t4kvg4HxEAIrtg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e88254-1f9d-4ea7-9703-08dbf7d60502
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 10:11:19.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1587
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/8 9:13, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This series adds clock controller support for sophgo sg2042.
>
> Thanks,
> Chen
>
> ---

Hi，Conor，

Can you please have a review of this patch?
And I'm not sure if you are ok to pick up this patch so it can be merged 
into the next v6.8?

Thanks,

Chen


> Changes in v6:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [7].
>    - fixed some warnings/errors reported by kernel test robot <lkp@intel.com>.
>
> Changes in v5:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [6].
>    - dt-bindings: improved yaml, such as:
>      - add vendor prefix for system-ctrl property for clock generator.
>      - Add explanation for system-ctrl property.
>    - move sophgo,sg2042-clkgen.yaml to directly under clock folder.
>    - fixed bugs for driver Makefile/Kconfig
>    - continue cleaning-up debug print for driver code.
>
> Changes in v4:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [5].
>    - dt-bindings: fixed a dt_binding_check error.
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
> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v4 [5]
> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v5 [6]
> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v6 [7]
>
> ---
>
> Chen Wang (4):
>    dt-bindings: soc: sophgo: Add Sophgo system control module
>    dt-bindings: clock: sophgo: support SG2042
>    clk: sophgo: Add SG2042 clock generator driver
>    riscv: dts: add clock generator for Sophgo SG2042 SoC
>
>   .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   53 +
>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     |   34 +
>   MAINTAINERS                                   |    7 +
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |    4 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   79 +
>   drivers/clk/Kconfig                           |    1 +
>   drivers/clk/Makefile                          |    1 +
>   drivers/clk/sophgo/Kconfig                    |    8 +
>   drivers/clk/sophgo/Makefile                   |    2 +
>   drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1356 +++++++++++++++++
>   drivers/clk/sophgo/clk-sophgo-sg2042.h        |  226 +++
>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  169 ++
>   12 files changed, 1940 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>   create mode 100644 drivers/clk/sophgo/Kconfig
>   create mode 100644 drivers/clk/sophgo/Makefile
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>
>
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
