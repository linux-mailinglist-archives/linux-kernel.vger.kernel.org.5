Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742047A1769
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjIOH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIOH2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:28:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4091BEC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:28:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso242212566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762909; x=1695367709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+90Hr//frpTkWEteZOWRQ+nQcKMb773c4X0lXsObrM=;
        b=VM1YvPU+lCbp+aLDYBznr0rzl7BGTVTkn88grvq4riAUX8tZBuz4hbAYUaEsY/rdmB
         F8xUnlgOuRbQ5EajczYpsphr36KZXt801HgVISXavsU4cWzYk4UJZOUiiYxhhXM7J8q7
         g1yoWuOrKTp04KNJDZJ+n4dqZB7WtmMpR+6fFV4ks/XR8v9hQb4eAbGFB/fpGBU0kf0p
         Ujbhq3xpItI40lTBT4pxTJzFraxZxMJnuRj/VQEz1xZ1NtYSNvyE+4qndSLYgwp9me4/
         GBnKZJdZCHw1spN95bJKsx8ohrc/Q/oFcVAaFmzNy/6efhbidCyj3HKJRUqPSvK0hl06
         NqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762909; x=1695367709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+90Hr//frpTkWEteZOWRQ+nQcKMb773c4X0lXsObrM=;
        b=DxiapSqKYRT4rUyDs7gM2y6adFcVyvx3WDR5XLmhL4I33MwOj6h/lKt8owAdZShppp
         FPc6FjBNmf7amCsSYNpcikCZk8LKEPaxftLMFMd6xz5fz+Up0+9U4mpgZ8YEMZlAdzVf
         xxvwAfooppIhJb7FtzqEqLRFnWrn+UCiON+yhjWKGFhmPJ0raJHsaDSFgJSZsRbJzn1d
         TmfDbtmQ/9Zgn/+IpxcQI3SXWep7QXxV6bZXj9pSJE7nd9GAU833Fj0woNQB6CPBidxT
         vr3Aoy+p9ku4woOMgV3xhwewaIlJGC3Z49bci9EpxdJntMiWezmusJ5eSWJZMLrem5AK
         e55g==
X-Gm-Message-State: AOJu0Yxb/4ATnN4Mo0hIbNNzIgPTodmd+CGcSZP68TSxFsM1JR7vGC3v
        PruoREUe1sR1newL8tLE38+ssg==
X-Google-Smtp-Source: AGHT+IE08NnmTdCH6VhjCu45zO4wvUo87eat3XEc+WLyWnOo7jguE1yB1dWViXm3zC1tKM1/RRntEg==
X-Received: by 2002:a17:906:846d:b0:9a6:65f8:b328 with SMTP id hx13-20020a170906846d00b009a665f8b328mr578943ejc.1.1694762908645;
        Fri, 15 Sep 2023 00:28:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906114d00b00992afee724bsm1986435eja.76.2023.09.15.00.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:28:28 -0700 (PDT)
Message-ID: <fa9755be-13c0-6934-9f48-f6cb35518331@linaro.org>
Date:   Fri, 15 Sep 2023 09:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/12] riscv: dts: add initial SOPHGO SG2042 SoC device
 tree
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
References: <20230915072431.118154-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915072431.118154-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:24, Wang Chen wrote:
> Milk-V Pioneer motherboard is powered by SOPHON's SG2042.
> 
> SG2042 is server grade chip with high performance, low power
> consumption and high data throughput.
> Key features:
> - 64 RISC-V cpu cores which implements IMAFDC
> - 4 cores per cluster, 16 clusters on chip
> - ......
> 
> More info is available at [1].
> 
> [1]: https://en.sophgo.com/product/introduce/sg2042.html
> 
> Currently only support booting into console with only uart
> enabled, other features will be added soon later.
> 
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> ---
>  MAINTAINERS                                 |    1 +
>  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 1794 +++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi      |  513 ++++++
>  3 files changed, 2308 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e0d477dab38..b74d505003e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20068,6 +20068,7 @@ M:	Xiaoguang Xing <xiaoguang.xing@sophgo.com>
>  M:	Chao Wei <chao.wei@sophgo.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
> +F:	arch/riscv/boot/dts/sophgo/
>  
>  SOUND
>  M:	Jaroslav Kysela <perex@perex.cz>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> new file mode 100644
> index 000000000000..0b6cd3559693
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -0,0 +1,1794 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +/ {


..
> +
> +		cpu0: cpu@0 {
> +			compatible = "thead,c920", "riscv";
> +			device_type = "cpu";
> +			riscv,isa = "rv64imafdc";
> +			reg = <0>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +			numa-node-id = <0>;
> +			status = "okay";

Drop, it's by defualt. This applies everywhere.

> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};

Missing blank line

> +		cpu1: cpu@1 {
> +			compatible = "thead,c920", "riscv";
> +			device_type = "cpu";
> +			riscv,isa = "rv64imafdc";
> +			reg = <1>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +			numa-node-id = <0>;
> +			status = "okay";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};

Missing blank line. This applies everywhere.

> +		cpu2: cpu@2 {
> +			compatible = "thead,c920", "riscv";
> +			device_type = "cpu";
> +			riscv,isa = "rv64imafdc";
> +			reg = <2>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <512>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <512>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +			numa-node-id = <0>;
> +			status = "okay";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};


> +
> +		l2_cache0: l2-cache@0 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};

