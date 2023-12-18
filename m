Return-Path: <linux-kernel+bounces-3297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89B816A97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24AD1C22921
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9213FE6;
	Mon, 18 Dec 2023 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzBDenRg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF49134C3;
	Mon, 18 Dec 2023 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so32910061fa.2;
        Mon, 18 Dec 2023 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702894214; x=1703499014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YC7nUYxtMAPXUFOtVXTFzk0D+Ha1NUghjTTPnYwUs+c=;
        b=lzBDenRge3xD+m5ur0rDocyPV4wcKtS3SpcNRP1ugzPIn/7WTwlQW02aaHV8vACvzJ
         EMhifKY+aOEtLz5Px6tzu97kVoal+6JtHCHUg2E0psNXxzrZOkqaICxndg7DL7Ga4TsH
         n0S+hIxRWGn+FdjuSeFV2oGRvfRDjProRKgY5EWZ9jNm5jxU93AnAK22PykEzoaph6Wj
         UPaPajaFKT/bGsg/hJsIEs2NJKdwGOOhLVu3ojxRsXn0uUrpA7JaU21ZL0MuZ0F44ITO
         19hJgj8wmIvv4FZExHI2l8Uaib4GGa765sMt5L66YkLggVZLIVN0tzvInQaKYCaEtDZ+
         eh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894214; x=1703499014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC7nUYxtMAPXUFOtVXTFzk0D+Ha1NUghjTTPnYwUs+c=;
        b=gXve+/OLNyDofbC5Sq704Ox8MYHt1DMHAgzzKMRh3ocNDf9N5r9RMkkO2yD/VG4UPi
         iDy7i47F1OECDCuX1hvwIfjgQ6T2q2pqaYFNtd1yFlgDVAUKBIx8nosn/IFSJxm5H2hD
         GlWZ8xzLjSOPgX7f/Go0zISfG3EDteqpJSpnFzDmheTlrbaTRThLhXypmu8+ynu8sH3e
         b91EcGuVNBVFcRvtIxU5umkcaojQYHarwFphN8Ft4Sxm+HQFjMUYCqD2w4u4jIuNDzPQ
         PyAG2gbynllMljs9GVAqg5GB4J1EVLeaq8pyNme/iNYDg25/C7xh2aprxq/jUdfxqT7I
         zRHA==
X-Gm-Message-State: AOJu0YwjoQAxD7fPeGkDdSu5TsAUn905Tkh1rGTUxx735zk3jCg9pdTy
	UlKh/M2BgB7vBdRHMnr2RqA=
X-Google-Smtp-Source: AGHT+IE3EVLnFggdzYIFxGY/O4qZvTMXQtcau7VkqurJWHdYJ1W+qQxqmBjun1z1ouLDhPHAtx2Kpw==
X-Received: by 2002:a05:651c:1a13:b0:2cb:314f:c300 with SMTP id by19-20020a05651c1a1300b002cb314fc300mr6926538ljb.27.1702894213998;
        Mon, 18 Dec 2023 02:10:13 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e15-20020a05651c150f00b002cc6b5ab63asm552635ljf.119.2023.12.18.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:10:13 -0800 (PST)
Date: Mon, 18 Dec 2023 13:10:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: xiongxin <xiongxin@kylinos.cn>
Cc: hoan@os.amperecomputing.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	andy@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <26nje24sbwccuenarcttuskk7q2ngyxun2nbuynd32ylcozc5y@aasey6najeji>
References: <20231218081246.1921152-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218081246.1921152-1-xiongxin@kylinos.cn>

On Mon, Dec 18, 2023 at 04:12:46PM +0800, xiongxin wrote:
> In the hardware implementation of the i2c hid driver based on dwapb gpio
> irq, when the user continues to use the i2c hid device in the suspend
> process, the i2c hid interrupt will be masked after the resume process
> is finished.
> 
> This is because the disable_irq()/enable_irq() of the dwapb gpio driver
> does not synchronize the irq mask register state. In normal use of the
> i2c hid procedure, the gpio irq irq_mask()/irq_unmask() functions are
> called in pairs. In case of an exception, i2c_hid_core_suspend() calls
> disable_irq() to disable the gpio irq. With low probability, this causes
> irq_unmask() to not be called, which causes the gpio irq to be masked
> and not unmasked in enable_irq(), raising an exception.
> 
> Add synchronization to the masked register state in the
> dwapb_irq_enable()/dwapb_irq_disable() function. mask the gpio irq
> before disabling it. After enabling the gpio irq, unmask the irq.
> 
> Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Tested-by: xiongxin <xiongxin@kylinos.cn>
> ---
>  drivers/gpio/gpio-dwapb.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 4a4f61bf6c58..8c59332429c2 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -282,13 +282,15 @@ static void dwapb_irq_enable(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);

> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);

Thanks for submitting the patch. I wasn't sure which way was better:
define a "mask" or "hwirq" local vars with respective semantics. From
my point of view both were correct with the first version being more
optimized and the second one making enable()/disable() methods looking
alike the mask()/unmask() functions. No objections against you
implementing the second version. So

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  	unsigned long flags;
>  	u32 val;
>  
>  	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> -	val = dwapb_read(gpio, GPIO_INTEN);
> -	val |= BIT(irqd_to_hwirq(d));
> +	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
>  	dwapb_write(gpio, GPIO_INTEN, val);
> +	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
> +	dwapb_write(gpio, GPIO_INTMASK, val);
>  	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
> @@ -296,12 +298,14 @@ static void dwapb_irq_disable(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  	unsigned long flags;
>  	u32 val;
>  
>  	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> -	val = dwapb_read(gpio, GPIO_INTEN);
> -	val &= ~BIT(irqd_to_hwirq(d));
> +	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
> +	dwapb_write(gpio, GPIO_INTMASK, val);
> +	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
>  	dwapb_write(gpio, GPIO_INTEN, val);
>  	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
> -- 
> 2.34.1
> 

