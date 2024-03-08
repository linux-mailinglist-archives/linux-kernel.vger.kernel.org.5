Return-Path: <linux-kernel+bounces-96988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B828C87641D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72061C216E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7155E57;
	Fri,  8 Mar 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="SwUnY2u2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591C53818;
	Fri,  8 Mar 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900053; cv=none; b=Rw7CYr7icJ3pkxrlXqVQFQwVymvFvLzD40IpiyjrpFbnf+1o1TGt7ytXbfOijNYgrPiAeC22Cf01OL8ZofY7mMyBImoOvVxnNKMkGZ03scJXf0sFlEkPMddfoCQohf+Cxc8/o3Gv0pnDiQOt+XdXdTD40ummV0aPw+Jj8xkTHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900053; c=relaxed/simple;
	bh=Z2gjmGEER6YwjeSGLmpcDZtstH/cbjrJyU9s0AI66/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S66IdWHu7xgc9FIf1vsxfoeyKSI5Ho2GWSUcXiyFs0lJDhG2MKWZhtPjQZQTlFphrJOYIy+CND/vNxnq6Wj5Avy8Ty+yfM7bN+Asy5PqwHHQtzTBWOLft5uaz0dtLOY3sLrwBjsjGPjnDeoOCZXXM14st8bXNjLnxcIRUvEk+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=SwUnY2u2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd01ea35b5so11873755ad.0;
        Fri, 08 Mar 2024 04:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709900051; x=1710504851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgqkPMmyrA39zl1mz2n9jVnuMuXfncFZQfiwsciJnYI=;
        b=BhLcil7HC1wZ9FXnzwJo106yYA+fS5qhJKYFJ2j9XjnBSwraRf4lta3tAcMQ06JEb/
         baQ047ndqTtqcjG54NUgnMpdsAgSpEwa3C+oDhMhfFQvUjmgDhODqB1ng6G3cBGnNz5T
         8EqClVioOd1ySiiBIF4a9yAG2gkPWVlAaoMpwo9bbtF+lafCIWUhOsyqQmyTVaLuIXjR
         ssPIiwOcj3pLKEuOS4We31Ph6LtCv8QkjcZN3HWRAbWcm5ULyggb87ntEJjtm/2JmDVE
         5fDSpwBiHjQeX99eGU3MTZPM7C+DKVos3UPx00P9aEvZmFiW6ITnIxzRMVKxDy/8gDD+
         rZvA==
X-Forwarded-Encrypted: i=1; AJvYcCWqNsbSWQPBWOYCPuo575reSMuilxh6wJkHS+WBVHgnN7blToQ8cUZcRPtGe1B8gtTVzCEfLuz7iuuyByDtAuvHqQGSAqJTZr0pTDWSB0LHcKFy731utmyZSsmWyj8WVNcliOOIFyY5mWMoRzo=
X-Gm-Message-State: AOJu0YwNeoCssqa0xbegXKoYp6dgHz2gr9xJuGR5uep3nDp0ttF7SoL2
	Nk4/6pPVmZgcBZ6P0fsX3PL764hFqLo1gBC8tEJ0Vcq9JXPufYw9
X-Google-Smtp-Source: AGHT+IFE8NaD7kpLL3RVrWfJIo0LQC7EefKIHy6ax2AH9mcVDFCSmzTeE/JdF/9bOAe55t7TtxhIfQ==
X-Received: by 2002:a17:903:124b:b0:1d8:f129:a0bc with SMTP id u11-20020a170903124b00b001d8f129a0bcmr13428866plh.13.1709900050803;
        Fri, 08 Mar 2024 04:14:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id mq12-20020a170902fd4c00b001dc8f1e06eesm16150114plb.291.2024.03.08.04.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:14:10 -0800 (PST)
Date: Fri, 8 Mar 2024 09:14:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709900049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgqkPMmyrA39zl1mz2n9jVnuMuXfncFZQfiwsciJnYI=;
	b=SwUnY2u2kdAk3//j5fJr5CSk2tHzz1J1QQgOfRzHzBMoqFeGYZWQ4wnYfXgTY03p5yYHOy
	/ztv4t4yrpkrXDIFRXQK3gaZQ9zQev3D2jbCIFOuDw1/gyw56LeGqAdQO82gLzP1A5Gcq9
	Ye28p1ske52pm+q0nq1+ysxZ66yyC1V9DjXM+fW8vd6GAKS7lUWiOi2nJtn+RikwEKl3Op
	GV2cTolY5BvPfLi//RTCXye2DIa3WQTswdWhUBGwySiUw+YsfbkLuOWjpq2bV5Y4M5C8V3
	zGBqio4lhnHbnieEdkE/JEpiCdOPN01NyK1klgy2XAjWt6nh8k5WzyRqJqHPYw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Hongbo Li <lihongbo22@huawei.com>, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bcachefs: chardev: make bch_chardev_class constant
