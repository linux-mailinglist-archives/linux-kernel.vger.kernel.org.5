Return-Path: <linux-kernel+bounces-60031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442F84FEE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A24B21F20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235017BD3;
	Fri,  9 Feb 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpWRg6P1"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35914F6C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514168; cv=none; b=jDqzxbg2yuBPKHHEdgoxdLuGBiHTaPsxUdJg2pUtH3vV4E3izusdOrEXGRvuaIZU9eEXVk/rpRlUw0BNGb15WwTGDCl9FOmuxkeXKc0RkA0bWmHrnLoNOVPKDAGJQSeYGASpPtmtjC1jE3kRNGX/GVzqFKvlbiMUEXsE47Pqw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514168; c=relaxed/simple;
	bh=pWreq0uQ7RGFDUM1s6ZuK5ETVToX4fCl1Qke4Own+KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daWE8ddCKcaxMPWxphWRY4ad0CuKkoa2b09gQxz+PtdCXuIHEJU1frEbSPFnajAeyQ4qAz9Lsh0oYfDFgAhr82K25H5gsi1dG2o6bmYv1gLmFDkpL/saF+jTAc9KQ9DRB7FCYTDHyo3t6wklNTANGe6LdmgzlHnXYNpYKGZrAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BpWRg6P1; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-467ed334c40so226583137.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707514165; x=1708118965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6t7JxYzUYe1G5tyy354y/OPoxlWnEMIYfd55PcMEAnU=;
        b=BpWRg6P18ToACg3k4YIKAC8ob6Xh5nojHidMej/6K2tGU96Z4Co9W419h7WqbUT41S
         SIep4H/o5FrjZDDTIynhpJofng4/I8TvnvLv5Ax8WGulPTCzWRjPf4CKSBVta2WH2tjT
         jp3HG17JuE/ntcq5NwSux0Mmp9zgWybtUe7NvOeUkwUCV7Cp9z0fkRvssCh6IIn+X/CR
         QJoQiOq0EeRlvwjcVaGKCFK7TENof6mmMrl95UbuQ6OOKCvxSzkXZBj0QkTPlb9etus2
         1rp3rFJNOJclM1U9L1UOBNvEra4iFTWhANSsmpub3LyiY8UnlbeoOYiiRsWT2cNuNATG
         nG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707514165; x=1708118965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6t7JxYzUYe1G5tyy354y/OPoxlWnEMIYfd55PcMEAnU=;
        b=AKhBRVgNvMw8H1VvDtAfDPGbdyaVvPlPng35i9j8L+i1IAg9srs4FWzgeJBdj8SNxy
         sfR4VoAAwjNi3MsPkd3bRRVbaNY7bWTuk95f+hWCXC+JkFZRFddKYxCiE3zBmVbobPYe
         R+uZKrdeG2k9B4IplzXFO7md2I1bUgNylmVdwInKiJFgmgxVF7ZVyj9jhU5wlUr8Om3k
         Ap7aiRE1r/l1GPc0uyo0DNIhcfQBZAmOpusmoS0F9FqguzJGQJFMqp76NtzZO0/lkFN9
         7cG8OTlFFULAWe8bsLUX+t6wXgMu+pFVAodMQPUSc/L2iAYXrAYF2NlYPiQhsgxXEJOm
         3Zxw==
X-Forwarded-Encrypted: i=1; AJvYcCU/23fozLS6wlgdfU1MZRT9795lzZWvesmv7S66w0M2vVqbnAi59fjsjc4lW2P1eNDdvdoW73F5TOIkpF0c36AewVg2UCM5GVF7wit9
X-Gm-Message-State: AOJu0YzIDyxsmAkw41XXWvG66q83THCo+F8XrYJXDuZrmWfGxSVEMWhL
	u5ftpoREDNKGtKtZDbWMQ1vO21afmGSYsUbe3zVWDBsXEQK5Jyoj+AFvLTjt5AE=
