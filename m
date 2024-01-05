Return-Path: <linux-kernel+bounces-17484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91CF824E13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29CBBB23E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10053A1;
	Fri,  5 Jan 2024 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT171pWs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56B539C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5097150fso19335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 21:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704432143; x=1705036943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Prv2KfoPdbRkHa0MBG1J/qgAyoY3a84lfxo+6B3V+LE=;
        b=HT171pWsM76bMo37Gdj4eb1OURy5M2a/lGatwInGT+rqxFbCYAnaPqOgSZJvlBNRZZ
         ZidFaXt4MOWGsaJbaLm5JijiC4GzK09FQXaMYfmD1iFmQ++9nCmOfFgJ3Y3MT78mgRPt
         pzABQu7PrfFs97a7KD7g7caukTM3UJYpO4RsvbOEsnfGLsaVok6xyOtm4BvtwHhdZUG/
         yHY/gCYVnRS1qq91uulre9LfuYdnvtT4Rt2VsxpL6rn+YZ1lxuprClDFH/WSyuCItGDi
         cqR9JT8wj6b47dYjsmIsfOnROYOSyDU01EFV9hIy6PZK9+RdnIhUT0VmfY37jKuQ89Mg
         ZO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704432143; x=1705036943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Prv2KfoPdbRkHa0MBG1J/qgAyoY3a84lfxo+6B3V+LE=;
        b=pBpabO+Ry4eS0npquuZh9gnosELLXWdFa2HOLegIdMuZYssQqcoLTs47UtRJ1HL28c
         ST89VmeKzAsifHyYAIFfaVOs+neb2CnXZh9eLP5oIzlUC9AG0j4gPGIJGt0HcwJvPFXt
         jkMuiEZzswW4rHZtFNe33BqaJomP3+PbSa0vuzdoMMfTW14bxsNwoYboJCp9bl36N0ys
         xEuCqgHNw8/C2GLYfSj/YgQgFmy4GfwnLgYYg466XNndw+ZIVTp9L+3Q+4NWgaiYN6vf
         fZzN0DI417LQefXcZ2vzZpRL3mRza6LPbwYwW8J/6fKaIj1Srw/f9JUNOIgR3TTUMuNN
         Nrkg==
X-Gm-Message-State: AOJu0Yz7xqo10j4QiBb9ArFaBH9gf/+yNPSJcGVzHK4x2bzO1J6MqAaG
	BM9AsdoYZB/pzDWAjw9lDWqvhK5cnMCWR+xAT/dxPN7R/mQ=
X-Google-Smtp-Source: AGHT+IEwNKKHRm+uTIxVxKB+8Q3FhDpdGsp7Dxf6ZFEW/q+MhkAKaEAcSk0JibWKKmJbWHsgOW0oyVeeX5CnpRw3Or8=
X-Received: by 2002:a05:600c:511c:b0:40d:5af5:3233 with SMTP id
 o28-20020a05600c511c00b0040d5af53233mr94425wms.2.1704432142832; Thu, 04 Jan
 2024 21:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-18-jstultz@google.com>
 <9dbcc5ed-8994-4929-9ac5-18b13c01eb2c@arm.com>
In-Reply-To: <9dbcc5ed-8994-4929-9ac5-18b13c01eb2c@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 4 Jan 2024 21:22:10 -0800
Message-ID: <CANDhNCo_U50+Ov2TzzD+jnDHKms8Wej3ypLsSS6PGNoEier8KQ@mail.gmail.com>
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

On Thu, Dec 28, 2023 at 7:19=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > +static int __init test_sched_football_init(void)
> > +{
> > +     struct task_struct *kth;
> > +     int i;
> > +
> > +     players_per_team =3D num_online_cpus();
> > +
> > +     mutex_low_list =3D kmalloc_array(players_per_team,  sizeof(struct=
 mutex), GFP_ATOMIC);
> > +     mutex_mid_list =3D kmalloc_array(players_per_team,  sizeof(struct=
 mutex), GFP_ATOMIC);
> > +
> > +     for (i =3D 0; i < players_per_team; i++) {
> > +             mutex_init(&mutex_low_list[i]);
> > +             mutex_init(&mutex_mid_list[i]);
> > +     }
> > +
> > +     kth =3D create_fifo_thread(ref_thread, (void *)10, "ref-thread", =
20);
> > +
> > +     return 0;
> > +}
> > +module_init(test_sched_football_init);
>
> Hit `modpost: missing MODULE_LICENSE() in
> kernel/sched/test_sched_football.o` error when I build this module.
>
> JFYI: the module does not have MODULE_NAME(), MODULE_DESCRIPTION(),
> MODULE_AUTHOR(), module_exit(), ... as well.

Good point. I've only been using it as a built-in.
Added all of those except for module_exit() for now, as I don't want
it to be unloaded while the kthreads are running.

thanks
-john

