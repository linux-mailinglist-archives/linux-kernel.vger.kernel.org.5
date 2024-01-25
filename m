Return-Path: <linux-kernel+bounces-39050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E283CA40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69111C24DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB7131E2F;
	Thu, 25 Jan 2024 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mg2hZQtq"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539081E861
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204667; cv=none; b=czvNcb9lPmVUVFCakyO9qcSMcmYcOxvhy2bb4l0hLCMmgp91eMnxCojHRjhV74lMxqN67VHFZMuSXgwSdHtpe+JXThbDWSTTUlU2y5GSbNMkyoxAfa4o3vWAJnLnkNq5gq06h3OOeELmkdoQK4JVEVKxVzLZcPuaHLYm2AZCfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204667; c=relaxed/simple;
	bh=tjPfDUpseeEonRNynpV+LoJ4m0AXS1x1V40LUzBpalg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpX+1KLtAYzzx9wEEwYQ3qGddcYMjjITsiyI/oeXcnVPOsrQ5Xb+J7EZZaFupJGWs1JJ9PsExQj0yXA2QE7VgcuDS+kxtUF+VqM7JTDL8AwaMOh/NVWcLwSqjKY4w4IL7+1r/57IGsHiRz7lpz+s8Da9R9fB5szrFfA5ZpTRQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mg2hZQtq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c66b093b86so709723a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706204665; x=1706809465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvk8W9882Lam2bRB3cQpOZgivCaHjqfd28pX1k9iQeo=;
        b=Mg2hZQtqY7FfBGr59lGKaq4BUyRdx9Foiya0J2V7UirRxDynOz5aUxbHkqnHYujphX
         5EPoyW/+x0B8UndVuR2h2ZSMVwvBG/RdbEqIB/OP7ikwXWm8QB0Bm5v5L+6+vXkeMA2H
         yb07VpETtv7rh+QpS/esxrnbMzFRiU2BDisIobFrWinSukw54cC/wp35HwKZQmgDpBMD
         wCh2o52kALv8BTJdX9luGjZ0Q8orDFZSElcEuG41WdIDuozGwNAQ7gP0BjBgf/faQSHj
         PURWv4wGlFiIg0QmvMOh1jk9RSz2Hfb8NmWLw3lD/cOk8s2A6ud/P37Zz6nKHINuXxHU
         7+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706204665; x=1706809465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vvk8W9882Lam2bRB3cQpOZgivCaHjqfd28pX1k9iQeo=;
        b=d8BS+kpl2YhsfjgFfUUomHfuUZBAjtG36X/DwKOQj0QbBp3/x2ceO8UzbZCGgvWGHG
         InZtxkjYQ1uFDSc0tzrVmTQEWgwQlCk9JVaK/D2zqngptg/7WH4Ugwf/KzmgQf5bRW0t
         gKTr4izopXgh70ehITVwl62kpzo7W2qnveqpe3YysADnOXi/IBlzimRFXrfGLUtr83oj
         1TBrjPZQr1hHiyocups4rmt+M918ZQ9w8GhqXX51aaNMKO67H+EbZI6RfoJ88lZ8Vq43
         ujBo60Pt0l7LGs40ZtK647NCMCO+iVqSkstZzisuOnoHVryU+sgiow3W5lsRlu3TC/Fj
         FRpQ==
X-Gm-Message-State: AOJu0Yx08YlHO4RrVlE3EgQB2Ov7685fzvI8r9b9AUt4xxE07g6yUEAU
	6CCn94KXR8nhoqMZvTmBUwyutrgunhq2BHx2d9Ie0aIlfMtKbUrLEl7MMdbDwWS7JXl0cbDhY60
	MbT/k1Ds+HJaocg6tbocZxXHC/TrZfPEfBq0VAQ==
X-Google-Smtp-Source: AGHT+IHfHonkTtkTWlL6GYoGsUhbmr9AYoC0XOgZpYtHPtbLgFrAYyzy5Mj/wDRBWsMXJBlVuaC+11JO7JGCnUaLBX4=
X-Received: by 2002:a05:6a20:4c9b:b0:19b:4eec:cbd9 with SMTP id
 fq27-20020a056a204c9b00b0019b4eeccbd9mr146530pzb.42.1706204665636; Thu, 25
 Jan 2024 09:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com> <CAKfTPtCfYcD_zPr7PqgL5hRYny=n3KW8hr6GY8q7zkoyRN7gQg@mail.gmail.com>
 <20240124224616.wcrexeb2evkugbak@airbuntu>
In-Reply-To: <20240124224616.wcrexeb2evkugbak@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Jan 2024 18:44:14 +0100
Message-ID: <CAKfTPtDnxsOS0je9DgMc5ZCLPXA6QRLz14t6o_ht7rvxbAbc9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 23:46, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/23/24 09:32, Vincent Guittot wrote:
>
> > > > @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> > > >   */
> > > >  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> > > >  {
> > > > -     return rq->misfit_task_load &&
> > > > -             (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> > > > -              check_cpu_capacity(rq, sd));
> > > > +     return rq->misfit_task_load && check_cpu_capacity(rq, sd);

Coming back to this:
With your change above, misfit can't kick an idle load balance and
must wait for the cpu capacity being noticeably reduced by something
else

> > >
> > > You removed 'arch_scale_cpu_capacity(rq->cpu) <
> > > rq->rd->max_cpu_capacity' here. Why? I can see that with the standard
> > > setup (max CPU capacity equal 1024) which is what we probably use 100%
> > > of the time now. It might get useful again when Vincent will introduce
> > > his 'user space system pressure' implementation?
> >
> > That's interesting because I'm doing the opposite in the user space
> > system pressure that I'm preparing:
> > I keep something similar to (arch_scale_cpu_capacity(rq->cpu) <
> > rq->rd->max_cpu_capacity but I remove check_cpu_capacity(rq, sd) which
> > seems to be useless because it's already used earlier in
> > nohz_balancer_kick()
>
> Okay. I need to look at your patches anyway. I can potentially rebase on top of
> your series.
>
>
> Cheers
>
> --
> Qais Yousef

