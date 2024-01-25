Return-Path: <linux-kernel+bounces-37810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FAA83B5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A281C2380B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54068196;
	Thu, 25 Jan 2024 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAVJ1yGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058A193;
	Thu, 25 Jan 2024 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140921; cv=none; b=Xl/eXftoASzGoQlgzfE3bcpQjJGYQIVJY6MlEVNsyr6BFQfLWkt420HaMZ0532oHETvkkubDUtZAUx+QpJ10KGFAXV6Wf58gb3o7gEjRtZVs1uclTkhlww7Kkv0mkkimYy9zgqD8N2QQnXAxZZKe0bBElwtVBMSS/DWxBXmG5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140921; c=relaxed/simple;
	bh=5mwY570DfNBBwhuUW2/t3DHz1by/BgnhUlLMFufm0+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0H/C/8X+ykLj5PAarohcLkP3bxvfB7cuEBPLtziX6+6vUK30UadOvkY80rMq0XpY1IewfdCP3bFns9nwCXyKi/Qo69P8Wp0CA+SzySz3W5b3KLA57WrxsYEl00stzxWIRPsnKQhljW1/k4zjVsucH47mtAU4kJUW0qTwY3jR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAVJ1yGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099DC433C7;
	Thu, 25 Jan 2024 00:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706140921;
	bh=5mwY570DfNBBwhuUW2/t3DHz1by/BgnhUlLMFufm0+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sAVJ1yGg1Hx8GOa4pX8oNHh6i6qqNofcmWg+KNI8kogmUaYu4sZ5Cq0vmU7AT5kwX
	 qvjsp6BsOTdGa/BD2OA9yDJDobUhrxyo7KPGlPua6VqafmCPm4Gdsh6zHQXklK3dSB
	 Zbde20MmT33LnKromEZbhe4z9A2erIY4n8JC/Ujj4CbMcDZ8+wMNtvp5MFagoK3VsY
	 WWx+dOnt6jCi0JZWB08CQxZsTXYQt6gs2gr7BEgEsOz6Q9tFMpu8LEaj1UrjDGFgQC
	 HpqtU60KJCk5o9nIzIDwd6BiFxgQ0HXVCIPLF5Zr42wiZ4VDxpGYh4lLTZBacf5ydg
	 KF77tNBO4h78A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso12333281fa.3;
        Wed, 24 Jan 2024 16:02:01 -0800 (PST)
X-Gm-Message-State: AOJu0YzQP9l9bY2In9qhaGHsSyvsAE52z33W3g4H4pLK1RXLaf1fgdTh
	Kw40F2wKaWPag6fAyazdyp1CYPieJdzV6Z8tUMCjMlrt/Nt+QA87y4zrzIhb4RtHJfgQXdR/PVc
	5bNNPlROvby9mbvKdDxGcVONh12w=
X-Google-Smtp-Source: AGHT+IFCXb46Pzw2PPc2gtLorR23QXWS78uxb9N4YsNdsOk4803nUo90BTz/XVPNryE+v48kycxwftjhso1Cfm5+d58=
X-Received: by 2002:a2e:9b49:0:b0:2cc:c794:57c7 with SMTP id
 o9-20020a2e9b49000000b002ccc79457c7mr66379ljj.43.1706140919297; Wed, 24 Jan
 2024 16:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
 <20240123235803.8298-1-dan@danm.net>
In-Reply-To: <20240123235803.8298-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Wed, 24 Jan 2024 16:01:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW49L8B9K8QFg68v=zG9ywMehUTD18DaG4PexEt-3mzQqQ@mail.gmail.com>
Message-ID: <CAPhsuW49L8B9K8QFg68v=zG9ywMehUTD18DaG4PexEt-3mzQqQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>, junxiao.bi@oracle.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the information!


On Tue, Jan 23, 2024 at 3:58=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> > This appears the md thread hit some infinite loop, so I would like to
> > know what it is doing. We can probably get the information with the
> > perf tool, something like:
> >
> > perf record -a
> > perf report
>
> Here you go!
>
> # Total Lost Samples: 0
> #
> # Samples: 78K of event 'cycles'
> # Event count (approx.): 83127675745
> #
> # Overhead  Command          Shared Object                   Symbol
> # ........  ...............  ..............................  ............=
......................................
> #
>     49.31%  md0_raid5        [kernel.kallsyms]               [k] handle_s=
tripe
>     18.63%  md0_raid5        [kernel.kallsyms]               [k] ops_run_=
io
>      6.07%  md0_raid5        [kernel.kallsyms]               [k] handle_a=
ctive_stripes.isra.0
>      5.50%  md0_raid5        [kernel.kallsyms]               [k] do_relea=
se_stripe
>      3.09%  md0_raid5        [kernel.kallsyms]               [k] _raw_spi=
n_lock_irqsave
>      2.48%  md0_raid5        [kernel.kallsyms]               [k] r5l_writ=
e_stripe
>      1.89%  md0_raid5        [kernel.kallsyms]               [k] md_wakeu=
p_thread
>      1.45%  ksmd             [kernel.kallsyms]               [k] ksm_scan=
_thread
>      1.37%  md0_raid5        [kernel.kallsyms]               [k] stripe_i=
s_lowprio
>      0.87%  ksmd             [kernel.kallsyms]               [k] memcmp
>      0.68%  ksmd             [kernel.kallsyms]               [k] xxh64
>      0.56%  md0_raid5        [kernel.kallsyms]               [k] __wake_u=
p_common
>      0.52%  md0_raid5        [kernel.kallsyms]               [k] __wake_u=
p
>      0.46%  ksmd             [kernel.kallsyms]               [k] mtree_lo=
ad
>      0.44%  ksmd             [kernel.kallsyms]               [k] try_grab=
_page
>      0.40%  ksmd             [kernel.kallsyms]               [k] follow_p=
4d_mask.constprop.0
>      0.39%  md0_raid5        [kernel.kallsyms]               [k] r5l_log_=
disk_error
>      0.37%  md0_raid5        [kernel.kallsyms]               [k] _raw_spi=
n_lock_irq
>      0.33%  md0_raid5        [kernel.kallsyms]               [k] release_=
stripe_list
>      0.31%  md0_raid5        [kernel.kallsyms]               [k] release_=
inactive_stripe_list

It appears the thread is indeed doing something. I haven't got luck to
reproduce this on my hosts. Could you please try whether the following
change fixes the issue (without reverting 0de40f76d567)? I will try to
reproduce the issue on my side.

Junxiao,

Please also help look into this.

Thanks,
Song

