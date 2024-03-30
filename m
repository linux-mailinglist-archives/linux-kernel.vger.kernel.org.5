Return-Path: <linux-kernel+bounces-125612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6E8929A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7953C1C20C87
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1C79ED;
	Sat, 30 Mar 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeyEXKqN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A877FB;
	Sat, 30 Mar 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711782441; cv=none; b=uY9be6TA5YgBR1vdjV9O1UprbpD+Yt706tDSgMnZEqrN9gl3y1RrVvylv/b2KVZp7A2/2jJJzDQ9FMEoFRDMjF4yJ6W+AIHd20jHurL8RdT9H33kuOXSV04FO3242RMypGrl11L8meAuyP/rAjKGdWNsknmGpwmdoXXa1/lYsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711782441; c=relaxed/simple;
	bh=DfKe1GaAeO1jSPZfHRONUECzOmyixsLd6boX2xS42Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dYQyR/cLKPGvKbl3909fyViErfkt31yBbkJgAiU6SmEhe4juZwvvxObv6e7o2CF1dQVVnzJ1//CpsEJHw9ObgceKIJ8yCWWjW/N1s2jux9wvNn38vAfMcQltmUE2npd+xzfvisUfiPHEMRMaD4Uw3X4YNAMpm2CrEK2nnHgYYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeyEXKqN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a466fc8fcccso328923866b.1;
        Sat, 30 Mar 2024 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711782439; x=1712387239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nckLeDqGhSQaqNal+sJU1eNl+/6Kt+Tu4bK8s4J+tVs=;
        b=NeyEXKqNbpSZqQdkx4eXQV4GEHa4AHnO2H+mh49jerAkN7M+KiwdtDpoG4n4KpCklG
         uINAQQwVkwdvTp0kXkDW7paGgoyLe2UpDNBuYQ6YH76zkcnko6eawEPWCJoSne81tm/5
         i7UMcw+0/Qz2r5yQJ+9IkAPAYatW5MJh38Nz1TSQLpuQnHQ1YaKK8LjxVCcVzkMS8q0F
         SWlMx9d41xvUVPz+GbLTHNEAguQZH5mWwyqVoO1lS0n6qQeZqxvkXnWfuLwWxW22upBJ
         7IB8Aum8OkYjeLf9km2bMvQ2s1iPfoAaQAs8RXvmLHzPdodXUyINNojak/osw22EEmWE
         fj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711782439; x=1712387239;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nckLeDqGhSQaqNal+sJU1eNl+/6Kt+Tu4bK8s4J+tVs=;
        b=Yqrhxr4LH/MO/GFK4v/Xjuc2V941+s8C9pK1Fb4Xhfp/K4mn1hf+Hdp5LtfK0HL4Rh
         T4ueQFURX5BG4IxU2rkvKvbKDC3nNhoXaxbnsywiPud9QZNxx+0OTCUKUvPPCyXYiy80
         Uvzkefs+BqxM693D+CoHZI3Ksk1x2mc3ji/kM1v709zdlYsNu9fldLdqWYnf2OI36vGB
         XnsP7bNIbXggNrYz2ySKQ4nKU/KDZZ93IbUR5RHLMA96AnRo27D+x3DmKs7RDwelDe8h
         NBj2zFWMW0wMXB3wH1G3h9rDHl3j6C3MtFFbZbAKh++peaTXZvV2w1aOn+2nNR1RHlp9
         Lrww==
X-Forwarded-Encrypted: i=1; AJvYcCWYOjQ5RDdWXfYo/D1tyDLU2/mGy7zmwSHozSGrZDA3XSpDgD7MGzqEUp6sRztDiaXb0Hu+i0O35b1wqkVAAO/8Io3SWkANgUU3eUgfj36rDXi04sj9SURz07DP7LO3r6mcGaXS05a1k36G05J2XLG8ZUziqjvQ8z5quQv9SSZhU+6yesExdLs=
X-Gm-Message-State: AOJu0Yzxu8TiYNFtnKa27NoCR82yhDSwDr65KgRJOgWyAOyrtWVdHQvr
	w5xLaf087xxU/MVl/+zyqmn+YHESiO8OutoP9AB8QdqYfqYXTcVie+fxIR7x
X-Google-Smtp-Source: AGHT+IEZKo3sEI9j0pgyjhXR0Dis29fDjDPCuR8TI/LqmJF0b4bRohk7FKqThfOON2B2k1sCZwVTdg==
X-Received: by 2002:a17:906:57cc:b0:a4e:488d:aa90 with SMTP id u12-20020a17090657cc00b00a4e488daa90mr672540ejr.74.1711782438510;
        Sat, 30 Mar 2024 00:07:18 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906a00600b00a46d04b6117sm2789504ejy.64.2024.03.30.00.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 00:07:18 -0700 (PDT)
Message-ID: <7f28584c-0e9a-44bf-b0c1-7f7a2acfb847@gmail.com>
Date: Sat, 30 Mar 2024 08:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: pm6150: correct Type-C compatible
Content-Language: hu
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Danila Tikhonov <danila@jiaxyga.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328074544.5076-1-krzysztof.kozlowski@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <20240328074544.5076-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 28. 8:45 keltezéssel, Krzysztof Kozlowski írta:
> The first part of the compatible of Type-C node misses ending quote,
> thus we have one long compatible consisting of two compatible strings
> leading to dtbs_check warnings:
> 
>   sc7180-idp.dtb: usb-vbus-regulator@1100: compatible:0: 'qcom,pm6150-vbus-reg,\n qcom,pm8150b-vbus-reg' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
>   sc7180-idp.dtb: /soc@0/spmi@c440000/pmic@0/usb-vbus-regulator@1100: failed to match any schema with compatible: ['qcom,pm6150-vbus-reg,\n          qcom,pm8150b-vbus-reg']
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> index 11158c2bd524..b20a639cddf3 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> @@ -71,8 +71,8 @@ pm6150_vbus: usb-vbus-regulator@1100 {
>  		};
>  
>  		pm6150_typec: typec@1500 {
> -			compatible = "qcom,pm6150-typec,
> -				      qcom,pm8150b-typec";
> +			compatible = "qcom,pm6150-typec",
> +				     "qcom,pm8150b-typec";

The warning in the commit description is related to the
'usb-vbus-regulator@1100' node, whereas this fixes the compatible of a different
one.

Did you want to fix both?

Regards,
Gabor

