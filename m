Return-Path: <linux-kernel+bounces-72482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431E85B40D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350CC281358
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33E5A783;
	Tue, 20 Feb 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSe83qHl"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955052D79D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414428; cv=none; b=VkBF0homiKkwQ5Kw+s+NN/OwNyhr/38IaIj/bBhk0tDnA3CLnOxQd4UwYcO6HThRlkbrqeQo7SpS7DUqwRefmiYZYoXLmwQcb3p0mkYJ0rlG86Emo8mOpFrlW2pKbHmxR04qWZKtt/9l5Rgfjsq3JhU6NyIWTmAS/+5nYNmVg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414428; c=relaxed/simple;
	bh=gXDvV6ZXXMBqmPgURlBl8TrIV2CHccnufrRAQwQy6GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWK3hRmfmVVlnv6+ANjr88r4pYnEKln5fzoUo/TaLJAGyoWbVK2IUtrhr7qLuhf/VRjzeXE8Sen5GJaRoBq/akY2GVQvHTjYqW3PNkoO2RJlnDUrI1g/lVUAB/RWLkKG7+jcGAxKutj1TG7/bV+rMBEQGBrO+iEQROc7SOP9rtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSe83qHl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2999329dfe7so1657306a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708414426; x=1709019226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsenoJ7EMCFSDYF3hHTZ5Kjc4dQDNAVYOwwzOKqMxdA=;
        b=kSe83qHlChxhxvOM8k1RmbibxbDZXqcORdNablyxGLPjMihyKNZeeTRNZQu0s65HB6
         LXnulA5xbbAx/vnz+OgbkRIenRCp03JiRuI9J4E0WzQBhCAse/bh/IXy2xilvIiQrCa1
         DoVXhFV9Mqrohrw+kl98IahUyqE+3iRI/J+F0WEoVNuepGsV8PVxDd4bgxfwm4jiWopk
         iB0h2Ab3Eg9WagnVvReO3kF1wEMgswGIgiT4oGi38kqCNZamsujq5pDxOzZP2rkfg3Or
         3etXxDRBuiS6d1PUmq0SADAetZajM0QOCvZoSohPIgv6mc4uxU2X+DOamO9/ptSEqa1y
         +Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414426; x=1709019226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsenoJ7EMCFSDYF3hHTZ5Kjc4dQDNAVYOwwzOKqMxdA=;
        b=P5+TYrVPH6tuJHmTcSouePa47vVusj87+3x/jEKQ83zkXFhWuo3QHGBV8+uS2sVmu1
         tubZ9MaNrt57QzxtLsQMg2Bnu3x90K/Kdgv7+6c90Gqi6tHWMor86n17t3dar+rdgRqp
         JDL2xjYrqmbROde8DG2kU0akBVTzQaYiMaig10fJo4pfoYXZU3ZW2RoSgpzAKmDh4c1M
         M8cY7ttHt6im/jaAKkRtqfoJ8FHHb4b3aodLC2se05+SsBOR0LCrLg63Y2K2aBt5MP/c
         5shl4qyY+BAAJC/ALiEvgNOOHvytQc0D4M8/LM7Zv5hrQwzkVtMxJAmqQe8PFQ10Ph9/
         0t1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4mf4oO4t5lU5MgqaBpk4md7tqlEe4zYFJ1l7lGvsb/LhuNp24/Y6oouEu48h8GzMgES7Xq23wDh4Oo9yew2xyJm/Vw3Ln8+oW+VAq
X-Gm-Message-State: AOJu0YxQDctDCcgEi6qBOjJNGrFFuUDcmyTlCZP2qLiOy6i6UxoluynB
	oDLt9n23el6snOkTkAyVfNZkza8Tf02o9O7heTS2f6915MX1fY+2FrLLY4GFWhTlu4RPIt7QHsa
	/7jt9wu9SPT2JmaiwYkdF1/UQt3Q=
