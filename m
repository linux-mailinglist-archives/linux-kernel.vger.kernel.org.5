Return-Path: <linux-kernel+bounces-122711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C414488FBEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C88DB2797F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079077B3C1;
	Thu, 28 Mar 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoDvqUOk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908A056776
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619041; cv=none; b=rowxsK/x2UXoYwXz6xoXxHQ2DEznw/Kxxbjx27tQ3wgwN1irXJyoFssVW0+xdRwnVtLovUMO4IEafdSy8I/2yvvG1LaNERDVCG+p/VhrOnuULZcWpgUgLBQclpdwajHKpx23oQ3nGg2Uyio+RGltIDD8ifXJXaRz/E2INUQN/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619041; c=relaxed/simple;
	bh=0gtQOfL2IxWKUANFFpJOKFUXgEmm+bNGW/O+OkOV3GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5CeC4UuBLfQQyAjm6BJvhFAa1HDfqVtnJ0O5iLIcrZUS8VuRrcG7Vo517v27MMazvWAg4PyVdmjAPY3DeF5R31wysMPy1u2qzBWgYaVi+c6tUhpvp6XGD6JjhKs9i28GAujKTmEbZVYPfvMHx8iTpp74ua4DVQhMYY6/UszDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoDvqUOk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a45f257b81fso80646866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711619038; x=1712223838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8PQcvYa9QyM4sVMtzETsaa8yVa4q+f5Y6AyTb1Idew=;
        b=IoDvqUOkF4QNxu5tDIxlpyhwF3iMGJdPOGXBeErVMJjIrN8pA5SeCRmeJZvq5xUaYd
         QJOT2J1qMEf20UdNlQT4b823s88GMCsUvYEt1H2ZDLoLV9I7r37ZCDh5JMTVE1rXbvBT
         GlIMaKTZbHnrFGCl71LUAX6G7yU7RAOh3wn4XB9tKxdw2UURFGDzjnKgx3MoqE8qVqKi
         b9eAfvB1G069S3qOeb64cydreP4IX+5WLHdFAulsDB6QSEmHJjSVHK1KVhfzwHo81nZR
         CUkMBT2SenmyWMWebpw3oBtVbZxGgkjK6Td/+lMvTkog2oIe8gKvy9mj/q1/h9H3l4QU
         Q9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619038; x=1712223838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8PQcvYa9QyM4sVMtzETsaa8yVa4q+f5Y6AyTb1Idew=;
        b=kmTpCqB05hWC1B2p4CTV+yFDWQrcE0J/0fF7iiFi21dsbY4jNOV/1AVoEEBZFRCqAd
         /bFbsoaxNIdJ6Or1dkaXfwc1eOOc4sCUP6Fvg0J8xPSHoIPqWkoi8q2y3uEspMe2adgD
         iYB0h24hUg22oerDsBn9aiiVF+OywPusYYtO2K8h6P9Z71dFyTzQ7j5vtXosrv/5Vi0u
         Ypk4ZEGlh9vv4DcmmndZ0A+3tkkSgXKdomtM2N5T2OD/JLBJYTM/9cmFKdqsw2gqS9Kc
         35iHq34Jq+ufj0JFQQ0l6wtYZ5G7E0MGJ/2zH5Z91eyb8EGaP6AWlE4G3doWvrQ2aNxp
         8ItQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdvplGkO5V9En6YSrTfXqh/u7HXhw68RDq7rezTMRDb8Cz4cg5fTzBt3Lr3Id3edZbHlSD12jTu51m538jxZoHqNQtgeoytbG8SprV
X-Gm-Message-State: AOJu0YwbMOJLXsnPchjVLgUwV6qUyraC5BA9pYNdd9DPoPn/6m1xDs7j
	jIyQ0w8QoYNO/NWa5b/I3h5FPay2CWhGQirPH8ISVieBrFX8lrHo
X-Google-Smtp-Source: AGHT+IEEOxZ9abeIcO+/r9yarJ7DL5YOGytUCWVH5Hg9HCVwCdqkk4c2YJ5N287tZNQvA7REEUa+nQ==
X-Received: by 2002:a17:907:7dab:b0:a4e:14e6:2084 with SMTP id oz43-20020a1709077dab00b00a4e14e62084mr1738741ejc.51.1711619037317;
        Thu, 28 Mar 2024 02:43:57 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id kg26-20020a17090776fa00b00a449026672esm545578ejc.81.2024.03.28.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:43:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 28 Mar 2024 10:43:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH] sched/fair: Combine EAS check with overutilized access
Message-ID: <ZgU72pVEQlDOPFbG@gmail.com>
References: <20240326152616.380999-1-sshegde@linux.ibm.com>
 <ZgMiwYxF5rnVTpLf@gmail.com>
 <CAKfTPtCk_aD-g-uADdoiWrGVHBbbVMuBKzWjyrKuA609O8vJzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCk_aD-g-uADdoiWrGVHBbbVMuBKzWjyrKuA609O8vJzA@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Tue, 26 Mar 2024 at 20:32, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> >
> > > Access to overutilized is always used with sched_energy_enabled in
> > > the pattern:
> > >
> > > if (sched_energy_enabled && !overutilized)
> > >        do something
> > >
> > > So modify the helper function to return this pattern. This is more
> > > readable code as it would say, do something when root domain is not
> > > overutilized. This function always return true when EAS is disabled.
> > >
> > > No change in functionality intended.
> > >
> > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > ---
> > >  kernel/sched/fair.c | 20 +++++++-------------
> > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 24a7530a7d3f..e222e3ad4cfe 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
> > >  }
> > >
> > >  /*
> > > - * Ensure that caller can do EAS. overutilized value
> > > - * make sense only if EAS is enabled
> > > + * overutilized value make sense only if EAS is enabled
> > >   */
> > >  static inline int is_rd_overutilized(struct root_domain *rd)
> > >  {
> > > -     return READ_ONCE(rd->overutilized);
> > > +     return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
> > >  }
> > >
> > >  static inline void set_rd_overutilized_status(struct root_domain *rd,
> > > @@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
> > >        * overutilized field is used for load balancing decisions only
> > >        * if energy aware scheduler is being used
> > >        */
> > > -     if (!sched_energy_enabled())
> > > -             return;
> > >
> > >       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> > >               set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
> >
> > On a second thought, I'm not sure removing the open-coded
> > sched_energy_enabled() branches is a good idea: the current code makes it
> > really, really clear when we are within EAS code paths.
> >
> > Hiding it within is_rd_overutilized() makes it a lot less obvious IMO.
> 
> That's probably a matter of pov. I prefer embedding everything to make
> sure to have useless access to rd->overutilized

Ok, fair enough - applied to tip:sched/core, thanks guys!

	Ingo

