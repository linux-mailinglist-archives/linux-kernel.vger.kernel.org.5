Return-Path: <linux-kernel+bounces-122778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF588FD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F5B28BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666397D094;
	Thu, 28 Mar 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gS2ORqsJ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A97CF34
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621961; cv=none; b=U39yBfkgBxzMz1pSOscp6/TvTXe6NiMnpPoSxWC/Zw8W7Y+yhO+I+TNO9Fun78160JciGNILJmRdkwDuaLpkeIoaJeVErICW+0jrkN9sPbwAM7bYG4Yikju1SUFsbE0HrzDgj/cNYYVp74B6AmxeU/8uWtjmU1JO626k1oV+WxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621961; c=relaxed/simple;
	bh=EZ3n+V0QBAi/57I3TL1yZtFThV8d9Nr5Duuzt9FivF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAh8BqT0jzldUw9uKNPKKgwXBHexpALeIQKzxtA+GhfozNgW69ZHPXljc2PTysiOCoGj2DgMDhjwKYo5SPA84S54SAIOFHc1vfxGSDvwTjwOC7SXl+MREwH6fZ2a/8KV3vOwuXVa0l8/bt/31WjyqOh2bKL91MCCOd8MZEIJ7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gS2ORqsJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46ba938de0so103247266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711621958; x=1712226758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7ncvUdpMRSKqWXW0WZYpoDYWoHmMZgWCq1hd7UA6vM=;
        b=gS2ORqsJdLObdZn08vhuwt1UGTAjU+oaoKANmbJaXvAgFKYVXv8AToS0R3EySCEVJ/
         0iABG/JoySg64LGZC3V0+S2KpbCRuGe0ICLbBoVUH5N4eRNOXmxiUim6PPVnPwAdbQWM
         9bbKRehLcjEQsDKSOheF0OOXS3d80dOjWeO7lNxtoFktAG2CgBpIxsbcZXAhH5oJ2HSj
         HsMyuVbj4hIVNt2+kxzFzPakQ6nfSb9S6B2UUQADKUZJ/I80n4PJmljCLCMGwkCr4uPq
         sr0XRUk6LTxXjTcXX9bh7RAuJg7hc6Sx5WHeEeO21dYVR+BdVTogmAAmLR9fdxE5wFJF
         R7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711621958; x=1712226758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7ncvUdpMRSKqWXW0WZYpoDYWoHmMZgWCq1hd7UA6vM=;
        b=SW2x+Z4pkt+vxwLJjYjLHzVZ7X67GkznxCpMfOafA05bri3YYZVnKOjC1QAz78vz94
         xjfR7Io26Ia7LjbaSEld1N8off6ACJs2P/PMdX7mHkvDhrowgspZj/Taz1M3IPD77rZz
         CuCisctk4OMqOeKNHm1XcHtXXb967vTNj27GvxmduQeb5G5rS+wxhbyBBexgk02wmuux
         nCEexSGWHiln//UY41KJnD3dG4rwITn77pvada7JPXZ3H46wU/XXkAmLznQDnfQvuAyu
         UGiJJzGUwMAfWjfAmqlD16VlUk+60IMLSRWDTc2s4u0QKyibYdGq+8qge9/x6oN11WC+
         MMEg==
X-Forwarded-Encrypted: i=1; AJvYcCVWkMGV7rHGZfFjvn/5IOFc5oZ5sccLYJRX/dYUP/7EsWH+mGGoBlz4H9S75Z7feU33ZopDhZq/CkDgDbzC2FjWzMUFk6gsSpH1xYn1
X-Gm-Message-State: AOJu0YxOytdt2B8ljw5Ol1OHJaM+ivCAjv/D6zWxmHndMIXu5dpN52b8
	SO0lSINiGNpNyQwJr1hXiXxarYdc27Hevpop85/1itDugpn5Psr3mttJcs7kMs0=
X-Google-Smtp-Source: AGHT+IHEizdX+YVTFuwat4TDpSt3i7BuuxSRo5U8WSM4vSBPrlRdExLtV+/exHiPQv3bY2iIn3YEPw==
X-Received: by 2002:a17:906:c147:b0:a4e:2349:ef0f with SMTP id dp7-20020a170906c14700b00a4e2349ef0fmr984300ejc.65.1711621957973;
        Thu, 28 Mar 2024 03:32:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bn25-20020a170906c0d900b00a4e23400982sm444122ejb.95.2024.03.28.03.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:32:37 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:32:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, "Andrew F. Davis" <afd@ti.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] gpio: davinci: Fix potential buffer overflow
Message-ID: <014637ee-6d5e-41f9-abb6-d9c56ac5bf32@moroto.mountain>
References: <20240328091021.18027-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328091021.18027-1-amishin@t-argos.ru>

On Thu, Mar 28, 2024 at 12:10:21PM +0300, Aleksandr Mishin wrote:
> In davinci_gpio_probe() accessing an element of array 'chips->regs' of size 5 and
> array 'offset_array' of size 5 can lead to a buffer overflow, since the index
> 'bank' can have an out of range value 63.
                                        ^^

Where does this 63 come from?  SVACE is a static analysis tool.  I would
have thought a static checker would say that 'bank' goes up to
UINT_MAX / 32.

This stuff comes from device tree though, so it looks fine to me.

Documentation/devicetree/bindings/gpio/gpio-davinci.yaml:      ti,ngpio = <144>;
Documentation/devicetree/bindings/gpio/gpio-davinci.yaml:      ti,ngpio = <32>;
Documentation/devicetree/bindings/gpio/gpio-davinci.yaml:      ti,ngpio = <56>;
arch/arm/boot/dts/ti/davinci/da850.dtsi:                        ti,ngpio = <144>;

So it's fine.

I'm not the maintainer of this file so I don't know if adding a sanity
check makes sense but if we wanted to do that we'd have to add it to
davinci_gpio_get_pdata().  Otherwise it would have already had a buffer
overflow earlier in the probe function when we do:

drivers/gpio/gpio-davinci.c
   223          if (pdata->gpio_unbanked)
   224                  nirq = pdata->gpio_unbanked;
   225          else
   226                  nirq = DIV_ROUND_UP(ngpio, 16);
   227  
   228          chips = devm_kzalloc(dev, sizeof(*chips), GFP_KERNEL);
   229          if (!chips)
   230                  return -ENOMEM;
   231  
   232          gpio_base = devm_platform_ioremap_resource(pdev, 0);
   233          if (IS_ERR(gpio_base))
   234                  return PTR_ERR(gpio_base);
   235  
   236          for (i = 0; i < nirq; i++) {
   237                  chips->irqs[i] = platform_get_irq(pdev, i);
                                   ^^^

   238                  if (chips->irqs[i] < 0)
   239                          return chips->irqs[i];
   240          }

regards,
dan carpenter


