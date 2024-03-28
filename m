Return-Path: <linux-kernel+bounces-123373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62289075C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F62E1F25EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD412F360;
	Thu, 28 Mar 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Nbi9gXcO"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499C42AA1;
	Thu, 28 Mar 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647808; cv=none; b=KPALXklfqlTKL32bjD0+d+w542i0X7LAIJdXv/KhcXso9smwclC+LjiTD4tzH23z9fh/qL+cydju8bLMRt/2N9ua9mTPqdyZjjL/GGRR9M6VVi6bVvspJVDNrV06CFulQotQckQfbHw5q0Z5+vVvEdwQ7nL8r/V8/n21QW/GsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647808; c=relaxed/simple;
	bh=KXXurivZyV3iaL8JT2YK2Yn98ezt/cj9OLREbuE7Wb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrIpg+fdz8qw33ZCqCDwlqkUnSjzv4tr9pRbk45k46O4/ZdzWxdhHihyaXX0+yXm6jI0iqeK49k/qFcFeI63i/JDpkks6y2XS6Y5zD7vwCYgZ+M3zDIICg6wBhyA/Mvwc/PW5FIBwk1fu2GL+LwcqEe5ielH1Gdc732DechPOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Nbi9gXcO; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a56710cdccso488365eaf.3;
        Thu, 28 Mar 2024 10:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647805; x=1712252605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9vr5XsWFJLw7ybCrrKVxNz1sn6zwz/bJc/6H6RbUNG0=;
        b=dJ4RiPVgDQpg94eG5Thautu+ZQObu3NQ0Wiyp58nYegIlMcz0AS6+BvzviXj1Prt1c
         KiCinUkyv4rBhmtD5B6OZcPOeVOzFAnALSfv3Gws1Chy60IogSltybcVm2GQjrUk6+Ex
         RytNhCR/usBauupzCkaLg5TxHfmipBq0H5YU5LyGzb9CmCWwi0fEalKEN6Ig7dVGIK/y
         F1wNm/kfnAlu0sWGCv3VEqJ88sD9wnyOMeiAW//GskTWk5Q9iU1bF92exr/eB9u5tCdD
         CghhzLAgVd5e+RHMLWhq8vuLZuzbcg9LKuL7YRUkldzNhat5QrJkOdeu/JP0pjLlSHQl
         n7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUyiBzDajtZuw7C6sCRKp/XvCCEU5Km5cT81JC3mbxyyWUsSPGKUO9a0eHFg/B1QMFwrDrCK4gK9qyIxB/AOGsmx5JKufJ+11Esc4eAC8K37P15aPEiNVA8wephCigw/1zwC6WjNaYYJqc=
X-Gm-Message-State: AOJu0YxFhT5WZnuDHZcej4TgEEN8m0RoZWqjf9PVOTvuCSx20ByK1+YP
	CwxHjJMHar6/wT2CFSRRER0U8BfxjIPzmg8Qy96TfLiFFiff70NP
X-Google-Smtp-Source: AGHT+IHaNpbaz/HDGu7VcRVzlq5wmBVR+jd4KotHDGtbxum8Y0dFyx1RYgsRz1lnxxh3nMkEQZYc3Q==
X-Received: by 2002:a05:6358:8a9:b0:183:55a6:b239 with SMTP id m41-20020a05635808a900b0018355a6b239mr50469rwj.2.1711647805317;
        Thu, 28 Mar 2024 10:43:25 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id c192-20020a6335c9000000b005dab535fac2sm1545837pga.90.2024.03.28.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:43:24 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:43:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1711647802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vr5XsWFJLw7ybCrrKVxNz1sn6zwz/bJc/6H6RbUNG0=;
	b=Nbi9gXcOc5NcUrstW9X8nn8RlBwi2uHsy2Y32aP2LfHT9yVaTezwxWLxd8PgX5FGtM36DQ
	J2t1xftR/bP/t7FKdz2Y8CUF3W614ML3MHYihRpCfNNbc3+3dn2AjIhqOXzysJrVMP0hf7
	1UzenDadzbEhOnYdG0JsM64KojgNdSryHwTUmQ5K8wDfQNgAymvxvXo8ChVeK6LJUTqoE3
	z8u5RzABxwyrQq0C2ZsxGqMXCzHOLLoFtif0v5pfic0F/IM3bjrl5D17HlBqnMrDxFcR+0
	kQ0rIy8dWwO9Ca3kh1eplvOwhTvsqGcGLWY01wc5zsbRNYczMrUG/EGIdHCskQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] video: backlight: constify struct class usage
Message-ID: <zzbvkpcaxgmj3t5qzgiacazsaf5cfn7vjopt56c3ngfvtiskq2@igc4vue7ltqp>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
 <20240328114131.GB13211@google.com>
 <2024032816-tightrope-lushness-00f1@gregkh>
 <anuaxqt2zlravjpepkuhqmii3adjdeh3lzal3wwb7rg7krv6uu@7sbwczq3flot>
 <2024032817-avatar-agony-c17d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032817-avatar-agony-c17d@gregkh>

On 28 Mar 17:49, Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2024 at 09:46:01AM -0300, Ricardo B. Marliere wrote:
> > On 28 Mar 13:01, Greg Kroah-Hartman wrote:
> > > On Thu, Mar 28, 2024 at 11:41:31AM +0000, Lee Jones wrote:
> > > > On Tue, 05 Mar 2024, Ricardo B. Marliere wrote:
> > > > 
> > > > > This is a simple and straight forward cleanup series that aims to make the
> > > > > class structures in backlight constant. This has been possible since 2023
> > > > > [1].
> > > > > 
> > > > > [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> > > > > 
> > > > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > > > ---
> > > > > Ricardo B. Marliere (2):
> > > > >       video: backlight: make backlight_class constant
> > > > >       video: backlight: lcd: make lcd_class constant
> > > > > 
> > > > >  drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
> > > > >  drivers/video/backlight/lcd.c       | 23 +++++++++++++----------
> > > > >  2 files changed, 29 insertions(+), 23 deletions(-)
> > > > 
> > > > No longer apply.
> > > > 
> > > > Please rebase on top of v6.9-rc1 or for-backlight-next.
> > > 
> > > As I already had this in my local tree, I've sent out a v2 at:
> > > 	https://lore.kernel.org/lkml/2024032805-putdown-mushy-a0f9@gregkh/
> > 
> > Thank you Greg. I will see what is left to be made const for -next.
> 
> Many of your patches were not picked up for -rc1, I'll be taking a bunch
> of them into my tree "soon" as that usually means the subsystem isn't as
> active.

Yup, I was keeping them in my inbox so as to resend but if you could
pick them that would be great!

Cheers,

> 
> thanks,
> 
> greg k-h

