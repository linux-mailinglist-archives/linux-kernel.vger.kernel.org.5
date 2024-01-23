Return-Path: <linux-kernel+bounces-35863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732E839791
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26431F22045
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE581AD2;
	Tue, 23 Jan 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARVs8Xcl"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591181AA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034161; cv=none; b=Zoo3Fm2jnzfm0S4TEMqTWW3MZo3AL4rA7MyxS6AJ4cNRoy97MvODh0z/k9GQU2J4xfSgOf4KEhiSDdZSEnuubI2moX1602c0kA3i1kUMwsJZfXkYDsITcyOSJuhxqPJy2ISrorKDpOgJBHEoTUUgZQ5YA8FfqgV5J90BA2VYpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034161; c=relaxed/simple;
	bh=VeyyMoBVIKlMH0NcHNj60fMKyjSi0lWbBJa8NNMG8Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQWdsUQ7Xy1MHbDuXssHCrhvYmqpW/PZLjxkMBwv3GcinzpBXqjR77YqvwHKupTy9GaiDPYCj5Q2HhhipMg0GJ3CnGhmlJuBz5SKTYVInShcp8wOJq03BnBxtPHihYQ1jwHv3EuOQD5ziwwV8d5wb04brL8KcG/olFA/b/XiwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARVs8Xcl; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b978e5e240so1053816e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706034158; x=1706638958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Txtw4XL0y1j+c0lxWfVcA1Q/ie+rL6Vj9yfU8yVg4fE=;
        b=ARVs8Xcl30GeN+IjrEX3orHg/Bq0fiMPHU4xBdjcNYFYLuj1jF5aO7UPPaS3yKZ1p7
         2HMlT7Wu6zUwJGF1UJidlUzoQHIW5bc54kOd8QwZ24RD0WMaJUsB8+DQbY4K5Qcpbd3Y
         s1GL0V/vPzQvzAnNZHeC35QBLw5hVXarpUT3xom6k0E2j0bWrLh3wl28fjfin+AlTBWw
         MpSXc/Y1rRmyE3K62PY4Llxj01YvLaLI3bpZBdT+RTXKl4CNs1PVXqR1XKv9KIXVITpF
         nWlJ0yAU2tJ0MeJ4kYnjUiX36/+nXlop/s5+xGLcoNJERmllRQPWoy+zb5mYcYj5441Y
         zWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034158; x=1706638958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Txtw4XL0y1j+c0lxWfVcA1Q/ie+rL6Vj9yfU8yVg4fE=;
        b=XN1z1KL0Cm1JnmwMoMQPNcBZaDOHvpjl+oSSqej4iLJSB+WKxd2Fm6/O+r1O2jpVYb
         8CINPpqKGhJLONnnhsKviMnfSM9nvYF/iHvVVE2ud5OZrXi33fPrCCpEfNbiHJ38cXqm
         uZ8mm+BkXSiYzjWGAod+CYYPlBOm6+iAB1352Q3DeeywhzNF/kkiK+lWpPw4pe5U6K9b
         F027y6kj+syIuXS/3XCwtuyg8TdzDv6ag5ZzDerzGWSgDbinryt1uoR6La3LD/eb9qdc
         0M1vfWSwpusFQbFLPTWhIdYQ4vs0RQfrBjRE1NZ+KE283LDjYHDJsq6D+sS49Vd1T9oj
         GJwg==
X-Gm-Message-State: AOJu0YzF+Xgwaox2kMFjXHbxF/moF9Z8vkuXNgB3fFsMFQ+/wHalDFys
	YVFj9A0bBWvYA0C90VEwXAjsSLXLhbtOS6F5PAaAy9q6/3Tl6e0D2I+sfr5/00E=
X-Google-Smtp-Source: AGHT+IGxg1xctE52EPgHbz/k7cD69YdinPWJapWnvqXRGSxG2NzhyId4NpRhDgcvk6rb3tEMHa57kw==
X-Received: by 2002:a05:6122:1691:b0:4b7:30f4:4066 with SMTP id 17-20020a056122169100b004b730f44066mr3103168vkl.25.1706034158304;
        Tue, 23 Jan 2024 10:22:38 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 36-20020a9f22a7000000b007ce1febd008sm1658773uan.34.2024.01.23.10.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:22:38 -0800 (PST)
Message-ID: <e1313275-ca10-49be-ae68-ce783c3262b1@linaro.org>
Date: Tue, 23 Jan 2024 19:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] arm64: dts: qcom: x1e80100: Add ADSP/CDSP
 remoteproc nodes
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-4-072dc2f5c153@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-4-072dc2f5c153@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 12:01, Abel Vesa wrote:
> From: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Add ADSP and CDSP remoteproc nodes on X1E80100 platforms.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]

> +		remoteproc_cdsp: remoteproc@32300000 {
> +			compatible = "qcom,x1e80100-cdsp-pas";
> +			reg = <0 0x32300000 0 0x1400000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,

Is there no PDC mapping for this one?

Konrad

