Return-Path: <linux-kernel+bounces-55172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C3384B8CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE128923A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06608131738;
	Tue,  6 Feb 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DhvpJd1u"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEE38D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232020; cv=none; b=br8dN+w4tLndbK4W6QWf3ab5/iLH0ROnM2zRd/PztyanqHJpwPYKtCp6otzLE5Z3jWAnr13HTPJqSeX+MF3IlK7CiNa7JfJVOaWUL8XqBd628H9O7xY4IUSu8HcWfrW4MSQFCx+YUo67aeIBbHx57ugqnhAZ/P23O3RdAUJaGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232020; c=relaxed/simple;
	bh=jQEYv3jIAy4MqZMCKc+hokmr2pwdSZDR8UEHWdNGDiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5egd2NKa6SidYB8I0d4I8ptjCoaGR9nPq44IKF1g6/EvLr07d/xcc1hofMzCP/LwwwixA+LLM58fUGP1J+/mtY8Sbzn1CpKQEGTpJSJn7An7tBoTzWl2A7N3pOKSHmATad/bWY1pWywrxW58vncoJocTvTGbOp/j1fVOIXK4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DhvpJd1u; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b401fd72bso1486431f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707232016; x=1707836816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ7y3Y7lXB7e+rY0LpFvOr02gZDXpOWLyRQYElaW0F8=;
        b=DhvpJd1uCuJzV6OhB861n2VtjYXLlgRbWNjAMZnDRQuRQtgyY2Z0noOX92+TuJtc/7
         tlwsIXjhf2PLSdVlPLxNLwiW9Ua4iTTFw59XRb8j5crxQOlnQyBXPypwsa8srBiY2YCQ
         uzpJWxCd13w61QrjSsydZU2c9LEs3vZJpCA8Lm7L0YN1XBMi80j06k7L+6//kmF2yaSJ
         zVo6NuouELeG4JCeSDWUBIXyLJipuXlYCYENgd+5AhNms/5caWaykmMYqwCBBT7a0BC+
         tUT6yE/d8GplGbntU3zgvYw6fLs99aPBhBMcEfFsVu7omRHeBsRbY/wC5SlOFv2py44g
         AUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232016; x=1707836816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ7y3Y7lXB7e+rY0LpFvOr02gZDXpOWLyRQYElaW0F8=;
        b=IgZoI6yO2TUkRlo81Sx9j8Y9uXxNSGWR10qN7LR5tGVYhi60WF0UVb80Kehut/ZQjN
         0OKHViyeAKP0ZCMLifK/axf1dUwXEIdYBucAlD9Hq1UCyFGg7U4gE4iFcuAztjTwcPr/
         Fw3cTAHsdJQLNCKA5ACzv7xmkRDU1GtCVKmj/b0ObJrwW/YzlhkGV8i2fv4PKNsEYvLD
         2MzzKSLcLtrhtZhJjheojBrStGw9m9YWPmtsZ0YTqSuEqXpM3AWmE86gCh87Ecv+YllL
         tZ3p43D5Kg9k4xlm0KAg3xg3XLqzYHovpdqcJkSCGpGPWANTIxSeXfoLV7l+cpFc3UUq
         UNag==
X-Gm-Message-State: AOJu0YydZvlYxxxpus2MGN4bBZ1eVeLlnNm9TF3iSGAtot3Z5rB9SIhi
	YAEv/gCYHr8CL5Et+caw1S+UV+3PeClQNgzc4gDwYNsSfUFW2mn9JNqQOHgGq8o=
X-Google-Smtp-Source: AGHT+IEN/8cQ0Z0MASmXqjo9YCJ2D9uX3HFp9lPHKp/WN84VlCwUisWDaCbHBh3sIPcH5EjSWveeAQ==
X-Received: by 2002:adf:9bd1:0:b0:33b:28b0:752a with SMTP id e17-20020adf9bd1000000b0033b28b0752amr1579439wrc.4.1707232015880;
        Tue, 06 Feb 2024 07:06:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVY7LC4FbWJph26Fi0xFYdlrL6mgK4G76Sr2/Y49Brg4veedUVJtm6ycgkouT2JjGqsgI5q8hjPlPo77VNit4jZv3p2atzyEZRpKWku9XNua0m70lXzqRdDLh5cqSSZSgI3F6SAyXeZZUre8wByzE3bs2Tcx77Abd5EBzFfYwI8x1lMDwtWPl45Bf+DLA==
