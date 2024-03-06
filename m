Return-Path: <linux-kernel+bounces-93856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C5F8735E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BEA1C21C58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DC7FBAA;
	Wed,  6 Mar 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="gTHihgpB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF35F566;
	Wed,  6 Mar 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725817; cv=none; b=tHHU79AD2CVAMF0ixksF1UUpfqltuJVx9ZLx2PMAtehiI6K7Z3Qz+RXiLWyWArE1vqzuLR5Ma/Gb4QtcHxjT6YSy6smyVbrLr51ciOJ7PqH52vEQ4U7/b0VqW8p8s1NH4o7q6oyiC6cTgkl7ZX+6HW7PDJv/keqruhDUZZtAu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725817; c=relaxed/simple;
	bh=oQEURLdMMQB0V8R88RPwkASCvabdh1vk2k5dwlNoEmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXsNA+yx3Ulkgs5CE91YNPEED3D3+HWE8KGxAOU81HoJvkcbjDnJj2yLY7lcN7kyFuHXStZuOhbIMcZWItapbnS46mr2edAYUtbTlawCUgNrdDMxH4xvleZ9/J2RJnfaJjETjesW7OEgNUEnBm8VrNKHn1n943ougmXfpdqZ1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=gTHihgpB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so55334325ad.2;
        Wed, 06 Mar 2024 03:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709725815; x=1710330615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8G7GEXa9DZzi0CKgIJJT9sMbg0rLs947ZnTK1mGAk8=;
        b=j+FxhUQeMkcRWFP1wLo9EeOHdTRGcVqkhbgnTfenrdK6RgtFaTq6NfARIZhPyGVzVM
         9OKF35fDE5//txzGaiOlk9eUc8ti7h6VuEtCHxq827mq5Dr828buTFjkhOvwGFy7dw8V
         REhz2PiFZIrWs4fspZR9T7w2cWDlqY87TetCdaZNgajX0BotfjrUGbjseG14LOpW6oi8
         xfeXr6JZjsq9C2Mx9i8Yt+HkClXbypEqaYmdncO10kZT2LK9TeUuNw8hDGCqxbMho8PX
         6Rk0zLuxHCIkfAYuTBbyVjGKEWtHCvqW/Od9xFFJRmVu8mzDtTAdFQk7O7FuLiBvDT87
         ckjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ220M4lDHyGerWHquvHG3A0XBxq569XMrogOWWi8IpbSsOrSJ9kJwQVUguail6gMRaKY+WtCv2r6aTHBJTKru+gC8Ba7SSrxBPxU7JK2/3sn6/wBnEYwGWMKovLxJhce1gQbQ4VD+wQWYv68=
X-Gm-Message-State: AOJu0YzekNFojkxgDZRwx8XW64Y0aZVxH0o4QTx8J00g9BPGiY9IkPkT
	nKe6PEGgxj3oiFCBZPIXr+LAOVKpP5om1woAeV3bhwxva1qqwxy8
X-Google-Smtp-Source: AGHT+IEQQ9bQFR3pzcK4+X+LWoZ64gRcWJ2YZV68ITvp3WYWMBbXpGRveiwaabuBfP0dRJ+ohlOBQg==
X-Received: by 2002:a17:903:2444:b0:1dc:d52e:a038 with SMTP id l4-20020a170903244400b001dcd52ea038mr5536055pls.60.1709725815067;
        Wed, 06 Mar 2024 03:50:15 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b001d9a42f6183sm12372225plg.45.2024.03.06.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:50:14 -0800 (PST)
