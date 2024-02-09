Return-Path: <linux-kernel+bounces-60023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A786684FEAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328E01F23064
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7F335D8;
	Fri,  9 Feb 2024 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBA5/R5v"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023AE2836D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513478; cv=none; b=MeNPk6WS0xO0uZkz69SGSi3fXkg5ijjmr+R3edhbKqRoSBLtJjpA6mIkBIWwl+hZG4r+xmgqQhGIobf9eLEbmUioZrWT7VAJyDoC8X5v2NM5uttn7Xgi3IUMx2i7KidazYxR6hAubzSDslOKyy7bBJKrP7rQrNIyJdUE/r3wXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513478; c=relaxed/simple;
	bh=k+q8GVcm37M2DOBHfFk5ukpkWH4xwPFh21oXz/kS0S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcJKbLGFEdKry8UCXmtEgjlSW0l47WhxTlVe0pn6c/xvS6Y40tSQvqQ4dMKFc/o87sxa2WDcWZV/yHbPUqjxVvw0OJgTzHVw4yk9DDkmI3eaFxESuk8E+ppLzrXJsCClytlNYES9R8nf1h2Hp4EsqJ3J9l5PXqoQTFpu6+utuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vBA5/R5v; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a36126ee41eso185423266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513475; x=1708118275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVoSokiaKGaUYmnPXQyscywpomvYxKVzbMKo32GAWvs=;
        b=vBA5/R5vRVqTPJBQcpsikJ1i9XyIOGcEbiLwQFhc3kzI+Rn4OoO7Ew36k9sZ625UNg
         pg5pNU6WStniZX7qW4HGcJXWotQS3OCfUhMuSN7bZPdK1d+HAgwu8AyEY38fQi6w5h27
         DFTlWVtHPenFuCdZPDwQWVdli/28Mc0vIyg9QXH1eIllvtdd1z9Lw5xAEAnSt3wxq3TS
         /xmPF3nUejjlURa0V924xfonXoasGkvv99Esn3M/FinDWAemtJwSKhXCgDk+nlNTSaGJ
         j1hEzsYHHggCj95+ti5yuw2MzgVcPPiCi5akMlYhbsNTWvPuoqB+DQzQ5+HKwq3TFPRg
         LpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513475; x=1708118275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVoSokiaKGaUYmnPXQyscywpomvYxKVzbMKo32GAWvs=;
        b=K38HRdzSunNzM8pctqXEqx3QD1ZQFK507aXHYbQ57sbCLO9a/lpGxWyfPUZZV+wme0
         owkGNvJbRYIZU6VMIUx1/cuwk9tnoaW9u/cJQ1uphl0WTO+AmoqAQ6P/OkljhS2d/qQu
         BtmUCuGxI2Ls2KXOYe+ZjhBHlGOslTTHzVSrujJTTBTI5rRNJPnB1WsZmqUD4R+IpDNI
         dN+Ko7QL6Wiu+5xs1BauR6qIG2J9YatziurFg2Mt2nAnIslKoanZ22HbOINtlHXFEuvi
         EiCSrabHPG9JwGxZOJqHlwqDeu1urbanpEz7Z83xf4CD2Ac6sXb2KsAPATiNkvObliLY
         tygA==
X-Forwarded-Encrypted: i=1; AJvYcCWOLglWo97tgv9pQcCH9BiSpsUEtyTkCycvnMNHDfbObzn7dNYioME8HrwP1QgTECybzGqfeocDMGWKi1mX8gN4ap54ypI+n9cVcHVp
X-Gm-Message-State: AOJu0YzSSi5XHEjQgfQ7OzBdAgE2cBTGT4+/0Jg5t3A1pXeRrxcf5vVT
	GVRXtB5GrWjexegA0ssFepUV0DBvjGWhCnyYGpjF97DXwRFlTh0iwl7S8ZgOn34=
X-Google-Smtp-Source: AGHT+IFPHbebB0TCxBDxDR4N2achstR5pskoa23oRsBbFjLI5DrWhSZbEqMOFVS6xYiKv+0I7Y0q2A==
X-Received: by 2002:a17:906:7b87:b0:a38:a2f:c131 with SMTP id s7-20020a1709067b8700b00a380a2fc131mr192858ejo.43.1707513475257;
        Fri, 09 Feb 2024 13:17:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8SLIGRdPYwgzRHTmageyjpQrkavjkcpzurK4DCp0Qky210Dnq3OXvIoi84ZbLcaMqXMGlGaoUyV20QKFx3XipkXwFbnwEvKyBca1yFA0PLM2wHSdGXAhq/53yZy7czXjF1c2ZX7fje89K7/nKo+MV9QGaH7cpT9WBmfR0+5CMeQ7ec12Z1Xr6xmwp2pgdgRTDizRRXqV6TS6/87dtefQIPUkG+WIXqc9ExnfU5LLFLz85PNWAU1fG9MEn8gou6K/WwAJNzbRFLBmLEXCndysvxJcd/SxYxlLMJ8tKI9u9hCFlAOJikiSQVV7ZLMxg3DsZx6bNekhCkcQ=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id re12-20020a170906d8cc00b00a3895de6d53sm1125971ejb.140.2024.02.09.13.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:17:54 -0800 (PST)
Message-ID: <b60c69e5-69e9-46d2-ab23-52b12cfdd203@linaro.org>
Date: Fri, 9 Feb 2024 22:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: aim300: Enable PCIe0 for WLAN
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, andersson@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_mrana@quicinc.com
References: <1706257348-638-1-git-send-email-quic_qianyu@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1706257348-638-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.01.2024 09:22, Qiang Yu wrote:
> WLAN is connected to PCIe0 on aim300 board. Hence, enable PCIe0 to let
> WLAN work.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
> This change is tested and rebased on https://lore.kernel.org/linux-arm-msm/20240119100621.11788-7-quic_tengfan@quicinc.com/
> 
>  arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> index 20a3c97..d42cfac 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> @@ -251,7 +251,7 @@
>  
>  &gcc {
>  	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
> -		 <0>,
> +		 <&pcie0_phy>,
>  		 <&pcie1_phy>,
>  		 <0>,
>  		 <&ufs_mem_phy 0>,
> @@ -349,6 +349,23 @@
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;

property-n
property-names

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

