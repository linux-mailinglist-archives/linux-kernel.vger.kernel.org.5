Return-Path: <linux-kernel+bounces-72526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1BF85B4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDA1F21610
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD75C612;
	Tue, 20 Feb 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHUnKtqU"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91A5C8F4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417125; cv=none; b=BwvOf/Pfc8KSCFe+f1487xvd9HfNU/qaEDZuZ8hpn6q8mZA6y7KCfunoB7e2cUN3TRs/WxswDFl0gFLGKTgQRZIeB2NecjkMNGUtLU4ezmA+stO9+6b8lwFkD4DtAHf+ogwcDnhLrlSyhke7153lsxHpCBzACVoJdVdA3EVCvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417125; c=relaxed/simple;
	bh=pHdRA+7ogJ02qcXpOX5WJivcbhrt5n170QtkCSfmb6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRPnfmF3JrD1wAfiv5flI8fC+NiiDNytPueQ3MpjlxaCoe81/NH2nq3tkcJUu4/OPSLnqqDZN7XTnkPpsYycuYCun4hnpJy/swlCWhg2uz1gyZKjC3gEledmd1li3d9NMUxzM0nYxSWBSiMsML7QZ8caUtMN/PEHZTuyelZliEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eHUnKtqU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so41195201fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708417122; x=1709021922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi3MPqgCuLHNFY4zy61+ProRpnD0uv04k3iT1qIMqWo=;
        b=eHUnKtqUBvPORk/xBdRYULnTSmf5eR1qlyGDDoJc8wDCv+NHGxev6QWrQ0C/URbJgF
         /Dk9YXhKJVb+7+t/wYXVFeTXhXmJeIcjRgF2VQ+MzDzzKY0VzOsJao0ZWQ1nfyg07UYF
         1URZIBXKu7Sn7jX5DY3FuVf3BSzE/aOc88FJwlnOseJN+Sznr2oEKYrOrB/HQTyCfQKY
         GlPk5P/gqHRhvvWdfCratC5y+bRVtOoajFrMVP6dryfXGYQMEfn/mcJ2eJxAa5z30M+N
         7fGSnlJJIescpCfMXILwTLfj595ypcp4pxuDg4qHflaZGR8lpDkyGX64Y3nlhGqtBORg
         knvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417122; x=1709021922;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi3MPqgCuLHNFY4zy61+ProRpnD0uv04k3iT1qIMqWo=;
        b=A7oGL7o0uaJUpR04l+Sql+xGSOd6TVhbtGcTbziO2uci+4JeKLc5aw1WTTellZK3vC
         Ul4W2rCQhegpxOqvRsYcHwVpUd6v0U5UwDwKyL1NVcOpdHQrbU/Du66CMiKYpmWeXFqe
         Ctdq1yIsiRWcqgCg16TZ+4fKmvlejQhjK6DuU0E1TkhVsXq+pAlVGd/AhNH4cQ3N3Yy1
         L9hMhuwm1CS9gkXgd1kaGYpfq4XtI+sIef6toeupM2+DQ5srdcFpVRrVAfr9Znp9v7X3
         iKm6ysb6HzzaM1WNxzHMR2jaOxHP7mcGr8vKmDHr2HzZnArK9075RirS6WELDUHrHJ/T
         lArA==
X-Forwarded-Encrypted: i=1; AJvYcCUz+36ijHU0CFmPNLWDDXgdy2vUJeiaxcM7sTqpDT8b5oH6oGKGi7asn2gf0qQTO/NnDJpNiaMMhXE8tp9f28caYZYFSC49RzG4nxep
X-Gm-Message-State: AOJu0YyMx8MSHC1Fn16gq/Kr7IY7MKNxt+jkMEiXvjYegVCFLwYaJfK4
	BPmmyW47VTUbIK4H/dBkK1zHo1LFW2R1ATdjLph5+4815HOVwoQbnQA3nDJNpPk=
X-Google-Smtp-Source: AGHT+IHIF0Y7hUiJfXgMVPQ6b5AvdKdIvPBjYCi2iMSr2MBt7/EmnsRks4vdnwTjpn6NQNsrGavztA==
X-Received: by 2002:ac2:58fc:0:b0:512:b3f8:81d2 with SMTP id v28-20020ac258fc000000b00512b3f881d2mr2409057lfo.12.1708417121872;
        Tue, 20 Feb 2024 00:18:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b0040fe4b733f4sm13549306wme.26.2024.02.20.00.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:18:41 -0800 (PST)
Message-ID: <d69b3fd0-2799-4cf7-90fd-d22e6c24bdc3@linaro.org>
Date: Tue, 20 Feb 2024 09:18:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 5/5] dt-bindings: phy: hisi-inno-usb2: add
 compatible of hisilicon,hi3798mv200-usb2-phy
Content-Language: en-US
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-5-893cdf8633b4@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240220-inno-phy-v3-5-893cdf8633b4@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 22:28, Yang Xiwen via B4 Relay wrote:
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: port
> +      - const: test

Why old device now gets two resets? You need to constrain it per variant.

Best regards,
Krzysztof


