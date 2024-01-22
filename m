Return-Path: <linux-kernel+bounces-32788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1209836014
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D0C1F21481
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4D23A27B;
	Mon, 22 Jan 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIxaTDia"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBA3A1BE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920660; cv=none; b=e2AHMtJx74/QGIQWF8qJ5dZIr9C5sNgsAA3UnzDbP+717bIPEUvkugblN1hfYNkI/kLU9a/OSQFJQ7sl1U933p3GKUB8m9D88I9+6kMnBW0p2gQVLkN7Exbvhdz3hgIb6D6OgLllgIXAu3Dchki+qQuWZxz3rBFynjCZAijjqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920660; c=relaxed/simple;
	bh=dFQKRV53d41l5dL/sSIuuPKf5MGyxVfeQ8gHMWfsGu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7XKfvbY8mqx/5GBWRShCFHi7PRMl0xrw3b/a+AWFTgX1AMF9urO2fjqeOF18dst57v4HhwEz9b4S0veS++8ncEvsl4qoTGJMLzp2LJijLzMicj/03vdNxMGw1oZmviaTIH8gncYMzZOUslxR2HUELy6BM/DFe+YDUauZYvm+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QIxaTDia; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a997f3dfso214642166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705920657; x=1706525457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M8yvXevL9licw83jHDt/PBzBsdwg08SwRbA4+7IDl1s=;
        b=QIxaTDia3CjFJDjmzdwZ/4ziRpu6wYW3A0CJFqw/NlTrwGSxFv7jgpjigEid9ASMP2
         6VXqvnAZ7EXhz7tHQQyUk9hDbTKt81f4Lyb+q6kf1ew5ZYqW3Nny65MRxVXBfVE1BjLD
         kddNwbAoTj1iH9aboXI3qdpKr6IHQRdstl+uJuQ49e3+v3ToJxU/GTbw7L0Ri4XGbHKf
         qvArg1OdXqJ0Gilcr37MdGsepbg7e9s8kA4txeJcc329C5MTfX8swYvKxMg7VeA9J6tQ
         9P/Lwr7NsOLHx7DRJ9hDILBTnK2DPd572CHP6/8jPrcPuSh3kb6LQWt3oyeB2tE8knFS
         Katg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920657; x=1706525457;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8yvXevL9licw83jHDt/PBzBsdwg08SwRbA4+7IDl1s=;
        b=mTza+iH10xpqLa06IQF+wNZVck5wueBnLNMorzLJgC3qPPUDPJ+9457+VCOmktPoxn
         MbL0A3Pib47FhC2XZj1+j23ZI2v4v3Vmhgj6dPYSSFB/YzpVv1iR6rApIIT8UNHsGaqB
         /T9EtZrcIRXh2n1ezGyO6+jfJmnVouu+mLOn6Necc7/6J+uSKYO7POB4+gfsTIY6e8kP
         m/U3ggh6FHEFPcnJWz8FcEO3GR9gx1fSXF8BWy/T5RJvjsCHxE3XUkAMSwiFmypnKAg7
         Gi9uH7lw2E6rycaVvwWR3gElYNGeckv/hRaWKEvPYNY2vs/SVpoPnOViPrwvMDPMEjXE
         BMVg==
X-Gm-Message-State: AOJu0YwRSdtmWoWlVU65FiwAh+oPn3I/knYRZC3VlpJeV1j7xybLva3b
	z1hgr/ReGaFv31CNVJEv3SOxEtOZavqTj6RUgn4iv3dICI0f4zexsvm2bsu6noQ=
X-Google-Smtp-Source: AGHT+IGm2Ud+3TjJVbH3MlgByCMSKS5V1U79UJiHNFQrN71oS9MCtY8unE+1Rpl4Rlkh4BPFhMPOOQ==
X-Received: by 2002:a17:906:268e:b0:a2c:6bea:58a8 with SMTP id t14-20020a170906268e00b00a2c6bea58a8mr2086541ejc.37.1705920657106;
        Mon, 22 Jan 2024 02:50:57 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id qa18-20020a170907869200b00a2f168ca475sm5177494ejc.140.2024.01.22.02.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:50:56 -0800 (PST)
Message-ID: <1635b0e5-df47-4918-be83-edc27c59d8cf@linaro.org>
Date: Mon, 22 Jan 2024 11:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for Samsung
 Galaxy S5 China
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240121154010.168440-1-i@rong.moe>
 <20240121154010.168440-5-i@rong.moe>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240121154010.168440-5-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.01.2024 16:39, Rong Zhang wrote:
> This device has little difference compared to Samsung Galaxy S5 (klte),
> so the device tree is based on qcom-msm8974pro-samsung-klte.dts. The
> only difference is the gpio pins of i2c_led_gpio. With pins corrected,
> the LEDs and WiFi are able to work properly.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---

Looks like you didn't change the brcm,board-type though?

[...]

> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-msm8974pro-samsung-klte.dts"

It's customary not to include .dts files, instead split the common parts
into e.g. qcom-msm8974pro-samsung-klte-common.dtsi and include this in
both the existing and the new one.

Konrad

