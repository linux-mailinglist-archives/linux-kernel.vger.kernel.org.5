Return-Path: <linux-kernel+bounces-51609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB5848D30
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095611F22364
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665A2230F;
	Sun,  4 Feb 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+cRUsGP"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67502208E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047071; cv=none; b=nCLpTyRB4dISMBsMJ6q0Jet5PUY0INQMpm879zgLfoFa+PqildlbpAaCMbe3tARy5CbZv6QWZuo92jLEQFDkx/uzF/YUZyeph/0+Z/1j7lW8NbZebEMMc4LjWC4orTasRmlfygq/SerBO7SkZ2BTwBUfcdDSV25hZdqiB3enFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047071; c=relaxed/simple;
	bh=FLI71eq9cA+4gsDpM3dr/vmtlO08DEGVbIOczprzopA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6Nt2bBt99JnFfcyTy3aMj+Ks/AooAhzP3/5RxAanC53ei4baEPTK1rWROEZvK70qnCGpnimzSKnsYg9y04sz/FjNHRRQ65FIHrLRdOMZ4o2tFzkeH/gbuo/CRIctF6XcxUfgFfrMKN+Jo9Wl8q0TwrKg4ysUHWV9eaRt70yAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+cRUsGP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-296996743adso24247a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707047069; x=1707651869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+IpDkwBKQbBMHnTLu5Cc5LVxjmmPrWwJkCSxU1oxVK4=;
        b=v+cRUsGPUltaSSuq2M+GXsey8oalYvo8P0l3fOVZzUe3nNZMWOOqbQoySFON99B3HD
         59ip7h7lbX1o3TLGm0ArO21x4oj806d6lFu+fkoKbLWElDGY8ljdC9WDkZTqESZfa91L
         +DQMIQlAsPs5R5iDcyEbfkNKE8lA/QgwXq4eXolqn5jDJowKd31hz8kKP4rvCxo8QSut
         LBhhpsXZppn2uY7mlr6SA61fSmCD2PMR92x4Q6l9ec0qp0Waqu+myTbuhkj9uPEqa4TS
         g0Lb/lj2+6xgDU6069Pwf0r8WUyGoy64E3BSqXOv98sE1ykA20RejChbdW+qdENFaZ+3
         ynVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047069; x=1707651869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IpDkwBKQbBMHnTLu5Cc5LVxjmmPrWwJkCSxU1oxVK4=;
        b=CQ85W/eA49jtE3kHHSeqTZW3rsc8oXd2XY5TejkV2lopQtIwMeoe52Tv10PocRkdL6
         od2tLU9wXDLLrOLzb/2f9judVVKoqs35L3CpXg5naSVN0chCBzfXBsnQAp0jjSiHxWQG
         8EmOKlaugE1qOCSGRo1051MCGKWd7AZNiGicwJJRllAmy90Jyxe5ta6uybs7xsOhCLT9
         tQsfJOA6+pz/dKjVx75PFJXsdOE2314NjkR/H8K3l4dA/eGnv6kS6StCdhwn8RPq/siZ
         I3ilgAqWqdnV02fAsm9b+U7dsvxTg8FabTTxNL633PGloj32V5GEsSrFVTm1cT2EeoaJ
         CbBA==
X-Gm-Message-State: AOJu0YzxyKCDuQEYmrbMgGd4g9riTHrAwigrPiuQ6V0/5mJffBku4Op4
	s8iKto1+KSVt7CUQcePMROctzGiUWlL38yQv+2p1AgDe9byuImMO78lo+XHNlAdNrVb7In9gaN/
	9CRUFWqlgAUvSjiCjkB+TYrFOh1fUykG1SwgvOg==
X-Google-Smtp-Source: AGHT+IFDtvPPma6XvMOlHBOfqCf9LTrIN/Z6tX/n24EGI3QzmbDfB9tHGd4vvhdZFVsIYzuIFRVLcb/gLFcoZqPyPF4=
X-Received: by 2002:a17:90a:43a6:b0:296:3eda:482c with SMTP id
 r35-20020a17090a43a600b002963eda482cmr5454015pjg.45.1707047069212; Sun, 04
 Feb 2024 03:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044618.46100-1-void@manifault.com> <20240204044618.46100-2-void@manifault.com>
In-Reply-To: <20240204044618.46100-2-void@manifault.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 4 Feb 2024 12:44:18 +0100
Message-ID: <CAKfTPtCtqOAgSkXFrm918MCUMR8Z4KuTBGxGvS0E0Bmqg6mkYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: Remove unnecessary goto in update_sd_lb_stats()
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 05:46, David Vernet <void@manifault.com> wrote:
>
> In update_sd_lb_stats(), when we're iterating over the sched groups that
> comprise a sched domain, we're skipping the call to
> update_sd_pick_busiest() for the sched group that contains the local /
> destination CPU. We use a goto to skip the call, but we could just as
> easily check !local_group, as there's no other logic that we need to
> skip with the goto. Let's remove the goto, and check for !local_group in
> the if statement instead.
>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: David Vernet <void@manifault.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b803030c3a03..e7519ea434b1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10578,16 +10578,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>                 update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
>
> -               if (local_group)
> -                       goto next_group;
> -
> -
> -               if (update_sd_pick_busiest(env, sds, sg, sgs)) {
> +               if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
>                         sds->busiest = sg;
>                         sds->busiest_stat = *sgs;
>                 }
>
> -next_group:
>                 /* Now, start updating sd_lb_stats */
>                 sds->total_load += sgs->group_load;
>                 sds->total_capacity += sgs->group_capacity;
> --
> 2.43.0
>

