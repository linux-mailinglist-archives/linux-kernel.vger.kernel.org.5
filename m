Return-Path: <linux-kernel+bounces-138600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE289F43A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BAB28BB23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E715F3F1;
	Wed, 10 Apr 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB/QEnJ3"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B4158D76
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755629; cv=none; b=mpykKPF6TMLXXkwirvIHrzx59qbXkQ+n6uXsRf6z8Ap98Sb8ZuhU2L0S4SfWNyVZJJHBwSu05o94YvwOtJldB9cprtuon5ztAb5V22FawUEV+jeVgocoJmc6CaybDIonve6UVOSl4QX7Hj/l4uBQR3NLX315oO4OSgTSBoH82Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755629; c=relaxed/simple;
	bh=xMIrTLGjJqr6DWw79isjfTXMWURAOcD1QXwXUnanW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeXpItQYJwNca3Zpq/2X96lwuYSJCYWkoAe28N4x6VQgSuLUft1yvKClCfS8YtspY1DI7SZqIMgFuM0Wm9KD2+OI+ybTPqvRRyS6zB5lQhTfUf4UYlW7oxkS9mtvhWmBFp7qB51dwm2QRAm2ouw7brurvvrpkPfDBKaNUqENlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB/QEnJ3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617f8a59a24so34659037b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755626; x=1713360426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi+4DCwnHTAmfAqEJzjHXORo4khqCoQQ4VwVv0Dtzlc=;
        b=hB/QEnJ3K6PiqkkBJ4FNU5A3NLMvjIRsqjfnDDlQxjDDvza7CzQ93W2qg45pGCgtFe
         2ITi7pxDHMqg5ar6EAm98SvBT6T5MY9GJ2a6Un4AZyoavRw2WgrKZM5jQo92Imnaur9E
         W6SCdx8GxgzIjkSyaDz7rrsHxqaPKktrtfLKJIExiRrRNmrgOxo2pyOaPNDD5HUAq4Ta
         JyJOGA+Wd+XlupPl3v3jgwxeiV3PsQK1UNuRJS17ZTwk/D4zFSTiKoez0FBYZxDSlhus
         4CNzcG0hbqQmsxV4NTPmBvErnXA+zOYj9PH5anHQ1mffIRasiYXoXxu2ZnGpaXZDvMRI
         g2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755626; x=1713360426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi+4DCwnHTAmfAqEJzjHXORo4khqCoQQ4VwVv0Dtzlc=;
        b=OWkLjBb2RefptOR1vTeU0wK0sBzNW3Pg7PjRAJqpb8EU16Y+L2n0FEvJCJkiHS4Ipr
         15fK2JOpf3AZE1GVfXSCrNQERMWnYMy0oJImtWdIJIF7AbxYER5/wDZVpuKE0M/UREBs
         nlSPvfqbvh4QLw8oUgG6j1koUkoy4xCWp0YuL3O+PTXQRiNE1pBINUtVvrE33sEwvRTG
         TvDfrXKQIchfcM/oiZI9WnFsWxaY60iE0RBTOEQ5LFDERHrMoiTrrz50I1poWJ7JCdfW
         W/Fmp54OS+A2gRB+3O23EGy2jx5xCmayz8QhJERAiu9HZCRaiPwqH3quq7pjifrMDO+a
         miuQ==
X-Gm-Message-State: AOJu0YypQSGmgch3+xwY1NhTRrAZe0ORZCk8mVA1BEISsQvq+SbxaQ6o
	5YihLwxvtp38DOcmCGYwo+x71lB8fSmswzkQGpGFRBxNpXnztlpW
X-Google-Smtp-Source: AGHT+IHPf1bO1Hpk1rj0MLDjs0wxJ7zC/0kveJaMg/4qdZZbrJpDeDQkt01UJZa3yl+WPBy3GofYqw==
X-Received: by 2002:a81:6c11:0:b0:614:281d:acdf with SMTP id h17-20020a816c11000000b00614281dacdfmr2690103ywc.31.1712755626484;
        Wed, 10 Apr 2024 06:27:06 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id l64-20020a0de243000000b006145f80d24dsm2684124ywe.29.2024.04.10.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:27:05 -0700 (PDT)
Date: Wed, 10 Apr 2024 06:27:04 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 0/2 RESEND] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhaTqNP3mIq62M96@yury-ThinkPad>
References: <20240409155250.3660517-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409155250.3660517-1-kyle.meyer@hpe.com>

On Tue, Apr 09, 2024 at 10:52:48AM -0500, Kyle Meyer wrote:
> A soft lockup is being detected in build_sched_domains() on 32 socket
> Sapphire Rapids systems with 3840 processors.
> 
> topology_span_sane(), called by build_sched_domains(), checks that each
> processor's non-NUMA scheduling domains are completely equal or
> completely disjoint. If a non-NUMA scheduling domain partially overlaps
> another, scheduling groups can break.
> 
> This series adds for_each_cpu_from() as a generic cpumask macro to
> optimize topology_span_sane() by removing duplicate comparisons. The
> total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 (per non-NUMA scheduling domain level), decreasing the
> boot time by approximately 20 seconds and preventing the soft lockup on
> the mentioned systems.
> 
> RESEND because Valentin Schneider reported that PATCH 2/2 wasn't
> delivered to all recipients.

Hmm... And this one doesn't have #1, at least for me. Can you please
resend again, so we all will have the series as a whole?

Also, can you rephrase this from patch #1 because it confuses people:

> + * for_each_cpu_from - iterate over every cpu present in @mask, starting at @cpu

Maybe: iterate over CPUs present in a @mask greater than a @cpu?
Or similar.

Thanks,
Yury

> Kyle Meyer (2):
>   cpumask: Add for_each_cpu_from()
>   sched/topology: Optimize topology_span_sane()
> 
>  include/linux/cpumask.h | 10 ++++++++++
>  kernel/sched/topology.c |  6 ++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> -- 
> 2.44.0

