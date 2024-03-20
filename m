Return-Path: <linux-kernel+bounces-109440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C81B881932
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CAFB21710
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670F85C44;
	Wed, 20 Mar 2024 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avjYfL9e"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7D33062;
	Wed, 20 Mar 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970512; cv=none; b=JfUDKUYkxUma7EKO+QRM4wwu+EtSNN50PCAge3ayKPdnzVJXl49tzKoA1aQ1qnDK60+9KJBv0N/MNi3ZgfemhZjO1LHpFcsWxz9FVPPHhxL8mPdG+YuxYLLQYf+XvudWC2UEoWtR7nRNSlsUy7zIBJf4BazG9+TSoHZWt+4IUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970512; c=relaxed/simple;
	bh=TcWmYjPumbIlPBomNV9YOOX92d2441jgONKaND86xeg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmV/udWm+iHCAEUuWsbBfVYS0E3ZHWcBnsO4/Amdhr8GUffWy1ezFTSY8PjXvEGGVotH2kORRGvn9UfE5hKMl7PS42ZBsV0Dt4DFVNq9o53nMByX9ueHGFtcHRfrO2bMu5E9ShmW36k1e4/7uHPcM++ioJEJkIfFjT2IJWE9HNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avjYfL9e; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso39510666b.3;
        Wed, 20 Mar 2024 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710970509; x=1711575309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2488KgiQz0Ozm6AmLdfbpRuHfsugl87Zu2zk1y9WHjg=;
        b=avjYfL9ekBibXEI6Upo8xCed7Fg/n83urK/8LViFVocshnqPdlWcK7vZi0OCIZzqUl
         kHbZ5i2LihT8PyHDxiiaI585WZAZV9IxLl5U8q30ZqYOogJQbwwXiOM0khkR8rQKJRz2
         NEkxHX+uEjvG8It03Cg1op58KVTXL6nh+G8u0M9a3RYMudoWNTakOHc6ybvxhqwkdxPk
         T6Gafkay7sIJOZbyrL9SvAnVB62Ik5VW6CWVEe2f/QeZVMF+cVj6EWFMspnl062Op0Ld
         AHs7RvzDmtt44nB1USbq9DHCHyVjNlu7nXalzGQVPihgA16OxDxKXDS04/Pz/VzJvg/2
         QSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970509; x=1711575309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2488KgiQz0Ozm6AmLdfbpRuHfsugl87Zu2zk1y9WHjg=;
        b=BH5ZjWY+myaYQ3NpAKLfdqeJFxc/0qS1lT4GQ1kzwstwa7ND1+hO6YEv140b0nZkZM
         +yXU2oKPpMHDSa/d1ToosazSPYhQ5ll8uQhsPGyIpMHti1RNyXztOQ3nHBJAUgcFfiOG
         HGkSEL1iE3uispwe4dWADI2XhdEal+Z0o/7hOCvPRtzy45IwAtCBBzxTeZ4WV7ucwD0K
         6CbNGXqa1A4lYqToWGSG54snJPXggZ4eeDTgYjJpAp3kBNZLybpqtaO6mk+Oo72rpHCL
         fDHC9WY1KgDzIEP1xpRPNOdbSxlnTz1EjnNwPUGdYXE+DsxazApok+BIzky56fBng8HC
         wNIw==
X-Forwarded-Encrypted: i=1; AJvYcCUElehLtkCmhx2x1z95VFzGMiQE+WfATOEl/W7TIlTNH88rBKxYRz/17j+fZa3Q7BGbq49PA3VhouQLmD0QTj8VkvUaEaTEUi+YRDr6ZfNMyQfbYguddG/6Tqd+WEafSpa3b6yMaxRG
X-Gm-Message-State: AOJu0YySKanz7YBm2I8EMZRcM/UWd6Kp4mT5MQ1+0pkLJq24s+33Ge6D
	B17WVrdqjKlY5IoscbfI/2h/wsN/IkzVpmMqSHKAJOd3yfeV/fdu
X-Google-Smtp-Source: AGHT+IH8szzncBG1aLLxaZjuATsI9dcfMdIIBEgaidEn0FkFhM1jMeSmv2gEXSy/ocnkY1wlGxOkow==
X-Received: by 2002:a17:906:4f18:b0:a46:a17b:c44e with SMTP id t24-20020a1709064f1800b00a46a17bc44emr84105eju.30.1710970508756;
        Wed, 20 Mar 2024 14:35:08 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9be1:7bef:ff5c:57fc])
        by smtp.gmail.com with ESMTPSA id wp2-20020a170907060200b00a46faaf7427sm964913ejb.121.2024.03.20.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:35:08 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 20 Mar 2024 22:35:05 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240320213505.GB52721@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-7-vassilisamir@gmail.com>
 <ZfrFc9GF0_Jix5YT@smile.fi.intel.com>
 <20240320174602.GA36450@vamoiridPC>
 <ZftUWg31QvA99syr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZftUWg31QvA99syr@smile.fi.intel.com>

On Wed, Mar 20, 2024 at 11:25:46PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 20, 2024 at 06:46:02PM +0100, Vasileios Amoiridis wrote:
> > On Wed, Mar 20, 2024 at 01:16:03PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 19, 2024 at 01:29:25AM +0100, Vasileios Amoiridis wrote:
> 
> ...
> 
> > > >  	/*
> > > > -	 * Maximum number of consecutive bytes read for a temperature or
> > > > -	 * pressure measurement is 3.
> > > > +	 * Maximum number of a burst read for temperature, pressure, humidity
> > > > +	 * is 8 bytes.
> > > >  	 */
> > > > -	if (val_size > 3)
> > > > +	if (val_size > 8)
> > > 
> > > sizeof() / new definition for the buf[] size?
> > 
> > In a previous commit that I was fixing this SPI driver, Jonathan had mentioned
> > that there is no need for a specific definition since it will only be used
> > here so that's why I kept it as is.
> 
> It seems not only here, but also in the buf[] definition in the struct.
> 

You are totally right, I didn't think of that!
It makes sense to use a definition.

Cheers,
Vasilis

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

