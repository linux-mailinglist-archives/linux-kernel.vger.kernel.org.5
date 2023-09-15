Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588097A178E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjIOHfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjIOHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:35:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE0D196
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:34:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso1642071f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694763297; x=1695368097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOhwwySDKn21smjpOk6dEq+GSuFI63bl1UFYi1EKI04=;
        b=S2ajIbeYZYyTxsEYGmgWJPM9xwmLu7ijk0YL49umjAtFn8R8WN+895HHJGC7MxEpNd
         s1doNM5/JqYzgFoG6nikIaGseeQnNZc9NsoCebUdusj982F2A+kO7Zxm8xb3xAgxulFD
         FV7mvoCWhy/hIrtDHWEhmVkOABcJE5e4dnyWaxSE9yiz/iugtAq3ALnZJ5IGoyxElwR/
         tW12+tyKNEbUurCBdC1Oc4ionblUfISkB9wuZdfmy7A4aQ/K/idxPd6aUO+wUkLF1ell
         fWZiK0urWXkfTA1GQAvUQyI3SDZTc/TY0SjwvL2E5ViPsZ/UXYvDgslhWMsoxPKY8rKb
         uX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763297; x=1695368097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOhwwySDKn21smjpOk6dEq+GSuFI63bl1UFYi1EKI04=;
        b=Jg37hYNPLzL5qPZJhZ7ulrGKXTnmGMgrspbbiyqj+ZEBvuPQ9lJedHpA/tejOI0uVI
         QB4bmGsJXHEfNCTQVWvKEeY8gfJavL1YmFKkmbK07fPLpaQ0Q48BJy/Z3tXJSkhFWqGT
         IEr+kZI0sDtREWClBCX6EGK7fI/gpOIJU33+aoG8lboEuXZre1c3T9BpHuy/REOtcVIv
         CaOJ91kGqWnUvgM8UlboGAROGrogsQoHm4+G4VIoaDP4yPRF02ogmSvceobxqeS32rKt
         VdthLPxpMDSmyooINIwguUEqv6katbEYwUZoEvTjp1Z8VmRi9dt5+ljPwyBTdTTzcxWf
         3AaQ==
X-Gm-Message-State: AOJu0YwZqsw0zBJyuyPX1VkHDbgPKxxdmZD/CMcCjcM8rInTl0ZkUEl1
        z84qF/Qt/ujq0pOVySDIJinZZQ==
X-Google-Smtp-Source: AGHT+IExuGBnRGeiPUMGNEcpJuC9JYDa0ARcsc3STMPxBsCsHrtn9sUbxB+m5v9Cwhl0shqQDvwc+g==
X-Received: by 2002:adf:eec5:0:b0:31f:9860:2325 with SMTP id a5-20020adfeec5000000b0031f98602325mr610529wrp.67.1694763297409;
        Fri, 15 Sep 2023 00:34:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d6ac8000000b0031416362e23sm3731001wrw.3.2023.09.15.00.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:34:56 -0700 (PDT)
Message-ID: <fa554890-7315-97cb-a9d3-d0acf18d0ff2@linaro.org>
Date:   Fri, 15 Sep 2023 09:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 08/12] riscv: dts: sophgo: add Milk-V Pioneer board device
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
References: <20230915072451.118209-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915072451.118209-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:24, Wang Chen wrote:
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON
> SG2042 in a standard mATX form factor. It is a good
> choice for RISC-V developers and hardware pioneers to
> experience the cutting edge technology of RISC-V.
> 
> Currently only support booting into console with only uart
> enabled, other features will be added soon later.
> 
> [1]: https://milkv.io/pioneer
> 
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/Makefile                     |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile              |  3 +++
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts     | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f60a280abb15..94788486f13e 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -6,5 +6,6 @@ subdir-y += renesas
>  subdir-y += sifive
>  subdir-y += starfive
>  subdir-y += thead
> +subdir-y += sophgo
>  
>  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> new file mode 100644
> index 000000000000..5a471b19df22
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> +
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> new file mode 100644
> index 000000000000..4f480ff88fbd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include "sg2042.dtsi"
> +
> +/ {
> +	model = "Milk-V Pioneer";
> +	compatible = "milkv,pioneer", "sophgo,sg2042";
> +
> +	info {

Drop, there is no such node. Otherwise, please point me where are the
bindings for it?

Anyway your submissions is incomplete. Your DTS should enable some
peripherals, like serials etc.

Best regards,
Krzysztof

