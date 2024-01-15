Return-Path: <linux-kernel+bounces-26173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96E82DC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09861C21D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D517744;
	Mon, 15 Jan 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0LUANBY"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB851773A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso2441332a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705332424; x=1705937224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJg7NLwiFD5QIzGuGfb2SLXATeNIKVo9SH4/Azpyieo=;
        b=U0LUANBYG1K/tzYe+1esf8ABE9oNkPsR7k6AdrMCOE59MvIJoyx3D+f6pEjRz+1PtW
         UzDerT6vK2iqVMcy5iFjAILFLl8kgO/2G2IHpXnrFvqaZ61h9iBatl3qm25jMCnruwqj
         UiiQAOvFvXmL+yUziuyNi6L6lIek4AO5TNpQwfWV7fOtJH5oqdLGluE3GrY4mbwvokzc
         qE3B3x7ebK4lgSLrjAu+UrruDZ/EsyIE27CuX+hRxw41RdH41IZkfZbu0f37pZwfd2V6
         oR0hgYI3Has1WB02A8G1Q+afW5FmNO/wCn0j67Wwr8JbiyoVxaU+QSM0K8pdVj5plrN5
         iTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332424; x=1705937224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJg7NLwiFD5QIzGuGfb2SLXATeNIKVo9SH4/Azpyieo=;
        b=s2/eA3//u8IvLCon5PCZmqQRJDSRjDwvmMsF8vyok4kf5j9GYUAAAp0tNerzJ5E+99
         GgJViqiiC1aAQsymmLb3SV71ogrpr83fC1+XKUKYWuZKFep9br0e3eGdan2EvzcGxCy6
         3Jr4x0g5234MZrc+GCg5hBUiwwbk10fLyfX+1ItMBy2JLt4qsD5OKHrvDrDIJmNYTUMN
         vIYYA6waLSvRHCM46JnzZqRdXUllgXscwYeKDEb1bmVvDd1Dnw9GZwW6N1BovNQ+LsFT
         5NglFnBLlCmMue83jxD+yHOv82rDSt/ER81fu3yKzAyprIQC+dCloU40RcIJB/m8eE/U
         T6Aw==
X-Gm-Message-State: AOJu0YwX+aOKUZ/P6JebEsIs58K+ql2L3SPJUAjOdshvx0nPp2IkNb4k
	a1WNaxfbXUDdgzwpDX+yyEVHguSukmKsw/4B2WwgT8wisyZN2Q==
X-Google-Smtp-Source: AGHT+IGMR+cLKE+ZVJj6aNs6YKCg4k1tN3RpWIWaIGXRlw/YGnAOrmbHexHFoevWtJXk17i0DxmvSVxeJjsD/8b1Xh4=
X-Received: by 2002:a17:90b:3e8c:b0:28d:a474:9967 with SMTP id
 rj12-20020a17090b3e8c00b0028da4749967mr2599608pjb.31.1705332424384; Mon, 15
 Jan 2024 07:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu> <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu> <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>
 <20240115120915.fukpcdumntdsllwi@airbuntu> <CAKfTPtAMacH4hKLyttLuQJjzc=D4m864MFaEEwZLG4K8RKTDYA@mail.gmail.com>
 <dfde5b4f-0d5e-49b6-a787-0766eff23f91@arm.com>
In-Reply-To: <dfde5b4f-0d5e-49b6-a787-0766eff23f91@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jan 2024 16:26:52 +0100
Message-ID: <CAKfTPtB72Oa8XvH_xRFiKy+bfyEKUMdndKphFAD3dixePBUohQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, Wyes Karny <wkarny@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jan 2024 at 15:03, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 15/01/2024 14:26, Vincent Guittot wrote:
> > On Mon, 15 Jan 2024 at 13:09, Qais Yousef <qyousef@layalina.io> wrote:
> >>
> >> On 01/15/24 09:21, Vincent Guittot wrote:
> >>
> >>>> Or I've done the math wrong :-) But the two don't behave the same for the same
> >>>> kernel with and without CPPC.
> >>>
> >>> They will never behave the same because they can't
> >>> - with invariance, the utilization is the utilization at max capacity
> >>> so we can easily jump several OPP to go directly to the right one
> >>> - without invariance, the utilization is the utilization at current
> >>> OPP so we can only jump to a limited number of OPP
> >>
> >> I am probably missing some subtlty, but the  behavior looks more sensible to
> >> me when we divide by current capacity instead of max one.
> >>
> >> It seems what you're saying is that the capacity range for each OPP is 0-1024.
> >
> > Yes that's the case when you don't have frequency invariance
> >
> >> And that's when we know that we saturated the current capacity level we decide
> >> to move on.
> >
> > yes
> >
> >>
> >> As I am trying to remove the hardcoded headroom values I am wary of another
> >> one. But it seems this is bandaid scenario anyway; so maybe I shouldn't worry
> >> too much about it.
>
> I still don't fully understand this fix.
>
> We had:
>
> sugov_update_single_freq()
>
>   sugov_update_single_common()
>
>   next_f = get_next_freq()
>
>    freq = arch_scale_freq_invariant() ?
>           policy->cpuinfo.max_freq : policy->cur (**) <- (2) !freq_inv
>
>
>   util = map_util_perf(util);                     <- (1) util *= 1.25
>
>   freq = map_util_freq(util, freq, max);          <- (3)
> }
>
>
>
> And now there is:
>
> sugov_update_single_freq()
>
>   sugov_update_single_common()
>
>     sugov_get_util()
>
>       sg_cpu->util = sugov_effective_cpu_perf()
>
>         /* Add dvfs headroom to actual utilization */
>         actual = map_util_perf(actual)            <- (1) util *= 1.25
>
>   next_f = get_next_freq()
>
>     freq = get_capacity_ref_freq()
>
>       return policy->cur (*)                      <- (2) !freq_inv
>
>     freq = map_util_freq(util, freq, max)         <- (3)
>
> Still not clear to me why we need this extra 'policy->cur *= 1.25' here
> (*) and not here (**)

Now, util can't be higher than max to handle clamping use cases
whereas it could be the case before. The jump to next OPP was
previously done with util being higher than max and it's now done with
freq being higher than policy->cur

>
>

