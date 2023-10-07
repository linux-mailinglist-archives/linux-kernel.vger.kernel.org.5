Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2147BC7BC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbjJGMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbjJGMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:44:35 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2020.outbound.protection.outlook.com [40.92.103.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C8B6;
        Sat,  7 Oct 2023 05:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9D0hnskYAoRphcHNjMp9kg7Jdlok/k0JpWwKo4O7wPmWUtlv6SA+dI5ZdeqwljUqZNzGwYHEOnogeoGarq10eA6knbI1nKU6UTlQKihbPJ7iCJ4ASmT7icz8D8VhivpRUiER8MINsaDJS9iDmNmyvHAxDFKhE2sEY3MMAxZcfmVuSIIXWZx9RQuNEZV0e73dFcLuKD6NcMhBS4dfHidj1yPL0zvnWcReUbwV9a6eb2G0B9H6WyAQuTtQbUMxl444QMBTKd63ngpHGpSl3XP/rCcmifvHw4C/0G11Zftr7hApVRe8faUOgDYqbpTIAXQPq47jxdis5gJuVQ6rjQAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbGUV3xgw2r3FA34QSOjK/IUaKKhnYbQXhh+oAvp75s=;
 b=Rjb7m669eBim3rYLB4Y2cMM9Vz4RDkbAirRkiIysl8apz5y9afJIX47WA6WcgXGUdPrSmGfLUPe/3uLRSfwE2yKB0LF1hWLFLjdrhyo5SubGgUG/pM03PbIhX8GYwsqOSZFgVQ53igo9y8NyCuNOIKGj+3w6UF5+TdRx9OBy56yRkUbtAE0mfJc27CUyN1PUK9XHOIqpIfQSJCKISknOWfgsiAx8R4Dx1DKSxzcHTQP9EEkVyUKX8abDi6lV0R+QBtax/CsRjYYEsPx4BB0V60pmaqc3dUYKOROg8+EYNWIkJPH8CESTUAPvlsGAIvI1BUpaCwk2M93B5NtXw18O6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbGUV3xgw2r3FA34QSOjK/IUaKKhnYbQXhh+oAvp75s=;
 b=AnEGBbsoJUsEDnL0bZtOsiJlhoF7MWRbe7GGlGxkDzHrt/RVnsSkUnXPL2dh49Lo13QReFIUNeSNc8Fd2VuLGixc8k8/PkYOZYTnLPhlsnl/qvEJEMhcb/CMLJCNdxWMCppbsnqL+ElDIgEHkccqrzS4FgHbcS6BLOhaZjrjwycymDBCOUdqNo4WtRuZwg5dgXePoYtFhyVpLTEdJnKQykhzTvMzUcUE09qJrvrkrXFZczM4PfUtu4PfzKDH0Ww1ZRC/RygP8OfonfVzrqBjKalr820qxusKbezHP+UjyvNVv6HJdAabRsMcPE0tTck9a4646AYa/s7BGHoXZ/5TFA==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB1079.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:142::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Sat, 7 Oct 2023 12:44:27 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 12:44:27 +0000
Message-ID: <MA0P287MB0332FDA6E0083755B0FCB8ABFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 7 Oct 2023 20:44:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] riscv: dts: sophgo: add Milk-V Duo board device
 tree
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>
References: <20231006121449.721-1-jszhang@kernel.org>
 <20231006121449.721-6-jszhang@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231006121449.721-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [uHLiM3JxmgzdJ+W+WVRI6JNSvqRR+y4v]
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <c4ee4e82-d4f6-4d37-9760-3756e565d208@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB1079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a436db4-7c4c-48f1-3c94-08dbc73323d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YM1hsF42vtEiBaEZHzY0TLfyzmmHgdEljaPVlXrA5nv5jxtfCURGzhr+zkI+Xug/r7DmSQCR4mqUMjAxmeM3r+ilEfNN4R3TBZWBJU2OLotZXZIjHhm32v6YKMbNog8YYEZZTt98kmnW9eEmeUHHq+bJHn4GgwxUydDat/IZKFHDvmyYRpnNu4tySsRI35T/K5jvWdT/pqcv62rUuScGzyVd6sLf563pRvk42YVYwXRHErjJXOrAv7V4T+85NEWIQ4fm+RL7+1x/prDyd+mDEnObIvlik7GIx5Wyp2xUJuPaKNEHaSUXSxMvLd7faFauVF63UklBOERE8f5jxdUf6SGsz5CsZkYVLZl9XydqKZpOUoxMWFUirEaIYMidPLDYFYfH/8dC+ee4jkiC55SZFlRdZJZGFCuYiWnVmuB98zChtyCUrzzz+mu8t8l/FCKuPB74xgeCH5HmSISnrnJMkJTepYC0qA2ya4uhZhm40Tkuhz6WYQ7EaQNyz5nGPkc3aUaCr4m4ip9Iu5JjB33xCl944r0A5XNMK/3qzHMV7DEe8K7BJg8MOYMKcwebh6P8sLdkAW3Z8AAaRMpWsunWBD3+046wn53inqBQ+GNAjJY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVgvVzdsM01Va0V4ZjMzY3ZSYmgwU2hRWkJkMGx6dEpmWHlOZk55ZjBSVVBG?=
 =?utf-8?B?ekVhWFF4WE50OHVDS3dsRjZCWVB6bUtoMUpnWnQ3dGRYRnFLUXJxNStsZHJX?=
 =?utf-8?B?RCtXd1lJNlF1N0hKZnVOa2J3U0J0VG5iWDZFRzBsNkRSSGdpTkJNM0ZTenA3?=
 =?utf-8?B?TlhNRnNBRGpBNFNWeWphcU5saTRyakM5SkJ5RGppSStwYVkyYSt2TGZ5UUp1?=
 =?utf-8?B?d3NCWWljbWNTNm5tNEhBQkpQbTN2a0JiUUhXM0Fya245NGlDdjg5SFMyTUZ5?=
 =?utf-8?B?QXJkSGJybXZQK3h6YnhOeWdqNGtqbVVMMnh6WTcxM2NMN1hmcENuRWxQV2Y1?=
 =?utf-8?B?emwvS1d3NGNUNnQveFBBTVdTNzVNeDczSlBveEE2T3VQYkt6VmNhNU9heStD?=
 =?utf-8?B?aEhTY3NYQ1FUeFZBYnRZUWwyb2JHa0RTWUdmaWYybXNnU2tBUVNIK0xYMEtX?=
 =?utf-8?B?NWNFWERTelE2bThqdFljNEs1TWUyaDRtbExzVnRKZ0ZxM29qRFM0bGR4OWox?=
 =?utf-8?B?Qnl6QVN4WVgwK0h5cGZya1JyYnhTUk15S3JOWG01Q2wweTZ0NGdsV1QrRUJs?=
 =?utf-8?B?cTYvU2JpTXdpcjBoSW9IQXM3UGNVSjk4T3BWM3hVODNvWWxDTnl5dnBRRS9q?=
 =?utf-8?B?QlJDZlh5bEVGQnZRaldCa1ZENUlOeUg4VTZLYzZPR3Jmc3lEdWs2UUVlTEM4?=
 =?utf-8?B?bk1JdXc4MjZGVkVQMElCckZCQkN1dWtSTlpvL3RVMjNqTVpzVGQxNEhucDdP?=
 =?utf-8?B?dnBWT0NaN001RitvWWluWE5xNFVYLytBOUJkOXdDekMyemcvU3BScXNCL2lo?=
 =?utf-8?B?OVJDZzd1WU52b1o3UjAwc08zQnFLQWw3OEUwUkwwNHBsRStxNVQ5Z3YySWZo?=
 =?utf-8?B?bmNta1dVUkhieXRtaktLNTdkbjAybzA0Skl2c2p3QTJhRDJhWFRnVGRWbUpH?=
 =?utf-8?B?eDA5OGw5eEpJU2lIdlhhV1lqS3NvUGt5N0k0b3k3em1nMVZnU1cvT2pwM0xx?=
 =?utf-8?B?SzRwenRLQVEvamY2T3JaZk5LV1lCV1hwaGtLUlE1RGpaaW9hY3dZaVdCQk9y?=
 =?utf-8?B?eXJ4SHNxZTJqbEhYWW5QdWZhN1NxSytnVW5LSFBISi83bFdQNEhlWHc3L0tO?=
 =?utf-8?B?ODJPaGNTSjNnSU5VdU5rTUxyZXowaTZkNnZyN01qaUZoY3AxZmtIMzdKMzYz?=
 =?utf-8?B?MjB3RFpnbTU4MnlDTUpYQkpuajZQOVhSQXd2bFYvcVhzY200M0Z1WC9RcUhh?=
 =?utf-8?B?L1RmZ3ZuNkcrbnRlTC9FbHJPTGJjWVpvbXpueGx1RCtHN1VyamxQcGM5S2Vk?=
 =?utf-8?B?aS9BcGZ3aUJ1UkVBSVM5ak9wNk84MDNGOStJeXUxaUs4LzFtZ0hDV0JpajV5?=
 =?utf-8?B?L1pKMVJJVDJES01zNU5PWDVuRzZGUGpFOURFa29jQllnY0pTZHVLdmRTYito?=
 =?utf-8?B?VlBsNDJyUlFQT1dRWDhOWDg5QTVyNEZmL0dGQVZCb2NJaTdNVWx3a2xSYmtT?=
 =?utf-8?B?blJTVkhTQ1N6RHlZYkNVYS9KT2tBdGg5ZUwvWTlzVUJjZUF0SVhPZldocVVN?=
 =?utf-8?B?bWxxUW1qM2VwSEpobklOY0NMMWJtdUlRdVYwRjdsdytIYy95Q1JaRTl2LzFV?=
 =?utf-8?Q?jXGaAckPNRixzySUePvZeRQLAmdRt9QxQFcC+6j+UCx0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a436db4-7c4c-48f1-3c94-08dbc73323d9
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 12:44:27.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1079
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/6 20:14, Jisheng Zhang wrote:
> Milk-V Duo[1] board is an embedded development platform based on the
> CV1800B chip. Add minimal device tree files for the development board.
>
> Support basic uart drivers, so supports booting to a basic shell.
>
> Link: https://milkv.io/duo [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Chen Wang <unicorn_wang@outlook.com>

Thanks, Chen

> ---
>   arch/riscv/boot/dts/sophgo/Makefile           |  2 +-
>   .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 38 +++++++++++++++++++
>   2 files changed, 39 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
>
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 5a471b19df22..3fb65512c631 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> -
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> new file mode 100644
> index 000000000000..3af9e34b3bc7
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "cv1800b.dtsi"
> +
> +/ {
> +	model = "Milk-V Duo";
> +	compatible = "milkv,duo", "sophgo,cv1800b";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x3f40000>;
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
