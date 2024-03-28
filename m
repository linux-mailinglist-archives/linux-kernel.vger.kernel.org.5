Return-Path: <linux-kernel+bounces-122542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9C88F931
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAB41C26C41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7453813;
	Thu, 28 Mar 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXEc6qN1"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B823768;
	Thu, 28 Mar 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612405; cv=none; b=liHQ3vyV8oQoAA715DoTmEH9pWhoTJ63twhRa6mfdwL4hdDJbTzMOLSLSTO7IMJ/giWRTDuvMNNTkC2s/rs59K3XzoiFDw6nq7YWTCcexvoFO6lsrH4Zkpi9xuqOt4Le8HyFB87Lsov3t1uJelGF/PfKA5KqOfh0IyNEHrK9wCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612405; c=relaxed/simple;
	bh=hXUOINxev2sW2aHJR3Tsa4GArFRCJyPX7m0SK/yhJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYKXXw+UZwnbRJjSPnYEotQGw1dOSVmj3pOX5VWwbMA2olOQHFgWZ7X8f0qwFWcphmTHJiTMuKpQ3BY6DvGgwdBTWtSUaqiPvxV1T1IyXFRhGaR5jayoq6jSGY3Hq0jFmuHChghISA30wtuTSzEfZTLp60OySSpkE2NErR3Q2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXEc6qN1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea80de0e97so517783b3a.2;
        Thu, 28 Mar 2024 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612403; x=1712217203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VWzLPeLLlmGOBtEnLvR7ID/q8d8vc0GlObcdJceoe8U=;
        b=lXEc6qN1yEubZR1zYuMGyfIv2BoMmN663mzQkkadMXjYgPIlSnz4DAQ5j0xaxowPB1
         Yx4Sv66vTubAJ4dtAvB2Kgqf6jGPQ4DPZo6nhzeTDse/T7PNQpfwcTX2PaTPENwZ0E3I
         uU3M7/ArTissTUZnJj5gNMmGlJ8D7Pz8NFKwc0Mk5el/bewkqPPDvZNIhPqYXqJUFPhJ
         UUpVBND6hnBO1/2N4kACJM0FnplOLFNTwNJWTs0CqgkhXWFPz32qkUH4c1Eg+5K4BN49
         DmItCbekEN/jxLqQVqwXcv/tkZfHekpNkMSslNxscRgHapIKxBG0TEp6lACBevzUtUcR
         tLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612403; x=1712217203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWzLPeLLlmGOBtEnLvR7ID/q8d8vc0GlObcdJceoe8U=;
        b=VfR7kkqN3QtD1SXRw9aBMbGn3o//+7l5jvkb7e9uB8llhmTp+1qtKbhWn7Wia+x46X
         GM4w3atE1X9Va2e8v8pt03B8MKpFC7/J5C/WtuSRb2v9w25zenJ1la/a/XOhCYtxWmqv
         NQyXRgX+4qS3YqPlxCIvXZPiCn1u8sSz8Q5Lo/0JRlL4z2cB5AwXUhfpuIHh899fMz+3
         P0z8L/j6Fp38Qt4HGGtiPcqQJc7pxQtaw6iLOroHYVZo+IzAht9k3+N/bONyAonwq8Fv
         nWVaHm37nbk/M7X4sS3a9x/WrcgBwlE15NOKrTolNv+Zzy7x2ftxvV5RtSmmERoxvmF7
         EupA==
X-Forwarded-Encrypted: i=1; AJvYcCXKRP8EA9Cu5UOwZcynR8+zQ2DWMrsjGHUvi76OpgOKEj6tNSGKTJmoehcPWaJbifjP60nIDYattTkksZQP/kFlYLxEkvlPGGrLDshuI+GekqNbu8APGgopXX8m6xwZStGxk+NTFuY2BJGZSuB71hkvsOCC
X-Gm-Message-State: AOJu0Yz1mV3KIzWMdffK+8CiJIYcauEnxzlKnSzz1OVoJP97N+BAPTab
	IoT0V/R/6uNoeoAXwEenXNnP3ACSgoWjTVIOH5OBkf6lCsr4JIR1
X-Google-Smtp-Source: AGHT+IGNSCAzjZUIEUhikEwCO0OBMmnJm83tV+FlDjZ9po4KHUV3/ZohPm+enyNSfYnUY3P+hJl5KA==
X-Received: by 2002:a05:6a20:d049:b0:1a3:6ec2:d23b with SMTP id hv9-20020a056a20d04900b001a36ec2d23bmr2957496pzb.15.1711612402804;
        Thu, 28 Mar 2024 00:53:22 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001d9fc6df457sm879274pln.5.2024.03.28.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:53:22 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:23:17 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: alison.schofield@intel.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <ZgUh7cIQIsOgvWpw@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <CAHC9VhRYDNoqkbkgdUSg-kYSHVbheD5NtezmVxyRakZ0-DzuSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRYDNoqkbkgdUSg-kYSHVbheD5NtezmVxyRakZ0-DzuSg@mail.gmail.com>

