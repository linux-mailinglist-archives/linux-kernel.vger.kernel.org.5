Return-Path: <linux-kernel+bounces-16497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936B823F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79CE1F24EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009820B29;
	Thu,  4 Jan 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCeaDL41"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB020B1A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28b0207c1dso26751666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704363419; x=1704968219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axVHCLogiFwlowqKF1yqwuJ21Ur8/u8wrrCsdFwy9zI=;
        b=yCeaDL41QQRMIUdmUHpgXf+H/HovvQPgFK4XOUdCHgeMBeCmqFUvzumXkOWE0drRcv
         4AnE+DGK5wFspopKF5sMaSC0vXb8d/LkZiw8FuHkd/0XBenxJmMWERnjreo9Tgsxrfeu
         q/4dbMjHG+9vvcXlfN27r47uHSmd1rOYtXC0Vf+eFtP0YfmIDiCdAGZQGHLE1KkYwgAO
         5zvXgeoxhZqwhK2bdoAKMhE0GvA+62vxCwCJZlprGTCWTpjaeQkmIQ+IfNa+l7Rcoodn
         Rtw8WB/bA7AL/nO3bXy+t0FJQgCuMipFqtB82qD8M0s1/LzX4EwjcsWnMF+Tvi8I5ytT
         fj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704363419; x=1704968219;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axVHCLogiFwlowqKF1yqwuJ21Ur8/u8wrrCsdFwy9zI=;
        b=mLeUQxZur7CzJgC9s8Hhv2FzwwbLhGthq3hGvQlTp+3ObNVUEvo4iBpmdGKUMCeHrF
         nqAPBc2lSL0jIzK5fxy5/6On/Kjjdw/ojQfSE2qzWzDydmKh1vXIidJqWAEUeq4e1VQD
         Nb4Q7+HQ7jds4iQdz7RDLyGzcnOOrdRsjqnmFyLrHHTNM0hzlv2kpV/dwDcAQ1QRa8+E
         XpRaZZsIgsAAlQu8ImHgu5WwPvUN6+CJ2hZjOIeeVTqQBkOGorXcnIZXMPH7wQ14w3sc
         gRqJe3Q3VH2CnbWVPUXXtRf4CqrhbFFkgxwmL3Ou4FxgXdPxvQed0RT2q4k3F6lc8Whd
         9IvA==
X-Gm-Message-State: AOJu0YyfiQqagvhbxZrp5I68216hIPL7M/flZEIvwpheGEuxqyC/yLYp
	DD9rtpnFwRiAVh2RTyVny7d57zrl4GL5Gg==
X-Google-Smtp-Source: AGHT+IHdymu8t3HtyUPiEU28onagVr5wHHe1WM/EeHGHy0yvUD5I1K2Ao7taHvX1UNV5uRAu4jjxdQ==
X-Received: by 2002:a17:906:73c5:b0:a28:e159:b598 with SMTP id n5-20020a17090673c500b00a28e159b598mr251487ejl.60.1704363418584;
        Thu, 04 Jan 2024 02:16:58 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709063ad000b00a28bf7969cdsm777767ejd.180.2024.01.04.02.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 02:16:58 -0800 (PST)
Message-ID: <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
Date: Thu, 4 Jan 2024 11:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
Content-Language: en-US
To: Fenglin Wu <quic_fenglinw@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, quic_tdas@quicinc.com,
 quic_aiquny@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
 <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4.01.2024 11:13, Fenglin Wu wrote:
> 
> 
> On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
>> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>>
>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>
>>> Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
>>> so add it for ipq6018 gcc device node to eliminate following warning in
>>> dtbs_check:
>>>
>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
>>>          '#power-domain-cells' is a required property
>>> from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
>>
>> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
>> the warning you are adding a bogus property.
>>
> I agree. However, there are also some gcc drivers not implementing GDSC support but the bindings are adding '#power-domain-cells' in the DT example, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml, qcom,gcc-ipq6018.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.
> 
> Actually I thought that maybe we should do a clean up by removing '#power-domain-cells' out of the qcom,gcc.yaml binding and only adding it into individual qcom,gcc-xxx.yaml for the driver which has implemented GDSC support. I checked this with Taniya offline, but she prefers only fixing it in ipq6018.dtsi as it doesn't hurt anything by adding the property, and she expects the GDSC support should be existing in most of qcom,gcc drivers especially the newer Qcom chipsets.

Before we start changing anything, we should assess whether these
platforms actually have GDSCs within this clock controller block,
even if they are (currently) not described in the clk driver.

Konrad

