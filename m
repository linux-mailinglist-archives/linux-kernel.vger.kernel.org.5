Return-Path: <linux-kernel+bounces-96964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D958763E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793091C20CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AA56742;
	Fri,  8 Mar 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VooACwFN"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5F5645C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899088; cv=none; b=GsKIb4zNZGHNf714PC+v0nf4KbqAM+QTCrcJaldUyLGqc/WDCukdh1zL3mkxtIqyMp6Jf7FJbYRdaYAObSx4a7aKFuKW+PN3j1+NIKPEvrgGhd5fSbl/wCa40YqEdOHMaYLCWjmlFFnlzpesixY/I5UeXEJu22p6DHfeB+9tnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899088; c=relaxed/simple;
	bh=tBAwUGRbXq59I/dWai3Bt85iAagt+HvpW8FxlvtMZps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYEESiEwkL3hcrjzdNSM/DWiI5SVqX30x1viyLG6GQH4Lo5u6plrIF/2GBsBcbVOyA1V2YHCgq09SmBEOup/DS3wlP6h4GdYvsnr1d2W/6+afr3dfM+2NHLv2l2PZasDL3pII4MBgbOpr61pgAgPGtGrDD00hxwgAyAdYDqp/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VooACwFN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso1278056a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709899086; x=1710503886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=toCza1XInuOraHxuy2SmQIYltdK3DEIguvFMU6ymn7Q=;
        b=VooACwFNIqEO6OcFC92hk7o4dXYWHi5KmPbrwQHA/52UfIdCx506gq/5P8j5MNEwvf
         ujScx5ItnvK/tEf2cBefXdm3azqJumqguXPJkbx7GRxAZkiNENRmkUYOG4nypbyu8/Hs
         yNbjMmhrCwfU0FM7u7dKybvC4dRmdQJQMY6MUQGOjgvn901vlZgcwJkanQTt0XQGi3DT
         g6+JTYeVTyj80Vm4+xO7pBVM81E84qqTeVzUJHXsAahnMGiYlPm6qnzlq116lRzLCl4X
         nxN4GrFKtlrej57JbOkztSIR60gx5OqwoKI45KC4QzdZ7YubZwbVeScJuVMuC9+bmm1r
         lcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899086; x=1710503886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toCza1XInuOraHxuy2SmQIYltdK3DEIguvFMU6ymn7Q=;
        b=WM4J8wJlc1gu/knoRVvebEtjHUu4OdQZc6FvdskqTkb1cPkbJFS9mWpp12APCPHIN1
         /BpQS1UeR1zPNFeHHv2No56LBByzvlbQl+GdhBvUxBSY6kYSkHXdXy0C8KwJH68MG8P8
         9XQ2u+YRZix2cWq8sYw8rQz3mouytbedIdWY+PLF/Ph44I79llm/FK4xsr7uh2QFUEDP
         84wbSJaCIQcf9RnbstFEeuCRpb93eePvNDz3M4VF1Q6bZLV1W77zgLa3apQBl6yP379S
         p8Ys/6g/0Jlgv8TYl3rrRZzSXIM0G8JFlroVgM3pTND4dZDj0l8wrD3zV1adHZcikAcY
         EuaA==
X-Forwarded-Encrypted: i=1; AJvYcCV0x0BJ2ecPzrqhhhPdKhYIvM2rpcoMQjUiaqE9alZ+WJAJhNJxh3nxdDZIyIccLAOzNiKGq4MyU3I6RFgy5FTbxcjDDCmddGJ3LRCK
X-Gm-Message-State: AOJu0YwRyApdH4f9q5snv06KEEtaO0ydOQq9cEqo+mI1/IS7YUI4Q33o
	JrR4WMMxWsMdzLyffgMOJ1WK6HX7E87oYp5TSLENJ8WOjpOOPw2WQ2SdUB9H+ugPt9R4uAObeKo
	GMzcql3VmkCTM4EOFvQBkfTgEam/+Ita8MWGQvg==
X-Google-Smtp-Source: AGHT+IFaxX+qgK6PnYUhIWTkawo4oWOqMv+nsZ0Bq6fJaPNdk5lpumWA4F58ozA4HYNfA+YqA596LG8DmZ8P9fOsJPE=
X-Received: by 2002:a17:90b:1bd0:b0:29b:3d08:c644 with SMTP id
 oa16-20020a17090b1bd000b0029b3d08c644mr14900070pjb.9.1709899085761; Fri, 08
 Mar 2024 03:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094831.3639338-1-mingo@kernel.org> <20240304094831.3639338-7-mingo@kernel.org>
 <xhsmhbk7tdkac.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAKfTPtCNnTVFdf85sRdJxPhdNZxc8qKcnHL3sznjg-KBVn8Bew@mail.gmail.com> <ZerlUU4kAv580rLh@gmail.com>
In-Reply-To: <ZerlUU4kAv580rLh@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 12:57:54 +0100
Message-ID: <CAKfTPtAwh-khpNw-=oku3VU8xR6qVpoL2hrzEF6u1AZ7WQ+3Cw@mail.gmail.com>
Subject: Re: [PATCH 6/9] sched/balancing: Update run_rebalance_domains() comments
To: Ingo Molnar <mingo@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:15, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > > """
> > > The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
> > > from two places:
> > >
> > > - directly from trigger_load_balance() in scheduler_tick(), for periodic
> > >   load balance
> > >
> > > - indirectly from kick_ilb() (invoked down the scheduler_tick() too), which
> > >   issues an SMP cross-call to nohz_csd_func() which will itself raise the
> > >   softirq, for NOHZ idle balancing.
> >
> > I'm not sure that we should provide too many details of the path as
> > this might change in the future. What about the below ?
> >
> >  - directly from the local scheduler_tick() for periodic load balance
> >
> > - indirectly from a remote scheduler_tick() for NOHZ idle balancing
> > through the SMP cross-call nohz_csd_func()
>
> Okay - I updated it to:
>
>   /*
>    * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
>    *
>    * - directly from the local scheduler_tick() for periodic load balancing
>    *
>    * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
>    *   through the SMP cross-call nohz_csd_func()
>    */
>   static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>
> Does this work with everyone?

yes looks good for me

>
> Thanks,
>
>         Ingo

