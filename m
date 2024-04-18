Return-Path: <linux-kernel+bounces-150808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74968AA4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D94C285BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E4C199E86;
	Thu, 18 Apr 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDW3Zr56"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F8194C9C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475976; cv=none; b=HE9Y3YE+R/QKcY68GuG1wkFfyps1UUvLF/SajU6tbus5f4wI0gqlUWZHZN33yYtMs5Kwu9t2NIy6spCRfcJiHqiWmwWcTHGbh8OF+DkAtI2BjYWAzm0vzWIecOT9z7v1jOYqOl3tTivScEBsh7DBfkWJvGLAFsERenKJ1yd+Dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475976; c=relaxed/simple;
	bh=b0nygiwxmJlG1oQLrfl0aH+WNMxY74C2hSGxrXaRvM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+Pa2HNMSSxzV0eKEY/ZWZnTFjStHllM027VSyuGcLjL3vP9na+hmJ6iOyMUCZnNUw+wKtZ4p7g+CFGhlSqtUUdz9j2DU4VsmjW2QOBs8WfDHstp+3EByUe/jsusKEOuLk3B5K2zMmKHFB12h/Mwm7BwoEahoMWRN1XFste158M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GDW3Zr56; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51a70f6b3e3so132850e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713475973; x=1714080773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxbsd0dPflCO5RkYZb7eaAkraukyQtr37K8wnkzVq/g=;
        b=GDW3Zr56hR0qvXX7VeK9iLQGtftiEl3rO6Mi36kPIsdytpYwXVrNWADSuc4SGMmpFb
         vACoCxzzrvSd7cKDaC+wWoZHrLEYKdAya3dBqojvukWyv0dzvNapUE/+P3ZMr+VpS6UA
         dAsnDWtOdY1hnqd+QfBneHfoXToNT2fI67eenHWIsJ7OXLuk7QKaSpUcV0dPvAk3uKEj
         H/ThfXUnvi/evUG1ufwBg9Kb1iAp9yJrb5dgJz32yRW9Rwx2U8a5lto1ULnzPE9NaxZ1
         5wlIu5qosnBrJ5dzbDVZN5L6pl6H3tWnsc0ZJqZteijBH2e46aNPRS78fpbcmv67pggL
         BYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713475973; x=1714080773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxbsd0dPflCO5RkYZb7eaAkraukyQtr37K8wnkzVq/g=;
        b=rJt7z8Mh6MxU5i71CUFyNAsoVk6n/u0edQ4jcTvxl3NJb3eCIbctrrsIP2k/Ghjacu
         6QwthXW/qLwuXzHzwKWNNx8Cvqr79jRrvE8ExUxvpfSRbkVrdk3IcMCL8RljsOyFomGy
         ZnusJTEtubrG/KXzPPBCgfc1bLXwx4V8QdoSrKCLVPC3UEINU9vO/mRocQQkI408Zt+T
         gi84uj6VBcQAMAGcvKw0Po/QhRVTu+Z3Ej+3kSfz6dY/JXJVIpZssEqduy0SsQm0hUFk
         A5nOFMGIj6drh19KQ7jya7suROj99fUw2sdCwhGEerRcp8Bh/DTYexILVzjE99rtLwL9
         19gA==
X-Forwarded-Encrypted: i=1; AJvYcCXSA8xjfXJM13oFFb1HAYX0rnWVpOwVF26oozebljsJhtkcIlz/rVL8gR4g/CB+4ZmMQuQBbO02xx0vE70rRvSVIFbB7izE0KZosHyj
X-Gm-Message-State: AOJu0Yzt7eKyCG+VTug/2rMcrJzIGSk1PpcGgHNKDjhm7tB4AyhygHFk
	+6hVgP2kTizpMSlRMo7GcZFs9/40kC01o/I/LF1MYpH/Sz8ggjjV/6OFPkJBB04=
X-Google-Smtp-Source: AGHT+IEZbPT9ldV7zsLo45ecnfScIBljg/SXJxyGO/+cIGa/4wW5qtsy2dAtU7axHhrG1ZM3EmOCdw==
X-Received: by 2002:a19:6908:0:b0:515:d5e6:d48c with SMTP id e8-20020a196908000000b00515d5e6d48cmr148628lfc.0.1713475973140;
        Thu, 18 Apr 2024 14:32:53 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id h14-20020a0565123c8e00b0051789bfa1a2sm244260lfv.269.2024.04.18.14.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 14:32:52 -0700 (PDT)
Message-ID: <199eb351-12e7-4b30-9085-7aa4992658f1@linaro.org>
Date: Fri, 19 Apr 2024 00:32:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 4/6] dt-bindings: clock: qcom: Add SM8650 camera
 clock controller
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-5-quic_jkona@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240321092529.13362-5-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 11:25, Jagadeesh Kona wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8650 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/clock/qcom,sm8450-camcc.yaml     |   3 +
>   include/dt-bindings/clock/qcom,sm8650-camcc.h | 195 ++++++++++++++++++
>   2 files changed, 198 insertions(+)
>   create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index fa0e5b6b02b8..fcf6a50b6c01 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -8,6 +8,7 @@ title: Qualcomm Camera Clock & Reset Controller on SM8450
>   
>   maintainers:
>     - Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>   

After resolving the valid review comment from Johan, please feel free
to add my tag:

Acked-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

