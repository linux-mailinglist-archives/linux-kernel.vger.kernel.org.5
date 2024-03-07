Return-Path: <linux-kernel+bounces-96037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6A875665
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2351C20FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418BD135A52;
	Thu,  7 Mar 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH7DJt4U"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352411CABF;
	Thu,  7 Mar 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837512; cv=none; b=U0vYmHtiSSBcN+qPKzulj9B+lU9WV3Hvd7XgpZmvLQdO0EoSgA1Bw2YBtb0o3rbl0pYuPQHXVCfBwGPbJk1xlCri5+83RMnLRDJ7UM3NTuezjZxCgWEozcrocMR7KoKjYQV9Ttt3y+HJwGh5ctnnERMtrHmdpQXq5IOOUBmi+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837512; c=relaxed/simple;
	bh=N/1LTd3Vcx75JdIJEOJGneBncdExkJ/dSla/9DpX4Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUFThnsKOgAzBwWTiYqJbCuHi1LreEPXmW6CwQHjgBXBSxcFhAePXS1b5i9qMnfwJXG4DbYD2cVu+bVNrie965bSEP/+ExOQUgdkOEgcnmfIvJngh90yq0s1HANFImo/N6obbA/mvLKGqNJmuTeHf5FTtm0UZNetYf38EuVNlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH7DJt4U; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e55731af5cso41735b3a.0;
        Thu, 07 Mar 2024 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837510; x=1710442310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUyNKrc+lz+/7kEV9cViNqymoVTf2ZJi7Os2/FxH13U=;
        b=hH7DJt4UnUoUoi7bQFTYZSZpi+v9hUZtqy1Js1qg5YI2pipnv89zuWCoUg55Ko3p4b
         JbV7ZM1jkk6CTYsru7Wx8Ul1xmVKzQcFsu1aMXvH4DAunRl12sZhSi0fXvPSmRCfnLuJ
         8Rzh+NE4jClhSzxqEmRksPrQCYGzS6t1lg6D6mztYwZlKYztdJfcCJkM+m/L0PaBKbNz
         b1Tad9qJusoYtCNWXyJ89avzp8p6mcEIgLhBXpAVY5K9E9gmA5nTHlGveJsmjqJ5eLGO
         KPmgRmTderPNsNBoN7ziahiHHDazbW/TTLzrriZEKyL1L40u07ViEETGE0/+j1fVoq+n
         TOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837510; x=1710442310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUyNKrc+lz+/7kEV9cViNqymoVTf2ZJi7Os2/FxH13U=;
        b=tmdpGWrE9fJ8QFhWIAnt3bACvZu7t9tEdsfzTvi/B9O+x6jMo4RLuOcATZhdxNBPUk
         Rp61W9j2Mz4KZEpw+oJ4n+kzE36zTRJQAyfj1OOk9hTiPxMvRskZbyejSgwTB2uZbs0Q
         92+LzXooGxZQL4mmUnYLdLqVCNCwCS/v5W9r4oqq+mPXB/sbh0MJ2/DLD5Mm8nTj6F24
         JlSMfCgGpgKHYqtyvhNKf4Cn/xnQiaeVC7+Yp6vGwG3+3CeIZBFxQ4QLSuPcdQV56pxG
         paeqD1MM7pCsUC3iZtx+NVXCA3rEoOaq7PnpNMJ8CXp1zofr7cRjMXOCQejKgUPRJA5n
         1VWA==
X-Forwarded-Encrypted: i=1; AJvYcCW9zpSlVBdpWSaNh+HD/a6cb24eeZEMlNEhH/w9mANrpPkrdNJEVcTeD5VPt2n1c/7SVvr1Dk6FNJReiFgFhmreswwPlPBLnxs/2rjjNzsNIO0xoQekknwBoaX/buZKU10cb5hzRxaXQ+yI2IfxKNYRfxp0hGB7o6b7uQa5c+Xh/pTuW7rVkydvTUlxMowioEQrGsH9MTKzOke5DKrmp5wy1ywtQKxvc0SuZn+ua/TdoaTBGry6PIma+3+T
X-Gm-Message-State: AOJu0YynhRBrNWq/RkUHmSUr3ik87Ywjv0e1FRMbgOFWopmtDai6+3ty
	ZFdJSU7N0nO7ARz6snF1qI1+ToduW73+jeU3i2KuHW7jFmU6eVN+KjOcQpAM
X-Google-Smtp-Source: AGHT+IEvg54j22LNv7F28r4VAgw0h+HzFUEmPHt76C0lDF58wlsi+HlDriKXzvLhKX2N54XOqkpkDg==
X-Received: by 2002:a05:6a00:39a6:b0:6e5:8fad:6f75 with SMTP id fi38-20020a056a0039a600b006e58fad6f75mr19634198pfb.19.1709837510258;
        Thu, 07 Mar 2024 10:51:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a635706000000b005dc98d9114bsm13225403pgb.43.2024.03.07.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:51:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Mar 2024 10:51:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, corbet@lwn.net,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH v14 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Message-ID: <771b185f-98ee-475d-8075-86399b3dfe09@roeck-us.net>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221104025.1306227-4-billy_tsai@aspeedtech.com>

On Wed, Feb 21, 2024 at 06:40:25PM +0800, Billy Tsai wrote:
> The driver support two functions: PWM and Tachometer. The PWM feature can
> handle up to 16 output ports, while the Tachometer can monitor to up to 16
> input ports as well. This driver implements them by exposing two kernel
> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> existing drivers for controlling elements such as fans (pwm-fan.c),
> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> provides sysfs interfaces for fan.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Applied to hwmon-next. There was an outstanding suggestion:

> > +static int aspeed_pwm_tach_remove(struct platform_device *pdev)
> > +{
> > +	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
> > +
> > +	reset_control_assert(priv->reset);
> 
> This is already done by aspeed_pwm_tach_reset_assert(), looks like
> aspeed_pwm_tach_remove() can be removed. With that, priv->reset can
> become a local variable in aspeed_pwm_tach_probe().

I'll be happy to apply a follow-up patch making this change.

Thanks,
Guenter