Missing blank line

> +		l2_cache1: l2-cache@1 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};

Missing blank line

> +		l2_cache2: l2-cache@2 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache3: l2-cache@3 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache4: l2-cache@4 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache5: l2-cache@5 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache6: l2-cache@6 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache7: l2-cache@7 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache8: l2-cache@8 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache9: l2-cache@9 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache10: l2-cache@10 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache11: l2-cache@11 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache12: l2-cache@12 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache13: l2-cache@13 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache14: l2-cache@14 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +		l2_cache15: l2-cache@15 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <1048576>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> new file mode 100644
> index 000000000000..5c4b82f13207
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#include "sg2042-cpus.dtsi"
> +
> +#define SOC_PERIPHERAL_IRQ(nr) (nr)
> +
> +/ {
> +	compatible = "sophgo,sg2042";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	dma-noncoherent;
> +
> +	distance-map {
> +		compatible = "numa-distance-map-v1";
> +		distance-matrix = <0 0 10>,
> +				  <0 1 15>,
> +				  <0 2 25>,
> +				  <0 3 30>,
> +				  <1 0 15>,
> +				  <1 1 10>,
> +				  <1 2 30>,
> +				  <1 3 25>,
> +				  <2 0 25>,
> +				  <2 1 30>,
> +				  <2 2 10>,
> +				  <2 3 15>,
> +				  <3 0 30>,
> +				  <3 1 25>,
> +				  <3 2 15>,
> +				  <3 3 10>;
> +	};
> +
> +	/* the mem node will be updated by ZSBL. */
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x00000000>;
> +		numa-node-id = <0>;
> +	};
> +	memory@1 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000001 0x00000000 0x00000000>;
> +		numa-node-id = <1>;
> +	};
> +	memory@2 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000002 0x00000000 0x00000000>;
> +		numa-node-id = <2>;
> +	};
> +	memory@3 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000003 0x00000000 0x00000000>;
> +		numa-node-id = <3>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x2>;
> +		ranges;

Missing blank line

> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x00000000 0x10000000>;
> +			alloc-ranges = <0x00000000 0xc0000000
> +					0x00000000 0xd0000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "riscv,pmu";
> +		riscv,event-to-mhpmevent =
> +			<0x00003 0x00000000 0x00000010>,
> +			<0x00004 0x00000000 0x00000011>,
> +			<0x00005 0x00000000 0x00000007>,
> +			<0x00006 0x00000000 0x00000006>,
> +			<0x00008 0x00000000 0x00000027>,
> +			<0x00009 0x00000000 0x00000028>,
> +			<0x10000 0x00000000 0x0000000c>,
> +			<0x10001 0x00000000 0x0000000d>,
> +			<0x10002 0x00000000 0x0000000e>,
> +			<0x10003 0x00000000 0x0000000f>,
> +			<0x10008 0x00000000 0x00000001>,
> +			<0x10009 0x00000000 0x00000002>,
> +			<0x10010 0x00000000 0x00000010>,
> +			<0x10011 0x00000000 0x00000011>,
> +			<0x10012 0x00000000 0x00000012>,
> +			<0x10013 0x00000000 0x00000013>,
> +			<0x10019 0x00000000 0x00000004>,
> +			<0x10021 0x00000000 0x00000003>,
> +			<0x10030 0x00000000 0x0000001c>,
> +			<0x10031 0x00000000 0x0000001b>;
> +		riscv,event-to-mhpmcounters =
> +			<0x00003 0x00003 0xfffffff8>,
> +			<0x00004 0x00004 0xfffffff8>,
> +			<0x00005 0x00005 0xfffffff8>,
> +			<0x00006 0x00006 0xfffffff8>,
> +			<0x00007 0x00007 0xfffffff8>,
> +			<0x00008 0x00008 0xfffffff8>,
> +			<0x00009 0x00009 0xfffffff8>,
> +			<0x0000a 0x0000a 0xfffffff8>,
> +			<0x10000 0x10000 0xfffffff8>,
> +			<0x10001 0x10001 0xfffffff8>,
> +			<0x10002 0x10002 0xfffffff8>,
> +			<0x10003 0x10003 0xfffffff8>,
> +			<0x10008 0x10008 0xfffffff8>,
> +			<0x10009 0x10009 0xfffffff8>,
> +			<0x10010 0x10010 0xfffffff8>,
> +			<0x10011 0x10011 0xfffffff8>,
> +			<0x10012 0x10012 0xfffffff8>,
> +			<0x10013 0x10013 0xfffffff8>,
> +			<0x10019 0x10019 0xfffffff8>,
> +			<0x10021 0x10021 0xfffffff8>,
> +			<0x10030 0x10030 0xfffffff8>,
> +			<0x10031 0x10031 0xfffffff8>;
> +		riscv,raw-event-to-mhpmcounters =
> +			<0x00000000 0x00000001 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000002 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000003 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000004 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000005 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000006 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000007 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000008 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000009 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000a 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000010 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000011 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000012 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000013 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000014 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000015 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000016 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000017 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000018 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000019 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001a 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001b 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001c 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001d 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001e 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001f 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000020 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000021 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000022 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000023 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000024 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000025 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000026 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000027 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000028 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000029 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000002a 0xffffffff 0xffffffff 0xfffffff8>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clint_mswi: clint-mswi@7094000000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "sophgo,sg2042-clint-mswi", "thead,c900-clint-mswi";
> +			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
> +			interrupts-extended = <

