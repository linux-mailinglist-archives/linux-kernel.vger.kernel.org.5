Return-Path: <linux-kernel+bounces-79849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD67862791
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05D21F22490
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6D4CB36;
	Sat, 24 Feb 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bE2cP/h8"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611844CE04
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806111; cv=none; b=N+iyAifvqn2Sn8ByezdhvCnwjWMyGkCf9m7PKDVgqUs8i5TsdQ8tzWBz7Japw81xTTYK/OvBVP0mxm069XIyxFL0pDXWsHN3bO7gk8qhgGsRcKoSTFfdKy1Vz8UXiA7X3C8F741c1FydXol4qJ2SsRkkl6EvpZOsY2pqjzMFPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806111; c=relaxed/simple;
	bh=ehZ08gU4FIWv5pM7BAGY94VZDeKNtJCzDFKzK4Oxtz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiVkq1YbupwQRCK+Vq4wSuyu20NBhHs3vJ8kMfgktJTmdazdqNP435z4wPwsV50aLTIcPc/zpDQ6y697CX5BOvyFZDfPBTQLAxjavw/3QZ458e31rULV8t4dLo8iO1V7YPiCmLwDH7ISuEOfS/D7xfZxsqOoYphsUuTg2nFQ4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bE2cP/h8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71cb97937so22157815ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806108; x=1709410908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ipyqjxXJNlrJUdv0Iam1Q+/TnUziHOnI8o1nibDPQf0=;
        b=QEImeuwFF8m+PEEdhJqk0jb2gxQ3uibvhQGUSXumULlRwzbXUezccoe6tA5FHsNazi
         Hh6MrKQFlKNAF/+8quF7aMyWsEDble611c3ntn03mn1tyoMRayH4sAnxgMoy3yCn3L0U
         DA5GiU6qs816YyVwzTUyfvFSldsVFkGGojpYerPyvoOofBYwAXnI44Mju7sqypCfDPCa
         xEU9D6TVQTA0FLLLmaykW6p68bqeh+CxK5c93EtJ6sZgjk/RVRveYUeqwrtxLM4kMAS2
         YaUtkGOcMSqGokKhwbHH1dvSiy2kXRDTbxWR7C+ntXWrPJYoQhHIZ5BUcYXxYPK/lGBz
         GojQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdb4VeFHSBCqCSc7H7vmhvPJMrfNEhYqpSafzr76gh8Hm8UMBzYYABro0davk92YEZM35ozJleu3rsHZBqSvMTmjzUjmUfNAO4S16p
X-Gm-Message-State: AOJu0YygjqT/Z5hB0GBrw/CZ7AJw9M8wgTMSp79uR6HSMK+weZ/+Ls5c
	NBSB2FwE+MqV9Lx/oAGD3kHqYFsgjLz0utsJbXMhM5FcWYPnrqn2
X-Google-Smtp-Source: AGHT+IEB9ZAcUcWJxBZNiuJpwHkCTd/u8mb2e+ap9YQDA02JMHvrCMODH3NPu20hCv96rcjn9Tir+g==
X-Received: by 2002:a17:902:9f8f:b0:1dc:2755:16d2 with SMTP id g15-20020a1709029f8f00b001dc275516d2mr2725428plq.18.1708806108528;
        Sat, 24 Feb 2024 12:21:48 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902b78800b001db28ae5d81sm1346259pls.159.2024.02.24.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:21:48 -0800 (PST)
Date: Sat, 24 Feb 2024 17:22:39 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708806106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipyqjxXJNlrJUdv0Iam1Q+/TnUziHOnI8o1nibDPQf0=;
	b=bE2cP/h8/p0/ZKYP3QQ19ChoJxBA33csYHusYKf39XINlAwisC3LvRFCgp2scPkbwuHqMC
	61Eep3vtb8j5QTOdPFyfEBMdlPpIlaEOL8CC6CaJj1uyff7JB8jCevzVxTUetw+5jLkNZX
	ibOG8H6nJiRalo4j6dcRtjT+m8KiBSZzRE/da4NrlAUDTBB2WYG/MYzzq4WEKUoFJpd67h
	3nMj3SJdAhL+xhYBXRE9H2nOQz2f2V+AxAWx4OZcUk34mcvk8wtlgS8Q3fFk9sw5bamBW6
	oN76eJW87IVn/DPZGKRTytYGMRHk+6E6O9SpZF28Qkd4PrVYd6aY/ed6u8e7qw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Alex Elder <elder@ieee.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Message-ID: <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
 <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>

On 24 Feb 09:43, Alex Elder wrote:
> On 2/19/24 6:40 AM, Ricardo B. Marliere wrote:
> > Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> > core can properly handle constant struct device_type. Move the
> > greybus_hd_type, greybus_module_type, greybus_interface_type,
> > greybus_control_type, greybus_bundle_type and greybus_svc_type variables to
> > be constant structures as well, placing it into read-only memory which can
> > not be modified at runtime.
> > 
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> This looks good to me.  Assuming it compiles cleanly:
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Hi Alex!

Thanks for reviewing.

> 
> On another subject:
> 
> Johan might disagree, but I think it would be nice to make
> the definitions of the Greybus device types as static (private)
> and make the is_gb_host_device() etc. functions real functions
> rather than static inlines in <linux/greybus.h>.
> 
> It turns out that all of the is_gb_*() functions are called only
> from drivers/greybus/core.c; they could all be moved there rather
> than advertising them in <linux/greybus.h>.

