Return-Path: <linux-kernel+bounces-23465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA9882AD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D48B1C21737
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0D1549A;
	Thu, 11 Jan 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0/p4iXL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D515484
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3368abe1093so4138919f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704971795; x=1705576595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMrj071u8QxSrpPG+XgJOGjzHRcUM7yJCNZgbHu8j4E=;
        b=e0/p4iXLx+14e1WLRMDgpewM0MbzoGoWCZnqSToEVr1P334ddvfzOdIOr/BC7/uNjF
         vQrULfTB+AvX85ZqQQj9RQF4RFbI3JTN8UvS4ovVTbINxP8ZcS0MeUP74FFLN/ucXyEl
         N4zQWjDLktR9cy4pfnN/gP0esLBsE6mPaMJV6NGLRbCuFMqfb4Ej9+rzeI6YEifR2eXS
         /eIWFuoUHDS+fFmCgB8v1mSsJgAi92jZGck5enGOiJMs/RzpIm54RwmsHY7PiBuSd5Y1
         9CZzgemcj7E4/i5A2lcX3wqlr6cZLuFzbIIKxDq+LKpnoICrtyUfZVRVr+9p1SSUx0Eu
         X17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704971795; x=1705576595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMrj071u8QxSrpPG+XgJOGjzHRcUM7yJCNZgbHu8j4E=;
        b=t790TTvA9xTfLjQePaaGQFZeKev0kcKNzXn7MW8aow+g1zVQX61fIMrGrVhBTTYqOZ
         NZievD+YkbC1PVOsvalZAZoG5rWfCQSmbFIYkQ52Z1Sg7UWc7iNlO50Bcm7LaKr9i7XW
         qGebsMH7LVSs90LnCFAUZ8222xr6XGi/DRpjVv7LZuejvNpdUWlXEAqcVFqS7WqXoPGi
         1v18/5ZEABYqzBL6JdnrKAPV59BzTCoI0DP5GGlxSkM0Wk4lJlW9R8wLDwFQKRQp7zKu
         K0jo2p/Ro/pa1gsMR0kC1sgikK0B2Bz10Ijp8C0qN9trtmBNh6FnOOpP6aSkWvF3CX3n
         ++IA==
X-Gm-Message-State: AOJu0YyfZTf92gOpFMP9CknH9e7j0ZPcuthThnj3NQSeA/EM2TkuQz0H
	fCxgYwOFt6pX4/CuPdIdZmMcud7x3/5xmw==
X-Google-Smtp-Source: AGHT+IEPPNVvbO5ZAGHaJIqpc3i4tc1NLOXiXRpJBAk/R+nqSaMM7qnZtN104k+NMK5aCMx5D6B0oA==
X-Received: by 2002:a05:6000:11c9:b0:336:76dc:9b48 with SMTP id i9-20020a05600011c900b0033676dc9b48mr488079wrx.91.1704971794944;
        Thu, 11 Jan 2024 03:16:34 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p19-20020adf9d93000000b003378ea9a7desm157130wre.33.2024.01.11.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:16:34 -0800 (PST)
Date: Thu, 11 Jan 2024 14:16:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	clang-built-linux <llvm@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized
 when used here [-Werror,-Wuninitialized]
Message-ID: <628bf675-77fc-4ccc-be2f-9c3ec8a7b0b8@moroto.mountain>
References: <CA+G9fYvDNksfKNvtfERaBa9t2MJNucfD_s3LgKGw_z2otW+nyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvDNksfKNvtfERaBa9t2MJNucfD_s3LgKGw_z2otW+nyw@mail.gmail.com>

On Thu, Jan 11, 2024 at 04:23:09PM +0530, Naresh Kamboju wrote:
> Following build failures noticed on i386 and x86 with clang builds on the
> Linux next-20240111 tag.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> ----------
> mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when
> used here [-Werror,-Wuninitialized]
>  4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
>       |                                       ^~~~
> mm/vmalloc.c:4684:20: note: initialize the variable 'addr' to silence
> this warning
>  4684 |         unsigned long addr;
>       |                           ^
>       |                            = 0
> 1 error generated.

We turned off uninitialized variable warnings for GCC a long time ago...
:/ I don't know if we'll be able to re-enable it in a -Werror world
although Clang seems to be managing alright so perhaps there is hope.

regards,
dan carpenter