Your formatting is odd. This wrap is not needed.

> +				&cpu0_intc 3
> +				&cpu1_intc 3
> +				&cpu2_intc 3
> +				&cpu3_intc 3
> +				&cpu4_intc 3
> +				&cpu5_intc 3
> +				&cpu6_intc 3
> +				&cpu7_intc 3
> +				&cpu8_intc 3
> +				&cpu9_intc 3
> +				&cpu10_intc 3
> +				&cpu11_intc 3
> +				&cpu12_intc 3
> +				&cpu13_intc 3
> +				&cpu14_intc 3
> +				&cpu15_intc 3
> +				&cpu16_intc 3
> +				&cpu17_intc 3
> +				&cpu18_intc 3
> +				&cpu19_intc 3
> +				&cpu20_intc 3
> +				&cpu21_intc 3
> +				&cpu22_intc 3
> +				&cpu23_intc 3
> +				&cpu24_intc 3
> +				&cpu25_intc 3
> +				&cpu26_intc 3
> +				&cpu27_intc 3
> +				&cpu28_intc 3
> +				&cpu29_intc 3
> +				&cpu30_intc 3
> +				&cpu31_intc 3
> +				&cpu32_intc 3
> +				&cpu33_intc 3
> +				&cpu34_intc 3
> +				&cpu35_intc 3
> +				&cpu36_intc 3
> +				&cpu37_intc 3
> +				&cpu38_intc 3
> +				&cpu39_intc 3
> +				&cpu40_intc 3
> +				&cpu41_intc 3
> +				&cpu42_intc 3
> +				&cpu43_intc 3
> +				&cpu44_intc 3
> +				&cpu45_intc 3
> +				&cpu46_intc 3
> +				&cpu47_intc 3
> +				&cpu48_intc 3
> +				&cpu49_intc 3
> +				&cpu50_intc 3
> +				&cpu51_intc 3
> +				&cpu52_intc 3
> +				&cpu53_intc 3
> +				&cpu54_intc 3
> +				&cpu55_intc 3
> +				&cpu56_intc 3
> +				&cpu57_intc 3
> +				&cpu58_intc 3
> +				&cpu59_intc 3
> +				&cpu60_intc 3
> +				&cpu61_intc 3
> +				&cpu62_intc 3
> +				&cpu63_intc 3
> +				>;
> +		};
> +
> +		clint_mtimer0: clint-mtimer@70ac000000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mtimer";
> +			reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
> +			interrupts-extended = <
> +				&cpu0_intc 7
> +				&cpu1_intc 7
> +				&cpu2_intc 7
> +				&cpu3_intc 7
> +				>;
> +		};
> +
> +		clint_mtimer1: clint-mtimer@70ac010000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mtimer";
> +			reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
> +			interrupts-extended = <
> +				&cpu4_intc 7

Srsly, fix your style. This is unreadable.

> +				&cpu5_intc 7
> +				&cpu6_intc 7
> +				&cpu7_intc 7
> +				>;
> +		};
> +

...

