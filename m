Return-Path: <linux-kernel+bounces-22030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2982982C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2281C21C20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA547762;
	Wed, 10 Jan 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Du61n+9K"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710247A45
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e741123acso4375473e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704884308; x=1705489108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQl3ayL9sqF0LP6sySgVGCkUNXjL2bpTn4VJ6Si9uJw=;
        b=Du61n+9K+eYAURDjp6ifN3pf9DVIi9ZGODzDlm4sMcB6f+8NjL3mFkL0DdQfXmQ0L6
         lvcdAlhFYY8e03vfAQSKupu612PN7fmOd5JWXHbLgAUeYURtputJ0FO/V69/zO5eKKhJ
         EJdHbQBsUIEUpxkFOBr/LIem60NuOjCKG68PT26Oxf+pss+yd34M0/iBP1rriLGUp3lh
         0Y1dLgXOYrRtcUWHcQU+ECp+YF2/u2CZnXjQk9PQLu9oUhhrCf1aYy4zf4f9b9u/x1ZY
         EGjL+V+AZHaRa1epYHuJzLKeSGaBnkWOIyObcbTIEEvXMb12Il/y5WlPICAiirzFbmVz
         w8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704884308; x=1705489108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQl3ayL9sqF0LP6sySgVGCkUNXjL2bpTn4VJ6Si9uJw=;
        b=DXYiFntM6m1eE9r/JvzLtIiO1lQp97SBeoZ8+xaAK0f3FLDu+FoOYBiYdnN/eivAKq
         crp2Ar7W889jzw4ymCDipelj1jUC6FPuMsZu8jOe91+sPqYQ6mlho9t8xaWHDwW42OgW
         owRVzJNtHvHuN59D4KHMKCKiNbu9pfwR4GAV8rUMuirFRpouo4QGyweEu1Bi6F3NBKBr
         5qtR9g23KQCGuJjxmuDoD3hVEG//lQJ3fh4cu/GGDa+QWyZtjYFCtl/oNJv8XXLKQ0Co
         iXBPu4pWtaqa/BpXnboC3q3MnU/2rgYEOxO+2R1gJMutrYPy/aegt1K1VLlU6J+4ZRgT
         BmdA==
X-Gm-Message-State: AOJu0Yyu57gh6lj2pKX0Tl3nC1eSgDIjq1AgFJcpdZW/6u5VsfEoZ1fO
	6qAMXT1Ek39E82dIdYM5RrhQfahcd0iCzw==
X-Google-Smtp-Source: AGHT+IGQgra7b8A3guiBeFlLtpRtNPD7srNEqn1+qqwRBRSmoYj0FHlUHQUVTHZRC0a4Jj7cAmxmog==
X-Received: by 2002:a05:6512:4811:b0:50e:cbf1:d2f8 with SMTP id eo17-20020a056512481100b0050ecbf1d2f8mr256193lfb.134.1704884308105;
        Wed, 10 Jan 2024 02:58:28 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b13-20020ac2562d000000b0050e7f5cffa6sm617421lff.273.2024.01.10.02.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 02:58:27 -0800 (PST)
Message-ID: <3fdc6e74-d817-4341-bf64-9096608990d6@linaro.org>
Date: Wed, 10 Jan 2024 11:58:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 display and GPU
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240105-fp4-panel-v1-0-1afbabc55276@fairphone.com>
 <20240105-fp4-panel-v1-3-1afbabc55276@fairphone.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240105-fp4-panel-v1-3-1afbabc55276@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/5/24 15:29, Luca Weiss wrote:
> Add the description for the display panel found on this phone and remove
> the simple-framebuffer that was in place until now

Why? They should be able to coexist with a smooth-ish handoff

[...]

>   
> +&gmu {
> +	status = "okay";

Please kick the disablement from the SoC dtsi instead, it won't
probe without the GPU being enabled

Konrad

