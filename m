Return-Path: <linux-kernel+bounces-109751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F488553C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136D1282670
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB85812A;
	Thu, 21 Mar 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCPDx2G/"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924941E4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008095; cv=none; b=Cnop12AKAGkL2SWy0g3mBqMnroRsL1VhlikZn1dufX+d1IrIaec0ey53Puoahipsc8ZpGs2I4mZl8zxAu3sant3uKRr5seq01Ue9MYOslHRXNVjQYJUgaKGDmmrDBsF6neitdcBIAWOexs0glCYaKR2jcwuTBSL+csPJ9F21pGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008095; c=relaxed/simple;
	bh=i4zwPJVpXqhU2FAr++17pgpneo/UpWJ6XbYcmX19IAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHky8sbQ2xoE2G2GvXFuoEfxjh9JAXdcnLCt8MbUH2OW3bM9rbLSjocmIPlLi5VBeeajYBNoGBXsTL1hsiywVqcsZf2pkilys95MXG+mam7iPv9TVyIc00zf+bSIV0Tb16SpfSgotWQ+ve4PFk5B5ZR4l96xObaBDsyKhvme07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCPDx2G/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29fb7e52731so549365a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711008093; x=1711612893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FjFrEpsJSPY9n7SWzhe+mZvEerSKreA8nYhpUpSVpXw=;
        b=qCPDx2G/uYqRCtlTfNJ07BJeKjziCw01WNzrkxvQwvhyzLIWMo28UtOA/CHG/BoSe5
         KjePOeZi0GxEDiTXxwbk2zDlTw/irFRPC6LbJMQofEd3wiCahhU60Y8GKsJlDmDY3U9H
         b9TUNTaDfTaIDe3i0O1IPTS6Pwr+JyK0eqroXIEj4uOYVvbcLjDESC9GGZ3+0p1G0NL3
         9F8xxit7qdnprYDDKUIvnyY8xaXpi5JZyTFCn8OwEdSb9SZ4hu8gDw45LuzrYvpeMZtL
         Fkj37ilrx5MMNeIZZj4OkNHFWfyd8PNWG/b/vPk0zrwI9IrgB0d1VZjZR2jhqtYCdamE
         ZxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711008093; x=1711612893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjFrEpsJSPY9n7SWzhe+mZvEerSKreA8nYhpUpSVpXw=;
        b=K/lzSPn2HuZd/Dkl+FJqbRvIHbj1s2XNtbgh3JsA9WGksgKzEVW3xhLeHenI6aUweQ
         I72Y9RZfq/ncBNUtqscFXldstMiDOjWvp/hzpID/wc0MVsvGwYJ5CHiVB0KLz8Vqpq0O
         wMOtan2CdRzrRfcPCDQsBQNxbveDsgca+fPMK5ZmfUVCSx75KJ07b+Ukubi+Tv1P2MYI
         WJg9Har6SjkUAVxgSDZZMD4rg4vQMBNOw9P0yO6BsNaPQyvxukzq6rKwQa6NzML33lEU
         wRYHoNrde8L1lSj8iebgCD4OjoBYyC3waSUNkpTK6zWhmImY+9kKiDlr3Mddx0Ng9ztV
         2BqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpHtLw4k3wXQN8/1IvpvBuU3hMYVf7Ns3wuloJ8paPP1JFyJCT5NGktYfWJsVu+ZU9Z75rZ1FqIPfsSMK1P68Ugdvqhl6fEXCSkBd7
X-Gm-Message-State: AOJu0YyxHu1C2I9RKa7vyZx/jl624aTNffwcJZFpvX0OkAW/fr/Cgzgl
	2gVvVQF1O+3NfesqOiRWC9eY/4zlkrsZZSqSy5YQMGsmempzD7GvOYrJZi31BFc2RjyAZF44Qqz
	+yI92zRZGSHt+TEo+dmHvDzkSQHUwAmm5YMsZHA==
X-Google-Smtp-Source: AGHT+IE66tBwdnEhf50hb3gUZmIFhdYJN3ZVg6mlW83sBuBn2hsQfVGJ3pQgFiGmlp+qWP641zrSHsIszI3n8pq2Djw=
X-Received: by 2002:a17:90a:e384:b0:29c:6fa7:980d with SMTP id
 b4-20020a17090ae38400b0029c6fa7980dmr8584517pjz.6.1711008093132; Thu, 21 Mar
 2024 01:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313150133.1182298-1-sshegde@linux.ibm.com> <20240313150133.1182298-3-sshegde@linux.ibm.com>
In-Reply-To: <20240313150133.1182298-3-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 Mar 2024 09:01:21 +0100
Message-ID: <CAKfTPtCnGRaAcqB6mkVZPP5CzptG-yLO4-mcoaOeHx8ZGPfTvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Use helper functions to access rd->overload
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com, 
	qperret@google.com, yu.c.chen@intel.com, srikar@linux.ibm.com, 
	pierre.gondois@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 16:02, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> rd->overload is accessed at multiple places. Instead it could use helper
> get/set functions. This would make the code more readable and easy to
> maintain.
>
> No change in functionality intended.
>
> Suggested-by: Qais Yousef <qyousef@layalina.io>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c  |  7 ++++---
>  kernel/sched/sched.h | 14 ++++++++++++--
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index eeebadd7d9ae..cee99c93e6a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10621,8 +10621,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>         if (!env->sd->parent) {
>                 /* update overload indicator if we are at root domain */
> -               if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
> -                       WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
> +               if (is_rd_overloaded(env->dst_rq->rd) != (sg_status & SG_OVERLOAD))
> +                       set_rd_overload_status(env->dst_rq->rd,
> +                                              sg_status & SG_OVERLOAD);
>
>                 /* Update over-utilization (tipping point, U >= 0) indicator */
>                 set_rd_overutilized_status(env->dst_rq->rd,
> @@ -12344,7 +12345,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>         rcu_read_lock();
>         sd = rcu_dereference_check_sched_domain(this_rq->sd);
>
> -       if (!READ_ONCE(this_rq->rd->overload) ||
> +       if (!is_rd_overloaded(this_rq->rd) ||
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
>                 if (sd)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 41024c1c49b4..c91eb8811bef 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -918,6 +918,16 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
>  extern void sched_get_rd(struct root_domain *rd);
>  extern void sched_put_rd(struct root_domain *rd);
>
> +static inline int is_rd_overloaded(struct root_domain *rd)
> +{
> +       return READ_ONCE(rd->overload);
> +}
> +
> +static inline void set_rd_overload_status(struct root_domain *rd, int status)
> +{
> +       WRITE_ONCE(rd->overload, status);
> +}
> +
>  #ifdef HAVE_RT_PUSH_IPI
>  extern void rto_push_irq_work_func(struct irq_work *work);
>  #endif
> @@ -2518,8 +2528,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>
>  #ifdef CONFIG_SMP
>         if (prev_nr < 2 && rq->nr_running >= 2) {
> -               if (!READ_ONCE(rq->rd->overload))
> -                       WRITE_ONCE(rq->rd->overload, 1);
> +               if (!is_rd_overloaded(rq->rd))
> +                       set_rd_overload_status(rq->rd, 1);
>         }
>  #endif
>
> --
> 2.39.3
>

