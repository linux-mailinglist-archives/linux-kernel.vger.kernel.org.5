Return-Path: <linux-kernel+bounces-100085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D387919A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7DC1F22FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172D78693;
	Tue, 12 Mar 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNElnSw0"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B278685
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237720; cv=none; b=nYmtZJfXALgKjBnJEH75iUepvxQ5Ocvi6LLVv5+BgzMqj1Y592AQEC4ajnQ9x5uHiyI3VpE4bQfay4qMsLogI5s2ICa253RdONJo3d2e5IoMtIaU7hKzqH3WG+SNj170XH3A1stgXQq005jJyo/0cMv+LjJBcDnC3ELySu5zzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237720; c=relaxed/simple;
	bh=tp5xX9Tm9xpf7J2Fvq+qiNhQ7Uk9Xc14J8HhcqOI2m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeQh9IBSBCXzuksIAyzkR7DFSbCQQx+7Fn0WipS2nPysQn2+jugKlCi+r6oI5RRaPBqJM67otrBh4ffDGnncmsSwQ0vT7NJ4RclrxG5N6GwBhHjqIcyHuZnEDqYsPuPn1X5V8qoLravky5TIGIIMRE5NKs+58UuHV4reJ1h6JrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNElnSw0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5135486cfccso5017302e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710237717; x=1710842517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0swIGGPrFyv2J0CGwXxVTIM3XPOwdeAHETEHM3daH4=;
        b=gNElnSw0fk1c/RBO1NkmPRlM0j/yzApmb6Bq4C4tz7ZHFwcbyNNMRXx5rpyNX4Y6/4
         DjZsBXX3U0qOf6pM44GWrl4Q2kots7A4WBxzDdR10+nbBWFOg9SKVGjJBGrQbQoMgzic
         O3sIbksu1fbbIzaJs6ZxrCM0/1+98lHyOgIeWaLE8bW55bE+YidxBtNtoUHYAk05zRZf
         AAFNLe/JtjIadHXrAux/m3XGHdbjwiTK7oHWpAiRQlGasGxqXv7VTgPjnPp4RJNUTSEv
         uFa5DBM7wyv4Fir9V4Oc84eihPQr4q/avgXGpWl9tJzuDHZzv+9Wv/jhPGIdrF2FOZk0
         tpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710237717; x=1710842517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0swIGGPrFyv2J0CGwXxVTIM3XPOwdeAHETEHM3daH4=;
        b=dI4ujw/vUbbtZtV2eyslZ7HiL9j0jW2xWP/9C+Ep4mav4SVJoZjaiuR9eOKCDDk9BV
         NOMrv2Uvo7QRJeVuIaOUUppW0+qBtfkq+sKm4dyZZtvfGg+0q1wk1/Z99aaQvy8hx2Rr
         1/kvK6/gtPy8oKBTXFxetGrexYPrSqT1Hk1m0uDIIJgwtrC/25EmExO69b+Fq8vz/s3R
         DkffaMe4CEP57oJ9l/BfI5am+LDCkDY/9W5ahZI8FPmi0XyjH4A+LQJRYfQp/9OdMy7b
         uNgNHFHkaZVaupnwIc5g9+XNc53ODfnwNOYFmFz1yLfy3zC1HQsxmJclap1kytC4Ziro
         HR7g==
X-Gm-Message-State: AOJu0Yw/MnvKhhEMIwWhWIrSVyW2U4TPVCSiYRlMlc5OMbWiReysoVKp
	ZOVgunG90SWdSwE/h5g9jckrmZWGqejdKBTYA7ik89+COyMOU3oV
X-Google-Smtp-Source: AGHT+IExGLPT9xM67wwCMqef8h2IEYToWfL9bmbFh1oCWZkj0O11jKHvmG37arFK5ffcVFYkx11LQA==
X-Received: by 2002:a19:e010:0:b0:512:fc30:51e7 with SMTP id x16-20020a19e010000000b00512fc3051e7mr5936669lfg.16.1710237716839;
        Tue, 12 Mar 2024 03:01:56 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id iv17-20020a05600c549100b00413160baa9bsm15671103wmb.10.2024.03.12.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:01:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 11:01:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
Message-ID: <ZfAoEmH6KRhjyUor@gmail.com>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/8/24 4:28 PM, Ingo Molnar wrote:
> > We changed the order of definitions within 'enum cpu_idle_type',
> > which changed the order of [CPU_MAX_IDLE_TYPES] columns in
> > show_schedstat().
> > 
> 
> > +++ b/kernel/sched/stats.c
> > @@ -113,7 +113,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
> >   * Bump this up when changing the output format or the meaning of an existing
> >   * format, so that tools can adapt (or abort)
> >   */
> > -#define SCHEDSTAT_VERSION 15
> > +#define SCHEDSTAT_VERSION 16
> 
> Please add the info about version, and change of the order 
> briefly in Documentation/scheduler/sched-stats.rst as well.

Good point, I've added this paragraph to sched-stats.rst:

 +Version 16 of schedstats changed the order of definitions within
 +'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
 +columns in show_schedstat(). In particular the position of CPU_IDLE
 +and __CPU_NOT_IDLE changed places. The size of the array is unchanged.

> One recent user that I recollect is sched scoreboard. Version number should 
> be able to help the users when they it is breaking their scripts. 
> 
> +Gautham, Any thoughts?

If it's really a problem, I suspect we could maintain the v15 order of 
output.

Thanks,

	Ingo

