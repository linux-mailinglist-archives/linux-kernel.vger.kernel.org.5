Return-Path: <linux-kernel+bounces-137669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F689E5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88F0B21D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C2158A3D;
	Tue,  9 Apr 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U46hyaEP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377113E404
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702197; cv=none; b=tpf04z5T96ggV5VKTUlVLYC++sMrBy40Spg+lt6JvgA6LNRaZZnFXq/ZqMOC/O/5IASWaht/ZvJrR2FnomACu15yDGdGdNAs+qpBlcJdQsZHoi7BgdfTgaffbzVOdNlBOqtKYJ5zNDVF1xwECZq9vhCOyqdOKAzYS5nrSBqWd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702197; c=relaxed/simple;
	bh=Yu1dzMK6TYBubE+b7nGo/sZ7OIdPOQ/w/FJZT+3ZnNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re/ythzFcIGsyPN3IQrYqCEr1stZ4XJUeZY4Lk0zPkUhVME3/L0bb/xa2QhZRluBOmZDz4b5bEBHysfKFlhxEyv5145GTdNU2CkWieroZUA2hFbqCEzRQD4BB6BJaMSsgJH9MS/F+hKjUJr1px/AhJWMsJ8tVzSLzFwjG8GXkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U46hyaEP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so13815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712702193; x=1713306993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu1dzMK6TYBubE+b7nGo/sZ7OIdPOQ/w/FJZT+3ZnNY=;
        b=U46hyaEPTxXUCbhPoj+TSsbAWj/VtgrdUB3172mi9vmtwyGILtjSH9wOrIFlfDHgVD
         /W+ihaSW1LYnu9V1E3QGxQiDdzzgLNThhv3cksXnU/07Fjtrvft185rKFLSIsCs5vPWe
         VijabHliPbT9EoYBb8hVZcV0AYZ4hCxP5iOwkGOGE4H2CDLSgkMwrDHSX9iUO1He71uN
         VaI4hWfshviyc+MAIc1lxa6lRKXolqNzJXxbujsYhUs2BOTiILo00TX4y6mpaO4/Pi9k
         65I3Y6BaDa7A9rvV9fG/gmWKUnNjBfc1qpMxsGXuOgfariXVvCS2D2qt+GKKenaA5oCz
         fRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702193; x=1713306993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yu1dzMK6TYBubE+b7nGo/sZ7OIdPOQ/w/FJZT+3ZnNY=;
        b=dBlSgFUTjzIlo0l8oxWJkfJJ0Ex3mbxbn6ib2E6X0hvHqU2AmaMfE5mRpN7OYqog9c
         HUe50IWIMf3UPM1kGNFdIz4MNkwklvP8mGVMsIIu18vaw4Ycfp3xB0rLYFRdcrGF5tCm
         6hMbriXV2/genNH6dtitdxra8hSPW0IqoGLpZPLiT/R7wGyaX4AakSC16su17UnYGM2T
         PfefQCII3RmJUHQtYtdW2WKtM8PCRfhdiLx7MHNBHxJiPSVmrA6DJARb8UqwqRGEkwfg
         OSB8iDfq70XNhs8tb1Hd6VecvIszUisZVmouuKIykN1rTAoh6/3l+jnPJMNB0mPR8+sa
         g9qg==
X-Gm-Message-State: AOJu0YyKMnnY3eoNwX3eNYyVSTq1AxdnwKlXKK944HxIOdiu8vyiR9fA
	yhq4dRGvx6G0YMgev2xfL716/ncQCHtI+whehtvqqF4g7bu2JSmpzm0oAGQcYjQrXEcjfLBRytR
	JwM7A/OcKIF/NX4fUs7pLq8RjeysP1AxZiNg=
X-Google-Smtp-Source: AGHT+IE9rhUOAmHlTDXxZjO+xOTGaeVRVC/7XikhlYN58O1vHhwqPfFajPu8M1jPlMvVGjvYoOwxHUxs2NR19kYVf9c=
X-Received: by 2002:a05:600c:1c95:b0:416:a753:38bd with SMTP id
 k21-20020a05600c1c9500b00416a75338bdmr63367wms.6.1712702193483; Tue, 09 Apr
 2024 15:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com> <20240401234439.834544-5-jstultz@google.com>
 <xhsmh5xwqa48q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh5xwqa48q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: John Stultz <jstultz@google.com>
Date: Tue, 9 Apr 2024 15:36:20 -0700
Message-ID: <CANDhNCr9J4zmXpH5YiNU2DqV5B+2CG0JgnwYq6Mn3Suht5S0ZQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v9 4/7] sched: Add do_push_task helper
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Connor O'Brien" <connoro@google.com>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:30=E2=80=AFAM Valentin Schneider <vschneid@redhat.=
com> wrote:
> Naming nit below notwithstanding:
>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Hey! Thanks so much for taking a look and providing this feedback! I
really appreciate it!

> > +static inline
> > +void do_push_task(struct rq *rq, struct rq *dst_rq, struct task_struct=
 *task)
>
> The naming IMO unfortunately clashes with the hotplug push_task /
> balance_push() stuff.
>
> AFAICT this is move_queued_task() but in a double rq lock
> context. How about move_queued_task_locked()?

Sounds good to me! Changed in my pre-v10 tree.


> Interestingly, all the patched call sites end up with a resched_curr(), b=
ut
> move_queued_task() has wakeup_preempt() instead.

Yeah. I'll look a bit more to see if I can find a way to fold the
resched in as well, and try to make sure I understand the subtle
difference in move_queued_task() - I don't want the name similarity to
confuse if the behavior is different.

Again, thanks so much for the feedback and review!
-john