I guess it depends whether they would be used somewhere else in the
future. Perhaps it was left there with that intention when it was first
being developed? I agree, though. Will happily send a patch with this if
desired.

Best regards,
-	Ricardo.



> 
> 					-Alex
> 
> 
> > ---
> >   drivers/greybus/bundle.c    |  2 +-
> >   drivers/greybus/control.c   |  2 +-
> >   drivers/greybus/hd.c        |  2 +-
> >   drivers/greybus/interface.c |  2 +-
> >   drivers/greybus/module.c    |  2 +-
> >   drivers/greybus/svc.c       |  2 +-
> >   include/linux/greybus.h     | 12 ++++++------
> >   7 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/greybus/bundle.c b/drivers/greybus/bundle.c
> > index 84660729538b..a6e1cca06172 100644
> > --- a/drivers/greybus/bundle.c
> > +++ b/drivers/greybus/bundle.c
> > @@ -166,7 +166,7 @@ static const struct dev_pm_ops gb_bundle_pm_ops = {
> >   	SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
> >   };
> >   
> > -struct device_type greybus_bundle_type = {
> > +const struct device_type greybus_bundle_type = {
> >   	.name =		"greybus_bundle",
> >   	.release =	gb_bundle_release,
> >   	.pm =		&gb_bundle_pm_ops,
> > diff --git a/drivers/greybus/control.c b/drivers/greybus/control.c
> > index 359a25841973..b5cf49d09df2 100644
> > --- a/drivers/greybus/control.c
> > +++ b/drivers/greybus/control.c
> > @@ -436,7 +436,7 @@ static void gb_control_release(struct device *dev)
> >   	kfree(control);
> >   }
> >   
> > -struct device_type greybus_control_type = {
> > +const struct device_type greybus_control_type = {
> >   	.name =		"greybus_control",
> >   	.release =	gb_control_release,
> >   };
> > diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
> > index 72b21bf2d7d3..e2f3496bddc3 100644
> > --- a/drivers/greybus/hd.c
> > +++ b/drivers/greybus/hd.c
> > @@ -116,7 +116,7 @@ static void gb_hd_release(struct device *dev)
> >   	kfree(hd);
> >   }
> >   
> > -struct device_type greybus_hd_type = {
> > +const struct device_type greybus_hd_type = {
> >   	.name		= "greybus_host_device",
> >   	.release	= gb_hd_release,
> >   };
> > diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
> > index 9ec949a438ef..a88dc701289c 100644
> > --- a/drivers/greybus/interface.c
> > +++ b/drivers/greybus/interface.c
> > @@ -765,7 +765,7 @@ static const struct dev_pm_ops gb_interface_pm_ops = {
> >   			   gb_interface_runtime_idle)
> >   };
> >   
> > -struct device_type greybus_interface_type = {
> > +const struct device_type greybus_interface_type = {
> >   	.name =		"greybus_interface",
> >   	.release =	gb_interface_release,
> >   	.pm =		&gb_interface_pm_ops,
> > diff --git a/drivers/greybus/module.c b/drivers/greybus/module.c
> > index 36f77f9e1d74..7f7153a1dd60 100644
> > --- a/drivers/greybus/module.c
> > +++ b/drivers/greybus/module.c
> > @@ -81,7 +81,7 @@ static void gb_module_release(struct device *dev)
> >   	kfree(module);
> >   }
> >   
> > -struct device_type greybus_module_type = {
> > +const struct device_type greybus_module_type = {
> >   	.name		= "greybus_module",
> >   	.release	= gb_module_release,
> >   };
> > diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
> > index 0d7e749174a4..4256467fcd35 100644
> > --- a/drivers/greybus/svc.c
> > +++ b/drivers/greybus/svc.c
> > @@ -1305,7 +1305,7 @@ static void gb_svc_release(struct device *dev)
> >   	kfree(svc);
> >   }
> >   
> > -struct device_type greybus_svc_type = {
> > +const struct device_type greybus_svc_type = {
> >   	.name		= "greybus_svc",
> >   	.release	= gb_svc_release,
> >   };
> > diff --git a/include/linux/greybus.h b/include/linux/greybus.h
> > index 18c0fb958b74..5f9791fae3c0 100644
> > --- a/include/linux/greybus.h
> > +++ b/include/linux/greybus.h
> > @@ -106,12 +106,12 @@ struct dentry *gb_debugfs_get(void);
> >   
> >   extern struct bus_type greybus_bus_type;
> >   
> > -extern struct device_type greybus_hd_type;
> > -extern struct device_type greybus_module_type;
> > -extern struct device_type greybus_interface_type;
> > -extern struct device_type greybus_control_type;
> > -extern struct device_type greybus_bundle_type;
> > -extern struct device_type greybus_svc_type;
> > +extern const struct device_type greybus_hd_type;
> > +extern const struct device_type greybus_module_type;
> > +extern const struct device_type greybus_interface_type;
> > +extern const struct device_type greybus_control_type;
> > +extern const struct device_type greybus_bundle_type;
> > +extern const struct device_type greybus_svc_type;
> >   
> >   static inline int is_gb_host_device(const struct device *dev)
> >   {
> > 
> > ---
> > base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> > change-id: 20240219-device_cleanup-greybus-c97c1ef52458
> > 
> > Best regards,
> 

