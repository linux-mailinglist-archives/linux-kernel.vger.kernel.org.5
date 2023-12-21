Return-Path: <linux-kernel+bounces-8823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AA981BCBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E232864A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C43627F4;
	Thu, 21 Dec 2023 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxg3Y9Yz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C39627ED
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so12496a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703178835; x=1703783635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh24iCbFxiwtrROZkpCebfSpqES7hwdYxSjrscwi2QY=;
        b=xxg3Y9YzUZjhL4Zru04FiOBP0/TuViVal4Og2BgTgueuGDg1d/vkqdXENqL/iSZmN0
         zdbW1sEfBgV2xzCTz3hU5wyKWLnKSnPBERQlRZthosQCyJlDbenXMWqzwDegpnV8O7aM
         Fza7KLlnhtTS6Cr4GnidXWyWAvhwhwqG79COryz7XUfU+eFBShmNw5Yn0idyFDcZXcJy
         n/Ca4YS1rbNOB7FjDuQxVxfGcbgUXHTBVmHhjUc4Z9mo4acC8+7ZqCoykIIwDDMxQi8a
         Yslc4xQebZSrHi1VdV/09Ze3GOihIO6wW6Lgofvt4fwBILwZiokiKEvzypOw5wldqxJB
         cX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178835; x=1703783635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh24iCbFxiwtrROZkpCebfSpqES7hwdYxSjrscwi2QY=;
        b=OQydFEIWYW4M40wkAn0ZAaHYjyXhIYyNegcwCgSKn0EpsIK9KtGY9326kGr5GhQPuJ
         f1UOfrclPWd3QFfjQ+BhLoRoS8wcLg8k/d+Rt20MtD+Z1axVALpwN2DCbzAlqIJrsbN5
         lbCaZ/gFb56MwfNuWAu9ZMtVq0hnIZpsC4FpOWwkvkrDPq4qhrgnY7siqdK9ZFyfs698
         6ihAvqvZSu917H/qq/bML4iOpMX/LxVo9A8rgW0zVgVh7VAegjraaB2IrWe7EwYzHR2X
         VPvE9ufoNY0QAYOP/9IyGZFI+5i+IhXgJkR1A05g1BBx5pC25c8gxVXM31liz3GxQ5Ln
         KSNw==
X-Gm-Message-State: AOJu0Yz5aDyce/u5h1ImeFYivlPMJSEsdPx5D2tN4EHlbcsyzmYjAZRA
	99XFTOd3iLq4hp2XfTVVJC1xR8BUYCLvtCzl9xtfOBLaojY=
X-Google-Smtp-Source: AGHT+IHArRhSTAh12qj6uTyw3xGzBKCiLKvnnKgDb3eCRIaFWKpUfWyPi2Ki3Nk4xYpyIEOAGzxKJumcPm+t/g1lZHc=
X-Received: by 2002:a50:c08a:0:b0:554:1b1c:72c4 with SMTP id
 k10-20020a50c08a000000b005541b1c72c4mr116205edf.1.1703178834637; Thu, 21 Dec
 2023 09:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <2b4bb9ce-fe92-47fe-9185-e29571502ae9@arm.com>
In-Reply-To: <2b4bb9ce-fe92-47fe-9185-e29571502ae9@arm.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 09:13:42 -0800
Message-ID: <CANDhNCrHd+5twWVNqBAhVLfhMhkiO0KjxXBmwVgaCD4kAyFyWw@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] Proxy Execution: A generalized form of Priority
 Inheritance v7
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

On Thu, Dec 21, 2023 at 12:35=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wr=
ote:
> On 20/12/2023 12:18 am, John Stultz wrote:
> >
> > As Connor outlined in a previous submission of this patch series,
>
> Nit: Better to have a reference to Connor's patch series (i.e.,
> https://lore.kernel.org/lkml/20221003214501.2050087-1-connoro@google.com/=
)
> here?

Yes, thank you for providing the link!


> > * As discussed at OSPM[5], I like to split pick_next_task() up
> >    into two phases selecting and setting the next tasks, as
> >    currently pick_next_task() assumes the returned task will be
> >    run which results in various side-effects in sched class logic
> >    when it=E2=80=99s run. I tried to take a pass at this earlier, but
> >    it=E2=80=99s hairy and lower on the priority list for now.
>
> Do you think we should mention virtual runqueue idea and adding trace
> points to measure task migration times? They are not "open issues", but
> kind of to-do items in the agenda.
>

I appreciate you bringing those up. The virtual runqueue idea is still
a bit handwavy, but the trace points are a good item for the TODO.
Apologies for missing it, as you suggested it just the other day as I
was prepping these patches, and I didn't go back to add it here in the
cover letter.

thanks
-john

