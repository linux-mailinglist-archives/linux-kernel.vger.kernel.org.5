Return-Path: <linux-kernel+bounces-160092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B38B3903
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AFD2863DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F5148310;
	Fri, 26 Apr 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzeUyjnD"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FD140389
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139606; cv=none; b=G6clkKznKKZfdwbOUHebEHeYdwIx9z5u3cT+aqZIuLdihSp94woUe8caNQvmtticaeWsVmwxtwX/TyyOuA/q/XP86qcqpWknjdTtXQKMDkDIntzarn2RRug9Qx8HQkClLzh0I8IzdEwRcQblyipb64libpcmjRHEc8ZEIFD6ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139606; c=relaxed/simple;
	bh=kfoxr5MPT8Y3C1vwEbZQqbvK0Cu7jbe/sUQY8skyjXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVUANPNWE/iFIX2vJJa2ZyAEXOpYUMabHYm25RE4ByxLtxSxKxbgFVkXI23drycjWYWsEFr5wB/mhkgMFaX+Q3XSNpdLRK7tri4Ts8z1lHpLAmZ2v1LwdoKv/NSfW4ziNVtQzHmN4jigQQcGE1INkV0hIS/P4tkBFzTWenY6Vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzeUyjnD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso2944065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714139603; x=1714744403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcMN14IZtAud1SzWuvyCQx4H2upUNwp8wShEfmdsMaU=;
        b=mzeUyjnDwBpDeAXWorypUmlLrH/Gd1qmU3W4/8w+dVJ8SEgdApiWU/WXsgXnkkjaoI
         OaRwIIqe3LfuZ+igE1uhhaGaMu6+OUISuDhM884em52UBwhjlossdvl1fntzACjb/OWh
         7r39KkdwYWrDZDy94xzZapJrdusN4pNe4rwNznLei22AywR9JyLHIMjFErbRi9xP8FN/
         RZQ5RbDvVeNs6UV4L4tO+EA+O8up3SbkPxG1UaxD8DGRWWQXIrKhzLNFq3ybENTXbmL3
         E00+qY6KQBWGnMReM3DKvYeQL+/zIgsS/C0Ru8+FfZN28AH4EVK8poz14bOZ09/xpIkW
         Dqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139603; x=1714744403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcMN14IZtAud1SzWuvyCQx4H2upUNwp8wShEfmdsMaU=;
        b=nuwgw50bSn4cX8/kFMnqpCpUbv7GbbrOlFBEEu8f9bAEG9DIt59MUzBaT/ClJDiXJV
         vFloYlm0JMgLADjUZ0d5eHDsV8gM4AnsiLq3G4QONpl+hMx28mf6iNJ4Tq9n/eYc6ndF
         VNKI++KTA+z+4B2B5o8E6Ed/iUcvtOgoydioFHkXpP/ZgVJwPuQ8/OB9c1OUGFy8SxA2
         4lE/QbDT75xC6yhjJ9SquwTJ7jDpGv4hwSYtvFqcwmr8gXPpdOgPsIK3f6VUSrZGEIec
         lCYDfL8tuUNrs0JdAjhWibBZo4CB5ZuILPiAvE9uj4ouHyZr0V3TTlKF7E5dsWGvam9i
         CyOA==
X-Gm-Message-State: AOJu0YzRh5Oo+NXQMv8sgrhOG2SBgX5rC/ZoV9Lz2Rs4EcrtscacexeJ
	g6vM5DEfUi8lJV7f5/jJ/VCzN4dpH8eJ626F7Rkt7S4uuCJ46ArfAprHlHyGeNE=
X-Google-Smtp-Source: AGHT+IE83jWZzVOng5zKH0QSGdpbtE4+Wt+APtbatCw3dZ/Qc0dSNlMokp6KwGnYkxFdJsCiBVpVKw==
X-Received: by 2002:a05:600c:474d:b0:41a:408b:dbd4 with SMTP id w13-20020a05600c474d00b0041a408bdbd4mr2373100wmo.7.1714139603241;
        Fri, 26 Apr 2024 06:53:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm35048249wmo.1.2024.04.26.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:22 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:53:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: lumingyindetect@126.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <87d376e4-84f1-48c3-8c5d-955f706f3bfb@moroto.mountain>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426114716.1275085-1-lumingyindetect@126.com>

Run scripts/checkpatch.pl --strict on your patch.

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#15: 
In the execution logic of the lpss8250_probe() function, the function may directly return via a return statement at either line 347 or line 351.
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 12dadc409c2b ("Linux 6.8.7")'
#19: 
Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67

On Fri, Apr 26, 2024 at 12:47:16PM +0100, lumingyindetect@126.com wrote:
> From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Fix this email address.

> 
> In the execution logic of the lpss8250_probe() function, the function may directly return via a return statement at either line 347 or line 351.

The line numbers are not important and they change all the time.
Instead say "if pcim_iomap() or lpss->board->setup() fail then ...".

> Unlike lines 357 or 361, where the return statement is used directly without releasing the dynamically allocated memory region pointed to by the variable pdev, causing a memory leak of the variable pdev.
> In the lpss8250_probe() function, I added a label named "free_irq_vectors" to release the dynamically allocated memory region pointed to by the variable pdev, and replaced the two return statements mentioned above with goto statements to this label.

Just say "Use a goto to release this memory".  No need to explain
further.

> 
> Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67

This is the wrong hash and the format is wrong.  It should be:

Fixes: 254cc7743e84 ("serial: 8250_lpss: Switch over to MSI interrupts")

> 
> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index c3cd6cb9ac80..fa9fd4dc86c7 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -344,11 +344,11 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	uart.port.mapbase = pci_resource_start(pdev, 0);
>  	uart.port.membase = pcim_iomap(pdev, 0, 0);
>  	if (!uart.port.membase)
> -		return -ENOMEM;
> +		goto free_irq_vectors;

This needs to be:

	if (!uart.port.membase) {
		ret = -ENOMEM;
		goto free_irq_vectors;
	}

regards,
dan carpenter

>  
>  	ret = lpss->board->setup(lpss, &uart.port);
>  	if (ret)
> -		return ret;
> +		goto free_irq_vectors;
>  
>  	dw8250_setup_port(&uart.port);
>  
> @@ -367,6 +367,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  err_exit:
>  	lpss->board->exit(lpss);
> +free_irq_vectors:
>  	pci_free_irq_vectors(pdev);
>  	return ret;
>  }


