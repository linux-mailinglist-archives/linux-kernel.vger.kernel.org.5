Return-Path: <linux-kernel+bounces-90482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86E86FFD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1891F26C41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B839AD8;
	Mon,  4 Mar 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc/tDBUn"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD25383B4;
	Mon,  4 Mar 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550525; cv=none; b=Ni1IyuygIYLyCpRKKMtOJv7HYo4u9aES8oBUhu3LNvIxE/NqgCYw2sNKKNNqOGusWZE6UCWu7oZXn+S1bv2o7venJX4SO2Wl0IbI9qyOaE9oD5al9IT+9g/eOhOU+DA7WBDWQcn84lf9wswnEkpuYOSrBpK/bs9sZIadvZLvrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550525; c=relaxed/simple;
	bh=5Ni75zB70Cek0dgrqjXliuHLqs7oGNsHeKAy6oeSjnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3YbRjy+l4Pj98hcuOOuXRuiHtLVELW2nbyXQd9W6bRdh0XznGpXqC1HxML6todOUaKIu86E4m8VbP6RDIPBYT4s6YveoeOvV2+yFPEaAE14TgAnZga9Vmfmh+MSJlLabM2x4ZVIUa84bOB9ZWjtPo4Y3/lS8zNZHbhVt7XIMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc/tDBUn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso4993318a12.2;
        Mon, 04 Mar 2024 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709550522; x=1710155322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4XakkF38dSoSGWZfunmCZBJpqQT1gByMvmkek2DU0s=;
        b=bc/tDBUnMlZeEBJJjhhRKEXk5eLAkPtvI8WnSYLDsod5FdOo6065T9LEG4IrWbAtVy
         1HORlzkQDWWcu76V/iPS0/JL87uKeuev5i6uUCFcMMOklAKhYPFptx/QR0K4fhxWq1js
         7apZkJcsdMBDTmCn7dGpa/ORIIFIZ6664L1osBmGjpG+a2EEgDGK9DXCGpf8728NQSGl
         UgWzbFcBOJ07QKb+invaN3kjanhqbEr6BwGyrcFxP936UdsoWEzf1r6ncLSGtUzbFNq9
         6E3YoPIkZvAH44Tq96+yRrs/ekhix6YHVhCUKgZkvdM4wCDEZXEiElqDMLB6hYQVAWgA
         anbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550522; x=1710155322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4XakkF38dSoSGWZfunmCZBJpqQT1gByMvmkek2DU0s=;
        b=Ezryi0acz2HY2q4DDY8EIYRAOOYCaONoZq15KLd81eoKDxwbmlMTJ05YRvN5y7t55P
         Zfe2ZCM1p2a/lG95vpT9aBaZjEe0vrrHviZvDrXLKmMCSEzxS986jBFv7tnWZE13Gm/i
         uDAlK2k3WHX4lEXy8BIG05XEKrEuCQmTpUbbnlFj6z20e32FU+rF32G0ERfRGPD9GKCX
         EELND2QpCBwiOGQwyMyqGLdhj2CxDcNI6ZvLhWOvOgiywqQy6mJHi7YTnEsfWPBBxJBH
         0sThaDCX4kxeUgEnFnZ2c54y1QfgJAH85JGoZRgjHiQWqNohMl6Bk5lWZOXVSGpcfbJJ
         c0tg==
X-Forwarded-Encrypted: i=1; AJvYcCVQrh7v6YUC3HtOBJ2rqsAkkUr4kMSyNj8eA5VJNRFxFPcgI4DfVRq5IAXm0jctsuZh9JQT62lB20rCzPAJzKUO1OVMT6zCzyLCH27t
X-Gm-Message-State: AOJu0YzSThy8hbfCwDU801PT0uukKHq08ue9k6HbZSYj1VESCjUWHGx3
	NRBkY/XUHmub9GQ4jAafFc3EUK8cG4xKor8IPGUGpl9CCwmP5acoWa5zJVg0ZcY=
X-Google-Smtp-Source: AGHT+IH/7THfo50sl3BYdWjiPzvNk/Rwlr18dSqq65BxX0RwEFp45p1+R7aS6+NKhxNxe0Bvf/OM4A==
X-Received: by 2002:a17:906:1385:b0:a44:f9a9:a016 with SMTP id f5-20020a170906138500b00a44f9a9a016mr3106691ejc.45.1709550522099;
        Mon, 04 Mar 2024 03:08:42 -0800 (PST)
Received: from gmail.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906265700b00a44dca5f9c1sm2513288ejc.100.2024.03.04.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 4 Mar 2024 12:08:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 0/9] x86: Cure tons of sparse warnings (mostly __percpu)
Message-ID: <ZeWrqNcbSFJrQddR@gmail.com>
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303235029.555787150@linutronix.de>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> A recent 0-day report about new __percpu related sparse warnings made me
> look deeper into it after I dismissed the report as bogus initially.
> 
> It turned out that sparse is actually right and all of these warnings (not
> only the most recent ones) are valid and got ignored. Some of them for many
> years.
> 
> The worst offender is an UP build because that maps the per CPU cpu_info to
> boot_cpu_data, which is regular data.
> 
> As a consequence all per CPU accessors which look like legit code and are
> legit code in the SMP build are causing sparse to emit warnings.
> 
> This series addresses this by:
> 
>      - Adding the missing __percpu annotations all over the place
> 
>      - Curing the UP madness by exposing a proper per CPU cpu_info for the
>        price of wasting 320 byte of memory.
> 
>        Even if the size police will hate me for that, this cures most of
>        the madness in one go and avoids to add more hideous macro mess
>        similar to the completely bogus cpu_data() one which should have
>        never been there in the first place.

The market of UP-only systems running an upstream Linux kernel is shrinking 
fast, so I doubt this is a real concern.

>        I know that there are people who think that size matters, but the
>        only things which really matter in software are correctness and
>        maintainability. The latter simply forbids to add more hideous macro
>        mess just to avoid wasting 320 bytes of memory for something which
>        is mostly a reminiscence of the good old days...
>        
>      - Fixing a few obvious non __percpu related warnings which stood out
>        prominently.
> 
> That reduces the sparse warnings in arch/x86 significantly.

Great - there's also the side benefit of reduction in <asm/processor.h> 
complexity via patch #2, which is great for ongoing work to reduce header 
depdency hell ...

I've applied your Sparse fixes to tip:x86/cleanups straight away, so they 
have a chance to make it into v6.9.

Thanks,

	Ingo

