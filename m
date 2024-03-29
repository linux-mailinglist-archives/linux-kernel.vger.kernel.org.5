Return-Path: <linux-kernel+bounces-124057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345689119F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86701F241BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E92C85A;
	Fri, 29 Mar 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQYkeOkp"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D48224D1;
	Fri, 29 Mar 2024 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678791; cv=none; b=Tddl499isusfIGoAW8Dlk2ldf8YuMfgJPkQNI065M6u6gC4/GOmmEfzzU3YpvsY4Pr1vqoJJPR2nD06K+DBiIm01xuAhLZn1pBkQrHdyMGEvcQdhppO8N+gaqrkxsyj3lOMryWJnYpYgxp/Db9DYiShGixEcIg46O36UdzDmOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678791; c=relaxed/simple;
	bh=pM4r28R4O0XiKgV1w8evOjFQxQQi4y0kqsHq1Ox+cHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGLXGQB6dsupWRolOZRXzx4tmB0FFeLoqTyzROL/KEVd1o1+T0nne204643PT4hO2prYezHQkzuwOXe8TNlAlmKL+NLHjfI+VKGZUTTnC2dLHt/JkOjKzLJb1elwmEHEptPfiCgvPo0Cd0xSlef0MMvfcThdmPx+84VHKQbpyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQYkeOkp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1148246a12.0;
        Thu, 28 Mar 2024 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711678788; x=1712283588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPnYnYEiLIlR/yOzXCJQfKbBHw7UwGViL9JcBPvqOX8=;
        b=fQYkeOkpgoaCkSyEvovA46PCbvCxet7KrYzfUWWnkuJjqhiZ0uWScZW+ErNoENyJPA
         XlqzUm7DoGWTHyrffDPz2t9O9z370fh0A5VGcQ2WmBjpmtknWK5QwrAvoFkOZxuiVGxQ
         O7xhLLq0c8YZ87AW3Ezq97GJeuj+qei+oa7tG1plnoPQQ/YAyEeBTjrMi0fjJ1BDfv8L
         AOwAGWrLNxMXNvJHzGjacJ6/k6Xb62AsvPt1HYipQ+iGmPRN6WvqE9JcWwwfafI1FjKp
         nUoKxsqxpyG0Koo7YBpQmKRu8HaxvhPUvuuYnZqqonBYNDYiVXPiGU9QkwHfL1UiTJXQ
         3mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711678788; x=1712283588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPnYnYEiLIlR/yOzXCJQfKbBHw7UwGViL9JcBPvqOX8=;
        b=OyZMBmUP7PYI8oI0P9D7F5VMItWU59NpQJ7CsyMe4UluGBUxi2CaGiLwQ7ncNtb5wX
         Cu2i3Fcjq0lnPhmcKK5txpJU5wqCn4E+ehn11U4rbtOzuMmKa8ACyUsZxnjqHpWBapJs
         8P+ddArMma2pLkWQMLGq2VgpunkXL+ws1Px1/nUOuAB1zHub97NfKRxmgbyNgLVnN1Mz
         9D+DcyJIjyyAP+Gz4JQ7o1sjE9rCvcnTduBE6JGhLB8/Z+4CsE67hZ6K8GHuA0DCHDuG
         kIFkL/83BsbbWQ5Hr8zQz20dNjMc5/RFgIGd8e2pI5Cm7tdGbM5CatoDrvhYFRnFxzaB
         KGPw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pjpVYFS76+1fPd6GHLfBBqM/2WkVNhz2vMmZanTZ51a/aKUBM+X6I8J2PpCCaeLZUWd4jNAUMaBMF2199kwfaD/3/P2ZYMrdglDatnOVvgeBml6MWxHgMjbL0o/mGdnC8dyMLyY6eUWZ4jBhPiqok6YQ