Hello Paul
Thanks a lot for the feedback. Apologies for the mistakes. Could you
help me in some places so that I can correct the errors, like:
On Wed, Mar 27, 2024 at 07:43:36PM -0400, Paul Moore wrote:
> On Wed, Mar 27, 2024 at 7:26 PM Ayush Tiwari <ayushtiw0110@gmail.com> wrote:
> >
> > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > struct landlock_object and update the related dependencies.
> >
> > Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> > ---
> >  security/landlock/fs.c     |  2 +-
> >  security/landlock/object.c | 14 ++++++++++++--
> >  security/landlock/object.h |  4 ++++
> >  security/landlock/setup.c  |  2 ++
> >  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> Hi Ayush,
> 
> Mickaël has the final say on Landlock patches, but I had a few
> comments that I've included below ...
> 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index fc520a06f9af..227dd67dd902 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -124,7 +124,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> >         if (unlikely(rcu_access_pointer(inode_sec->object))) {
> >                 /* Someone else just created the object, bail out and retry. */
> >                 spin_unlock(&inode->i_lock);
> > -               kfree(new_object);
> > +               kmem_cache_free(landlock_object_cache, new_object);
> 
> See my comment below, but you may want to wrap this in a Landlock
> object API function.
Sure. I will definitely implement this.
> 
> >                 rcu_read_lock();
> >                 goto retry;
> > diff --git a/security/landlock/object.c b/security/landlock/object.c
> > index 1f50612f0185..df1354215617 100644
> > --- a/security/landlock/object.c
> > +++ b/security/landlock/object.c
> > @@ -17,6 +17,15 @@
> >
> >  #include "object.h"
> >
> > +struct kmem_cache *landlock_object_cache;
> > +
> > +void __init landlock_object_init(void)
> > +{
> > +       landlock_object_cache = kmem_cache_create(
> > +               "landlock_object_cache", sizeof(struct landlock_object), 0,
> > +               SLAB_PANIC, NULL);
> 
> The comments in include/linux/slab.h suggest using the KMEM_CACHE()
> macro, instead of kmem_cache_create(), as a best practice for creating
> slab caches.
> 
Sure. Apologies I didn't see that, I tried to implement it from scratch
using the reference from linux memory management APIs.
> > +}
> > +
> >  struct landlock_object *
> >  landlock_create_object(const struct landlock_object_underops *const underops,
> >                        void *const underobj)
> > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> >
> >         if (WARN_ON_ONCE(!underops || !underobj))
> >                 return ERR_PTR(-ENOENT);
> > -       new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > +       new_object =
> > +               kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> 
> If the line is too long, you might want to consider splitting the
> function parameters like this:
> 
>   new_object = kmem_cache_zalloc(landlock_object_cache,
>                                  GFP_KERNEL_ACCOUNT);
> 

Sure. I didn't do as it was below the 100 columns limit, but will
definitely implement it.
> >         if (!new_object)
> >                 return ERR_PTR(-ENOMEM);
> >         refcount_set(&new_object->usage, 1);
> > @@ -62,6 +72,6 @@ void landlock_put_object(struct landlock_object *const object)
> >                  * @object->underobj to @object (if it still exists).
> >                  */
> >                 object->underops->release(object);
> > -               kfree_rcu(object, rcu_free);
> > +               kmem_cache_free(landlock_object_cache, object);
> >         }
> >  }
> > diff --git a/security/landlock/object.h b/security/landlock/object.h
> > index 5f28c35e8aa8..8ba1af3ddc2e 100644
> > --- a/security/landlock/object.h
> > +++ b/security/landlock/object.h
> > @@ -13,6 +13,10 @@
> >  #include <linux/refcount.h>
> >  #include <linux/spinlock.h>
> >
> > +extern struct kmem_cache *landlock_object_cache;
> 
> This really is a decision for Mickaël, but you may want to make
> @landlock_object_cache private to object.c and create functions to
> manage it as needed, e.g. put/free operations.
> 
Okay. I didn't make it private as I was using it in fs.c to use
kmem_cache_free, but if this is supposed to be private, I can modify the
approach and expose it via some function, not directly exposing
landlock_object_cache.
> > +void __init landlock_object_init(void);
> > +
> >  struct landlock_object;
> >
> >  /**
> > diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> > index f6dd33143b7f..a5fca4582ee1 100644
> 
> -- 
> paul-moore.com
I will make all the changes you mentioned, and as you said, I will
wait for Mickael's say.

