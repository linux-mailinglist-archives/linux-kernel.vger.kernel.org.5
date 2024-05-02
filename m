Return-Path: <linux-kernel+bounces-166605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB48B9CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560B41C22DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F1155322;
	Thu,  2 May 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLivlWfH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92891153BD1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661745; cv=none; b=NpUKmEgCJKxZspNe7EqeOGijmq2e8sOp+9bvUYat0Nt8wvEnOzHndjlH84LNgfW9fp0nU5DMvcd1oR2+Y4iCfoLlhkevX6LMj076NoZDgrOJLrODcWKxAJm64j7JDWBHeWkcTp+zwTG99ikv3Cm2f2rj2Kex1dnUla1jupIncLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661745; c=relaxed/simple;
	bh=qH3j0a0xCyqfLiGGyC52j1KGgdnJBMoR4O/4aTJahcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAcQ5j+PiDh7Rk9ZnYrO0wyR/s5X9fm+GDKHEtzSAK+KroPKmTPs/2e2tetNqnHsfjzAGWoq+TM+qg9t9SofSFQClvv+FehJbvl3i94DMUh/4sUbC9pCuHehT/+4GcIQGwkmLVWpBCo41qK8fNsiwmRKKlBmo1+QbXmDYV5kuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLivlWfH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso7375900b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714661744; x=1715266544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrEUOvK097HKAstA2TkGDsib8opUQaNCIsTRyOHR3Ys=;
        b=KLivlWfHx+20lbTa/7kokmNDwHLq65foXCzR/fxjUreYl7xoty2Ek0/DgeBtIDBifz
         azDOYOHZv88ddv15lc10QLv+91CFKoBSn/yYi60ImIAbxc/S9GiA5CyrjNIPqFvn8kLU
         PRRWjKhStLgzmA9ncJq8MtYbY66eIWk2nEAwg0UHVmNjf8GqhE5YBo4eUk0TDQ7BJsh5
         XR13/n2m/s6768Df98cOSFbllCiKwwcqfIW8yXAjhyT9sZITWaqA9sxyiNd3G7ctI82k
         VXhtF0B/YWwsUPgS1HUNQS2NNBocCWa47KqDdhDi928N2+QIIcTw+F/H74zGNTkGnvL1
         wveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661744; x=1715266544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrEUOvK097HKAstA2TkGDsib8opUQaNCIsTRyOHR3Ys=;
        b=aEJ5P6MGOY3SbMp+NvsAfHKa7RrkUWCzTS7QiKG9w9UkuJVhS2+c/zPTZm8EGAq8QP
         NJ/4ZFqhYy+8zI2HRBmmp+0UkmsDlS55PfifGymBTrkWczWYpDTjc9vMeG+2GF+qXb2L
         t774Hdh3C7VFmLjkRP8m19JDjnn1b8nKmBv8ZRv6kY1xEZtpiWlCpvBgUXGqBqgD2BPc
         awE+BA35QHOz75dNPQfPAWFS7cuOvvsX7FfC2h/jcNoVHj3/S5rxIWXxzngLYzO3gjyQ
         EGvEnhuK0OQyTBW/r71a13eJUzW0cyfxeQ6CGnjY4UzZ1HDfz8I0aAksiFaVKaRHnD60
         UVCA==
X-Forwarded-Encrypted: i=1; AJvYcCWbIsbEB3UgIx0FvdcCWg7BOzxEDzrw9kdjocJ+ttx5IlzdaRBi0JAS8VQoD5wPsFctuKcJyI7C25X34ghHhWSl8Oj/5VZ/uri35jBX
X-Gm-Message-State: AOJu0YwXSKwIfEqbc/HOFUstRvc8Aerd7eaxAGmYW7HFY2dhqi03XUqU
	xNibNlBAIwmBFrtYaE7hJv0y9SeC1SXRGOWmsW5VHSbu7Dm9egEXpfDazA==
X-Google-Smtp-Source: AGHT+IHJiMTG1/v2Ym7omIqHikfZEf0vky5SlX0yGu5KvWKwp3TvGpuDazS+Z//8LqEf+/4/AqRMew==
X-Received: by 2002:a05:6a20:2587:b0:1a7:919f:2b60 with SMTP id k7-20020a056a20258700b001a7919f2b60mr6786417pzd.37.1714661741570;
        Thu, 02 May 2024 07:55:41 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id y29-20020aa79e1d000000b006ed59172d2fsm1311658pfq.87.2024.05.02.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:55:39 -0700 (PDT)
Date: Thu, 2 May 2024 07:55:36 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] bitops: Optimize fns() for improved performance
Message-ID: <ZjOpaFfwuBLqMYz/@yury-ThinkPad>
References: <20240502092443.6845-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502092443.6845-1-visitorckw@gmail.com>

On Thu, May 02, 2024 at 05:24:41PM +0800, Kuan-Wei Chiu wrote:
> Hello,
> 
> This patch series optimizes the fns() function by avoiding repeated
> calls to __ffs(). Additionally, tests for fns() have been added in
> lib/test_bitops.c.

OK, now looks good. Thanks for the work, Kuan-Wei.

I'll take it in bitmap-for-next. Andrew, can you drop the previous
version from -mm?

Thanks,
Yury

> 
> Changes in v5:
> - Reduce testing iterations from 1000000 to 10000 to decrease testing
>   time.
> - Move 'buf' inside the function.
> - Mark 'buf' as __initdata.
> - Assign the results of fns() to a volatile variable to prevent
>   compiler optimization.
> - Remove the iteration count from the benchmark result.
> - Update benchmark results in the commit message.
> 
> Changes in v4:
> - Correct get_random_long() -> get_random_bytes() in the commit
>   message.
> 
> Changes in v3:
> - Move the benchmark test for fns() to lib/test_bitops.c.
> - Exclude the overhead of random number generation from the benchmark
>   result.
> - Change the output to print only a total gross instead of each n in
>   the benchmark result.
> - Update the commit message in the second patch.
> 
> Changes in v2:
> - Add benchmark test for fns() in lib/find_bit_benchmark.c.
> - Change the loop in fns() by counting down from n to 0.
> - Add find_bit benchmark result for find_nth_bit in commit message.
> 
> Link to v4: https://lkml.kernel.org/20240501132047.14536-1-visitorckw@gmail.com
> Link to v3: https://lkml.kernel.org/20240501071647.10228-1-visitorckw@gmail.com
> Link to v2: https://lkml.kernel.org/20240430054912.124237-1-visitorckw@gmail.com
> Link to v1: https://lkml.kernel.org/20240426035152.956702-1-visitorckw@gmail.com
> 
> Kuan-Wei Chiu (2):
>   lib/test_bitops: Add benchmark test for fns()
>   bitops: Optimize fns() for improved performance
> 
>  include/linux/bitops.h | 12 +++---------
>  lib/test_bitops.c      | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1

