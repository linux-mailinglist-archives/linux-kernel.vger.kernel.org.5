Return-Path: <linux-kernel+bounces-42336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F783FFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEC8B22C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC0537E8;
	Mon, 29 Jan 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8LAfgQv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687D52F6D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516126; cv=none; b=c5LT4xVVQOmhvxhOtS0AmeYzb01XiR34qruicpHR0X23ltegPGE+wt5awDzGOmIE4YjpKQmN4RNVYZE9YNfJZVDuBsj8FumXAIzutAYwySTppJKi6YTaDcg6GMAUr2eLaOET5lkzsGg3rvPdaAmznNUbpcNeqt+Jdn73gKdLWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516126; c=relaxed/simple;
	bh=bTMdAmM70iD8Skp4adPt1e6R4xGZ8keLZAYelVo6dXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKyiQBWYs96qnKcuDdhGeRJQwZK86ywDRAJQ5V9yascfYC84DWBgV4SNvN+ob6k6vUG+i1Bjbk38OFeTPYTj+PdKIK9v72Hiv67iDgorlc3RlkWbSz7p2SgxUfIbu9m3Ny0pY7f7n+j/cHMe4kMRVz4X2RHNM1Dn6+BZECTmFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8LAfgQv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55eedf5a284so994482a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706516123; x=1707120923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZ37FTpWtxd+apLpbc3f/ZbNZv8NUkS8211DEAp7JYE=;
        b=h8LAfgQvUC2rdUGfj1sBsgVZPAsuydP1MFnDvPdTACh8beSh/Al2Ky6BWAE/HZEOYc
         Gya4QhMjXVSuVz+kCxOkrEvt5uEaDTmesMnvuvC9FUcKHYX4plkt35RwwF9FxMx2YjoN
         76W5c6pFav6JyCIoP9/Pz5KjPBPgCvoxhmbfR79Cm0AX/X4IEC7dJwm79A+UunF3BXM+
         zy6pB17k7jEqlqi30vx1E3YJGgPDjn9D4Zd0CNhjM9+Cmi6BNQW45xsyAWSK4UACwJYR
         iVIvyq1QsSbTe0I2tvcR4zobHKBDJkM81FkgK4AmfYI6yh5jZS/oOJXsiG8va2ReWh2g
         HX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516123; x=1707120923;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ37FTpWtxd+apLpbc3f/ZbNZv8NUkS8211DEAp7JYE=;
        b=WSwnXf3bRPiF5C8DnAGus/sL5AZGurcAIoIWtHyWOolaQ1v/58reVFi56VOnXH+j8i
         MmSiSbEQwFBIhnlG7pYVGcJJnTxVO//A4P6hNsZf96k6Alep4tpF10zdcYR40+wR8pFv
         DKkBVGltFNKyI6NMNLrGWeRIA3Hv69ZoTtj3H4qtBuxzKtFAKvsZJKXMSGUcE9aIyvFo
         AjZL6LroRryz39H2H70qAZm9fQVXgCPfZN4C8/mSX/x22XyoB5cyHu5UszxbUs2TQI0Z
         nhM1l55Smnu9KNYHwgqNzmNEvt0kweJmmujMnNrF4EvHAhf4c+n9OCdTJeBNmtWdQaOo
         7vnA==
X-Gm-Message-State: AOJu0YyvLVNNeVrwoqmQ44DgbNSFh4YReuVKaU/Jep6nNSZqcwWhjFpq
	WI4Ss7dPeIYcCMDeG+hetY/Dvn63MIOkkQ9DFPQCmL3D2ZBsRGsI2jGLAgdh8Tk=
X-Google-Smtp-Source: AGHT+IGq6hM25x7JO+csRoGfY9SrHjUj9tVt/PgVdiJnW4tND8ArgaPwpwQ0gpAxBtDpMJDT0pPnGg==
X-Received: by 2002:a05:6402:35c4:b0:55d:20f2:11c9 with SMTP id z4-20020a05640235c400b0055d20f211c9mr3598720edc.25.1706516123326;
        Mon, 29 Jan 2024 00:15:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g15-20020a056402090f00b0055e230fe75esm2743763edz.91.2024.01.29.00.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 00:15:22 -0800 (PST)
Message-ID: <cc28fc0e-0ef0-4194-ab1e-fcd98a7be903@linaro.org>
Date: Mon, 29 Jan 2024 09:15:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] arm64: dts: qcom: sm8650: add hwkm support to
 ufs ice
Content-Language: en-US
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 andersson@kernel.org, ebiggers@google.com, neil.armstrong@linaro.org,
 srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 kernel@quicinc.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, quic_omprsing@quicinc.com,
 quic_nguyenb@quicinc.com, bartosz.golaszewski@linaro.org,
 konrad.dybcio@linaro.org, ulf.hansson@linaro.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, mani@kernel.org, davem@davemloft.net,
 herbert@gondor.apana.org.au
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-15-quic_gaurkash@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240127232436.2632187-15-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2024 00:14, Gaurav Kashyap wrote:
> The Inline Crypto Engine (ICE) for UFS/EMMC supports the
> Hardware Key Manager (HWKM) to securely manage storage
> keys. Enable using this hardware on sm8650.
> 
> This requires two changes:
> 1. Register size increase: HWKM is an additional piece of hardware
>    sitting alongside ICE, and extends the old ICE's register space.
> 2. Explicitly tell the ICE driver to use HWKM with ICE so that
>    wrapped keys are used in sm8650.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 2df77123a8c7..c27daf576af5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2524,7 +2524,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  		ice: crypto@1d88000 {
>  			compatible = "qcom,sm8650-inline-crypto-engine",
>  				     "qcom,inline-crypto-engine";
> -			reg = <0 0x01d88000 0 0x8000>;
> +			reg = <0 0x01d88000 0 0x10000>;
> +			qcom,ice-use-hwkm;

Vendor properties go to the end. Please consult DTS coding style.

Best regards,
Krzysztof


