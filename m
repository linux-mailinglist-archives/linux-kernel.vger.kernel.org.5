Return-Path: <linux-kernel+bounces-22036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11720829848
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373681C21CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92347765;
	Wed, 10 Jan 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNreywxf"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132241773
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd04078ebeso45366711fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704884640; x=1705489440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXHmqRSeaFg8TZchfw+nuRyCtYEND+76VtH1X1yLAvY=;
        b=xNreywxf3dxm8+EcrcSsKWsuE/BOQcVlDK6reNuuA5Hw76NIgTyB3ALNBCfKr9WqWe
         3AYzT5AFqZ/kz572rnnPdrLu0w9QN31VkXcFSQBFA4YDx6cAAeSWN5KbykbeOnSSPU4L
         Bca8vxPZ7MZtTuzdLVq64QDZzBG5bsI/YAOfUycttPcOloG7M+Qj+XzJP886rDetzb2L
         CzDba1BhDjXPcT8hMarZYfaimtsrje0awhYHgxg0+PvROxIgBxjXGqrwsFilIMlvCrkv
         gXwwlHV5pRSazhkniXR+bg4nyVSl18vxXHy+cFqaZOkmInYbqedNAygjOJs1CGX6PVwg
         lbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704884640; x=1705489440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXHmqRSeaFg8TZchfw+nuRyCtYEND+76VtH1X1yLAvY=;
        b=Reqcqui1lkab5OaWAqW2GLg0Pbh2zjegkBspj6I2c6iMUnxL6fPCYryZ3lmBIYhO1O
         ey8TmCp0FrEdbB/z83tLoMviXhcEGAFqdV12MwsmFj1l2z5VB6RjE5dvMN+xTvNlUdUM
         hR6cbcFOlEbGQc6Jd3lb2I3WAQjsQ1ny+SN8Mxrc9/6q90nq4mdsScclSp4W/gIVcA36
         5n/rvIfHPytaxB2jqoCMZJKjdswWwThm09XCZsfqZDOyhSx0W0paQg0oWB+867titouL
         perpXn/j9iyFXUTi1h7Lm/3opiLsQKBAT4w1A6e66aqvysc5WNbI01Y0mIAa/CnRdMv+
         y52A==
X-Gm-Message-State: AOJu0Yz61lk7Mf7qQrk8xWTIUVSFRgjZtIYUbJkuEjljFR5XKzjRjgZt
	1loNzRVLfMNENOPzS9/UMZ+Emlmaw6FKNg==
X-Google-Smtp-Source: AGHT+IH6OmxdmfVlAOe0AYJUerqGxRHghXPe27mBVgEhA09mTIiCk37D7aPkBP9yz+aTkH8NtBOdQw==
X-Received: by 2002:a05:651c:3cd:b0:2cc:f397:500f with SMTP id f13-20020a05651c03cd00b002ccf397500fmr529342ljp.25.1704884639962;
        Wed, 10 Jan 2024 03:03:59 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m7-20020a2ea587000000b002ccd2d688d8sm698861ljp.107.2024.01.10.03.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:03:59 -0800 (PST)
Message-ID: <927d1ca0-3915-4039-b855-b31ff5280cf7@linaro.org>
Date: Wed, 10 Jan 2024 12:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sc8280xp: camss: Add CAMSS block
 definition
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
 <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-4-b8e3a74a6e6a@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-4-b8e3a74a6e6a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 17:06, Bryan O'Donoghue wrote:
> Add CAMSS block definition for sc8280xp.
> 
> This drop contains definitions for the following components on sc8280xp:
> 
> VFE * 4
> VFE Lite * 4
> CSID * 4
> CSIPHY * 4
> 
> This dtsi definition has been developed and validated on a Lenovo X13s
> laptop.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 239 +++++++++++++++++++++++++++++++++
>   1 file changed, 239 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index f48dfa5e5f36..35bc31117b41 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3614,6 +3614,245 @@ cci3_i2c1: i2c-bus@1 {
>   			};
>   		};
>   
> +		camss: camss@ac5a000 {
> +			compatible = "qcom,sc8280xp-camss";
> +
> +			reg = <0 0x0ac5a000 0 0x2000>,
> +			      <0 0x0ac5c000 0 0x2000>,
> +			      <0 0x0ac65000 0 0x2000>,
> +			      <0 0x0ac67000 0 0x2000>,
> +			      <0 0x0acaf000 0 0x4000>,
> +			      <0 0x0acb3000 0 0x1000>,
> +			      <0 0x0acb6000 0 0x4000>,
> +			      <0 0x0acba000 0 0x1000>,
> +			      <0 0x0acbd000 0 0x4000>,
> +			      <0 0x0acc1000 0 0x1000>,
> +			      <0 0x0acc4000 0 0x4000>,
> +			      <0 0x0acc8000 0 0x1000>,
> +			      <0 0x0accb000 0 0x4000>,
> +			      <0 0x0accf000 0 0x1000>,
> +			      <0 0x0acd2000 0 0x4000>,
> +			      <0 0x0acd6000 0 0x1000>,
> +			      <0 0x0acd9000 0 0x4000>,
> +			      <0 0x0acdd000 0 0x1000>,
> +			      <0 0x0ace0000 0 0x4000>,
> +			      <0 0x0ace4000 0 0x1000>;
> +
> +			reg-names = "csiphy2",
The random newlines kill consistency with everything else

Konrad

