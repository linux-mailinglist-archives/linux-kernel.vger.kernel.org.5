Return-Path: <linux-kernel+bounces-138072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFB889EBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C07A1C2134D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8713CF8F;
	Wed, 10 Apr 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoMORzkv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3A26AC7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733983; cv=none; b=J6nwkTXJOnR87NSe/Sw95T/91Yrku1GHUWi2ky1Doq0DmrxAtQwXvwF0mq53b3ztrJhqA9rrTDbAFiLzrwGGLNM6yd2DqpNbhxEF+qIk2rLrK+4j29EN/I1GQcIhDFrM79uUunjOnyIdniqFdliOKOOJP+ge9glEkfc3E86lW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733983; c=relaxed/simple;
	bh=s2k1ouNV35zF+1dBdzATsz5bImit+heSjpkBXxYGZ8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7V872smM+5TRv/gWPCcLbSVoiX2SMjCw54ADUDgqHmFi6b+/Y4EPIpQoTK6xm+04ivWEXSrzHFReaocepiJqL6B1dVsADVYADzCCogVZVaxLEOEBHyjpapKa1hnxeueYsvChLoxRg3PQtXQ9arVX95yvtN07dyktS3xn64h/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoMORzkv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3c7549078so29426005ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712733981; x=1713338781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+D5Z65HMJHZbVna0dIsXP4PfyW82zjn+oyWq3eUZQQ=;
        b=uoMORzkvUkn5xAYSHRYWX3hNA2EztdH8Eu8hudjuNj6jS5yaAk8T/tTF96zm/FO0EI
         s9PuNWuePUHjIlT7GK/Vy1vbLYVE81DHygrtwVdlKF2fJMVYuoGoWQmv+cSkexllDoN3
         NO/yeaNGfA8+ST3FvlRCqDEzM0z3IVp50AnvzBrDOYuYIm2HM9Lqe6mMSeG8XxoxAB5X
         Fv4iTHpLwOdnzsBaxy7Uun7nbIRXwihUwZ3AjeBjXAc1uVhcTZeq5Q36Gx7qVEE8Wsk4
         2bvltoJRqajWLVAXqr+rpEGnD4zxALwz05wcQcER0Uc6P+eRK+/xgDxWXxc7QgmQEJ1B
         BrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733981; x=1713338781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+D5Z65HMJHZbVna0dIsXP4PfyW82zjn+oyWq3eUZQQ=;
        b=tuZa9IkztavqCDWGeg+c5bI9q5gRe6jiW0QUdnV/lZHv3z1qfIIQyXBWLG/1J+ayOT
         QaUW6/jniGwyXBDprHassDJOqlA7ihgi5y9UfHuMZi7gZHJ939TfxP0iFomL5t5TWY4Z
         Ry2ZsMYZOrIYMzykm6mSUH0xgC2VbPoalvp6Et0Jdnr6yANfsVLAyOkKwxiYTNQdt6eZ
         vDrsMamLBy2trvumEN/eueo/57/mdx+O7K3BUIdr9RhHMNYs2P4YUOIao5mU1MV9x82b
         RXXEqcHkIreMkd8EuRQc5TFTT5dNGP8gVwxyKJ3r5bDrpLHYR8HRWl4d8JXzU19+f/IC
         VCUQ==
X-Gm-Message-State: AOJu0YwnGuW+jdi+TWN0Dj43f3/4NPJpBz2fsL23xKhwQKgsVSBDqCwm
	1K8MEno9vCtLkCISGbC57BmZSg4qh9mWqVSYmhYkuOO6xx9R2Kg+xtAbhARDmJZoGE1rwvuFdUD
	k0HhxnK3fTeesXQUfNG43Fv9yo0ZLFuyy4zPDbA==
X-Google-Smtp-Source: AGHT+IHc8iy5jpANvXJrZBp73iRmK4mDGBZwDIgJAGp7g/7omiXWjTNaaHDhS+jG4SPOe1EjpY7Yefhi09BunmsuBnY=
X-Received: by 2002:a17:902:6546:b0:1e2:aa5b:bcfe with SMTP id
 d6-20020a170902654600b001e2aa5bbcfemr6177722pln.22.1712733980791; Wed, 10 Apr
 2024 00:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409155250.3660517-1-kyle.meyer@hpe.com> <20240409155250.3660517-2-kyle.meyer@hpe.com>
In-Reply-To: <20240409155250.3660517-2-kyle.meyer@hpe.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Apr 2024 09:26:08 +0200
Message-ID: <CAKfTPtC+d++V0T+C-O5fBy=i4BpEzvMib6eQYsPt-trhx2a1Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2 RESEND] cpumask: Add for_each_cpu_from()
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com, 
	andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, russ.anderson@hpe.com, dimitri.sivanich@hpe.com, 
	steve.wahl@hpe.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 17:54, Kyle Meyer <kyle.meyer@hpe.com> wrote:
>
> Add for_each_cpu_from() as a generic cpumask macro.
>
> for_each_cpu_from() is the same as for_each_cpu(), except it starts at
> @cpu instead of zero.
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/cpumask.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 1c29947db848..655211db38ff 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -368,6 +368,16 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>  #define for_each_cpu_or(cpu, mask1, mask2)                             \
>         for_each_or_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
>
> +/**
> + * for_each_cpu_from - iterate over every cpu present in @mask, starting at @cpu

So I was confused why you were not using for_each_cpu_wrap while
reading the description which has the same comment :
"
 * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a
specified location
"
Could you clarify that it's not "every cpu present in @mask" but only
those after @cpu ?

> + * @cpu: the (optionally unsigned) integer iterator
> + * @mask: the cpumask pointer
> + *
> + * After the loop, cpu is >= nr_cpu_ids.
> + */
> +#define for_each_cpu_from(cpu, mask)                           \
> +       for_each_set_bit_from(cpu, cpumask_bits(mask), small_cpumask_bits)
> +
>  /**
>   * cpumask_any_but - return a "random" in a cpumask, but not this one.
>   * @mask: the cpumask to search
> --
> 2.44.0
>