X-Google-Smtp-Source: AGHT+IHMNUIQRPRFIANoPeiBmbYLMsMQLt+tkvba7nY6cjzK43sPcjINZKOlh+h5FJ1Km+jgg9teAQRd8mKNVFDoOuQ=
X-Received: by 2002:a17:90a:b014:b0:299:6e88:7b6a with SMTP id
 x20-20020a17090ab01400b002996e887b6amr6036719pjq.36.1708414425900; Mon, 19
 Feb 2024 23:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <20240216180559.208276-17-tj@kernel.org>
In-Reply-To: <20240216180559.208276-17-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 20 Feb 2024 15:33:34 +0800
Message-ID: <CAJhGHyBR6up3o9Svxn=uL2a0rRcu-q3BR8TgdpLykR6iTZ3Aew@mail.gmail.com>
Subject: Re: [PATCH 16/17] workqueue: Allow cancel_work_sync() and
 disable_work() from atomic contexts on BH work items
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Sat, Feb 17, 2024 at 2:06=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> @@ -4072,7 +4070,32 @@ static bool __flush_work(struct work_struct *work,=
 bool from_cancel)
>         if (!pool)
>                 return false;
>
> -       wait_for_completion(&barr.done);
> +       if ((pool->flags & POOL_BH) && from_cancel) {

pool pointer might be invalid here, please check POOL_BH before
rcu_read_unlock()
or move rcu_read_unlock() here, or use "*work_data_bits(work) & WORK_OFFQ_B=
H".

> +               /*
> +                * We're flushing a BH work item which is being canceled.=
 It
> +                * must have been executing during start_flush_work() and=
 can't
> +                * currently be queued. If @work is still executing, we k=
now it
> +                * is running in the BH context and thus can be busy-wait=
ed.
> +                *
> +                * On RT, prevent a live lock when current preempted soft
> +                * interrupt processing or prevents ksoftirqd from runnin=
g by
> +                * keeping flipping BH. If the tasklet runs on a differen=
t CPU
> +                * then this has no effect other than doing the BH
> +                * disable/enable dance for nothing. This is copied from
> +                * kernel/softirq.c::tasklet_unlock_spin_wait().
> +                */

s/tasklet/BH work/g

Although the comment is copied from kernel/softirq.c, but I can't
envision what the scenario is when the current task
"prevents ksoftirqd from running by keeping flipping BH"
since the @work is still executing or the tasklet is running.


> +               while (!try_wait_for_completion(&barr.done)) {
> +                       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +                               local_bh_disable();
> +                               local_bh_enable();
> +                       } else {
> +                               cpu_relax();
> +                       }
> +               }
> +       } else {
> +               wait_for_completion(&barr.done);
> +       }
> +
>         destroy_work_on_stack(&barr.work);
>         return true;
>  }
> @@ -4090,6 +4113,7 @@ static bool __flush_work(struct work_struct *work, =
bool from_cancel)
>   */
>  bool flush_work(struct work_struct *work)
>  {
> +       might_sleep();
>         return __flush_work(work, false);
>  }
>  EXPORT_SYMBOL_GPL(flush_work);
> @@ -4179,6 +4203,11 @@ static bool __cancel_work_sync(struct work_struct =
*work, u32 cflags)
>
>         ret =3D __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
>
> +       if (*work_data_bits(work) & WORK_OFFQ_BH)
> +               WARN_ON_ONCE(in_hardirq());

When !PREEMPT_RT, this check is sufficient.

But when PREEMP_RT, it should be only in the contexts that allow
local_bh_disable() for synching a BH work, although I'm not sure
what check code is proper.

In PREEMPT_RT, local_bh_disable() is disallowed in not only hardirq
context but also !preemptible() context (I'm not sure about it).

__local_bh_disable_ip() (PREEMP_RT version) doesn't contain
full check except for "WARN_ON_ONCE(in_hardirq())" either.

Since the check is just for debugging, I'm OK with the current check.

Thanks
Lai

