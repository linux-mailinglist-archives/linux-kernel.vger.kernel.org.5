Return-Path: <linux-kernel+bounces-61436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0085124F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26D71C21608
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05A63A1BB;
	Mon, 12 Feb 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="TvOtKisP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF43A1B5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737532; cv=none; b=VeR3rbq0ExeJJrKBgCy6S+di/EaYYiRix2CtH0NTFGyeuE0PGP9EHCvgO4l1iIeouSUA23DXa8QyVgjQAkAyBjOm7Mmg3n6WQzFgtB2NUc7I882HHL4JWxkAdjJ6LRbjPZKmiSO1Fu1NdwBJGs61gRyDrTl+fA/SbWsg2rThJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737532; c=relaxed/simple;
	bh=mehdPdtfuLlY3Wlmm6hizpCRq5FRHuXm40pRRmZ3ubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s31fY/XWt5On5TSggQmVcwtAGTsKtj9CJUc6tt+ujIllQq2Qwr58KxVw1/COREu5zKIgRV96S9fss2IATqRU6xvYoJFfWsMU3Avl4R8AJLwydvMR25FAszK1qwp4LuOfXu7CuOFC02md3BVhNxjxSWeaISUbcZrVP+/veoVoTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=TvOtKisP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7881b1843so27766435ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737529; x=1708342329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r1p4l3EWCvJjOeR6nbKxVHb2Brr41nykHfFVXGT0VkU=;
        b=OYTscRr5JlsAbT7BGLdWXTQXMvT3fmWEQv8l6hgR+Yj6odChN+UlOUHd0Qth/Ybs6h
         iIOVbNZmNt0xO46bIa3ehTLKxs1PDe72/LsBSRMUd8WeUS8emiZMgMkGRid/mGb2t1RY
         Z4SoYuO/XCDpr7y1n/7gVc9ZrWc1TWLk4fVfCmXLohgjLfCsU4AYpQpF7TINoKGtng2l
         8jjU/IT3EVfQnJ2G+pgzdrrUnD+XYSM9lKti1BVWCq69QpfSD22G6iLkdK5FS0G74LLL
         Up+qu6Adx4towAHMHaJaMHx5EYnyqI1TShekn92ZPHNCBYtP1LJLf0DDEzgu14eJQzDc
         D7eg==
X-Gm-Message-State: AOJu0Ywgi92z0S2upEdHtlN0U8MDcOpQT52pYtCRMlpTWOeR0Rr4UXj8
	rK/T+kNidftON1JnuWanNJM+Iusfp/VdJ9xYnaHewOL/wlTMrFenUjFqq/lpLw1m9Q==
X-Google-Smtp-Source: AGHT+IGsWOkEHowlUcxiDKbwtYLyUn8pVGHuR1OqUclHXd9BuXZi9tNoo/lOkw1S6fEErDH4UzbV8A==
X-Received: by 2002:a17:902:dacd:b0:1da:2a89:e5e4 with SMTP id q13-20020a170902dacd00b001da2a89e5e4mr4823100plx.59.1707737528898;
        Mon, 12 Feb 2024 03:32:08 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b001d937bc5602sm172399plb.227.2024.02.12.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:32:08 -0800 (PST)
Date: Mon, 12 Feb 2024 08:32:46 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707737527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1p4l3EWCvJjOeR6nbKxVHb2Brr41nykHfFVXGT0VkU=;
	b=TvOtKisPvjq33MEAambKuB2YbF2vYxqu5uLtq9rzmp4DWyX/ec3mofRAOfgG4JJ+LbQDpn
	R4M0De3X/MTtUjrKNDb9nyMx60GK+64fcEA2bWXudaE2oLxbF+q7RGVVIZ0eHkzIx7x1sv
	SwFiJjkKYC9xl9hd9GuwgP6zBp0W5/EJ8qvVqaFK8YGfSUBPnh/s9UgGuIJpswKjp3zePh
	7g4ciPwh292EWGFRE8G4EGG6xjwYflaeSKHDFTEiqQyn2JrJjfF8q5uQFHnxY4nOP6I7hj
	x7nQ2GNRnZpH8K4w5ElsCfCzsiwbLvAAuqQE/pXmymuC4c+zA2GjVjOgE1aqRw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: make dio_bus_type const
Message-ID: <kk66bpxu56ok4lgoeltesbahtyfduggesny2prbtbmtchx5u6h@mtibrwmxaymr>
References: <20240211-bus_cleanup-dio-v1-1-02140fbc5289@marliere.net>
 <2024021249-attentive-entity-70d1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021249-attentive-entity-70d1@gregkh>

On 12 Feb 11:44, Greg Kroah-Hartman wrote:
> On Sun, Feb 11, 2024 at 12:40:16PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the dio_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/dio/dio-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
> > index 69c46935ffc7..2d9fa6011945 100644
> > --- a/drivers/dio/dio-driver.c
> > +++ b/drivers/dio/dio-driver.c
> > @@ -123,7 +123,7 @@ static int dio_bus_match(struct device *dev, struct device_driver *drv)
> >  }
> >  
> >  
> > -struct bus_type dio_bus_type = {
> > +const struct bus_type dio_bus_type = {
> >  	.name	= "dio",
> >  	.match	= dio_bus_match,
> >  	.probe	= dio_device_probe,
> > 
> 
> Don't you also have to change this in include/linux/dio.h?

Indeed, I missed it. Will send a v2, thank you.

> 
> thanks,
> 
> greg k-h

