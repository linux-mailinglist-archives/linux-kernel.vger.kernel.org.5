Return-Path: <linux-kernel+bounces-16787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A58243CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DE1F24763
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99756225CD;
	Thu,  4 Jan 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ze6JRXNu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C0225A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso349790a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704378473; x=1704983273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlDNdLgG5ibL0gOyrViS7ps98MSZFg5ogqetKbBuLvU=;
        b=ze6JRXNu8h4e79QNoCUrmA376CL9Yg0a/MtGOvLGKP/XZfrkJaypWwPZPv8IThbYZn
         UAqUq0DEjeTfwmpBW1wACMDw7tQUR0u0hhusJmVc+9jsZ266igEJMUdjWBNka2J3QjSM
         A0+LtJSB7zYXB3G+1LiO7t6NaDZ13YFpMgmMz8Gap3Dvj8CcYT2krXu2JW9VPI0WRGpQ
         z6DWpZa5XP9LLGVw4mdlf93PVisHMIGycJH9zT/tYJC/msMHV+7ZlYRl2pIEkNy8TLKL
         z+zgf2uXx/GumC3eVl9fPhnNtfoMo8nz3S1P/NG+prW+emh2BMdz2Or4SEkEvAjG+Lcr
         sv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378473; x=1704983273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlDNdLgG5ibL0gOyrViS7ps98MSZFg5ogqetKbBuLvU=;
        b=YDpqHM6uEywPTGqIoRyQMYUPGUFbclteMUU86u2ywRypLUAuFMjH0Y4FO6HYERcOXO
         9jLZBCmp4HK7PsAwB6m5Id/+bX3NRMzXrUiH8HxSaakdsWkyKKkkHo6abtJPRN/HMmzp
         +9EViPONhWSMQy0fRjsrA76nMWDEe1/5v+8bgmM9mo5wyvEjgSkH1OwKRX2mfbMdFxKj
         i67PmGI9hEB15N/vudu1rLvwPwbh/PyLfTTCZphr8xmchpQMUSWMVINuLxZ2eMf1sVnZ
         sqCJ+UpzNV83Rw49CFb8YXoq7S+BWTrZtth2ib6Qprc5mRmOFhm1WvS7EdkPiQSDodt4
         rUhA==
X-Gm-Message-State: AOJu0YzAy/zw6IkCxUVxzzatRlWFKebUcNUW/iySljY1k8Q0eDAnIRLl
	i8Ts40Z8rNHMvNRQM8o24UbfugQKCX1uhFPG49mER1fgvhOJzA==
X-Google-Smtp-Source: AGHT+IGqvkW6yeaNT+Y7OY+dO+PH6KMDKkNWkiq98aqn0UvOwKKiSD9Z6AiaRMINEuA90J/MiNKP3flBsgcm0JdZv9I=
X-Received: by 2002:a17:90b:4c4b:b0:286:6cc1:5fde with SMTP id
 np11-20020a17090b4c4b00b002866cc15fdemr512285pjb.97.1704378473558; Thu, 04
 Jan 2024 06:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101154624.100981-1-sshegde@linux.vnet.ibm.com> <20240101154624.100981-2-sshegde@linux.vnet.ibm.com>
In-Reply-To: <20240101154624.100981-2-sshegde@linux.vnet.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jan 2024 15:27:42 +0100
Message-ID: <CAKfTPtDU1osT2NF8p0BDSXBdp4Qjwkt6mBQEaA9oHVd+O8zYGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched: use existing helper functions to access
 ->avg_rt and ->avg_dl
To: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com, yu.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jan 2024 at 16:49, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>
> There are helper functions called cpu_util_dl and cpu_util_rt which gives
> the average utilization of DL and RT respectively. But there are few
> places in code where these variables are used directly.
>
> Instead use the helper function so that code becomes simpler and easy to
> maintain later on. This patch doesn't intend any functional changes.
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..1aeca3f943a8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9212,10 +9212,10 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>
>  static inline bool others_have_blocked(struct rq *rq)
>  {
> -       if (READ_ONCE(rq->avg_rt.util_avg))
> +       if (cpu_util_rt(rq))
>                 return true;
>
> -       if (READ_ONCE(rq->avg_dl.util_avg))
> +       if (cpu_util_dl(rq))
>                 return true;
>
>         if (thermal_load_avg(rq))
> @@ -9481,8 +9481,8 @@ static unsigned long scale_rt_capacity(int cpu)
>          * avg_thermal.load_avg tracks thermal pressure and the weighted
>          * average uses the actual delta max capacity(load).
>          */
> -       used = READ_ONCE(rq->avg_rt.util_avg);
> -       used += READ_ONCE(rq->avg_dl.util_avg);
> +       used = cpu_util_rt(rq);
> +       used += cpu_util_dl(rq);
>         used += thermal_load_avg(rq);
>
>         if (unlikely(used >= max))
> --
> 2.39.3
>

