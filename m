Return-Path: <linux-kernel+bounces-22856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13782A406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B71C2239C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5674CB4B;
	Wed, 10 Jan 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIewTkGx"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E073A8D8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so1296a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704926218; x=1705531018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3HmJgAPuEK09Q7e5jSckqXU4pVPJKIWB2ghZ8SoogI=;
        b=LIewTkGxiAI07UCL3d26PwuIffbesljWRXH2atKgSqT/WfWu0/QwPTGAzT2I8eYERv
         VjCDEjhkobV2i7KObUpEF+Olo16RW1DNJXUkvPYTkNQisZguj6oTJuzspDeq9V9Cm4de
         OfXS8i8E1sERuM2hDTNGccwiUq+TwuJqqbnMnPB833awIu1Sy3K1Dbp3KwckLgMx5PKH
         E65SnFwswHj681xdJYhJ5L2E2hgJB8BaIznzwsbtGCjqnjcpftrYmrr1rpoY3Ie5CDbE
         mnoBQKZYO9R2Y7EMmvDqmnI0yKQXDY81MeZVLu3ZMMlEa+wbDQv8540loo41cOtElJvd
         r5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926218; x=1705531018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3HmJgAPuEK09Q7e5jSckqXU4pVPJKIWB2ghZ8SoogI=;
        b=p1pOQXXajU4Gjtwue/kFa63f0kgBYWbMGA4A2ffjGrJjOznROWnvGCWQpGSi19WQc2
         CRjwnLi184jQY2i6/OtEsGJLct6oiMQ61bu4cLwYVsRAKN694AhQAJwoaL1yrP+s7qev
         i4nO5U+lAieo89UDTMgq1/fQWlVE7Ur1gAqNNZ19pMRjdtGcv8nXtDSVLcY9TGJ/wCjL
         CWmsAp+ISUnwbmmxSSJPcxNOMmZ67moa1QJUYcsC99XHT+dA6bYqeC7xXEAv7zJKUyF8
         JnPT47lnGi8Y+MXMDhrRe7G3tUj6I8HSqM6RL6fBgTBvzoSJnc+IlxE8zrFuwseSYt/X
         7/AA==
X-Gm-Message-State: AOJu0Yzi/9aDaGTqAoRY1qy+SMklaPAXQ99xX4xJU0MzKVRtsFYMe1NJ
	ZUsLw0AiCiZARbuGPBvKHv06WmWOIyLUPXdjakgDKaBnPwQyViHsGAZQIMuPX2edpYXUPgIY8Yq
	shaQH6bkRNOSfCh3nilTETj7OCUV4Vz1i2eY=
X-Google-Smtp-Source: AGHT+IHOU9h2YCtS0XcSzEnFP/QLy4NHPfMBXiguaVlsaoggd1NlOBwhU9RE9KGQyUjb6p5w3yjdShrkw+IazyqE3uc=
X-Received: by 2002:a05:6402:291d:b0:557:3c8a:7242 with SMTP id
 ee29-20020a056402291d00b005573c8a7242mr29175edb.3.1704926217863; Wed, 10 Jan
 2024 14:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-7-jstultz@google.com>
 <b038f966-95b9-49c6-baa3-f51ef64d5f69@arm.com>
In-Reply-To: <b038f966-95b9-49c6-baa3-f51ef64d5f69@arm.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 10 Jan 2024 14:36:44 -0800
Message-ID: <CANDhNCqQoABvj_MA12u2HEmAHXq1p2C9sHp+UOP_6uOHO0qcQQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/23] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
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

On Thu, Dec 28, 2023 at 7:06=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -908,6 +908,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
> >         If set, automatic NUMA balancing will be enabled if running on =
a NUMA
> >         machine.
> >
> > +config SCHED_PROXY_EXEC
> > +     bool "Proxy Execution"
> > +     default n
> > +     help
> > +       This option enables proxy execution, a mechanism for mutex owni=
ng
> > +       tasks to inherit the scheduling context of higher priority wait=
ers.
> > +
>
> Should `SCHED_PROXY_EXEC` config option be under `Scheduler features` men=
u?

Yeah, that sounds like a nice idea. Done.

Thanks again for the suggestion!
-john