Message-ID: <kbf4df66sn5ls4lb2vaotsmpcbv5pwozh464zbrwzawhqqch62@vumhpeaghqqf>
References: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
 <d1209aa3-b8d4-4509-9689-4882bc079ffd@huawei.com>
 <sky4no6qxoytrkd3azcf5hokmhxrrpluao5ilhbqvprqxwuj4r@ozwmbbulfbrt>
 <5odqpww3sjv6ffj3hpmhx25q4fdacstfr5qn7seb3mwrclynpi@drhj7xa2cfyj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5odqpww3sjv6ffj3hpmhx25q4fdacstfr5qn7seb3mwrclynpi@drhj7xa2cfyj>

On  7 Mar 21:18, Kent Overstreet wrote:
> On Wed, Mar 06, 2024 at 08:50:04AM -0300, Ricardo B. Marliere wrote:
> > On  6 Mar 09:23, Hongbo Li wrote:
> > > On 2024/3/6 4:21, Ricardo B. Marliere wrote:
> > > > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > > > a const *"), the driver core allows for struct class to be in read-only
> > > > memory, so move the bch_chardev_class structure to be declared at build
> > > > time placing it into read-only memory, instead of having to be dynamically
> > > > allocated at boot time.
> > > > 
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > > ---
> > > >   fs/bcachefs/chardev.c | 23 ++++++++++++-----------
> > > >   1 file changed, 12 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
> > > > index 226b39c17667..af587453fd3d 100644
> > > > --- a/fs/bcachefs/chardev.c
> > > > +++ b/fs/bcachefs/chardev.c
> > > > @@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
> > > >   };
> > > >   
> > > >   static int bch_chardev_major;
> > > > -static struct class *bch_chardev_class;
> > > > +static const struct class bch_chardev_class = {
> > > > +	.name = "bcachefs",
> > > > +};
> > > >   static struct device *bch_chardev;
> > > >   
> > > >   void bch2_fs_chardev_exit(struct bch_fs *c)
> > > > @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
> > > >   	if (c->minor < 0)
> > > >   		return c->minor;
> > > >   
> > > > -	c->chardev = device_create(bch_chardev_class, NULL,
> > > > +	c->chardev = device_create(&bch_chardev_class, NULL,
> > > >   				   MKDEV(bch_chardev_major, c->minor), c,
> > > >   				   "bcachefs%u-ctl", c->minor);
> > > >   	if (IS_ERR(c->chardev))
> > > > @@ -968,26 +970,25 @@ int bch2_fs_chardev_init(struct bch_fs *c)
> > > >   
> > > >   void bch2_chardev_exit(void)
> > > >   {
> > > > -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> > > > -		device_destroy(bch_chardev_class,
> > > > -			       MKDEV(bch_chardev_major, U8_MAX));
> > > > -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> > > > -		class_destroy(bch_chardev_class);
> > > > +	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
> > > > +	class_unregister(&bch_chardev_class);
> > > >   	if (bch_chardev_major > 0)
> > > >   		unregister_chrdev(bch_chardev_major, "bcachefs");
> > > >   }
> > > >   
> > > >   int __init bch2_chardev_init(void)
> > > >   {
> > > > +	int ret;
> > > > +
> > > >   	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
> > > >   	if (bch_chardev_major < 0)
> > > >   		return bch_chardev_major;
> > > >   
> > > > -	bch_chardev_class = class_create("bcachefs");
> > > > -	if (IS_ERR(bch_chardev_class))
> > > > -		return PTR_ERR(bch_chardev_class);
> > > > +	ret = class_register(&bch_chardev_class);
> > > > +	if (ret)
> > > Here, I think you should call class_unregister to relase resource which 
> > > allocated before. And the same thing shoud be done in other exception exit.
> > 
> > Hi Hongbo,
> > 
> > Thank you for the feedback. Did you mean that bch_chardev_major should
> > be unregistered if the class_register() call fails? Because if it does,
> > there is no need to call class_unregister().
> 
> Hongbo is correct, if bch2_chardev_init() fails it needs to clean up
> anything it did.

Hi Kent, 

I agree. I sent a v2 but let me know if you want that to be in a
separate commit.

Best regards,
-	Ricardo.


> 
> > 
> > > > +		return ret;
> > > >   
> > > > -	bch_chardev = device_create(bch_chardev_class, NULL,
> > > > +	bch_chardev = device_create(&bch_chardev_class, NULL,
> > > >   				    MKDEV(bch_chardev_major, U8_MAX),
> > > >   				    NULL, "bcachefs-ctl");
> > > >   	if (IS_ERR(bch_chardev))
> > > like here..
> > 
> > Can you please elaborate?
> > 
> > Best regards,
> > -	Ricardo.
> > 
> > 
> > > > 
> > > > ---
> > > > base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> > > > change-id: 20240305-bcachefs-27a4bb8b9f4f
> > > > 
> > > > Best regards,

