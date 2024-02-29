Return-Path: <linux-kernel+bounces-87342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FD86D30F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11671C21D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90213C9C7;
	Thu, 29 Feb 2024 19:26:15 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00E1350C9;
	Thu, 29 Feb 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234774; cv=none; b=OnHX6E5TDjgwRilDv4IIrQ3meBXmfR7t2IL5sCaEKrJoHIx61qUb6Ok3pK6SL/SijvfalfW5dYEdMLaWSfb623cczKqBtDfH7/2zoAIhNfpyHSa4XZdu3Gw2w6Oo1DnTVsLWxZGPCitoxKntep1TV1KgFhHFOMyDuaCQ46yiRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234774; c=relaxed/simple;
	bh=CDs+Duuit9PD7/A5RsuZL8XM9F0qhGpY7SYwSBEzlVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQKka1kh0hfff4Ay5PmZ1ZwfTq1HmIqSZ7DGAOAMOeD+KQSX7gwIYqn5ToFqyOHp+NbNTTtU32CRhsM02h9wAfV3ufbgx+HfFr3l4fisKmZQfuQE3Tlkk5s9gIMbTtWPJX7G17M0xJhC4b9Ab8eSnHWqEM9tVbE+MhxUGG2zBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e447c39525so253348a34.0;
        Thu, 29 Feb 2024 11:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234772; x=1709839572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rhpKQ+eX1EBSDrTVD9HPgkSZTA4wQdaIQcskZLuqPY=;
        b=V5HTwvzK9LUbFkfPwqCs0UybG8LJb75bzGbfO2wg0FRlMKAtmpPLma6rhpDy2eHZxL
         W6VdNj3EvHimaiOqusknstTveDJ5KzLP8rQ5vN3D8sVxqTKu3vjzmOjcnKGws7oPgNcc
         g8kCGEYoBb96z3ICNsKt4BNZ8KfzWoIupvfqHNqzmfFeWVWLskzOf1xz89qaJz6vdDmx
         QXqmxH4dQmGmO1beF9z5wlY/rQm7O1W/92lC586rSUHMc3rfkhgu66Ra+N98EE6DlybH
         jK4orHE/ucWLayBV0UdnX0YyWc3XhNG7oykf0P5B01cI+Kiljd6hcQ2+1/3llDc4/XCx
         spqg==
X-Forwarded-Encrypted: i=1; AJvYcCWdCYyRBVkbVFu8nUleb3oLOMIDt+Fij2lLU+Lf2xdLyJBXluftux6TjRacOT4oU7nbLAoKeIiO3kBQ1cNh0khiGbA4zsXMQGXVR1WGLMtPAPB2rc9pc3JLaosS0uTC2qyQi3Xq6OU=
X-Gm-Message-State: AOJu0YxfbPlajFRbTkpbABnARwdATFX7D5cF963TaiM6ISptrkZmlFgQ
	Z/aW3m6gn4gJsjOX7H6HiqNFseQsXkxyrHT1ASfaulNpIrmgL24jVQ3zHtD5xKEKmUxGD3nm5i/
	AHUnoAx1JuTdfIH4fdlL2pyYpKEY=
X-Google-Smtp-Source: AGHT+IHrZscDx64lfBlx2DuEDGUOJc9YfwEmOQEtRyeSj3fvgLNPG6NkD26cQXPOO6wlNsTi5qc0PZYCL5ooULkXhZI=
X-Received: by 2002:a4a:d091:0:b0:5a0:4216:c5f0 with SMTP id
 i17-20020a4ad091000000b005a04216c5f0mr3006435oor.0.1709234772617; Thu, 29 Feb
 2024 11:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222233947.sl435tvhhpe5iqzw@airbuntu> <20240227233452.405852-1-qyousef@layalina.io>
In-Reply-To: <20240227233452.405852-1-qyousef@layalina.io>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:26:01 +0100
Message-ID: <CAJZ5v0hdZc2Usfa8m_DrVr6ZnzqZOUd60grGySz-EkyMgtzNjA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Honour transition_latency over transition_delay_us
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:35=E2=80=AFAM Qais Yousef <qyousef@layalina.io> =
wrote:
>
> Some platforms like Arm's Juno can have a high transition latency that
> can be larger than the 2ms cap introduced. If a driver report
> a transition_latency that is higher than the cap, then use it as-is.
>
> Update comment s/10/2/ to reflect the new cap of 2ms.
>
> Reported-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 66cef33c4ec7..926a51cb7e52 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(stru=
ct cpufreq_policy *policy)
>
>         latency =3D policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>         if (latency) {
> +               unsigned int max_delay_us =3D 2 * MSEC_PER_SEC;
> +
> +               /*
> +                * If the platform already has high transition_latency, u=
se it
> +                * as-is.
> +                */
> +               if (latency > max_delay_us)
> +                       return latency;
> +
>                 /*
> -                * For platforms that can change the frequency very fast =
(< 10
> +                * For platforms that can change the frequency very fast =
(< 2
>                  * us), the above formula gives a decent transition delay=
 But
>                  * for platforms where transition_latency is in milliseco=
nds, it
>                  * ends up giving unrealistic values.
> @@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struc=
t cpufreq_policy *policy)
>                  * a reasonable amount of time after which we should reev=
aluate
>                  * the frequency.
>                  */
> -               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2=
 * MSEC_PER_SEC));
> +               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
>         }
>
>         return LATENCY_MULTIPLIER;
> --

Applied as 6.9 material, thanks!

