Return-Path: <linux-kernel+bounces-7402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939AA81A76B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE802865B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527148CEA;
	Wed, 20 Dec 2023 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmFECnI7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0D48CCF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so699935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703102030; x=1703706830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMz6PPwV6TloA5GiUZslivU4Omqyb/lnTc7vendM9V8=;
        b=jmFECnI7xj3TgBDsOIlLSQCyVujdVlO61hT34QLbvFSvqgkxVAhOzjRVZo8hn2yxle
         020579WvRns6/IYSug8FqXpf7o1kolOe4poyxFrrbF/LS6qjP0PvXPdw8BrzZS4iZh5Y
         zV/R7yOohgc7+9LsikdPGnrI+PnAiVE+zq7ifLV13HxIN3A7K4hlcOK8ei4op10p5nyA
         jaYF5ljN0Yf8WOGzwQryyLtUa61mn/oDtUNrxLSMlRpBX/n/MEDWiQ+OL5y0fyokPQCz
         rDe/oJJs+IibwqP4CBn65PIxwOgaHJ6NhjXkStocLRsk4rlQcTl2BTS327fpyX/YZXGy
         02FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703102030; x=1703706830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMz6PPwV6TloA5GiUZslivU4Omqyb/lnTc7vendM9V8=;
        b=dIND2xwMLH3/2d0CYcnUYr1DLBeB6iNaG2UNXlD/QqSKhxzn+HC/3iNTy6oZbfJH7z
         L8lAedC4V1+a6iraDylSYVf1f40rVrhgwoItTdMlpXeR5zDTYNg+mHaAoll+RZJcoSe2
         jqlPvv3y60pNQUx8mzjByCob8PKll4fBPeD4JzS1adZt5rPkU26f65mLNkpPUUZ58Be5
         IFNJCGGfsl4LDAos3I7T6EJeeSZNx68NH+MGPG7/p796Vh195exwtGS0UmnsMX6D2QFG
         NJKwaVCP/UQDCwMfnL903dWadqkQHyPoFLJC1hq5SM4f7xfcHwtxh0aQSQffhHe37XOf
         /nBQ==
X-Gm-Message-State: AOJu0YyVc33tFuo9ILpe6A97Ghd80TGRjNz39L+LIZMWRU5J9++qsG8i
	+nEzhzfBJf03FoUrlSQSctA=
X-Google-Smtp-Source: AGHT+IGmUs4z77bmagm3wdecGrGb9n/BkqVGy9WlHPEZrpmtAo2RptW61NKujGv5qZUVm1is2q+C1A==
X-Received: by 2002:a05:600c:1e0a:b0:40c:3891:b0a3 with SMTP id ay10-20020a05600c1e0a00b0040c3891b0a3mr108012wmb.160.1703102029709;
        Wed, 20 Dec 2023 11:53:49 -0800 (PST)
Received: from gmail.com (84-236-112-204.pool.digikabel.hu. [84.236.112.204])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe84d000000b003366d79edbfsm317264wrn.67.2023.12.20.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 11:53:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 20 Dec 2023 20:53:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, peterz@infradead.org,
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
	srikar@linux.vnet.ibm.com, yu.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH] sched: move access of avg_rt and avg_dl into existing
 helper functions
Message-ID: <ZYNGShf8SYMkhRic@gmail.com>
References: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
 <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Wed, 20 Dec 2023 at 07:55, Shrikanth Hegde
> <sshegde@linux.vnet.ibm.com> wrote:
> >
> > This is a minor code simplification. There are helper functions called
> > cpu_util_dl and cpu_util_rt which gives the average utilization of DL
> > and RT respectively. But there are few places in code where these
> > variables are used directly.
> >
> > Instead use the helper function so that code becomes simpler and easy to
> > maintain later on.
> >
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bcea3d55d95d..02631060ca7e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9212,19 +9212,17 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
> >
> >  static inline bool others_have_blocked(struct rq *rq)
> >  {
> > -       if (READ_ONCE(rq->avg_rt.util_avg))
> > +       if (cpu_util_rt(rq))
> >                 return true;
> >
> > -       if (READ_ONCE(rq->avg_dl.util_avg))
> > +       if (cpu_util_dl(rq))
> >                 return true;
> >
> >         if (thermal_load_avg(rq))
> >                 return true;
> >
> > -#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> > -       if (READ_ONCE(rq->avg_irq.util_avg))
> > +       if (cpu_util_irq(rq))
> 
> cpu_util_irq doesn't call READ_ONCE()

Oh, that's nasty - according to the title only avg_rt and avg_dl were 
changed, which I double checked, but the patch indeed does more ...

I've removed this patch from tip:sched/core.

Thanks,

	Ingo

