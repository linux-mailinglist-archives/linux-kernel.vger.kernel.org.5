Return-Path: <linux-kernel+bounces-38486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93D83C08C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143F8297C33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236D3589C;
	Thu, 25 Jan 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au2ErUE/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B733CC5;
	Thu, 25 Jan 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180940; cv=none; b=jSL0FOKxewHDqWVL0iJdR/LbXwIEOyJNvFPVlSG7FDlWN8hbSBtb7LfgQJl+nL9XY8+J+JgJe5EDJlkFHQTxbWkApdJCU4XHtoj5tjeBOoFKEYNbR90e92aszqbNhNODrwjbY9sHtH5Tfp6CoWZuo+PQfD/ABW8wjszvXT7IP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180940; c=relaxed/simple;
	bh=0gSrtphXWM/KvtBldBJdsfycTt9idhUJiXrIZWEUnZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAeih0LNfXA1sw/ZULc4+fVmJjT2IP+WfiNyYRtoNabTpczRYsomKNzuDE1UY3iWwxFEQ1jbf+ei/ziGNV6z3+KmmtEleu5v6+GilmiTWGQK3YRuav/wa3GChgHmR7UgFPn9Zms02n9nDPkLAbjudfF/ZccKya++d2EamyX2izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au2ErUE/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55cd798b394so1170444a12.0;
        Thu, 25 Jan 2024 03:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706180937; x=1706785737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GHNBu5aNFDFsMch1xBt9J/kX0LTQtMA0cQmPO85BtRY=;
        b=au2ErUE/naIbpnSikCgUXu/H3K8JNmzrwLkjrNF6+FNvvoqp7eq1CvSdrWVKDOCdFj
         8G4H/KLu133adz/adzt4/Zf60VGxxhkOpRz9zhp0Gcl2zSV+2CGRIlOVZxYXadf0xfUf
         1Yl/DtrMubcEjZuqJX0iOzgBkg9SK/ff8dwzlPjFEP+ckVfFmZKCRRzVxJAz+6G/HmW9
         mtwRBJtmR93PBqJq7yMNZwB5FaxRXzkAnjS0TNoJelRPh+BPVZCiSc7nCTkI01/4y0B5
         ERHfoNtoGZZvf5xzn6JaZQGkfy9+wDWkezxOjI4ykTJCUjJmE6vvd0U4FLBeJAyT6Rh8
         eqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180937; x=1706785737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHNBu5aNFDFsMch1xBt9J/kX0LTQtMA0cQmPO85BtRY=;
        b=NB9W25MdGFnzUIdUVMjHO7iIjWDfEpnP6d47qBRKkTjx/HPrWcsxtRosbsZwnn7yHH
         CkozFFvrjd8tJ9HVdFJ2mBW1GZjKLcm1nvQEXTlMObFAChRzgW6slf7MdHhr90Cs7lH0
         2zl5sN9VcCoXqq7RlrSaPByA1QasRzmUoj0hO9Z3ZVweJflbcM2EHRUBKraRz1hGNQOM
         rYcZLeS7buiWlyMmeDlLWu9j0HpVTN/5YNLQIr9/83GK3lSk+Sh3blfdY/2zJEvTd3Jh
         GRnCFYQZ1rTuTXPIP102xs2Wvk//Lz0R04fiazvoJKlurY+zwhvWhs2BgsPtt9cWoVnt
         z2Ow==
X-Gm-Message-State: AOJu0YzCBEivVQYJwyZIu+0PGiEDu9l9hMzt0avZrQg9UxIqkndxL7uo
	Zk7YupNRaXCospW5QX5BOAiCVvnPOhohsgWUwwg3kDX8nQqIFcS6+17Zfg5B
X-Google-Smtp-Source: AGHT+IHpgTaSzlDtbOLB8OZpEYdIlfVCyrmAh/MYOXFXcElfV5LZi9juklHVeDuYJ+GjrEVkRDc23w==
X-Received: by 2002:a17:907:1b1f:b0:a30:e9a6:68f6 with SMTP id mp31-20020a1709071b1f00b00a30e9a668f6mr1209185ejc.37.1706180936566;
        Thu, 25 Jan 2024 03:08:56 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id l8-20020a1709066b8800b00a2f168ca475sm921520ejr.140.2024.01.25.03.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:08:56 -0800 (PST)
Date: Thu, 25 Jan 2024 12:08:53 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: fix temperature offset
Message-ID: <20240125110853.GA3857099@debian>
References: <20240125102641.3850938-1-dima.fedrau@gmail.com>
 <0a98e54735cc2a97f393eef6b1cdaf27c946d10e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a98e54735cc2a97f393eef6b1cdaf27c946d10e.camel@gmail.com>

Am Thu, Jan 25, 2024 at 11:49:25AM +0100 schrieb Nuno Sá:
> Hi Dimitri,
>
Hi Nuno,

> On Thu, 2024-01-25 at 11:26 +0100, Dimitri Fedrau wrote:
> > The temperature offset should be negative according to the datasheet.
> > Adding a minus to the existing offset results in correct temperature
> > calculations.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> 
> This is a fix. You're missing a Fixes: tag in your commit message.
> git log --grep="Fixes:" should give you some examples...
>
Will fix this and resend the patch. Thanks for your help.

Best regards,
Dimitri
> With that, feel free to add:
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 
> >  drivers/iio/humidity/hdc3020.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > index 4e3311170725..ed70415512f6 100644
> > --- a/drivers/iio/humidity/hdc3020.c
> > +++ b/drivers/iio/humidity/hdc3020.c
> > @@ -322,7 +322,7 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
> >  		if (chan->type != IIO_TEMP)
> >  			return -EINVAL;
> >  
> > -		*val = 16852;
> > +		*val = -16852;
> >  		return IIO_VAL_INT;
> >  
> >  	default:
> 

