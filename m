Return-Path: <linux-kernel+bounces-163765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C18B6F98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4742A28240C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E74E13D284;
	Tue, 30 Apr 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te5mO2KK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002D129E72;
	Tue, 30 Apr 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472639; cv=none; b=kDBaWzKbTb61Uo58f/txjrE8+aSJZhyqt01+7N6xHs6a3Cv+Q5r2/X7zsVdLFQ5QNsDDjuGoth2CGFN6+4nW6X1GnebRpEC1NAZ7+nZVewd+ZDp5k5Mg/eN3DvTXQlZccvTSqmjEFRXkCdy0ZNTnhxkmplos9S76opyQdouTsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472639; c=relaxed/simple;
	bh=NG4wt3E1qhVSIOTYVEslbj0IbUx4tbqUB/Gh0AJzueI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSJEYLYN/McndSzBpKgcSUxnbTF20EEkA541gI+PCAWOragqsHz1gH5sOmMu9baqGllUjup8+SWfKWUqvu/2frN1R7iRT7znOLo9eWKZzoR30khYuZzndjFPAF35B+rL7Bd7mTrE5YMNM/TWKqfJC0AiF25hUtVuvMKezF8SUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te5mO2KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39DBC4AF1A;
	Tue, 30 Apr 2024 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714472639;
	bh=NG4wt3E1qhVSIOTYVEslbj0IbUx4tbqUB/Gh0AJzueI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=te5mO2KKAx3Xxper97DsSGj7zUacskVc35grwLDK/TdU+LjNR4ogJjDUFCueItDbe
	 pcIC/vMmiJFQrvCYSWsWc4aHiBDFW6gaWYdakvIZhHyF/phEgC53hAyx4JZMSqUBf6
	 sOaSSGYNcFGBaIzUw0r8kBmBhzrM/z4mtQqP1sWL4Iib3bf8Qa1korZ6rc3uPCjgcG
	 SWptIAx/GKDvm0JG1r/Mf47UvqoJDivbVNT2XVb+65/rm8rancacKXoisd7O7xOoeW
	 NTeyVFSVV6Q7aoixN/NhoxViwgbFOdSciFVl7HGAU0ezn0M919cTJM6msI0r9LoRsn
	 JD4/WfXAVyaEw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1295979eaf.1;
        Tue, 30 Apr 2024 03:23:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW/RsCI8ykekUodlBaO50fuZZ0I8S4t2M71G3WF6XMXpKFGFwlC6NkvxKywPBwhzNq6VPRrXExtOxJZ6r+B12o8EDQv+O+w0UzzrbEM2IShl7COm/O67jB8DccB3wfsGY/60krcJU=
X-Gm-Message-State: AOJu0YzLXiVZvOpd8pN3zkjF7I5YZqm3Hd9n3/ZlUUZAahocoGdYTEoP
	7Rigt3o8dtMkk4dhHRZ8a+SMk4x6Lnebkad0k9NMvPVuch8Z1FSAeNtbm9S5RveiImehLt/3bkv
	Q+UMSaDR++OV7eIPp8Fq0RSlfuKI=
X-Google-Smtp-Source: AGHT+IGl6eXKbVFaA5PHBxunuMobv5CMMLmDt/bSqqUh4kJXyRJLo82vT1vUHNgP3fYA5yTsL+07NfKnrv9ZS07nVfY=
X-Received: by 2002:a05:6820:e09:b0:5a7:db56:915c with SMTP id
 el9-20020a0568200e0900b005a7db56915cmr13550801oob.1.1714472638205; Tue, 30
 Apr 2024 03:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430074857.2069301-1-perry.yuan@amd.com>
In-Reply-To: <20240430074857.2069301-1-perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:23:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h73Pacu-70ps22WBNvXG+SCSBoa-j0wERA2tfqf3qs6g@mail.gmail.com>
Message-ID: <CAJZ5v0h73Pacu-70ps22WBNvXG+SCSBoa-j0wERA2tfqf3qs6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: fix code format problems
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, gautham.shenoy@amd.com, Borislav.Petkov@amd.com, 
	Ray.Huang@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 9:49=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wro=
te:
>
> get some code format problems fixed in the amd-pstate driver.
>
> Changes Made:
>
> - Fixed incorrect comment format in the functions.
>
> - Removed unnecessary blank line.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404271148.HK9yHBlB-lkp@i=
ntel.com/
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

As this is a resend of a patch that has been posted already, it would
be good to indicate that somehow.  For example, send the whole series
as v2 and say in the notes below the changelog that a Reviewed-by tag
has been added between v1 and v2.  And for the second patch, say that
it is new in v2.

That said, this particular case is simple enough for me to see what's
going on right away.

Both patches in the series applied, thanks!

> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 83a29b257794..85656342a101 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -792,7 +792,7 @@ static void amd_pstate_update_limits(unsigned int cpu=
)
>         mutex_unlock(&amd_pstate_driver_lock);
>  }
>
> -/**
> +/*
>   * Get pstate transition delay time from ACPI tables that firmware set
>   * instead of using hardcode value directly.
>   */
> @@ -807,7 +807,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigne=
d int cpu)
>         return transition_delay_ns / NSEC_PER_USEC;
>  }
>
> -/**
> +/*
>   * Get pstate transition latency value from ACPI tables that firmware
>   * set instead of using hardcode value directly.
>   */
> @@ -822,7 +822,7 @@ static u32 amd_pstate_get_transition_latency(unsigned=
 int cpu)
>         return transition_latency;
>  }
>
> -/**
> +/*
>   * amd_pstate_init_freq: Initialize the max_freq, min_freq,
>   *                       nominal_freq and lowest_nonlinear_freq for
>   *                       the @cpudata object.
> @@ -843,7 +843,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *c=
pudata)
>         u32 boost_ratio, lowest_nonlinear_ratio;
>         struct cppc_perf_caps cppc_perf;
>
> -
>         ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>         if (ret)
>                 return ret;
> --
> 2.34.1
>
>

