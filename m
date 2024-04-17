Return-Path: <linux-kernel+bounces-148135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3808A7E29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FE41F2286F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647A7F7CA;
	Wed, 17 Apr 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/obyrx3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B47F47D;
	Wed, 17 Apr 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342272; cv=none; b=FKVhaTiyY1sLEWdvkJlq3h+1Ntt+DgiyRygItAS9Nx506HFpEh4oRE6E6SDm/KTM5JA6JyPkv4yp5uyu0fx4Y5RneR44rxNguxsuhtRE0Z+H2V3Vhp5HZFKXEFmDHpfVcoTl1gPAVnLtySPbrUcetOx2rx4xUkgM0dLI6fx6Bps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342272; c=relaxed/simple;
	bh=gFqoMNtfRcF+aSCfHjBlC5FeyW9EDw1hQFKmEcwuPjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRMGrVzMFwBBfCQuPq4n5BKMp6l9mTAiW6nCi4huHbW6OZHUZt+4I4P/0nc3Ny/fUrjDgOra1gYxvS+pqACz0O3kfvo/Ote3e5sicsxOFfoahgxm8IyHU4E5wagIAadkF9f3RxpVdZeqRf1OWn1QgpKa7V/0MLV9OIEiBKKMdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/obyrx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3609C32786;
	Wed, 17 Apr 2024 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342271;
	bh=gFqoMNtfRcF+aSCfHjBlC5FeyW9EDw1hQFKmEcwuPjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l/obyrx3t7TkMQlKjkgqXrmDRuoPE8F96s1KStiQ17Sew3zNCN4UZ4aMnS/d8RIqk
	 kq45+p+qmfQo8pL4fk8Sb9RmEUK+zxXHt2afi28LTm+V998PCmcXC34kNeJ0GW0NxQ
	 xf6aKdMo0dMSbcW5CekJ/GIUuYaN4+tLhPGwIT8NRtfgeP3FtuBqV5aW2VtheIbFCK
	 0A0U8sFh6TSTdji6j37Aj1miF49XIbtyBK+SczVMLpoAWkVYQ6rBIGERgfU6NqIgah
	 VarAsR165Ox240FLCe4ISr35ttxlEV4eb4+HP8RDx05dRBGvV6T4CXwwN1SUt17MxL
	 PD1taeUj83QZQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb7a4d64e8so1162611a34.0;
        Wed, 17 Apr 2024 01:24:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU34gw+5AO5lEVSCbxMbjfzWIMBrz23MkKstemsujrOaMZsAho0T1tRXex+o79otls1gEV0ddLNleNHRFdjJVAIVRyfZ8Jr/H8=
X-Gm-Message-State: AOJu0YwqO9xGGqkjqgc5bdU0T0n23lvbdK02mX/VE5KnPflP3Vpjqy+m
	zZCP8nyh04JA68wr2aJmtm4KOUb+K82NjwrBw/SJEd/Co4E88d1Os89v2maktDjNCSfxOsaVfzN
	itfZ1LbAicNxytIUP9ckdTmMCyuQ=
X-Google-Smtp-Source: AGHT+IELx4IGhtnudJP4QPEms/qHBnXjsSZx8RtYwudlcxsm/iTKGVm7iRXtcGROfBXaM//W5T+hs04bc3w+Pz+96rM=
X-Received: by 2002:a4a:bb18:0:b0:5aa:14ff:4128 with SMTP id
 f24-20020a4abb18000000b005aa14ff4128mr15816270oop.1.1713342271009; Wed, 17
 Apr 2024 01:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212218.9624-1-tony.luck@intel.com>