Received: from airbuntu (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0033afe816977sm2296404wrt.66.2024.02.06.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:06:55 -0800 (PST)
Date: Tue, 6 Feb 2024 15:06:53 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240206150653.34ouqhbt4yz2cmgo@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
 <5249d534-d7ac-4cbc-a696-f269cb61c7d1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5249d534-d7ac-4cbc-a696-f269cb61c7d1@arm.com>

On 02/05/24 20:49, Dietmar Eggemann wrote:
> On 26/01/2024 02:46, Qais Yousef wrote:
> > On 01/25/24 18:40, Vincent Guittot wrote:
> >> On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
> >>>
> >>> On 01/23/24 09:26, Vincent Guittot wrote:
> >>>> On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
> >>>>>
> >>>>> From: Qais Yousef <qais.yousef@arm.com>
> 
> [...]
> 
> >>> And to be honest I am not sure if flattening of topology matters too since
> >>> I first noticed this, which was on Juno which doesn't have flat topology.
> >>>
> >>> FWIW I can still reproduce this, but I have a different setup now. On M1 mac
> >>> mini if I spawn a busy task affined to littles then expand the mask for
> >>> a single big core; I see big delays (>500ms) without the patch. But with the
> >>> patch it moves in few ms. The delay without the patch is too large and I can't
> >>> explain it. So the worry here is that generally misfit migration not happening
> >>> fast enough due to this fake misfit cases.
> >>
> >> I tried a similar scenario on RB5 but I don't see any difference with
> >> your patch. And that could be me not testing it correctly...
> >>
> >> I set the affinity of always running task to cpu[0-3] for a few
> >> seconds then extend it to [0-3,7] and the time to migrate is almost
> >> the same.
> > 
> > That matches what I do.
> > 
> > I write a trace_marker when I change affinity to help see when it should move.
> > 
> >>
> >> I'm using tip/sched/core + [0]
> >>
> >> [0] https://lore.kernel.org/all/20240108134843.429769-1-vincent.guittot@linaro.org/
> > 
> > I tried on pinebook pro which has a rk3399 and I can't reproduce there too.
> > 
> > On the M1 I get two sched domains, MC and DIE. But on the pine64 it has only
> > MC. Could this be the difference as lb has sched domains dependencies?
> > 
> > It seems we flatten topologies but not sched domains. I see all cpus shown as
> > core_siblings. The DT for apple silicon sets clusters in the cpu-map - which
> > seems the flatten topology stuff detect LLC correctly but still keeps the
> > sched-domains not flattened. Is this a bug? I thought we will end up with one
> > sched domain still.
> 
> IMHO, if you have a cpu_map entry with > 1 cluster in your dtb, you end
> up with MC and PKG (former DIE) Sched Domain (SD) level. And misfit load

Hmm, okay. I thought the detection of topology where we know the LLC is shared
will cause the sched domains to collapse too.

> balance takes potentially longer on PKG than to MC.

Why potentially longer? We iterate through the domains the CPU belong to. If
the first iteration (at MC) pulled something, then once we go to PKG then we're
less likely to pull again?

Anyway. I think I am hitting a bug here. The behavior doesn't look right to me
given the delays I'm seeing and the fact we do the ilb but for some reason fail
to pull

> 
> (1) Vanilla Juno-r0 [L b b L L L)
> 
> root@juno:~# echo 1 > /sys/kernel/debug/sched/verbose
> root@juno:~# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> MC
> PKG
> 
> root@juno:~# cat /proc/schedstat | head -5 | grep ^[cd]
> cpu0 0 0 0 0 0 0 2441100800 251426780 6694
> domain0 39 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain1 3f 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 
> (2) flattened topology (including SDs):
> 
> Remove cluster1 from cpu_map and A57_L2 $ entry.
> 
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -44,19 +44,16 @@ core0 {
>                                 core1 {
>                                         cpu = <&A57_1>;
>                                 };
> -                       };
> -
> -                       cluster1 {
> -                               core0 {
> +                               core2 {
>                                         cpu = <&A53_0>;
>                                 };
> -                               core1 {
> +                               core3 {
>                                         cpu = <&A53_1>;
>                                 };
> -                               core2 {
> +                               core4 {
>                                         cpu = <&A53_2>;
>                                 };
> -                               core3 {
> +                               core5 {
>                                         cpu = <&A53_3>;
>                                 };
>                         };
> @@ -95,7 +92,7 @@ A57_0: cpu@0 {
>                         d-cache-size = <0x8000>;
>                         d-cache-line-size = <64>;
>                         d-cache-sets = <256>;
> -                       next-level-cache = <&A57_L2>;
> +                       next-level-cache = <&A53_L2>;
>                         clocks = <&scpi_dvfs 0>;
>                         cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>                         capacity-dmips-mhz = <1024>;
> @@ -113,7 +110,7 @@ A57_1: cpu@1 {
>                         d-cache-size = <0x8000>;
>                         d-cache-line-size = <64>;
>                         d-cache-sets = <256>;
> -                       next-level-cache = <&A57_L2>;
> +                       next-level-cache = <&A53_L2>;
>                         clocks = <&scpi_dvfs 0>;
>                         cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>                         capacity-dmips-mhz = <1024>;
> @@ -192,15 +189,6 @@ A53_3: cpu@103 {
>                         dynamic-power-coefficient = <140>;
>                 };
>  
> -               A57_L2: l2-cache0 {
> -                       compatible = "cache";
> -                       cache-unified;
> -                       cache-size = <0x200000>;
> -                       cache-line-size = <64>;
> -                       cache-sets = <2048>;
> -                       cache-level = <2>;
> -               };
> -
>                 A53_L2: l2-cache1 {
>                         compatible = "cache";
>                         cache-unified;
> 
> root@juno:~#  echo 1 > /sys/kernel/debug/sched/verbose
> root@juno:~# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> MC
> 
> root@juno:~# cat /proc/schedstat | head -4 | grep ^[cd]
> cpu0 0 0 0 0 0 0 2378087600 310618500 8152
> domain0 3f 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 
> [...]
> 

