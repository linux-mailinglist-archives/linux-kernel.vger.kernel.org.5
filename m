Return-Path: <linux-kernel+bounces-128356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A958A8959C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BF51F2322C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A415920C;
	Tue,  2 Apr 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulL8ERGG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86178158213
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075613; cv=none; b=F58XJp8RYKiOcLhDgDVZ6zW9Lz2kdXq9p4Qcssfm84/CmPSN97Ty3V71pwRPOyyTe2kd5IrrvLfNeHu+dW7KbW4xxs5MlHkGeQULrNxNNk4lLB4XrYi/1lUlGmzFoZBXiz+7hVmSoTrzoOnAccqMT/jUl5oBMv/A04kJoq4Z8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075613; c=relaxed/simple;
	bh=QTAUVY7LfjE56ADj75f0WHyMKTN0jzSyXtQIY6XP++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukeiA/pYnHldI1a8bzUA0grBw29hvfLbAWP/7jq6ceiIDeC+YCj3/Bb8iFV/Y2zLyEpsvMTgkYYTPnOQyvkpy8IvBb66ll7MdQuNDH0UfIzsWD1L410y6C9814ZhW3Pbv68hKb9iEydlivDNny8lqpTVCipN9ilXdaZiKTBzcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ulL8ERGG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso9053965e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712075609; x=1712680409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eBAi60q8FF9/ONXl+YI1oi2f67+yFwmO1MPFJZV80Q=;
        b=ulL8ERGGKXeEFz5R0MhpuFgRwSFXGJWtMnM5j6yjlITyniONZ7Dns10Da7oDlzKkkK
         DhaJURcpz4EXYT9b2wg5I840E3bWyL4hePlx4KQJ8Q5N1tGmz56/VRTvb+WPac7aVEDS
         6lPqCLWMCx2YyUB77ZCQpdQV3aH1PxSurdFQ+B87IymO5uAyhISM7Q10GpoImLSjCSeo
         4VUa9ZatmvakTPZ8UcpsuBXP0BmrU98/kE1z5h9ePwujV5S/9fR+g3BALQ7H0sUo54Ne
         tBGaVu3h5y9qsXdJEQilEpo9hLzADjYoqUDLHqoGaH+wW7kqlU8Fx4WHNkGTTTy5Ay3p
         QAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075609; x=1712680409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eBAi60q8FF9/ONXl+YI1oi2f67+yFwmO1MPFJZV80Q=;
        b=leHVx540qcxqIiuEK9Dasuw9c6bSV3lnzUracYFbnvJjXwR7sQon1OWGElvW0v6RCK
         0cuNbDo1AMq1TQTuoqkggDVj11aWUZPgmJ1nltvbLQ9JWtj7XTCupyJWJtYEJBJUsIGN
         2ZyobcFWc6t+A5DNhCPAjvlGO4ROeV+wvPSzuniLgypfDJcplkZPXgojb6gMoJ5JnGlk
         M8X/04JMINBtNJvcpr3hxJbr6gfGPmWSyB4vyaC8TkRi1zeBfytizGaOhxtsGi4ZEa8B
         KYeXakHYoHCuP7V5vaTqKPzANlAMhb5Ui2PqQjLhFBY4upYp/pQDFo4+i9ckaSy1013I
         2ohg==
X-Forwarded-Encrypted: i=1; AJvYcCXkSb2GKX5gXq6JUwNMwuxAYEbopVC+AEwMvwsoBUCMTUGUoxmHm/kENDgYlRonXLsZV3bS7zVD6sQz6FPJdKMIWkQovd+0QXJtiPvO
X-Gm-Message-State: AOJu0YyfqlqiGvxyfunfR7J3e29OaeYPKPGTbMgb1hFLi5t19B/m49LE
	lO5yCfl1rGStbBhhTpdxMVmmw/sLo14+P9gGjKg9PTOHF58hGObhlLg+sVYPVeM=
X-Google-Smtp-Source: AGHT+IHIX7s2OjCovkzetlaRfayUzrdv/CIw0hPqydZjXFMP92Xd72ZPjcSjswpyJLynuJFUczcOOg==
X-Received: by 2002:a05:6512:3f28:b0:515:a9d5:aab6 with SMTP id y40-20020a0565123f2800b00515a9d5aab6mr2176422lfa.18.1712075608669;
        Tue, 02 Apr 2024 09:33:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o16-20020a1709061d5000b00a4e8cf42527sm846771ejh.121.2024.04.02.09.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:33:28 -0700 (PDT)
Date: Tue, 2 Apr 2024 19:33:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	Grant Likely <grant.likely@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v3] drm/panthor: Fix couple of NULL vs IS_ERR() bugs
Message-ID: <a7d59aee-f8db-411f-9bad-729baff35c88@moroto.mountain>
References: <20240402141412.1707949-1-harshit.m.mogalapalli@oracle.com>
 <20240402163838.34003a10@collabora.com>
 <91e25b42-c3fa-4b69-ab8c-5d79610e757b@moroto.mountain>
 <20240402171925.41dce3a5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402171925.41dce3a5@collabora.com>

On Tue, Apr 02, 2024 at 05:19:25PM +0200, Boris Brezillon wrote:
> On Tue, 2 Apr 2024 17:44:18 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > On Tue, Apr 02, 2024 at 04:38:38PM +0200, Boris Brezillon wrote:
> > > On Tue,  2 Apr 2024 07:14:11 -0700
> > > Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> > >   
> > > > Currently panthor_vm_get_heap_pool() returns both ERR_PTR() and
> > > > NULL(when create is false and if there is no poool attached to the  
> > > 
> > >                                                ^ pool
> > >   
> > > > VM)
> > > > 	- Change the function to return error pointers, when pool is
> > > > 	  NULL return -ENOENT
> > > > 	- Also handle the callers to check for IS_ERR() on failure.
> > > > 
> > > > Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")  
> > > 
> > > I would explain that the code was correct, but the documentation didn't
> > > match the function behavior, otherwise it feels a bit weird to have a
> > > Fixes tag here.  
> > 
> > The code wasn't correct, it returned a mix of error pointers and NULL.
> 
> AFAICT, this is allowed, otherwise why would we have IS_ERR_OR_NULL().

Yep.  I have written a blog about this:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

> The fact smatch can't see through panthor_vm_get_heap_pool() and detect
> that the return value is different for create=false/true doesn't mean
> the code was wrong. I'm certainly not saying this is a good thing to
> have a function that encodes the error case with two different kind of
> return value, but I wouldn't qualify it as a bug either. What's
> incorrect though, is the fact the documentation doesn't match the code.
> 
> > So it needs a Fixes tag.
> 
> I didn't say we should drop the Fixes tag, but the bug being fixed here
> is a mismatch between the doc and the implementation, the code itself
> was correct, and the behavior is actually unchanged with this patch
> applied, it's just done in a less confusing way.

Oh.  Sorry, I haven't been following this thread closely and I misread
the code as well.  You're right that the code works.  In this case, I
would say actually that it does not need a Fixes tag because it's not
a bug.  It's just a cleanup.

Sorry for the noise.

regards,
dan carpenter