X-Google-Smtp-Source: AGHT+IFhUodESDe8mt61qKpTTqFTzwMEjBVpz0ybXibJ7A3O5xt3dKTI0pK2CAdiM6pE73oilv1FeQ==
X-Received: by 2002:a05:6102:2322:b0:46d:210f:20fd with SMTP id b2-20020a056102232200b0046d210f20fdmr647367vsa.18.1707514165164;
        Fri, 09 Feb 2024 13:29:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaxdtMY0BJKPa7zdVAd0dpwWZsnh/A3jFMcCGpvSDsERIAP92g7x8mxj4PdyC9EGZhc7uOMmzJrGviP9cAdUHOKRAl2ZjHDak9gqUZZPhnNhhKS/vQkf+4aZ04cdI2T4CFWdUms/HkdFdyUAIfjK4DGQ3Rw+10EY5g2ibFA36ro2CS7Lb3fwmW5nMgCkEwcsHZatTcazhCV8UCfJ73bVVv8zZLNDD9xSY8n1X5dE85NASVc3tYomL0U1sxjP1noD4VjEbcC8muLk4xF6K60jv32xmgNh6nnlBbhGWOhIKlInTvMOXgJAszJhfrvwl9sMIWNxSvjTPvBGg4tuNdLERM0yVXJAEvDeZBIDajp9ksCZOwam59mbQSlKjnU7SbO5z8/yWAJJCBJUEfZmwyEHh/O95I73vWJ+DmZ4OZdWT29ia4G+ug7+rrj2MFjvEN86NBrZrpM+P+zLFfFpcAOdvQCKMLPsa8VrWkvK3XuIV+CEfCl5q9JIhHWRNKO8QaCcpYceZkZPRKFITIM8sS4SqIpON/MjL/VSbuGzjXTsl9tlYYxLrFohCg3scs2PyLea6J8gssBTqyEWhySQu25d2o00rsC+/TH6tQgAlCM2LRF9AQ7c8jRPTDx4lV5Q3zz5GRmqchWOFuT8ZGXnLCBkZNf6Ih6Z+xdq2fMeZAGNamfHbIqw8O5sBGljWxLSfXxPuGCT2W7c8P1NMgOa88EGRa
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id o35-20020a0561023fa300b0046af097562bsm49535vsv.9.2024.02.09.13.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:29:24 -0800 (PST)
Message-ID: <45f8b1a6-9611-41f5-9d50-6a74fcd2382a@linaro.org>
Date: Fri, 9 Feb 2024 22:29:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8976: Add MDSS nodes
Content-Language: en-US
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121194221.13513-1-a39.skl@gmail.com>
 <20240121194221.13513-5-a39.skl@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <20240121194221.13513-5-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.01.2024 20:41, Adam Skladowski wrote:
> Add MDSS nodes to support displays on MSM8976 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 268 +++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 118174cfd4d3..2d71ce34f00e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -785,10 +785,10 @@ gcc: clock-controller@1800000 {
>  
>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>  				 <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>;
> +				 <&mdss_dsi0_phy 1>,
> +				 <&mdss_dsi0_phy 0>,
> +				 <&mdss_dsi1_phy 1>,
> +				 <&mdss_dsi1_phy 0>;
>  			clock-names = "xo",
>  				      "xo_a",
>  				      "dsi0pll",
> @@ -808,6 +808,266 @@ tcsr: syscon@1937000 {
>  			reg = <0x01937000 0x30000>;
>  		};
>  
> +		mdss: display-subsystem@1a00000 {
> +			compatible = "qcom,mdss";
> +
> +			reg = <0x01a00000 0x1000>,
> +			      <0x01ab0000 0x3000>;
> +			reg-names = "mdss_phys", "vbif_phys";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>,
> +				  <&gcc GCC_MDSS_MDP_CLK>;

The last entry is misaligned

[...]

> +					port@0 {
> +						reg = <0>;

Please add a newline between properties and subnodes

And then the rest looks good, I think!

Konrad

