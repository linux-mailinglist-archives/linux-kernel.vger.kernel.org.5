Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E41756DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjGQT61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGQT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:58:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A61738
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:58:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99342a599e9so697911266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689623888; x=1692215888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCWvgKUXfcW1CPS5sL1xeCdhcIZJ7olcj1eoB35DPKY=;
        b=FYiL78JQFAZQkZuMCP3Kkz2pXDfnIy2mkoW84p24YFfPCUYfyCa1OBXQXkps4rvxc0
         VVG8IbaU0LhSDVy7/6+1MaAWpftz2fjvsomf+J0PsaBBMXm6wXC2bphsw6ScSzh++TAq
         udgfArxo5zxNGgenWAZ9xms56ILBGMh25jhzYeaFYzuIEU62KlRSzh4xi3EfNGunnbCc
         6wcJ2g6LLLlJLc9gZMZlKrlxhuVOsPJ5rLjCH7UPRObW1FZKFcg1ilBr/2lIpxNIypcM
         wIsQuuPd8I+MHkU9nVqhjM1sayMZ8VHR93pQ46XXVYN81n33+o7FNZarAgcgxRzSGl+g
         mFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623888; x=1692215888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCWvgKUXfcW1CPS5sL1xeCdhcIZJ7olcj1eoB35DPKY=;
        b=WMJny/dfc0Z5HKfes6hJzbpDudafAmqqGrZAC3d3mnoo56pSHErRuoOE3iza+yZtdZ
         UtTKiDx8Z1OxtE+fkMCqkKTPrs6JPU4Bu6TvX10wsxlGYamP3g2p5sM4pFvf8qZTZSq+
         j+mW+WXKquFr+U3YhQXX9s1MtiM7OnsTqK0zCazDmZupwfhFjA4JjAEOKSZiK4lB1cp2
         TZDG+NipdVfDlmmZIa5gJXFm3SHzaLLStRNyPQlF8EkHTTPGXZgG83eiBtAEhkrF73Q1
         7NqCXE4dU05elwQSQxsQGQ7NOb2xVGR/tPj6wTwgbwbqWvS/CUeJlSoyVM+jLiOplzSj
         lBiw==
X-Gm-Message-State: ABy/qLYjxd2eZwqISfykdoixedr6nXsYUklfjRaLqamOy8z8gdxohDtj
        0lcg1RhPvsbEZ9822/mdcazEOQ==
X-Google-Smtp-Source: APBJJlGPH/4WX3gvMsX76UHYK0bLVpi5LnmMFLDa/91Ewd2MMtPkpY4SnQrrAXgEujst5NHSR/yweg==
X-Received: by 2002:a17:907:7709:b0:94f:3521:394 with SMTP id kw9-20020a170907770900b0094f35210394mr10161706ejc.51.1689623888534;
        Mon, 17 Jul 2023 12:58:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906828a00b0094e7d196aa4sm82784ejx.160.2023.07.17.12.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:58:08 -0700 (PDT)
Message-ID: <43ecf0b0-4b55-ab11-3b80-b9243b971c2c@linaro.org>
Date:   Mon, 17 Jul 2023 21:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
 <20230717120300.21388-5-jason-ch.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717120300.21388-5-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 14:03, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8188 on evaluation board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 401 +++++++++
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 951 ++++++++++++++++++++
>  3 files changed, 1353 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c99c3372a4b5..9bd2324259a3 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> new file mode 100644
> index 000000000000..d8906172390e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8188 evaluation board";
> +	compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial0:115200n8";
> +		kaslr-seed = <0 0>;

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scp_mem_reserved: scp_mem_region {

No underscores in node names.

> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +	};


Best regards,
Krzysztof

