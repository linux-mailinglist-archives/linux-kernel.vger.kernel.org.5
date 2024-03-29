Return-Path: <linux-kernel+bounces-124052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CE891191
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987421C2A5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74681DA3A;
	Fri, 29 Mar 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWvtN2Nc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67A1DA4E;
	Fri, 29 Mar 2024 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678494; cv=none; b=sr3k9zXa9k6xeWXq64eFC0D0rXXZYYIeqY2OXqBlVW+tVUFfakdVVoPJMtldFib9rOmX3FmTfSv7g33QXYMPCeUxdpkXM1bvWcomjYezm4fJtEnDjJp+G2JPNgxn9MtCOXUQg0Axh6lyeSYUQe+HU5S55WhmtwmxD5xh0oX0kRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678494; c=relaxed/simple;
	bh=DhZdQ2iI7Zs+BqDVOGl/HOsjIT1jvsMP+tqZq0VoEFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC6Fb2P/+Qm2dt5CGRrtaMBwc5Q4xiRx6lKR0TPahHrAqhPR1Lgm4efb4ZTQdAyXZL8lZJ6EoGHLaYuWj06Nm0y2XscFRlbPxvpZomh+JMu8Ggu5hs3+bJKeIxXaikIdSOZ0atSEU/wmgC2aZO5mH39BlG2zi3wKz78OwBMtAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWvtN2Nc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1def2a1aafaso12171355ad.3;
        Thu, 28 Mar 2024 19:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711678492; x=1712283292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHKg/7V7Pl/oLudfM0ileqdKuhPljGzHIMYbgvPiGiA=;
        b=LWvtN2NcWKtQpPb59VF/GBak8NrRXRB8C2vS40r0fcXG4ktaM6BvoEfA8/DbI8kUVh
         2BPFAW7hFDf/ZrpR5aTKkrvN9j0WjKis4wM+kF8YJjD+RLdg47OlTeHa++SqOIT6f3z9
         5Cwum59JJmbxuV80yNR597Kdp6CH8sg2uKWqLCZc+2dfRd7S7mDM1e4T+rVd9DdCM3D1
         +pCJyKrRQk4Csj7im4SnVHQqxS2RhkOnpUQ0tBu7pW155sB3LqSkbgWbDGxh8JPYgxv/
         vpS6zqdo1FJc+Y9Wesi+OXNtTPAyRRu3zmj7L1Qa+k3Uce8PuGMwj9vW5wWAtLSbiZ6y
         AA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711678492; x=1712283292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHKg/7V7Pl/oLudfM0ileqdKuhPljGzHIMYbgvPiGiA=;
        b=CLNvWdgVfs/Tak/m2IdgfAWRIkvQVQ6mWdxpW38/82dYyq8Qdenc/yV86OPtvr6sRR
         GMMFmuk4T13AamneyhGQjH5fdWOUT7KN9MGw8tbxreQuQnGuDFIlXseP8+8yawIwAcJk
         NEMQe92xq8K92oAOnHwhWnYyMr8r17FLfp82lxWyTeCBl2TXz4wb48PWfsRtd8MABzGd
         jCfBQ5O48KlRyRYmK+I9CPqljlmKP08r4u6uy9h2PpyfMr0LgxM3TiDYjz+XAgHDiNMk
         eRhT9ZEyzxOFeVxh3lJBBD5aSvdEnO1Y5xIWrP6RIKZfF0yRV5eHYPtzKYgZUYnSl3fR
         xcWA==
X-Forwarded-Encrypted: i=1; AJvYcCWHHYpVyZ1lMcBzspN16x96gDDNqNcVYvCq9+rCwTUS5BZnUO2gOgW7Hngz1Yaz0OTozleJfxMxVGGvQLg7GxG0M/yK9pu+pq+BVKBsF7eDxfR8PY/86AJROenky+IsxHjjqk3zV8+t1NnmOFJLMVhWVhlG
X-Gm-Message-State: AOJu0YwI0R2rYHntmZR1uRVp7vwF3Q5AdB4vW+FwoSevIhGAeTMEXwCT
	EGpbqSLsD09K9Q5/eWnfn68OcKa/1nSa+s8Iy5gwZ++jTr6IkB0R/pfpfccObpo=
X-Google-Smtp-Source: AGHT+IFvOpFFrQkbmzDEFb/cGsaj4nEqoC3f0kHNWirc2xKMaRHRNGExfwgCVpA/5A/dRRUx2hFrMw==
X-Received: by 2002:a17:903:1210:b0:1e0:27c8:5c7e with SMTP id l16-20020a170903121000b001e027c85c7emr1375866plh.25.1711678491960;
        Thu, 28 Mar 2024 19:14:51 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([2401:4900:4e59:88b8:f462:3eea:57c6:a15a])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001e0b5fd3c95sm2342659plg.259.2024.03.28.19.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 19:14:51 -0700 (PDT)
Date: Fri, 29 Mar 2024 07:44:42 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <ZgYkEghv7lFK4K4+@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <dfa6ddcb-9a2d-49ac-90b7-bb30b23e32c4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa6ddcb-9a2d-49ac-90b7-bb30b23e32c4@moroto.mountain>

On Thu, Mar 28, 2024 at 09:39:14AM +0300, Dan Carpenter wrote:
> On Thu, Mar 28, 2024 at 04:55:57AM +0530, Ayush Tiwari wrote:
> > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > struct landlock_object and update the related dependencies.
> > 
> > Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> 
> Is there some advantage to doing this?  You need to re-write the commit
> message to give us some clue why you are doing this.
> 
> regards,
> dan carpenter
> 

Hello
Apologies for the errors. I am working on a newer version, instilling
all the corrections. Thanks for the feedback.


