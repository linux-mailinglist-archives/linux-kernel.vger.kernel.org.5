Return-Path: <linux-kernel+bounces-122519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDC88F900
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A51B25DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEB50A6B;
	Thu, 28 Mar 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnNYGmg3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCA537E6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611779; cv=none; b=d+NqNxy8ZgRr21/2U8omfuer/273dosFwNL7oWDY9M2Ib/+VFHupQ37xFWhHI+yy8FTcK90yt9vuCFd1HL96gb9ZZ8SQHgamZoH2PQiHMHdBW2ZgBR2s61tOvcIyeopXWhasRcNsQVm/4icr4iU4JYWZlJY78lG9B/RUf1KOux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611779; c=relaxed/simple;
	bh=nKUzJTHQzNFpVntUC/PVLAP63nOsFjnAW7ofZ93y5EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6Nhzpq5opsxdkBOluA15jUp5KM51id+eQ1FpcTYzR0fBa30gJe901+FHIuyoHiBJDzaEA0IBnZKbcEYImHgxwfLiKcToot/rjVcJzhf2xQ0anPMxIdJ1Sif6ur3W9tDft8WqK8F01ptwQB7lQHl1zgCQ7d4sQOSdiDwXqZbFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnNYGmg3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4149521d76aso4556145e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711611775; x=1712216575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9Z1hl3Voqz4rKbH/aYbXcmA5wCp7kHC4YYlDvX1XsQ=;
        b=xnNYGmg35zDGpO7N4mwt517RpPNR8ISUPvXOlIhyjt0LNX/wONsA6J4l5mGHGRFcDg
         E3WEwcqZK/xRvWSq4UnlXg6ddfl8y4dU2tq+KiTDu7la9LzqY0BC5fnvY+7wMpmWGkfR
         PDWTXj9Wax4fDOWG3SpJ0MfkNltD2uriciPdBJnyAxwYAp05qDaba+wlmZvm348ubzFS
         jqc2QkmlzH/KSc8hvglnYnOnR0G8zXasHauDyBI7IlumO++aUYY6+AJugirA3kYPKtqj
         hUW4OMkr0Y/AnM6lBQClDQnL/VtSN1589E+FVX7767elErOKuslbpiiFUJ3aaOItkDmp
         N9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711611775; x=1712216575;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9Z1hl3Voqz4rKbH/aYbXcmA5wCp7kHC4YYlDvX1XsQ=;
        b=eppP8hAXIS+nXSdMBoapF6vWr1h/ThpzIotjCJkv4Aqa5tcv4l9MGKRcWAyMertDqW
         0iosuaKR2+fH2j4BhiLj41Q+wiQJub5awz8kVtEHkTbOhdOrMF6rMuHa9mh9Qa1gO3Tc
         Ab6YYLgEBzCG/JRkcNnQoXetlq+Bi9ioFwdSlFpOzQ8JuLo/1LP+x4/3FR9jW21jA/1f
         wL77MxQpaQEqNwG2OkTCK83on5rJSD9vwavlb8fB8OAm1JwgROkWgsFgbiWj28A78YjI
         wyX97N2R2c4qlamSo/+Y3B64/p5S6KETFczFFdAdvDUokKHHAktKrGangKujuT2jgt2t
         QKNw==
X-Forwarded-Encrypted: i=1; AJvYcCVstaN9dMP8G84dzeQIgs0gtOYjZBq7s8WpblMawA04TFsjabwGqPo8ipw8ruuznHl+uZZZ5LxljchwWd2XvwURS49LmXIKg8NhQ9Uv
X-Gm-Message-State: AOJu0YwSWvwx4eR/H8iCBytDh7z4f0aPA0hwHGva0k1PO6lxPIWMK6X0
	10MuYoFOAMIn8owahKp+dBsj4e35BxMC2TjEbTdlgbPZXU7CL7V185fF9g/P9Po=
X-Google-Smtp-Source: AGHT+IEn1uwQTxgQZwYHfKejub4W7DzhIEQCVx8fpRARAzaog7bFVr8dcc8Ld3RH0v2OOStWQi5bAA==
X-Received: by 2002:a05:600c:5246:b0:414:24b:2f4e with SMTP id fc6-20020a05600c524600b00414024b2f4emr1091644wmb.39.1711611774960;
        Thu, 28 Mar 2024 00:42:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0041408e16e6bsm1392429wmb.25.2024.03.28.00.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:42:54 -0700 (PDT)
Message-ID: <c89aeaea-f575-4514-b4cb-a75fbda2a6eb@linaro.org>
Date: Thu, 28 Mar 2024 08:42:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] media: i2c: imx258: Remove unused defines
To: git@luigi311.com, linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-2-git@luigi311.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240327231710.53188-2-git@luigi311.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 00:16, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The IMX258_FLL_* defines are unused. Remove them.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Your SoB is missing.

Best regards,
Krzysztof


