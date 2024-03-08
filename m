Return-Path: <linux-kernel+bounces-96445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC0875C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC921F21F47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B72377D;
	Fri,  8 Mar 2024 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xwaUisIj"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54C1D546
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864326; cv=none; b=YyEHAMW8yDm9ekVuQstIOdVgC4zpE4vCGQfGEVusdGOeB9fw4oy/AEqi1EFuIf/jGwltuuciCqcz2OCWfEAIuT73tyxdvrqDy40qDHN9hfCHiElhf8cZiVKXunMH81bAeLJ4NeVRVuIZpmkmOTuZeOn4yKLKSy/B75ED9JLHeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864326; c=relaxed/simple;
	bh=nEwH4yfP4vqXQbZOO7lJhENGHFgNWar4jxiwuKlg7Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN3j0SFGA5wOfuQ08+2Xc7Y8Ei8avbXW2rCFuxK+fZPPDFyOHTq1jcTezld+GoeimEfYPelxkZ9VHUcPUVUIlcvQp3lPgslEWnlpjlrz2uT3FoTTI6TujwVf00IgJMLozwYtkLgr034k3tpS0TYxmHKsFfDCqfYiGHXRSnjDzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xwaUisIj; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Mar 2024 21:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709864322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLxjIs8f/lnLvJoE5R+baInSbYa4ox3iynZ8gnuCrEc=;
	b=xwaUisIjy/cj/mNY5MLxtwBhEG+kOE1pjEA/ITKL9zJkd1mSJn+xQYI5JqbQOfa4gbNHgn
	1ksclDjfKdRKb4o4L2cZk0h7fCDoXvtJYCe2Q6N4X5LJLmeqpMHYaoiJ405iBpFwbD4lfD
	9N8Kgm9ey0EY6ip0U8RY72DRjLzPCAw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hongbo Li <lihongbo22@huawei.com>, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bcachefs: chardev: make bch_chardev_class constant
Message-ID: <5odqpww3sjv6ffj3hpmhx25q4fdacstfr5qn7seb3mwrclynpi@drhj7xa2cfyj>
References: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
 <d1209aa3-b8d4-4509-9689-4882bc079ffd@huawei.com>
 <sky4no6qxoytrkd3azcf5hokmhxrrpluao5ilhbqvprqxwuj4r@ozwmbbulfbrt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sky4no6qxoytrkd3azcf5hokmhxrrpluao5ilhbqvprqxwuj4r@ozwmbbulfbrt>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 06, 2024 at 08:50:04AM -0300, Ricardo B. Marliere wrote:
> On  6 Mar 09:23, Hongbo Li wrote:
> > On 2024/3/6 4:21, Ricardo B. Marliere wrote:
> > > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > > a const *"), the driver core allows for struct class to be in read-only
> > > memory, so move the bch_chardev_class structure to be declared at build
> > > time placing it into read-only memory, instead of having to be dynamically
> > > allocated at boot time.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > ---
> > >   fs/bcachefs/chardev.c | 23 ++++++++++++-----------
> > >   1 file changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
> > > index 226b39c17667..af587453fd3d 100644
> > > --- a/fs/bcachefs/chardev.c
> > > +++ b/fs/bcachefs/chardev.c
> > > @@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
> > >   };
> > >   
> > >   static int bch_chardev_major;
> > > -static struct class *bch_chardev_class;
> > > +static const struct class bch_chardev_class = {
> > > +	.name = "bcachefs",
> > > +};
> > >   static struct device *bch_chardev;
> > >   
> > >   void bch2_fs_chardev_exit(struct bch_fs *c)
> > > @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
> > >   	if (c->minor < 0)
> > >   		return c->minor;
> > >   
> > > -	c->chardev = device_create(bch_chardev_class, NULL,
> > > +	c->chardev = device_create(&bch_chardev_class, NULL,
> > >   				   MKDEV(bch_chardev_major, c->minor), c,
> > >   				   "bcachefs%u-ctl", c->minor);
> > >   	if (IS_ERR(c->chardev))
> > > @@ -968,26 +970,25 @@ int bch2_fs_chardev_init(struct bch_fs *c)
> > >   
> > >   void bch2_chardev_exit(void)
> > >   {
> > > -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> > > -		device_destroy(bch_chardev_class,
> > > -			       MKDEV(bch_chardev_major, U8_MAX));
> > > -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> > > -		class_destroy(bch_chardev_class);
> > > +	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
> > > +	class_unregister(&bch_chardev_class);
> > >   	if (bch_chardev_major > 0)
> > >   		unregister_chrdev(bch_chardev_major, "bcachefs");
> > >   }
> > >   
> > >   int __init bch2_chardev_init(void)
> > >   {
> > > +	int ret;
> > > +
> > >   	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
> > >   	if (bch_chardev_major < 0)
> > >   		return bch_chardev_major;
> > >   
> > > -	bch_chardev_class = class_create("bcachefs");
> > > -	if (IS_ERR(bch_chardev_class))
> > > -		return PTR_ERR(bch_chardev_class);
> > > +	ret = class_register(&bch_chardev_class);
> > > +	if (ret)
> > Here, I think you should call class_unregister to relase resource which 
> > allocated before. And the same thing shoud be done in other exception exit.
> 
> Hi Hongbo,
> 
> Thank you for the feedback. Did you mean that bch_chardev_major should
> be unregistered if the class_register() call fails? Because if it does,
> there is no need to call class_unregister().

Hongbo is correct, if bch2_chardev_init() fails it needs to clean up
anything it did.

> 
> > > +		return ret;
> > >   
> > > -	bch_chardev = device_create(bch_chardev_class, NULL,
> > > +	bch_chardev = device_create(&bch_chardev_class, NULL,
> > >   				    MKDEV(bch_chardev_major, U8_MAX),
> > >   				    NULL, "bcachefs-ctl");
> > >   	if (IS_ERR(bch_chardev))
> > like here..
> 
> Can you please elaborate?
> 
> Best regards,
> -	Ricardo.
> 
> 
> > > 
> > > ---
> > > base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> > > change-id: 20240305-bcachefs-27a4bb8b9f4f
> > > 
> > > Best regards,

