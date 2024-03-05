Return-Path: <linux-kernel+bounces-92493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515887212D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783841C22BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EFB8664A;
	Tue,  5 Mar 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THeV5zfz"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE88615F;
	Tue,  5 Mar 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647908; cv=none; b=oJPTyxbXknyKpfEBuNSGzZaCCQd5ZQscXSmiePKOy0DYZwBqrnV7EDZJStIE4q1EKrtUf1S/zRaPp1Y5LgIFNjuwTU9Nu0NbeM+aB8uKxuwAl7VefciVrj7LmEKAC82/fsliSRURlDQYqq5brkHXNLx4tUZpR+1BljhQiqK8mz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647908; c=relaxed/simple;
	bh=l87FN/S7hYBgOYZ849x4u4XP0S9wnn3Ph0dNs7/oyLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDnVjPpZfv+brcL+l39o5faEt8kEsPNj8JmrJmqaaPdXvQAKhCfpYRMaiAJirppxmi3j+uIxsQv8NBPXrrGX2znslHjyqjt/muVqLB5rs+ZMgNTwVKEAx3jTJxPjOxIk3j/PrKki8EByqk2ve2wgF1tAZ2C7AYjogqB0lyg8n+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THeV5zfz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so4103666b3a.1;
        Tue, 05 Mar 2024 06:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709647906; x=1710252706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ptWYKwK26XO+pPKZk7491w2CRd3K9UN34Kmlw2Ucys=;
        b=THeV5zfzEnAhhzjTM9rHS0epw6LX3nadeJI2cDySQzv4somQjRGPVOSg0QUy33XKBF
         JabVZHVRI028wfrOWtkhDHk51ZfN5uPEOyw52m9MpyyxWZcCuMZOdePlPPzawBQiQR0G
         5u3DEWhtyGR5HdNqhtJjkYFjqZKFpIHr4ZUaqOpzoIUahRz0JBXrvBBlYS7VikAUtwQ6
         I/6bBp6Q+8GK7fM689eGGgCxGdPcSZJkKUcm3XSj/BPT7xTp/eswX/lzVJ+4nzJxZG8h
         lVUGVVRLT1lsEycRyucaLW9i/bJIYDoN29duSdZoKslKS0BoadEvWY2reX5s0pfwNckR
         0Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647906; x=1710252706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ptWYKwK26XO+pPKZk7491w2CRd3K9UN34Kmlw2Ucys=;
        b=tuK3NAwy0M/KE3RwKp5Fzh/zdtN+mITnVKqslAgLi8nTD4kybIgngI1li2lBuH+Enu
         A7Dza5N2Ox4PkmdTW2hYgVl1QNbbC4ymJ4wNMMCACRI0YrSrMbEyCPDm7S8leqbBmotH
         D5GvcZwKBepW197Rndz6iut7m/W9PK1jdd1eZqMno4dvGzU7J2nkbP2IvfFurkE7+/th
         w9tultnKSps6V4jxIk3df5bZ5qBuA9EDjdB0g5qXXvxq+E1EOCGBF4nB1gDsdi7xEALn
         /e0LdzacfnaTTCoLX1Cuyr/oAHDwXmP96khjZsJgmE638/tLJSooAd/F7ZbxbnccJlmp
         Ju6g==
X-Forwarded-Encrypted: i=1; AJvYcCWGu0aamlzxcQr2NLsHZp8sa99QY4SeYP3DMh0sL42Wt+IE7fhubsXMBvKZ81lMm8Z0QcmGhBSzgJCEyd1ER1tjrb81y/NUGuUbu1TDHdEvtlX1thVmr2FA20oYxbCd70elSAAJukMcZa35jqg4mfBrh4htBnIGyLj2JYcbfa7+ZWCcvA==
X-Gm-Message-State: AOJu0YxiN2z0jA83blyIhJ/0f+YBcN2FAHNPJsmcYo//GeO+eSC94Fxy
	5k4j9H7mSNwfgkvdztekhDI9EDdjNaeZC6MJalqJOAoq9nBQI4V2GEVOnHxYGFpt6M7WViUvnbn
	B24wii6vYrDQC3Oqq8ib9gq9ed3w=
