Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D397B7825
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjJDGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJDGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:50:30 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2053.outbound.protection.outlook.com [40.92.103.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D3AC;
        Tue,  3 Oct 2023 23:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhkodXDwy87hFD5VZ4Xc6Jnb0pXTrsCaCW5PXw8Ls3FVOgiVs3bWXKeFcRTEyd/+o9wA9j0vwl5tbAUlGvdrvYgswH/RKWmSiqRmQIQMjdKXx/m/xj0ONFnIooQpv6VBQpkMxgRBfKmm0SEWPC/xI2vl+l2pFrcqC6QyDH1KGJxsGWnkbg5OYjtMnb2xo6Gj659wAtszGHXlUhlE0+oQHdPh6nWPSTfwxaU5sKT2G5LbT0gYIRmoOGnQfMZ16eZsMjDezCP9LP9ezXi2lUWgNPlyXGgpcnzkmbCWBE9LniTi9Bmaogdl7QLukemMwAcrWvGF/Mt4phSPpM4tX5mjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEAmoCkEb3uv9hE7547pV45Hn0IwRQxY2PmeftrPutE=;
 b=FKHPL7OPPBJOu5oI17ZV6nlGH7je6PdJ8EYnlG+u9EdX1fD9zEa3J5rHJChTmjq1Frr5ZfQjLzhqia/EQ3xmnwqdHIzPkDycD7vpl8OSKPwdBQ69Qp0E7ey8277wGp+So9rQ+caDA26F6s4zpjF5FH0iU+HlbPZriVeDihsGybwNd+dLPuvXuoiq8sosPcqqCsmMF4SClpshja3ibutlEB8lKVNNboLyjUoTTIzyhQwQE/cGSAU402jXdRShjsk+nP8k6eJluP9RNyw4Ysy4TaxEmxnfclgZWSY1JN0WExjH1GpN0eRA698kHMvLRo/D2h7whRvbAh9auB+UNunfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEAmoCkEb3uv9hE7547pV45Hn0IwRQxY2PmeftrPutE=;
 b=WvpuEVxtRLPZY/INlMavWN+7DNW0+9eVa7MvnBeq92IBG7xd0FBtOfzCeR14WPEiQAZnr1l5xGMgntG/sM5QVQ90drPLGiNlzaQMfDGbVG4RvY9NNV/lAgSrlV4eRtBSnFna2DUfrZ9UvWRwkXZqqjEDrsK3P4uhqqCAYh49dXl5mPm3DSJzEzfB+5cqXTN/hPmIX86YpE7MMnLjwYO6kckaFgycuFdJrdxwFEQjSQeg0TamLNoU+ziURo+e8gT4I3nX3sYXZ8uk+xGfTrNRWibZ1Xlxwxi3ORGVSOjVE6ktEsBfq28DsnZp0Mw093QgyPlvQpQfWu8gt3IJBDC+xg==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB1529.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 06:50:16 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 06:50:16 +0000
Message-ID: <MA0P287MB0332AF093C75B7712FA8AEA8FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 4 Oct 2023 14:50:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: add Milk-V Duo board device tree
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-6-jszhang@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20230930123937.1551-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [dx3Ypcn0iAHjKS7PQFzamStSi/E20KCb]
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <87effa78-7d9a-48e3-982d-e30b057f6ead@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB1529:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c27e667-4e23-42e7-ac83-08dbc4a62a66
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40t5Deb3GZQZt4K2tIqM4zzMeN3Hmbx3b9ZiZMl1+41KK/eg6mXVVN09QyK81kazVs+/X9IqklrJ9PvtxEAE4uQGL1XDE7BpnbSUgKt/QyuXH4FNEOS/H2JBSfFGOKNs1gsiEwuMQwBHX10P9hEpYxpo3khcICFRR3UvBE6r388wP8ITpKuH0KwYoA0IL4mVeSexveMyxkk+8Ad2Cz88zqEik1my0ssBKItkc8V+N/RRcPRHnWEw3CAtmlnbH1CH3sfG6uVHBTujZhjJ/toNT5+EoWpC66kCMWq8jcek8oh1xqobPHhqTrGuj0skZKEtCKfTBTxZxC53Wft77d8ys1lDPK5oOOabtxqD84cS732EBA63xF0fHBGvhM91vwYEqg7FgEThkTtC123XbZCzmr1MQTGO/uVZiekhl+PDb2AuPLyOzNhovujRnayrlmIeu1Vol4rWqnj6k8lHpWpkPxlmj1+RWGyKYtlhtkjD3V/AHWOoc1eGrEeFaqh+rA/bM5VVxJBd+NyLOHXpkp+pokppE1jC88k+F1i/rwLr/ip1mHbTuSPa96D5HAI16CXOuQx0lGduP+0PlXZfSfmqsEcDGh7JzwNIj2sQ4iHYRPU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGFLakpITmttM2grYytvd0IvTS9BQThuSFp4SHFFUVVGbTV5L3VhMnFVekNH?=
 =?utf-8?B?UkdLcjBiTnZ4UjEzU3VJVEl1UVl6bjQzQ1ZKU1RaTzZvYkZ3WVJsL3g0cFo0?=
 =?utf-8?B?c0ZWTVg0c3gzUzZQVU9Ja285SHh4SitRWElSV2lVR2xOajkzUjV6YjBIVi84?=
 =?utf-8?B?MUhiVVlzT3JpVnV6czdkSzFjUUhWa3plUmIvdDBkMHMxNk9MWHQ5dVQ5enRO?=
 =?utf-8?B?VGdGN2R4bGJHb2RXMWYxeXdiYVBUMVF4c0F0MXU3NjUxZ1ZiZnV4M0VaR0xZ?=
 =?utf-8?B?LzhuOEJZVWc2WW9TQW1FSkUvdjF0OFFGeVNZUU5CSVA3Z0owME96V3liNEdk?=
 =?utf-8?B?S3hobTFYeUJaN2pmZzdpV3hiZW85NUN0MzdwQW5Xem42cDVucnEzUjZxeFRl?=
 =?utf-8?B?ZkZ5djZyQ2pHbVJWKzZ5Ny9zUllyd2pBSnRxOWFQTkMyK3l6dmN1VzhyOTVK?=
 =?utf-8?B?eC9zWjRhZjRaR3B6ZkI4TGhkeTZPS1JlVGtLOWNTVzExalZ3ZlNra3lxOWZY?=
 =?utf-8?B?WEdUSDFTRm54cXptZ3ZWR2pZRk44QWdWQ08zMTZNV09tQW4xYVR4RFZXMTBC?=
 =?utf-8?B?RmtVN1V5MTFnaWZ1aVFkUS90cS9mam90WGlBa015bDhIYkk3WnlVNkp1bHV6?=
 =?utf-8?B?Y1ZHcXJtS1QzaGt6azFKOG90aFJldjJpaElIbVBVWWxQajZ5Vko5bmlCMWZ4?=
 =?utf-8?B?MWlsR0swWWNqSk5QOUwzK09GTk1SdUhGeFdWenQra2l6TS9weEZadWpNTlJB?=
 =?utf-8?B?bXZYRnlLVEZWM0xBUHBRbHpkM0Rvckc4TDFWbFBIM3lFVUEvbDhEaUZIVDZj?=
 =?utf-8?B?ZWYyUmtEdnZ2KzV1SmM4ajdOblBzYmZSdlV0cDlhV0JHU2daODZmT0VyVEtu?=
 =?utf-8?B?TjVPaDhPVG9HMm80SHREYmVtNWV6M2VrZHJuK2I4YVNFcDFQMi83RVdyRlpT?=
 =?utf-8?B?M2ZzTFVTRDJrTjJIbjlWU0ZjMzJaMlR4Q2w0VDllK3l3VzhHb0R3dmtkMkZi?=
 =?utf-8?B?QXlXcGplTWYycHZWOTRaWXdUVlpCL05pTDFGV0JHV1cxanJDb3d5Ukw0dmYv?=
 =?utf-8?B?dXRLeEJJemxGVFZLN3JnWklaVzNEM1hhVE16bkV4TG5iMkpLTlhiSDdjOXdF?=
 =?utf-8?B?Sk81S2NHWU1COUFaWU1CYzNSSnlCT0pxdXJzZlRNUHZuaDRtSUtKdGtOQ3dG?=
 =?utf-8?B?eFRLaHl3TWl4eW1QdlhaZGVtdnQxUCtSenlmYjZOOEVUSk05UENqKzFiNmZ1?=
 =?utf-8?B?Um1oSXFna3d3b00zY2l0MGhFQ2NzcXJ0b3h6RFNJdHNhUDgyM2MvVWlhMHFk?=
 =?utf-8?B?SnhIWEp1d1RQSjFKU1FQb01mTHpJbVpQY0VqUDdEVzMrclBFS1pLclQzS0RG?=
 =?utf-8?B?WDZ6VGw2ZGxmYWp4ckJiZFlDMjE5NDdSdG1vSElBeHRFdzZhTlo2UkREYkxP?=
 =?utf-8?B?MnFUVG5acTBScFZITnZXMmRhY0tsd01hMlEwMEVvQTJNT3pDd3J1a0UvcE90?=
 =?utf-8?B?Mkt6RWVtUXlLQ0d5ZSsvcmlDZ3VZT3Y2TUdpeGlacnVuTFZnd2puZjFZZ3Nh?=
 =?utf-8?B?OFh2V0dyeDVvbEJrU1kvWGJjV0U2amo4NjFhcnFld3gzdzVISUpWSzRsTjVy?=
 =?utf-8?Q?05jwrgq+JISHlYdOT47up0DVajlFwR4nESDjdt/urkug=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c27e667-4e23-42e7-ac83-08dbc4a62a66
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 06:50:16.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1529
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/9/30 20:39, Jisheng Zhang 写道:
> Milk-V Duo[1] board is an embedded development platform based on the
> CV1800B chip. Add minimal device tree files for the development board.
>
> Support basic uart drivers, so supports booting to a basic shell.
>
> Link: https://milkv.io/duo [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/boot/dts/sophgo/Makefile           |  2 +-
>   .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 38 +++++++++++++++++++
>   2 files changed, 39 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
>
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 5a471b19df22..5ea9ce398ff6 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> -
> +dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
Please adjust it in alphabetical order.
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