In-Reply-To: <20240416212218.9624-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:24:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jf-O8b-CU8TJZLgitD5DSmQLp5dD0+eutY_xj=ZFua2Q@mail.gmail.com>
Message-ID: <CAJZ5v0jf-O8b-CU8TJZLgitD5DSmQLp5dD0+eutY_xj=ZFua2Q@mail.gmail.com>
Subject: Re: [PATCH v3 51/74] x86/cpu/vfm: Update drivers/idle/intel_idle.c
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:31=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/idle/intel_idle.c | 116 +++++++++++++++++++-------------------
>  1 file changed, 58 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index e486027f8b07..9aab7abc2ae9 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1494,53 +1494,53 @@ static const struct idle_cpu idle_cpu_srf __initc=
onst =3D {
>  };
>
>  static const struct x86_cpu_id intel_idle_ids[] __initconst =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,          &idle_cpu_nhx),
> -       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,             &idle_cpu_nehalem=
),
> -       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,           &idle_cpu_nehalem=
),
> -       X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,            &idle_cpu_nehalem=
),
> -       X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,         &idle_cpu_nhx),
> -       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,          &idle_cpu_nhx),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL,        &idle_cpu_atom),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL_MID,    &idle_cpu_lincrof=
t),
> -       X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,         &idle_cpu_nhx),
> -       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,         &idle_cpu_snb),
> -       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,       &idle_cpu_snx),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL,       &idle_cpu_atom),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &idle_cpu_byt),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &idle_cpu_tangier=
),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        &idle_cpu_cht),
> -       X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,           &idle_cpu_ivb),
> -       X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,         &idle_cpu_ivt),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL,             &idle_cpu_hsw),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,           &idle_cpu_hsx),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,           &idle_cpu_hsw),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,           &idle_cpu_hsw),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,   &idle_cpu_avn),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,           &idle_cpu_bdw),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,         &idle_cpu_bdw),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,         &idle_cpu_bdx),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,         &idle_cpu_bdx),
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,           &idle_cpu_skl),
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &idle_cpu_skl),
> -       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &idle_cpu_skl),
> -       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &idle_cpu_skl),
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &idle_cpu_adl),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &idle_cpu_adl_l),
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,        &idle_cpu_mtl_l),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,      &idle_cpu_gmt),
> -       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
> -       X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,     &idle_cpu_spr),
> -       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
> -       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &idle_cpu_bxt),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,  &idle_cpu_bxt),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,     &idle_cpu_dnv),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,      &idle_cpu_snr),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,      &idle_cpu_grr),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,    &idle_cpu_srf),
> +       X86_MATCH_VFM(INTEL_NEHALEM_EP,         &idle_cpu_nhx),
> +       X86_MATCH_VFM(INTEL_NEHALEM,            &idle_cpu_nehalem),
> +       X86_MATCH_VFM(INTEL_NEHALEM_G,          &idle_cpu_nehalem),
> +       X86_MATCH_VFM(INTEL_WESTMERE,           &idle_cpu_nehalem),
> +       X86_MATCH_VFM(INTEL_WESTMERE_EP,        &idle_cpu_nhx),
> +       X86_MATCH_VFM(INTEL_NEHALEM_EX,         &idle_cpu_nhx),
> +       X86_MATCH_VFM(INTEL_ATOM_BONNELL,       &idle_cpu_atom),
> +       X86_MATCH_VFM(INTEL_ATOM_BONNELL_MID,   &idle_cpu_lincroft),
> +       X86_MATCH_VFM(INTEL_WESTMERE_EX,        &idle_cpu_nhx),
> +       X86_MATCH_VFM(INTEL_SANDYBRIDGE,        &idle_cpu_snb),
> +       X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,      &idle_cpu_snx),
> +       X86_MATCH_VFM(INTEL_ATOM_SALTWELL,      &idle_cpu_atom),
> +       X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,    &idle_cpu_byt),
> +       X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &idle_cpu_tangier),
> +       X86_MATCH_VFM(INTEL_ATOM_AIRMONT,       &idle_cpu_cht),
> +       X86_MATCH_VFM(INTEL_IVYBRIDGE,          &idle_cpu_ivb),
> +       X86_MATCH_VFM(INTEL_IVYBRIDGE_X,        &idle_cpu_ivt),
> +       X86_MATCH_VFM(INTEL_HASWELL,            &idle_cpu_hsw),
> +       X86_MATCH_VFM(INTEL_HASWELL_X,          &idle_cpu_hsx),
> +       X86_MATCH_VFM(INTEL_HASWELL_L,          &idle_cpu_hsw),
> +       X86_MATCH_VFM(INTEL_HASWELL_G,          &idle_cpu_hsw),
> +       X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,  &idle_cpu_avn),
> +       X86_MATCH_VFM(INTEL_BROADWELL,          &idle_cpu_bdw),
> +       X86_MATCH_VFM(INTEL_BROADWELL_G,        &idle_cpu_bdw),
> +       X86_MATCH_VFM(INTEL_BROADWELL_X,        &idle_cpu_bdx),
> +       X86_MATCH_VFM(INTEL_BROADWELL_D,        &idle_cpu_bdx),
> +       X86_MATCH_VFM(INTEL_SKYLAKE_L,          &idle_cpu_skl),
> +       X86_MATCH_VFM(INTEL_SKYLAKE,            &idle_cpu_skl),
> +       X86_MATCH_VFM(INTEL_KABYLAKE_L,         &idle_cpu_skl),
> +       X86_MATCH_VFM(INTEL_KABYLAKE,           &idle_cpu_skl),
> +       X86_MATCH_VFM(INTEL_SKYLAKE_X,          &idle_cpu_skx),
> +       X86_MATCH_VFM(INTEL_ICELAKE_X,          &idle_cpu_icx),
> +       X86_MATCH_VFM(INTEL_ICELAKE_D,          &idle_cpu_icx),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE,          &idle_cpu_adl),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE_L,        &idle_cpu_adl_l),
> +       X86_MATCH_VFM(INTEL_METEORLAKE_L,       &idle_cpu_mtl_l),
> +       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,     &idle_cpu_gmt),
> +       X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,   &idle_cpu_spr),
> +       X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,    &idle_cpu_spr),
> +       X86_MATCH_VFM(INTEL_XEON_PHI_KNL,       &idle_cpu_knl),
> +       X86_MATCH_VFM(INTEL_XEON_PHI_KNM,       &idle_cpu_knl),
> +       X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,      &idle_cpu_bxt),
> +       X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS, &idle_cpu_bxt),
> +       X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,    &idle_cpu_dnv),
> +       X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,     &idle_cpu_snr),
> +       X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,     &idle_cpu_grr),
> +       X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,   &idle_cpu_srf),
>         {}
>  };
>
> @@ -1990,27 +1990,27 @@ static void __init intel_idle_init_cstates_icpu(s=
truct cpuidle_driver *drv)
>  {
>         int cstate;
>
> -       switch (boot_cpu_data.x86_model) {
> -       case INTEL_FAM6_IVYBRIDGE_X:
> +       switch (boot_cpu_data.x86_vfm) {
> +       case INTEL_IVYBRIDGE_X:
>                 ivt_idle_state_table_update();
>                 break;
> -       case INTEL_FAM6_ATOM_GOLDMONT:
> -       case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
> +       case INTEL_ATOM_GOLDMONT:
> +       case INTEL_ATOM_GOLDMONT_PLUS:
>                 bxt_idle_state_table_update();
>                 break;
> -       case INTEL_FAM6_SKYLAKE:
> +       case INTEL_SKYLAKE:
>                 sklh_idle_state_table_update();
>                 break;
> -       case INTEL_FAM6_SKYLAKE_X:
> +       case INTEL_SKYLAKE_X:
>                 skx_idle_state_table_update();
>                 break;
> -       case INTEL_FAM6_SAPPHIRERAPIDS_X:
> -       case INTEL_FAM6_EMERALDRAPIDS_X:
> +       case INTEL_SAPPHIRERAPIDS_X:
> +       case INTEL_EMERALDRAPIDS_X:
>                 spr_idle_state_table_update();
>                 break;
> -       case INTEL_FAM6_ALDERLAKE:
> -       case INTEL_FAM6_ALDERLAKE_L:
> -       case INTEL_FAM6_ATOM_GRACEMONT:
> +       case INTEL_ALDERLAKE:
> +       case INTEL_ALDERLAKE_L:
> +       case INTEL_ATOM_GRACEMONT:
>                 adl_idle_state_table_update();
>                 break;
>         }
> --
> 2.44.0
>
>

