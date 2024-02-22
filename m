Return-Path: <linux-kernel+bounces-77345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9C860424
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E3828CF32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5112D1E7;
	Thu, 22 Feb 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+TVcWsU"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132371739;
	Thu, 22 Feb 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635426; cv=none; b=lg7sVW2Ntsx9pCkPEEA89w9yrp67QlHkzRrfX5d532UORdx8Fa9D/RH+Npb5FcOljNQrn7zUZHA+rrzrmrbVTEQiLP4Jx2AqM2BCBv8H0IMutAc3CEIuSKomtni44xhJoZConhmYheqbUwopL7xytVvzm+fkNaEH4yiTzGsKrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635426; c=relaxed/simple;
	bh=ZXL/20AOlmDgfRX36Nzj4Pff74rf6CTLJF/MqrlGbAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azjXMUXH+lzE5RNmJVr2Ux7N2c0WEbf2VU6gjhfaRo8Bgnic1lRBQkvtJX1FsTOPHbM1qSjr3ki32v79sxC5/2eOyxhPAMgxyHHJy20qZ6Hvexjz32+SJnKHLJ9DUBTq6RMV5APOrYcGpDr1Mpn0wcZ2/YgKHcg43T8Z/EWpTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+TVcWsU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5654621d62dso66090a12.3;
        Thu, 22 Feb 2024 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708635423; x=1709240223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2R6exNFMuMyEP9Zs0TU701ZxYwzvvvAfOU9DIEkDzQ=;
        b=g+TVcWsUvU38GqV+gwUEtUKoG8zXXRYmpcGGGQrpgtrCCKt9m98Xs2BAPMHqpfOWzH
         kGLQz468V9PM7ArAM9VovH8T0WZ8X9WPp7ERPhWv6/NKQAyd/JK0EoAhgPsrFKHfCfDg
         l5+CGWxkFgmNqX6sXF5lcnXFeTgXkOWhIvZKrAzBRmjEj7Qr8EtIbD9gS1pkyUqpv/rb
         ibU9mTVLZ4en/MpcZydsXod7BYckyd3JlMRIxL21AjiHRXE73n4tE05Gab+VE7Hsmynp
         mlrsH2O2RIQRmHx7jsBcK0bOtQ38Fv27toXMffpmHjnBrFucxYMAVDL0KcKkv9pOg0n3
         NUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635423; x=1709240223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2R6exNFMuMyEP9Zs0TU701ZxYwzvvvAfOU9DIEkDzQ=;
        b=jK9zorFkU730j0vSeb27YkIZRV484ootI7yw006nuVIfSyzo9seCNyBheZRI8jHWL3
         txhJI/QZHf+LLgE1aJ91wc/qVylydn5rXwLbipja7vVJwhp6tAA5djaotKkxyS5B5ouo
         mOABJv61zi1UKSt6RoFD59zqJV/4l9/m//8Uv6kUbEDk9JAy75TsVlM1mWzZ7yRVNVne
         U7Hl8tpqQD2cEJPXjnm5PpkoPQ3Pa225stXhswp8s8MMtPZ3MTJv2t/JBwkmQEHqqom3
         STOQEB4al3F2pawt5+k2saG6D/PFORZzn+TTBfpCKAaXA8MU/4WIKrj/p14u1mFuNWCN
         8z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYRC1oXWkfQE2IGu9dcE3kfWSGp9eAUfvyijQ5M7ovpPvhEl2ilGwn8PI5LJL3Z7bkb1m9184Kb8VDQxLawsisgZ046Yen83RYIQKIKZZoa15MWCF46cWvXt/TgdekvVO+6S/ap3s=
X-Gm-Message-State: AOJu0YxsYlAYssUVDc7IUxxK8u3pfSjglqtUl0zYGXQq0kYUPvhxOKlU
	igbfYq3irZL2SN8kD20voe8eYQlpnF4aJ3HI1lM1KoAXuk9OfcOeCG7+rAML42g=
X-Google-Smtp-Source: AGHT+IE/qvrg3YIq3JMhwgKa7j4LV2SY69KS3EGu1YYakjYgPPsfh2dUaKoCvH0+xzFJkFJVYOeQJA==
X-Received: by 2002:a50:cd58:0:b0:563:e5e0:85e1 with SMTP id d24-20020a50cd58000000b00563e5e085e1mr16447362edj.25.1708635422647;
        Thu, 22 Feb 2024 12:57:02 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id r21-20020a50d695000000b00563f3ee5003sm6120860edi.91.2024.02.22.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:57:02 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>,
 Ondrej Jirman <megi@xff.cz>, linux-sunxi@lists.linux.dev,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>,
 Samuel Holland <samuel@sholland.org>, Aren Moynihan <aren@peacevolution.org>
Subject:
 Re: [PATCH v2 4/4] arm64: dts: sun50i-a64-pinephone: change led type to
 status
Date: Thu, 22 Feb 2024 21:57:00 +0100
Message-ID: <2792937.BEx9A2HvPv@jernej-laptop>
In-Reply-To: <20240206185400.596979-4-aren@peacevolution.org>
References:
 <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-4-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 06. februar 2024 ob 19:13:20 CET je Aren Moynihan napisal(a):
> The status function is described in the documentation as being a rgb led
> used for system notifications on phones[1][2]. This is exactly what this
> led is used for on the PinePhone, so using status is probably more
> accurate than indicator.
> 
> 1: Documentation/leds/well-known-leds.txt
> 2: include/dt-bindings/leds/common.h
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

Sorry for late review.

Please update subject in patches 2-3. Instead of "sun50i-a64-pinephone:"
use "allwinner: pinephone:" (check commit history of sun50i-a64-pinephone.dtsi).
Also rgb -> RGB, led -> LED. Last, please reword commit message to exclude
links and just say DT bindings documentation.

Note that I'll merge patches 2-3 once patch 1 is merged.

Best regards,
Jernej

> ---
> I can't find any documentation describing the indicator function, so
> it's definitely less specific than status, but besides that I'm not sure
> how it compares. Please ignore this patch if it's not useful.
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index e53e0d4579a7..6d327266e6cc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -61,7 +61,7 @@ led2: led-2 {
>  	multi-led {
>  		compatible = "leds-group-multicolor";
>  		color = <LED_COLOR_ID_RGB>;
> -		function = LED_FUNCTION_INDICATOR;
> +		function = LED_FUNCTION_STATUS;
>  		leds = <&led0>, <&led1>, <&led2>;
>  	};
>  
> 