Date: Wed, 6 Mar 2024 08:50:04 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709725810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8G7GEXa9DZzi0CKgIJJT9sMbg0rLs947ZnTK1mGAk8=;
	b=gTHihgpBH7dFALaSY3q7jsrEv2uQu8SqSzL3rknwFp8OVNkf5PLvhFvWdllYxUlwOXUxZF
	h5YkLSw6WMx0IzfyaKkgLmX4a8sl6PC4E0SG3YI3SBtksUoeUg5//AHwsAIrpgB7OwFfXZ
	KVxd1csDBVuUHkEx8+tw2NctcFOxYRzyQ6Uq5P6r5cgkbkKvLCqAg5ytY2KcAOhvYtnCux
	c6HAb+hVNJSccQOlUM1O/MMXn5ixgmuPSN9QUaN2+OHxKzi7twDROZX3rCTgiIRx0wIiun
	LAZ1Q3hEEYlcW0kuCbisznrSHtQyIWmBnSuIV0nqi7aHGu6Q6ObKkslVfothyA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bcachefs: chardev: make bch_chardev_class constant
Message-ID: <sky4no6qxoytrkd3azcf5hokmhxrrpluao5ilhbqvprqxwuj4r@ozwmbbulfbrt>
References: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
 <d1209aa3-b8d4-4509-9689-4882bc079ffd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1209aa3-b8d4-4509-9689-4882bc079ffd@huawei.com>

On  6 Mar 09:23, Hongbo Li wrote:
> On 2024/3/6 4:21, Ricardo B. Marliere wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the bch_chardev_class structure to be declared at build
> > time placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >   fs/bcachefs/chardev.c | 23 ++++++++++++-----------
> >   1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
> > index 226b39c17667..af587453fd3d 100644
> > --- a/fs/bcachefs/chardev.c
> > +++ b/fs/bcachefs/chardev.c
> > @@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
> >   };
> >   
> >   static int bch_chardev_major;
> > -static struct class *bch_chardev_class;
> > +static const struct class bch_chardev_class = {
> > +	.name = "bcachefs",
> > +};
> >   static struct device *bch_chardev;
> >   
> >   void bch2_fs_chardev_exit(struct bch_fs *c)
> > @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
> >   	if (c->minor < 0)
> >   		return c->minor;
> >   
> > -	c->chardev = device_create(bch_chardev_class, NULL,
> > +	c->chardev = device_create(&bch_chardev_class, NULL,
> >   				   MKDEV(bch_chardev_major, c->minor), c,
> >   				   "bcachefs%u-ctl", c->minor);
> >   	if (IS_ERR(c->chardev))
> > @@ -968,26 +970,25 @@ int bch2_fs_chardev_init(struct bch_fs *c)
> >   
> >   void bch2_chardev_exit(void)
> >   {
> > -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> > -		device_destroy(bch_chardev_class,
> > -			       MKDEV(bch_chardev_major, U8_MAX));
> > -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> > -		class_destroy(bch_chardev_class);
> > +	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
> > +	class_unregister(&bch_chardev_class);
> >   	if (bch_chardev_major > 0)
> >   		unregister_chrdev(bch_chardev_major, "bcachefs");
> >   }
> >   
> >   int __init bch2_chardev_init(void)
> >   {
> > +	int ret;
> > +
> >   	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
> >   	if (bch_chardev_major < 0)
> >   		return bch_chardev_major;
> >   
> > -	bch_chardev_class = class_create("bcachefs");
> > -	if (IS_ERR(bch_chardev_class))
> > -		return PTR_ERR(bch_chardev_class);
> > +	ret = class_register(&bch_chardev_class);
> > +	if (ret)
> Here, I think you should call class_unregister to relase resource which 
> allocated before. And the same thing shoud be done in other exception exit.

Hi Hongbo,

Thank you for the feedback. Did you mean that bch_chardev_major should
be unregistered if the class_register() call fails? Because if it does,
there is no need to call class_unregister().

> > +		return ret;
> >   
> > -	bch_chardev = device_create(bch_chardev_class, NULL,
> > +	bch_chardev = device_create(&bch_chardev_class, NULL,
> >   				    MKDEV(bch_chardev_major, U8_MAX),
> >   				    NULL, "bcachefs-ctl");
> >   	if (IS_ERR(bch_chardev))
> like here..

Can you please elaborate?

Best regards,
-	Ricardo.


> > 
> > ---
> > base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> > change-id: 20240305-bcachefs-27a4bb8b9f4f
> > 
> > Best regards,

