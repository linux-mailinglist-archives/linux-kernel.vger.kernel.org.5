Return-Path: <linux-kernel+bounces-145888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D924C8A5C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDF61F2327C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107D156972;
	Mon, 15 Apr 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOt0FiRv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC06CDC2;
	Mon, 15 Apr 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213993; cv=none; b=AMAqpr3hVu9Cx5tuUaNN91dtqSVWvNtYVCgMAGyJO0j2l5740fxB/R2ZmsKsGCuQINQR7Gy7Mo2MZwPFcHUjLEuDWO5bT755VH03KvEbgByP3I31lNOWjlu0Vcwpnvkqck+wiydMlDa7BL373IClHWjcAvKXPaXUiEn/U3zFPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213993; c=relaxed/simple;
	bh=DXWvgmZ3OBUiLaT3J5TtSgfTI4GViAYB4pLbra/t6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtVpYB9mddgSkXoyip5B7/6M1y7bUyhIQoEGMgLGMQudORMngcdg+U8Z0+5askb2D4ASImTC8twI5an+Dz1P81TrFKvTrDEBwgGNoSq5nJakkC0/Q/sbOYf017ZcIFpDPMuYhiqsYyIwIqSdFsGaO/G1W61AwKMs6jTK9Prw8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOt0FiRv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417f5268b12so32009635e9.1;
        Mon, 15 Apr 2024 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713213990; x=1713818790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQH1fnHdxuhfyl8z9lLAyiPd+rF+Qf9RWJEuMIgG794=;
        b=iOt0FiRvRjSCpc1AZp7qDi5IzJC71f6WzgNt0Rht4ZxeHHE0QOaVpjE5+RNClXDLqq
         /8M6KBYRP0S/wv6SixaJ0sKL2+9ccZa2HDn6cjfCpTRiNRlb5NQAIgXCyTy1BrsZuRI/
         U5N+4NL9c7IA02tJ9T+bpmVnWP5ynz9pQQ4H5/BKAE1wS3oXy43mBk4AJSa56QOncT6a
         MpTpyQ0z1Bq2Glk7S1bnKSK2ypdgHrGKfi/1zwAZsvnIEGPdh0sUL6QKXiEAk6fWE0yA
         7F79rC600GkqVGL8LxTP6IE1m6zbwTRF62Fo1COMiA0zA3ZZslhBjx5yizTFpqYt1cZT
         CBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713213990; x=1713818790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQH1fnHdxuhfyl8z9lLAyiPd+rF+Qf9RWJEuMIgG794=;
        b=YPzKdYjUAoco9Fy5BzCVM5U5MBH70ls01xylfn/R0/weRg0mjQnP3Bg+1oSAwO4X7m
         VOFyaiZdf6IeEEZukYhkSLnweNjnf1eM8QEk8NtVFlwO+kp0jf1MUgpETnu2NW9KbZ2g
         OzD0PWqqahHBQ7Shswo6d35qSrjPeF0TL+VczlHW9fC7ouj+xfxwA4Y4XFnYPplzirZT
         DNLGknjMI4bGCZ2EqsxxiiulDAIlBQ7KC3eqVv1DZs8IMobIDBCQXDLIAHOAToDGd/wK
         XW7aWEpq22+vEIH84f3xgI+1YzmkABFJhkRYa2xwveOsS99oxLww5+/ROOWMhHItVSWG
         A5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVOUI47TwyTWhrsff18GcgyEWzwNsUuqqTnLZg4Ce3hBIUqtLr2+qOgwcsiChE3rCxuc0oyvIx6nSKibZogfZ8JCI9SulGeWIg7gBULx35V3BlpUCs2Y0mWxCyZh/7VW0oHRYUhP63F+ATzvdniDS8fo2rxy5uvm36cnTavW0E1ilKutmrR5QMiS5fOUYEFD/Axh/D4lR9jiLrRIFQR4YMD
X-Gm-Message-State: AOJu0YyagyNuW/9Bxxuf9DhWYghIqZG7T/GYaYaZfyAp32EQzf4OfUvO
	QikVry3EO8i64FKrL2DKEUJDqUpx6CeCKdkk3hbnvDXnJvMDGFIg
X-Google-Smtp-Source: AGHT+IHz0wOP7okRZmGKnlB9cgbQaWoJFhJdoBH0pyaqWvuNkIdpW8kz8KDqkPKRxlBdxvcDsLAroQ==
X-Received: by 2002:a05:600c:4f87:b0:418:1e10:ab6f with SMTP id n7-20020a05600c4f8700b004181e10ab6fmr7029506wmq.35.1713213989864;
        Mon, 15 Apr 2024 13:46:29 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d4534000000b003434f526cb5sm12938715wra.95.2024.04.15.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:46:29 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Aren Moynihan <aren@peacevolution.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Ondrej Jirman <megi@xff.cz>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Willow Barraco <contact@willowbarraco.fr>
Subject:
 Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add regulator for vdd
 supply
Date: Mon, 15 Apr 2024 22:46:28 +0200
Message-ID: <2319549.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20240414175716.958831-1-aren@peacevolution.org>
References:
 <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 14. april 2024 ob 19:57:13 GMT +2 je Aren Moynihan napisal(a):
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

Commit message cannot be empty.

Best regards,
Jernej

> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f6e22dc9814a..db35e239d4a8 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -29,6 +29,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  vdd-supply: true
>    proximity-near-level: true
>  
>  required:
> 





