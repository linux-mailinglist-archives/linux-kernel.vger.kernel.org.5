Return-Path: <linux-kernel+bounces-161243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B332B8B4969
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633A11F21560
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529373D64;
	Sun, 28 Apr 2024 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXk+XiYv"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C528F1;
	Sun, 28 Apr 2024 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714275008; cv=none; b=nKkHcYhL7AWQ/Z2soE2upBmfUYrX0A0HWmUHj8vm4o6EF4v8t+1eyOVYQ5vKCGr3OqT6JXo2zJE1hmbnXh5zphQphgtAoHLcu7VHehscwXyru61FuB4FjstdIcIdpWOBXdb7R5Z3Fh2PUlrwtkqToC2HdEjNGGlPtMQkRYfIu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714275008; c=relaxed/simple;
	bh=I4zlPiNkPKCqigRDkhVrLgPV52DgP2yPuBfoCuO++rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2V97sLTqsfvxLYZIuFoEqXQ926meWsrsmJaKs/Sq2ylT7dTEEaKcX+AT9U2XGW1ftOWANvyWdJMQRhppo3RMwO9qcT6xIx5du9rhP+L8mSu0U+6toDcqow1Vg5mktBMXLuFJDvv3OFNYM2bLmNVZfpJka1EiJWDeZTj6HhmfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXk+XiYv; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c730f599abso2090143b6e.0;
        Sat, 27 Apr 2024 20:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714275006; x=1714879806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ5VTPH2nor9MJto5pDIHRFuErP8fLZdpGXB3ZZ2RNE=;
        b=QXk+XiYvVbsqr0lwnEEsHbmHUMBNzhiSObG/8O4TN38qW8/NfPT6D/AibC2KcKvKti
         NPqX22tVgfwhdQ5Vj2y4gozh7y/cexOeg+Q/2ycwiIJ5PSFelzxLOQbnHMtUbwhBqYa7
         GIzhVhqJaTj1YT0TiOiYgotqrwnfQltZE10SQqG18K52JRKnhRhtLKgZwaArf3TXkPl4
         KKJuF1RgnPZ+L9u9utA8Vv/wfgEL2Wwi6UlszsTRN9sVKJ4352GO0SkR3Gfnnbtcf4jK
         /86OtKlAhzEqcOEkhlRlpuAtZHitnDltXpG7mUh6umv1ICvc1nSl0wYes6uhNF1igwWC
         rAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714275006; x=1714879806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ5VTPH2nor9MJto5pDIHRFuErP8fLZdpGXB3ZZ2RNE=;
        b=B3lgKJgrq6ZpncTBy9bjx07aXWvhTtAg7yHq8XT3Sy+LK/6mYyXmxcxzFMmXtmrVh1
         PoW59lXM6gixKGKooQy5auwK4ZvD9IzqDL7HPLJVSW/6jTy0qg1wl4g58+HNr1XYVQhF
         W10fgPkjAmqdAUKJWWYpUyJn81BIo22HsDh9agvGeoC1xEWuRkvnuXFF2aQD4vBH6y/k
         c/GVGIWIUomdl4MFshTHQx6wOpsHoNK7KiK19ozOF0D15TGAu9xEGk8AJebAn6to9dbi
         AJ0/yNnGMTaagQXPn2h6AmA+NoNxlWOoVL7iKGupR0COIRMY9FshnlDJCLqNR/uuDEiG
         JAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUWHKVYPOzJBY6fXbpliFAOc6tpETV59UboQIfQ7R/jiGbAW5Wy8B63u+hbIGkBtIduPQapYP4wtfUKC3Bgf5O4qOgD01Niv8DH6ve7E/jOjggIYixs4F+PoFbxJJRapJoIKANUZMknEjEMTDCCeI8yW+lj6HeFMuZAPwvulJ6Du5GcfW/b1xA=
X-Gm-Message-State: AOJu0YxcQb65YJLzcQfLBmxqFO11y76pOcah817fxfhJOSkhETfA1rma
	0Vuk0HhwQmqgW/4CpHgoN7LA6oaEb58/NPP2NAp5Wi2Y8wJdqH8u
X-Google-Smtp-Source: AGHT+IGJkj+yYHDRxtFh21/KcaEEA+iw75QHG9gavNpfANp/PSWXvk5mSppHJic7qjN9s62bkRVoDQ==
X-Received: by 2002:a05:6808:1594:b0:3c8:41ed:8738 with SMTP id t20-20020a056808159400b003c841ed8738mr9142094oiw.22.1714275006042;
        Sat, 27 Apr 2024 20:30:06 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id a8-20020a62bd08000000b006ea81423c65sm17563901pff.148.2024.04.27.20.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:30:05 -0700 (PDT)
Message-ID: <89aa81f6-8945-4448-b298-b66ec4d386fe@gmail.com>
Date: Sun, 28 Apr 2024 11:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/panel: Add driver for Synaptics TD4328 LCD
 panel
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
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
 <c792a2dd-3183-4d39-bda5-4a8c30a476ff@linaro.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <c792a2dd-3183-4d39-bda5-4a8c30a476ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/24 23:58, Bryan O'Donoghue wrote:
> On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
>> From: Xilin Wu <wuxilin123@gmail.com>
>>
>> Add support for the 1920x1080 LCD panel driven by the Synaptics
>> TD4328 IC, as found on AYN Odin 2.
>>
>> Co-developed-by: Junhao Xie <bigfoot@classfun.cn>
>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> 
> checkpatch.pl --strict somepatch
> 
> CHECK: Alignment should match open parenthesis
> #207: FILE: drivers/gpu/drm/panel/panel-synaptics-td4328.c:150:
> +static int td4328_get_modes(struct drm_panel *panel,
> +             struct drm_connector *connector)
> 
> total: 0 errors, 2 warnings, 1 checks, 269 lines checked
> 
> ---
> bod

Ack. Will fix in v2.

-- 
Thanks,
Xilin Wu


