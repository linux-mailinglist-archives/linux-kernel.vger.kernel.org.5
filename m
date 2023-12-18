Return-Path: <linux-kernel+bounces-3531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B734816D73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C341F21068
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F0D4CB5F;
	Mon, 18 Dec 2023 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/aqlDaQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499E4CB37;
	Mon, 18 Dec 2023 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e239c49d0so2335638e87.2;
        Mon, 18 Dec 2023 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702901268; x=1703506068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dxyVHTfWXCVHKUJ4PsRXiIlpKZrhjqQJMyk98Ihb9c=;
        b=I/aqlDaQkZLlpoU6dfcugX5AzUBynBrugAvU6SgEX2oPJO9FjZNz5AlKWS10JbLIT7
         IMsVfLTzfJA+89S8IyoT/cBSteyIYt3MA69ja3GjQtMry95Q1QDW6prZH3Upnz3IHyWp
         /k8GyF+rkSDyBp0rpvXwb0kkPYhgJewG2DfiOb90fHsnj5/ij0U/bLYS/BnpUtom+xX6
         WSpOe8ZI15B88IcTL4rJkjQHqSHozL02Ct2rFxdtUS8H0O0MxEwqpXCEPCwjc96HJKxV
         63cXlotxjRvsJAaqMA38Aei90ncMFzLG/qnJjBQJS4Lp3XS+2VBj/9oDxKTUPUgzqbU5
         +9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901268; x=1703506068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dxyVHTfWXCVHKUJ4PsRXiIlpKZrhjqQJMyk98Ihb9c=;
        b=eVS7s16rl2lBOhr5+u/R29BUF20VrYUJcl0ZjHI8H1gqAe0DWlE7Ao7T4PcdQSYpLv
         jk6uM50T/z8yjJQ7ZlsjDBybPAffNpDLcb6l1e0pZKgN373ANJ7Ne0+wJkff1xO4l70X
         2m+01AATuBvNw1eG3HrppSayw5plX9Bg0cqLBYrgnbl3qXSyFS4VOgEfX7vE/eb68mXf
         3wC14PaxVNHhj7/YyyCey+z/AHJYYTf56OFXEXXu1BIdWLqrXMZEicDpDz9Y2FTeN/tS
         Ps/YYflfRVpdEkequ8bsxrCYaQgv4n3J6q7VFJGjXnN5YRQ4mSul4LM7Ft3jz53i9ZAX
         TIww==
X-Gm-Message-State: AOJu0Ywq7HZ0dkANbt10o4KXTRTpBaBQTNaBYWZzS69gm6ah76distME
	hCO2Pz27EwNio6ECNc/o+eM=
X-Google-Smtp-Source: AGHT+IFhCnB+9DIlvwhRdrkEZeuhLMibN9TSxq/f2X6/GMXWUc+/YCqpFg9V105fJ9x08PfzEjEx3w==
X-Received: by 2002:a05:6512:b0d:b0:50b:f7fc:ac5 with SMTP id w13-20020a0565120b0d00b0050bf7fc0ac5mr9778870lfu.97.1702901267947;
        Mon, 18 Dec 2023 04:07:47 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u4-20020ac243c4000000b0050e30d2e336sm509383lfl.91.2023.12.18.04.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:07:47 -0800 (PST)
Date: Mon, 18 Dec 2023 15:07:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: xiongxin <xiongxin@kylinos.cn>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <mdogxxro42ymeaykrgqpld2kqbppopbywcm76osskuf3df72sl@5jalt26vzcv4>
References: <20231218081246.1921152-1-xiongxin@kylinos.cn>
 <ZYAt8Zlv9XMYO5FF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYAt8Zlv9XMYO5FF@smile.fi.intel.com>

On Mon, Dec 18, 2023 at 01:33:05PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 18, 2023 at 04:12:46PM +0800, xiongxin wrote:
> > In the hardware implementation of the i2c hid driver based on dwapb gpio
> > irq, when the user continues to use the i2c hid device in the suspend
> > process, the i2c hid interrupt will be masked after the resume process
> > is finished.
> > 
> > This is because the disable_irq()/enable_irq() of the dwapb gpio driver
> > does not synchronize the irq mask register state. In normal use of the
> > i2c hid procedure, the gpio irq irq_mask()/irq_unmask() functions are
> > called in pairs. In case of an exception, i2c_hid_core_suspend() calls
> > disable_irq() to disable the gpio irq. With low probability, this causes
> > irq_unmask() to not be called, which causes the gpio irq to be masked
> > and not unmasked in enable_irq(), raising an exception.
> > 
> > Add synchronization to the masked register state in the
> > dwapb_irq_enable()/dwapb_irq_disable() function. mask the gpio irq
> > before disabling it. After enabling the gpio irq, unmask the irq.
> 
> > Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
> > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> 
> Your SoB should go last.
> 
> > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> 
> Then at all means what this SoB for? Either it's missing Co-developed-by,
> or simply wrong.
> 
> > Tested-by: xiongxin <xiongxin@kylinos.cn>
> 
> This is assumed to be done by the contributor, but it's harmless to have it.
> 
> With the above being sorted out,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 

> To Serge, I give my vote to hwirq as it is aligned with the documentation.

Right. Thanks for noting. It's now even more justified to use 'hwirq'
then.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

