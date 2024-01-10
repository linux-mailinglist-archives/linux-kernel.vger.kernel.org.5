Return-Path: <linux-kernel+bounces-22072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442AC8298C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67161F29D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C24778F;
	Wed, 10 Jan 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="owOMXJMe"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702B47F61
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40b5155e154so52315205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704885632; x=1705490432; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vlqGHcDi/Sy4uBIl5Jnr3cngTZ3e/jHWYQNYtZZtTZE=;
        b=owOMXJMeofa3oGLWuav2HeouMg7Kk20O8ydAAjBLgIwIHRLxsyOqgrY4eHB7GKGzIX
         rQVLHRUnfg0DIPb5rH4VJn5wN++fX73XucgaZkA1bFYFuAeVVYF5jnGYZC+JUnCdPKFV
         zrdJ+tNvYZ8xDqfcaJwY3zpayAXwPKTW7vdWvk3Lp7TAnx5hoK4a9PiWXaspTo8vba7+
         F7XWJ4EpkA+o7NPAD3HrKuV0cxXDRYobTSnzIHDFhMQVMQrRG042F4t5hkOcSS539m1t
         Fm3rcLi1AHCq0OS/3D0zn4IQAw8LabfUN9At4RKrDwpsnIpqzRsKB/nESQzI1kWweHP7
         skaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704885632; x=1705490432;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlqGHcDi/Sy4uBIl5Jnr3cngTZ3e/jHWYQNYtZZtTZE=;
        b=CI3BT5CUOlOWLoC8ejCEj7UeFKRmoW9q1FCRsmfWEn76VahiYy5MDKfSUZWxXv5LZR
         TDh5Df4osh0Y7L3hb3hQ8NY8df50Z7jpvw68hXSYsJMwFnFFwgWXh8wnxIXM3/1ta6Cl
         iKGrZOvNIIVSDiheLBnDRf4S/V1r9nL5H7b6YOclWDZCNHshV6CIqwR4LHzcyQ/sSzDF
         Ybe17gjAWSal1jzCrQyO4DJA+1NL1T1bsGH2IPEmaeCsXNplzHa51FhkVbqlK/+swSPI
         KRZ2QL397YfWwjKHerOEV0dfhF6FvQ+vf9PQopM26tuKIcm9d4kjeyxAkHlMVzm010OW
         MUIg==
X-Gm-Message-State: AOJu0YyoPBUugr5teX6JRbWkfBSkxodDp7DQKViQIICgZKT6tsN3zgQU
	xghAjDQapasgp7/dNPAnvLU40wf/im7vRQ==
X-Google-Smtp-Source: AGHT+IHbFpGfeZfC9AI5PuT+WFKOB6Wfi932nxWEAg0oL5APRSxrD72gbhMFpBecRdk6idA3QUls+A==
X-Received: by 2002:a05:600c:198a:b0:40e:3b3a:aeb0 with SMTP id t10-20020a05600c198a00b0040e3b3aaeb0mr455216wmq.156.1704885632252;
        Wed, 10 Jan 2024 03:20:32 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:9eb:66c9:5f1b:87ab])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b0040d5a5c523csm1858810wms.1.2024.01.10.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:20:31 -0800 (PST)
References: <20240109213812.558492-1-krzysztof.kozlowski@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mark Brown
 <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: dai-common: Narrow possible
 sound-dai-cells
Date: Wed, 10 Jan 2024 12:07:30 +0100
In-reply-to: <20240109213812.558492-1-krzysztof.kozlowski@linaro.org>
Message-ID: <1ja5pdzb7k.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 09 Jan 2024 at 22:38, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Instead of accepting any value for sound-dai-cells, the common DAI
> properties schema should narrow them to sane choice.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Adding a constraint solely based on current usage feels wrong.

A DAI provider in its generic form must have the sound-dai-cells to
provide one. It says nothing about how many parameters an actual device
might need. That is the idea behind this binding.

It is up to the device specific bindings to define that value.

If restricting things here is really important, defaulting to 0 (with a
comment explaining it) and letting actual devices then override the
value would feel less 'made up'

> ---
>
> Mostly sound-dai-cells are 0 or 1, but
> Documentation/devicetree/bindings/sound/amlogic,aiu.yaml has value of 2.
> ---
>  Documentation/devicetree/bindings/sound/dai-common.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/dai-common.yaml b/Documentation/devicetree/bindings/sound/dai-common.yaml
> index 1aed2f0f1775..6db35887cbe6 100644
> --- a/Documentation/devicetree/bindings/sound/dai-common.yaml
> +++ b/Documentation/devicetree/bindings/sound/dai-common.yaml
> @@ -13,6 +13,7 @@ allOf:
>    - $ref: component-common.yaml#
>  
>  properties:
> -  '#sound-dai-cells': true
> +  '#sound-dai-cells':
> +    enum: [0, 1, 2]
>  
>  additionalProperties: true


-- 
Jerome

