Return-Path: <linux-kernel+bounces-72007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D085ADC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B459F28373D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAA53E39;
	Mon, 19 Feb 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeFwcjIe"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC554F88
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378366; cv=none; b=fWmHdY48dU7W41pKnEcYmzDMyNtSv0z2RiITSKFErlwaQjJ0xOFsagXYMUiN6EdhIdo/lZExuilcF0dYt35H4BGczNOYZLH0n/N2LcC0IA4/MRiG4qG8WAjvS5z3qxWR1hOU0bM6hyShSnmnubdCFPxpSXU9B9S4QgFItHuIaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378366; c=relaxed/simple;
	bh=m8KSthNjvuV2pc5kxKdpReYqU4WkfI+pOkWvedfqvB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7be6XdHmZBRlInCec4L9pg81/QsM0JXwMMttJKsTTT1NRtn7SZR7/45IXxM7wOGttDnhjbVPm9FooJuO9GNif/71gUs0EtUH8mTi5Cq+Tq9TOafBwKnnuIvijRjI1+b99ShItTgxidYblV6hQXMizTt4QIffd138POXZNKVyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeFwcjIe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so67952061fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708378362; x=1708983162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQMmvVMlguA712EM5vqAVmC9OaafpFPTCUNiNlSKks=;
        b=TeFwcjIeOu00recvs5fruG2f944u7WR06WE0o1Ce5xAGBaapfawTJFRbX5JQGFBZPt
         lZJFRmRYBxpzOsd3GL6i9eaOIVGz4dxG6sXmNKmWuXq7JccByugT1M04p+omsyCyVxm7
         VAa9f1XXad45GaFnY5U0f1WBPTMSCoXQ9fd0uOYLfg2lvKSHJ/R2dESAdo0mngs/Dfjg
         GTsgUZQ74np2yztetLKZQ1ODJuVJ4FfjxvxCTY42ALkJ6Ql2ZlKLD64s4JGFKGMubVUP
         G9fqNuViA4gS11Zo4h9SRshBMyf8+a78jyg61vJHS/makfODnmhe45mQ/oywfBxau5uA
         UBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378362; x=1708983162;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQMmvVMlguA712EM5vqAVmC9OaafpFPTCUNiNlSKks=;
        b=pffekz8wnRURRjJyTuKKs3d8Ox2JYUHult7nsSh6/sea7LjwuQlQd5kCU7rQHw0DoL
         hTQLoSmABgU3nL3fQXFHOFne9KYmZZQi0pJHHMKgiKlEQz5UP0558OGzZXcd3lFUIIr9
         wSYltP5+vEt0grPrkkW0ndpea2ruY4+ttYvw3gM+Vlpg3c9CFpydGubVdrhdVu/VwMhS
         Wd2VK4Rugw9opHg1L5zgQDmMQL4RdhxsV8kDfx5bruVby01igO0mdOgGI6gVxLoIaT+J
         vtDDb3uJpyyoK2/4JDqokMMNXYgZklwL2ulVh5bi6eckUWbmIKqDkrkbhnJujXOjCzRw
         QXRg==
X-Forwarded-Encrypted: i=1; AJvYcCW5/Ff2gzN8kD/SvLDo6saddyoDKMj7Cx9PKcItD6C7lYR5Tkwd+WZWt0DABmArEiaJp4SOXcmi4G/lL8EKtHg78Su758Q1/oB88unM
X-Gm-Message-State: AOJu0YzbxjrNKBW+rlojg6C8rkbKhAuyP5ZhDtjMNlFliy9+O7Nx4gEl
	fe31TJKs7lVjcvPgaMBWnZyJRsbRIvmZK/4/zy+aVEmpRRoJCHZWKo7u/D2Fkms=
X-Google-Smtp-Source: AGHT+IGsGaqgk96JXsoNn+fNEykHvT/hvS4W/mr9CHJ/L/IlAI3OWqz8/XzfcMKglZwgUC6PsV3Nww==
X-Received: by 2002:a2e:80da:0:b0:2d0:9fb2:2c79 with SMTP id r26-20020a2e80da000000b002d09fb22c79mr8593370ljg.3.1708378362022;
        Mon, 19 Feb 2024 13:32:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b00410add3af79sm12204151wmq.23.2024.02.19.13.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 13:32:41 -0800 (PST)
Message-ID: <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
Date: Mon, 19 Feb 2024 22:32:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
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
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
> list due to prior driver change.
> 
> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
> compatible lists.
> 
> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>  2 files changed, 95 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> new file mode 100644
> index 000000000000..1b57e0396209
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@outlook.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - hisilicon,hi3798cv200-usb2-phy
> +          - hisilicon,hi3798mv100-usb2-phy
> +      - const: hisilicon,inno-usb2-phy

According to your driver hisilicon,hi3798mv100-usb2-phy and
hisilicon,inno-usb2-phy are not compatible.

This is confusing.

Best regards,
Krzysztof


