Return-Path: <linux-kernel+bounces-16788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DE8243CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD199281615
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B00225A5;
	Thu,  4 Jan 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSDP1dDI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82B224F6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso349210a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704378505; x=1704983305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7b16XJV81Ezx0/hgukH741RGVgLap5mS3dAoiHtIRs=;
        b=SSDP1dDI84NgvVQo/QjIaa0ilRzvU0LNqQXRWjFB37tPPq3wfenWDsMzc69zrKe31x
         7EDZkKzdd0ltFJfS5T2bl+FoXXyekCe71Wlxri8YBn2uHksnW3gMtrnjcES46P4qIkEn
         Vin1dAgkH9HX6uc/Sn3sVDf4IBbLtyti6VBJV5r9p2Lutj5HPcFR+FVp0D9zqE8s4Isk
         QYojI55UalsG3umywjkeUzLT7AoIzP13uz6fA6j7WusBWVQlwvZotajU/cyege9OKkyn
         1v6/nwztCBtKFY7tQDTQ2bRtC6+9Rnz2rulyyu07O1+Aw1j4FpJQtRQdyQz3JDdBgWw2
         oHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378505; x=1704983305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7b16XJV81Ezx0/hgukH741RGVgLap5mS3dAoiHtIRs=;
        b=mUJBFTcxABhVWrZqeOWGtP84JwvjRRT2POGpCcZbH4f+vHZixtT5q3yDKX4QrVyixP
         xKvCAGoSpipP3/20bCUrseFT2lKH3gs5ZlXbEk0QXC/ggOHv+8jbIe/0JER+3Ww+01zf
         mMY5AiRFJhSjG7MxhEkY9b32LsHwlNgIobBhvmYkfxMsnwn4fCJFGEwe9IKCEybSdal3
         mfXiKAoHSOiihknVzY5TisUTpYq+D3u/1ig8yTcPAOp6gmC/re9xtFClnl9MqoYlymvp
         ElHyrTmshsi8jHibwPU3bd0AixEBlqZk262+GQnr1V6W0Wqv+Y+amWS49rvRPOaGVivx
         CLqw==
X-Gm-Message-State: AOJu0YyAqTgyKDOmsTM1rIxef94xhHTPAoBcpllC7vA5G07xkcyjT+aS
	p+8m5kyefx4KnNndMTbh/rf42uINTm8mmpQI6FozLzzqsJzglw==
X-Google-Smtp-Source: AGHT+IHlSjCCDxnrHiMCtyNWIJh4Kgukk1K25FN+dLych69uCF9HO3VQKPCjVMDcSsz3TEiTnJZF9FBt3SWnrWez/3Q=
X-Received: by 2002:a17:90a:4498:b0:28c:61c6:4fe8 with SMTP id
 t24-20020a17090a449800b0028c61c64fe8mr507141pjg.88.1704378504858; Thu, 04 Jan
 2024 06:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101154624.100981-1-sshegde@linux.vnet.ibm.com> <20240101154624.100981-3-sshegde@linux.vnet.ibm.com>
In-Reply-To: <20240101154624.100981-3-sshegde@linux.vnet.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jan 2024 15:28:13 +0100
Message-ID: <CAKfTPtA6tV6hROLisPPE7_cJXUx20y6hFJn3RGeLTiOi7uHDtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched: add READ_ONCE and use existing helper
 function to access ->avg_irq
To: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com, yu.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jan 2024 at 16:47, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>
> Use existing helper function cpu_util_irq instead of referencing it
> directly.
>
> It was noted that avg_irq could be updated by different CPU than the one
> which is trying to access it. avg_irq is updated with WRITE_ONCE. Use
> READ_ONCE to access it in order to avoid any compiler optimizations.
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c  | 4 +---
>  kernel/sched/sched.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1aeca3f943a8..02631060ca7e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9221,10 +9221,8 @@ static inline bool others_have_blocked(struct rq *rq)
>         if (thermal_load_avg(rq))
>                 return true;
>
> -#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> -       if (READ_ONCE(rq->avg_irq.util_avg))
> +       if (cpu_util_irq(rq))
>                 return true;
> -#endif
>
>         return false;
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..edc20c5cc7ce 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3125,7 +3125,7 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  static inline unsigned long cpu_util_irq(struct rq *rq)
>  {
> -       return rq->avg_irq.util_avg;
> +       return READ_ONCE(rq->avg_irq.util_avg);
>  }
>
>  static inline
> --
> 2.39.3
>

