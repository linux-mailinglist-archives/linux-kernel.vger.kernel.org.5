Return-Path: <linux-kernel+bounces-141819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B168A23DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF29D1F2380E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF710A3C;
	Fri, 12 Apr 2024 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QOwbCjmt"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7917F5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889888; cv=none; b=F/aCzDYVG1xXFYygJ8e/KU8xD7O84lQS+TI1nwvJbDtZSQQgwhA2smNRu1RIWlLrRf4McNQvjTRMXoPHROylmHbO7s8wNj2oekHSWIbjPJ7VWeVSJGMRAOERwvXgs9uDRaAieHPxKm5XR8Y3WEHHbOqhSGoqXhX09FceCEKOhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889888; c=relaxed/simple;
	bh=d8TMlfpqfj0EJkk4co1gVGQPXhL+ttMpGKUpO6Ej/tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNbL81efktZXVdkN2BrrgY0DsmNuD3EeSXV4ZGxaHMBtEPN/C58du1JxqBv3TOk4MQffZR+yu9T6DF5Gp7WEkXIuiDmNI3gZyLBA2wokjhDuv3P/512eOhHLv97ZdaMy1VRB/+lXLT1WzR3MTzdoaSutjMz3XvqfKtAkduc4Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QOwbCjmt; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Apr 2024 22:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712889884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I79hH/MqceyrY7sxro/GgYJP7b4PlTecMBGnWtJf/kE=;
	b=QOwbCjmtAEE42sRxAb7b4AOsULuYL9eaT/ENTW68O2WWOHkwIByai13wmNjulZDpk5VlT1
	0lj9Lx96lHfqscUXt+BmOsp7OqM5uuz9N670Zr5su0INS0k36HpSg3jSSaGzx32sJAidS8
	cZ9xhmBRsbwCenfTJ97RuZqjlEbytwQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] bcachefs: chardev: make bch_chardev_class constant
Message-ID: <vl32k2zzdeohe6ek5cmfibme7ka2e76x57xbxcm26olxlog6ef@lkxtlw63csnv>
References: <20240308-bcachefs-v2-1-3e84c845055e@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308-bcachefs-v2-1-3e84c845055e@marliere.net>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 08, 2024 at 09:12:47AM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the bch_chardev_class structure to be declared at build
> time placing it into read-only memory, instead of having to be dynamically
> allocated at boot time. Also, correctly clean up after failing paths in
> bch2_chardev_init().
> 
> Cc: Hongbo Li <lihongbo22@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks, applied
> ---
> Changes in v2:
> - Used "free the last thing" pattern in bch2_chardev_init().
> - Link to v1: https://lore.kernel.org/r/20240305-bcachefs-v1-1-436196e25729@marliere.net
> ---
>  fs/bcachefs/chardev.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
> index 226b39c17667..dc09f547dae6 100644
> --- a/fs/bcachefs/chardev.c
> +++ b/fs/bcachefs/chardev.c
> @@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
>  };
>  
>  static int bch_chardev_major;
> -static struct class *bch_chardev_class;
> +static const struct class bch_chardev_class = {
> +	.name = "bcachefs",
> +};
>  static struct device *bch_chardev;
>  
>  void bch2_fs_chardev_exit(struct bch_fs *c)
> @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>  	if (c->minor < 0)
>  		return c->minor;
>  
> -	c->chardev = device_create(bch_chardev_class, NULL,
> +	c->chardev = device_create(&bch_chardev_class, NULL,
>  				   MKDEV(bch_chardev_major, c->minor), c,
>  				   "bcachefs%u-ctl", c->minor);
>  	if (IS_ERR(c->chardev))
> @@ -968,32 +970,39 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>  
>  void bch2_chardev_exit(void)
>  {
> -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> -		device_destroy(bch_chardev_class,
> -			       MKDEV(bch_chardev_major, U8_MAX));
> -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> -		class_destroy(bch_chardev_class);
> +	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
> +	class_unregister(&bch_chardev_class);
>  	if (bch_chardev_major > 0)
>  		unregister_chrdev(bch_chardev_major, "bcachefs");
>  }
>  
>  int __init bch2_chardev_init(void)
>  {
> +	int ret;
> +
>  	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
>  	if (bch_chardev_major < 0)
>  		return bch_chardev_major;
>  
> -	bch_chardev_class = class_create("bcachefs");
> -	if (IS_ERR(bch_chardev_class))
> -		return PTR_ERR(bch_chardev_class);
> +	ret = class_register(&bch_chardev_class);
> +	if (ret)
> +		goto major_out;
>  
> -	bch_chardev = device_create(bch_chardev_class, NULL,
> +	bch_chardev = device_create(&bch_chardev_class, NULL,
>  				    MKDEV(bch_chardev_major, U8_MAX),
>  				    NULL, "bcachefs-ctl");
> -	if (IS_ERR(bch_chardev))
> -		return PTR_ERR(bch_chardev);
> +	if (IS_ERR(bch_chardev)) {
> +		ret = PTR_ERR(bch_chardev);
> +		goto class_out;
> +	}
>  
>  	return 0;
> +
> +class_out:
> +	class_unregister(&bch_chardev_class);
> +major_out:
> +	unregister_chrdev(bch_chardev_major, "bcachefs-ctl");
> +	return ret;
>  }
>  
>  #endif /* NO_BCACHEFS_CHARDEV */
> 
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240305-bcachefs-27a4bb8b9f4f
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

