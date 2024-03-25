Return-Path: <linux-kernel+bounces-117809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF888AFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFE32467F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61A1C2AC;
	Mon, 25 Mar 2024 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zj7iGGjt"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C731B59A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394607; cv=none; b=leiH/mwMfcO77TsH4aaEV3RxJpwyG9NGSOIloDjHtqBnU531/0d2vJUjKzJJvKZHdJo6/CAr0D9DvLhwYC1xuDD8uJIsbk4ue2fRog8rNWl+1g98H21ITez2Ov9NBqV0Hh940ciiNiiOFImyp6mabAE3LYqUtcaX5mvhpG04PwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394607; c=relaxed/simple;
	bh=FjY4GYVXr3k8uuStxgi4b+AOUxwzWPNNLCmKPoWQjp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I9X2kwffK6Cbdqe0Bi3m9w0tn+A6S9o9MY2Ucfw8TPckhmAVg52pIWreRUa4U6j0BPc4Faqo5PuynjBnfSjB03v74XzrsozU09gINP42gls4udmHoqfmKuf4pvRNcgFMZFMdkJgM1SxeCZ70V6Av1XQmO/qx5iFXEDT16VWPjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zj7iGGjt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a474d26fb41so219049066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394603; x=1711999403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I2AtToWe7Efdj6aJ4/2uX4LyPVqOVDYs0OVfwHkOouk=;
        b=Zj7iGGjtc/8+nvsIBkYm/TZ9d8oNFmH5XPCDjDecbTfiDWjdJiCkMWvHRHphhcWG35
         LKZVMOfQZMj+I7uwDUXZ1ApH/mzBDIkyU6WJgXMT9IvOk8YiFwYfhA326i3oKoqQR6Uz
         lCevjdSgst6xRs8c1HUZW9f/tJcnYRg7hQGPTjVb8stkHf8N5TdqnJs7xgQBpEh/Coks
         /EYF4G/8tURAZQdOdPUz4YZrSgUukuXQDSOJ8pYCF3u9w4tdx7sB14saJ357EWt/q+Hg
         S+YfTJNUaoQsqRtIJbk0Xi8ONNe6pboDYtk1uehsq/dfLi8KdAo1B3N4UWFTkQmVMy+d
         wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394603; x=1711999403;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2AtToWe7Efdj6aJ4/2uX4LyPVqOVDYs0OVfwHkOouk=;
        b=LDI6A4mEbVMqWx904YsPfEbcA96HhAbRN3ZMw4DrqzhljNqiLrbQBin77CyBBmzXUi
         U5kblSkWazxaGdCx3eteOJIf0lHdDp8EX+Ewi8hONefKqi5VsJ1n/+GUOAx7ARmEt/vL
         zXujbcVsKBZoAXtjjnJqcHDBCuz2EQNDKZGZrYJc034h+gIQpzX0J/aqL06n24PAHJfA
         5N7cL1eBvZIV3teDSOGpq65hozP7VN/zS5vg3uZ3ERpUoKJI+RmBaNOez8S5hOHdYrMK
         wghJWBiW0INob+l5cj0unVAc38Nk28I503kPgoE8kbKuqHnpSh4RF/Uz+dcJFlr7bCXY
         tFyw==
X-Forwarded-Encrypted: i=1; AJvYcCUD4wlVP2vWjyxGTDZZX1KLROX5vnUn5+qV4EMhC7bdBIfNtK0iXOzj69HPsYmD5yqBYBfzi8HreULesFpI1h6exfN+tmfidKsk1FTW
X-Gm-Message-State: AOJu0YxylDYWO5Ar9iUMgB5Huk27iGIcKt4mlLyowc41qw+d+8RRJkgJ
	NGMnysBndGJp2bQZD1YWU1p0nLgcH/Puq3ZGFR7Cn5LHAfXPacwERnpBpvfobAM=
X-Google-Smtp-Source: AGHT+IFJk6SRM+6U3z7hDZmnH7BBwAQIbn/6FyxaLUpn9jAktkYp4Qj6rmfhKfQ1b+g/dKkhdtpYjw==
X-Received: by 2002:a17:907:1184:b0:a49:fa33:a413 with SMTP id uz4-20020a170907118400b00a49fa33a413mr3016087ejb.69.1711394603570;
        Mon, 25 Mar 2024 12:23:23 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170906f6ca00b00a457a55b814sm3357754ejb.73.2024.03.25.12.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:23:23 -0700 (PDT)
Message-ID: <531f7c92-9520-45f2-81b0-a45fa3f472fd@linaro.org>
Date: Mon, 25 Mar 2024 20:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdx75: add unit address to soc node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325102924.26820-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240325102924.26820-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.03.2024 11:29 AM, Krzysztof Kozlowski wrote:
> Soc node has ranges, thus it must have an unit address. This fixes W=1
> dtc warning:
> 
>   sdx75.dtsi:399.11-736.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

