Return-Path: <linux-kernel+bounces-119953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472EA88CF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC92A321917
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D493312AAF6;
	Tue, 26 Mar 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPsQ/qsz"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAA1E884
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486118; cv=none; b=s+CcxG3wEcpT8Ro37PE3fIUufRTK5IHpWAXl5TyiwIghvKcLTswGY7sPa/ZlcDXrEfb0F8Jr/BQEmYNAdxsooxKk19PPUkjEmhjoHvTYKxSoZSUfasoxdbQ7cleaT0+nn2eyWZ+oHega2XyPKVoIsTvjOiON2PvJnUKDI+HtJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486118; c=relaxed/simple;
	bh=urJyeXZnDDwgM5949YY+/cyU9zg6bB0ky9ypE7HM3A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnusueZDNBpZGjrxDxDAvJHo6si3AaVnxebkv7RFeoOx3OJogQ5HilWEeZNH9RuGxrJ0zFRCn27sW7XkVRQXczZmJGIwr+WxJdfQQJvr7Z0ZH4SY94clxgknn2JHsFrrEzOFPH8c+bGKxmPSXTggJhqW57yzRRD+Vu2krfKoJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPsQ/qsz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44f2d894b7so737228366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711486115; x=1712090915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0x2T28eezAs91HOxMcg6JN1+2OrXJY88X4xpF1P2/yU=;
        b=yPsQ/qszUeAfCV6/I+6h005OBMJJ2lWKK7CuGGfk3ldJ6bkUabY3QPzQHxzEU8Qkld
         dgg+ZxjwHJ7fX9+hqpkGgNxSDQPvnu8JBQvC6OMES1MfXN4Ed/2mlFlRwCsDOpS0gHjz
         Pb1hgSa/cLZuqYpPesiwWGMeFGHngctSvq3sMCraDfQyzVhA24yUFghVQkYhSKPurZwH
         OYNO8/lJFVxPF8sr0KFUcwk+T1DKXZZqzNd/SgwSnXUyJ3snDUXvtZp28zOjVeqeoXQP
         T6ehKDBHAPm7SIrSTTZ5l8v8p2MW9p7C670wUp2NdU+YQsyP2hCsW6d7Ua3OvHg3sXKg
         NkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486115; x=1712090915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x2T28eezAs91HOxMcg6JN1+2OrXJY88X4xpF1P2/yU=;
        b=jfhW5BVLRcGPNBFz+oW45riuThaXqDswEwxh760CkutF3oLlVmHZeJEFD2/3ZsSjD/
         OrGKzZ2WK70fFETzcJumsYgp0wFTmhq7m8sRMl0BZga6XJZcVvFLzaDKTzIUIDY7hBMd
         qetjg7J2CxLWrwc31Z1zfEUtaPDGvXz+s6FMIdjLsf1IMxy/sSq16vasCMkJiHExxCgG
         mYGUQCMfj/H55jqiQAAygEytPW3vj3uax29f5i+pTWHGg/DXDNEkzwK4pI2JmwDH6YFR
         vUB1+UsGHy+QMjRpfE413uEAXdvTXSne50qlwN3LBDHPUczy7vf+qlzJ12ZFtPPxovLg
         Hx7g==
X-Forwarded-Encrypted: i=1; AJvYcCXza3LMVs+nGsW1vVNa9wbYKnrtWouBmQdwsKxboIixdvKmPhk8Bbjbl/BNb3f356wINct8u+gC+Wk8kGApqgwTSlvphKT3Xa3fgyx0
X-Gm-Message-State: AOJu0YwkH6LZ3S4JXQ9IwgR+nBoaxnFHCozEH1mnUv0tVTBG/QATUcMU
	jSBT7O4aleu8aSasX3Hgdn7sJoSbTrbil/bOyBQwy/tmrAWQHS7JtaxY03+UbEmqhUuRj9JAkSo
	Q
X-Google-Smtp-Source: AGHT+IGSv5Yd1/jmwEVatb4Euh9npBW0MkL+XeEkC4x4F7lQauM2Jnw/aFhCjV6UMels6T2jsjpcVA==
X-Received: by 2002:a17:906:eb0c:b0:a47:4ee6:9035 with SMTP id mb12-20020a170906eb0c00b00a474ee69035mr2583525ejb.29.1711486114654;
        Tue, 26 Mar 2024 13:48:34 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id qk6-20020a170906d9c600b00a466af74ef2sm4569474ejb.2.2024.03.26.13.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:48:34 -0700 (PDT)
Message-ID: <d0633ae2-7f95-4dac-9f36-73886bf2e8dd@linaro.org>
Date: Tue, 26 Mar 2024 21:48:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: fix PLL rate for IPQ5018
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326-fix-ipq5018-apss-pll-rate-v1-1-82ab31c9da7e@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240326-fix-ipq5018-apss-pll-rate-v1-1-82ab31c9da7e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 2:34 PM, Gabor Juhos wrote:
> According to ipq5018.dtsi, the maximum supported rate by the
> CPU is 1.008 GHz on the IPQ5018 platform, however the current
> configuration of the PLL results in 1.2 GHz rate.
> 
> Change the 'L' value in the PLL configuration to limit the
> rate to 1.008 GHz. The downstream kernel also uses the same
> value [1]. Also add a comment to indicate the desired
> frequency.
> 
> [1] https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c?ref_type=heads#L151
> 
> Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

