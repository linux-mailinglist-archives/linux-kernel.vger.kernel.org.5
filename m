Return-Path: <linux-kernel+bounces-106969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F387F625
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AB1C21D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76577BB12;
	Tue, 19 Mar 2024 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6X6jc5N"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F457BAF5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819830; cv=none; b=ZADrlqtmKWPQQeABDcLf9kdD2wdfS6fwuMJZeL5hbI+SPJJSJASh4OsnMmzupM2GW0Mu5/KCrvDTK6GkPTfroTaNac1oihSKX2el5rHBN1VRMWXvcfKSc+QHyU189kYh6wF9Kv2eT+qWRIOnFqhKj6iB8LkaiFA9vgcAj7B3wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819830; c=relaxed/simple;
	bh=3C4E2lx6oAGZiXciFhbwxkPXYmgCY2q8GuKrU9E9utw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEHbGiFw4BWhcwa/kBGOsau9X+jCGfyRnfnly1RnXAUvZhbIm6OlNKZy0IPVCbGHpwIP0ovlFF/yHoPvy/iirlypphosBz8GGjOqBJsk/Q77ZKiChyClRKahI5RvE1UmA30ontNurdEm7g30xiwSKFgkJ5Zv4Lrq+2JAFqJWOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6X6jc5N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e00b1c2684so16937705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710819827; x=1711424627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTGQ/CESZvXFazF6RKBF2ndPgzjqBAvim3Dzh/cpoLI=;
        b=I6X6jc5NDrSrjqQ9wDE7ztsQivhm+Y/3+61NJkk2Y6liOpMsrdeaXoIe+DfTN0X23c
         fgD7hPzgy5MJCt99p7dCamS1NC2oQ0aysdEkyuKshM8xLCLhAl/8c0CUWrHhzI1qhYna
         fRQkg2VAxjNATIZd4sqHQuyov4K/JrXK+Syyp5V87troGWt2/F3Jy3FHavHwzQ+qdR15
         cTd8kuRLS03JDo1MqKIxph+R0JoYLUkwF5RiMjCB8L1qkmJPkHMEV+Y8zgWowDv7WyrW
         maTeWvHWHHtho2vkJTyXasogOibWuStC6jaMAqcs9xcZ8ofFyHvlEE613QbOZ6WaXiDo
         f3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710819827; x=1711424627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTGQ/CESZvXFazF6RKBF2ndPgzjqBAvim3Dzh/cpoLI=;
        b=oiZZyvIbo02weJUo8LCP9mKZSPlAUYrNchIQLlpvOIZHMTw08QWM8McWC8z0s5GlG9
         OYyJnlpr3Td6ui9P98hK4Ixyv4KEVEEXQ3k2X0GdznXpBk0nUX7pHvhu2+SbVlnIiIWU
         7F8hT6M2utOkAwtmTsym1vNsNE0EIQJ0qY6WkF+8Al27/yrsj++5n3QdEPcAjibzabYK
         0Iy3p6xmS5x1hdjzWZ8Za1ZtE6muoCImooESGw8TpnixmmWyrmU6mst7u+cWwZuAsWzg
         pds2Fadp9DHRp7/qtBqJmxZGwnjSp6X5+n2b/RCQIoR4Q+FRFW42VYg3km+P21/iGCLn
         TFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdX+FRSDMJpMsqaYK8tTDlhjwlNHG+5LWoNtxyXeCkudLWi7dJrCebeNjceX34UQBUGzpw5iKV/O3TiOlZ2GDG615Q8CR0nbX6RgCl
X-Gm-Message-State: AOJu0YydUQiqOoMhe76inl9nvz0gqLPQZmB9ViPq7Bho5wk2csxTnYvm
	5hAoJeWhPQyRwWKd8WFRMIrWO1KEw2bS/YFYA/LX95PzLsRH0yRx
X-Google-Smtp-Source: AGHT+IGF6XFce3wwu2xZ+ChVYZrAz0ml2i3vnVaxy8yPDuwGkXiOwrwQ/h6ZJ2CTnpwIzlaJ3R1Rcw==
X-Received: by 2002:a17:903:245:b0:1dd:a34e:84aa with SMTP id j5-20020a170903024500b001dda34e84aamr16280829plh.48.1710819827491;
        Mon, 18 Mar 2024 20:43:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001dd4b1fb72csm10141894plb.189.2024.03.18.20.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 20:43:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 18 Mar 2024 20:43:45 -0700
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
Message-ID: <352dd5ec-31f3-4716-8411-b5a3515b175d@roeck-us.net>
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

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

