Return-Path: <linux-kernel+bounces-51613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7250848D38
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F71C21127
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1B2209A;
	Sun,  4 Feb 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwpBX1bv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47221A0A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047304; cv=none; b=FpE27zXIqNxijTQe5TWJFPu3Am8f0EZ84tFSBJfc3gsaLx5dxS2ZMRfcGRuFRh94brI/jde/ZeolL7TTCyq/gI4/5CjhH7CAqMV/qjnnJlfVmBS8KNuAXZ05Pu1p/7ryHyhdhxbPteudLOsWXip/zSPGk7M6GzXGZ30GP0iCoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047304; c=relaxed/simple;
	bh=1DuL6dXCrknE23VcOSIz+lgVGVDMztlVCyPAUOOnS+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH960flYyHuUPOrCyoohkPIdB+I7pmqbRj1AJjcGmF5DyMPCdFHyj3W0qIAgrmkeFqYGw4kzQmMROQTAU7A2cxBVFJalRDYQinZoTZeeL/Sntfqx+2jnGydK5XDrOA7OvEP9mL9q4MwYGd861vJ16eA6Wc2oGlZQ7+7c02KXSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwpBX1bv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2871957a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707047302; x=1707652102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iLWoLtoNTPqCxrIM8mN16L13n1zpFY2d5lyre0SQZo0=;
        b=jwpBX1bvu2O+77BorHqyXEp8JoFLYo1Z7+zWf5hhwmuoRQ+j03TEzK8iyyaJTuTQzS
         XEMLvekwTdtpX/fjnxkYI/OQk98KyYmzRfXiO60FmFb34HlNwCQb14A30fLRAVMlpG8Z
         uWK5Gp5dexEDMO8u7V0/Jv88KjgDuFY/ee37X5iBCn90pyfXh9Kc/uN0iZuUVQtjL8UX
         PYknD2smuB0kEyaTty2PhUgEeyj0Mrlhevw3RgW+meDMmzOgoHCLN+GDm37MuCAJ+KEK
         TsZciUWd+frZb1zhvER2DpqUo3QH0mls2ELLauY+AKms8PjAQVUcsyu5VG3gfLjqZQyJ
         NyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047302; x=1707652102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLWoLtoNTPqCxrIM8mN16L13n1zpFY2d5lyre0SQZo0=;
        b=tbR/vcJLumB0csfpwO2hLyNqrnnaz9huPgmhCzi5mz676lsBKgbB5gBM/eehfbvzgB
         YAwIvl9PRHFK+bLtcos4Ngtbqwk/7Xse+j4kNXuz2CQyE8e45fw+KMntM07pwozICUAL
         BMGwozmXoQsdEVNUSPJm12xhM/Gj/vO0zbk/ZngRgeS1npkIGA5bUxyQk5VXd7P43pIF
         iN/Df6ImMQcJ/izWZmPV64YBjzs0IT5N1R3Pc+QohLU04rwOiAT1S+MA8Z1S2NCiJy5D
         DWxhfnlvJgIc7ePutrkkTDMCm0QrjrTpGYt+lDD7o7mVytZNJlF7tHM4EL4hPcW4SxGA
         IXjA==
X-Gm-Message-State: AOJu0YwGekPz5Xuq7z8VuwY1cfXEeYYU7d+eME1xtEc9hMUw8WgvK/j+
	szG4RILThtnXr6eBnCCHckWaQ50Ni/+oSBvyhJIKS0YQv/gd5JnIRD1yjZ3Yq/4GcZpdRx1jHM5
	RHrj11O756wzm7SkLd9jsTm66+WJdfZyb8ylKcQ==
X-Google-Smtp-Source: AGHT+IEOi1scUQyf78MY4kTNWqSEf7HlOqWLYuomTqqK+b8A2/eT8u4bXLkS3+LMceEB+Lz2pWQR/bpqnLMe5hA5unU=
X-Received: by 2002:a17:90b:387:b0:296:24cf:bae6 with SMTP id
 ga7-20020a17090b038700b0029624cfbae6mr6785135pjb.27.1707047302628; Sun, 04
 Feb 2024 03:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044618.46100-1-void@manifault.com> <20240204044618.46100-4-void@manifault.com>
In-Reply-To: <20240204044618.46100-4-void@manifault.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 4 Feb 2024 12:48:11 +0100
Message-ID: <CAKfTPtB5NbvJt58zpi9aM-8kOxchgzYccY03wUEQLypaWjUXew@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: Simplify some logic in update_sd_pick_busiest()
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 05:46, David Vernet <void@manifault.com> wrote:
>
> When comparing the current struct sched_group with the yet-busiest
> domain in update_sd_pick_busiest(), if the two groups have the same
> group type, we're currently doing a bit of unnecessary work for any
> group >= group_misfit_task. We're comparing the two groups, and then
> returning only if false (the group in question is not the busiest).
> Othewise, we break, do an extra unnecessary conditional check that's
> vacuously false for any group type > group_fully_busy, and then always
> return true.
>
> Let's just return directly in the switch statement instead. This doesn't
> change the size of vmlinux with llvm 17 (not surprising given that all
> of this is inlined in load_balance()), but it does shrink load_balance()
> by 88 bytes on x86. Given that it also improves readability, this seems
> worth doing.
>
> As a bonus, remove an unnecessary goto in update_sd_lb_stats().

The line above is not relevant to the content of the patch.

Other than that

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  kernel/sched/fair.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 76d03106040d..fa049f866461 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10006,9 +10006,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>         switch (sgs->group_type) {
>         case group_overloaded:
>                 /* Select the overloaded group with highest avg_load. */
> -               if (sgs->avg_load <= busiest->avg_load)
> -                       return false;
> -               break;
> +               return sgs->avg_load > busiest->avg_load;
>
>         case group_imbalanced:
>                 /*
> @@ -10019,18 +10017,14 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>
>         case group_asym_packing:
>                 /* Prefer to move from lowest priority CPU's work */
> -               if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> -                       return false;
> -               break;
> +               return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
>
>         case group_misfit_task:
>                 /*
>                  * If we have more than one misfit sg go with the biggest
>                  * misfit.
>                  */
> -               if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
> -                       return false;
> -               break;
> +               return sgs->group_misfit_task_load > busiest->group_misfit_task_load;
>
>         case group_smt_balance:
>                 /*
> --
> 2.43.0
>

