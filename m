Return-Path: <linux-kernel+bounces-163910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD8E8B75A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797011C21E12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3F13FD8D;
	Tue, 30 Apr 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2Komikw"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEC13D633;
	Tue, 30 Apr 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479836; cv=none; b=Io1E1i+1VNtJbAg+N+8P/Yq26MobyOI8MnIgx/dW6fFbyass4WdFCIzlggvpitUZ1EMVGyOiSV/ZqbmBN4YrXhGK6yvKweovbBW3UvIr/l5HqtW3asFlvculyKQrCgpyMuB2k+NqwxVmEw5dwQ8jqXjvaa0XA9AihJfQZCuK/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479836; c=relaxed/simple;
	bh=WWLv3CHIm9s7TAl+zioxwnWBii/PyN3HMDQfYT3g4Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxx2WNKM7EHOibs8+1ukAGTZWT0yoh5zD6qXAB6aQhP0KRooxWY04XAU4jOjGHUwTYKtkQRCSOAd3XajmEHoap+wGjDuFEnpTzsTFHJVQ9hH3pZNi0ciwWJc4qzD4oVDRVLiyskPQFDJINuyuBQJH2kbJRvFYzKIPEU2Pkbktsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2Komikw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso68524471fa.1;
        Tue, 30 Apr 2024 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714479833; x=1715084633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3HAypglzqN6U0QsC7A4U1xuU1yi1lv7rpj/nALDr2w=;
        b=d2Komikwmnz2m4qkDwihKKLLrLRq4RAzqBrGrI0VP3UUiXKyo7vyHqs78BinzA45k2
         GNw/ACHP29q+1LgmpHSHYndN8VnEwqtuBTWiupnSiXAYonMD6qnShrFNvM6rBb4Rz4H5
         QshDK2PnQLH8fsbPQKNY1v3sEbJW8CX1ZHhW5pnJOnTNh2MWvWZbs+6FBC8AM+oKnE+J
         3ktNnzkuze+TqwBcX1pVmDt7PhTUNFsNU6AD7F8ertgD3mEJWQ2zOxzNGQspOEr1Lujq
         Rdk+SerZla3U4s7thEICDSHThdbngshL1T1VFpdxjJFsIEoTzatMS9BjcHv+ZMSU32xG
         q7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479833; x=1715084633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3HAypglzqN6U0QsC7A4U1xuU1yi1lv7rpj/nALDr2w=;
        b=a2mKRNi45y0i3V8xZoykYbYoIxI3Ujq2E0DVkC0Aq1PXqGkqJmfaVH6t3zfjb17twg
         I55Jk1ly40A0ONBnvGcK2ltUNh10gkomJ1Q2uW1ijDcmXYrx6HSQvm7FlFQhNCnfFgMi
         P/3Cn45/Iq/F0FEKQk46kyzDDyRxirfOFRBB0RkMn7YKd6O62a3l+ORLJbMQmtBDOtdD
         +LR5Vuu2kBKWyx65YD0u0QzGAy10ElvupRJsldQtl3Qsy6oKgXUosW9Lzw+CIHFtVMLj
         9ugrkaW2x9QkgZVqZV/Ni916OBVVjD4F5teBUzDMbG2bwPtrQ6qU79wrvipuC6bY3jpb
         awBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMdFUZKBrTZZqFpIA2+8aDzrjfc3VNV75UosHdTVhY8daVU9/EGNFqe/ketH6D0B3ZA4VNi8O7QGkrNINuCiYk77FjOJK6XYC3YWoLz1UxA8m6lw7dWiHZcph8NxJWIYcb8onECsU0
X-Gm-Message-State: AOJu0Yxhf7JVvXzUDRrYDHY59a4MQgOvOdv/POZOE1Q4NW2YbLXYIQ94
	y0I3om1cE3xw5cPOJf/rugh8p1zcrfhz+LszMHpuRVBwISyp03gu3gdmIA==
X-Google-Smtp-Source: AGHT+IHEVfzlX0uNTD10J6KfMRRtL5PFFP9TO8mxGuF4fj5hAI1IdFduDv9u/aUE0QgVJkosFQjAig==
X-Received: by 2002:a2e:8348:0:b0:2de:d4df:54b8 with SMTP id l8-20020a2e8348000000b002ded4df54b8mr10750866ljh.7.1714479833111;
        Tue, 30 Apr 2024 05:23:53 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b0041ac4aafd3dsm26535780wmo.12.2024.04.30.05.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:23:52 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:23:50 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: temperature: mcp9600: Share scale by all
 channels
Message-ID: <20240430122350.GB46332@debian>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
 <20240430120535.46097-3-dima.fedrau@gmail.com>
 <20240430130934.00006d33@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430130934.00006d33@Huawei.com>

Am Tue, Apr 30, 2024 at 01:09:34PM +0100 schrieb Jonathan Cameron:
> On Tue, 30 Apr 2024 14:05:32 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Move bit IIO_CHAN_INFO_SCALE from info_mask_separate to
> > info_mask_shared_by_all since temperature format is the same for all
> > channels.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> Whilst this shouldn't be a problem for well behaved userspace,
> it is an ABI change so as a general rule we don't 'fix' cases like
> this once they have been in a kernel release.
> 
> We may be break someone's hand crafted scripts :(
>
Ok, will remove the patch from the series.

Best regards,
Dimitri Fedrau

> 
> > ---
> >  drivers/iio/temperature/mcp9600.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index e277edb4ae4b..74e0782fb073 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -28,16 +28,16 @@ static const struct iio_chan_spec mcp9600_channels[] = {
> >  		.address = MCP9600_HOT_JUNCTION,
> >  		.channel2 = IIO_MOD_TEMP_OBJECT,
> >  		.modified = 1,
> > -		.info_mask_separate =
> > -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
> >  	},
> >  	{
> >  		.type = IIO_TEMP,
> >  		.address = MCP9600_COLD_JUNCTION,
> >  		.channel2 = IIO_MOD_TEMP_AMBIENT,
> >  		.modified = 1,
> > -		.info_mask_separate =
> > -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
> >  	},
> >  };
> >  
> 

