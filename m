Return-Path: <linux-kernel+bounces-73158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C0785BE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982AD1F21065
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019F6A8CC;
	Tue, 20 Feb 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtOuoA8j"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC866A35B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438273; cv=none; b=J59Q0ELsycWunqKvj4welERbxoKwXKptO5Zj+0AorGxOjEJ71rxppwEn2XwsDUfavR8fTegeLdhftlFld7M8faOeLN5hUN/MWmLoW0yWnFOaRirl81uB2oxyFWbcLGHeyWK6Z/kEzq0mEJ1B5lFBR5UdzbGYcLa4FGZxl0weUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438273; c=relaxed/simple;
	bh=DoDTpH52fG/xa9JYP7JIk5GojpXoFXs7XhgACpgYZoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRkY3sbqatEOJsY7Mqn1H4BJayedxGUShYLjFt411Gr3QAZF1hggdVQu2wAliIwPvd8v/zp2utkGFIf30Bjda38XZgIjxX3hiWKCt7NtICWX8sahn0ivG0hRrYZ81J910LXMmRASCZRpN/VF0qaTbKesoAA/vBMyrWQHTeIkqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtOuoA8j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4126ea3b6fcso5443325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438270; x=1709043070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYAwDAwFgnqBG7CxkptbcyQsBM6DtwJYIQlGTNsuuGE=;
        b=MtOuoA8jvtt49h63j6TQEYV+ueHDmktflInByjI7pu3IOcfGUKQplLp8T/QtsPz8lH
         93NBfXIHBNwA6PaQYgeUzROW8Z4Iq/dOsEkO5kDwapdIFD320Gk1gpoaT+85uOe9upQv
         p35drCVWTw2J2i1oNkX0falGJwuwhqPVcNeNHdcK4o/VkeEC2m2OKy8XpMrhQ7MLvRy+
         e6W4wZKLtgpi2P5rWmGfJ4judLgOejxTmPTikyZxgAkjORzaZASBtvf7K98ghmFeox6W
         TfmV6QcI6+SuhcO6twx7WQJ54aKkRKljPbrcvpYHXNF4pAJBnkM8oM38hcEsjbQR5eC7
         C3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438270; x=1709043070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYAwDAwFgnqBG7CxkptbcyQsBM6DtwJYIQlGTNsuuGE=;
        b=GqPwzkYCVrN/Y5pS3tL3EfSSGZciiTLYHyo5FjsW2HrYawfUQhcsCIE0lotTnwzkQT
         Uu1+dYWxK84DNq4Gd92TiUpEzz9EZS/QulSd+oRbExCHAPE6pFxFQ8zy1IaHgvDA69Z3
         ezE5IbAhX3X/EKwa9A05EU2nGgZaOlv90rQAMt8waMxBPV7meUeTYNz6oxJwFcr0wGck
         Trem1zwRzj3EBjdA6fQ6vJtKhJkf+pg58jzMYbCbGVHnkeMHlAs5cG6XxPWJqKa2i5lx
         Mz1i7POLwPM4ecqev43Q4RL/UpeooyA6fQdQytp5LW15y+ArVFDmZxTHmFB1F3yVu6zt
         V3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIzsgWTSAM0LxkE+THz6xVrAGc7zwGUXn+9QraOdU4XP8eZynBevO67RcGKrSXfBddu1EasbvS/7nVXkJ49qUHLo707QnivgLaai4G
X-Gm-Message-State: AOJu0Yx9kavfPJH1gNapR9QoNFYRzSDhP4VGZd8pOccqqOOy4ZnR6H6M
	jX+D9/lQqev2ct3MSAmjgf3P2mnAqY/75kUs6BKesYkz59SlpkTnGpOfVKRVmuk=
X-Google-Smtp-Source: AGHT+IH7G6/8AbTda6e+b8uSaQ+ucRuJkJiJ61GD7iDnIPSep0vXQt5/dU86gOTGDRGrdA5ym28B4Q==
X-Received: by 2002:a05:600c:4fc4:b0:412:913:5484 with SMTP id o4-20020a05600c4fc400b0041209135484mr10836802wmq.11.1708438269747;
        Tue, 20 Feb 2024 06:11:09 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bp1-20020a5d5a81000000b0033d38cbe385sm9829129wrb.6.2024.02.20.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:11:09 -0800 (PST)
Date: Tue, 20 Feb 2024 14:11:07 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"G.Shark Jeong" <gshark.jeong@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maximilian Weigand <mweigand@mweigand.net>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] backlight: lm3630a: Use backlight_get_brightness
 helper in update_status
Message-ID: <20240220141107.GF6716@aspen.lan>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-3-9ca62f7e4a33@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-lm3630a-fixups-v1-3-9ca62f7e4a33@z3ntu.xyz>

On Tue, Feb 20, 2024 at 12:11:21AM +0100, Luca Weiss wrote:
> As per documentation "drivers are expected to use this function in their
> update_status() operation to get the brightness value.".
>
> With this we can also drop the manual backlight_is_blank() handling
> since backlight_get_brightness() is already handling this correctly.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

However...

> ---
>  	/* disable sleep */
> @@ -201,9 +202,9 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>  		goto out_i2c_err;
>  	usleep_range(1000, 2000);
>  	/* minimum brightness is 0x04 */
> -	ret = lm3630a_write(pchip, REG_BRT_A, bl->props.brightness);
> +	ret = lm3630a_write(pchip, REG_BRT_A, brightness);

.. then handling of the minimum brightness looks weird in this driver.

The range of the backlight is 0..max_brightness. Sadly the drivers
are inconsistant regarding whether zero means off or just minimum,
however three certainly isn't supposed to mean off! In other words the
offsetting should be handled by driver rather than hoping userspace has
some magic LM3630A mode.

You didn't introduce this so this patch still has my R-b ...


Daniel.

