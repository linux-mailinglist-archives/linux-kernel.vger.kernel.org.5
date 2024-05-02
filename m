Return-Path: <linux-kernel+bounces-166164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D423C8B96FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9784E2832C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E824D5BD;
	Thu,  2 May 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9RwVptd"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483846B9F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640364; cv=none; b=QSCw0jbRq3RjLIElBHe2Wqj3KWAAjUl57m8wj+HWuGQfFH4jN2eGT4JN41e4kUHtOsLwVuO2I1AbScDhMq4/WGz34RGlSGFwFAvSNPVI2bGkik73WXge5g1pre10upqkiYYqEjDBARdx6rWa/z6mpcm9ke5yFhOxEEy2tAgV7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640364; c=relaxed/simple;
	bh=cgYb2kPZ5GbGdUXi0a4N9CJtK6f0uTTDVTCr6ydiVgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWU3h3D3qyl6VaivNtOEPYu68evdv90Ek1PTwRAt945CS2TkVeOwAwAzYJzjx/yhPOewct7upNaPuNx8cN7mbiOoTlDyT82Bdy+pLrUWorakavvWWZ2Y9nXjMcOQk+I9WrSM3VOEjeXJrQaTSA6t/8jDQE9yr3rcdevwuvteEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c9RwVptd; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f17ac14daso720967e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714640361; x=1715245161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JArO4bX3IUaYcurGaRFt9DxIObyTrUcxPuO3BO9ScqU=;
        b=c9RwVptdg3Np3c9X0OqwY66xbF5o1d+MKOD0F7YslPJVriZR2mgQO9AtaAjUOgs/SB
         aBEXd48qRDrMGmDDCazuL2laECfCFETiZBVn0n88FUaJgbnkr/GBAKler3OnnLcFkKXv
         slPUz7x4i5GcamZS+rQtBzRFjcWeDd/12msbpYr3M83glD++9CFjmZY6qjQG8IMTPZDG
         y//Fpofr04ATdy60ALBIQE9pYe3Dbn5V22DSfZxlI52gRilGCbQksEwLjYOSUdXn3Pvd
         wmcihTJc+eSrjuYmOVND7oZTJ9D97UoTi2dao5HanON4XP57hzo5CJwmqyPxCWP+90Tj
         7c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714640361; x=1715245161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JArO4bX3IUaYcurGaRFt9DxIObyTrUcxPuO3BO9ScqU=;
        b=BZ9/THo1JU2ULEVFO8V7jhLSd0b1PnbhBqHjW3umK0E7NuOQD/pu4CE11mMxGtQmLV
         I9oLCNAdC60DygWB5PioumHPv2Ex9dfPdL0IdtXleOTytTcDkaAZ+WCbshlF5mhlExPa
         StZD//RyCcZTXPBi6fwyrIISIzAzNUj+SwVa6ry4m1pT/bmNz6g1+ljW4SjJsLAK8S/L
         aHTMZmsOZmFM78UtYpd/rMp1TRKjryqzfjiIKxsbSMY67UNqkZXHgRAQfjhoOjbZYJMl
         cvODkrKOhH4LDQo+w4tCOGUk+7hI7Wf5hdu2t0aBUmx7biHhK9FQlR18UnPEaS+z/E1Z
         4Bpg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/Lf89pNt6jc7lUxvmCYktU5ai0KhTtwJGAR7xwVQfpKIxt8NCd3EQTIb1W1n3+DGy2CrbbQFVLBJRtSGuedDchq/ZqMcrIYjmhXD
X-Gm-Message-State: AOJu0YzwabK+gQ2qq4xJvupJq9D30As8bF+mVMTclHKZiXgGQHWTsvTQ
	GGI2E4Uar9tj0ko0JeYZwobSsU9h/F1uW7VxCKj1hzdMA7uLEbCG3e7DzxW/su4=
X-Google-Smtp-Source: AGHT+IH1P9B88ovnKP0SkYQLjObmvbIH5cf6HaZXDX/4lkfpxRooBAbtPgShWMsInUtb90o/du4pqg==
X-Received: by 2002:a05:6512:3b87:b0:519:1e33:9d85 with SMTP id g7-20020a0565123b8700b005191e339d85mr1153370lfv.36.1714640359096;
        Thu, 02 May 2024 01:59:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id br39-20020a056512402700b0051da1d9c47esm101814lfb.64.2024.05.02.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 01:59:18 -0700 (PDT)
Date: Thu, 2 May 2024 11:59:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: pi433: Rename goto label.
Message-ID: <752171bd-9695-44f2-aad0-c8140e5099dc@moroto.mountain>
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-3-ikobh7@gmail.com>
 <3005db51-58f7-4247-a37b-02933767f644@moroto.mountain>
 <b0cd37c3-5465-467d-8074-67fa2fddcc4d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0cd37c3-5465-467d-8074-67fa2fddcc4d@gmail.com>

On Thu, May 02, 2024 at 11:44:15AM +0300, Shahar Avidar wrote:
> On 01/05/2024 17:06, Dan Carpenter wrote:
> > On Wed, May 01, 2024 at 08:58:20AM +0300, Shahar Avidar wrote:
> > > Use destroy_class_and_remove_dbfs instead of unreg_class_and_remove_dbfs.
> > > 
> > > Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
> > > ---
> > >   drivers/staging/pi433/pi433_if.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> > > index c8c1d296184b..4fffd7007040 100644
> > > --- a/drivers/staging/pi433/pi433_if.c
> > > +++ b/drivers/staging/pi433/pi433_if.c
> > > @@ -1409,11 +1409,11 @@ static int __init pi433_init(void)
> > >   	status = spi_register_driver(&pi433_spi_driver);
> > >   	if (status < 0)
> > > -		goto unreg_class_and_remove_dbfs;
> > > +		goto destroy_class_and_remove_dbfs;
> > >   	return 0;
> > > -unreg_class_and_remove_dbfs:
> > > +destroy_class_and_remove_dbfs:
> > >   	debugfs_remove(root_dir);
> > >   	class_destroy(pi433_class);
> > 
> > This is cleaning up something which changed in patch 1 so it should have
> > been done in patch 1.
> > 
> Thanks for your input.
> I thought of a previous comment you had were you noted Greg preferred small
> patches, so I did my best to keep the first patch the with minimum changes
> without breaking git digest.

The rule is not "as small as possible", it's "one thing per patch".
It's a bit subtle, but you're doing half a thing in this patch.  Not a
huge deal.  It's part of the learning process.

regards,
dan carpenter

