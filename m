Return-Path: <linux-kernel+bounces-150127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BE8A9AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533FB283417
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C963161920;
	Thu, 18 Apr 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aa54c0oM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2A161339
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445362; cv=none; b=h/baPv3/bHEU25bBX0dSANAc6S6WW1HyVyx9Z62FtZwwpjW9iyxisqYJA93gNOdUOLIZ7vC14DQtAZUQXT22Iy1qlJ1/bCRResDptL8gafWgai2ryG2zq3bILgYvdUnwKYwpa80jIKmyDJQF/6KlAsCp9WDn5RyYz5WTLO18ECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445362; c=relaxed/simple;
	bh=uZrB5vZp14AnyqyXxGpgGZ10yCrOT+gwRlBBTnMyGWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shFYf/JbjGZNIbmkfyYeFacLNAdBmcLQ7kzh32akV23waMRUzFF2SZQdYV1DIJtxvtpQALkrlKbuaNM+Va8RoKP2zRLCXdrjb0HM0ww582CFNelKsxdnX18wa1Yxkkx0mOarNyt8V7fIFLQOt6xmgjElUHj2ZUalXENBroguhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aa54c0oM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso148679166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713445359; x=1714050159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVyPUZzpnAkaHf5uIez6yP0jHFtLyERSTeCCJwCmVdY=;
        b=aa54c0oMddNzgGXnJXlwodm/eQ8VoSD7dIeW86Us0U64DoZmx7UxVWEe6E5HKSK93L
         TU1WXGVZ4FI4b8lXTc5btkBlwhwl30BpsNe+DepYByfleYwMn+okdsAlT8/4wFZC/nJu
         geZPxPtdECgMufIpk4EWTo934m05EHi+eKrB/YMcQ00YRWVHX1X+WdYciHa3zz0PzslV
         QDpuguMQdtlycE8dHhpbs4GRdlma6nHg7LYe2pR3ZP/P5opP3mjsKKXOdgGjWGZ4gl5i
         /kCPSxmW3BJMUuqnFykugK7AAjMw0oL+QR/PC7WuBN7ETarS7hNLW3cpjkSkUhhPnAPG
         7GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445359; x=1714050159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVyPUZzpnAkaHf5uIez6yP0jHFtLyERSTeCCJwCmVdY=;
        b=Jnr+/K5XnXn6oMuVUNL66VGn5gGRjHPrKVlIyN2aszgFES2zy2wEQkgR3q8DLyJBql
         iDn97Nrl4k/FDoV5G+n/YV8xt5es48q0bK3hNbCWi4bgXtZlyL2ezZkDL8Zs+STwLLmi
         59YnJnJ1bU7RG2/adncMpkTCjM5szPYbC2Qj2cHo0qtK/Y4qz2WAXL2PCnD6CB7vpY6u
         kvxc5p463tIBHEN0aQUpFi24J1a1KfRsTNYUBQn+bCspOfoOjdqZpZkpERQb45a+ZU6X
         QQKbhrg1G66XGEvASvl3/j2QMOSi+/o6soYLKNnw/+suGYgbDL6j71K1ozBRaeYmGYlZ
         rNFg==
X-Forwarded-Encrypted: i=1; AJvYcCXe++mFYT/GQ+m85pL7Xkobi7EHKIHAz9DsEJtn1ZwsQxFUflzka4F0XIXL8dqbpzRDyuyAcqMaJmo/rUr3KZAgMHUWJP0+QhwDB3ec
X-Gm-Message-State: AOJu0YyRGtahDpDUtONk9hKCdEJTVVcMa1qkhtIPoy82nMbslqFxm8pA
	CUVXjNvo0iSMIZecLWdAGNAch88jn6hygTqMj3NrH7849vT1ejX6cNZQ747EkEM=
X-Google-Smtp-Source: AGHT+IH0N89eEQyHSFCXfRykybkZDOZuDp2tJqO99tXBPvhuSPwv2IlxEhe/EsNO/07OXybXEnBOWw==
X-Received: by 2002:a17:907:36c1:b0:a55:6135:7ab7 with SMTP id bj1-20020a17090736c100b00a5561357ab7mr2297200ejc.6.1713445359195;
        Thu, 18 Apr 2024 06:02:39 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm794633ejk.57.2024.04.18.06.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 06:02:38 -0700 (PDT)
Message-ID: <57d55af9-33d1-45de-b8e2-ff9ab2e74e4f@baylibre.com>
Date: Thu, 18 Apr 2024 15:02:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] arm64: dts: mediatek: add display support for
 mt8365-evk
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-18-33ce8864b227@baylibre.com>
 <ee8d0a32-b4fb-4fc4-83b2-300f7453d95f@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <ee8d0a32-b4fb-4fc4-83b2-300f7453d95f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/04/2024 12:27, AngeloGioacchino Del Regno wrote:
> 
>> +        irq_ite_pins {
> 
> Did you run dtbs_check?!? :-)

Yes without error, here my command:
dt-validate -s Documentation/devicetree/bindings arch/arm64/boot/dts/mediatek/mt8365-evk.dtb

Also I've done a "make dtbs_check" just to be sure, nothing wrong on mt8365-evk.dtb.

For you, what is the issue please ?

-- 
Regards,
Alexandre

