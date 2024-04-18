Return-Path: <linux-kernel+bounces-149903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499C8A979A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F336C1F218E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC415B968;
	Thu, 18 Apr 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em9goE19"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859ED15AD9B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436873; cv=none; b=RYdS9q33ikXiGCCIULQdfIm16zR+2P1MyqGc3f/7E20nRAUowtPbasat4MTOVAvMuAMLlhvmbmFaXFlwAi33JovMCoHeb1VT7/lCyGEfur/rFFWPNfwaDH9Je4NMF5/37TLjZhCpUyUzwsky3YgsMNSdWu1C0Lf0rkuYmB9SvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436873; c=relaxed/simple;
	bh=5MJVQNnAltPPYqR5fyLaSzpKAs8uzJVa87qLnasz6V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmDdzhZIeYoMZxOvG/jrtntz9rlvRaRAX4DtYlho+aiQJ5UYEmzLqcpYCjb7slfPJPIYOwldD9lw5ArMsKRVMOEBNhT4K6n0Tm9Uw2lnZ5dWvjWXvEJEReUiAdoxU0NtSWYupZYEAqbyVtOfjOIhKvL3zxPd4ijaI28B8+SRk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em9goE19; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a555b203587so69989066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713436870; x=1714041670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JpEL1BhH93BClNIFFrPrHPyrE8+P1tWWO3Nmmetb4EM=;
        b=Em9goE19qb89MzWqTsGULgIKqT+JdERk22AwaCX4lreNaPuYqy7QuDxxDhypIHwKLA
         3XRdFeBz0p0/m/4fSgO+dD9bRiQ1+IPMerUVeoqybLCFC45lHjgtJ4DQuAO+1q9I/HIW
         xzqL2nqwliyd0bOgiFoLbFdb+stHJkrOkjiQrlev8Y2iNjbB/C+hmOfZ2ZL3yio32Q6J
         pX9bYo87H1zjlkdNNYCpe1lNZybMXo3dEt59NdAfAfDhL9vu9sDTmeJNBi7foneieHpu
         /Z6RwWSFG3Id23H6H/oVvbv698RZ6VIYVRprENegu13CogMqNocDKkwWNS4wm1Z4GwsP
         Wjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713436870; x=1714041670;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpEL1BhH93BClNIFFrPrHPyrE8+P1tWWO3Nmmetb4EM=;
        b=ErahTZhyqKIlytcPDAUqKuRPOcPiL5XVMzLe3HvipcrkTxtO1VnxGG1EnuZcNcGLzH
         1BuEgzNSDwANFNoXRy1sFZxCS90+DNiR5RvEgfws1pmwKoA27CLsbEsFZbyG3qgwR4CM
         ZKkuy0s+gu+d47+i/WV9SLjrA91Q/1t1g6nS2XD1XfEiF/5QqxPL/wbP5khnspFvm3L3
         +TksnQSbHVCHk0EZi8pVhdATCH+hAoeiFD5dzTnfK6yeIVyFMyoGlRjD8ebPBT0jTkMF
         oVpccvrywZt3w7XccU3EvtA4wify88ArbJHV7CF70n1/KI0aGupee9qowCugS3QGeLyV
         fYhA==
X-Forwarded-Encrypted: i=1; AJvYcCU3LsJddmb6fxbwc/JslBWeEcOg/RwM21o9os7UQoYUoP5pDy2p4oRW0zSYvw3RAcWbSeQKurm3jdAR5MRb6iddLIo+H6RK+KGTkrMb
X-Gm-Message-State: AOJu0YxM3xmmA36bGWqk0e2VBH+alqQHvS2S6swFTrDNyoAB+FbEXcX3
	rjE8LUC2YaQyMIs1N0/FOrAmSLEjAzgq+xjPmn0ZOT8KLup/1r7wotCPQeKwGz0=
X-Google-Smtp-Source: AGHT+IGP8wIbtJpzHlE1x37VglufZhBU+bgRMQJEShZuRY/hV07VpN1vJRjHdubUU+DzjU2mONQwbQ==
X-Received: by 2002:a17:906:2418:b0:a55:61cc:7337 with SMTP id z24-20020a170906241800b00a5561cc7337mr1787730eja.43.1713436869811;
        Thu, 18 Apr 2024 03:41:09 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id gu6-20020a170906f28600b00a4e44f724e8sm708558ejb.186.2024.04.18.03.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 03:41:08 -0700 (PDT)
Message-ID: <fdc820f5-f7e3-43ab-8077-b5fc55035052@linaro.org>
Date: Thu, 18 Apr 2024 12:41:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100: Drop the link-frequencies
 from mdss_dp3_in
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rajendra Nayak
 <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240418-x1e80100-dts-fix-mdss-dp3-v1-0-9f8420e395d4@linaro.org>
 <20240418-x1e80100-dts-fix-mdss-dp3-v1-1-9f8420e395d4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240418-x1e80100-dts-fix-mdss-dp3-v1-1-9f8420e395d4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2024 12:22 PM, Abel Vesa wrote:
> The link-frequences belong in mdss_dp3_out. Display is broken because of
> this. Drop them from mdss_dp3_in.
> 
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index f5a3b39ae70e..0642b5e88639 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4096,7 +4096,6 @@ port@0 {
>  						mdss_dp3_in: endpoint {
>  							remote-endpoint = <&mdss_intf5_out>;
>  
> -							link-frequencies = /bits/ 64 <8100000000>;

Could you also remove the stray blank line above?

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