> +
> +		intc: interrupt-controller@7090000000 {
> +			compatible = "sophgo,sg2042-plic", "thead,c900-plic";
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x00000070 0x90000000 0x00000000 0x04000000>;
> +			interrupt-controller;
> +			interrupts-extended = <
> +				&cpu0_intc  0xffffffff &cpu0_intc  9
> +				&cpu1_intc  0xffffffff &cpu1_intc  9
> +				&cpu2_intc  0xffffffff &cpu2_intc  9
> +				&cpu3_intc  0xffffffff &cpu3_intc  9
> +				&cpu4_intc  0xffffffff &cpu4_intc  9
> +				&cpu5_intc  0xffffffff &cpu5_intc  9
> +				&cpu6_intc  0xffffffff &cpu6_intc  9
> +				&cpu7_intc  0xffffffff &cpu7_intc  9
> +				&cpu8_intc  0xffffffff &cpu8_intc  9
> +				&cpu9_intc  0xffffffff &cpu9_intc  9
> +				&cpu10_intc  0xffffffff &cpu10_intc  9
> +				&cpu11_intc  0xffffffff &cpu11_intc  9
> +				&cpu12_intc  0xffffffff &cpu12_intc  9
> +				&cpu13_intc  0xffffffff &cpu13_intc  9
> +				&cpu14_intc  0xffffffff &cpu14_intc  9
> +				&cpu15_intc  0xffffffff &cpu15_intc  9
> +				&cpu16_intc  0xffffffff &cpu16_intc  9
> +				&cpu17_intc  0xffffffff &cpu17_intc  9
> +				&cpu18_intc  0xffffffff &cpu18_intc  9
> +				&cpu19_intc  0xffffffff &cpu19_intc  9
> +				&cpu20_intc  0xffffffff &cpu20_intc  9
> +				&cpu21_intc  0xffffffff &cpu21_intc  9
> +				&cpu22_intc  0xffffffff &cpu22_intc  9
> +				&cpu23_intc  0xffffffff &cpu23_intc  9
> +				&cpu24_intc  0xffffffff &cpu24_intc  9
> +				&cpu25_intc  0xffffffff &cpu25_intc  9
> +				&cpu26_intc  0xffffffff &cpu26_intc  9
> +				&cpu27_intc  0xffffffff &cpu27_intc  9
> +				&cpu28_intc  0xffffffff &cpu28_intc  9
> +				&cpu29_intc  0xffffffff &cpu29_intc  9
> +				&cpu30_intc  0xffffffff &cpu30_intc  9
> +				&cpu31_intc  0xffffffff &cpu31_intc  9
> +				&cpu32_intc  0xffffffff &cpu32_intc  9
> +				&cpu33_intc  0xffffffff &cpu33_intc  9
> +				&cpu34_intc  0xffffffff &cpu34_intc  9
> +				&cpu35_intc  0xffffffff &cpu35_intc  9
> +				&cpu36_intc  0xffffffff &cpu36_intc  9
> +				&cpu37_intc  0xffffffff &cpu37_intc  9
> +				&cpu38_intc  0xffffffff &cpu38_intc  9
> +				&cpu39_intc  0xffffffff &cpu39_intc  9
> +				&cpu40_intc  0xffffffff &cpu40_intc  9
> +				&cpu41_intc  0xffffffff &cpu41_intc  9
> +				&cpu42_intc  0xffffffff &cpu42_intc  9
> +				&cpu43_intc  0xffffffff &cpu43_intc  9
> +				&cpu44_intc  0xffffffff &cpu44_intc  9
> +				&cpu45_intc  0xffffffff &cpu45_intc  9
> +				&cpu46_intc  0xffffffff &cpu46_intc  9
> +				&cpu47_intc  0xffffffff &cpu47_intc  9
> +				&cpu48_intc  0xffffffff &cpu48_intc  9
> +				&cpu49_intc  0xffffffff &cpu49_intc  9
> +				&cpu50_intc  0xffffffff &cpu50_intc  9
> +				&cpu51_intc  0xffffffff &cpu51_intc  9
> +				&cpu52_intc  0xffffffff &cpu52_intc  9
> +				&cpu53_intc  0xffffffff &cpu53_intc  9
> +				&cpu54_intc  0xffffffff &cpu54_intc  9
> +				&cpu55_intc  0xffffffff &cpu55_intc  9
> +				&cpu56_intc  0xffffffff &cpu56_intc  9
> +				&cpu57_intc  0xffffffff &cpu57_intc  9
> +				&cpu58_intc  0xffffffff &cpu58_intc  9
> +				&cpu59_intc  0xffffffff &cpu59_intc  9
> +				&cpu60_intc  0xffffffff &cpu60_intc  9
> +				&cpu61_intc  0xffffffff &cpu61_intc  9
> +				&cpu62_intc  0xffffffff &cpu62_intc  9
> +				&cpu63_intc  0xffffffff &cpu63_intc  9
> +				>;
> +			riscv,ndev = <224>;
> +		};
> +
> +		uart0: serial@7040000000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <SOC_PERIPHERAL_IRQ(112) IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <500000000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +		};
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};

This does not go to the end. Keep the nodes ordered alphanumerically.

> +
> +	chosen: chosen {
> +		bootargs = "console=ttyS0,115200 earlycon";

NAK. No need and not suitable for mainline usage.

> +		stdout-path = "serial0";

You need only this.

> +	};
> +};

Best regards,
Krzysztof

