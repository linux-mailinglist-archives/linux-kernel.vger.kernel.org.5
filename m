Return-Path: <linux-kernel+bounces-36199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D351A839D67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7046E1F26D27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6279D54FB4;
	Tue, 23 Jan 2024 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGRqu58n"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EC54BD0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053954; cv=none; b=jew2ICbily/K4Hkv/vzpnDwDiMIdbTQ2IV8YCg5fLE9Rj+J34fXsJVrYHzlAu8BsHV6/zfsk7D3r6A8K5vOftixrTfXoLx4kpwGkfaq4ckQRpTgIUKQ8WeqS8hPFz8hEwhImZNc8rlYMa5e4dNeMHbb5LSGu1fkp55UBJzDc+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053954; c=relaxed/simple;
	bh=3L3IL+2D+SMgdaVONy0zP+GHvj410YwKBXkFH6FiJDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI1ysV7r+grDXxzcZJ4BVn/hTkstFgLdxlGZlWbjAh0ctCBPGs8hEQ8HZjOhofoRSkDUDgYzXn4Pn48/XfUHzsLKllcVR4Q3Px1td4C2RHj2HrVn3i6L+WZkLrZmiWg4ZAhYr4lRmG/TQrMZL6f6GYTeeUkMZWeJKwgi6AzpKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGRqu58n; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2142c746270so2096259fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706053952; x=1706658752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvRkL2paV0pbOYNTMneWlAG3SYsPIxZwPdfU91UWToE=;
        b=SGRqu58nxoi+75kHE3mDSx5yDNME71sizjOVuJVl7KMV0+e9YLfw9BQP5RPhGGVqb7
         YBM7OKSUCylU2woaMND833Pv5DSsh/I00UBHiD9TxK2t5J8qxXYzodT/wXzRj2ok/lJG
         ICI2JHeetAyzfFIzdBIBd3uCyt1MqJ8Yx3PxMusvZJzAnFpKLOg42lievT9y3wYPxY2H
         nwSL6cEhYUoi1YG427T29+wtJRGS6wotz0Ygk3WTpOwODls/47MbLiE3rMXDpu0zmYiP
         bRGDSQk+6teuTje9+RhjPNhQ1mID0Fi6kp9NlikQWsUCBxS2ze/8RLq1Kj9SIfdXHJ4r
         lmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053952; x=1706658752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvRkL2paV0pbOYNTMneWlAG3SYsPIxZwPdfU91UWToE=;
        b=ujT2Qo8KsCPxwUvDv1hVz3qJHdCneuNSOOhDq2eBYP0V4XV2+z00xHCKHf1CN5nJMH
         o46a3LnG+JTCKT7uwIJl/ab6KH/zHuHmdxm76ZwKBzXANpf1hpVymMHdUQnCroK8oZF6
         nekIW6/Mlpe2ET+kY/0dzUOoEQhtjRJe6zSJHSBms6LnRRA9o46vKi7YwO2se8QI8XQY
         ouzp7UV3dj7MhPUhNvdumdxbbULMXlNIgT6jYGXUsEarwjtQrg7iiDhZVzbs7iY90sDo
         9V8uHjpe2RVCymYqi24itphm9eKhEoDBWz46aK2LBxoT1kHhy9r8UGBE3RgPFL8mn+Q3
         j4FQ==
X-Gm-Message-State: AOJu0Yz//kDVpf/fYBiGGToT/0TxpwanbdZ5KK+qaUcwFW2ayPfbK3rj
	A8s3nhVGH+cajju3xnhzsq1rDrRB223cFJGah48lFkFksBDys4MyPHlgWrBO7rwRRfZq/4556SH
	t8A0ZQQ9xgsOvMDSoURoi7hpsrXraD8A3V3zdTjS5DKXMmXXuC4lZ
X-Google-Smtp-Source: AGHT+IFq2gwdR80pul+rqMg35HsEdTnFxB76+k9DJJ5gcrUtnSwBAVIDxj7pGEpHRI2zHDw+LjxSsTTgsQvo7NNhlNY=
X-Received: by 2002:a05:6870:1642:b0:214:8233:fd94 with SMTP id
 c2-20020a056870164200b002148233fd94mr2225261oae.12.1706053952140; Tue, 23 Jan
 2024 15:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153313.GA21832@redhat.com> <20240123153359.GA21866@redhat.com>
In-Reply-To: <20240123153359.GA21866@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 23 Jan 2024 15:52:21 -0800
Message-ID: <CADBMgpwhH4VyADf7ajYee=FFhdfwSQF3iAjCHTHWPv5FOoYRPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> After the recent changes nobody use siglock to read the values protected
> by stats_lock, we can kill spin_lock_irq(&current->sighand->siglock) and
> update the comment.
>
> With this patch only __exit_signal() and thread_group_start_cputime() tak=
e
> stats_lock under siglock.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/exit.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 3988a02efaef..dfb963d2f862 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1127,17 +1127,14 @@ static int wait_task_zombie(struct wait_opts *wo,=
 struct task_struct *p)
>                  * and nobody can change them.
>                  *
>                  * psig->stats_lock also protects us from our sub-threads
> -                * which can reap other children at the same time. Until
> -                * we change k_getrusage()-like users to rely on this loc=
k
> -                * we have to take ->siglock as well.
> +                * which can reap other children at the same time.
>                  *
>                  * We use thread_group_cputime_adjusted() to get times fo=
r
>                  * the thread group, which consolidates times for all thr=
eads
>                  * in the group including the group leader.
>                  */
>                 thread_group_cputime_adjusted(p, &tgutime, &tgstime);
> -               spin_lock_irq(&current->sighand->siglock);
> -               write_seqlock(&psig->stats_lock);
> +               write_seqlock_irq(&psig->stats_lock);
>                 psig->cutime +=3D tgutime + sig->cutime;
>                 psig->cstime +=3D tgstime + sig->cstime;
>                 psig->cgtime +=3D task_gtime(p) + sig->gtime + sig->cgtim=
e;
> @@ -1160,8 +1157,7 @@ static int wait_task_zombie(struct wait_opts *wo, s=
truct task_struct *p)
>                         psig->cmaxrss =3D maxrss;
>                 task_io_accounting_add(&psig->ioac, &p->ioac);
>                 task_io_accounting_add(&psig->ioac, &sig->ioac);
> -               write_sequnlock(&psig->stats_lock);
> -               spin_unlock_irq(&current->sighand->siglock);
> +               write_sequnlock_irq(&psig->stats_lock);
>         }
>
>         if (wo->wo_rusage)
> --
> 2.25.1.362.g51ebf55
>

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