X-Google-Smtp-Source: AGHT+IF2u1CS/qzzW2dSsR05vsnKkZIimUbzC3oZpDvZ2seDKjLb26oGv8Iks7gNcsCttodsxUxVKire2jLC4A0eqp4=
X-Received: by 2002:a17:90a:ac12:b0:29b:36a8:4742 with SMTP id
 o18-20020a17090aac1200b0029b36a84742mr6761437pjq.13.1709647905647; Tue, 05
 Mar 2024 06:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305135903.3752568-1-robimarko@gmail.com>
In-Reply-To: <20240305135903.3752568-1-robimarko@gmail.com>
From: Robert Marko <robimarko@gmail.com>
Date: Tue, 5 Mar 2024 15:11:33 +0100
Message-ID: <CAOX2RU6ciO1dTPTxA2E2v3FVH7y=BLM1tR05XN2rj9tKMEvZLw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qca807x: fix compilation when
 CONFIG_GPIOLIB is not set
To: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 14:59, Robert Marko <robimarko@gmail.com> wrote:
>
> Kernel bot has discovered that if CONFIG_GPIOLIB is not set compilation
> will fail.
>
> Upon investigation the issue is that qca807x_gpio() is guarded by a
> preprocessor check but then it is called under
> if (IS_ENABLED(CONFIG_GPIOLIB)) in the probe call so the compiler will
> error out since qca807x_gpio() has not been declared if CONFIG_GPIOLIB has
> not been set.
>
> Fixes: d1cb613efbd3 ("net: phy: qcom: add support for QCA807x PHY Family")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403031332.IGAbZzwq-lkp@intel.com/
> Signed-off-by: Robert Marko <robimarko@gmail.com>

I will resend this as I sent it targeting net instead of net-next.

Regards,
Robert
> ---
> Changes in v2:
> * Reduce the code indent level
>
>  drivers/net/phy/qcom/qca807x.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
> index 780c28e2e4aa..672c6929119a 100644
> --- a/drivers/net/phy/qcom/qca807x.c
> +++ b/drivers/net/phy/qcom/qca807x.c
> @@ -732,24 +732,24 @@ static int qca807x_probe(struct phy_device *phydev)
>         priv->dac_disable_bias_current_tweak = of_property_read_bool(node,
>                                                                      "qcom,dac-disable-bias-current-tweak");
>
> -       if (IS_ENABLED(CONFIG_GPIOLIB)) {
> -               /* Make sure we don't have mixed leds node and gpio-controller
> -                * to prevent registering leds and having gpio-controller usage
> -                * conflicting with them.
> -                */
> -               if (of_find_property(node, "leds", NULL) &&
> -                   of_find_property(node, "gpio-controller", NULL)) {
> -                       phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
> -                       return -EINVAL;
> -               }
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +       /* Make sure we don't have mixed leds node and gpio-controller
> +        * to prevent registering leds and having gpio-controller usage
> +        * conflicting with them.
> +        */
> +       if (of_find_property(node, "leds", NULL) &&
> +           of_find_property(node, "gpio-controller", NULL)) {
> +               phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
> +               return -EINVAL;
> +       }
>
> -               /* Do not register a GPIO controller unless flagged for it */
> -               if (of_property_read_bool(node, "gpio-controller")) {
> -                       ret = qca807x_gpio(phydev);
> -                       if (ret)
> -                               return ret;
> -               }
> +       /* Do not register a GPIO controller unless flagged for it */
> +       if (of_property_read_bool(node, "gpio-controller")) {
> +               ret = qca807x_gpio(phydev);
> +               if (ret)
> +                       return ret;
>         }
> +#endif
>
>         /* Attach SFP bus on combo port*/
>         if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
> --
> 2.44.0
>