X-Gm-Message-State: AOJu0YyWqx9KvG4/ZzdlJIRPauAfpM0BRPPeyMI9ppZlY16gwNE3Y1Sg
	WUUy4UHS1PYHqdkLJ0OZSXjwMpL5ExpVwGxQZHQ3H1HhW4s87IO6
X-Google-Smtp-Source: AGHT+IHmDTTiLCtRHhuKzloYq78VsTqePUHAKSBRT79w1pCLj1qy1CgzY5cbxg/HuGG561/9pe1BHg==
X-Received: by 2002:a05:6a21:a5aa:b0:1a3:af03:6b0 with SMTP id gd42-20020a056a21a5aa00b001a3af0306b0mr1141550pzc.7.1711678788468;
        Thu, 28 Mar 2024 19:19:48 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([2401:4900:4e59:88b8:f462:3eea:57c6:a15a])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b001e14807c7dfsm2358346plh.86.2024.03.28.19.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 19:19:48 -0700 (PDT)
Date: Fri, 29 Mar 2024 07:49:39 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: paul@paul-moore.com, alison.schofield@intel.com,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <ZgYlO8jGSH/6KTEe@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <CAHC9VhRYDNoqkbkgdUSg-kYSHVbheD5NtezmVxyRakZ0-DzuSg@mail.gmail.com>
 <ZgUh7cIQIsOgvWpw@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <20240328.aiPh0phaJ6ai@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328.aiPh0phaJ6ai@digikod.net>

