Return-Path: <linux-kernel+bounces-60769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9D85093A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EB328673E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56A5C5E8;
	Sun, 11 Feb 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX7IhvdU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749035C05F
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654895; cv=none; b=LJRKjlpMw14muUo7UBku56ZuJIpOL1HPcdl7I6x7/sKXexYzIEzqZlJNjBIJW3KO0vpwI+CdQJgzLW/xR0pePN3/daE+cQeT0xxhw8ToUVMwuSPsxMkBTwufBbTUnxlTZYakY5bUxpky8jhzD2LY2kGPJFfCyOXetYA559uBHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654895; c=relaxed/simple;
	bh=QGSB9vQFBzaOSZ1Q1KgAdhwcktg+EZUqfnt1pIw+ZOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp1mFF2TJiWP9tpxr+AQGSB8ZRlsVDQ+bOt9yNdcg4nr7Ag7K4j2UjtchUZGcHZlJOf18yPMA2FKyKuvP/7lcEXrfCv+ZeSOmmtdYV99Uni3wz7nB/Sb0/pXsflOmRT8YpRw4CmVkXm4eq3gvy22AZBgjQu/nxx2Odt0X4015uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YX7IhvdU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-410c1ebf5e4so1903335e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707654892; x=1708259692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPK0EfMN0yxK9w97IP5JX0KkHv5GGy9XxGZVuxjRPoM=;
        b=YX7IhvdUrcyX8sZsrmO3Kez4FWKAV6BbLNgiXkMn6uq1PO/5N5HKglnc1g5goRzJVp
         eQopPiN/yi1VnNupx28zjc0ffDBJSJkKv00VUHiAqTSMw/VE5+5sa6Fmivs1X9AcC0+C
         VD3AYZFFH4oqzYldVLrVjewbP+O1oLN34p10Fbe0rOTv0gUl//7cxd9jy3+jVOut5gZd
         BHe8x8d4M3J9iJkjYfaYHLNew06awYS25mFGAxp0Litf6QKqfk+1ZrvyTVRbWBbPIg2S
         tZ2SWQhBmiLouM/NrSicyVaPpyYpwfOIP72ujTJDzfwAE8DsAQdjyy4KYjJJr0B0NhEh
         KplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654892; x=1708259692;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPK0EfMN0yxK9w97IP5JX0KkHv5GGy9XxGZVuxjRPoM=;
        b=g2rD5o0n6vpifMhW4InQrRtK289JOXd9msrSdh97amFtmuPIVjL1mXmc0IrvG/Tk3z
         bagzQOLY6zxQXXrPG7wDwBMjO3K5quFxejDRC0L8Nbp+I5xHfGfsstHtTAnVDYYn7fxu
         krMJw6+VZVOcroSfNA/70Bo9nqD2vG/uG9iwXmtyhBbG3LRliyNQ5I6+MHbBh/iij+9y
         mG80L60fv3h/DMpZgIxKklzz8DaGd5NlMp7MShWjEnrYtdrURVlC8t61xqXpeGH4aZ6+
         MAfIlMPG4ZePyWHt/TDAjQRynb09/GODFUUyApkhmGc0eI+y5Rbg+7Q9nvjIkOrLL40v
         /5xw==
X-Forwarded-Encrypted: i=1; AJvYcCUQqsB0PPtk2vDfT3Tdc0+1MceqYleq6xQsRwek7lKVE+/Dg4PFUsff9RC+IxLoN4G8AES/9SwznO3wKD6OjNj+48T03nD0R0M3bkV7
X-Gm-Message-State: AOJu0YzR5UjxgbrW0AR+e7sxSmh+aaaMTDsjELXRUR4aKMOxARmdMBza
	EgprX6owqH9mZb1AWfWRzplF2dyqOBAPrOz5QRxkADic7DSY+yjsiaWMLmfqao4=
X-Google-Smtp-Source: AGHT+IEGWuRE0MWUGYz/HvyE9OS+KwABNnqHf/LaqT2dBQUSYXrCVtLl67P9PvMXyprkP0UcBgh3PA==
X-Received: by 2002:a05:600c:4f43:b0:410:6d90:8f19 with SMTP id m3-20020a05600c4f4300b004106d908f19mr4075672wmq.3.1707654891817;
        Sun, 11 Feb 2024 04:34:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdjekMBubdXrpZNV5ZNf4MrE7ImeT1/sXpNy9mI40MRGSVAlgw4+znygCusuMrmPQ3fKZFfCU3kndKEQ6+tzEgPnKT5XXSUvIorsr5T4DaO3GFhBYtMpQAuc+ZZeXdvYGSHcFfjWj1VxxIGjDELmlLO1otxLSeqiMJYqBKolZafAC6O2tOkMOLWrxWgUELcJs/E9IoevdyVgQklDrFQbZ8d37sykNB5fadKbGC58COPdTo28VrKL2/IsSNI4PYyQYF0KecA3aHFyYK6v8w/3kTs0AXZkthKLDk4c7dd37VyTPq4Jbm+LAXeLT8zGC7Zm0eYsDcL0T5OMOnUTK83bfTwvbXEIYA2uRAJ1casi9YhI8FxGsOqDJMtk2Z3MNCCiTahQeHj5UfxzxjcKaMXIf/yB1wT4lv44iSkCMiEHt1JLW+FFsgPKaijk1Md6Gc20P5P9Op9SjFaMH94ayd0//5BO+9XkvK5Ezzptvk5Ybhh773wRlhoagmEYoeDDWtEU6JRvr1EyNY1lZSnwe23w==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b0040fdb17e66csm5833625wms.4.2024.02.11.04.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:34:51 -0800 (PST)
Message-ID: <f479f1c1-cf84-4738-8c6e-832869951b82@linaro.org>
Date: Sun, 11 Feb 2024 13:34:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/14] dt-bindings: arm: add UNI-T UTi260b
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-14-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210012114.489102-14-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> Add compatible value for i.MX6ULL based UNI-T
> UTi260b thermal camera.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 228dcc5c7d6f..fa20c2699530 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -708,6 +708,7 @@ properties:
>                - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
>                - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
>                - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
> +              - uni-t,imx6ull-uti260b   # UNI-T UTi260b

If the product name is "uti260b", then it is enough "uni-t,uti260b". If
you added the imx part because there is a SoM, then it is anyway not
correct representation of the SoM.

Best regards,
Krzysztof


