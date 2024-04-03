Return-Path: <linux-kernel+bounces-129140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D09528965B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F27B239CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB225C90F;
	Wed,  3 Apr 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUBtL0di"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5154906
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128306; cv=none; b=kLrpJxFYWvD+ruuv6Z1kZKDd+x7P4AYJaP2JYkxVynJtk0J2JA9o9N41AQz2YBn2VOt5gBsMjS+tisoosovMaRuxBa/2+ipKZn7IjfAXt3czKYFgpJ8SQWDuyrH1Z+XPaFhAPBBvyJQgyKaDbaDhwlaRbjbSj+POgVk0SjZGT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128306; c=relaxed/simple;
	bh=yW1wMSjwUT6UBDzAMQBeDv1XjsKC2CWDXtg1QVTtX9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuqSEC3FqchGaAJK0msGrmdKTgQBMJyVlrMBKSyUGW8/5YMecTax8nLFArX4h7D4Vhi0XMZhO531JDMZOZpkRMeKHy/OhvAm+rOfvugBV9Abjx+klIt5LyPsB4+SMoO3JdePhie79X2ksBP1tH1OjjZSudC6u8GOV3P/Jvg2UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUBtL0di; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56dc9955091so3287547a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712128303; x=1712733103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eSl+u8dEasrOIaRrdpO4QMlXyyio20Nz1bnAXO9MgKs=;
        b=UUBtL0di3T8Hatb3q9GqhTUhRosomZP4NJOqsoBrIe0js6tAAuOCN6ExGvShQ3XdU+
         YHq32z1LjFSm148QEH5SHrQhL8OjdidZicKsGFVQQX8R1UnQVs743eIbFMHlALnqUbhk
         UrMniabIcCCHW/uWZI03dPSBg3OsGg+OyChHNZGAdU/23Mx0VrxCsFGTHBm9C88p/I/Z
         SOOHCuOfNMAoVfgCvP+xGFmPmhSkQulpm+HdKGXcDA9oUo9qGn7YV8ILfSyy2PJItue9
         SidN7nF7WrX0bgtjXFwnQ6w00E0rmu0vrDhwqbyMDLuuFK+Qjk8syign6THOYs1aOEd2
         4Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128303; x=1712733103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSl+u8dEasrOIaRrdpO4QMlXyyio20Nz1bnAXO9MgKs=;
        b=Cqq7n8GBF6mLGOvI+UgbYMqqFlkcbjni7cM/KMMp+wW4WrmyZai7d15nL/bWYgRQum
         WeQCQNscil/wZdykr+MYk+3TsOSJNnxNjSfZH1ZNMTnpzKyJuYsFoFXuxMvSWiqTVfqC
         kCVvIiq7FtwYvDgTwVb4b3Ravcr3AinEtrh5jZpAHsVY63Bf93+eKHBnArzCuHN7AeEj
         gNYMoIlsOmgowA+SesO/bthGFLbTSITK4CRXNcuxfrfRVD0U9C5vdOyXwFmv5G620xGu
         x6ol+PDkDxL0Zv1mmhN8k1jskK/1YT+wZioKvAQAXPW4DXp57ufEKk2n24Hri+aRra/t
         8FGA==
X-Forwarded-Encrypted: i=1; AJvYcCWikmzGb6rgstv6qe2eHrV83MX0JwVmhhj0EkVHgD/HD8tgwhFHRkXhJywxTckvfygdAUumIZ0Bw3GYEHtMqxZOpsp8209dKKqjuY2c
X-Gm-Message-State: AOJu0YyeO1AXPwMxXnXY0rDJBDBokUbCCuA5CsZl62HnkuHRMF9mKhbL
	lQ65wQmYkgZ5mRy2DVoio8U0XPyq4UeSB+6sdoKxryMh82Tcz+cr3sw/fUOKoKE=
X-Google-Smtp-Source: AGHT+IHINt9VbsM5Bdmm5hPgJahtIS6eDrQGtiFIizXfFgzKaaXBKCjNATBlGoL/86nefaycQW4euA==
X-Received: by 2002:a17:906:7f99:b0:a4d:f1b4:6235 with SMTP id f25-20020a1709067f9900b00a4df1b46235mr10034311ejr.27.1712128303130;
        Wed, 03 Apr 2024 00:11:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906339200b00a4df78425dbsm7348184eja.36.2024.04.03.00.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:11:42 -0700 (PDT)
Message-ID: <d9058f73-a229-45c1-8478-88b7f36745e0@linaro.org>
Date: Wed, 3 Apr 2024 09:11:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ansuelsmth@gmail.com, robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-7-mr.nuke.me@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240402192555.1955204-7-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 21:25, Alexandru Gagniuc wrote:
> On ipq9574, there are 4 PCIe controllers. Describe the pcie2 node, and
> its PHY in devicetree.
> 
> Only pcie2 is described, because only hardware using that controller
> was available for testing.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 93 ++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..626d6359d750 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <0>,
> +				 <&pcie2_qmp_phy>,
>  				 <0>,
>  				 <0>;
>  			#clock-cells = <1>;
> @@ -745,6 +745,97 @@ frame@b128000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		pcie2_qmp_phy: phy@8c000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0x0008c000 0x14f4>;
> +
> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> +				 <&gcc GCC_PCIE2_AHB_CLK>,
> +				 <&gcc GCC_PCIE2_PIPE_CLK>,
> +				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
> +				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe",
> +				      "anoc",
> +				      "snoc";
> +
> +			clock-output-names = "pcie_phy2_pipe_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +
> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +			status = "disabled";
> +		};
> +
> +		pcie2: pcie@20000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg = <0x20000000 0xf1d>,
> +			      <0x20000f20 0xa8>,
> +			      <0x20001000 0x1000>,
> +			      <0x00088000 0x4000>,
> +			      <0x20100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";

Put ranges here.


Best regards,
Krzysztof


