Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A167BBAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjJFOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:49:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85954E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:49:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0605AC433C7;
        Fri,  6 Oct 2023 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696603741;
        bh=umqG2Vr+mTf5yJgKR+T2964HJLMvzddkT3m/kr/44mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c73mGCajUXAGcjUUoGTiOHC+FjsVgS0OAbOlyqoMLosKXDk/FTXTkpFhXgii7DRFP
         d9N7Td4bdhVXhZA7nqL3wxxmq/9crn2J9M5hsuF4ebVWpxa/+hCke6FZxjy9ZPF7Qi
         VcYhKMEARDV5ppl9gxb0T4v5t3XvDh7cXEvfMT5B40Jkttm4hLcAXJujVRaSJTQVnT
         yWncdZq92rhlt1i1d5HoE2opBDHYIJtGfZ4nL4hYq8pd469CgGcog/Xv0dmM+18MXe
         4OkZA1iFybkUIs0eLRZSJ7i4hgXkm2Sf8K2Ec2BqBojgYiJ7l54vUymadadqYx00Y0
         EpSd2iDGr5k3g==
Date:   Fri, 6 Oct 2023 22:36:51 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v4 08/10] riscv: dts: add initial Sophgo SG2042 SoC
 device tree
Message-ID: <ZSAbgxZItMsEHfio@xhacker>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
 <ce56aba64ccd237e5d9248b9b9ed937ffb8894c8.1696433229.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce56aba64ccd237e5d9248b9b9ed937ffb8894c8.1696433229.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:44:06PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Milk-V Pioneer motherboard is powered by SG2042.
> 
> SG2042 is server grade chip with high performance, low power
> consumption and high data throughput.
> Key features:
> - 64 RISC-V cpu cores
> - 4 cores per cluster, 16 clusters on chip
> - More info is available at [1].
> 
> Currently only support booting into console with only uart,
> other features will be added soon later.
> 
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Acked-by: Chao Wei <chao.wei@sophgo.com>
> Co-developed-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Co-developed-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> 
> Link: https://en.sophgo.com/product/introduce/sg2042.html [1]
> ---
>  MAINTAINERS                                 |    1 +
>  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 2000 +++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi      |  325 +++
>  3 files changed, 2326 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97cb8abcfeee..fedf042e5fb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20067,6 +20067,7 @@ SOPHGO DEVICETREES
>  M:	Chao Wei <chao.wei@sophgo.com>
>  M:	Chen Wang <unicorn_wang@outlook.com>
>  S:	Maintained
> +F:	arch/riscv/boot/dts/sophgo/
>  F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
>  
>  SOUND
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> new file mode 100644
> index 000000000000..b136b6c4128c
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -0,0 +1,2000 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
...

> +		intc: interrupt-controller@7090000000 {
> +			compatible = "sophgo,sg2042-plic", "thead,c900-plic";
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x00000070 0x90000000 0x00000000 0x04000000>;
> +			interrupt-controller;
> +			interrupts-extended =
> +				<&cpu0_intc 0xffffffff>,  <&cpu0_intc 9>,

-1 may not be correct, is machine external interrupt(id: 11) supported?

Thanks
