Return-Path: <linux-kernel+bounces-112123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDC8875F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608881C20EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA66625;
	Sat, 23 Mar 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3oW9gJi"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369E63D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152699; cv=none; b=dheOB38UFE/z72OfNX/XK1+hQnuQdH73+Q/ToTfwJ6S84pPYULTBY01+5xPWA3mPjf4aww4KWaiiMtRddSBB7x1TnJrU5AjajZmj55CgTxluALPwfjG9NIjYiMiETbYQQmUFefXHL1TdSKU/ttOsSQzH9s6lcmIDA+tRQsQDFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152699; c=relaxed/simple;
	bh=P/EP+P6BnH9TyUaUed9aOUzEfM5ZQWRlxn2Pg6ia2PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uToC+29tRkZszrHzerSGH5OJtwzYpwaUHfXUSoz+dLILtYajXYtY1NV788FRQ3MXi4PaVYvXI1hISlbIum1UTArUM0vi/VZ7qlMU8MoO7kQI/AG0lgVZMF9o2kXypMLVeEs+q+9tWc4i/+gxGiif/Gz6uQ3Pp5bSie/zXYzx2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H3oW9gJi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5148ea935b8so3049184e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711152695; x=1711757495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3MCFSvMO/tlYKEIBdXDWMBZUwgIizoQXcUu+EHJkdE=;
        b=H3oW9gJi0BtcFA5C8+buZiXV1xpIgH2zLlCZ1mb7+poN6srbvB7b/kW5OdV8pC08MT
         SCkB1Iuowpf/8HClZicSLLzBF8d1UEFjJQqdPwQ61ne4Ex5p+CniK1qAwf3w7TXbC+5c
         XT8KHYD8zPtIgcxEvhSX7aCmHtg32fWv9LTPJE8BObbr/naa0RVCijgmnqMGOAS0EaYL
         SZPcA0ejWjU6/zOaK1ShEF/z1O+8butI+9yoMOrAxUjBEHYGzJuyyChBv02uV8Q+L26F
         TnQbEOuAb3ZXs2GNzBwLgJCTvIch5Tq8ncbVGeSkmjsJyM07ktq7NhsThkbITvb01ljT
         wKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152695; x=1711757495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3MCFSvMO/tlYKEIBdXDWMBZUwgIizoQXcUu+EHJkdE=;
        b=Wwh2do0vga4s7yu7nvPTyA0JVclyPw901setPuZzlBblWs3IF+Znr5uJA7tuuKWih5
         g59w+u6qxdJwv93u+WilZiLTf/lcppdpDn4MKrKEsiZEc4VUiFxvVeT6i9ubcD2Uq2lC
         cqfwUjFNsNtqCoK+L57mxGwuiZ+uCI0om+5vBH0jXi4xgjH0Txa9yEqdNSZuydbtHk4C
         KL0BRnNlyZBhAvriUpcNDoqcBPKtajgvrHmGsqpd3GmOdvqzGLB6tgPa480bJw7UU6e0
         iVaw+O6irI3FiXWvGGvVOgjaKt249R3DNLmAs1gfFzRDVfGNtxFNPnqMVv5577gKTz2b
         h/UA==
X-Forwarded-Encrypted: i=1; AJvYcCU29K7kDoVpe0/7x28vN+zh8sEOBg1t10QsPyZeRFc59Y3WMbOKX9XPIGWm0rTT1l2n3V8dRgHr0yS2DR/nwNKBEoiCRU7BGM4jWPcu
X-Gm-Message-State: AOJu0Yz9NuJfPC16e/oMTNwCrlbEPey/T5QQ8zokXOhZNA2t+VH1CMJp
	BVpva/x//bkwEc8vame0u8+118KXv6kKGMEPNQ4nTIoEChxq929uM0zmtZ7+XTo=
X-Google-Smtp-Source: AGHT+IFry0RlYQGrAAhXRAPDON49IcLTGX1hJRc3YJNRYsvqjBsTp4W4Yr1IHjDKv2LU9H9QWOR04g==
X-Received: by 2002:a19:5f46:0:b0:515:9aa9:ecb7 with SMTP id a6-20020a195f46000000b005159aa9ecb7mr667861lfj.27.1711152695471;
        Fri, 22 Mar 2024 17:11:35 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b00a46d4e26301sm341615ejk.27.2024.03.22.17.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:11:34 -0700 (PDT)
Message-ID: <cf8fb32d-3061-42e7-aa7d-4624c2bf413b@linaro.org>
Date: Sat, 23 Mar 2024 01:11:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] Add PCIe bridge node in DT for Qcom SoCs
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.03.2024 12:16, Manivannan Sadhasivam wrote:
> On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
> for each controller instance. Hence, this series adds a DT node for the
> PCIe bridges across all SoCs.
> 
> There is no functionality change with this series, but the PCIe bridge
> representation in DT will be necessary to add the DT node for the client
> devices like the one proposed in power sequencing series [1].
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-arm-msm/20240216203215.40870-8-brgl@bgdev.pl/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Everything looks good

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

