Return-Path: <linux-kernel+bounces-89391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B789D86EFBD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE563283F0B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342DD13FF1;
	Sat,  2 Mar 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyzyDhVy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0382376
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709370847; cv=none; b=fIZA2oYSAOimLvDsJpqjlaKCt9vLiMqEc+W0MT2VAMrxgyFkspzgkOM8eTVQct2H1Jwd9fA33fPJvZG33/UfgTA+Oq3pJItqKyDf4VdSNir9uvNaZ7O865AZc59wkSeb4tHRHB9y7fxqZZ+juSzJ+Qxm/uWbJPl2mYYQoQa7mFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709370847; c=relaxed/simple;
	bh=AQCHu6wjC1Mc61DwzXSbpHVMgu3N08Sag4neGTjHap8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn9FuFsiEGm+/YAHYgNXi4LFLj/WibWYRVldk+q1fhZQOZyZHl9+tuoiZZCMohDJkuIHEpcUSNlUo2MMW5Nxd14TwrT1YfPA2Gz3zXlUyV6lYB4KI4mqKFR5fP21l7g60eRtR5e8G+dC5pwFhnQGIMtYP/tF9djZF1C0L/9z0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TyzyDhVy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4429c556efso458949066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709370844; x=1709975644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFSpcwT4Hy2bJfwJLXbvIJSYRBInQpfC3lHF7abplN0=;
        b=TyzyDhVykPJyXTVESsrhxoch0+bBcNML8ayZyTOIlmiUJlvLSNocu76IrF//dhYNHT
         D5ZKcSshJIkRd0VtR5WG8ul12ginmdsDbM0xkmj7pBbqhMcbtNGLtFxSswUIjK+brm04
         C/zBMUxlBeSPPK7oLOBc6oNtgHdBRjFmC3fafPeIWJlA568cufqfyt5y+hEL/k0w6QMM
         nqDortpPlKMM2sJJDyxwfRKn0ijAcD262kURRZ9A9tLr5/OXXApD1l18rfbGsCMywS5V
         wnICBIC3EEl5lBhsuHJEIOpmbaEhgkptCal5r10karvwzZwtFejLy++qS+Dd3TC5LDIm
         4UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709370844; x=1709975644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFSpcwT4Hy2bJfwJLXbvIJSYRBInQpfC3lHF7abplN0=;
        b=Nhqqog3kIwP3tY718yV9g82+yHm/idIK+ssgUYqASoPcEJJH8Qpn26tNdeBT8uxPaf
         xRTMIwMKAWloXXP+FSj8OdXlS4rATZmVPKz09+VCA4kBvUeHgXdNa3UKg8C2UW6Kh+Zt
         GR2VSYarP7uHC7Y39I71m3v1lSPCQgJhtaKjyMZWquk6mY74KAHvpLmkKlzBb+gwcSNz
         7jL7UpbLw44lI2TtpzQeKiGnhNZrksQpS6Z7/CA7XsO/IKeQ+yBoJE0xjJcOrrkGRd6/
         WEsiuwglTWgKaz64KZ7k9u3mDIeOVwE6XIb81NN90pVCODLyvrXymZDGyVOHXXccOoAt
         WwWw==
X-Forwarded-Encrypted: i=1; AJvYcCVvY5NipFIdf7EyYOuuvX9R0Cyjyt0qaKBEvH10y7WA0oUfD+ChR2tXEvv+fDEpUrV7HCR8arjdiftCtjsyfV20oCkYHVTCNPSD7pk+
X-Gm-Message-State: AOJu0YxrUOMZspiv2WSE5u93G7gDDa9uA1/DawBHk74Wa8MEKivlY7pP
	ln0fAD+FKFpT+1/ssg3w0U3WLeHw7GE/wEy9ELEordWjjptDanSH9rCgOwplFlY=
X-Google-Smtp-Source: AGHT+IFw0H9KYLYbJ+iK2SiQXFZ3sKDi47m5yY6mq2kN5tKP5jX67KeShfXodKkF3G4h5YBsmaugIw==
X-Received: by 2002:a17:906:80cc:b0:a40:2998:567c with SMTP id a12-20020a17090680cc00b00a402998567cmr3019889ejx.41.1709370843819;
        Sat, 02 Mar 2024 01:14:03 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000104d00b0033dfa7ecd33sm5901777wrx.61.2024.03.02.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:14:03 -0800 (PST)
Date: Sat, 2 Mar 2024 12:13:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Markus Elfring <Markus.Elfring@web.de>, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ds90ub960: Delete duplicate source code in
 ub960_parse_dt_rxports()
Message-ID: <8ece4c88-dbc7-4327-ac2a-0a097fc990d0@moroto.mountain>
References: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>
 <ZeGV_siWFkfqSEgZ@kekkonen.localdomain>
 <db1d7227-f9a4-42fa-89ba-b484e1260e0b@ideasonboard.com>
 <ZeGZsRtH6YLx2FiM@kekkonen.localdomain>
 <ZeISEYXTaiyA-b4K@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeISEYXTaiyA-b4K@smile.fi.intel.com>

On Fri, Mar 01, 2024 at 07:36:17PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 01, 2024 at 09:02:41AM +0000, Sakari Ailus wrote:
> > On Fri, Mar 01, 2024 at 10:49:19AM +0200, Tomi Valkeinen wrote:
> > > On 01/03/2024 10:46, Sakari Ailus wrote:
> > > > On Fri, Mar 01, 2024 at 08:46:25AM +0100, Markus Elfring wrote:
> > > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > > Date: Fri, 1 Mar 2024 08:23:24 +0100
> > > > > 
> > > > > Avoid the specification of a duplicate fwnode_handle_put() call
> > > > > in this function implementation.
> > > > > 
> > > > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > > > ---
> > > > >   drivers/media/i2c/ds90ub960.c | 5 +----
> > > > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> > > > > index ffe5f25f8647..eb708ed7b56e 100644
> > > > > --- a/drivers/media/i2c/ds90ub960.c
> > > > > +++ b/drivers/media/i2c/ds90ub960.c
> > > > > @@ -3486,10 +3486,7 @@ static int ub960_parse_dt_rxports(struct ub960_data *priv)
> > > > >   		}
> > > > >   	}
> > > > > 
> > > > > -	fwnode_handle_put(links_fwnode);
> > > > > -
> > > > > -	return 0;
> > > > > -
> > > > > +	ret = 0;
> > > > 
> > > > I think it'd be nicer to initialise ret as zero, then you can just drop the
> > > > assignment above.
> 
> I think tearing apart the assignment and its actual user is not good.
> 
> > > I don't like successful execution entering error paths. That's why there's
> > > the return 0.
> > 
> > It could be called a common cleanup path as what you really want to do here
> > is to put the fwnode handle, independently of whether there was an error.
> > I think the current code is of course fine, too.
> > 
> > Soon you can do
> > 
> > 	struct fwnode_handle *links_fwnode __free(fwnode_handle);
> > 
> > and forget about putting it (but you must need putting it).
> 
> Let's wait for the Jonathan's patches to land (v6.9-rc1 I hope) and then
> we may modify drivers if needed.

The __free(fwnode_handle) stuff has already been merged.

We could do some additional work to make a _scoped() macro for
fwnode_handles but here it's function wide so we already have what we
need.

regards,
dan carpenter



