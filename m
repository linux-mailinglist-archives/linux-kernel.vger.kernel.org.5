Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AE7B78AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjJDHYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJDHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:24:12 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2066.outbound.protection.outlook.com [40.92.103.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8FBAD;
        Wed,  4 Oct 2023 00:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyFnSppb1ahuD2VBoyR9lThNl0bM34Zm3PX7jr0retaWs7tva6KH+RDCFezmWmq0iALml8b/n9Kd+IzUZNrTWuK/8Qh3f4JeShHfT8MoUbjFdhHK82Dk2SBz695lsWBtO1bGW7R6grPOvxc9DJaYg6FrlUHgogLYM80S8tGIft+a2NpX+gdrdpGouIdFWG+2wyXOCiDglmntqNI5EgqU29Nd/NbU0DmitRxIUiJ3RExGGLSaBt6uruIgcG8NCmkaHJZEGLzGKCpKbswsFWqxh4V5b1/4rQ47s674j96GkMmVYGrtYJYXVdIBs/SW/ePzccCkKMRMSG2wbVfHoGVWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od5DAXaAGYhsHoFqRXoMyOUCBjUtrqtgWFXubq9hH7A=;
 b=ZvZipvlyHhz2TNG6JGiNwsJd7xZ2tnNHujBR3ka6duZCH14A28Wb6e5MpnDS9+0/2xYYsOb8/LsquF0hXdEzbO5Nqx01eA8Wga9k2uCCmJVdQp4E+nMguI6AMTgfsI8jD4yDblal6meku0Z/OFwJn10cpTlZYOHz4Z2dpaFdwKBNP6yFn1KeX8S0I4dsTF8TWHlvm05R/g304sVUVJjMifgRILXYJ58ACy8HqBqgT9k7akoxp2AgXHHXPrfWLa5/DuSeL1XVAPn9N8WH37jQuXGEH4jt772qt44GVpnXaf7T9nCKi0ECuDk5drFgp1eACaiWEkw3Skem/nUkbIDLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od5DAXaAGYhsHoFqRXoMyOUCBjUtrqtgWFXubq9hH7A=;
 b=KaYZDbiLy3+n2b/iBJtSo5vtE58xY7zh29/hBo9Y04+UcbKMhYiiP3SdnPIHHkLFCNZfOzrz05mdn7EEWGVD/SjzUTQiRFHC6txyhGmuK5bbyYBMDEKf/4RZB8z5vP0IXHqqw8DeLljQMLCTpMWaEmwFboWnzxMc7ezGRDie0uqkboDNPTDqvAfOZ5OKdi0XSGrvG6D3QK7Y0jsdXvT6un3bfT4MDmXfaLrKXD5GYsBHHQNTcywuY6nmFrDozdK+rs8AHhYs3/u51JWhzt5hf9oXU0NOH7xvwKFi5qA9BJobyas3Hj0AsVazUulAMUYcndvrSxbx5XSwZ3MOqVJ/Jw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1848.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 07:23:59 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:23:59 +0000
Message-ID: <MA0P287MB033277186E21A09127407452FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 4 Oct 2023 15:23:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-5-jszhang@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20230930123937.1551-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [es5SnY2jD3jNz/solUs2BPXbk+GIgyxJ]
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <b26077d2-0db6-42f8-95d3-2c5a50caba6a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1848:EE_
X-MS-Office365-Filtering-Correlation-Id: 290731ac-6c5d-4ad5-c45c-08dbc4aae049
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UF/vmHjvrnBmk1pC85p20SCincox0GAvohhG3BqAAyx5tbqEv6s45+juWR4wpCbnll3dpXqJwqv0MiUgHLkmeQM98O8vZnWSozQeYABBs3DiLZ8KdyeVzAgb/0zJmKyokmNg896Ix9lo/TUBPgnQ0FG8taI0erJqEUH5NvuD0a294ccKrUZ3a8WDRCJEhLmnmevBkdjPMf1/RKF+G7VHJUPncbdmLoL7fyQPICyOeg7AW7x4xarI8LrsDn1WC+oV9Y7ootvzkH8wVAg//RNYIi5Rl/A89jXWEjtRQ5RPnRLtR1pzlOvMa3RGX+VOGuClCsWweB8eBqJcTd3vqckgwTOD5phEqPa/XXkPnG6UsK3l8CKnGhC/k/IYhby2e6T3ygRDW2fShq3m5AcnejbYSMm1rbUptW0X5kkfFabBeExLVthiiBGMdJP/I/wskTmE/jC6so6th37DsSZ9iUPBFg+dI+ylU4u3WZHbbpibwkBQ0hvw9vFBt6+hBJzMghHi1Os1MPsjT+RTPci3aYjeGFn97En+nUhlrfn0Iq9XQ7r55Vz3SsD61CIi7QNn1Vk+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJlNGp0SXVDdXN0UWdLK2I5QXlDWWt1QzR5RnFSS0dJVVdLYXl5d1lUenoy?=
 =?utf-8?B?a2FxZWdrbFUzSDNLRVFTRkVMd05jQ2grZ0U2OUI1QUdWMXZTRnJVcmw1dHdv?=
 =?utf-8?B?RDkySkNMWjVNaVlrbVZzSm5keGUvZ1pjZkZyOHAxNzc2YUd1YWE3QllrQUUw?=
 =?utf-8?B?VVozaitXbmxKc3ZvZkNVNUhQMnZ2OG9JbEhDZjZxTUlTUitOL21pR1JqTXl3?=
 =?utf-8?B?c0xrVDRzSlA1VSt4bVpnc2RLWGtYV01Tak5BTFJzVHRxT3RsMVhhT2Z2Tm4w?=
 =?utf-8?B?RlpXaHBRZE5RZkt3NXh1eEwra2dNa2xLVEsyV2g1ZGVsZjlRZHNmdkdrVVdV?=
 =?utf-8?B?RjVRckVQMnBtUHVRajdYN1FVbmdGTkdhSU9aalJnVjFKLzlUc3pmU1Z0aFg1?=
 =?utf-8?B?K1BZYVRmcUNVSXNISk9NYytrUnVWQkwwVXF2aXJyMmRqdHp1QTBGZGNaK2lt?=
 =?utf-8?B?T1NxZFdvTk54VnB3eUQ3Zzk2aWxXVDNJczFNU2plKzZpLzFDOTB3TVFvUk51?=
 =?utf-8?B?R2JHeFcxUEpZc0FCQlRaWTNVc1ZldlpJcWtLMkE3eTdyb3FTVENkb0lxYktS?=
 =?utf-8?B?TDJuUmttZm1pcktTampWTzdRSi9NWElGODYxa3h2NHRkVmlqV0lNclpaREJO?=
 =?utf-8?B?MTVFU21JU013ZWJjRTBhTjQ5SXZ0bklBamdnMktmUkN4SzhzaGdqQWs1ZUMv?=
 =?utf-8?B?RzZEbzJOWm1sT0ZYZC9rMURQVDQ5dUc4VlA5KzBjaTk4U0ZqQ0I0MDlWU0w1?=
 =?utf-8?B?RG5ENlU0TmxlZklYaVBYRWJDdVZTMW9IM1RlWjVEQVVvcmRFK3VWaUptWWpU?=
 =?utf-8?B?eXk0M1VOU1gvSDRWcTI1ZHFTQnhzMkp5a0J6RnhReExEWXhUN3BaU1dtWDhs?=
 =?utf-8?B?OEUxelArSWlqYy84UmxqVkUvd294cWdKY25LZWJrSFl6MmFOSFczZUNHV1pl?=
 =?utf-8?B?cmlJdHNsMEk4YjNnaXNKck1kWnB5Zi9IVXBpS0VtNUpZbUo0K25Uakh4S0JN?=
 =?utf-8?B?N1NpbGRnRGxRZVFqYlhTbzJSRHZSQ09aVzBoYSs1cTZJMFpjcWVMcDZ1bEh5?=
 =?utf-8?B?LzhUcVZWdlhMU0hZWTVJKzYvbGRnWXk3UUlrdERvWUU0VlJwS1FxWm5GRklS?=
 =?utf-8?B?V0pMaExCRDRBUDlvbmhvaWUzNkVXeEsxV21GK0gra2VDVmRzTGlSYUQzaFRj?=
 =?utf-8?B?aVY4YXhHVFZjOFZYTjA2QU1NSkxqY28rNjRuZmw1L0FJaXM5bzNNcVkrVjFx?=
 =?utf-8?B?SlI4RTViWmxPSysxNlF2TktuU1VybVR0MDJYVm1KeWR0Szhhcjk0V3VSM0Q1?=
 =?utf-8?B?S1hsYWVzeWZGcFdLMG41V0R5WVNnLzFrQ3RocDBSU0IrRmwwUjc2M091R21v?=
 =?utf-8?B?OEVJV0xPM01yUDlmaGMxT1UrZWZuMnZCUGtnZ1NsaDFVU0MrWCtXT0M1V0Zm?=
 =?utf-8?B?Y2sybTVqUFhxbHl2cDh0Mk1HUER1NXpIanZ6c25Eai9uc0YrUUI3MjU1Rnk0?=
 =?utf-8?B?TGQ2WU84QktBUUo3c1J5YzBJdE9Ma1ZGM21OZ280V3A3T2FuVi9VZHhBRzA2?=
 =?utf-8?B?MUcvaHNmL0ZPcmFIaTBoMkJKR2J4a2o5NnY5QXJnNEpycWhBbkdZQ2hrZkJN?=
 =?utf-8?Q?WROO9UhUTYZtstxXggOHvzZMTq9qmLd80aQpyMji4Qr4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290731ac-6c5d-4ad5-c45c-08dbc4aae049
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:23:59.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1848
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/9/30 20:39, Jisheng Zhang 写道:
> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 117 ++++++++++++++++++++++++
>   1 file changed, 117 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi

Hi, Jisheng, as far as I know, sg2042 and cv180x are now tracked by 
different people and even in sophgo, they are two independent 
projects(sg2042 is target for HPC and cv180x is target for embeded 
device). To facilitate future management and review, I recommend 
registering the maintainer information in two entries in MAINTAINERS. 
The example is as follows:

```

SOPHGO CV180X DEVICETREES
M:  Jisheng Zhang <jszhang@kernel.org>
F:  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
F:  arch/riscv/boot/dts/sophgo/cv1800b.dtsi

SOPHGO SG2042 DEVICETREES
M:  Chao Wei <chao.wei@sophgo.com>
M:  Chen Wang <unicornxw@gmail.com>
S:  Maintained
F:  arch/riscv/boot/dts/sophgo/Makefile
F:  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
F:  arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
F:  arch/riscv/boot/dts/sophgo/sg2042.dtsi
F:  Documentation/devicetree/bindings/riscv/sophgo.yaml
```

For Makefile and sophgo.yaml such common files, just keep in sg2042 
entry should be fine.

@Conor, what do you think?

Thanks,

Chen


> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> new file mode 100644
> index 000000000000..8829bebaa017
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "sophgo,cv1800b";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <25000000>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "thead,c906", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <512>;
> +			d-cache-size = <65536>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			mmu-type = "riscv,sv39";
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	osc: oscillator {
> +		compatible = "fixed-clock";
> +		clock-output-names = "osc_25m";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@04140000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04140000 0x100>;
> +			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@04150000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04150000 0x100>;
> +			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@04160000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04160000 0x100>;
> +			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@04170000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04170000 0x100>;
> +			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@041c0000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x041c0000 0x100>;
> +			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@70000000 {
> +			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> +			reg = <0x70000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <101>;
> +		};
> +	};
> +};
