Return-Path: <linux-kernel+bounces-78016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0E860E00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D97C1F25041
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B675C903;
	Fri, 23 Feb 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPipCWl2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45D18E29
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680746; cv=none; b=QhE35caT3QMSKVLcUSozBD/jsDjNhYV5IoNdXd5v9qyPoL/LE3OAliDQN/ckucYbhKjbRSK2sEN+Zzoge7HIp9hksHEZFnMm0sPNKn/KhX2d2vHTH8bP4XA4YdgGyX/5NL4hY8onj0X7OgMxu+k3gN9igMR2IrQpx4M9s6x+Ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680746; c=relaxed/simple;
	bh=qApWEFFYRZvt09gXx+YkszWxC753jaUWfWsFpXxbF1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN7ylF5IsOihCYxS9DTI8gy+x8h2B/6j2TbhaAPcucMFzjyfB5GdkXWN0IIEWZtswksOIcde+yi0Iq2EoTOfMJYZ55aC+X2hZ0BKNdcTF9kWLzNoMRJHZPG+n+3CIrrUloAZmyGr3Ih8c4hNvvx9FqhEU9nA+tqsiAj+2U1FroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uPipCWl2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso31000a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708680744; x=1709285544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YH0on72w0dSvrTpAI4EZ8xCDoXPQcz05aupfXOJOA3A=;
        b=uPipCWl2UaqDZF5eEHMTXKxYxGYpe0RQQIR+tzI7/bf/yJ4lZ+twtXh8abkf9R5oq5
         gTJe5Dri3nflFOt3LfVMhyDe+Pu4xmz4WktnVSdEtZFthUQApY3WnhUenMBLTWXxvMsr
         E95m3mWQrKeC6KxAPSOhBXYT7JrZUYTIJUu2uKAwl16FyX3iPEAQf3PRXdE5Hve1vzlJ
         42vtTZRAUBOaO16SZynd+3wRNhfTPxjjbOaBfUt5HC2QLsPAGy40TltXlX6+GQ90ZBFQ
         CQ5rFrN3J8fMDlMDBepsA8+L8V2LB22j5MotEUh9WHjryHgaSlvSIf10W59UCVwZZykI
         XFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680744; x=1709285544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YH0on72w0dSvrTpAI4EZ8xCDoXPQcz05aupfXOJOA3A=;
        b=J/6s1oywTWTLxdjF6OxQKRG2rArwEtRsGbz8QfGaS3OmSVgF/nuMJ0rFhqyOFcUQdW
         XrWoeyvo/knxRI2xZSYqWwf2gm64br6VMkqH+ZFAVWrIBrjS2cwYFpBgk7rJOYI1HOkJ
         7MJnDOIKdshZ9OXXtunF4ZR9YFqdkEuA+t7SLSuxSNU1IuH/vDgAHhLdITFraMx3vWb6
         ZRlfg9xT3zsAau+wXhN/cjCDJmWjgC8lftrS1TWfkFTWgXb+O5cKv727djSe/lmNoyIn
         4nlPo05qgHzViTkU9BNUNrwCYBQDqBMyMrOkg0CaecnS7wDZD4glAXCdZUcBkeZf7Jyq
         Y5/A==
X-Forwarded-Encrypted: i=1; AJvYcCXz6duY/wYvxSYSQsVvvuPfiH26yfY4nfCemcRovtzfgPw0PdzpVylymvZI3Vn8RMY1O69BnlrSVTxspV8FESUZt90YIezofKLrudvS
X-Gm-Message-State: AOJu0YzkbuHCd7/6ovVkZ3UtCGzBfLWqLNKoIkxxzXBSJCQ5fo5rZfWO
	HSg6BdL14mX6AGAlitXwtB6puqoeq0G5O6UP5Zbkf2d3c0Hk3mJQrQ6SNSGsHOjlwUOsyG0jmBe
	Y/3zryVRgHzTFLqEB1SaOTti9B2xP++lXctOx9qwOVROWDqenTqI=
X-Google-Smtp-Source: AGHT+IHAa69QAOboZsPtT+Z7X6Qs1+x4qD7wmPRsZ+AnuCFbwvYVeNpi9JCF5twQwnVDK/A91WHSj4o4+D5XuiUt4/c=
X-Received: by 2002:a17:90a:ab92:b0:299:32d6:aa76 with SMTP id
 n18-20020a17090aab9200b0029932d6aa76mr1132370pjq.43.1708680744445; Fri, 23
 Feb 2024 01:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220225622.2626569-1-qyousef@layalina.io> <20240220225622.2626569-5-qyousef@layalina.io>
In-Reply-To: <20240220225622.2626569-5-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 23 Feb 2024 10:32:13 +0100
Message-ID: <CAKfTPtC3B5HPbMFnr-HyCd8_s1hHgihs2hjbUn11VKwH6f_Yhg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] sched/fair: Don't double balance_interval for migrate_misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 23:56, Qais Yousef <qyousef@layalina.io> wrote:
>
> It is not necessarily an indication of the system being busy and
> requires a backoff of the load balancer activities. But pushing it high
> could mean generally delaying other misfit activities or other type of
> imbalances.
>
> Also don't pollute nr_balance_failed because of misfit failures. The
> value is used for enabling cache hot migration and in migrate_util/load
> types. None of which should be impacted (skewed) by misfit failures.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 20006fcf7df2..4c1235a5dd60 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11467,8 +11467,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                  * We do not want newidle balance, which can be very
>                  * frequent, pollute the failure counter causing
>                  * excessive cache_hot migrations and active balances.
> +                *
> +                * Similarly for migration_misfit which is not related to
> +                * load/util migration, don't pollute nr_balance_failed.
>                  */
> -               if (idle != CPU_NEWLY_IDLE)
> +               if (idle != CPU_NEWLY_IDLE &&
> +                   env.migration_type != migrate_misfit)
>                         sd->nr_balance_failed++;
>
>                 if (need_active_balance(&env)) {
> @@ -11551,8 +11555,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>          * repeatedly reach this code, which would lead to balance_interval
>          * skyrocketing in a short amount of time. Skip the balance_interval
>          * increase logic to avoid that.
> +        *
> +        * Similarly misfit migration which is not necessarily an indication of
> +        * the system being busy and requires lb to backoff to let it settle
> +        * down.
>          */
> -       if (env.idle == CPU_NEWLY_IDLE)
> +       if (env.idle == CPU_NEWLY_IDLE ||
> +           env.migration_type == migrate_misfit)
>                 goto out;
>
>         /* tune up the balancing interval */
> --
> 2.34.1
>

