Return-Path: <linux-kernel+bounces-96787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241087616D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625BF1C224D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B0537FE;
	Fri,  8 Mar 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU0CIt7m"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00168535C8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892003; cv=none; b=BAIt+VRNJ0FnMarelhJj3QDGEY9rzjtxpC+VC8JHmh84HNJJna70UA6ew+G+Eovqeu9jA+a7OY/WHyimFitOPk2lEbKex5S0UQbZZUyov+DV4lD5NTtNTnLL+GQ9JBYCjQzbT2o3oeEjWWTz+fP7UbA1yDrhARO6Gbt66FQoUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892003; c=relaxed/simple;
	bh=ZK6noPrmKxUC4atN9oG0vDIpDb5ltfo6u3smF80Dmpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/hJ3sTDhMWJ7llOwPGlaeKbVQ3rayxNNcmk7X5jwEWLrIsJ1G3VLAi/Awx/zkbmPN1GAo2crDe3PTMDGlCOqtI1uNPDr1X8SFjkvx/QgoLs2jg3TtAGRTR5McAeKuLuf9FgGO3x3ScjibbjYCdt+lmjVqgs/NGhvHxGRCNryw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU0CIt7m; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so2148464e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709892000; x=1710496800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SeR5og9yTjPR65icnbxspPrnmiFvWNAcIfMp3pXu5k=;
        b=GU0CIt7mvfGwzs81Fm2zPETAFDZa7JgqYnXJQtpIozIvicNdyMX4knyCkw7NrOwNi7
         nkvKM02odvocsUdnd7iS38zNto4lY/Z06eZxmAx9ERy3bFmBAbJySpDnOi6LgIWw0Znz
         G8/mwTmI+tUb095LXQ7nSdair30xnAN6Kr2cgv5mDJq0j04g0b6kqJvKKizNQpCwLq+F
         1EMVQzhmYCaSO3j5x8ssU1mMgjhvtfeYOlqT2+x0kbqsz6xuEqe4I8RMbkIdUFjrsWL0
         Hyc4OpfCiEhkRCA9WtIziQGGqln+2z5FZeGNzVjNxDkeFVvBhLnmhiJdJvJT0S2Kanzr
         HfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892000; x=1710496800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SeR5og9yTjPR65icnbxspPrnmiFvWNAcIfMp3pXu5k=;
        b=ZNYeB2k41CfSJZ67zHA+1uNyK7ExD6xKQwJRDJhe1aPxmRNXXJxFC0LTJJ8bjLQwJq
         1RXUE51ejylBeKhnvmLj+HvX5ye1HBIJtSHPuI8dTpGlCO2CFrUhywztPZ4mf1n8zB7Q
         zQh9GefdB0XltQElfnELG9VKmchs78Db2s6Xj1rw7/i+gtgvlYcYAOSjw0PJ/goMT74R
         Ohu7Tazzves235GRmkbN6ek2KEdAcHI0r2U4upA05uu9s/BX9BlHJ2he0D0NhOtdRd2B
         PYvBmJfAHUL3IYFfqblKJTL+F2i2XpYQ4m/PiBjHw+7O5MdgpLaLCc7usMQauGsSdtjk
         14LA==
X-Gm-Message-State: AOJu0YyabKj+xy5fk/GZSaMoUJbFr4IE4OQvVlAfF/GnJuYWa+zXYlbj
	ZQ/5zbn02IFZmdOlZXzuVntlb3zbHxUojyrBab0D3Um8KF+bYkO1
X-Google-Smtp-Source: AGHT+IF6WzuJBXJGEEByWuV4w8sKLF4OySTUavqcSAVnTKzbves9pk2luDcEf69Df/mhpfZTOVx6tg==
X-Received: by 2002:a05:6512:2152:b0:512:ed82:fd6f with SMTP id s18-20020a056512215200b00512ed82fd6fmr3038693lfr.60.1709891999388;
        Fri, 08 Mar 2024 01:59:59 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b00412f2136793sm5585678wmq.44.2024.03.08.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:59:58 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 10:59:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 3/9] sched/balancing: Change 'enum cpu_idle_type' to have
 more natural definitions
Message-ID: <ZerhnPHeBSgd+XOk@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-4-mingo@kernel.org>
 <CAKfTPtCu=_ys+FFTqKfZbu9f_yD69fN7L3nETykEK3y9TW3BmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCu=_ys+FFTqKfZbu9f_yD69fN7L3nETykEK3y9TW3BmQ@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Mon, 4 Mar 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > The cpu_idle_type enum has the confusingly inverted property
> > that 'not idle' is 1, and 'idle' is '0'.
> >
> > This resulted in a number of unnecessary complications in the code.
> >
> > Reverse the order, remove the CPU_NOT_IDLE type, and convert
> > all code to a natural boolean form.
> >
> > It's much more readable:
> >
> >   -       enum cpu_idle_type idle = this_rq->idle_balance ?
> >   -                                               CPU_IDLE : CPU_NOT_IDLE;
> >   -
> >   +       enum cpu_idle_type idle = this_rq->idle_balance;
> >
> >   --------------------------------
> >
> >   -       if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
> >   +       if (!env->idle || !busiest->sum_nr_running)
> >
> >   --------------------------------
> >
> > And gets rid of the double negation in these usages:
> >
> >   -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
> >   +               if (env->idle && env->src_rq->nr_running <= 1)
> >
> > Furthermore, this makes code much more obvious where there's
> > differentiation between CPU_IDLE and CPU_NEWLY_IDLE.
> >
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  include/linux/sched/idle.h |  3 +--
> >  kernel/sched/fair.c        | 27 ++++++++++++---------------
> >  2 files changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> > index 478084f9105e..4a6423700ffc 100644
> > --- a/include/linux/sched/idle.h
> > +++ b/include/linux/sched/idle.h
> > @@ -5,8 +5,7 @@
> >  #include <linux/sched.h>
> >
> >  enum cpu_idle_type {
> > -       CPU_IDLE,
> > -       CPU_NOT_IDLE,
> 
> Could be set CPU_NOT_IDLE = 0  to help keeping in mind that 0 means
> cpu is not idle even if we don't use it ?

Yeah, makes sense. I've added back __CPU_NOT_IDLE = 0 (with the underscore 
to make sure some pending patch isn't accidentally relying on something it 
shouldn't), and added your Reviewed-by.

Thanks,

	Ingo

