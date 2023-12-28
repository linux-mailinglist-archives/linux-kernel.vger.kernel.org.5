Return-Path: <linux-kernel+bounces-12332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2539B81F382
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A50283E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BF10E3;
	Thu, 28 Dec 2023 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qHzM3W/o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94480643
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9cdd0a5e6so805638b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703725168; x=1704329968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elVgyyaKQHa7CChhGztKeZdMb8vyhIwMcGn1pS44Q0s=;
        b=qHzM3W/o71rf08S67l55iJEqLw5xcLpJwdIh9KshmWhdFmgKxHKKVO+1y/nRjGYx6V
         5CR/YDINFEWYChbJ4JbtXTYFZhowVaE/z47LyWPv3xkl+F626eXiKa4hXxHpN1wZSx/j
         Y21rWCMlm7XeQfoUP/ySP7eK90UEwCitdTdaq5jDaDTwUO7+IxAW8GPb/wiwkIcrKcMM
         cENBcja51GdYX2drgwETSQlL+Uw9EzWdHQSB/RcNsbTnKSXnln3jqwyalhgXXoabA8Z8
         JcfkfdWQYkUurxidWpTIUnZDPmJomJOPOl1fuFu6yfTc4qqKtjyjvuSIv3S8ovViKWul
         0ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703725168; x=1704329968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elVgyyaKQHa7CChhGztKeZdMb8vyhIwMcGn1pS44Q0s=;
        b=cGFyadFdgtz9isP3C5rayxbhJJ9dPkmmIUV/JQ9KNUxCrFIhWilds0qKjB4uJRMEGB
         IAWj8EXg3BM2L6Ky6vIpAIergswQO05l9AzedV8FGtFuacOVstyUe3Tx6mabr6d8jWDe
         QHIawtdCkywhKT22L5YLKpbImMJm8ZpQt7mbZOAZlgQTV8jy1ZEYwKicdlpDvHfQdzq4
         7WaMncCzqYgoslFQoIiyRXtnJnlyuTPhe2dWNC/sF6BEu2ljbnhupqLlD2xpQDdXLbxW
         NBGYie7fOWaoSNh1+YsjzydqqbwN21SR3tScJaWLaGnAw+ZU9vueZn5RE/96W4zz+uNv
         PckA==
X-Gm-Message-State: AOJu0YwIdr9n9J0THbbKRdyPoUSqHGxRbF35LRHKzJ1LNSEsnIk2rsHO
	AFthJFitnzmfXWTXLObyPbBsbSB/Wkh7qtV9Iw9dPI7DQFw=
X-Google-Smtp-Source: AGHT+IFyHLd+rhmzrLa2GEEDyTbBm+WUcrcXFuc0p3vpjTEYuZNglA+fazKRXFRfzHbdPhiCdIaCUg==
X-Received: by 2002:a05:6a00:1241:b0:6d9:af0b:2af7 with SMTP id u1-20020a056a00124100b006d9af0b2af7mr2321541pfi.65.1703725167911;
        Wed, 27 Dec 2023 16:59:27 -0800 (PST)
Received: from ghost (070-095-050-247.res.spectrum.com. [70.95.50.247])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b006d9b5b3ea1fsm6614432pfd.22.2023.12.27.16.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:59:27 -0800 (PST)
Date: Wed, 27 Dec 2023 16:59:25 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/kernel/module.c:639 process_accumulated_relocations()
 error: uninitialized symbol 'curr_type'.
Message-ID: <ZYzIbVfge6I8Ptw0@ghost>
References: <d0897fb3-1af8-430b-aa8b-9aa829bad1d7@suswa.mountain>
 <ZXoFhu2TPXgrsInY@ghost>
 <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>

On Thu, Dec 14, 2023 at 11:00:46AM +0300, Dan Carpenter wrote:
> On Wed, Dec 13, 2023 at 11:27:02AM -0800, Charlie Jenkins wrote:
> > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01  638  			}
> > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01 @639  			reloc_handlers[curr_type].accumulate_handler(
> > >                                                                                        ^^^^^^^^^
> > > Can the list be empty?  Uninitialized in that case.
> > 
> > That's a tricky one, the list cannot be empty. Each bucket in the
> > bucket_iter is guarunteed to have at least one rel_entry. I can probably
> > resolve this by extracting this for loop into a do-while loop.
> 
> You can just ignore false positives.  It's not really a fix to change it
> to a do-while loop.  I reviewed the do while code before reading this
> email and I still wondered about empty lists, but just to hear that it's
> not going to be empty is enough.  Just the email was sufficient.
> 
> regards,
> dan carpenter
> 

The fix isn't the do-while loop but rather the use after free, the
incorrect sizeof, and incorrect error handling when
initialize_relocation_hashtable fails. I decided to include the do-while
code because I was already touching the surrounding code. Can you review
[1]? If you would prefer that the do-while is reverted, I can do that,
but it is important that the rest of the fixes are merged before 6.7 is
released.

[1] https://lore.kernel.org/all/20231213-module_loading_fix-v1-1-da9b7c92ade5@rivosinc.com/


