Return-Path: <linux-kernel+bounces-3776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467E8170D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146D71F2330B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4A1D136;
	Mon, 18 Dec 2023 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPrL1kWK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E614F63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d045097b4cso10748695ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702907483; x=1703512283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kOuGoThxLKeU8KPJztSEBC+gX6rgUvRCyfzNnaQssgA=;
        b=EPrL1kWK5xNH89442LNETq4AxhWnl/XA3VIrRaeWts8Stjx5d9U9KdcEmw9E9ZGvE1
         ZdA0koW4GvUWL7mMF/xzLvXHyrLfHimLXJX/ANtMEjR6cbQYLw/mf9NkLkZfLCg0wNd0
         W6vcDUTA3pJ8AXhE/NkbeN3iMd1XDkV7txk5bNK38H2z/VNf2gSV0MsC9LiE9JDwptt3
         NwqXW7bY/vYNYtUhpl7ZNqi/zUyZjw1MRlBYEaBjYeeh6Oy3EQf5r9d8jOeOMEYSkh4J
         OQi25PkR+oyTc7WBvKjv/S5hHZy0kbTaCmUZD6zCXbugiLuBZF3OYfmUnVSQxm198Qgz
         VNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907483; x=1703512283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOuGoThxLKeU8KPJztSEBC+gX6rgUvRCyfzNnaQssgA=;
        b=Q4HmRgAZ2LdGvo0reLeodGJMZlCrDpmShaXhQALSQEcrj3JqBMHQGHQJB4cg23H4xR
         RA5TOk2X1pySGjIC5Tp3pL7FXbFNSa+vWUFwoP3lrv8ufYnE9sKKBBea1simuj394zAR
         XfMY+42jR+8kZ+kHgs9ggluFY97DcG/xbHRPf4SY+fwszRHDfEJdlvnJ6Mv4ymwuw23B
         U6z9OLxCjJOIuI042fyyTHzlnnUK1EwGT8tUGp+3+fDb0PHe4jRACsNAuQZaSgyTh/i1
         QY6msb2tDZhrhEXBwz2JMOq8PhV0xTq1lQufnyYD/98WehzFtwDwDfABk2PWbOfBbTfU
         853Q==
X-Gm-Message-State: AOJu0YzFGX2oRfhatFL8c5NsdEl9SPiR3OVj+MvdM8wLkU4tuR/LTwVk
	W1AGdcPsXrBeZJ8XMFvx6y5sAgDHSmRfneY5mVumSA==
X-Google-Smtp-Source: AGHT+IHtCfeh+xTh6xr7gGytNaWFy0UeWtq80N/kNLJUBvDvnBdMRrV9WNjlJxZ4wQg7k9M1O1DC27/dK406v23Lrow=
X-Received: by 2002:a17:90b:e98:b0:28b:4d2d:5ad6 with SMTP id
 fv24-20020a17090b0e9800b0028b4d2d5ad6mr686805pjb.73.1702907482813; Mon, 18
 Dec 2023 05:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312072018+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312072018+0800-wangjinchao@xfusion.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 18 Dec 2023 14:51:11 +0100
Message-ID: <CAKfTPtD-rRsUr+P-vjzMDcKfx8Vnb_vLxjCOb5ZPvF5g2LpVzw@mail.gmail.com>
Subject: Re: [PATCH] sched/headers: Remove duplicated struct rq declare
To: WangJinchao <wangjinchao@xfusion.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Dec 2023 at 13:20, WangJinchao <wangjinchao@xfusion.com> wrote:
>
> `struct rq` has been declared at the top of the file,
> so remove the second declaration.
>
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/sched.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..349c90554bd8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -931,7 +931,6 @@ struct uclamp_rq {
>  DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>  #endif /* CONFIG_UCLAMP_TASK */
>
> -struct rq;
>  struct balance_callback {
>         struct balance_callback *next;
>         void (*func)(struct rq *rq);
> --
> 2.40.0
>

