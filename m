Return-Path: <linux-kernel+bounces-106120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E387E963
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120F01C213EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820B2FE0F;
	Mon, 18 Mar 2024 12:37:07 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C9381A4;
	Mon, 18 Mar 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765427; cv=none; b=S8Z5UG2DOzDDBhNw6B0Vk3w7no8V0Evg9wac0zsgAJk/AlRGQpoZIvC3kiOGqoyNXWrUhylnIFhZOwpz4QG+DRqThg4Fa4o8S7R6DmuAFm8pO90nZygiQY9DBTvELxd5yGOmU7n+6JuLPfrXy1RcBgmSR4ue56Df6aN30hCWQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765427; c=relaxed/simple;
	bh=cIGQbqXwEkpHmSUSGwv0CkWp+CTN18AGAOKkRrvubDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrsKckGc9N/YMn9uEO5D4GLG4EDHIn7HBrNWWDKKX2GcTsKAWX4/DABSVgEQxiIdwQJkqIek2ri+/1ByR5mAaVBQJL2q0DsnQNGCVYdZRRcpGG7d0d49sz+1ZbR45C0Vex67FAQor3wEoqljt9xjCaNL04PjlmHeYVh6aRaG3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e67ad4c2e3so69649a34.1;
        Mon, 18 Mar 2024 05:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765425; x=1711370225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qjbJ8yR4itgbNq8Q11dnfj4BFgBdhtIsr7EAZiZBAk=;
        b=VChGQlUtT7ueHW4E+7jBJjtAfQPQtSy8DHaEBSN+UOcNQf+63/95lBZjDAxW6mXAcc
         BG93bsurnjlqBvL2XdGBuPIB2VnQjRFkamiwoKWanH0+G2jIrZ6ZikfwqtM5mwUwxa4L
         bESpAvovxQoaPCvqbkBDwOo9tTwRl0g3JxX8Z17xb1OMj1184epGDaYJNQqVxNQ4UAUj
         psG5NiNy/DlRxiUOzmaE0l9CHwzbFjbV0sGSK9o//qKY8O8kQenVCOhBS7fuS1W//xUQ
         y+93cVRFYhSru8Gr/nrpL3ZWYVaL+2apySHg/GWYujA76Fp9FJvJFUSbDk5uZRJiUHpP
         UV4g==
X-Forwarded-Encrypted: i=1; AJvYcCUPyf9ov53mLbOSuPBIQw4gLoZPsb5I3jpoft8jgyER/0TYQOYYX8UjHSEbaRLnLGiKXCKuNbEE8fU/Z91rMK6U39rvGMmE9jLxRABMNYR/ZxOwB9FWMSpk6IDgLP7mhzoG189e6s4=
X-Gm-Message-State: AOJu0YzfV+6rA7JMcHeAIfhGfTBwwvxrBYkKsDlEk8TIGyFPMeRIYobi
	xF1YqsZ3wNX57DBK8h6L9LYv9xyiLeBvhC4cOQVP0XA4zwicZ/sSc59ObSDtKP90he+l4VskSfL
	ZzSW86TYc385SAAJUvRk4B+wyUR8=
X-Google-Smtp-Source: AGHT+IFAzXsV1FntoE35q7hpj2BcpxEpjp5RM1YnJQza6EzBR3vaHweTUIT9Fuc4N7kiUujvpMGNZfMBCclG9gksKA0=
X-Received: by 2002:a05:6820:2c10:b0:5a4:7790:61b4 with SMTP id
 dw16-20020a0568202c1000b005a4779061b4mr6980768oob.0.1710765424769; Mon, 18
 Mar 2024 05:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710754409.git.perry.yuan@amd.com> <d9fe75ae9ba3893061c01fcaccd93f2915b09a35.1710754409.git.perry.yuan@amd.com>
In-Reply-To: <d9fe75ae9ba3893061c01fcaccd93f2915b09a35.1710754409.git.perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 13:36:49 +0100
Message-ID: <CAJZ5v0hJjkUoEGC2wVXs3_TZpc99HFPfi7yX7rO16ykwRxk+DA@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:49=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wr=
ote:
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
>
> amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
> return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.
>
> There is no loss in readability in replacing their invocations by
> accesses to the corresponding members of cpudata.
>
> Do so and remove these helper functions.
>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Sender sign-off missing (when sending somebody else's patch, you need
to add your S-o-b tag to it).

> ---
>  drivers/cpufreq/amd-pstate.c | 40 +++++++++---------------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ba1baa6733e6..132330b4942f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -604,26 +604,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>         cpufreq_cpu_put(policy);
>  }
>
> -static int amd_get_min_freq(struct amd_cpudata *cpudata)
> -{
> -       return READ_ONCE(cpudata->min_freq);
> -}
> -
> -static int amd_get_max_freq(struct amd_cpudata *cpudata)
> -{
> -       return READ_ONCE(cpudata->max_freq);
> -}
> -
> -static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
> -{
> -       return READ_ONCE(cpudata->nominal_freq);
> -}
> -
> -static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> -{
> -       return READ_ONCE(cpudata->lowest_nonlinear_freq);
> -}
> -
>  static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state=
)
>  {
>         struct amd_cpudata *cpudata =3D policy->driver_data;
> @@ -854,10 +834,10 @@ static int amd_pstate_cpu_init(struct cpufreq_polic=
y *policy)
>         if (ret)
>                 goto free_cpudata1;
>
> -       min_freq =3D amd_get_min_freq(cpudata);
> -       max_freq =3D amd_get_max_freq(cpudata);
> -       nominal_freq =3D amd_get_nominal_freq(cpudata);
> -       lowest_nonlinear_freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> +       min_freq =3D READ_ONCE(cpudata->min_freq);
> +       max_freq =3D READ_ONCE(cpudata->max_freq);
> +       nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> +       lowest_nonlinear_freq =3D READ_ONCE(cpudata->lowest_nonlinear_fre=
q);
>
>         if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
>                 dev_err(dev, "min_freq(%d) or max_freq(%d) value is incor=
rect\n",
> @@ -960,7 +940,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufre=
q_policy *policy,
>         int max_freq;
>         struct amd_cpudata *cpudata =3D policy->driver_data;
>
> -       max_freq =3D amd_get_max_freq(cpudata);
> +       max_freq =3D READ_ONCE(cpudata->max_freq);
>         if (max_freq < 0)
>                 return max_freq;
>
> @@ -973,7 +953,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(=
struct cpufreq_policy *poli
>         int freq;
>         struct amd_cpudata *cpudata =3D policy->driver_data;
>
> -       freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> +       freq =3D READ_ONCE(cpudata->lowest_nonlinear_freq);
>         if (freq < 0)
>                 return freq;
>
> @@ -1315,10 +1295,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq=
_policy *policy)
>         if (ret)
>                 goto free_cpudata1;
>
> -       min_freq =3D amd_get_min_freq(cpudata);
> -       max_freq =3D amd_get_max_freq(cpudata);
> -       nominal_freq =3D amd_get_nominal_freq(cpudata);
> -       lowest_nonlinear_freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> +       min_freq =3D READ_ONCE(cpudata->min_freq);
> +       max_freq =3D READ_ONCE(cpudata->max_freq);
> +       nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> +       lowest_nonlinear_freq =3D READ_ONCE(cpudata->lowest_nonlinear_fre=
q);
>         if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
>                 dev_err(dev, "min_freq(%d) or max_freq(%d) value is incor=
rect\n",
>                                 min_freq, max_freq);
> --
> 2.34.1
>
>

