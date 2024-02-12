Return-Path: <linux-kernel+bounces-61699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4385157E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF39B285E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185B3B191;
	Mon, 12 Feb 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnS2Bpkk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752D3B189
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744796; cv=none; b=mL5ldGmtliq42zZJAMnXKNeojdicZtZPy1fAmp0y82+HE9CorlSWHMOscq5WE2ri9IBKx432zjImd/V6FnO8bMFv1bmiTp2XTcheDWVhbUjdWd3+Rt+WGQUjqLx1ZAm74pFeZaQhhsFz+TIrslRuNuh/TNsiyP9+/vbKZPH3aFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744796; c=relaxed/simple;
	bh=CHeDkbS84QCjf0RypUKMIayqdgs04cSEZaM+mqI7P6o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUBoS1R3WTU8fP3roKTFmqN4Eg6ADF250PYZJ3CDgw5c05Af4d+5FUjseHbkYOItuDw92kD4wzDjipLhKny/yFPgIYbFaSG1KISYNqui5fLmL10OtEfrOV3//+Z3BiNvpjAWqzZvZnFjwORFPhw82FoWLT61HM3KJ1liXbOankk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnS2Bpkk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41102f140b4so3299725e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744792; x=1708349592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5HiYFS7Fie3ZVA9jhxns8zucVahNQ/OMoleXMPcDlk=;
        b=GnS2BpkkqCEjWLEjkWYSJMLs8GU4uUTyeQPU0NExsl3/haVcbopHxh07slYNw5ZKds
         AeROxHGs0iqTbb7ivTcTuo5Nr84+7sfW6vB1L5C89+/cT1rcCbj76tu1Ft0MHi9C0kfQ
         qZ/gijvZyceMdYUiZnM9bFMenHYF4EFUS/G/BSpy60P/pZjiL4yUrZaiacRRu9NtrgOV
         519IQjJ/2IgqcsueOi3X8HrGttXN4xtE+aXQ9f8u1Rj9kCmiJxj3+AwX/racjy6pMWdA
         KG66qaQECis9q0EZPbn377aXO4AAv9//7b2UGgNt34c2lUgMHr+YRVVueBPiWcLORXzL
         jcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744792; x=1708349592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5HiYFS7Fie3ZVA9jhxns8zucVahNQ/OMoleXMPcDlk=;
        b=cHvT/xODMaohGITV4/60DOz2eIfMyAyJnDJJ+SUkUjWE0Stu8gD8bHarMpef+8a8nm
         fxz/9BqxYWPFOOCDjmzTYnCJy55TfYs5wB/iJ+L03nsXITegQ241X8vS0dJ2EhExMJQ7
         uSUmD7TiVaF5BhJlh7U3EECSN7KxF8D9o9S95ZDBBgNGfOb2DhMAreYN++7GM8ZB2ejs
         nwX1NBop0muyNXV/xkSsE6+ogaaSFVo2eQrGTzS/9cq9phVrgF0xQoDhpL6VXdbqSD3r
         sP/fmxIcuSvLbUIv1IeM+ms3lR+zZR5kEzcuxxeo3UrkFGuyYx4zDM1EFy3WW7wtw+/W
         ypgQ==
X-Gm-Message-State: AOJu0YxLYtuGOVONLG4h05ZIT/ChuK20YO0VyzQ90p+RCxuxTYOQXR+H
	2rWzH6H+F5v/TIdaTFnrafxvNUQfMVAq9JZXIREe8VHiARUopf/LobWw4bpGUis=
