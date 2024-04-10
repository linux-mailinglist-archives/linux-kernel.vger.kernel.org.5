Return-Path: <linux-kernel+bounces-139356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165C8A01CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B11F24419
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450F181D12;
	Wed, 10 Apr 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R92RmeCb"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE71836C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783590; cv=none; b=Kc7Ip0k4iBE8ClwOfsKBGFfd2iVlgxEaB/j8/qF+XBGKEVk8n44f6G2v8Q1PlaeW+wCF8TiYWyugzHFoVdwoFxCr/kZeAuVyYq3tYCsHuS8YXLuBCHmffiss1I2GuBd5EY3l+Jhgouz5LMLgmAy9PW6njgP6ofAnhbsRa13DJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783590; c=relaxed/simple;
	bh=5ydEIu4NwxWWsRaT80Gi5impoOhDMVhIgWRTaHPvrF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVk7EamabXdcU6yvBWtEqgss3Pj3RaTHJEFz+shkbD2eFM08af2L8KXQGhTK89xLLINU6M/EN6oL2rxdhi0+Rie9asSwgMb8KxloVVlnwoB7gYvCkAbGarD8uwPB+voRvdb9ewT5DpaIZg0HBFowFaciApPvO5ZeneifH5wR4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R92RmeCb; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36a2ab5a05dso12848635ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783588; x=1713388388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/mcIJWzR1Sz/R2oHW9ifvaeJ91v7JM0iP/2A/JiCg=;
        b=R92RmeCb5yhxFGYN312O93Wo/4zEIe8uEBtC4ciwNzxVyAr/G3JoKr9/Biaja+4HXT
         u5f5D2WIVSWD26WmHHZzeNYORd3V6QQPvH9NE66SlEGaXCO7zGAxowZSzudmEmAvGKqr
         +MA0E4paqzINR38VwPQhPlB5696MaqNm8zMmXGxGXLPoeU7nwZBKWTPilVAFIQB+PLuU
         1o+/BFREv0VkiRjUPJj4IV05dvNqCJL8bc3x4nFeDfFUEpFu5A5n0RH1pyEGs6xSRKTO
         /gQqs9AaXX4nY+E6fejGWJJpHQwdaTnGoW3JpZMN/WZ2nscwB/6f1Yx7d4ws/UJEsoCJ
         VFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783588; x=1713388388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/mcIJWzR1Sz/R2oHW9ifvaeJ91v7JM0iP/2A/JiCg=;
        b=wpntKvoN/CQ+wtvlvtBlY0nJ2KyHzJpNwrT/0xor7e+4or92Dfzynhfx/sGCVTUg79
         O8dKDBZyvXxI1il+QgTuIBDaoNh52KSEiQvvGeZGX3gb0QOlfnNJ2VM7HqDmDHUPaOf4
         BOq2AhJ4e6Cuxfvf6OEh86G/SR7sqpxOURTeiciirhzhRxGmUmNPREiKJQT/BgPx5Efa
         +hpzf6wh448K4wFa7VsTPivT+ejKxjeBSbnF0+l1CWLD4tZ+2sjMCFMHxdweKBt6Npfs
         KC0dmli/DvbCdVb08Rx0XUMyHiDzPv3Kp+QBvFWKc5WrrcZTbktaZgqe6Raopj1N/+4G
         yF4w==
X-Forwarded-Encrypted: i=1; AJvYcCX60Dos1r4nrGxQEshioGIbIU2K2AdGVXyc0MY0u8cA8aSNwFMuWggBbRnJIR0XU+wRysuy1yfq0M1qYuS3NvZO2sTSF5EAGx6vXKT1
X-Gm-Message-State: AOJu0Yx0RZlmBAXFEasnX4wXUZtBUTwoKLv7JD57f5PG208fDd/zpwMN
	ml+0W8mAbKRSzL0xmNBSCEXSsk33QABbd4Ehmm4/o0zdvFXvs3OWtyG5rWp2WQ==
X-Google-Smtp-Source: AGHT+IGpHuPTnJ+wxQMsV1XcgPUkjimJl+2RrlfGnCAGUQlqpTB1RQcYuHk2y6FkjRIkT4ntypW3jg==
X-Received: by 2002:a05:6e02:1d88:b0:36a:1eed:f105 with SMTP id h8-20020a056e021d8800b0036a1eedf105mr4448912ila.1.1712783588250;
        Wed, 10 Apr 2024 14:13:08 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id fg1-20020a056638620100b00482a9f7066csm1313094jab.151.2024.04.10.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:13:07 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:13:05 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] [v2] blktrace: convert strncpy() to strscpy_pad()
Message-ID: <ghua3jruo4xm3tj55wafwok4aveter2ychgu4lmw3k5rzkg656@np4aozq7mhbl>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-5-arnd@kernel.org>

Hi,

On Tue, Apr 09, 2024 at 04:00:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 warns about a possibly non-terminated string copy:
> 
> kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
> kernel/trace/blktrace.c:527:2: error: 'strncpy' specified bound 32 equals destination size [-Werror=stringop-truncation]
> 
> Newer versions are fine here because they see the following explicit
> nul-termination. Using strscpy_pad() avoids the warning and
> simplifies the code a little. The padding helps  give a clean
> buffer to userspace.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
> v2: actually use padding version of strscpy.
> ---
>  kernel/trace/blktrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d5d94510afd3..8fd292d34d89 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  
> -	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
> -	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
> +	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
>  
>  	/*
>  	 * some device names have larger paths - convert the slashes
> -- 
> 2.39.2
> 

Thanks
Justin

