Return-Path: <linux-kernel+bounces-48799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A22A8461A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E981F23ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20D8564B;
	Thu,  1 Feb 2024 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSQmiX8k"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54D8563A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817567; cv=none; b=a6/Wpfk2GXfsKTFvUF2cweIF7wK5A+X2e2IhrfJDzqPapbbzMyYmeBTyN/jK2vfSB/cTzRAyz92Q7+m+oTpB2VYIPTDaHxOD2SJfhD0aZwiN9bNMpamzsTtPIB2ZD6yUdzg8XWmwLXdkUkKsnCoL5flX6TCGJoDqCcKsI1Ih4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817567; c=relaxed/simple;
	bh=yemCSlTLsk8OwQPnRNYD/2IQjQ+HSzqIQZuEziEQu1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrmDFWaxYMYSnvwVjcwl6IXY7cKUrHeh9gSixP2UU9R6xXSulQT/jXhXjYssk6ozHlMv2fHR8p1X9Vbv/AeHtiT3dSQ6GoAy3i7cZ1dFPtnehg0tIsVEXQ/ikZvHZKEXu6EljzROfj/ChPEC7W6CrIuMxSNbKUemEuEeiQdf5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSQmiX8k; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so166456966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706817564; x=1707422364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dOp1JQgASRukzALnfQhyhwz92RPkxu1KRtWoDV2mjs=;
        b=SSQmiX8kBf9DWucTG4j0Ze/me28qTf5/CaFfxjGN6o/DcnbJDM7vdkwh8PeXrxc1FR
         FDyaPMFsnntmFddmBrK4qdGrmJodgEty0osjvSMe6ySsQ2ulHvyQ3o7oDL9m+6y7KWYe
         K5az1z9JTQytWcE8SeUemXRGmPseBavhhkFuIesnWu9h0V5gMUyCrDcXw+gCxcJbBp1o
         LmMyverT/sFeZbKqxxfRRzMFC5MJcG1DRlRRhKBtQe7bJ4+MrPZGyRBC/Wf7jXdd9xrs
         sFzlllGWVLs+9BlEJgQeid864iX4zXHbYihYXKfo4D1BeZcYxwDuvCphgZ3GDSR463Ab
         sgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817564; x=1707422364;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dOp1JQgASRukzALnfQhyhwz92RPkxu1KRtWoDV2mjs=;
        b=dmcQkixj5ZiTIo33qIl7c5gts8pCJAdSkJrNC4jPeluGyNxZ6hTDYBM3Bfp1guUFx7
         D/zBuZCVY5xKTOC/fJF0fB74CZfLVSguFvWc02lXb7fKj8kVzFM4umQObkr2wRSmlpNE
         H5T6QDL5DkN9xyKXv5HmLDO/XBUXl7vjYj+Zt4u2FUFY/4bvlh+oCuap/hN73cao4NEI
         CndajS1s5vY3i6QFD35OJ4EoZgXICZEhZSq5scH/GplEUqdlL4uSeox650Nv3pzX/ZqK
         P6UWU/0zAGeWTK2Q2cFuxl/6/C/4+neROwYY/JYgqU6wUBUhCoPyEIom5T0XKwXx3Poi
         byHA==
X-Forwarded-Encrypted: i=0; AJvYcCUUwmgYF5AomNEklMnR6wZ+nU45BZ/HtydGHKrf8b3zGVJTlzjx5B/W4F0zIQungH5eSQ3rtwx1MB57+2Abq3H236Sf3Bf8xwFyiRQp
X-Gm-Message-State: AOJu0YzA7W/V+s4FP1ZrTmPBBtoEN9kuccCXwXqL4leTbe4Sh3Oi9IKJ
	6/7SwjZJR4HAor9ghICytVBMoJVz/KhseFCZOH5K039L3O4dBtN/bHlPi7Ir2As=
X-Google-Smtp-Source: AGHT+IEssAWZFv+S4cGJLFyN6xFk8Ti/YY5fL4gEFTtsux6fgSXjeK3MbRw8YIb89B8Xy+Zy48nnzg==
X-Received: by 2002:a17:906:807:b0:a31:88d4:9a4c with SMTP id e7-20020a170906080700b00a3188d49a4cmr3861366ejd.22.1706817564249;
        Thu, 01 Feb 2024 11:59:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiRa5+Ww1MOwD7IJi1uBnxI6qvvRoZicjEsvFAld+PkE4XFrkA3zaW31nZErxltJRiB/Nz7q5btw80YWViRUMLbzGtaZnRYaXynuJ1VriWtvNta2bkHJo92vJHCLioenqdbC182yQcK8GA+01zgxHHLzzcICpKdPjxyU4bSENpH16tHHHQu1JGqKkZCDs3wGAxT6sr0XzfAWYbou4i/B6fIeS+113vT9KjjEFBegXlOpPljCA/lEevmMyh1SuPKnYfLwZVT8vfyYub
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090699ce00b00a36c6b0485asm108608ejn.103.2024.02.01.11.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:59:23 -0800 (PST)
Message-ID: <0cf69024-a3e6-4be2-89ce-017ae521721d@linaro.org>
Date: Thu, 1 Feb 2024 20:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.01.2024 17:55, Neil Armstrong wrote:
> Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
> received from endpoint devices to the CPU using GIC-ITS MSI controller.
> Add support for it.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> Like SM8450 & SM8550, the IDs are swapped, but works fine on PCIe0 and PCIe1.
> 
> WiFi PCIe Device on SM8650-QRD using GIC-ITS:
> 159:          0          0          0          0          0          0          0          0   ITS-MSI   0 Edge      PCIe PME, aerdrv
> 167:          0          4          0          0          0          0          0          0   ITS-MSI 524288 Edge      bhi
> 168:          0          0          4          0          0          0          0          0   ITS-MSI 524289 Edge      mhi
> 169:          0          0          0         34          0          0          0          0   ITS-MSI 524290 Edge      mhi
> 170:          0          0          0          0          3          0          0          0   ITS-MSI 524291 Edge      ce0
> 171:          0          0          0          0          0          2          0          0   ITS-MSI 524292 Edge      ce1
> 172:          0          0          0          0          0          0        806          0   ITS-MSI 524293 Edge      ce2
> 173:          0          0          0          0          0          0          0         76   ITS-MSI 524294 Edge      ce3
> 174:          0          0          0          0          0          0          0          0   ITS-MSI 524295 Edge      ce5
> 175:          0         13          0          0          0          0          0          0   ITS-MSI 524296 Edge      DP_EXT_IRQ
> 176:          0          0          0          0          0          0          0          0   ITS-MSI 524297 Edge      DP_EXT_IRQ

Is it by chance that this one never fired?

(lgtm otherwise)

Konrad

