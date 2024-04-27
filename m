Return-Path: <linux-kernel+bounces-161133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D921B8B477A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E628254E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768D3BB47;
	Sat, 27 Apr 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anzltQLf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6833C8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714244721; cv=none; b=AI/udHWA8AHRnbJcUy9EhuuTSr7nAIBmIyQVRcl4hg11OZhCmOoRetlo31HwJRTabo7szFx1OcQkPQWPtIrpgzcesNgqRT2ptRgkOFBz7C4p51m77Z5JWI9qXueBs4WTCOCxQC/1CIYcjspde51z1P0eYx75V+v8BIuaNbB4/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714244721; c=relaxed/simple;
	bh=1qHlCwsYaCQ2lRQllbAqblfxjCXjafgdSF5F/OJynjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD1bZkm+MwA+foLJcjgvxJ8pOrYaDRVEM390LQSQF+mrR0kVqFvjfdqTM5I1nQ2WoPKaTzaQ9ZB2W9m8kdJurtMj9pf1YLyrEwPAHvAdhmt9n4nT83IKEgYUznP3UzOYJLxzKeawklp1RbPyX3AvNOQom15XmSTbeoMoLgpKhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anzltQLf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2bbc2048eso28616915ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714244719; x=1714849519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p44pgiFZQovptJOnddSp5qDIAqapsQkYUFKjyJMajl0=;
        b=anzltQLfiA2Dn/gjv8GcF7wEKH6LeanxgI1fjnMykUxWlUvpbRyAswDW+ND4VxeEjI
         owJ9OcFuzGa4EyclH6pEDIXg/OY1uDsK2+57CKwtF1VmxgTa+E/SYTtHpndx39eewGvx
         gg1Ah7I5fkD/+IjlvP1LqsOSp675TTkJ1Vu8yczpKZj8rrjMpoGp75JvAyxcHs7N/F1S
         WqKfiF+6QYWpb7REQ2WtBL/MMyF3uq0UPo7dpQKWjiL2iNXrND2VRmRFNmtu/Pll25ou
         uol3hcSJkxlA1fxNFjU4A/d4XLqYgX03zYMrONeel+qPrLq4WxRxuUFGyoNQsQJKDkAI
         0TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714244719; x=1714849519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p44pgiFZQovptJOnddSp5qDIAqapsQkYUFKjyJMajl0=;
        b=YQ0gTVCLF38I4OYz8mrh+tOb+61tSUDcKfmsTu0efh2pXW6R8SZcZtVMu1PFns4jrm
         rEGHEgSJPS6XtJc5Nsx4B/R78ePOP6JMTdNL1A5pG+Os0QWIEQ4IJ6HGtWqFjRWkTM98
         Kqx/Ng9UxcDM39ivy8BPDMM8dTOOAqzJfpDOb9nTRHRwACHgDsr5XqIROwcdYfMunPPK
         W1q2Rdf3OLO+uIfJ0hZhqBQ2laTGu/LXc/Qfvsm2sakyPJ08Mr6wlLeOjTukICkFGKoA
         hkiklJY5VP3WG44yAMGUZoEKM8MGxcyNodNTwyV6nfa5OjUeVR8Sha2GX8KmF0FkIzXB
         JPUg==
X-Forwarded-Encrypted: i=1; AJvYcCU5lYgv+QB9vnkGNnm9YqgdlquI2XFltVz8JKogJWyy4YfyRdLxRc659OCO2vUiJDho+wt+0VgmDLjXcLW+Gra6OK8MVYXDu618i9GP
X-Gm-Message-State: AOJu0YxeopRXsRoqfs6OZCaiPx6uAFLhe39ffSECPS2mKcIUAbXZGyzB
	O+binhBwOqngot0dRwhwnzoi6Nlzf0oZOYToFJfhrDKF9lwsbkqX
X-Google-Smtp-Source: AGHT+IEV+6If6dwEWpp/lUf7r4DALNdnHD8eYWvKrfReaVqmDBg418UtiTMNU9+MN4vJunVxVKwDcw==
X-Received: by 2002:a17:902:e5d2:b0:1e5:1867:d9fa with SMTP id u18-20020a170902e5d200b001e51867d9famr7289497plf.44.1714244718719;
        Sat, 27 Apr 2024 12:05:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001e3c01dfaf5sm17388384plx.24.2024.04.27.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:05:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 27 Apr 2024 12:05:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Barry Song <21cnbao@gmail.com>
Cc: chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	dennis@kernel.org, alexghiti@rivosinc.com,
	Barry Song <v-songbaohua@oppo.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
Message-ID: <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
References: <20240319010920.125192-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319010920.125192-1-21cnbao@gmail.com>

Hi,

On Tue, Mar 19, 2024 at 02:09:20PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> generic implementation for this case in include/asm-generic/
> cacheflush.h.
>  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>  static inline void flush_dcache_page(struct page *page)
>  {
>  }
> 
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>  #endif
> 
> So remove the superfluous flush_dcache_page() definition, which also
> helps silence potential build warnings complaining the page variable
> passed to flush_dcache_page() is not used.
> 
>    In file included from crypto/scompress.c:12:
>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>       76 |                 struct page *page;
>          |                              ^~~~
>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>      174 |                         struct page *dst_page = sg_page(req->dst);
>          |
> 
> The issue was originally reported on LoongArch by kernel test
> robot (Huacai fixed it on LoongArch), then reported by Guenter
> and me on xtensa.
> 
> This patch also removes lots of redundant macros which have
> been defined by asm-generic/cacheflush.h.
> 
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
> Reported-by: Barry Song <v-songbaohua@oppo.com>
> Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net/
> Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

The mainline kernel still fails to build xtensa:allmodconfig.

Building xtensa:allmodconfig ... failed
--------------
Error log:
crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
crypto/scompress.c:174:38: error: unused variable 'dst_page' [-Werror=unused-variable]
  174 |                         struct page *dst_page = sg_page(req->dst);

This patch fixes the problem. Is there a chance to get it applied to the
upstream kernel, or should I just stop build testing xtensa:allmodconfig ?

Thanks,
Guenter

