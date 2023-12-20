Return-Path: <linux-kernel+bounces-7008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A581A077
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA9B21528
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16B374F7;
	Wed, 20 Dec 2023 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPkv28Wo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB037168
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d2350636d6so4923699b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703080753; x=1703685553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMjNlxioD1pET4ojPB/C9RHuhfOqSd6EevGlhbg/m3Q=;
        b=QPkv28WoRu3n93h45wm6ywojDMLSB5cuxODSdwpD9pXCIf0wuQ4zwHcWtcI2aTLpSF
         Y5Kf+PwEAeTCzNjLHYo37A6s5RC9gnRlBk5ay+BqFrz/K567KxGkHWftjh5gjKX4ofQT
         LbeAL8UsXBQR8VpEBMH8CYpNlPr8f+I1xT+25eRP0T59wXq+nXzV2b7pmFTmgpOOGoVJ
         FubIQYNvJP/+TCW8rQfvigS3GLJZij8a0DL4n50kL6mpe73YHmVHYZGULgXDPmIGZfOj
         FT1wtVm8Q1fwgPtRQZivnhb78d3w74sugLicHusFdW7xPATEGj8TMXzWKFcHPAWNvWni
         BdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080753; x=1703685553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMjNlxioD1pET4ojPB/C9RHuhfOqSd6EevGlhbg/m3Q=;
        b=Z/D3vHn+HfbDh3OCT4FGWn/AxSDxryf02BWpQs/1khpMgORDStadHjKYVc+D80epFr
         WJGU8kE2dx3tNagflR6jktkTRvt7QFPTdwa14HAPEAGHnKP5FEqQo+yy+rPsUmKromUo
         es6TuSpTJseZT6a+P0hjQ1Mljh+jT6bFjSTJtMHjQHXsY/XwgFhGW2v16CmxDyaQam9d
         nT7OMMS3BZvPPiqR+KnuNXqvBXhYKuiNNpqN//yao9l3bgV599C4WEd/gdaBKv4QXhpz
         mmx1oGp7nO6kdAoWdIu1TmnBzEvs7fcEvxsVzLkjeZ5KlzCFqrBr4mX7KfycJuER/Lot
         9Djg==
X-Gm-Message-State: AOJu0YzqFLFq6Dr6bodqTK3TdDBkiV8zMutSdA5Z8I4G7OGdUfRGlolA
	8Bi3yX2HGHDk+iQLmKYDpOyRHusBXWyqKh+2ehYq5g==
X-Google-Smtp-Source: AGHT+IEumgAp3E7GLd2o4qCBU+zKXoJ07SmFEpkmbuADqV77auvpzPh1a45S0CdzVU8yYipppWdsLrFz/Ou+Cb2FFyQ=
X-Received: by 2002:aa7:9d1b:0:b0:6d9:6712:f9ed with SMTP id
 k27-20020aa79d1b000000b006d96712f9edmr297610pfp.7.1703080753016; Wed, 20 Dec
 2023 05:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
In-Reply-To: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 20 Dec 2023 14:59:01 +0100
Message-ID: <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com>
Subject: Re: [PATCH] sched: move access of avg_rt and avg_dl into existing
 helper functions
To: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com, yu.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 07:55, Shrikanth Hegde
<sshegde@linux.vnet.ibm.com> wrote:
>
> This is a minor code simplification. There are helper functions called
> cpu_util_dl and cpu_util_rt which gives the average utilization of DL
> and RT respectively. But there are few places in code where these
> variables are used directly.
>
> Instead use the helper function so that code becomes simpler and easy to
> maintain later on.
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..02631060ca7e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9212,19 +9212,17 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
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
>                 return true;
>
> -#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> -       if (READ_ONCE(rq->avg_irq.util_avg))
> +       if (cpu_util_irq(rq))

cpu_util_irq doesn't call READ_ONCE()


>                 return true;
> -#endif
>
>         return false;
>  }
> @@ -9481,8 +9479,8 @@ static unsigned long scale_rt_capacity(int cpu)
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

