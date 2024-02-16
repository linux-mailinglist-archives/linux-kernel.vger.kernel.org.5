Return-Path: <linux-kernel+bounces-68890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA45858181
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04A1B26F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A413329D;
	Fri, 16 Feb 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWUcLL4E"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7112FB1D;
	Fri, 16 Feb 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097806; cv=none; b=aMH3QHQ4NkwDdznqreGass2qgRrxOLC9NzihdVbRYzsyBgB4j9OOCysV9KYw94a2x0z9sQhl3XyEHuMVRPfQJVGxY9rzCtTRDp+tIQaq7A3DMLBZIbS6DeSiahtrTiOa6epPdfit6Z+mcj8zuftl6MTFyi55E0o7cHXrDFpkkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097806; c=relaxed/simple;
	bh=wfvh0/iVILV3fPSo2ZQ8Ff6gHCxRyDBSeSEOuuSMcNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXUanl6QD8VKm+8IhrJc1R/jbDUEF7vxnIWeogzY8B1E7tmqf8RNVI2m3mJezHoBM8dZ5YUFQnft54kmGld2L4GTwOcvn5uv8Hq0U2FnGivKXmEh5rf6st2qp/rqHWDSGmEQXw94dfnjM3lrTAanIRS/UPh8I+BcTYGArMVUU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWUcLL4E; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso96934e87.3;
        Fri, 16 Feb 2024 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708097803; x=1708702603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EM9d4NKP1uyF0zPf3h7n9kTkhx6lIklzeqHT5ceF45E=;
        b=TWUcLL4ENszIGh6uWEB2NwKVcekPWPbM84cztdlzhsPHPz+uyqbV2x5LWrvzME52+e
         2BrHVFIka2E2efeU8DbsXrtqk+n+OOdjg6IaOYIEozv84zMig5UNDZpKz8BZZIPWyGqx
         //cBFU1y28Ms8eLeuyTwz5FyA8MpLiro5XT+n0zNmxxk25xZIUJ4sZuuZ2Zz7gRZ+7+K
         5Rjw++ol+cWspD2rDG90mqhxHaIRB1iAmyQuONHqTJ8/74yFDHaGndKYOp9sZS0QLiiM
         81I/25OIOZ2xOuK0Zej/HOb3VleGBcqnlhe/lCUcmzQJ3V0sfuJQg2Ig0IUDtz4eVGex
         RPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708097803; x=1708702603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM9d4NKP1uyF0zPf3h7n9kTkhx6lIklzeqHT5ceF45E=;
        b=ifEdsJkokD85rVzYLzKNm5ecZnWtw4IgD0HSAqwFZ9iJ83ds0pnKiEfW/YUgevezhN
         ROyPOFx0w0Gb9PDUdvYLEwRapGrbdZq/SySrRZAy/TXxREcwpaAWh1zUfY4sZU6OyGiJ
         6ydhH+156sKsZZIT1AIl8xneXudwd5V369Yx0K5oYnDiBZns1mdRj4Dmztb+So02k55g
         MIdiwpXax/1Jhu1xhp9SmhxWfw1WBFGO/4WWGAjOnMM9nsnMhKc+oF+IppvWRxaa7MNE
         zrSdUmKNE+7RNFx3L6GjHOtFNFl+VagOBnys/ugm/sg8L3Qr5XWtCF7+bANjLOuRV7aS
         y6Og==
X-Forwarded-Encrypted: i=1; AJvYcCVRgXX4w6HWMK7ZmS/U9RkkOQUNjkH/i7ctOD06++rCUkg8pNGmL6jVxqRXDFaYuUzFzCzKx0lK1D3CP1UmVjWLun/gISTUmo8i1QETXZEx3dh2ldF1SwRNebpu1zVQsVZvcT/TZW1v
X-Gm-Message-State: AOJu0YyXaKlTSVavIeCORxCgWrfsUsNz2ramFZhZK1cK4Vrh7fHfVKrN
	E58UXgXZfj2i+re20MRJ6xfWtBoObcKJC2dRxFAuUExAj6qOgD7s
X-Google-Smtp-Source: AGHT+IGL8xStZCW0jsSm7bnH1KR8fWUNvYE74CqPyX9SruTFi822dSL84Kg/zpi2WSUJp79+WrOtxA==
X-Received: by 2002:ac2:5970:0:b0:512:9c8f:d4c5 with SMTP id h16-20020ac25970000000b005129c8fd4c5mr447498lfp.26.1708097802849;
        Fri, 16 Feb 2024 07:36:42 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g26-20020a19e05a000000b005117a641cecsm643919lfj.142.2024.02.16.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 07:36:42 -0800 (PST)
Date: Fri, 16 Feb 2024 18:36:39 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: dw: Drop default number of CS setting
Message-ID: <4sbbhf4ltdwrmj7rrr6f7lnjbdxrwfjoutmcgsh2c44jy5fxzj@xgqdscqdnkkv>
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
 <20240215180102.13887-4-fancer.lancer@gmail.com>
 <Zc5mxyTjq6X_QRsQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5mxyTjq6X_QRsQ@smile.fi.intel.com>

On Thu, Feb 15, 2024 at 09:32:23PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 09:00:48PM +0300, Serge Semin wrote:
> > DW APB/AHB SSI core now supports the procedure which automatically
> > determines the number of native CS. Thus there is no longer point in
> > defaulting to four CS if platform doesn't specify the real number.
> 
> ...
>
 
> > -	num_cs = 4;
> 
> Simply update the default here?
> 
> > -	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);

Do you suggest to simply:

--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -364,8 +364,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 				     &dws->reg_io_width))
 		dws->reg_io_width = 4;
 
-	num_cs = 4;
+	num_cs = 0;
 
 	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
 
?

My idea was to make the statement looking closer to what is
implemented for "reg-io-width" property. An alternative to what you
suggest and to my patch can be converting the dw_spi::num_cs type to
u32 and pass it to the device_property_read_u32() method directly:

--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
 	u32			max_freq;	/* max bus freq supported */
 
 	u32			reg_io_width;	/* DR I/O width in bytes */
+	u32			num_cs;		/* supported slave numbers */
 	u16			bus_num;
-	u16			num_cs;		/* supported slave numbers */
 	void (*set_cs)(struct spi_device *spi, bool enable);
 
 	/* Current message transfer state info */
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -320,7 +320,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct dw_spi *dws;
 	int ret;
-	int num_cs;
 
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			       GFP_KERNEL);
@@ -364,8 +363,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 				     &dws->reg_io_width))
 		dws->reg_io_width = 4;

-	num_cs = 4;
-
-       device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
+       device_property_read_u32(&pdev->dev, "num-cs", &dws->num_cs);
-
-	dws->num_cs = num_cs;
 
 	init_func = device_get_match_data(&pdev->dev);
 	if (init_func) {

What do you think? Would that be better?

-Serge(y)

> > -
> > -	dws->num_cs = num_cs;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