X-Google-Smtp-Source: AGHT+IFYGprEV+d3HErwdfFC+XsS1hAk+2VcTVikqmf7dkgqRpqzbuTqmS04BGjfOp/aCycFL4/rSw==
X-Received: by 2002:a05:600c:16c9:b0:40e:f154:752 with SMTP id l9-20020a05600c16c900b0040ef1540752mr5624818wmn.20.1707744792312;
        Mon, 12 Feb 2024 05:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBDnbJcJOZ6hIKEZs01LtAKrab+vPQvJNU4Y6ATcknkRokAP2xxQDPT3pkxpFaGNzBU8XT7uAo0cCtmNnqTkM8HX5PNH3wVVEXzT+2Tnc8Ii6zmctvBQJOfjqD/CSJCuc16821W2NnoS/v5jkzCS7v0I/3WBOZRSgVykNBLNVzv53Jz+uzLJk9ro+vivCVPaZP1As8VfO6EmCI4PMsuX7WF+DbZUAuNUleb9pnohSOaY87uJwuJXZfh31zQHmrrs8KCBrkV4RQEBoXkFMNB3sfbd6IhktPfEezyiO89GDJA+8pgT/l62PcRl24MrY3h0Zr4+0KkSSruUowNyk9F2rFSQf0UZR+pHdz4tCLb17s3NA0qWPfLSFkN6uuCBArMzpeqMcwaw+zLIHyPwVuVTqp4aXGU312aw6P7nZqd11CRwUpF9A4pEKnoDWpyFsOc+SDLeVGT/MUqH/jwWVPWJtaNykD/2PJK2qUGZdmxMcVijs1CIWeh65TLGK+0u/YAuAirqQd2TOmrkmKgDaKMR49q4+UYOEvvvnVa/0LjKbxBjFOvhoRpca0zrvsJ+whO0nDwdy0LsQ5Ik+W2nKySdAMU0WNxwGNpZp3sEjwtqYNnr8Un1x9VgmnzJqYeCTC9vi73xp1NPJXN6aws1abbxBZRMmOQvAcjdMgGd4qY6dyECmSii5BnPCJfipvujhi7oRtCFOeF/wteBn2VBVUJ2UiZof18KYDjcTAZOAUqCmYxBZzG8iBD5fMtLSKK2D4kvy3dOJbQoMihh7BS2MgCuw3z4pggLWU741nppW18j9YCuTr6XC9aQiLUA==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0033b2276e71csm6843987wrq.62.2024.02.12.05.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:33:11 -0800 (PST)
Message-ID: <36869f81-fa1e-4938-a664-d8ce9afb63c6@linaro.org>
Date: Mon, 12 Feb 2024 14:33:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sm8550: Mark QUPs and GPI
 dma-coherent
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
 <20240210-topic-1v-v1-3-fda0db38e29b@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240210-topic-1v-v1-3-fda0db38e29b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:10, Konrad Dybcio wrote:
> These peripherals are DMA-coherent on 8550. Mark them as such.
> 
> Interestingly enough, the I2C master hubs are not.

Yeah they are not DMA capable at all

> 
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index b8f1c7f97e48..d696ec6c6850 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -812,6 +812,7 @@ gpi_dma2: dma-controller@800000 {
>   			dma-channels = <12>;
>   			dma-channel-mask = <0x3e>;
>   			iommus = <&apps_smmu 0x436 0>;
> +			dma-coherent;
>   			status = "disabled";
>   		};
>   
> @@ -823,6 +824,7 @@ qupv3_id_1: geniqup@8c0000 {
>   			clocks = <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
>   				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
>   			iommus = <&apps_smmu 0x423 0>;
> +			dma-coherent;
>   			#address-cells = <2>;
>   			#size-cells = <2>;
>   			status = "disabled";
> @@ -1322,6 +1324,7 @@ gpi_dma1: dma-controller@a00000 {
>   			dma-channels = <12>;
>   			dma-channel-mask = <0x1e>;
>   			iommus = <&apps_smmu 0xb6 0>;
> +			dma-coherent;
>   			status = "disabled";
>   		};
>   
> @@ -1335,6 +1338,7 @@ qupv3_id_0: geniqup@ac0000 {
>   			iommus = <&apps_smmu 0xa3 0>;
>   			interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>;
>   			interconnect-names = "qup-core";
> +			dma-coherent;
>   			#address-cells = <2>;
>   			#size-cells = <2>;
>   			status = "disabled";
>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


