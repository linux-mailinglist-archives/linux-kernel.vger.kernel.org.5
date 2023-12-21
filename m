Return-Path: <linux-kernel+bounces-8951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26481BE77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3931C24123
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F664ABD;
	Thu, 21 Dec 2023 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNsjcuiO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57084627F7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso7455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703184574; x=1703789374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjixayZMz+gHhsUfeAVKiE5k7f8w0LYxdYgUulEFxUg=;
        b=iNsjcuiOXWVM77vST/pZMvfMMhqXAAqiMRBeLwtPX2KJzJSDJ+5COKy1D1xN2eO6eQ
         j5r/KOFROCrUIVhs0zNjwYMrEsX5XTgE7cAqO0sSxwYYNNMAwGxDDaLSwuI8Yn32SThs
         OJmRmcfoFu4Pf3FgTsCh95W3J4TRPR+J5mLYTHWoVjCBYNK8luSh+KAlapXvVLUyldw7
         Gaah5bY81r02wAI32gG0W+fM0VezFN9Rk+H9SjHn0N2VMr/ICwDgj0j/J6lnt03kxT7+
         fg5hqL9PA+BjlaqNiOpg0CGqKczITJ6udS0mStg35rR0cc0WVx4KndvAU3vN8FVAbBDr
         yW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184574; x=1703789374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjixayZMz+gHhsUfeAVKiE5k7f8w0LYxdYgUulEFxUg=;
        b=K3u/q21Ag1V2nlKot6i2284I9TP5ahD/z/VM/zX4rK1zC+hRPR9o2trxo19sCqMfVt
         Bt/I/r5/A1uYndSBudoK63/Xkx/FDyHPi3RAl7lkTjqYpdE4Lm96sxFExShSrn0rKo7G
         80XXnhKj6ZEWD4tuAC41QW6XZYX7IcSuA+ieQWaW2spB0LMh3jXd1XqLvM8zK6JEfMm3
         fleuvpDmzCyLX6vqmC3CkvLLO5SyPbwtXglb+2QSH+kLMM2MqGL1xF3T/Vzn8huMBlIx
         U3j/zkrYE01+RsjIilneRhwBcPmhhG8Lxx71BkksMRqSUbeMcXFc+30Gp2uis1ZyFtgT
         nG/g==
X-Gm-Message-State: AOJu0Yyzl8u/TlCQSMYFoWOcsVhrFVwjlNmL4QPutrlQkJwCuG6KFomf
	jZa6IQqjubVE61jKA79TKpdPBSwlqorFOObinbeNTAg/Tk8=
X-Google-Smtp-Source: AGHT+IEUCJ08itRpB7uvjHjSHTXUDFpUJfElU1oICZsNN9GDuzVINo12wdzP0IBeh+V0adZ8cqOyfJjzKNAhtmifB5k=
X-Received: by 2002:a05:600c:3b1b:b0:40d:3f65:7e8b with SMTP id
 m27-20020a05600c3b1b00b0040d3f657e8bmr437wms.1.1703184574409; Thu, 21 Dec
 2023 10:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-11-jstultz@google.com>
 <d029fafd-658a-44ec-872d-62370c6422d7@arm.com>
In-Reply-To: <d029fafd-658a-44ec-872d-62370c6422d7@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 10:49:21 -0800
Message-ID: <CANDhNCpsCNwnNLYJgtxxPnSLeJP+BO3xP3wryA2_LjVcm0znfA@mail.gmail.com>
Subject: Re: [PATCH v7 10/23] sched: Split out __sched() deactivate task logic
 into a helper
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 4:30=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
>
> On 20/12/2023 12:18 am, John Stultz wrote:
> > As we're going to re-use the deactivation logic,
> > split it into a helper.
> >
>
> * Better to have a comment (e.g., in which conditions
> try_to_deactivate_task() returns true or false) here.

Ah, good point. I've added a comment to address this.

> * try_to_deactivate_task() is temporarily used by 2 commits in the patch
> set (i.e., it's only called by __schedule() just like in this patch at
> the end of the series). However, it's nice to make that big
> __scheduler() function a bit modular as we discussed off-list. So,
> should we move this function out of the Proxy Execution patch set to get
> it merged independently?

Yeah. I add and later remove the proxy_deactivate() function as it
goes unused, but I am thinking about keeping it to handle the case
where if the blocked on chains are too long, and we're spending too
much time re-running find_proxy_task() - where we should probably just
deactivate the selected task and move on.  But for now, you're right.

The suggestion of just the initial step of splitting the logic out
(probably make it a void function because the remaining usage in
__schedule() doesn't care about the result) is a good one, so I'll
rework it this way and send it separately (along with other early
patches Qais suggested).

thanks
-john

