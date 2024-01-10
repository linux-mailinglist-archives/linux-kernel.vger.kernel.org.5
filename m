Return-Path: <linux-kernel+bounces-22106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C178F829949
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CB31C257F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091D47F6F;
	Wed, 10 Jan 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/HwPXUn"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E947F4B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2821884a09so322987266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704886854; x=1705491654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCsB5QvkhBd8DXp6y9aUB4ktFWnjCacK4xzgw3mwVrA=;
        b=b/HwPXUnvQU8o/XAg4lj3sC00BHj5JGnXwSPJsUQsMfXU/Ot82Vf6S/phPejiQp+dV
         zdjx4X52hZuuXDm0aTwPQfiyp+0IEQjyuMZjciA0DPh1+WYpyrvk9y+Sbr3QCdvuOeDi
         5czTxHLM/wPNZnJC08vYbqC8QvbW87le5hwqmG98YjvZoha49dPm+6pQmkYWF2+UI3IP
         KzHmOMBUIdlNQj8+1w9j8xf+9UMrn65EYxKfS97YgVL1o16JHQ2LUbdJiQHpOw0gZK2p
         o1C/LIrJVF+2ymvi983j4RJiJE1KQsnjOYgI5wOx27PNd99olYNmlS11ufg9sdjWAkGv
         yixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886854; x=1705491654;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCsB5QvkhBd8DXp6y9aUB4ktFWnjCacK4xzgw3mwVrA=;
        b=IPcKbYFb2WUCXfZfAdTZMfCAL8ri5aQaWhmQHzCHsjpBZPBDtb6RT6JlYim69pHpHZ
         uLBdaNSe6bMCdVlZ8Sk3jMHX2B3KnUUS0aGFTGBwVGM5mcL+aPawOVkzKNb4GbIs6ARy
         M+R8xGWFL0l5e9Vlgm4yQwPfnAG7wU5wBtqDGFCfJzztauKRtEbiBwDY/oSca3wUEKtk
         DqyHKTadBnvkYoDv0CppOcYKICynbdvpqzN/o1Ad59gHP1CTVRT5zuhFkomX1RNZv48g
         HCkiSPjWRxAcGsxdVp1HlphD0tYQIDo31Emhnoqp4T7ObUbbGOgYDGBoXcPE3MKWZ9wF
         RsvQ==
X-Gm-Message-State: AOJu0Yyepd8XGvWeu6pMIGRmimxEPhjbVxUeQIkbqlqd2RD6lGQGPZcm
	1zFRHKrjUILKaYWyRuvC8ERTxNzEdH7kag==
X-Google-Smtp-Source: AGHT+IGXxlT0d6gzt0GUsmEZJyFJpOc1u6aWuYK1GYJPBRYSa87C5ymlLlDPciWj7u7nOVZh2p85MQ==
X-Received: by 2002:a17:906:fcda:b0:a28:5745:91b2 with SMTP id qx26-20020a170906fcda00b00a28574591b2mr481516ejb.20.1704886854290;
        Wed, 10 Jan 2024 03:40:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a2b9e2c971fsm889895ejc.191.2024.01.10.03.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:40:53 -0800 (PST)
Message-ID: <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org>
Date: Wed, 10 Jan 2024 12:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
To: Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com,
 quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-2-quic_luoj@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110112059.2498-2-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 12:20, Luo Jie wrote:
> The PPE device tree node includes the PPE initialization configurations
> and UNIPHY instance configuration.
> 
> Ther are 3 UNIPHYs(PCS) on the platform ipq9574, which register the
> clock provider to output the clock for PPE port to work on the different
> link speed.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 730 +++++++++++++++++++++++++-
>  1 file changed, 724 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 810cda4a850f..5fa241e27c8b 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -775,16 +775,734 @@ nsscc: nsscc@39b00000 {
>  				 <&bias_pll_nss_noc_clk>,
>  				 <&bias_pll_ubi_nc_clk>,
>  				 <&gcc_gpll0_out_aux>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&uniphys 0>,
> +				 <&uniphys 1>,
> +				 <&uniphys 2>,
> +				 <&uniphys 3>,
> +				 <&uniphys 4>,
> +				 <&uniphys 5>,
>  				 <&xo_board_clk>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> +
> +		qcom_ppe: qcom-ppe@3a000000 {

qcom is definitely not a generic name.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "qcom,ipq9574-ppe";

I don't see this documented. I don't see reference to posted bindings.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Ignoring this warning is a sign you don't really check your patches
before sending.

> +			reg = <0x3a000000 0xb00000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;

Put after reg.

> +			status = "okay";

Drop

All of above comments apply to your entire patchset and all places.

Looking at code further, it does not look like suitable for mainline,
but copy of downstream code. That's not what we expect upstream. Please
go back to your bindings first. Also, I really insist you reaching out
to other folks to help you in this process.

Best regards,
Krzysztof


