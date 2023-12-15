Return-Path: <linux-kernel+bounces-1826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F42815493
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D790928584B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE741CA9D;
	Fri, 15 Dec 2023 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHwb3tb0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A4495C9;
	Fri, 15 Dec 2023 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b9e2a014e8so981724b6e.2;
        Fri, 15 Dec 2023 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702683221; x=1703288021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hMnTlRGS/PXAXBP5TPslgIi8w7BTIAAQCZQIaoU8eQ=;
        b=HHwb3tb01uNXh/jLi3nQLIRLGs9CYcAsNVX393SALLkkbB3COBASkv9Y+bhd7BePJh
         dGNr+v1CkuapkAEHcSzcOi+QnPaWVQzq3HyFNX3nVppEZVqGGmDoT+tGM6oHap8XJdIo
         NV1WODxhJbmf8Pu6TmEYfkVnImHUfaqlax8OCeBIGSwGxZMwwD2K2/6KPz800c/OFhOA
         GrLN1mja+Q62SEtWpv4EEg3dXPQA/etDI6JEplsThOxndz5UrrCq3VC1sfqlb1Xn5ym8
         cVvpeNpiyq+K94qB27gsoJrvKfzNlYcpUcEzYFq1xSVnpYCwS5Fx1CQja3SEUIhPVdvH
         XUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702683221; x=1703288021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hMnTlRGS/PXAXBP5TPslgIi8w7BTIAAQCZQIaoU8eQ=;
        b=ZdsaPK11xeq2pZb1owqgC68A3YK+vHPPVUZqktp0XNIljMnsvGpA/aPqfNJaiA5kcp
         94u+hiHTT+wdxf4Wb456LVMTXUC5UMI7K5xXdu4E4f9FCjgbtNtDvUwmyr/zMV2v/SSm
         jBdqOhIUgjdoVAfAdq9Tq7T+FQ4SbDyDuH9LlEvSE7IDaf34OCTSswmKnIyVnuj76YtJ
         s/XVEi8nUDWM4iMH/F/HKiG3pHAVhGuDJTqzD7A4KO1tDK6EptqJ4rplfoNdGhLtd2+4
         jIPFCGtjNVPcvj+4Ov4hO9aQFQd7oyzh8GF1+KeFAimYS1TAQVxFOindmcx1FafH98N0
         qc3g==
X-Gm-Message-State: AOJu0YzAAEIok3dlbD1wKdRSqxn+YEz1H/ZcrPcb+9MN49JyXxE6K+Qk
	jnX0Mh/bSRIGWRJTFzjTnAVGeUxYIKY=
X-Google-Smtp-Source: AGHT+IFt6HYJ/TQPfxqy8q2sMFCyk3omOehMQg5P3QqDOGTONmqpvsXvJNqg8cv6+Quv718plUhXwA==
X-Received: by 2002:a05:6808:6494:b0:3ba:10b1:7a1e with SMTP id fh20-20020a056808649400b003ba10b17a1emr10299294oib.5.1702683221569;
        Fri, 15 Dec 2023 15:33:41 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001d36df58ba2sm3463505plb.308.2023.12.15.15.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 15:33:41 -0800 (PST)
Date: Sat, 16 Dec 2023 07:33:37 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH v3 1/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXziUYicXaENTDk_@rigel>
References: <20231215023805.63289-1-warthog618@gmail.com>
 <20231215023805.63289-2-warthog618@gmail.com>
 <ZXyAQq7tVaOFI2Vs@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyAQq7tVaOFI2Vs@smile.fi.intel.com>

On Fri, Dec 15, 2023 at 06:35:14PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 15, 2023 at 10:38:01AM +0800, Kent Gibson wrote:
> > Store the debounce period for a requested line locally, rather than in
> > the debounce_period_us field in the gpiolib struct gpio_desc.
> >
> > Add a global tree of lines containing supplemental line information
> > to make the debounce period available to be reported by the
> > GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
>
> LGTM, a few minor comments below.
>
> ...
>
> > +/*
>
> (now you can have a kernel doc :-)
>

Maybe you can, but I can't.

> > + * a rbtree of the struct lines containing supplemental info.
> > + * Used to populate gpio_v2_line_info with cdev specific fields not contained
> > + * in the struct gpio_desc.
> > + * A line is determined to contain supplemental information by
> > + * line_is_supplemental().
> > + */
> > +static struct rb_root supinfo_tree = RB_ROOT;
> > +/* covers supinfo_tree */
> > +DEFINE_SPINLOCK(supinfo_lock);
>
> Shouldn't this also be static?
>

Indeed.

> ...
>
> > +	guard(spinlock)(&supinfo_lock);
>
> + cleanup.h ?
>

Bah, I could've sworn I added that in, but it isn't evident in any of
the patches all the way back to v1, so apparently not.

> ...
>
> > +static void supinfo_to_lineinfo(struct gpio_desc *desc,
> > +				struct gpio_v2_line_info *info)
> > +{
> > +	struct gpio_v2_line_attribute *attr;
> > +	struct line *line;
> > +
> > +	guard(spinlock)(&supinfo_lock);
> > +
> > +	line = supinfo_find(desc);
> > +	if (line) {
>
> 	if (!line)
> 		return;
>
> ?

Will do.

>
> > +		attr = &info->attrs[info->num_attrs];
> > +		attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
> > +		attr->debounce_period_us = READ_ONCE(line->debounce_period_us);
> > +		info->num_attrs++;
> > +	}
> > +}
>

Cheers,
Kent.

> --
> With Best Regards,
> Andy Shevchenko
>
>

