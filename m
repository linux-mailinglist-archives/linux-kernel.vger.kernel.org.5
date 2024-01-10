Return-Path: <linux-kernel+bounces-22845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E047082A3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A255281AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2D50254;
	Wed, 10 Jan 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tx7vuGA5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913E50242
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5097150fso4495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704925489; x=1705530289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0h3PsV4VSVU0yPwyd2pbqdsw4enf8nEiC2KN4jc7hY=;
        b=Tx7vuGA5iRNsy8tfas7D6V6F3iJdEEtNsqFt6fV7cMsn2hpdBHICB7qWbSZugIm23U
         i6ZrDGkLiZlIe9fSsqVa35aY0IAOKEyFyAN99/xB40UQDS9xa4meVO48ZSYQ/8uLZweq
         ySqcn1QKzfzBAVG8J0VImKMn14R7R08dyxf73kaQacij8zKEuICmxTCI9i2bOgiWLxQR
         2LHxhEYaaDxgutOhdwCQmEu+oztqFvSiru4LG4eLxqEXLLSmr4X7PstJcjyjWPNtIft0
         JI1McXytMl2JgQFpgC8Gb9FMP5/Ug2pBpAsbpZ4GZS7Guu9ZnmCaz/fjZRWXNBKAO79N
         RT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925489; x=1705530289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0h3PsV4VSVU0yPwyd2pbqdsw4enf8nEiC2KN4jc7hY=;
        b=XYgv1Ww/NvoEg3soQgaWHEfShqUB6Syv768KFKkPOMBNWSXdXrfQyfjUjs7JbZQULF
         luKDJqZTjlL5MXZX+gys7odLMKmUIr0JmAsgZcv6zFoVj/IfiGHCYB6vouF5Jgv2D5ja
         L+Z9Orwwj5ZVEjgVaVoLkENZ39d3n7QuFZ7Ihi6RK9TzDePTX00m8q8lnCAVAnhAYm0R
         /Uf/10w/NXvuJo9Y63JfUJNxeQgVrW28QQMD/7SMNi6cU3QBjmKXYhPNLOKQM2vc51Yd
         rEV8n/3wXP5XxEtsxOBi1mRyxB4lMtloPVg6u5M/iM5xB1ENX6GzLuc1EYzll5K/3dMg
         qtmQ==
X-Gm-Message-State: AOJu0Yy2kgyPUdBanush4gpdwasmWhBPhmiTW6IGSEzQYEvedz4F06HE
	JYQ3Zzbxtf3IfKPFZ5+2MRoDE7JihUNu4n25BX2esxGXuVTa0pbfbf90D1C14ZXH/wlY9BUrPV2
	pohySTl3nPsytH2A6HGnGKqUEv7k+9VhYIXg=
X-Google-Smtp-Source: AGHT+IEBX5O5ZsPQ2m9kbqpp1r7L+nI2qqr8MRQ4FFqtOYKab83LNhv4h8spRuPazYChQChpktvIdvxs4azjuV1OCGk=
X-Received: by 2002:a05:600c:3541:b0:40e:47de:97ac with SMTP id
 i1-20020a05600c354100b0040e47de97acmr57984wmq.2.1704925488813; Wed, 10 Jan
 2024 14:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-9-jstultz@google.com>
 <xhsmh7ckqjwuf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh7ckqjwuf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: John Stultz <jstultz@google.com>
Date: Wed, 10 Jan 2024 14:24:36 -0800
Message-ID: <CANDhNCqOcDqJ3kYbVZ-qEBCHBZSC5BkecR0jqh=ssettgr=PSw@mail.gmail.com>
Subject: Re: [PATCH v7 08/23] sched: Split scheduler and execution contexts
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Metin Kaya <Metin.Kaya@arm.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:49=E2=80=AFAM Valentin Schneider <vschneid@redhat.=
com> wrote:
> On 19/12/23 16:18, John Stultz wrote:
> > NOTE: Peter previously mentioned he didn't like the name
> > "rq_selected()", but I've not come up with a better alternative.
> > I'm very open to other name proposals.
> >
>
> I got used to the naming relatively quickly. It "should" be rq_pick()
> (i.e. what did the last pick_next_task() return for that rq), but that
> naming is unfortunately ambiguous (is it doing a pick itself?), so I thin=
k
> "selected" works.

Thanks for that feedback! I guess rq_picked() might be an alternative
to your suggestion of rq_pick(), but selected still sounds better to
me.

thanks
-john

