Return-Path: <linux-kernel+bounces-31453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E180F832E89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC42865CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4627358AA7;
	Fri, 19 Jan 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvbwUvsW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3F58227
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687074; cv=none; b=hzZGdKcLULnuDlkPjSC0a4+sFnhced2hX9TFwI3kQIPgCzw/5fFh1klUp2QAYOF+yT94F8rDfRMFTPwSJVpzWjbMZjC4MEufQRAQKaapNCoABmAUFTv5QRWMdzVnQTB4jKXt24qCATYMKjzEUQLq7l2OhjgUvtlcxa2cqFe6jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687074; c=relaxed/simple;
	bh=Hs5EhcUi8XoiZYod5yUZE9vnnJwoed4gSPgHtPxEZEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCZp+ZSEve1qEuAtwd2LvXwR4XYHLzWwg/X3ZOQT3zrlNvgFMfNETTdTEqTVJ9EXROSGJdEpitITQULs2iRCIwwT5VFLdO5cHE/0eRaeiVUGgOsBitP9RnOKAWnlAlS1kl5BFcWh0Jy4TB3OoAxaPaXdwp3bUtOsFZL10Xq4e/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvbwUvsW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce942efda5so847324a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705687072; x=1706291872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STdvALwx1cJlhI4fFxZ8A3ouzBnNEklbbv9BMOJUhas=;
        b=NvbwUvsWrEVlcfhW7AgGuAINh8pp1XjxCrJzYyZaS4lMga7u+djlqr9uLY5vBhaZlx
         U1IM4aer3ms10BfUiMdzGfowzuDhsA46bZ/YX94W2txmPdZhzjhE5Y8YSqBh5IFtuzEw
         0vwC6dNUDNpycOCAsIIXcmpVmrK4D/g6KSXp1bTUvlglIJpgOFEZFx1P05LXkJ2B5U1G
         Y/erq/fojEvcPeW1vNkaa34uDYcaN3yV43Rs2kn3YBFO210ytnnqWqEx/HtmpPdhZ3dV
         OGeNcYdvYl/RfiCay+vOQa+r2dtGE7LyNbdPnF1O/uPXpi+j84ysPacyGarqwqgxWLge
         AqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687072; x=1706291872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STdvALwx1cJlhI4fFxZ8A3ouzBnNEklbbv9BMOJUhas=;
        b=P8vlcit6WKVN4HxeEsDuWI85qBHhptu1c8MmJTly9DgvpPxlOAZDmxErXhTelV17nB
         xU5qEqTgx89RjBkBJs/v/D6jTcpOlJoiiahtWDJkrdFj3+RseVzoeJsyuKY5ceLSQg4N
         6wmWB5zmPI/JLBX/SbjFQJe51SAGnF8e8sYTcGrgpB1q7R23jElvIXLTmH+vq9JWCQnh
         qZc3+lAueHBdUnfme3W/47GqS2LgajRoNyvaQqV6hJmNWS2kF7hiepfmC9xRoi6You5g
         aZfEHberaLUc5pVn0AXQzMClB2aMuBJLnXo3+fL/iwbgQq2Uw03uOtAQ2Xi+PQnSIWzG
         ftAQ==
X-Gm-Message-State: AOJu0YzfEd32sqL2a2PQttvs1NaFxrqTzegnG181xWAvUrnaFDFmGubn
	sehlX2nswytQwCTgi5Ulqj/Iui5v2fPmmgs2HXne24tevsP1lcl9z/55KQz0m3DA1qVh9OdnsYT
	NpL4hDS238YdapBtbmzxVfEneZg8Sm/r2SIA0PQ==
X-Google-Smtp-Source: AGHT+IH8ETPC9j1JKPobq2N1D5kovws7zB1ri83OldKaisFdDCCHf09XHHhY7RBpbmGdFefsj+FA8yRNnpVs7aLmQm0=
X-Received: by 2002:a17:90b:157:b0:290:2c5:b231 with SMTP id
 em23-20020a17090b015700b0029002c5b231mr116943pjb.81.1705687072457; Fri, 19
 Jan 2024 09:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <d37e3d06-d9fc-4fc3-ad92-e7031489660a@arm.com> <CAKfTPtAOSgnStDSao1QarHuUW9BTfk1o7r6NO4LhwEJMhq1drg@mail.gmail.com>
 <5ac0df44-82b6-463b-a805-65f93d181215@arm.com>
