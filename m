Return-Path: <linux-kernel+bounces-124199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F08913C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815F1288C68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE022249F7;
	Fri, 29 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ2x+jpW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F8A5F;
	Fri, 29 Mar 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693950; cv=none; b=bO0bE+xd2dyjp21N0+tgDHo8RARxdzpoRje1ig2wQIpDr51RiG8ZQ+OvtIlSe2PoPC/J1cvwJiM9o0fhngJpCjx8no+6MnEbhin8y3aS6Fw09Bc8LqohvZzsy6ppSLM6nrKmtO9OTFMl1T8JbwnOv6SzK1UN26A4k6YBadgtbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693950; c=relaxed/simple;
	bh=gmr2fGvLS//TG94CAfSgeLtnfySif1Al3X5cocCuKwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+iDmP+0MAHF/gRH8ZbCkw9EDO0Ytn/F3VknIIQlfJiozRnGD/UjsvWOOIfbRjxP/xgM/HtF3dMebWtCSoVowKCcrHBBrlr5ZoINidwsygtEzgAW3fP7SioUoBvTdNwIqJTcZMQp/cfADZZUlWdAhRbghbgRxFBB6hX72PmxId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ2x+jpW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0b213efa3so15859645ad.0;
        Thu, 28 Mar 2024 23:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711693949; x=1712298749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ndZTDMZkOJjEBIZTkRxOowZw+YYG8BnbmCDk2dhnrRA=;
        b=RZ2x+jpWsUYpppki59ltJxVmZo8IshWzCeDjgN/b+9xu6y87YW+voOiJVy/KOx/DMB
         41RKZPwHNIvNEtfRJ8eTpkg9LWAoxiwOez6q2seTZedaN8Qd1Svp0/uUcB1+4y/fnAOD
         D1oSVnPeRT9m2xi2sv/lvvQuVZZT76FkdCsAvwq+Zy5sUM9PolUOZgEuWFXjUnZtcVgq
         ZMux27gRbTjBc91UXHySGtfe1hZdqGsh8VTT3jmVJv0AyH72Pp1ZJ90adyQNXLsZykGJ
         /YT7malO5g9CwTYBGDHbOMDguSwcbpUG0bjo7NBjPRns0W2O8FnxYtIE2Lv0SaYqX0P+
         zSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711693949; x=1712298749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndZTDMZkOJjEBIZTkRxOowZw+YYG8BnbmCDk2dhnrRA=;
        b=HvmimAu9EjbcKf3qVbnWP8GgOhUnf07tQ8TGajFP4jRjtaCmcoyRqOIZ/kU/IzGepc
         jaZhBf4bsgp6tOKGNTJoLU2n02LwbWEJ9CM44YqlKskhzAO+ECkEcnAnPBc4lm0pbUJf
         NoXwpHI8cGdSRdqGvVYuDbN68OoeGkNgIIEmIi7K+imictJ4mxMTe8WxlcasVHM8neZc
         6oXx9z8DO+UoYfOt/fULJotFfHKlT4tKXo7hASwjWXB66+SZrDAB/KgVBgpBb5xw62jV
         ItSaSVPOkKOfLAdfpSPk4L6ffZtgibP5RZW01fr+N+tr22B+o2pG1FSkFrCAWJqEZ+FU
         cJSg==
X-Forwarded-Encrypted: i=1; AJvYcCXFzbcOXCXZ35SV01URDq2asQSQ+uLAQZyI+ub1FSdEruQdwzC1ovRDN+1S7MgJj/nuz+mVMb2TBK5QM3laByJKkG+1envCf8Hn9ttkfR72n+xfJK6GO6T3bXSJadn5NHxN4SHZ3FzJk7Fv1xg24Hab0qhK
X-Gm-Message-State: AOJu0YyvvU0GSYT9I5Z562BktwacbwXGlXlxpF/0m4EKTG66waBmg35j
	A4fyClp7B5q2LkQx5ej2/+a7tIQlUluUJjl4xwRqHNAHMDr7epF5
X-Google-Smtp-Source: AGHT+IFRmRQDyi7wwRtuc+POHnQVkysYigDwuTM6Oj37xtRf77j8LUvU+FV6uM1zEsYDb2Kum7ldDQ==
X-Received: by 2002:a17:902:c406:b0:1de:eac5:9294 with SMTP id k6-20020a170902c40600b001deeac59294mr1828172plk.13.1711693948781;
        Thu, 28 Mar 2024 23:32:28 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([2401:4900:3a8b:cfcd:75f4:f0e2:44ea:221c])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001db8a5ea0a3sm2742058plg.94.2024.03.28.23.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:32:28 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:02:16 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: paul@paul-moore.com, alison.schofield@intel.com,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <ZgZgcPxkG1TEVnt6@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
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
I was trying to work on the above suggestion and I am facing some problem
regarding replacing kzalloc with kmem_cache_zalloc calls when using KMEM
macro from include/linux/slab.h because for kmem_cache_zalloc I will be
needing a cache pointer, but KMEM macro doesn't return any such pointer.
So is there any way to do this using macro or do i have to avoid using
that macro for this case and use all methods regarding kmem as defined in
the linux memory management API doc?

> Agree with Paul and Greg unless commented otherwise. Thanks

