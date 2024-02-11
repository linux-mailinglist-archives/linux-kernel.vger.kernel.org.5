Return-Path: <linux-kernel+bounces-60864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EE850A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71F11C21CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431465C5FE;
	Sun, 11 Feb 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4UYGByR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8355C8FC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668858; cv=none; b=HlycsjVjjbjfhqH6mtRY9VeBHgChsb+rUeRefmBP5ehveZaDShhnTLgw9XKNp4n37ua8z6Hs7NeexkJFMy32OBbTlDro/IYy7l4FVFaA+ODdCDHSPOFC8KpOm+AWCz+FyK2hn0rOwovNJLTOAxA1owrtrJ3tCNJ9WdVcnc5tbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668858; c=relaxed/simple;
	bh=VjMOZyGkFTC4YEVkNIl29akoquINIdc1vXMWaDZAP18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCdhjgtlQT4wiyrpowZtpBOff2X6vDfZzhVh5Q24fDRkgljj/SmhtVFfJq8IKCfweUMcWCAG+4/7/yxV6b8utY2iOmRUeMroRJilsIHmnhrKxtzVIqbsRQeN9zpIEdnl8ocVYhlY9/Qlxr/DCZHBV7zVjnqB5iqZN0GODXXHQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4UYGByR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410cb93185dso2045825e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707668855; x=1708273655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14MQ2UgvpBbTYsh1PZKzThnxP7fIOs6UP5ZJI2+1J7Y=;
        b=r4UYGByRhaWicQsRSIUB64F7LMDEV+/YvwTp9+YHA5RYlHAznSzKy+jVQAmfAGr1Tc
         pL5PNFsYHl6j64gFwEYAsWiJsauKoa/10zjg+41Zu58xqcgs4YdX8vo4zBz2D6G8sUol
         jQKuBwRTk/7BfxbVswNp9O6TigO501uwgvn6muzU2b66NV1AT6GtF96/Zrn0RQoXopnJ
         Y+pxB12eWSEDXmpxljLvHurhaTNV8ttwqh8auxs0fGCwpoT32tJIj+SfZJLgkxcoOxT/
         aDX0O9gh5i0n1/je5uvWBwlsTXGzuOTTX309Ll/YvIqjub4m79R/AIHM5pEqjxxbkPwy
         WUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707668855; x=1708273655;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14MQ2UgvpBbTYsh1PZKzThnxP7fIOs6UP5ZJI2+1J7Y=;
        b=rM0NqzV5D75IFA8lgmjndMkBuVpRquGMWKhhlP+yvBkPYxe7Ax5uuBN+NpMJAISdEt
         o5q9ErSEgbXMqBU09SBjDSDts+Mk5YUyEsDwrwoDZNV1IuWDrI1pLVu7ZX4+5ZRE39kX
         bo7Su3YkTW+0SLHFnmBzTJROwSmCeqNGC9pU5z6aErRfvRKSFOFG2VAofeEldc5S6gq8
         IfJl0+6LQJZQSjwkgLziLjenCLEHBr04v0G9iGDAVRwZm4KoBxm9hc0wzH56pa7QTArz
         BcaRdFa3wLjQJhGot6lEmlZQE54NYGGBzPP/Okn4jo675Y3RKlSiXPwV72aW/rxr7/f3
         rAzA==
X-Forwarded-Encrypted: i=1; AJvYcCWnJkkHUetQpd6lirKH4NACzUlvqaVw3+s9OAwh60Z5dsIyNadV5tVbHjOk9g1yiRq03vXAHeOokjDtfjVJvWA0E8qPtBEkdMPtRRZ1
X-Gm-Message-State: AOJu0Yxi2d8YBCcLu5zqzHRmKFMUzRsnvxvQvpdMjqC0j4XWDPVMx+0m
	vNzrK8sweZDndEoBKaBhDiebaV6WzPCLg2GUZCc33HcRCDpeqRBzA+kK1WrgFLMGmSUW96+Fo9o
	g
X-Google-Smtp-Source: AGHT+IHQL89NNYSHgtLHCi0/ING8wnmJvXMUEuXdGJQyrRjJFG8qyzlQK2QjNZpQkPoFNQ0v3WDXhQ==
X-Received: by 2002:a05:600c:45c7:b0:410:d3b8:d39c with SMTP id s7-20020a05600c45c700b00410d3b8d39cmr554929wmo.29.1707668854833;
        Sun, 11 Feb 2024 08:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWo9ouAO0a1Jcew9OsrdI135eooJrtd7aJI4dAfPi3wn3X/4j7mvaNThhl42RnUwN9kGil5b5pZuf02jFRlYHjJ+v9g+yk/ZjYFLosqnmXnEsmGiaGJysz7BYIFcStiq6h+2Os+X3GIbkuOVmMnSy2kUtC6SYpMozUURD39kXUmWbYjsCpLmjU9xTi9BkACUYCBgiHKfuIQmZRRQqMJV0w9IwG11cV8kKzaqYjLDwR9vYTU2T+qMKknWwC5AMgSNYhblfcCRKguTYPf5nm0MuCGd2SNDGpYXMUCYDZUPP7tasqoFBD6tm8zMLrHN74l4kR26EtizdGrfPj5DVxXlguTCpF35W4tVZJB6FMm/SGY5bYqlGUynq31Utv2bfLJeEI9xt8/vg==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id jp25-20020a05600c559900b00410c7912c6esm1284290wmb.14.2024.02.11.08.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:27:34 -0800 (PST)
Message-ID: <662b50b2-93e2-4b55-b3a1-d405fcdb63ea@linaro.org>
Date: Sun, 11 Feb 2024 17:27:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,snps-eusb2-repeater: Add
 compatible for SMB2360
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-0-af2ca4d95a67@linaro.org>
 <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-1-af2ca4d95a67@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-1-af2ca4d95a67@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 16:14, Abel Vesa wrote:
> Add a dt-bindings compatible string for the Qualcomm's SMB2360 PMIC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> index 24c733c10e0e..6be20c157568 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> @@ -21,6 +21,7 @@ properties:
>                - qcom,pm7550ba-eusb2-repeater
>            - const: qcom,pm8550b-eusb2-repeater
>        - const: qcom,pm8550b-eusb2-repeater
> +      - const: qcom,smb2360-eusb2-repeater

Make it an enum with previous entry. Same effect, but it is easier to
read, especially in limited diffs, and more obvious.

Anyway:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


