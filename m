Return-Path: <linux-kernel+bounces-130178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3468974FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46169B27944
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6D14EC64;
	Wed,  3 Apr 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RgOFNIcC"
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F014D44E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160947; cv=none; b=ieZOg0anPa0Qj9W2mRPEdCGdyLA17tRp8al/Y9Iumf+MpsoE5Zb4VE9Zr64JedymSfkssx51jVDMNfyxzqSLPfS0a6CoIfByaLVUlj9iWiKL4+8PzssVt6N0hV7ZUSRuSixYKlPLRB+JKKVpwVUEmEFWcvBEtDVr7ou9Q7LWRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160947; c=relaxed/simple;
	bh=uatYMX2i3KE1ekQW6bUNQmpadzSHqfrZK0YEKMW1MqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNtTJoBt621zd0E77F3BHHIdX2Gz/JZ3hZqtTuUB96CR7aiFLSyzCPdkrlX98MMZaDhXIKBjBksDqeGH8MQ5CFl+7h9UKoBLBg6BiGA2bLXjMyd9JAV4zn+M3WyyVx/khy6GYlBC3fPbHCMzpLQdDiGASNwgU7TEGtUe2PqzNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RgOFNIcC; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V8qSn2c4fz9WQ;
	Wed,  3 Apr 2024 18:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712160569;
	bh=uatYMX2i3KE1ekQW6bUNQmpadzSHqfrZK0YEKMW1MqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgOFNIcCwT0MAtAY9jmDT0imf4WzdbQMHPXwzBjayYtuLO+mCny9g1of/NQw+m/B+
	 BeZTZ24wyfzfLBkjhXGZqo/2VZQ4++DeKv/VOeAAAeDvfB3GzxzKPozrMqBZ57dWW9
	 vyJtv8AsACKqNrc8YDjKyeHm/adTcxIbcj60x8a0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V8qSm2X6jz4mD;
	Wed,  3 Apr 2024 18:09:28 +0200 (CEST)
Date: Wed, 3 Apr 2024 18:09:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, alison.schofield@intel.com, 
	paul@paul-moore.com, fabio.maria.de.francesco@linux.intel.com, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Use kmem for landlock_object
Message-ID: <20240403.Yiep0aem7wu5@digikod.net>
References: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024033030-tutu-dynamite-47c9@gregkh>
 <ZgmETqQr7+W9XtWN@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024033111-squeezing-linoleum-52a7@gregkh>
 <ZgmmnLIal3gz55Q+@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgmmnLIal3gz55Q+@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
X-Infomaniak-Routing: alpha

On Sun, Mar 31, 2024 at 11:38:28PM +0530, Ayush Tiwari wrote:
> On Sun, Mar 31, 2024 at 06:54:39PM +0200, Greg KH wrote:
> > On Sun, Mar 31, 2024 at 09:12:06PM +0530, Ayush Tiwari wrote:
> > > Hello Greg. Thanks for the feedback.
> > > On Sat, Mar 30, 2024 at 05:12:18PM +0100, Greg KH wrote:
> > > > On Sat, Mar 30, 2024 at 07:24:19PM +0530, Ayush Tiwari wrote:
> > > > > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > > > > struct landlock_object and update the related dependencies to improve
> > > > > memory allocation and deallocation performance.
> > > > 
> > > > So it's faster?  Great, what are the measurements?
> > > > 
> > > Thank you for the feedback. Regarding the performance improvements, I
> > > realized I should have provided concrete measurements to support the
> > > claim. The intention behind switching to kmem_cache_zalloc() was to
> > > optimize memory management efficiency based on general principles.
> > > Could you suggest some way to get some measurements if possible?
> > 
> > If you can not measure the difference, why make the change at all?
> 
> Kindly refer to this issue: https://github.com/landlock-lsm/linux/issues/19
> I have been assigned this issue hence I am focussing on making the
> changes that have been listed.

As Greg asked, it would be good know the performance impact of such
change.  This could be measured by creating a lot of related allocations
and accessing them in non-sequential order (e.g. adding new rules,
accessing a related inode while being sandboxed).  I guess there will be
a lot of noise (because of other subsystems) but it's worth a try.  You
should look at similar commits and their related threads to see what
others did.

> > 
> > Again, you need to prove the need for this change, so far I fail to see
> > a reason why.
> > 
> > > > > +static struct kmem_cache *landlock_object_cache;
> > > > > +
> > > > > +void __init landlock_object_cache_init(void)
> > > > > +{
> > > > > +	landlock_object_cache = kmem_cache_create(
> > > > > +		"landlock_object_cache", sizeof(struct landlock_object), 0,
> > > > > +		SLAB_PANIC, NULL);
> > > > 
> > > > You really want SLAB_PANIC?  Why?
> > > >
> > > The SLAB_PANIC flag used in kmem_cache_create indicates that if the
> > > kernel is unable to create the cache, it should panic. The use of
> > > SLAB_PANIC in the creation of the landlock_object_cache is due to the
> > > critical nature of this cache for the Landlock LSM's operation. I
> > > found it to be a good choice to be used. Should I use some other
> > > altrnative?
> > 
> > Is panicing really a good idea?  Why can't you properly recover from
> > allocation failures?
> 
> I am relying on SLAB_PANIC because of the reason I mentioned earlier,
> and also because it was used in lsm_file_cache that I was asked to look
> into as reference. I could try to recover from allocation failures but
> currently my focus is on working on the changes that are listed. I will
> definitely try to look into it once I am done with all changes.

Not being able to create this kmem cache would mean that Landlock would
not be able to properly run, so we could print a warning and exit the
Landlock init function.  However, most calls to kmem_cache_create() are
init calls, and most of them (especially in security/*) set SLAB_PANIC.
I'm wondering why Landlock should do differently, if others should be
fixed, and if the extra complexity of handling several
kmem_cache_create() potential failure is worth it for init handlers?

> 
> > > > > +
> > > > >  struct landlock_object *
> > > > >  landlock_create_object(const struct landlock_object_underops *const underops,
> > > > >  		       void *const underobj)
> > > > > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> > > > >  
> > > > >  	if (WARN_ON_ONCE(!underops || !underobj))
> > > > >  		return ERR_PTR(-ENOENT);
> > > > > -	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > > > > +	new_object =
> > > > > +		kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> > > > 
> > > > Odd indentation, why?
> > > > 
> > > This indentation is due to formatting introduced by running
> > > clang-format.
> > 
> > Why not keep it all on one line?
> > 
> I kept it all in one line in v1, but Paul and Mickael asked me to use
> clang-format, hence it is this way.

Yes, it may looks weird but we format everything with clang-format to
not waste time discussing about style.

> > thanks,
> > 
> > greg k-h
> 