On Thu, Mar 28, 2024 at 03:45:12PM +0100, Mickaël Salaün wrote:
> The subject should start with "landlock: Use" instead of "LANDLOCK: use"
> 
> On Thu, Mar 28, 2024 at 01:23:17PM +0530, Ayush Tiwari wrote:
> > Hello Paul
> > Thanks a lot for the feedback. Apologies for the mistakes. Could you
> > help me in some places so that I can correct the errors, like:
> > On Wed, Mar 27, 2024 at 07:43:36PM -0400, Paul Moore wrote:
> > > On Wed, Mar 27, 2024 at 7:26 PM Ayush Tiwari <ayushtiw0110@gmail.com> wrote:
> > > >
> > > > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > > > struct landlock_object and update the related dependencies.
> > > >
> > > > Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> > > > ---
> > > >  security/landlock/fs.c     |  2 +-
> > > >  security/landlock/object.c | 14 ++++++++++++--
> > > >  security/landlock/object.h |  4 ++++
> > > >  security/landlock/setup.c  |  2 ++
> > > >  4 files changed, 19 insertions(+), 3 deletions(-)
> > > 
> > > Hi Ayush,
> > > 
> > > Mickaël has the final say on Landlock patches, but I had a few
> > > comments that I've included below ...
> > > 
> > > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > > index fc520a06f9af..227dd67dd902 100644
> > > > --- a/security/landlock/fs.c
> > > > +++ b/security/landlock/fs.c
> > > > @@ -124,7 +124,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > > >         if (unlikely(rcu_access_pointer(inode_sec->object))) {
> > > >                 /* Someone else just created the object, bail out and retry. */
> > > >                 spin_unlock(&inode->i_lock);
> > > > -               kfree(new_object);
> > > > +               kmem_cache_free(landlock_object_cache, new_object);
> > > 
> > > See my comment below, but you may want to wrap this in a Landlock
> > > object API function.
> > Sure. I will definitely implement this.
> > > 
> > > >                 rcu_read_lock();
> > > >                 goto retry;
> > > > diff --git a/security/landlock/object.c b/security/landlock/object.c
> > > > index 1f50612f0185..df1354215617 100644
> > > > --- a/security/landlock/object.c
> > > > +++ b/security/landlock/object.c
> > > > @@ -17,6 +17,15 @@
> > > >
> > > >  #include "object.h"
> > > >
> > > > +struct kmem_cache *landlock_object_cache;
> > > > +
> > > > +void __init landlock_object_init(void)
> > > > +{
> > > > +       landlock_object_cache = kmem_cache_create(
> > > > +               "landlock_object_cache", sizeof(struct landlock_object), 0,
> 
> No need for the "_cache" name suffix.
> 
> > > > +               SLAB_PANIC, NULL);
> > > 
> > > The comments in include/linux/slab.h suggest using the KMEM_CACHE()
> > > macro, instead of kmem_cache_create(), as a best practice for creating
> > > slab caches.
> > >

Hello mentors
I am facing some problem regarding replacing kzalloc with
kmem_cache_zalloc when using KMEM macro from include/linux/slab.h as for
kmem_cache_zalloc I will be needing a cache pointer to cache but KMEM macro
doesn't provide any macro. So is there any way to do this or should I
not use macro?
> > Sure. Apologies I didn't see that, I tried to implement it from scratch
> > using the reference from linux memory management APIs.
> > > > +}
> > > > +
> > > >  struct landlock_object *
> > > >  landlock_create_object(const struct landlock_object_underops *const underops,
> > > >                        void *const underobj)
> > > > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> > > >
> > > >         if (WARN_ON_ONCE(!underops || !underobj))
> > > >                 return ERR_PTR(-ENOENT);
> > > > -       new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > > > +       new_object =
> > > > +               kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> > > 
> > > If the line is too long, you might want to consider splitting the
> > > function parameters like this:
> > > 
> > >   new_object = kmem_cache_zalloc(landlock_object_cache,
> > >                                  GFP_KERNEL_ACCOUNT);
> > > 
> > 
> > Sure. I didn't do as it was below the 100 columns limit, but will
> > definitely implement it.
> 
> Please just use clang-format.
> 
> > > >         if (!new_object)
> > > >                 return ERR_PTR(-ENOMEM);
> > > >         refcount_set(&new_object->usage, 1);
> > > > @@ -62,6 +72,6 @@ void landlock_put_object(struct landlock_object *const object)
> > > >                  * @object->underobj to @object (if it still exists).
> > > >                  */
> > > >                 object->underops->release(object);
> > > > -               kfree_rcu(object, rcu_free);
> 
> Is it safe?
> 
> According to commit ae65a5211d90 ("mm/slab: document kfree() as allowed
> for kmem_cache_alloc() objects"), no change should be needed (and it
> must not be backported to kernels older than 6.4 with CONFIG_SLOB). This
> way we can avoid exporting landlock_object_cache.  Please add a note
> about this commit and the related warning in the commit message.
> 
> > > > +               kmem_cache_free(landlock_object_cache, object);
> > > >         }
> > > >  }
> > > > diff --git a/security/landlock/object.h b/security/landlock/object.h
> > > > index 5f28c35e8aa8..8ba1af3ddc2e 100644
> > > > --- a/security/landlock/object.h
> > > > +++ b/security/landlock/object.h
> > > > @@ -13,6 +13,10 @@
> > > >  #include <linux/refcount.h>
> > > >  #include <linux/spinlock.h>
> > > >
> > > > +extern struct kmem_cache *landlock_object_cache;
> > > 
> > > This really is a decision for Mickaël, but you may want to make
> > > @landlock_object_cache private to object.c and create functions to
> > > manage it as needed, e.g. put/free operations.
> > > 
> > Okay. I didn't make it private as I was using it in fs.c to use
> > kmem_cache_free, but if this is supposed to be private, I can modify the
> > approach and expose it via some function, not directly exposing
> > landlock_object_cache.
> 
> Yes, that would be better.
> 
> > > > +void __init landlock_object_init(void);
> > > > +
> > > >  struct landlock_object;
> > > >
> > > >  /**
> > > > diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> > > > index f6dd33143b7f..a5fca4582ee1 100644
> > > 
> > > -- 
> > > paul-moore.com
> > I will make all the changes you mentioned, and as you said, I will
> > wait for Mickael's say.
> 
> Agree with Paul and Greg unless commented otherwise. Thanks

