Return-Path: <linux-kernel+bounces-157275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85988B0F48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BF41C236E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200EC16D30C;
	Wed, 24 Apr 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQlk58Ly"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C016C840
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974343; cv=none; b=kZ8G4bhMQqpM+s5EisHAC4kKb8Vn8/JA1K0AWYlKafsH0Yco2zAeW4Nrq9muFNiVYdNCnyTQehFOUUrUN/+1nVjsqZNOi1FPswCLySXbAK58mTT3v0AD9l9kcDSZd/MtU7KlW28HDuYTsIKlenK5dsdMhNbD1x0VX2NqAj280HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974343; c=relaxed/simple;
	bh=HzT5H6GlsHBD/eTzJQNCdlBx4zL1yrnsAZGvhWHeeB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkkpV8TI9FcHa2KoOmqc8jj0zrhOWr1jJgBv9n4SdvQSPtwl27RpNilVRcSGgkjHfL5CLOjjo3zzHkzCDsK0cojSBqjl9J/4qx1Uez7ki9d7zrkY/MNprsxRMDGXWWoC3ixc4+hjkNmHAtV/B3UgFc+jY7wuNVNblMNJN63WrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQlk58Ly; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a587831809eso2720766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713974340; x=1714579140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ64wT6PzFAn8qjBgPSgjNXp6jZV103lzTHcm0eFcDM=;
        b=gQlk58LyUFJsBnZMz0E59N0Qw+5TP2snQgdvM5uoyXJWZCMHb/a9poELwGXVyzmsCy
         kQ/99+/+kRferXEIEBR9f/yQPy59iayQliipBEQUAtiJjwAWcx5c0n7+laZ3p8HlMKAZ
         sWuil3BgVoD8KKQqf61SUEwH6e/SPDnKCIVpkHoISxrQBu2Lw/YFIt7Abi1+4k54hKzL
         0EW8iT4O6we+EFJs/auKlZu66QlvgNov/J7jHEXO/3jwy/wfzofWXFy8Xu3h4e9P1NGF
         2ji3+CSE8CfmSnecB0QerQgzRN7YE4CX7VceDKhILZiKrCbKiRjQu7UOi12LISYOIyTu
         8ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974340; x=1714579140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ64wT6PzFAn8qjBgPSgjNXp6jZV103lzTHcm0eFcDM=;
        b=cmWZ97pcjbr5HxH8xZSar5b2SqOMAC+BQco4CMy7cGzcOglRX8KHwBYMp5qXGEAn3d
         gvSdk8gCojmB0swfZBHII2JKOQyRCifJy5pZtWl34IZ670okFWD2XqrhNcKceSzQZmLX
         OrI43Ef+4jmwpJ0MwOaX3CwzMbnd92Bz6cUsYI23bvdbbeNVChdbgVU09PBeihlNcKUM
         1btAOar8n1RhfyGA8vNyd71SZR3nw2r1UhQNdG24+N+5oQRSGBjYSWR7T/pOxEngi+Az
         ZNmXY6VFd+suTqQ2N23C67iBlgjpzZIeCmIQguTTp7HKXijFMW7cG2OFf9kqUrWIUNns
         Gbbg==
X-Forwarded-Encrypted: i=1; AJvYcCVvjYlAPmYKF8oIMkVkb0yWuToJJSDOHyfB1pds4YLMqtsW2tmdyvjSZDk33KTMc7lschnqYZftY6T7zDF4R/33sSHPFMcpdWlLpjbv
X-Gm-Message-State: AOJu0Ywd0KpQmZhQ4QWKBrRWI0XZ3NOSwotLO9LYVjK2raRWSDmnxUdZ
	0odhZxffyxSNCZXq4si0PMcK/F92f6GTa5jAcF4Jal+KKSElJG9bZ5tfIDOfpZY=
X-Google-Smtp-Source: AGHT+IGQsIGDTrEkkFZ0d7BzpTqrals6W9oWwDLo3KADefDZvUVftQF2XJ0m/McclRYDcXaOpGRFfQ==
X-Received: by 2002:a17:906:91c8:b0:a52:58a7:11cf with SMTP id b8-20020a17090691c800b00a5258a711cfmr2030787ejx.2.1713974339977;
        Wed, 24 Apr 2024 08:58:59 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ef15-20020a17090697cf00b00a55a5384f7asm5059033ejb.165.2024.04.24.08.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:58:59 -0700 (PDT)
Message-ID: <c792a2dd-3183-4d39-bda5-4a8c30a476ff@linaro.org>
Date: Wed, 24 Apr 2024 16:58:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/panel: Add driver for Synaptics TD4328 LCD
 panel
To: wuxilin123@gmail.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-4-e0aa05c991fd@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240424-ayn-odin2-initial-v1-4-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add support for the 1920x1080 LCD panel driven by the Synaptics
> TD4328 IC, as found on AYN Odin 2.
> 
> Co-developed-by: Junhao Xie <bigfoot@classfun.cn>
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>

checkpatch.pl --strict somepatch

CHECK: Alignment should match open parenthesis
#207: FILE: drivers/gpu/drm/panel/panel-synaptics-td4328.c:150:
+static int td4328_get_modes(struct drm_panel *panel,
+			 struct drm_connector *connector)

total: 0 errors, 2 warnings, 1 checks, 269 lines checked

---
bod

