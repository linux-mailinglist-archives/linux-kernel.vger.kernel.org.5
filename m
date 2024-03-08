Return-Path: <linux-kernel+bounces-96801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8387619E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5551F232DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6226B53E02;
	Fri,  8 Mar 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6qMemMZ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2953392
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892717; cv=none; b=sYaACYVc3g+OZ1Vyv4/U/2Qa9Px3rGFun87NQWdeQlTsrP5rtfSUhoV0PMyU9LPzET184+icX1kDZNl8fPyIuTTps7TNh7w5AS6UolcSX5rkyMzkd1KmKakqWTSE5PtNkxFxJJWZJOzjBsZDv0wzG6v1sSXlFJqOxB/NudzA2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892717; c=relaxed/simple;
	bh=YPk6MhupImEkBJNjzqHmDl9I4DWF0zfJXklSjafs0ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn7d8FbtXGXcRhSTj1ca/dMWLSZejwvBwklWT0V6jSmHAiElioKzHxv+nDZbLBI241whYNterpPECJoEEOGxdEu6VdEWSOEed1amZQqEvncRYvzunb8s+AcjUvG2NR/KXVgJZA65LDofztzi9dlSnkco1o29n2nJpLtNaNy9izI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6qMemMZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e570ef661so1068468f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709892714; x=1710497514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVZsmE5DPTMVZKCZO/p7hE6RchBte0hgIK9JBsijFJ0=;
        b=S6qMemMZSbEKdeHA3wCDVjH18fMX6+KZfm9BG/vhRh82H0rkMdtCY1TD1XX5+yIhHf
         ZH6URiwoSxYilycTKWUA16khNHci12WwZC4EfMyfuhFwK7gPx7m627+LrkyDNtc/a/qf
         dwIZe3VwI7BL3H4qPAxvGHuCCPyUk/D34OEQRUUXFJYYIoeQlNtnQnmhMVOOW3DTrN4V
         FbMjoDM3WlupwUdvH1TRwCGs223Pq3oHd8UztowuFlozpR+DiKu6ybuq/D919re8KsFV
         HmA1PFVdUEw9/8pg3s4YRz+wXCEqHC8atLpUST2DnfkEpDKg+tDw08FzrW74XjdqwFjk
         au1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892714; x=1710497514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVZsmE5DPTMVZKCZO/p7hE6RchBte0hgIK9JBsijFJ0=;
        b=On6Y0xO0yL8Y0pgki7hhuv3RfhtTj8aHk2JA2CKkFNc/CepdTZCeBGT6m541XjSsZw
         VLMmDoGcWJU+HJmQCqBSEOqdzSFhwuZ9002BXEmcfkNnEA9UzQxbOhAkcQej4dGzQrw3
         JYp1OQsd32FypN9kZiX/ddajujXbiaAH5C2AX0YF6aOoRMid+czL6uogex3gTKvvlCX0
         L1+K50rVe5G/6CCx6ioI5L7Z3a4sqzXqCib2D5syFw1EnytJiJ2wz3o4tEpfMfavP6kd
         v4/Wm4H+5/8N14TqSPxrwP6SUQruFMXCjevmc/EdeuvLK9RxxYi0z+ekfi7WkdcFSH83
         2DmQ==
X-Gm-Message-State: AOJu0YynR8jtJR9wyh9UeEnIrn8VBwNhJmTBlDExXlW1ZHPDZo47H3Zv
	lpHtvExMHpGUmooteBVexG7tizJLsb1UYRFhv5gqthaOuMdkU9CK
X-Google-Smtp-Source: AGHT+IFCQ/TGDK2MR8wN0wfYJ6AUXw1b845dGP+kczSdpfyrKYVjMgyPGvpk21hRIUajjKGivSvR1w==
X-Received: by 2002:a5d:457c:0:b0:33e:4ad5:7103 with SMTP id a28-20020a5d457c000000b0033e4ad57103mr9017353wrc.27.1709892713718;
        Fri, 08 Mar 2024 02:11:53 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0033e43756d11sm12055633wrb.85.2024.03.08.02.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:11:53 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 11:11:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 5/9] sched/balancing: Fix comments (trying to) refer to
 NOHZ_BALANCE_KICK
Message-ID: <ZerkZ/4wpjLrYtvD@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-6-mingo@kernel.org>
 <CAKfTPtCNmnsLL+OwyYjn+DysbXUyjqAdsWXr1Q6pGBybdkhYGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNmnsLL+OwyYjn+DysbXUyjqAdsWXr1Q6pGBybdkhYGw@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Mon, 4 Mar 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Fix two typos:
> >
> >  - There's no such thing as 'nohz_balancing_kick', the
> >    flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.
> >
> >  - Likewise there's no such thing as a 'pending nohz_balance_kick'
> >    either, the NOHZ_BALANCE_KICK flag is all upper-case.
> >
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  kernel/sched/fair.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 934ace69eb30..4c46bffb6a7a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12410,14 +12410,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >
> >  /*
> >   * run_rebalance_domains is triggered when needed from the scheduler tick.
> > - * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
> 
> I think it should be nohz_balancer_kick() instead of nohz_balancing_kick
> 
> 
> > + * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
> 
> In fact, this can be triggered even without NOHZ_BALANCE_KICK. Any of
> the below can trigger this
>   - NOHZ_BALANCE_KICK
>   - NOHZ_STATS_KICK
>   - NOHZ_NEXT_KICK

Yeah, indeed any of the flags in NOHZ_KICK_MASK can trigger nohz_csd and 
indirect the balancing softirq - so I changed the text to:

  /*                      
   * This softirq may be triggered from the scheduler tick, or by
   * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
   * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
   */
  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)

Thanks,

	Ingo

