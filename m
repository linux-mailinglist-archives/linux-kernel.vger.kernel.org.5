Return-Path: <linux-kernel+bounces-8911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD3481BE14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C531F22B32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535C63517;
	Thu, 21 Dec 2023 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAQ34tOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C4634F5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so1094a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703183020; x=1703787820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji2hJdOh2AMJJzZjAydWcJirZrXR1RsLO+qH+PANSOc=;
        b=rAQ34tOXylN1QgtOwDMs1bnacBzdvfq240g00qbC/Xb1YKCKOVsG6EaQKlBAXpFgiQ
         E300t4yIjSjfbHZmMDnE93sca0mn+/1PFLRv3eUKfYnOw4SYsM0lDVKktWEBIPfUBRel
         ulm5LVuNF+8sL2aGuW4Hk+YR6qEjk8yQqP6sz8+ulLrpoVkYCBs7beROOtMSs68bWh1z
         iQkqPp9lK0cvna9TuXV/l0TM0MOy0FjDqRKxXaIkCKyS1YJeYOz/Dg9yWQCWK5fotofl
         FnmOdfjdlLVDTtSJLV3QlKaLMPRVKLTMnp92U6zZg2EPHTNzuKNLf1gZoSf62OzY6pJv
         jTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183020; x=1703787820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji2hJdOh2AMJJzZjAydWcJirZrXR1RsLO+qH+PANSOc=;
        b=KgKeCJfDgRun9rfDUVnlNUmUzY7+uFyvb3E3lxwaj8ZqlCgDwFpfBa7zujvoM0tpD2
         WhFL/8K6qrj/tlORGmagJ/na4M9+EEX7l+5iaPU+rptUxDyy/7HngK32byJXb2IIkDjv
         /ZgiLdLH2ZShHqVgyyaFhFTInQJZfjH168YYLe2iTI4JCfL9G7HRkyhCoYBz4mdxUX+R
         vo5jWVTeSfbRaJfe2PZtgCXh3yPy3DEUuV1C/Wq1hSIEWSVaiQDmgcoLfImLtNavxqQI
         SFtflBgMSKZahPTjbShJZKTOr9OVk+uktO/SfDukxUvzHIvR615QSsLiOdOY7v9KMRwK
         xsuw==
X-Gm-Message-State: AOJu0YydxY7TbM8v9NvHXE6MWkIeLNftUJYVdPG/oHiVJfn2sA6qpBQC
	7o88ArPhagPkFscCV14Yp/AHD1DQ8VyEcnvbJy2v2WRnk4M=
X-Google-Smtp-Source: AGHT+IGYoyVAH9rP8s/3taTF8wVdnDKhcmaVTocTc4BnvsLSuoqHpbuXXDd/z/qjrkjb4ulv/pvi56pNnXUdCP7IM7s=
X-Received: by 2002:a50:c109:0:b0:551:9870:472 with SMTP id
 l9-20020a50c109000000b0055198700472mr123135edf.1.1703183020025; Thu, 21 Dec
 2023 10:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-9-jstultz@google.com>
 <a76adfd2-a17d-4342-af7e-5d17cf10dab7@arm.com>
In-Reply-To: <a76adfd2-a17d-4342-af7e-5d17cf10dab7@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 10:23:26 -0800
Message-ID: <CANDhNCpZShTa7s6WjeLeCkuLeTPQarqg94jbE2hHTNp=E6t3vQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/23] sched: Split scheduler and execution contexts
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 2:44=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
>
> On 20/12/2023 12:18 am, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Let's define the scheduling context as all the scheduler state
> > in task_struct for the task selected to run, and the execution
> > context as all state required to actually run the task.
> >
> > Currently both are intertwined in task_struct. We want to
> > logically split these such that we can use the scheduling
> > context of the task selected to be scheduled, but use the
> > execution context of a different task to actually be run.
>
> Should we update Documentation/kernel-hacking/hacking.rst (line #348:
> :c:macro:`current`) or another appropriate doc to announce separation of
> scheduling & execution contexts?

So I like this suggestion, but the hacking.rst file feels a little too
general to be getting into the subtleties of scheduler internals.
The splitting of the scheduler context and the execution context
really is just a scheduler detail, as everything else will still deal
just with the execution context as before. So it's really only for
scheduler accounting that we utilize the "rq_selected"  scheduler
context.

Maybe something under Documentation/scheduler/ would be more
appropriate? Though the documents there are all pretty focused on
particular sched classes, and not much on the core logic that is most
affected by this conceptual change. I guess maybe adding
sched-core.txt document might be useful to have for this sort of
detail (though a bit daunting to write from scratch).

thanks
-john

