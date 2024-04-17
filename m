Return-Path: <linux-kernel+bounces-148125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2D8A7E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A21C21E50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E77E763;
	Wed, 17 Apr 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4K0+uR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B295D8F6;
	Wed, 17 Apr 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342069; cv=none; b=gXPmn32Mh2WH7hhl/JHAChiE3s0ZgAd83FMIN57wOOLCkBUFxZhdeSspB8P/DYJBGPIwBjPQm0d9i5zsyHvzUEcJdzcQLg+yak/xws05iQsFhhSN4UnDP16OE3Dn6ymcNe4/HGFJCYQ5EOcz4DnnzeEMWsXQhfNsW7rNxfG7tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342069; c=relaxed/simple;
	bh=n75R7c/Oh7vGZ60kh161ESLlcInlrQbqdPcmJ9fFJVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKI7cRXAmYBsszIxW73cvt5jQBZF6fe4EoTyxeH4pwWuy0A/q/jjRXrflBMSdGKsC/Y95t44Y0t1MC3dyxTRbjK6kGxtHVHaLuh08wU9cHNXl3T0d0E3hgfKWyrd9wR276sRqUXAHABtBG7VEydYrMSQb6fq6bROksskomx1+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4K0+uR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51783C32783;
	Wed, 17 Apr 2024 08:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342069;
	bh=n75R7c/Oh7vGZ60kh161ESLlcInlrQbqdPcmJ9fFJVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a4K0+uR/k2z17A2pywiLxoy0vZO9lFEVelB4VBEjpEyYmS5TT4Z953zhvoWf7I6MK
	 DIWO9lEYOnLkg+Hg0iqpKbxx5B/ZkdsLidlKZYQeMC7QSsWBEAbUIHcvLcxHakdhg1
	 tzY7o2Iav71HHrqOs9aIhkb1dS1w1F9cUnE+jmRNdAa2hkwjTqJ2s4Adko/bTeYLjF
	 6YNWsSu0H+2lhob3h6s2T8WqkXDs9vqv/1fbhknSI+IrXuRPcPYDcJl82+agzYzC6q
	 wE3+hWsG6cxNCSV16gc0b33SRmILYlROlXFoRa3BqywZuaVZ9SvqCWBtralvh+aZdX
	 PgB+CT2Cqs4lw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1395060eaf.1;
        Wed, 17 Apr 2024 01:21:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdXg7XvJNxh5ZLfHzoprqfurVo4qicbJwV8jbCY7RnFhCK5+4c8ggU4r9cocGpRo4ymTTbYShGo4BU0tnkByKSwmRbHlCqnLECgG206WJieGhA2Dr0TVYAnAtrUzp12aY3C4GT3HQ=
X-Gm-Message-State: AOJu0Yx9yjAxH/RvLsuFlI82t3E4rdKcV/A6RW0gLjyNAIgEWvpY3onH
	TnOJ00psG9kry8q1uHILxed5T/Tejc0rJlf3jc69OnNyY1KJgiN1akPMoDVy1xy2SHCSWzcwX3t
	0dYsH4p5v1HQ1iI3ky/g9h/lJMv8=
X-Google-Smtp-Source: AGHT+IF1HUDQADytF/vNEBQ2UKS59DYMbC6OocjMGqOLuGMZH0OZPRVlzAAbkHRUU1qzVJJiRvJRK+r7AgZPRefv4/U=
X-Received: by 2002:a05:6820:4187:b0:5ac:6fc1:c2cb with SMTP id
 fk7-20020a056820418700b005ac6fc1c2cbmr15321134oob.0.1713342068650; Wed, 17
 Apr 2024 01:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212204.9471-1-tony.luck@intel.com>
