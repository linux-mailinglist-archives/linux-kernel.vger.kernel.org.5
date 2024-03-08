Return-Path: <linux-kernel+bounces-97422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96640876A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5182D284EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EF40861;
	Fri,  8 Mar 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zcfC6NeS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1F4779F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920500; cv=none; b=a+aWNuVgUQYQ+JCjqGmsSnFICl/FUJxEjGgX9hMzLAhYmoDYu0LlKvudvV4hu0Wz6PQ1qnTGXsG0MDMtT4Jcn69VrWboZQO2fS7CkUFm2w/D/xrR/ZLld31KKD7mcc8rcsNvYxyhLfwp0lrDImCWXKU7/h6On7e8t/CCGcB5P9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920500; c=relaxed/simple;
	bh=PqbYnoeebkLlNwNR80jokddThH4j13xSW/+xyPtw1Jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mID6fMOvjl6i8YYk8WIiGjk2o4idxq+IzuPLDJ7FDef5oONZ/CG/LQDAfEuEk4/fCFXj16pq8cxIffv7EeAB6CT8rGKp0VjnKhEv7YO13mYxa60gowOZ0BXyfI42EMjzhONiFeQnsF0ae8UWxc8am8LBt5sUVYYZwLiGspibHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zcfC6NeS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc75972f25so19432295ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709920497; x=1710525297; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EamBEUqzL9Iiqztd/HotFBvV3nM4Pbfu8Iqoqukog0c=;
        b=zcfC6NeSUDVSOX0DFih3g4kWmr7Ctro4sCUJX9fmd6mc9kgIGqbv6HU9kDYCg8ZeE+
         9/61adcgjPa2mYjYPCHvFC7Z8uWtmUYPC0iw4ubJUGpT3ApskHDtgz1+3CfjVpr8IbLB
         Q+3z3lRAsmgv6CtQfe9M4r4dEx6YE8ZJwyJMG927g2MytjivZxoP7lFxwp0NzNEkxwnp
         5gPJSITjOH9e3nTIv3a5JJ2s+JKFzEE4y8QkHFBV1VjIJU9KD+U3WAf13sNIeUBfTTMF
         FxSslFwKZ6pmWbQPDpm8vMtHxEu2+ewaL6qFgS7LSN614+3MqWV87HWBBTNJOdGHYL32
         ywDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920497; x=1710525297;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EamBEUqzL9Iiqztd/HotFBvV3nM4Pbfu8Iqoqukog0c=;
        b=XizdWDgDIAdEqdVeOIU5Bv5pVsK3MO0ckdsp9W0c0mshzyVqnXzLc4CXt90KlaQCDI
         LgFkB2O1KbCgfrNZT1IEXsuA96yozKUQszBFXT7brLdix8xUEHJ1Tvr/4IY1xuRqmks/
         hAeW7uWhAW+V+HwVud9BzqnTZ2GHOnBxvSRQGeJgRMqmcCV0BZ2VbhGQnFkZt+ZVVALU
         YRDxvVSO+LE8dhCKxRaIF2s5sbtAjGr5osa3+sJGuHqLUzKITvxcxUUkkaAHG4DU05nX
         Veqe2hDxA+Iar1936WO18poAFOs8FUS5Om2dOov9X0114Q/5RIJgr4VameKlEHuMk062
         3fZg==
X-Forwarded-Encrypted: i=1; AJvYcCVKF1pGz2ARaaBMoHD/dyVvEqnvvk4zdQv0ntES2LUAyfsHOSun933RmiigBtjxx9GTqZr6JmQA3fgwaa/Wx5xVacUfgaaU4wGpgFiy
X-Gm-Message-State: AOJu0Yw4yiUm2bgaiXtAA1Z1dMfNz8O9DSbug3qLgnl37QMEvtYjPth4
	q9EsZ4+q6dwaZj3Iz2PgfpFpEyGjZCuzjYatjFjKK85V8jX2F50hXkQLSWnNARE=
X-Google-Smtp-Source: AGHT+IHA4RG5j/V//vGz+610MDvs64AMo45dipHrCspxD7J7JXQra4JvVWAZSTY7TNiNzGWiYg9wog==
X-Received: by 2002:a17:902:db0a:b0:1dd:a34:7321 with SMTP id m10-20020a170902db0a00b001dd0a347321mr14382430plx.25.1709920497123;
        Fri, 08 Mar 2024 09:54:57 -0800 (PST)
Received: from localhost (71-212-63-227.tukw.qwest.net. [71.212.63.227])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001da15580ca8sm16565649plh.52.2024.03.08.09.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:54:56 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jerome Brunet
 <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm: amlogic: add Neil, Martin and
 Jerome as maintainers
In-Reply-To: <20240224084030.5867-2-krzysztof.kozlowski@linaro.org>
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
 <20240224084030.5867-2-krzysztof.kozlowski@linaro.org>
Date: Fri, 08 Mar 2024 09:54:56 -0800
Message-ID: <7ha5n8pq1b.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Add rest of Linux Amlogic Meson SoC maintainers and reviewers to the
> Amlogic board/SoC binding maintainers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Entries ordered by lastname.
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index edbc21159588..949537cea6be 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -7,6 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Amlogic SoC based Platforms
>  
>  maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
>    - Kevin Hilman <khilman@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

FWIW, I still believe "stable DT" is an oxymoron, but I don't care
enough anymore to fight this battle, so happy to see the other
maintainers listed & recognized for the great work they're doing.

Thanks,

Kevin


