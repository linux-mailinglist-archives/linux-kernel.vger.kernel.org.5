Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1045B7DCF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbjJaOlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbjJaOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:41:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3507BDB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:41:02 -0700 (PDT)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88ACF3F0B5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698763258;
        bh=bM2sMwP6Emxus/eSEbKlChfhnru0P5WYRen9BWIIMG8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=X2cLZTD/EvL5niE57t6mvqmMHl3VGajjHMYMfTMCqOcvrbCP/pShUShNXW5OkR33J
         QWzjLcLOUTWzDyxSeoYXpsfV8P3xZMvT5eE6C9EY14vmEsyuuj1+cTPHV5xyupXvPq
         3+/lJKIws5d+tC2DSAmAYwDeGPIywzoKT+l11yq+u6RyaN4B7c5MduM+2lLgAdLbJx
         VCIkMnWzkFZzPm46maRZQUNIGeoPFCwjoGLD95imoevLXcmc3EodH694xXcp6fsD55
         irsT4TUOylS5xUzIgUWWQLXJ0LYiKqxh2M8MkPj/aYGiAmC/03pYWoQA+z09NYYCIy
         YVm2ThM7SO9gw==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dd886536f2so7523613fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763257; x=1699368057;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bM2sMwP6Emxus/eSEbKlChfhnru0P5WYRen9BWIIMG8=;
        b=b65ooRJkIILT8DXOcYZKPKVsoooYTkFe/0+HJr7Z6fpGoiyVRQu6j5LrOXrQfNbWuu
         9BUxGyc0KZi0W6weyOhIMA0ytfYDUUIF73oCkS46rzoelA5PfsbMwlkcacYt3MofvM8J
         bpSYWfU2pHD2EcLkuleojhKJ9Q9tCr/V187oqeWIwkLkthFHogR9us4dkpZvP4gsJXlv
         AhjSQDO4HXkbmelgZJ7I6hfp0QAo5Zxp5TIoZm/JBdCa3VK+2+NOmV0zQfhYOJxOgJOO
         t8P/Oa2/XdXMkl3jVcC07hmnGqpg5wV5Ib3NJacUg2EaXl3lEV0sqA4sxsEq0wLVlagT
         EvEw==
X-Gm-Message-State: AOJu0Yyqw2UYyfSNkqps1vl61jMSDZAxXnfRDhee9JJSOV6ytR+YYUFn
        E66nfJMv8Zbr77cy9TkcoduAOLTvDCi7jxc/lMhrBxu31I5EPD82k5FIncy1hfbrNPpBg+agPeV
        Lzwli+6iWKOFF/NDaMDDLzDq/HDN18R72kvBf5NoFnjrdbt0d+OxapxQYYg==
X-Received: by 2002:a05:6870:1b16:b0:1ef:d51b:5f50 with SMTP id hl22-20020a0568701b1600b001efd51b5f50mr7603593oab.22.1698763257487;
        Tue, 31 Oct 2023 07:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFANyRAH1nXo4IUkrqN1HKuYxzfESQEmdy7ahALAdU7wdendE3vJG+CITZSdHBFI/mTHqrjKI5/+mlEUc3+Ggo=
X-Received: by 2002:a05:6870:1b16:b0:1ef:d51b:5f50 with SMTP id
 hl22-20020a0568701b1600b001efd51b5f50mr7603564oab.22.1698763257269; Tue, 31
 Oct 2023 07:40:57 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 07:40:56 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
Mime-Version: 1.0
Date:   Tue, 31 Oct 2023 07:40:56 -0700
Message-ID: <CAJM55Z_2hdsvw8gdYLs2kZbRrH6xcM6+xCZn8BCf5zsWYyhY3w@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA
 memory on JH7100 boards
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian Ciocaltea wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
> expect to be able to allocate coherent memory for DMA descriptors and
> such. However on the JH7100 DDR memory appears twice in the physical
> memory map, once cached and once uncached:
>
>   0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
>   0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached
>
> To use this uncached region we create a global DMA memory pool there and
> reserve the corresponding area in the cached region.
>
> However the uncached region is fully above the 32bit address limit, so add
> a dma-ranges map so the DMA address used for peripherals is still in the
> regular cached region below the limit.

Adding these nodes to the device tree won't actually do anything without
enabling CONFIG_DMA_GLOBAL_POOL as is done here:

https://github.com/esmil/linux/commit/e14ad9ff67fd51dcc76415d4cc7f3a30ffcba379

>
> Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index b93ce351a90f..504c73f01f14 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -39,6 +39,30 @@ led-ack {
>  			label = "ack";
>  		};
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dma-reserved {
> +			reg = <0x0 0xfa000000 0x0 0x1000000>;
> +			no-map;
> +		};
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10 0x7a000000 0x0 0x1000000>;
> +			no-map;
> +			linux,dma-default;
> +		};
> +	};
> +
> +	soc {
> +		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
> +			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
> +			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
> +	};
>  };
>
>  &gpio {
> --
> 2.42.0
>
