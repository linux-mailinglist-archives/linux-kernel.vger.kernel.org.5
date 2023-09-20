Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD607A7C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjITMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjITL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:59:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D2A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:59:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9adb9fa7200so186263066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695211191; x=1695815991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N46lU5p0BnRUo8JJjDH0v6qnXmdpf6A9RpC24puqDNo=;
        b=rRNCQc7rAI4RQlWbdNpY4seCvsBnnu3bTFAKaqEqkvs90uucn2T4AoG/6LyeyBJ55+
         OT99OSAsy61xr5jyX5yMRA1jcwayTRA6uWGyuWmFi0ndEQ+PDT+Pjs9vOQXH7qfswRmU
         2PaLHqHuG6nCWw5zXB5eDTyCzCHcjDvDaOqhLrsn3FTCGfs3dgIxiAirtwGBZWrzRuTP
         Yg3VGWmKR5tZezHjGQEupg+f5QVAHWt7lVWyQAzfYZnT62jGsCEzeBNadSMvdvW/tZHa
         OF9apGc+RJs8hmPQu5oMxdBC71wI0EChlycPZRUeT+8dTRUl2bG/oZggxmaK8DUb1HCY
         i+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695211191; x=1695815991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N46lU5p0BnRUo8JJjDH0v6qnXmdpf6A9RpC24puqDNo=;
        b=qUgshPUjlUJnsAr0cTvZjIDLSSfMd0uo0/ZK7oSlN51v25wWqDO7aRsWbYhzxZs0pG
         qMHD0pGlkdBfW2Igl8DjzvR13SSh0I1kxSxSzaQkYEIV8rID2C3qGnCYbG+Haav8qwux
         8nwWl2gQ0qiIQ/sLwzWFE+wEA+4YM/4SWVo+Eqzu7pSlnarDlqSygt9T9bKVmji+yPM+
         ++I6qZYeSJ5XiFXPvhJkVptL5oeomPLPjx9FYWL9LOMdWztr9VKOs2EbMd47fi9OOedy
         1SxmTvTPBg1fYfSXUmDCPJbZsKu0kEDkHg9rKV5Pm79N8UQmTWUsVbnJEwiiCJMpkKt+
         oxTQ==
X-Gm-Message-State: AOJu0Yw1BHZbN2rNsEsvwwfEjLytzDmcrAFHHJipw7dPsnNTTV+FY0ee
        d0hg2DQ4qIKFhWIMfKHwzQfkzA==
X-Google-Smtp-Source: AGHT+IGnACKqgtYQF2pNy2P1QPZMSIK5/+BVvB5z1ir2z6NqSx7yASc1Y4QTK2+UcyiIoVPLWMKmVA==
X-Received: by 2002:a17:907:c17:b0:9a5:ca06:6a25 with SMTP id ga23-20020a1709070c1700b009a5ca066a25mr8480612ejc.16.1695211191629;
        Wed, 20 Sep 2023 04:59:51 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906148b00b0098e78ff1a87sm9201237ejc.120.2023.09.20.04.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:59:51 -0700 (PDT)
Message-ID: <e18fe9a1-99a9-5dc8-27fc-6a6b934d917e@linaro.org>
Date:   Wed, 20 Sep 2023 13:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 10/11] riscv: dts: sophgo: add Milk-V Pioneer board
 device tree
Content-Language: en-US
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
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

On 20/09/2023 08:40, Chen Wang wrote:
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
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile           |  3 +++
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
>  3 files changed, 23 insertions(+)
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
> index 000000000000..d6e8c0285d1e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -0,0 +1,19 @@
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
> +	chosen: chosen {

Drop label, not used.


Best regards,
Krzysztof

