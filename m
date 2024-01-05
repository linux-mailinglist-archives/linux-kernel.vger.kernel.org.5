Return-Path: <linux-kernel+bounces-18029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099E825771
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4661C218DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F32E85F;
	Fri,  5 Jan 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmGuh7To"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEB2E852
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67f9f6caabcso7935796d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470442; x=1705075242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dn6MgJ/6ZzbMLMCkvKlinwOAEJn5n1fruy8Tzx3bMM0=;
        b=AmGuh7To2G1MG+2a0NvP8syCW+ZmYIpeFTew1EKC0yp4WVOXm9T0yBGVxTy3MRxfeF
         uSqdiUwJF80yRdxQPJ82MYvvWky5OSpGf8YjxZZrNJZIAc1CzqJPLEhOBbs4oNFAndEE
         DVuCZzfy/OhExa9rI5zXC5i01QqpAhQbep5xJ+frtUNfi7OAzHkG2xxW5gPh10bm/PQm
         5gUOAnys3DOSkBwWm7qQnK40WhiDupi2N/thMnYdtyWjJMWbRYTePyIf0AWAAsKMCa2n
         u8SEaq5l/PRCT8j2Zrbp1sVSYDqWlbOWxkO87+ytIIsbOVB357/sFXpV4uGU0KlqE/wi
         CFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470442; x=1705075242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn6MgJ/6ZzbMLMCkvKlinwOAEJn5n1fruy8Tzx3bMM0=;
        b=HRf0l31Oz1ATpKzTAF2XQm12tRk8qTghx581iRBB1L1ULAW8hu/GBiQgz7iZaX2Mga
         tOANySAKTbDim3x9UdJTnCC0ADbHVD0T/66mzoFBWiGofdohFSYLqJtX9G4HGeNnhN/2
         epAOi6SRD9MOg5L003t/6oVEUbOCjsy4cSrD4BmlVY0m0F+ZcbLp1/Yp8o5Z9WlL5c/d
         mCG8CiJciWw5cNhfhuNqDQlM5M9tA+DWqWGymPuxNqPYIuNmBoQhD+Ledfrwy4t7IM/e
         bk0sV4QPSkynBjCjmWBR5+1rWwnNNRiiBUPs6wsVp9vyZrkmpagw/eoKl3K4SzXksFIm
         UuMw==
X-Gm-Message-State: AOJu0YzWyEOvJJpXK3a0HUU9uNzzGHkuaQfrpHA2/LDO2MfuHtY+4qLn
	l4ck0NnoEN869jxGLQdrAx2X10kzfmjpSoi06PkA4K+d2GUEeA==
X-Google-Smtp-Source: AGHT+IEw94IZb/sngG0I+NbdEIM9RGCKMXUXlZS80Fe/znbT2cb+xlGnLVD+6GqKGUgMFPnm4VNWJ7bd1MWbspAj8ws=
X-Received: by 2002:a05:6214:3018:b0:67f:f92:2a05 with SMTP id
 ke24-20020a056214301800b0067f0f922a05mr2678267qvb.25.1704470442146; Fri, 05
 Jan 2024 08:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr> <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com>
 <alpine.DEB.2.22.394.2312182302310.3361@hadrien> <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
 <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
 <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
 <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
 <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
 <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
 <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com> <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr>
In-Reply-To: <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 5 Jan 2024 17:00:28 +0100
Message-ID: <CAKfTPtD0B29zadkeEOCWvry123zWVEEm41ouKj7noXwQdoh2+Q@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 15:51, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > Your system is calling the polling mode and not the default
> > cpuidle_idle_call() ? This could explain why I don't see such problem
> > on my system which doesn't have polling
> >
> > Are you forcing the use of polling mode ?
> > If yes, could you check that this problem disappears without forcing
> > polling mode ?
>
> I expanded the code in do_idle to:
>
>                 if (cpu_idle_force_poll) { c1++;
>                         tick_nohz_idle_restart_tick();
>                         cpu_idle_poll();
>                 } else if (tick_check_broadcast_expired()) { c2++;
>                         tick_nohz_idle_restart_tick();
>                         cpu_idle_poll();
>                 } else { c3++;
>                         cpuidle_idle_call();
>                 }
>
> Later, I have:
>
>         trace_printk("force poll: %d: c1: %d, c2: %d, c3: %d\n",cpu_idle_force_poll, c1, c2, c3);
>         flush_smp_call_function_queue();
>         schedule_idle();
>
> force poll, c1 and c2 are always 0, and c3 is always some non-zero value.
> Sometimes small (often 1), and sometimes large (304 or 305).
>
> So I don't think it's calling cpu_idle_poll().

I agree that something else

>
> x86 has TIF_POLLING_NRFLAG defined to be a non zero value, which I think
> is sufficient to cause the issue.

Could you trace trace_sched_wake_idle_without_ipi() ans csd traces as well ?
I don't understand what set need_resched() in your case; having in
mind that I don't see the problem on my Arm systems and IIRC Peter
said that he didn't face the problem on his x86 system.

>
> julia

