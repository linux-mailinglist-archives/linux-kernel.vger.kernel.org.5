Return-Path: <linux-kernel+bounces-90115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57D86FA87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9838283119
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F4F13AD9;
	Mon,  4 Mar 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5QUBIbs"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B2BA2B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536347; cv=none; b=NL0UwhCt7aSx6SQgP6JAM74aUcGKcYM+YGQgTMkbuGpqYGI2vtxoBbk9asvAjrXPUQZsne5tfB5myerB/AxRHAWsV4oMHx3LqJs64Yrq0ayp9s7kzFiIeNdJJjeiWfec6N5FvPprxW2e6IFsJHoWeZmu+zT7Ndh+r8iv8/8xKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536347; c=relaxed/simple;
	bh=TtMszT60sJFiCKPawS7iBjv7Fz74IxMlNkB/u4C38Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCXMKajaZsIwh7aE7X9/saT1oAJOW3llH1KkG7M7UYcJg4bxZYbaqxkS+HQ1D03TemZuqFPXbM3n1crdXAOWE9m1yvYMWH7oWyiNE51Li0mAVUpnpFZCOQed2HWPSpzE7cV+VgFUMACnbO1OIwcEl6GRA+gKK8IpwNGLWkgE1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5QUBIbs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so1319580b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709536345; x=1710141145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDcki6wWn44JwR9ywq+CgLT/BHDzHDzpseujJ9jCJpo=;
        b=J5QUBIbsPGjkqYN55GvlFrmdvqCslluBTbSnJNmLcc/HE8+VCiHvUtjl4jrI4zfg//
         CKvCMB9f9qODaGh9Q9TB6XjRkgF3vHPE2bGFfzIZKx1+kXGu4wJWE+//ByxDSroWmFhj
         Mf/IQixkUmSlklnelnTwHI97pgYIpKSseGRbCIRCF11syrK33K5LZdNqcMTTlfLLPtvx
         j1o+cf8w2d1SUfTqUv7tmAw2+66JYlSuVltzI1N4wBX1y3PmaDcqwK8EZKdnufjZM+nD
         fNz5mIY9ZHHnWywEJUkJwwiBOZDFhLlvs4YdxsHPWZmWUxxC1nCvX5ZFvToEUM/yg3fZ
         ntOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709536345; x=1710141145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDcki6wWn44JwR9ywq+CgLT/BHDzHDzpseujJ9jCJpo=;
        b=fbq+mAgn+w6o/9k9LcnEYkstRY/wknmLpC12HCIzjiZmcVIlRHshl7GUbN2j7fdIAa
         hYxzVXgBFKl8CAM+xrzYCclgJBsR1q5s9Z6OdU5HvKE8t3ymGl2kDXYIAf905dX+3mtR
         xTvgl/CJxSWs8syr5WfPjIJ6IxyXZ3e+XvG80nziLE2OvdA7YAYvJA9POupQlb4A3ex+
         iWwMUW1PmTqm5GkVv0SpDoK3EYz2+fpzr0C4zNG7bdYE5cUFMHHIRePlmvQgxgKvD45P
         UBpyfVxssDJ6tGXpKHCF6WuCuF8VUL+fcSAfrJewVAI7e5q+JTJPOcNf0+PxEYjdLHeC
         pKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTFvKpVfWKYodOtX5bs/SSBXXVSzkKZBk+t/G5gT5il+99K817X6P51xslPe6HFK0rIXtBp6VzQzC50uiu+O7QrC4zZYOLjmsoF2Lw
X-Gm-Message-State: AOJu0YwO/iGOgV3V87EubM3jaanstzSuUj7s/YA8rKRYujwS8Nt3W7OL
	tngXPyHl0OqRqZJ4URN3MOsXCfxTa4608QZZM2EBwRoh+UmGHsHx/kRybGnndeA=
X-Google-Smtp-Source: AGHT+IGRGLtypkqvltDU7f+SWiJXwZCuN3YSRC97dF/QpzFqcFscjmL/DzIb/6HX7bsAuMTqJl3d7g==
X-Received: by 2002:a05:6a00:22d5:b0:6e4:c102:8065 with SMTP id f21-20020a056a0022d500b006e4c1028065mr11204883pfj.5.1709536344783;
        Sun, 03 Mar 2024 23:12:24 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a000bd700b006e04553a4c5sm6604551pfu.52.2024.03.03.23.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:12:24 -0800 (PST)
Date: Mon, 4 Mar 2024 12:42:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Message-ID: <20240304071222.cx3s37mphddk23bv@vireshk-i7>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
 <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>

On 28-02-24, 20:21, Kathiravan Thirumoorthy wrote:
> Like all other SoCs in IPQ5332 family, cpufreq for IPQ5321 is also
> determined by the eFuse, with the maximum limit of 1.1GHz. Add support
> for the same.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index ea05d9d67490..0a46b5d49d32 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -191,6 +191,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  	case QCOM_ID_IPQ5312:
>  	case QCOM_ID_IPQ5302:
>  	case QCOM_ID_IPQ5300:
> +	case QCOM_ID_IPQ5321:
>  	case QCOM_ID_IPQ9514:
>  	case QCOM_ID_IPQ9550:
>  	case QCOM_ID_IPQ9554:

Applied. Thanks.

-- 
viresh

