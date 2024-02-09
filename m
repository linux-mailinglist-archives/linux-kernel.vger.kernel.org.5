Return-Path: <linux-kernel+bounces-60024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F484FEC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16931C24361
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A717BD3;
	Fri,  9 Feb 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkWOkY3G"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BBA538A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513933; cv=none; b=dQXLlzAc0QYenZrdYhCZeB4V2ZZcE/Sec41jebLjzoDdbSjfZcoTUODSf+6GGemIvxEQJtEUH7YyfsDJQLohYZurzI0E4cpOFoYZJM3/WJxGFYWJRZHY4K/vxzK3rn08bRd2vxX8x+cHX+3lzeoYIlEWMetoYIGt+yUcZ5OnJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513933; c=relaxed/simple;
	bh=w/XvmRgPtCBZGUAUHtdPmQu1TYOe0gjuO1Vk0hsbLdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS567EHFvBlJW/fbclYScaCnxQTMDyPpTobhtTYfIt5meBq7faaleOUhk1lWN47q8MqooQGEbxOzNU6IKinLbJw0CY6RP7WJrR2klXurSDuQ79XxDyJ0Mu8bXRpyJyWEDUMMKw3IB7pHbvmEyy2r89e4RxTdlOtGUkCsI8S5y2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkWOkY3G; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a383016f428so156121966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513929; x=1708118729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ei3V7Q0ZCMeJfeAnJqw+KwLQeCtW7bgtZ2iOxUJPJYI=;
        b=vkWOkY3G3u8rCZ9aOUtrkS204d1Z5H7gc3URwhzZdHvK0ku4ig1Xbmj8dUXHBuVwQ+
         oMUs9JJkTjCrXIbXOMVwv8LW/yYRUkOKppXDKkrcUemLh2mAU8SD9r/sn8qrJeIsn69R
         R6wefhFRh2L9egtqdEW1IVqNExEHEbI3KhqKmV5fzGYFvqec6tBVphPeA6ZaI1nkG9bR
         nhloM1LXplHEgJhGeei32w4fkSAXNwHXOCmA+n/ac/CKF9AbY8/yGl+zDfxD+wRd+j0G
         ZIGl9tZVDrTcRNx4P15CX5yCFRGRKAroWcYo0Ro4IEKaulZRDDlhj7t2jzzR+H9OzCX1
         ttWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513929; x=1708118729;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei3V7Q0ZCMeJfeAnJqw+KwLQeCtW7bgtZ2iOxUJPJYI=;
        b=suLDfIi+ZSFY/su9ySWxpdTfYvo/0k4IoX6OllZ1NYWYbID+BoFV6a4Bcgr/S5fd0a
         bS5GGua1SC/SzhquMfWV91NJ+WC8jyJ1fo8fa7HFLdSAIGF1CCK+01BAQNDkfCVWwCP3
         QHTh+yOWt1THyEVmdexBmgFv/CEGHi8dnlYwlhtFHjZFs/yQg5O+SDIqyFQ5zTnYiNdV
         GnDbeei8pr6oICDog6ajIcyntbP4QjkzCaE87W/GXXq6fwaIU46arMmTL852RC7rW1HL
         cvl6EVTz8inVUeL2u5mKrgDX6aMvWMF3AE2Lm2jaPuni6LgK8jAi4IL48c5YjWS5/dxo
         HQzg==
X-Gm-Message-State: AOJu0Yx7rSPIfWO33b6F+8CfYToRp9EVZ6otHO0wgkn3KrcuDJYv0yg8
	fWRJ2DuLBB4F+K6k69qLm4t42TkAaAiTM23a/yWDbXANjLWRxr/xqdQOqEXo9b8=
X-Google-Smtp-Source: AGHT+IEKA6PrmiVZORVYW2K6LDkg3oCWd/p5AJJwFFTHm5If66qb1QAnJE+E2KX7Ns3pQH1MJC0RQw==
X-Received: by 2002:a17:906:68e:b0:a37:17f9:42ad with SMTP id u14-20020a170906068e00b00a3717f942admr251259ejb.5.1707513929195;
        Fri, 09 Feb 2024 13:25:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPkh8uhaRYmF4N5rOjc0mz4EagteC5TOgQxsfx4EbiOmYy0eO7LMbTDyrn1JqOsflP9ic9KmFhx6rWTwMp+ikcJMtmfZcy1cIj7i6mfxPQfHrXeZwnSXxhHarTxYUOIyF10GdXRQoIRdFsHNfB5N/z1/aVMqUSIkOeOoSW2/D2cBHSriQDslczh/7+nJjVXzZ9C9STfX3G+E+LIvgNYEQ92jG4feHg0nCdv7eAIk0ufJp0f+M2z5eojnBkcpByi04uPHpJl+7EeQZJIScIPZHwD96tEHysN+gYHKAsk9lWYzuXKKGiLEr6QSLbSybog9oXiPvIhYZGuQMqt68ufIDBsUPkI2RFCbknQ//ZEH4jiNg7K44DpCiLeyousYOTwAm121hxKOtFusySckWREz+7mFtphQYS53ixQOV66qoWUIqNQFqBHF15WTmG9JprRdMZEBKWos63QoCCOMqiQiYQTHN+nfJsRq6y77zjpk8dc3FfTLHJd8B1FgNpqwOowkdB8eB8eun7Tryr0RO8puWODCDtIdjd1SV2P9HvnCmTYEXe8JGtCMY/aI6QHjQD
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709061d1900b00a3c1e8ecc09sm132677ejh.152.2024.02.09.13.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:25:28 -0800 (PST)
Message-ID: <6fe9f7aa-d0ef-4b8d-953f-c8051f0a1694@linaro.org>
Date: Fri, 9 Feb 2024 22:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: qrb4210-rb2: enable USB-C port
 handling
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
 <20240130-pmi632-typec-v3-6-b05fe44f0a51@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130-pmi632-typec-v3-6-b05fe44f0a51@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 20:32, Dmitry Baryshkov wrote:
> Plug in USB-C related bits and pieces to enable USB role switching and
> USB-C orientation handling for the Qualcomm RB2 board.
> 
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

