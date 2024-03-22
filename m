Return-Path: <linux-kernel+bounces-111218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4B88694A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32181C23FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FE20B3D;
	Fri, 22 Mar 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woCsGRhj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152E208D1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099905; cv=none; b=U9DLZAVZNtfK0sC/tbwbUNf2pTTERj5IafAlDqTdcJt9vfSiR9QygaqdY/1+Q0YaWZMHjZOaT2HBeQZNXu79wUC8SxYIu89tlSCe3kcij/gB5Uo1Q08bHErYQOTSY7WZtTVUK8pthTWciY6VmEIQSGM38dvaRDcZN4f7KvFwXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099905; c=relaxed/simple;
	bh=gADTjc2dxeesohFGmu4WtjCwknaJ3Fafeo6D42wFGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSxMAJqrOS+/RZK7E4UPzYmf6ddZBSbE5SiT3iAH9nLqyyHQIC6XxWi26TlZtMYmg6g5mIODVSrwvXv3P9bj69VKDU8m+cF2jIYauEIYfqdmsro+qggH0qzVxlrn7vjHM00gpMdTA9HP2jdKxExmtpNplfwmB1OzewnqxpCVk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woCsGRhj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4146562a839so13292055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711099902; x=1711704702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7E+eUGe/hdcugl2ZZv/ZnjrSpu6srn2v/HM636IHEis=;
        b=woCsGRhjq1IoiIsXs8xnssttIN6SQ5LULuMKNhVUAjAz9vj6og0B/XOdcgPxJbySBR
         65rqEkw25Aj81QFZYmx8/NLiBu3/A+La1/hLJj66xGyTW+K5pDWKdfeOwtMiUrYQLaDv
         c2usZaoQX/RfBytugCiXzUjyPxOqw4YsouhQ77753UVBk4JJSi2y9L90dkXFPFQreiO2
         Ju3jBYlT01o7PNUu9ZiNOBHYzfwGyj5xHBBkIRhH0CTGQiaJeCoHhuBTikgH1rQ93e6S
         rPG9EMjRIR7KLM2/czG7LxOUGhB5XI8S+RZRnVw8xHOJW5BIlpaNDLIV3FrWrIft8k/d
         cukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711099902; x=1711704702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E+eUGe/hdcugl2ZZv/ZnjrSpu6srn2v/HM636IHEis=;
        b=CqxXE4Pk0+DIfy4wFml8tEBK5uvxpgVmkloLJcB5gQomRYOjFqYdG0MkbbGOUqScqm
         mBv5fTN4d6IO/i0ru75Q/R3TvSgPV23B2IN0d7rkwnhR+ItmdYvgGdpUBI7cLwsp1Ckr
         Dj+7ASsIR01+m4qrLbfiv/y3KYwsKIo9JR+JytXeaE/sonuwFmbnOT3G+cX6npCEml5R
         Kk05km6Pkw3YlsgVuY8cKyRvtqHrvjJl7NcJhWyUXl0uO0SAD0OP6oTF5zXk1jPp614k
         lRqYp4WKbTd3ReDeXXTm40DPeDmi0+WaHrg+Ns1/LLv9j6Jl3ZpRSIH9q9PgQZ/4DifS
         gwQw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2CqVoqbWaYrFd7STt81/WNcEp8vuiUO8Z4ommSV07rhFYeC52tKEFQjF0KiJMH2cyDkqqlI/BueBLOKdg680UVFQ9OFoj/3UwMNh
X-Gm-Message-State: AOJu0Yy8CxQAF2nMgYKG/Khe65xJpPGAXSdVnexjFVmD17B+NPX65O+x
	pmejn6M04Bh/nu5eA9iqahW0LxTBw+qZh0dRzObqmwFxzgaN9FqcokvX1hnP3Xw=
X-Google-Smtp-Source: AGHT+IEx9+6Qw0hrRUZxzQ7LLuPG4KUN4sIHa+qcrOs3KA2kgTDh+sJcM3kgVXFOcm3zkWzxm860gA==
X-Received: by 2002:a5d:6583:0:b0:341:ba2d:bddd with SMTP id q3-20020a5d6583000000b00341ba2dbdddmr369781wru.1.1711099901869;
        Fri, 22 Mar 2024 02:31:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033e756ed840sm1641939wrb.47.2024.03.22.02.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:31:40 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:31:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] gpio: cdev: sanitize the label before requesting the
 interrupt
Message-ID: <f529d746-f8c5-466b-860b-e2bfaeb2cc27@moroto.mountain>
References: <20240320125945.16985-1-brgl@bgdev.pl>
 <20240322013034.GA4572@rigel>
 <CAMRc=MfQnZQU_t9-uDPp18vFikz_9eP6LtnWJYG0+KFgWjBcEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfQnZQU_t9-uDPp18vFikz_9eP6LtnWJYG0+KFgWjBcEg@mail.gmail.com>

On Fri, Mar 22, 2024 at 08:46:50AM +0100, Bartosz Golaszewski wrote:
> On Fri, Mar 22, 2024 at 2:30 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Mar 20, 2024 at 01:59:44PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Let's replace all "/" with "-".
> > >
> >
> > I actually prefer the ":" you originally suggested, as it more clearly
> > indicates a tier separation, whereas a hyphen is commonly used for
> > multi-word names. And as the hyphen is more commonly used the sanitized
> > name is more likely to conflict.
> >
> 
> Sounds good, will do.
> > >
> > > +     label = make_irq_label(le->label);
> > > +     if (!label)
> > > +             goto out_free_le;
> > > +
> >
> > Need to set ret = -ENOMEM before the goto, else you will return 0.
> >
> 
> Eek, right, thanks.

Smatch has a warning about this, btw.
drivers/gpio/gpiolib-cdev.c:2221 lineevent_create() warn: missing error code 'ret'

The other warning here is:
drivers/gpio/gpiolib-cdev.c:2269 lineevent_create() warn: 'irq' from request_threaded_irq() not released on lines: 2258.

regards,
dan carpenter


