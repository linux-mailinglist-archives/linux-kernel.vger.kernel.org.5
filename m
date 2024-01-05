Return-Path: <linux-kernel+bounces-17487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21C824E1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B351C2177F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39E25CBE;
	Fri,  5 Jan 2024 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U42uRu5r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A6567F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d41a32effso36925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 21:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704432318; x=1705037118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv7U/XmCCy2HtcYRxCLd5apAKdcejpGbOlD1Q6DvWrs=;
        b=U42uRu5rx1k/TMwqHZXnc57WDQ7W11GAEr8uRWVv+hsg0RffqIU7oSbpHezl93FIR/
         BJESSU7lJuZPs0WXDt5vGTd/gOc96FG9OXYIrUhrltvcOJvDLsbo3Xbnf9fUfJ2xMDRz
         tLIoIabV1y871vkaSHzi2BUn8NaKmwqReRk/amLNThSzwEosYjKFYVgWYUPCVy9aCXVB
         uHesSIjnWABcbpJ85CANfVTXl1np+u6glx+Hxjjor7f6gFQFFc52PqagEJuijs2dsXIm
         fjGnZrEZEzdQdCg4YIwJrCUAfAP9hMPFWpnvQ+BimD2FQC3tWIFLhhGZOrAYX+6S7hiR
         hPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704432318; x=1705037118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv7U/XmCCy2HtcYRxCLd5apAKdcejpGbOlD1Q6DvWrs=;
        b=PtJZgBieyY7fvEB+n8TzoSedmu3MK+/UT5wSFQQ+kw/eMizBjKd6ppFp8GN2rMiBc2
         L1Eg1Ykw0YMNKhvfkHewIDtdc4nM0BGilp3XVRJrMdBUPgA0Ps+gOtqbXVoCF6p8mhNl
         X63AzxRUtt6z6ItaHrHNPO1Rv6WTWWxKxUjQZxRhDlyzuQW4gckcyxX8PpU3IophUGcn
         UHBjEhEWKSnZvO7rd+ILbD8ZrtCM8d/hjM1CRhtutXJedSHwUX2xflvgqf0UFntdIMEH
         8J6eVtmS+6E91pz+3UyXd/V9TDTJG3Qm46TwdtnIXLINbzQg91tVUEKOnKF1AcCOVAp4
         uk9w==
X-Gm-Message-State: AOJu0Yw0WLC/WAmnG78MUF4dTGXUE9uEygxDwOP/bc9lTxfdj/XYeGTk
	Vqkzr4P67i/GEO2jXOAwL0qP/epHXedtWYmQ07E/0xJIi6dvaem1Y0qAnJpg
X-Google-Smtp-Source: AGHT+IEaQVCa7PEayYwWuqqFyE/A/eEWAQNXxcSuanCzdXX6ISJBOaBTl27JQUNlYVzZz/vYlniGg7yLZ9dYl1jC7d4=
X-Received: by 2002:a05:600c:511c:b0:40d:5af5:3233 with SMTP id
 o28-20020a05600c511c00b0040d5af53233mr94704wms.2.1704432317641; Thu, 04 Jan
 2024 21:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-18-jstultz@google.com>
 <487286b5-72db-4f6b-973e-56d4760ce1ed@arm.com>
In-Reply-To: <487286b5-72db-4f6b-973e-56d4760ce1ed@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 21:25:05 -0800
Message-ID: <CANDhNCrFLfwsmVCSSH0u0WfWCJVy6hWsO8fB3K=n-Wh0awmbNw@mail.gmail.com>
Subject: Re: [PATCH v7 17/23] sched: Initial sched_football test implementation
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

On Thu, Dec 28, 2023 at 8:36=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > +int crazy_fan_thread(void *)
> > +{
> > +     int count =3D 0;
> > +
> > +     atomic_inc(&players_ready);
> > +     while (!READ_ONCE(game_over)) {
> > +             if (kthread_should_stop())
> > +                     break;
> > +             schedule();
> > +             udelay(1000);
> > +             msleep(2);
> > +             count++;
>
> @count is only increased. Is it really necessary?

Nope. Just remnants of earlier debug code.

>
> * Please prepend a prefix to prints to ease capturing the module logs.

Done.

> * I think `rmmod test_sched_football` throws `Device or resource busy`
> error and fails to remove the module because of missing module_exit().

Yep. I'm skipping this for now, but I'll see about adding it later
after I figure out the changes I need to manufacture the problematic
load-balancing condition I'm worried about, as it doesn't seem to
appear on its own so far.

thanks
-john

