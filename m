Return-Path: <linux-kernel+bounces-73454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90985C2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F71282F88
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560D477632;
	Tue, 20 Feb 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlHoopGF"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B177F0E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450665; cv=none; b=N0vUp9T/rGw/Ul8RIAoMAwFaX+UR4rOL84p8sr3uRzyFFTesjR1+LV72LWDVhGYJJH/gDIYYKz1ltDLD+UowJPGgnndOoXcMHctD3jKv0w9jlsnnJXiu0WpR4XUVE+Wq/j+Q5rBaTOoCiOw46G6I482NaMKmg+XRiawgzDFMnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450665; c=relaxed/simple;
	bh=WKpzNcvIK0P/NIuxFDXvfATWYBYq86v97mLTcUnLeqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufL7h0dJiaWUEY9ylgRfkun2lfNYfX94XUCR7WTLNo7xC2oQNek89L/Je4NqIRtKkhp8qrEW5ueXEVtRchTzK51QYa2gHaoIAguK+fG21DGkfygWhymiT8k0hQoCfgnbmsaui0PEpr6VI8J5IAMpNSIGaQfyqmYG+TGIKreshac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlHoopGF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-299354e5f01so2908981a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708450654; x=1709055454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhuni0civ32K5iUKCYdlSRc+Waum7V0xwhUm0rPzhhY=;
        b=mlHoopGFd+69Ex1jDpWqYHxcFw4rtiUeO/ti8Tdg7Azx7UeqL0roFdsSG7GbFwfkoF
         NsSbMIMpjjKIc1X8grlygtwVmNzxS2ToFP/Wok537ThWTG9UGz0d6Sw0E9xLs/Kvy8+1
         8D7cAwguCdo3hDIlxjBRFvy3HvaLJUE67rXPheSOQkdegZmuXo4KmPdDEcz0ujjvsqQo
         JstigPF9fwfQzaC+E/5ZBMAGWya4sLjgugrj7WZVCA0/qzJc+Jl9OrWQaVHmgoG6g+aI
         zcuiPjz36a4UoDloLUMSgucr3NHs3jhpzAsOe3non7JicTUPDm4a8sNGM8sve6/pfZpC
         5cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450654; x=1709055454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhuni0civ32K5iUKCYdlSRc+Waum7V0xwhUm0rPzhhY=;
        b=GobtQeUyAzF/79qpHcTceSgQdIDnSXIij5QdZsOo8G0YGBCjk90V2rB3rqpSH4TfV9
         ZkjZMGzenCrL8cGNfo3ZFbaw/jPWVkqr+QUAgmoWs7Ro2EbNd1f0upNsp6dt+NC30zDI
         DVY30fsQL3beo85fba8Hpp8SC0GCZvqxyP2xY2YTPremqWcSZHfUZNP0HLZHP/9073Di
         xI3usAD74gRE2AEXfZzZE32slzRBW6PL4xxdR93wIVgzZFDQc5Eop3pkFGO0VjyLT3Pr
         VFWu5stagbpq2/PC8dskr9YBk6jzUk7eu7U6y2me4/yYEX8dx3jwQtqcNaFYluDyYInW
         yPJg==
X-Forwarded-Encrypted: i=1; AJvYcCUMFPVa0GDltBpd6ipBBZOojDZT+lIR/DvEV4iA5r+49OublGjYkzHc7kwtZIikwsx0R4ITfMDMECt2/DqfPa8lPJbPxSYeKYkpAQty
X-Gm-Message-State: AOJu0YxB745mDT0+rIUWQ/ZpbCwVwsaipz9zOhf0sDaY33H767IuNZ+A
	kxph1M/VV7EvoE31DkW/4M54925NHbRZT3/GI3Y7/e9spi22XldDyqdHUd8ncrkrrRvqpaT57Ml
	bsNegiQOnVzvCT1uOZL8NxojRlhTEM1MoyDyvMw==
X-Google-Smtp-Source: AGHT+IF0E7p3xEhZaG2DRCXUZ6Y/iTvEcWqkaMIgiq8fc5zLouls5yDaamySwCKx14Lnh+WGWbXnjhylJHxjzIqdudQ=
X-Received: by 2002:a17:90a:c598:b0:299:41dd:95c0 with SMTP id
 l24-20020a17090ac59800b0029941dd95c0mr15044844pjt.16.1708450654484; Tue, 20
 Feb 2024 09:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205021123.2225933-1-qyousef@layalina.io> <20240205021123.2225933-3-qyousef@layalina.io>
 <CAKfTPtAsij+_=n9JCxHw==j3-wC9rYZHEJyVmyBJsx_-Udhzgw@mail.gmail.com>
 <20240220155913.n7uxb3e56kuhcxs2@airbuntu> <20240220161546.7r3leteuqygf6jxc@airbuntu>
In-Reply-To: <20240220161546.7r3leteuqygf6jxc@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 20 Feb 2024 18:37:22 +0100
Message-ID: <CAKfTPtAv-9HuX5xqEdMamo=YtyryA+K2nHBBG5XX7oyNybnUVA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 17:15, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/20/24 15:59, Qais Yousef wrote:
>
> > I realized that I wanted to also add a new patch to not double balance_interval
> > for misfit failures. I think you indicated that seems the right thing to do?
>
> I think this should do it?

yes it should do it

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 70ffbb1aa15c..b12b7de495d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11552,8 +11552,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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

