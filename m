Return-Path: <linux-kernel+bounces-147550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CA8A761B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11463282131
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C06BFBB;
	Tue, 16 Apr 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmcd84tO"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CE5A116;
	Tue, 16 Apr 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301694; cv=none; b=poN922tUYUOXH/xoQxdPrI2SCljLf95TQjEomVjuwWT0i3DND+M6bpSW3krpalaeyg0MgL34O7uRTbRmRAXvDV/JrYL28jwUhzy447e2r+hYz1ziEKMRB8bMTVeqyCdtASXPbMV4wakpy1FVF0L9iwnL7gCGepFCyuYKXAr0RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301694; c=relaxed/simple;
	bh=cVRfsInjV4PY1kypj4NTkJ8QGpl3sEUZhiB9xb82I3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv/kCsCwcGqcluXIXguITo3vO7hb1V+EoKvHdLBrrtn1Bf8lcWjlBGwEB4FETDBsRnv/XazqMb5o+nW/DFWRWFDEFvCXYWTm0AP6cFHMnyg4L5mn11Lvevtf81spwC354Ghj2nQqcSQJKbANn7yCV7voA0uXFkrbeHZUeKfOOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kmcd84tO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso3813279b3a.1;
        Tue, 16 Apr 2024 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713301692; x=1713906492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i331i1Wcy5r/lDRFeghXmoWu6lGxaTU061BqljzeiVk=;
        b=Kmcd84tOCxod5e9zwD3Fxg+ZRIBfMn4AOBeIUt3rC0llJHcRgtcW0dWVdWVwWwd4Sg
         JazfHbp7LrHWF3akmohcqKyv7FXonzbumCSZFvo7Udy3+ahikjxGaMdXCjTJRyb9pJWj
         wibgo6ZUlgsTzwmpCzpAytbuBzXHUXYHxN4YGvb7TcQbobZxcZtK7Pu9BcaeKZJlcjzH
         Dl1R2F7+sBeahSlI8/qj0x2xx+OlMKRmmuG67f78qywzeGwlG1UUK/PCsgqT8PfGh/4W
         +AWY6ziA5AT73SEpZ0xq3WvX3RrMT7TqpoXi6DyI7uRiwlwGtvJbSSG5d1d0lvRhME6n
         RwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713301692; x=1713906492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i331i1Wcy5r/lDRFeghXmoWu6lGxaTU061BqljzeiVk=;
        b=rkhJzLnBujUzQAFTyKF1VDaU71LHhC9JULJ2EESKYkwor4iVsH4vqjBgeOa5wSV052
         iwQVKrlTjdpcvYRpVvFRQXZnH2/vtuSWymldSXOULXju8lHkgem4K9ht9P4Pc5LI2Rzr
         vNS+BcLXlnfdk1JbAVMhobSJZNGpcI4/COyQNKq9Wsg/IZKvAwFYdyMab9Env8vryZ+X
         zZ+ko5Y5XbtK14yaGQlRpfW6QbSHJgornRtqi0Cu+NBS/r4HxMACaFhoLWX3kfW11j/T
         fXdKg+xekpUZklLk12BkKq/vXzgwVWGCKBK9y9kjiUURMWKHp7lD2rtHOCsT45pmm/2z
         w9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/yZ4qW06okP2To7YdmPPnUWzh5zdVxoKDC741llBtjrfFCUdc2802WB/sY9BU2YJxC0yvzKFN7vXf5zjIra/LDVm0vSDGh/oFKirUWxzMF+Ize0qp+M0upzE3IuxIaxPPepQO8dvmM2XdjL1dvJmPLmh9JjZaU4Y8zcbSOf8sLHNTyVAeCUPDguQBEz3/
X-Gm-Message-State: AOJu0YxkRd6sX6FZ0nKjlqqOf7xYA5qPNdIpLnPpCWE96UWg3pyDHAUR
	zEFLUKganSamrFn6ph2n4chglSYBS1cEjxL6r3NzKROtkrYpNUeS
X-Google-Smtp-Source: AGHT+IHHi3KdjnjY0V9UEzcg8HtLCOxWhI6RMCOGq0dHKinG4EJl4xSHwSXlUd7jG9SeBpwVzdTetg==
X-Received: by 2002:a05:6a21:3405:b0:1a9:f44b:98f6 with SMTP id yn5-20020a056a21340500b001a9f44b98f6mr7502419pzb.15.1713301692028;
        Tue, 16 Apr 2024 14:08:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c21-20020a62e815000000b006ed0199bd57sm9734902pfi.177.2024.04.16.14.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:08:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 14:08:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
Message-ID: <8d62af9d-281a-44c0-a40c-93ae76827705@roeck-us.net>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-3-luzmaximilian@gmail.com>
 <43908511-198f-42ee-af21-dad79bdf799a@roeck-us.net>
 <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>

On Tue, Apr 16, 2024 at 09:00:05PM +0200, Maximilian Luz wrote:
> On 4/16/24 3:30 PM, Guenter Roeck wrote:
> > On Sat, Mar 30, 2024 at 12:24:01PM +0100, Maximilian Luz wrote:
> 
> [...]
> 
> > > +static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
> > > +{
> > > +	struct ssam_tmp_get_name_rsp name_rsp;
> > > +	int status;
> > > +
> > > +	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
> > > +	if (status)
> > > +		return status;
> > > +
> > > +	/*
> > > +	 * This should not fail unless the name in the returned struct is not
> > > +	 * null-terminated or someone changed something in the struct
> > > +	 * definitions above, since our buffer and struct have the same
> > > +	 * capacity by design. So if this fails blow this up with a warning.
> > > +	 * Since the more likely cause is that the returned string isn't
> > > +	 * null-terminated, we might have received garbage (as opposed to just
> > > +	 * an incomplete string), so also fail the function.
> > > +	 */
> > > +	status = strscpy(buf, name_rsp.name, buf_len);
> > > +	WARN_ON(status < 0);
> > 
> > Not acceptable. From include/asm-generic/bug.h:
> > 
> >   * Do not use these macros when checking for invalid external inputs
> >   * (e.g. invalid system call arguments, or invalid data coming from
> >   * network/devices), and on transient conditions like ENOMEM or EAGAIN.
> >   * These macros should be used for recoverable kernel issues only.
> > 
> 
> Hmm, I always interpreted that as "do not use for checking user-defined
> input", which this is not.
> 

"invalid data coming from network/devices" is not user-defined input.

> The reason I added/requested it here was to check for "bugs" in how we
> think the interface behaves (and our definitions related to it) as the
> interface was reverse-engineered. Generally, when this fails I expect
> that we made some mistake in our code (or the things we assume about the
> interface), which likely causes us to interpret the received data as
> "garbage" (and not the EC sending corrupted data, which it is generally
> not due to CRC checking and validation in the SAM driver). Hence, I
> personally would prefer if this blows up in a big warning with a trace
> attached to it, so that an end-user can easily report this to us and
> that we can appropriately deal with it. As opposed to some one-line
> error message that will likely get overlooked or not taken as seriously.
> 

I have heard the "This backtrace is absolutely essential" argument before,
including the "will be fixed" part. Chromebooks report more than 500,000
warning backtraces _every single day_. None of them is getting fixed.

> If you still insist, I could change that to a dev_err() message. Or
> maybe make the comment a bit clearer.

dev_err() would be acceptable. WARN() or WARN_ON() are no-go.

Guenter