In-Reply-To: <5ac0df44-82b6-463b-a805-65f93d181215@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 19 Jan 2024 18:57:41 +0100
Message-ID: <CAKfTPtCK-YeM4cJehSb8G0aj40rjGgq2kG-ddgKxdAMAvkbZQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Rework system pressure interface to the scheduler
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 19:10, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 09/01/2024 14:29, Vincent Guittot wrote:
> > On Tue, 9 Jan 2024 at 12:34, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 08/01/2024 14:48, Vincent Guittot wrote:
> >>> Following the consolidation and cleanup of CPU capacity in [1], this serie
> >>> reworks how the scheduler gets the pressures on CPUs. We need to take into
> >>> account all pressures applied by cpufreq on the compute capacity of a CPU
> >>> for dozens of ms or more and not only cpufreq cooling device or HW
> >>> mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
> >>> - one from cpufreq and freq_qos
> >>> - one from HW high freq mitigiation.
> >>>
> >>> The next step will be to add a dedicated interface for long standing
> >>> capping of the CPU capacity (i.e. for seconds or more) like the
> >>> scaling_max_freq of cpufreq sysfs. The latter is already taken into
> >>> account by this serie but as a temporary pressure which is not always the
> >>> best choice when we know that it will happen for seconds or more.
> >>
> >> I guess this is related to the 'user space system pressure' (*) slide of
> >> your OSPM '23 talk.
> >
> > yes
> >
> >>
> >> Where do you draw the line when it comes to time between (*) and the
> >> 'medium pace system pressure' (e.g. thermal and FREQ_QOS).
> >
> > My goal is to consider the /sys/../scaling_max_freq as the 'user space
> > system pressure'
> >
> >>
> >> IIRC, with (*) you want to rebuild the sched domains etc.
> >
> > The easiest way would be to rebuild the sched_domain but the cost is
> > not small so I would prefer to skip the rebuild and add a new signal
> > that keep track on this capped capacity
>
> Are you saying that you don't need to rebuild sched domains since
> cpu_capacity information of the sched domain hierarchy is
> independently updated via:
>
> update_sd_lb_stats() {
>
>   update_group_capacity() {
>
>     if (!child)
>       update_cpu_capacity(sd, cpu) {
>
>         capacity = scale_rt_capacity(cpu) {
>
>           max = get_actual_cpu_capacity(cpu) <- (*)
>         }
>
>         sdg->sgc->capacity = capacity;
>         sdg->sgc->min_capacity = capacity;
>         sdg->sgc->max_capacity = capacity;
>       }
>
>   }
>
> }
>
> (*) influence of temporary and permanent (to be added) frequency
> pressure on cpu_capacity (per-cpu and in sd data)


I'm more concerned by rd->max_cpu_capacity which remains at original
capacity and triggers spurious LB if we take into account the
userspace max freq instead of the original max compute capacity of a
CPU. And also how to manage this in RT and DL

>
>
> example: hackbench on h960 with IPA:
>                                                                                   cap  min  max
> ...
> hackbench-2284 [007] .Ns..  2170.796726: update_group_capacity: sdg !child cpu=7 1017 1017 1017
> hackbench-2456 [007] ..s..  2170.920729: update_group_capacity: sdg !child cpu=7 1018 1018 1018
>     <...>-2314 [007] ..s1.  2171.044724: update_group_capacity: sdg !child cpu=7 1011 1011 1011
> hackbench-2541 [007] ..s..  2171.168734: update_group_capacity: sdg !child cpu=7  918  918  918
> hackbench-2558 [007] .Ns..  2171.228716: update_group_capacity: sdg !child cpu=7  912  912  912
>     <...>-2321 [007] ..s..  2171.352718: update_group_capacity: sdg !child cpu=7  812  812  812
> hackbench-2553 [007] ..s..  2171.476721: update_group_capacity: sdg !child cpu=7  640  640  640
>     <...>-2446 [007] ..s2.  2171.600743: update_group_capacity: sdg !child cpu=7  610  610  610
> hackbench-2347 [007] ..s..  2171.724738: update_group_capacity: sdg !child cpu=7  406  406  406
> hackbench-2331 [007] .Ns1.  2171.848768: update_group_capacity: sdg !child cpu=7  390  390  390
> hackbench-2421 [007] ..s..  2171.972733: update_group_capacity: sdg !child cpu=7  388  388  388
> ...

