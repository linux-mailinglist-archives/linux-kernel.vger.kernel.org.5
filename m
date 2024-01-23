Return-Path: <linux-kernel+bounces-36128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4683F839C06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA07B25DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272714F218;
	Tue, 23 Jan 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCuDScnk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8D3FB32;
	Tue, 23 Jan 2024 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048527; cv=none; b=nDx33MtTWN5PdnOidlr8ouz5ngw1WjKjJCpgCev4mBYSjHpJORUt8XX8cyt3KPQwzWJzfuR1JNHMQMOc4P+n1s+KTI7kdkBbJUK3CbP31OwMV3TsbVovzfzRWqHPAosH8d0IPKBApgvJbgGvszS4xP4kuZpmFLG+kAwF5aiMvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048527; c=relaxed/simple;
	bh=EzwRwlhyI9kA9Jd55DwG+gIrmMJ8fBPSINqDqU0+1SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBUFDB23saf0YPzcx0dajlL0KxxLUh8H2k69ELqHmdOVX4z62pRhRY/QU2QHKjTLXFglXGTuQ6vQ0pxS6CsnTVsX+h4JSB+PrwRI4FMp3zIPBTKC2CY0u1Ph5NYZrTj8Vpu24aTA6YVc+UIZfuUJsonq2+syKtMekInu8w63cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCuDScnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE971C433F1;
	Tue, 23 Jan 2024 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706048527;
	bh=EzwRwlhyI9kA9Jd55DwG+gIrmMJ8fBPSINqDqU0+1SM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCuDScnk5OMkc0SF7hb4kstl87dZz28o9lnN91iCFE15A3nNkVSGiauCYJV+ETIs0
	 0fj+9tD1d4ls045IQABfYhs8xknV49SYHXeeuBBcoya7hnt4b6RWJ8OqtNvaCXmgxw
	 OhODmj+Z3H2wZxjOSCPIJtzfwCS6/BI/TvcZvwvvPRynLwLsVbrMC3x3DeQJ12g+wP
	 a72oX3WFJpXP+4SyhQiqawXqfieVdc4cQp8WpCiIpwUkkBKQwjZQFmyx6gKJaRY9oD
	 k9dp+iNwkRVQ7fmKr3flfJAYL12B2Uel4dw648sHh2W3lQ3jp+HdPsd5zOJagr7GPn
	 hCq1P1S2Tj21g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50f1c524010so5248966e87.3;
        Tue, 23 Jan 2024 14:22:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8B8txMzYH7M6+XZfxnEm49N3D2qqFfi4lCMNpNXBACuwT6F+h
	iw+00r2aYe4+Rtw6UnzcTh9cp9lOyInzvFJBrMECXNoQYvD+5yoYm+64cY6/KFipYiOFjyuaLMT
	ghyOzd3jzyssmjIaJLO9t/jXBMQQ=
X-Google-Smtp-Source: AGHT+IF1CUodDtCMAW+NVQPE7jGtYRkmWBnHNrxZXeGF1ISeA10pmyI6sPx3p8WupA3heZ8MeYXxHsOu3FAUZ9mxDAM=
X-Received: by 2002:a05:6512:138f:b0:50e:f724:5b0 with SMTP id
 fc15-20020a056512138f00b0050ef72405b0mr1723376lfb.97.1706048525166; Tue, 23
 Jan 2024 14:22:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW7-r=UAO8f7Ok08vCx2kdVx6mZADyZ-LknNE8csnX+L8g@mail.gmail.com>
 <20240123215307.8083-1-dan@danm.net>
In-Reply-To: <20240123215307.8083-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Tue, 23 Jan 2024 14:21:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
Message-ID: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, junxiao.bi@oracle.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, Jan 23, 2024 at 1:53=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> > I think we still want d6e035aad6c0 in 6.7.2. We may need to revert
> > 0de40f76d567 on top of that. Could you please test it out? (6.7.1 +
> > d6e035aad6c0 + revert 0de40f76d567.
>
> I was operating under the assumption that the two commits were
> intended to exist as a pair (the one reverts the old fix, because the
> next commit has what is supposed to be a better fix). But since the
> regression still exists, even with both patches applied, the old fix
> must be reapplied to resolve the current regression.
>
> But, as you've requested, I have tested 6.7.1 + d6e035aad6c0 + revert
> 0de40f76d567 and it seems fine. So I have no issue if you think it
> makes sense to accept d6e035aad6c0 on its own, even though it would
> break up the pair of commits.

Thanks for running the test!

>
> > OTOH, I am not able to reproduce the issue. Could you please help
> > get more information:
> >   cat /proc/mdstat
>
> Here is /proc/mdstat from one of the systems where I can reproduce it:
>
>     $ cat /proc/mdstat
>     Personalities : [raid6] [raid5] [raid4]
>     md0 : active raid5 dm-0[4](J) sdc[3] sda[0] sdb[1]
>           3906764800 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3=
/3] [UUU]
>
>     unused devices: <none>
>
> dm-0 is an LVM logical volume which is backed by an NVMe SSD. The
> others are run-of-the-mill SATA SSDs.
>
> >  profile (perf, etc.) of the md thread
>
> I might need a little more pointing in the direction of what exactly
> to look for and under what conditions (i.e. should I run perf while
> the thread is stuck in the 100% CPU loop? what kind of report should I
> ask perf for?). Also, are there any debug options I could enable in
> the kernel configuration that might help gather more information?
> Maybe something in debugfs? I currently get absolutely no warnings or
> errors in dmesg when the problem occurs.

This appears the md thread hit some infinite loop, so I would like to
know what it is doing. We can probably get the information with the
perf tool, something like:

perf record -a
perf report

Thanks,
Song

