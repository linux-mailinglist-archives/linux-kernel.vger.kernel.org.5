Return-Path: <linux-kernel+bounces-17331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E1824BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EE91F2346A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247812D602;
	Thu,  4 Jan 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GaaRp1H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C22D041
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5097150fso8255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704411198; x=1705015998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJDibVUaFpevfmaTJkLE/J0hqX0EYA1i/4EZEGe4nJQ=;
        b=0GaaRp1Hw4TAYzp1mVN1Wog8F7b1Gonh1uzVJtqpl4UK5zs/lEy4oos5x12L6fycQU
         PooPZdMt6p/nwB8VcBm2NJarDdrYX030zYH5zsrjjG3HbdQTWtM7LWypkVRjdyg2psyq
         rLy3LvrHWlvsb6rWELESXmJcoUkTTMNteuPJkIbGNVlLJ1ixNeYq8q9uuALhVJnHAr4N
         bbuxjQ6KK2JyMTyQBkCwtmeg6rgzMIL1TFQaNUjONz9Wgf4sxvMryh3VB6L9p7UpCBdX
         KQBg8XkMj1U4gL2u1I0Mhr7ljfZto9Mwd8SXM/bF3tclkWHxH42+NLtzjtDHZC8ZFmH5
         NQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704411198; x=1705015998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJDibVUaFpevfmaTJkLE/J0hqX0EYA1i/4EZEGe4nJQ=;
        b=ESycWoU4IDL8ilSp5Txbwb6mjEP/TahAdczdHzHIWs6McXW2wEc2ueoQmsDI6a7F15
         EbFLWmMkDql+yeH/aAFJxChuT01wKIWtQBGIS7Jh3r1PlXScLXyYhHDaBCMHT8FXnBfb
         sOVqjjYxYvDTpwHAm090RuU4Q6rtcI6e/YOxh0CyZluSOcGqO0lO4yYqmHrlWiv5IQ5A
         XNbv1vfqvaWRexczEvF1WbEfB2X7jqN2TcOyoQppu4iwR5XCVqxawVrL0rBpkI+WqK1z
         3l3dRKsuVyUbVjIC9IEuZ42E3nU0ku2RMLZ2vEPRIHET9yoiCKbWdWRPaSfvpg46IWqH
         A10w==
X-Gm-Message-State: AOJu0Yw73yoAAeWFhrnRUB6ojYWw9QQkr5P5OzP1se0zxN8teN/8hCW+
	nW0ToBjBKSDKCKa+p2WGxnxzkn2MvAyWxEkabZGXWtBAlCE=
X-Google-Smtp-Source: AGHT+IH938KSLRaMPxerf1Kx82t+y1lVaL1PLcCTwYuc6EEcb2j3heaSaRRFihrjJpTmgYp2GdVoeR/Y2hlVweex3LQ=
X-Received: by 2002:a05:600c:511c:b0:40d:5af5:3233 with SMTP id
 o28-20020a05600c511c00b0040d5af53233mr65695wms.2.1704411198253; Thu, 04 Jan
 2024 15:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-15-jstultz@google.com>
 <534c73b2-c28c-4e2a-9e6b-a5002c72afe8@arm.com> <20240102153349.GA66858@lorien.usersys.redhat.com>
In-Reply-To: <20240102153349.GA66858@lorien.usersys.redhat.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 15:33:05 -0800
Message-ID: <CANDhNCqaxrtLy70Q_sdFzWV7nt+3yG512my8hLA2DoHJ+ZywZw@mail.gmail.com>
Subject: Re: [PATCH v7 14/23] sched: Handle blocked-waiter migration (and
 return migration)
To: Phil Auld <pauld@redhat.com>
Cc: Metin Kaya <metin.kaya@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
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

On Tue, Jan 2, 2024 at 7:34=E2=80=AFAM Phil Auld <pauld@redhat.com> wrote:
>
> On Thu, Dec 21, 2023 at 04:12:57PM +0000 Metin Kaya wrote:
> > On 20/12/2023 12:18 am, John Stultz wrote:
> > > Add logic to handle migrating a blocked waiter to a remote
> > > cpu where the lock owner is runnable.
> > >
> > > Additionally, as the blocked task may not be able to run
> > > on the remote cpu, add logic to handle return migration once
> > > the waiting task is given the mutex.
> > >
> > > Because tasks may get migrated to where they cannot run,
> > > this patch also modifies the scheduling classes to avoid
> > > sched class migrations on mutex blocked tasks, leaving
> > > proxy() to do the migrations and return migrations.
> >
> > s/proxy/find_proxy_task/
> >
>
> While fixing that paragraph, probably:
>
> s/this patch also modifies/also modify/

Fixed as well. Thanks!
-john

