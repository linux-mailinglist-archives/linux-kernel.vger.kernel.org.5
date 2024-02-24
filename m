Return-Path: <linux-kernel+bounces-79886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32198627EA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4441CB21583
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CDC4D5A3;
	Sat, 24 Feb 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAqdlj9H"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3781400B;
	Sat, 24 Feb 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708812591; cv=none; b=iolw9J2W2X8Hhd1gTcYSkgGki4EjT8DwikruMlY6kJpEKDVkKZPVmK2AtTztYZP8cwkL5nlELiWD3qDQ0Vp95PjDjigSK6waFL0w15atj5MgvLyfofksJLAoHV8Xewzgn0mZss997Zh6c+XgCmXOtmvX+jb653T9LcBNTghJBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708812591; c=relaxed/simple;
	bh=vSlP7QP2oAfnAIQ/TOxuBgG28tjwrPrrynPqsk2UXNM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rydAJVE7p6+s4qWzdMDFq7LRyo693vS3Gp/nffNARIa7abo5TAfcjJuDunpckoKDw8nASXhcZnPgGzRU/RysidvVQ+lN/XRO/nmYjLOZLl2LdUv6yWfDT5ciz0wCIuEJT49F2aRDt9jpjsoHw/9RNpVn1Kx0cQrP5HCpUK6Ilgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAqdlj9H; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4128f5ec9b7so14343825e9.3;
        Sat, 24 Feb 2024 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708812588; x=1709417388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQTm/E2OgFHl030SeornH96V8pO1cw7ie2ssNFqqPEk=;
        b=SAqdlj9HrjUinOny1I83/7uwL6hzdT/zaYAcY4FMxJzcTad5isVnJB/t+NWNIRifc7
         VOoK09K9ZeBCBNSMCly2Qhob4zzLzpuhqRfauB1tQcfvjyddSHLDPBQo3DP0xTnevpE8
         rJc+PuOHfG7NYJ6K0ZAiF335LkC5RVMlykRXo3otvv970KfOjodMfKLqdrLHbXLc2TaW
         WJQyf0hNMwJc3oPAwd62+t7unSHhHBrvmyJQVhfPPfX4Q1Mi+wJPTQyYJ17ftD5Ilu7p
         Gh15atf8qpCxTThm+vNA3dHZKG81iJxjHYojbQtROlBudR/fI+xQdebtOaBKpe0zTdak
         H6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708812588; x=1709417388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQTm/E2OgFHl030SeornH96V8pO1cw7ie2ssNFqqPEk=;
        b=eJUZFqXennsTtFoED9xFauYcVWmO4nZXclg1kLhk9s6zCAz1nUM/QH+GeRAhvLSXEv
         dtGMlW8a2/G8NyfYC4DE832UHoLOrshBOC69txhlUm64bXjUb2LvsefVRQWMJ1HxNfBD
         vVXXj8ZgHkLVtXvspFQA+sFei5vgt4I9Q4IkOBYBgNXGeGlpsBKIpYgtd9AlSwtumEmm
         3PXZAb6Lnkr4LDQmoPdf7/dGRfla+QRMfhuowS7MeGAi3hBDsndXsiJAZOLKOxbPH1r+
         7A2EPxCPlmSKyqsD1AWMVLBF+RHNIL5RD/mXN0UueqYxr91CTYRpj0FAx2KF/n8nENX9
         okcg==
X-Forwarded-Encrypted: i=1; AJvYcCVAfaRwBpqGm4RC6E3Qf8mUxcYKqxBuRTpaeSFECAmjv6UaghnRdPKGbL9qHRtJXxADMxnHNIVdNI3hCABX+uB8wOBYC7V7ydhJ6/KoGfDqzSTB8iTgnpV3mKfkdiEiY5U6nyOraUwS
X-Gm-Message-State: AOJu0Yy6rFL4yctdyzZt4CeeDkbrMY0JHLoqhJrIUMyhe1SrB6oiexAP
	Wia1hUAeC8eb+j/1+VW7fY13Of3MRJ1VNl0MaLVZ0lBiAXUjplqJ
X-Google-Smtp-Source: AGHT+IHSlHx4cnsottoNj86qeFXIrxzs9ukI5oVj+R60y8NYElGDn5mkikYamhUHIZnuR5N3YwbLAQ==
X-Received: by 2002:a5d:6707:0:b0:33d:ca56:a61f with SMTP id o7-20020a5d6707000000b0033dca56a61fmr181051wru.49.1708812587463;
        Sat, 24 Feb 2024 14:09:47 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:663d:3291:5fa5:21e8])
        by smtp.gmail.com with ESMTPSA id co2-20020a0560000a0200b0033d70dd0e04sm3406928wrb.8.2024.02.24.14.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:09:46 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Feb 2024 23:09:44 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: iio: pressure: Sort headers of BMPxxx SPI
 driver
Message-ID: <20240224220944.GA105280@vamoiridPC>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
 <20240224180412.0b23a105@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224180412.0b23a105@jic23-huawei>

On Sat, Feb 24, 2024 at 06:04:12PM +0000, Jonathan Cameron wrote:
> On Tue, 20 Feb 2024 23:43:28 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Alphabetical sorting and separation of headers for the BMPxxx
> > SPI driver.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Hi Vasileios,
> 
> No. This ends up as a dependency of the fix which will want backporting.
> This would make it a non minimal change. As such the reordering comes
> after the other patch (and not until it is upstream).
> 
> All that needed to happen was bits.h being first of the includes in the
> fixes patch so that a sort later was minimal.  Doing that had no impact
> on the complexity of the fix to backport so was just good code hygiene
> in that would simplify the resort to follow.
> 
> Anyhow, dropping this for now.  Please send an update version
> next cycle once the fix is upstream
> 
> Thanks,
> 
> Jonathan
> 
Hi Jonathan,

Thank you very much again for the comments and I am sorry for not versioning
them properly, it won't happen again. I also understand what you mean in the
previous message and I will definitely submit it again, first thing after the
changes are upstreamed.

Thanks,
Vasileios

> > ---
> >  drivers/iio/pressure/bmp280-spi.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > index e8a5fed07e88..fd7ec6a5bca3 100644
> > --- a/drivers/iio/pressure/bmp280-spi.c
> > +++ b/drivers/iio/pressure/bmp280-spi.c
> > @@ -4,11 +4,12 @@
> >   *
> >   * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
> >   */
> > -#include <linux/module.h>
> > -#include <linux/spi/spi.h>
> >  #include <linux/err.h>
> > +#include <linux/module.h>
> >  #include <linux/regmap.h>
> >  
> > +#include <linux/spi/spi.h>
> > +
> >  #include "bmp280.h"
> >  
> >  static int bmp280_regmap_spi_write(void *context, const void *data,
> 