In-Reply-To: <20240416212204.9471-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:20:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGL8kk_0ym5-mvodZbkfhPtkJbjytEMjPmBN2G1vt=5A@mail.gmail.com>
Message-ID: <CAJZ5v0iGL8kk_0ym5-mvodZbkfhPtkJbjytEMjPmBN2G1vt=5A@mail.gmail.com>
Subject: Re: [PATCH v3 43/74] x86/cpu/vfm: Update drivers/cpufreq/intel_pstate.c
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:22=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c | 90 +++++++++++++++++-----------------
>  1 file changed, 44 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index dbbf299f4219..685ec80e0af5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2402,52 +2402,51 @@ static const struct pstate_funcs knl_funcs =3D {
>         .get_val =3D core_get_val,
>  };
>
> -#define X86_MATCH(model, policy)                                        =
\
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, =
\
> -                                          X86_FEATURE_APERFMPERF, &polic=
y)
> +#define X86_MATCH(vfm, policy)                                  \
> +       X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_APERFMPERF, &policy)
>
>  static const struct x86_cpu_id intel_pstate_cpu_ids[] =3D {
> -       X86_MATCH(SANDYBRIDGE,          core_funcs),
> -       X86_MATCH(SANDYBRIDGE_X,        core_funcs),
> -       X86_MATCH(ATOM_SILVERMONT,      silvermont_funcs),
> -       X86_MATCH(IVYBRIDGE,            core_funcs),
> -       X86_MATCH(HASWELL,              core_funcs),
> -       X86_MATCH(BROADWELL,            core_funcs),
> -       X86_MATCH(IVYBRIDGE_X,          core_funcs),
> -       X86_MATCH(HASWELL_X,            core_funcs),
> -       X86_MATCH(HASWELL_L,            core_funcs),
> -       X86_MATCH(HASWELL_G,            core_funcs),
> -       X86_MATCH(BROADWELL_G,          core_funcs),
> -       X86_MATCH(ATOM_AIRMONT,         airmont_funcs),
> -       X86_MATCH(SKYLAKE_L,            core_funcs),
> -       X86_MATCH(BROADWELL_X,          core_funcs),
> -       X86_MATCH(SKYLAKE,              core_funcs),
> -       X86_MATCH(BROADWELL_D,          core_funcs),
> -       X86_MATCH(XEON_PHI_KNL,         knl_funcs),
> -       X86_MATCH(XEON_PHI_KNM,         knl_funcs),
> -       X86_MATCH(ATOM_GOLDMONT,        core_funcs),
> -       X86_MATCH(ATOM_GOLDMONT_PLUS,   core_funcs),
> -       X86_MATCH(SKYLAKE_X,            core_funcs),
> -       X86_MATCH(COMETLAKE,            core_funcs),
> -       X86_MATCH(ICELAKE_X,            core_funcs),
> -       X86_MATCH(TIGERLAKE,            core_funcs),
> -       X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
> -       X86_MATCH(EMERALDRAPIDS_X,      core_funcs),
> +       X86_MATCH(INTEL_SANDYBRIDGE,            core_funcs),
> +       X86_MATCH(INTEL_SANDYBRIDGE_X,          core_funcs),
> +       X86_MATCH(INTEL_ATOM_SILVERMONT,        silvermont_funcs),
> +       X86_MATCH(INTEL_IVYBRIDGE,              core_funcs),
> +       X86_MATCH(INTEL_HASWELL,                core_funcs),
> +       X86_MATCH(INTEL_BROADWELL,              core_funcs),
> +       X86_MATCH(INTEL_IVYBRIDGE_X,            core_funcs),
> +       X86_MATCH(INTEL_HASWELL_X,              core_funcs),
> +       X86_MATCH(INTEL_HASWELL_L,              core_funcs),
> +       X86_MATCH(INTEL_HASWELL_G,              core_funcs),
> +       X86_MATCH(INTEL_BROADWELL_G,            core_funcs),
> +       X86_MATCH(INTEL_ATOM_AIRMONT,           airmont_funcs),
> +       X86_MATCH(INTEL_SKYLAKE_L,              core_funcs),
> +       X86_MATCH(INTEL_BROADWELL_X,            core_funcs),
> +       X86_MATCH(INTEL_SKYLAKE,                core_funcs),
> +       X86_MATCH(INTEL_BROADWELL_D,            core_funcs),
> +       X86_MATCH(INTEL_XEON_PHI_KNL,           knl_funcs),
> +       X86_MATCH(INTEL_XEON_PHI_KNM,           knl_funcs),
> +       X86_MATCH(INTEL_ATOM_GOLDMONT,          core_funcs),
> +       X86_MATCH(INTEL_ATOM_GOLDMONT_PLUS,     core_funcs),
> +       X86_MATCH(INTEL_SKYLAKE_X,              core_funcs),
> +       X86_MATCH(INTEL_COMETLAKE,              core_funcs),
> +       X86_MATCH(INTEL_ICELAKE_X,              core_funcs),
> +       X86_MATCH(INTEL_TIGERLAKE,              core_funcs),
> +       X86_MATCH(INTEL_SAPPHIRERAPIDS_X,       core_funcs),
> +       X86_MATCH(INTEL_EMERALDRAPIDS_X,        core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
>
>  static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst =
=3D {
> -       X86_MATCH(BROADWELL_D,          core_funcs),
> -       X86_MATCH(BROADWELL_X,          core_funcs),
> -       X86_MATCH(SKYLAKE_X,            core_funcs),
> -       X86_MATCH(ICELAKE_X,            core_funcs),
> -       X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
> +       X86_MATCH(INTEL_BROADWELL_D,            core_funcs),
> +       X86_MATCH(INTEL_BROADWELL_X,            core_funcs),
> +       X86_MATCH(INTEL_SKYLAKE_X,              core_funcs),
> +       X86_MATCH(INTEL_ICELAKE_X,              core_funcs),
> +       X86_MATCH(INTEL_SAPPHIRERAPIDS_X,       core_funcs),
>         {}
>  };
>
>  static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] =3D {
> -       X86_MATCH(KABYLAKE,             core_funcs),
> +       X86_MATCH(INTEL_KABYLAKE,               core_funcs),
>         {}
>  };
>
> @@ -3386,14 +3385,13 @@ static inline void intel_pstate_request_control_f=
rom_smm(void) {}
>
>  #define INTEL_PSTATE_HWP_BROADWELL     0x01
>
> -#define X86_MATCH_HWP(model, hwp_mode)                                 \
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, =
\
> -                                          X86_FEATURE_HWP, hwp_mode)
> +#define X86_MATCH_HWP(vfm, hwp_mode)                           \
> +       X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_HWP, hwp_mode)
>
>  static const struct x86_cpu_id hwp_support_ids[] __initconst =3D {
> -       X86_MATCH_HWP(BROADWELL_X,      INTEL_PSTATE_HWP_BROADWELL),
> -       X86_MATCH_HWP(BROADWELL_D,      INTEL_PSTATE_HWP_BROADWELL),
> -       X86_MATCH_HWP(ANY,              0),
> +       X86_MATCH_HWP(INTEL_BROADWELL_X,        INTEL_PSTATE_HWP_BROADWEL=
L),
> +       X86_MATCH_HWP(INTEL_BROADWELL_D,        INTEL_PSTATE_HWP_BROADWEL=
L),
> +       X86_MATCH_HWP(INTEL_ANY,                0),
>         {}
>  };
>
> @@ -3426,15 +3424,15 @@ static const struct x86_cpu_id intel_epp_default[=
] =3D {
>          * which can result in one core turbo frequency for
>          * AlderLake Mobile CPUs.
>          */
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_=
EPP(102)),
> -       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_=
PERF_EPP(32)),
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_E=
PP_POWERSAVE,
> -                                                       HWP_EPP_BALANCE_P=
OWERSAVE, 115, 16)),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102=
)),
> +       X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EP=
P(32)),
> +       X86_MATCH_VFM(INTEL_METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWE=
RSAVE,
> +                     HWP_EPP_BALANCE_POWERSAVE, 115, 16)),
>         {}
>  };
>
>  static const struct x86_cpu_id intel_hybrid_scaling_factor[] =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HYBRID_SCALING_FACTOR_MT=
L),
> +       X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
>         {}
>  };
>
> --
> 2.44.0
>

