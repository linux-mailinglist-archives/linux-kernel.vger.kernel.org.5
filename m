Return-Path: <linux-kernel+bounces-102461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7A87B26C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A8A1F26D15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BA4CE04;
	Wed, 13 Mar 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3aYi3co"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CB225AF;
	Wed, 13 Mar 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360037; cv=none; b=QykGSpKiScmqO5XsOcYf6LENxwi7TsL67g4DfcF8BAetY1vPviveV1VCnit8V41/q5kdq+6kifFc+GfZs9xjpE5EOOZ7oGwiDbNGLcH8ul9r8NLw4C6adu04CmOppMUFQcMgL+68wAOFVlo+2NqlM4Qa6xNaGsL1vABZL5VFy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360037; c=relaxed/simple;
	bh=I4XcGuTburoMv8FJwJYZcsdnM+xWLlluJGDQPgI1Rtg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k158DKrnM4kON/R2OLeelBz7nrwJcefXrRa4MzTVFKjxKw1ed6yCA7XloZ/E0P1yX6iw1vJatblETaKRjQGeP/Ws9BzBz648fQuEm/jgSvPFZEJVocIvkOXZYd4kGTiSUvNBwGtDj1ZCZwnXPNf771dmyV28HRJkq21N4KmJczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3aYi3co; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4649c6f040so33827966b.0;
        Wed, 13 Mar 2024 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710360034; x=1710964834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A1HmNv+yMo2ZvddaEye/rC5NZtopLXcTAFzBOCzH5/s=;
        b=Q3aYi3coTsavNVq8G2DGDAYfbEETuskYVmCjyq2pg/BvUKaFD+B3WuZoVVCbInY0Me
         6ndnPGP1arAWnp2BpdEpdUvxuVw6Xt3SrxI0qx6PJAOkLSsbxTnsou7dYFXouPgO7v3M
         r2UNwu+SCxroJRY5ro58aiWuat5d3Mpsv1vYDrdM4p1/sOM5vyovXsBWmVkm7fLmWCaM
         i5iK8H9gTrcD9rYsmUoYtUc+07ovZvD5tYfVmXMEMgBQiD/mbhZ/BmUJu8yh1ZQOAHrz
         XjzjngXRuTi6HeCWbg0OM9sKeoIRFmGbEf7gnZAhcMSHVyqCJajqnHYNlkI6CG55K+JA
         z7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360034; x=1710964834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1HmNv+yMo2ZvddaEye/rC5NZtopLXcTAFzBOCzH5/s=;
        b=krix0BL6F9BQ+u8YW8ZnLy7p4suwCxVJZ7E8DGlDgHMNnfMr5dO2xxjWcJj3/4AvGM
         sfnL41XVXDihSg0fBsnJkhBdbZc0gPx2GeRA8Sc+jPYj3/o77AwQw5JtXt7nSlnV+YMs
         04Vt1o7LhcX7fWjJi21Ehy7AfC8YAVc8FmVFx2c9aXqWvSJcqelkmID2eySMa/QovayY
         AFbKGNEmlERqCB6/BeH9XzQRRvImCVpsf40OV+XC3vpTnMqQnd15gRYu2c3WvHvXW3jt
         MEjYCYafjcymlzGHPRmMtkLjPkere1YtDNta18HT/g5wA5CRLx8FNzpBWs22HEM1hHob
         5i7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdav9Lkp2KavjFwbsQIXVmdv1K/6FoOU+ycHUoYRqy3nLWQDI6m8/TQP9ZaNP7g2lEGdud7KYt8dSjzu+gKGW2L0a6kAMYePcaSWO9muKXlfVmtgEO+Lqm2sE9ifnKyq/gAiYNfAVr
X-Gm-Message-State: AOJu0YzrGde/Cwhr9J64DNDvRN12rp6HJ9gMXSE6ODfGEgCghrdFAVR/
	hNHoaW3hPUBCzOyhSSB4ShrDcAPCUxFXbXzlMCGmqvJ1b2misUQx
X-Google-Smtp-Source: AGHT+IFifPyXM1JWvUAQeP4T4qXLYuAC/uZ6RDCKhYihgRi/7pnFNXrW0vmQFdAzqMgt30VVdx46Gw==
X-Received: by 2002:a17:906:fb81:b0:a43:29e1:6db8 with SMTP id lr1-20020a170906fb8100b00a4329e16db8mr8815457ejb.9.1710360033769;
        Wed, 13 Mar 2024 13:00:33 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id rn16-20020a170906d93000b00a441a7a75b5sm5091731ejb.209.2024.03.13.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:00:33 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 13 Mar 2024 21:00:31 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240313200031.GD1938985@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-7-vassilisamir@gmail.com>
 <ZfH3P9dTiBHpjN5b@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfH3P9dTiBHpjN5b@smile.fi.intel.com>

On Wed, Mar 13, 2024 at 08:58:07PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 06:40:07PM +0100, Vasileios Amoiridis wrote:
> > Add a buffer struct that will hold the values of the measurements
> > and will be pushed to userspace and a buffer_handler function to
> > read the data and push them.
> 
> ...
> 
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> 
> dev here
> 
> > +					      iio_pollfunc_store_time,
> > +					      &bmp280_buffer_handler, NULL);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> 
> data->dev here
> 
> Are they the same? If not, why this difference?
> 
They are the same. I didn't notice it, but I will fix it for consistency.

> > +				     "iio triggered buffer setup failed\n");
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Vasileios Amoiridis

