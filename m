Return-Path: <linux-kernel+bounces-12024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C981EF04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47022B20EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F244C7E;
	Wed, 27 Dec 2023 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jf5SkwoL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E55446D2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336990fb8fbso3496831f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703680862; x=1704285662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IobSWW9egD1J6lnzp7nWS1ewez0NIEgra4uxbagq4Ac=;
        b=Jf5SkwoLMAFvf/JGyqZ3KBpNUzPyXmQJ06LQ1rvWGMU9hzLfZ8XyCFB1rAdAL8gy+d
         jFWpZC/AIBZOtYd30+aMx2mnqvpQx0kEmYXpYaEy8fZl1WRweOyTkwbJPrrwmxZdhNPo
         90oojrNuu75rDam/Wh1bx6APpYmwNfkM0U0wGR8MguThR/qZzVCjvYRvcmK43e99CNPA
         x/LOre6RjPlI0p9VrH/BDPe2rR132UHRzk98QKDsIpmMjvACfl5fNUTB5BjyZQ2OhDpD
         zOwmCLzIiU+Mq83JxUsYU02PQTs+Wlxb8ZQ3C894sr43aKsBB9xbaq8A5t4+xFgf2QJY
         8GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703680862; x=1704285662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IobSWW9egD1J6lnzp7nWS1ewez0NIEgra4uxbagq4Ac=;
        b=Qx7hWOlay+lgPv0Zl6LcaJDzewNkjQbuy9Wzl4ZAV9FzCVs928t07PndspClUuLWIh
         YdrnMrKNmF7F/SNrdQE0zSy3nIMx0Aw0QQpMjbiNPSHsr8vmfd3FExdznUYFV1U39HM3
         gKFGshuvRLcGJflusiUdp0vxT7v4oXUUcdchx+FNZGRlHsWGu35kRri1XpNrA6UoLpNx
         mTiQ7JV23UaAcBghOFaHp0PKQ5FnkSplAu8orpjC/JY02hdWFs5MibTRTlgTxGVzxUHV
         Kiiv20/D2EWSx9JCIka0fi75Hs1o9qa6GcdFcWrAJVPKmAD7T2Ft6uRx13cWnAvEk7St
         WVdg==
X-Gm-Message-State: AOJu0Yy+x7cu7Z6icYuJRoj1VNsNp1Nb1fWJ548EKMP/Hts8gVm5CP8F
	4sUqfjv8cgIII9+imkjq6JKMn713AJOiCg==
X-Google-Smtp-Source: AGHT+IGBt+TovOPy4NKH37QHcuLITaQxwt7XvM/pUisHh8D6fzAOz557SHXJpaJ2EtnQ67ZT0anVNw==
X-Received: by 2002:a1c:7415:0:b0:40d:492d:c376 with SMTP id p21-20020a1c7415000000b0040d492dc376mr4720648wmc.114.1703680862515;
        Wed, 27 Dec 2023 04:41:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0040c11fbe581sm24050242wmq.27.2023.12.27.04.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 04:41:01 -0800 (PST)
Message-ID: <75fd794c-0366-445b-aa69-0975afb247c7@linaro.org>
Date: Wed, 27 Dec 2023 13:40:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: ac5: add mmc node and clock
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 huziji@marvell.com, ulf.hansson@linaro.org, catalin.marinas@arm.com,
 will@kernel.org, adrian.hunter@intel.com, thunder.leizhen@huawei.com,
 bhe@redhat.com, akpm@linux-foundation.org, yajun.deng@linux.dev,
 chris.zjh@huawei.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cyuval@marvell.com
References: <20231227123257.1170590-1-enachman@marvell.com>
 <20231227123257.1170590-4-enachman@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231227123257.1170590-4-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/2023 13:32, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add mmc and mmc clock nodes to ac5 and ac5x device tree files
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 33 ++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> index b5e042b8e929..decad14d0db8 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> @@ -77,7 +77,6 @@ soc {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
> -		dma-ranges;
>  
>  		internal-regs@7f000000 {
>  			#address-cells = <1>;
> @@ -204,6 +203,31 @@ gpio1: gpio@18140 {
>  			};
>  		};
>  
> +		mmc_dma: mmc-dma-peripherals@80500000 {

Generic node name, so bus@?

> +				compatible = "simple-bus";
> +				#address-cells = <0x2>;
> +				#size-cells = <0x2>;
> +				ranges;

ranges is second.

You have address/size cells, so are you sure dtbs W=1 does not complain?


> +				dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> +				dma-coherent;
> +
> +				sdhci: mmc@805c0000 {
> +					compatible = "marvell,ac5-sdhci",
> +						     "marvell,armada-ap806-sdhci";
> +					reg = <0x0 0x805c0000 0x0 0x1000>;
> +					interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&emmc_clock>, <&cnm_clock>;
> +					clock-names = "core", "axi";
> +					status = "okay";

Drop

> +					bus-width = <8>;
> +					/*marvell,xenon-phy-slow-mode;*/

Drop or explain why commented code should be here.

> +					non-removable;
> +					mmc-ddr-1_8v;
> +					mmc-hs200-1_8v;
> +					mmc-hs400-1_8v;
> +				};
> +		};
> +
>  		/*
>  		 * Dedicated section for devices behind 32bit controllers so we
>  		 * can configure specific DMA mapping for them
> @@ -335,5 +359,12 @@ nand_clock: nand-clock {
>  			#clock-cells = <0>;
>  			clock-frequency = <400000000>;
>  		};
> +
> +		emmc_clock: emmc_clock {

No underscores in node names. I think you got such feedback before.

But anyway, this looks like a fake clock.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
> +

Drop

>  	};
>  };

Best regards,
Krzysztof


