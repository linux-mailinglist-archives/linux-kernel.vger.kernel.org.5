Return-Path: <linux-kernel+bounces-48946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0B846377
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EA1C22E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40EF40C15;
	Thu,  1 Feb 2024 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlC3sZBI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21836134;
	Thu,  1 Feb 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826800; cv=none; b=NdbwvVWm7vZr7Zl9uToTMUwPIQocH6ojQ6ZtxOl4K9BNRiE7ieASs3Vpi5M+Aw5EyII3ajGSApUru7s2LUXevtDtU/zJSPWimyWfvGnHwi+evfPFiXN5e4zei/VeGKLNRxYLMVsOSIzeS960KlPU5NCsunwHu0wCPno6GRze2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826800; c=relaxed/simple;
	bh=UIZFij3vX2Sso0FDouOwGC3iXhnc2OgUMZXke142ft4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpT7MWyiOX2XPms6RPFjIYDRJQsxVTmTKjmZ+q7iV+vAwicvEemeBvMlElGVNnCFXiGIboGbVjJ3MoYbK1Tv7sqKL3ZYQ18CzV+1U+pv9JDvoIPXu3EpAyEt1pgRbhjk3KFE4z4y/X2peyak4jDSOtzkj9ua6Cl7Qw4Imrn3TA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlC3sZBI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51134755d9cso271323e87.0;
        Thu, 01 Feb 2024 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706826796; x=1707431596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOoVJvNlIyAZpSKQW2nK0aJiflX1kuB/bEqUHjK+UFc=;
        b=GlC3sZBIkTxI3T0f05RnM9zjR7JSEqtkxR0qok1Zg9hrpveDTH0mJ7OPlpQFoRevS5
         JgT9lov37e1wO1je1nZDznRWieX9NlXf8wXzR684AQJTnIzwEGbtuvEY1lFUq8Uq2Rk9
         NfeiT1NIMDSWTjC41wVBOkq5/sL75/3hnRLlgw+wOPYiLHeFap5C2ZWSPK8Vy3b5UzvW
         +Be6uM4foIKIQTHO6LDqSc53hXajjBLarXprLreZMN0ROMPHITUyEx2Zz5v+MNqWPTqW
         0Sfjv1PFU1+3vkVM8/+NSjXuMis+2ATfb641CYWbUDeW2rOfptN1YGEy0TzxYN5XYjNG
         mA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826796; x=1707431596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOoVJvNlIyAZpSKQW2nK0aJiflX1kuB/bEqUHjK+UFc=;
        b=mHotg2xHQA5mEnmz4dVvYywPA7cHB6aTIwuoGcvVLvO3UqqugTnxM3tvaPvDYTJ3D6
         mQQmKjHMw1TUj6LMt7YcS57USedMgry1CBFlmzYMUX6Dnh4rYUg44iZ13XxEQQ0uUNkX
         jYxsKFGBlk9CX2TrFrH62j/8B1P/6MLzQwO1x7S3GYPPl2vEdI7LYcmyiCFOiS7BLi4v
         rMYJ62Ys3wCGOunQ8vDoBnxqeY8IcZMM2XYz8rpMDJsLTC1OXoWbPlYrT/xd2m1ZEK/1
         +ftsQzYkqQ0J/1ezSH+NOUgKRwS07R9NzO3C4jFmx9ZbUDEzj+0+5IoC5TedwwBu32L9
         ibUA==
X-Gm-Message-State: AOJu0YwS/+RCoKD9LyoALAPcNfOvdP/9olBH3p5kFx8KAzERArwceQJe
	u4sX+kCBAHzgjax+uuSDXD+F8CqvvzcqaBPv/+AhBpM/+la/G836wuqs0QThb0SpPA==
X-Google-Smtp-Source: AGHT+IHsZNYZRvF+ZTQViUHg7CwLt4tXgfEKgX0bWoH7t0K5CTTzwt6LAuBX7Ups5F1iz9FstX9LlA==
X-Received: by 2002:ac2:430d:0:b0:511:351d:6acc with SMTP id l13-20020ac2430d000000b00511351d6accmr185356lfh.15.1706826796151;
        Thu, 01 Feb 2024 14:33:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUdUJyzuPJo0Xs64tfoHzHILjdDsgoPZ+i791+q/qxxpm0ZBcGxWDv384AIbMKsd+5bPvLIQvbalXcUlmIws4jipCbm23IVIAtlnkIeZxcQw67jgvFUSO0vwl6GQ2b2WvopIDROIIxp6kY3Yl/9+TfD74QdjLGxlNPbu47jxKs/cvtqAw7P4X227wXPoFnuCDvxwE0L+IMpPw30ejEJlWVpAKJrRuOYCc92Yudz9m4KCNfOHK9CCuOmd9O8PDldWCc6P0FLNY1UTK8+1tyycvbmUhV7/IYi+FN86iHCrTrQNfrAR9oEdVH/ddf1YTmX8saHBCspqSxdNsjTJNXFOuY8JTpWTCo=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id hd34-20020a17090796a200b00a36f314daa6sm224233ejc.46.2024.02.01.14.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:33:15 -0800 (PST)
Date: Fri, 2 Feb 2024 00:33:13 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Message-ID: <20240201223313.6inu6l6cwg4krapz@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-8-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-8-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-realtek_reverse-v5-8-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-8-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:27PM -0300, Luiz Angelo Daros de Luca wrote:
> Remove the line assigning dev.of_node in mdio_bus as subsequent
> of_mdiobus_register will always overwrite it.
> 
> As discussed in [1], allow the DSA core to be simplified, by not
> assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
> is unnecessary.
> 
> Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
> to mdiobus"), we can put the "mdio" node just after the MDIO bus
> registration.
> 
> [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

