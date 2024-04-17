Return-Path: <linux-kernel+bounces-148136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD88A7E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC759B24365
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13D7F479;
	Wed, 17 Apr 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSFRR89b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAF7D07E;
	Wed, 17 Apr 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342302; cv=none; b=Tb6qLcnaZfDQQlVC1I+8B1f5jn7sGVpFykEHeJHZCTOiVsM4PkH2OKDxXuc3sofXOPeNbGu0k/onkQcYe5bFPC2F4VJhVWtVW+xaKCCrI9Ny3/QicnDtssbhjRLu6lmgnbc/X+I+iw07fvxB57KCm2gz5b8DDfxdRG1t+ekQNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342302; c=relaxed/simple;
	bh=HJdgnr9JlqJqxyH+gp+wparjjOOrrISZgYv4r65W2Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8Hm9RMojFhvb1Tc4QGe1m5lguZEtCZfzfpSu8phnqD5KuckFHO2sk8ADMv4NiZ955NBvfPZ2rKezUZhuK+s3sp/EQyZkbp8vZG2IC9C2e32AUbWrsYil6dirfTQ/pvBnrq44Dwja2lpyfA+5j5Wn3pMq/ejq4O017QRLBxeofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSFRR89b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E1C2BD10;
	Wed, 17 Apr 2024 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342302;
	bh=HJdgnr9JlqJqxyH+gp+wparjjOOrrISZgYv4r65W2Hc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eSFRR89bIzVUDwaLk754SiYBDVfud6cr1jBBp3PuDqTY6i3xk2+4V+YE7iYKla+yx
	 jHuqYB7XU0tkwrVeR+GALmTbWyv+dQ2mOdzzv0dkmOUdH1c7+ax0oamMopKS1WU8wT
	 VtcS9uKGwqAQybHztbLrSmNIdxsYspWWub7FdPF/mwzg4rsHpSpQwsh3Q6/GXN6TNo
	 MXb+Bh4U/Cab5z2LlviiIc3nkFIz/iuyvVRMddfP3WSvtsiUtHlfbPVqGN+1I0HJr2
	 1H+Fd+Sm2KOSwg974bWRdyMdqNw7xBOzDRl0zPzDOvquDOy5NEWNnAJYhcLK6HP121
	 rzmTiIr3QWapQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so866260eaf.1;
        Wed, 17 Apr 2024 01:25:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8VyF3vsH9YcTVQHD8IBWCHlpk8TezYUnLRNQGNT5+1S8f/MBjd5/XHBY6s9NxnZGKYfi4QvXtjXj1tZCy2qp6ZYawPHzwR+s=
X-Gm-Message-State: AOJu0YzhA/W3KO5MYkx9se4+KIzSnhpIKUpdxW+7gIGXexp89izS0hDl
	uXZBeJ0mr5BrAsPge3Whr6qVsX6bEIiAAI3vEPxvSjxo7TeNZv11QZaITNaCDy0jkNzL5cQ3+NK
	67SFKjuZ4hLJkdoo0CDPRsmEhBe8=
X-Google-Smtp-Source: AGHT+IHO4yjTmYXh2ornv8Qq6wIi8HQfHoEg//zzRAj+PFsb7oltHBlheoMOn8GjdDCaAvvMM9O2pzQate+LEIzQS6M=
X-Received: by 2002:a4a:d750:0:b0:5a4:7790:61b4 with SMTP id
 h16-20020a4ad750000000b005a4779061b4mr15062761oot.0.1713342301713; Wed, 17
 Apr 2024 01:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212304.10028-1-tony.luck@intel.com>
In-Reply-To: <20240416212304.10028-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:24:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZe6hC6vLoQHk7iqaf3TSu9GRkG9M879P5Vuy90Pzybg@mail.gmail.com>
Message-ID: <CAJZ5v0hZe6hC6vLoQHk7iqaf3TSu9GRkG9M879P5Vuy90Pzybg@mail.gmail.com>
Subject: Re: [PATCH v3 72/74] x86/cpu/vfm: Update tools/power/x86/turbostat/turbostat.c
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:35=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  tools/power/x86/turbostat/turbostat.c | 161 +++++++++++++++-----------
>  1 file changed, 93 insertions(+), 68 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 98256468e248..80dc3bdaa5fc 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -9,6 +9,30 @@
>
>  #define _GNU_SOURCE
>  #include MSRHEADER
> +
> +// copied from arch/x86/include/asm/cpu_device_id.h
> +#define VFM_MODEL_BIT  0
> +#define VFM_FAMILY_BIT 8
> +#define VFM_VENDOR_BIT 16
> +#define VFM_RSVD_BIT   24
> +
> +#define        VFM_MODEL_MASK  GENMASK(VFM_FAMILY_BIT - 1, VFM_MODEL_BIT=
)
> +#define        VFM_FAMILY_MASK GENMASK(VFM_VENDOR_BIT - 1, VFM_FAMILY_BI=
T)
> +#define        VFM_VENDOR_MASK GENMASK(VFM_RSVD_BIT - 1, VFM_VENDOR_BIT)
> +
> +#define VFM_MODEL(vfm) (((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
> +#define VFM_FAMILY(vfm)        (((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_=
BIT)
> +#define VFM_VENDOR(vfm)        (((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_=
BIT)
> +
> +#define        VFM_MAKE(_vendor, _family, _model) (    \
> +       ((_model) << VFM_MODEL_BIT) |           \
> +       ((_family) << VFM_FAMILY_BIT) |         \
> +       ((_vendor) << VFM_VENDOR_BIT)           \
> +)
> +// end copied section
> +
> +#define X86_VENDOR_INTEL       0
> +
>  #include INTEL_FAMILY_HEADER
>  #include <stdarg.h>
>  #include <stdio.h>
> @@ -334,7 +358,7 @@ struct platform_features {
>  };
>
>  struct platform_data {
> -       unsigned int model;
> +       unsigned int vfm;
>         const struct platform_features *features;
>  };
>
> @@ -860,73 +884,73 @@ static const struct platform_features amd_features_=
with_rapl =3D {
>  };
>
>  static const struct platform_data turbostat_pdata[] =3D {
> -       { INTEL_FAM6_NEHALEM, &nhm_features },
> -       { INTEL_FAM6_NEHALEM_G, &nhm_features },
> -       { INTEL_FAM6_NEHALEM_EP, &nhm_features },
> -       { INTEL_FAM6_NEHALEM_EX, &nhx_features },
> -       { INTEL_FAM6_WESTMERE, &nhm_features },
> -       { INTEL_FAM6_WESTMERE_EP, &nhm_features },
> -       { INTEL_FAM6_WESTMERE_EX, &nhx_features },
> -       { INTEL_FAM6_SANDYBRIDGE, &snb_features },
> -       { INTEL_FAM6_SANDYBRIDGE_X, &snx_features },
> -       { INTEL_FAM6_IVYBRIDGE, &ivb_features },
> -       { INTEL_FAM6_IVYBRIDGE_X, &ivx_features },
> -       { INTEL_FAM6_HASWELL, &hsw_features },
> -       { INTEL_FAM6_HASWELL_X, &hsx_features },
> -       { INTEL_FAM6_HASWELL_L, &hswl_features },
> -       { INTEL_FAM6_HASWELL_G, &hswg_features },
> -       { INTEL_FAM6_BROADWELL, &bdw_features },
> -       { INTEL_FAM6_BROADWELL_G, &bdwg_features },
> -       { INTEL_FAM6_BROADWELL_X, &bdx_features },
> -       { INTEL_FAM6_BROADWELL_D, &bdx_features },
> -       { INTEL_FAM6_SKYLAKE_L, &skl_features },
> -       { INTEL_FAM6_SKYLAKE, &skl_features },
> -       { INTEL_FAM6_SKYLAKE_X, &skx_features },
> -       { INTEL_FAM6_KABYLAKE_L, &skl_features },
> -       { INTEL_FAM6_KABYLAKE, &skl_features },
> -       { INTEL_FAM6_COMETLAKE, &skl_features },
> -       { INTEL_FAM6_COMETLAKE_L, &skl_features },
> -       { INTEL_FAM6_CANNONLAKE_L, &cnl_features },
> -       { INTEL_FAM6_ICELAKE_X, &icx_features },
> -       { INTEL_FAM6_ICELAKE_D, &icx_features },
> -       { INTEL_FAM6_ICELAKE_L, &cnl_features },
> -       { INTEL_FAM6_ICELAKE_NNPI, &cnl_features },
> -       { INTEL_FAM6_ROCKETLAKE, &cnl_features },
> -       { INTEL_FAM6_TIGERLAKE_L, &cnl_features },
> -       { INTEL_FAM6_TIGERLAKE, &cnl_features },
> -       { INTEL_FAM6_SAPPHIRERAPIDS_X, &spr_features },
> -       { INTEL_FAM6_EMERALDRAPIDS_X, &spr_features },
> -       { INTEL_FAM6_GRANITERAPIDS_X, &spr_features },
> -       { INTEL_FAM6_LAKEFIELD, &cnl_features },
> -       { INTEL_FAM6_ALDERLAKE, &adl_features },
> -       { INTEL_FAM6_ALDERLAKE_L, &adl_features },
> -       { INTEL_FAM6_RAPTORLAKE, &adl_features },
> -       { INTEL_FAM6_RAPTORLAKE_P, &adl_features },
> -       { INTEL_FAM6_RAPTORLAKE_S, &adl_features },
> -       { INTEL_FAM6_METEORLAKE, &cnl_features },
> -       { INTEL_FAM6_METEORLAKE_L, &cnl_features },
> -       { INTEL_FAM6_ARROWLAKE, &cnl_features },
> -       { INTEL_FAM6_LUNARLAKE_M, &cnl_features },
> -       { INTEL_FAM6_ATOM_SILVERMONT, &slv_features },
> -       { INTEL_FAM6_ATOM_SILVERMONT_D, &slvd_features },
> -       { INTEL_FAM6_ATOM_AIRMONT, &amt_features },
> -       { INTEL_FAM6_ATOM_GOLDMONT, &gmt_features },
> -       { INTEL_FAM6_ATOM_GOLDMONT_D, &gmtd_features },
> -       { INTEL_FAM6_ATOM_GOLDMONT_PLUS, &gmtp_features },
> -       { INTEL_FAM6_ATOM_TREMONT_D, &tmtd_features },
> -       { INTEL_FAM6_ATOM_TREMONT, &tmt_features },
> -       { INTEL_FAM6_ATOM_TREMONT_L, &tmt_features },
> -       { INTEL_FAM6_ATOM_GRACEMONT, &adl_features },
> -       { INTEL_FAM6_ATOM_CRESTMONT_X, &srf_features },
> -       { INTEL_FAM6_ATOM_CRESTMONT, &grr_features },
> -       { INTEL_FAM6_XEON_PHI_KNL, &knl_features },
> -       { INTEL_FAM6_XEON_PHI_KNM, &knl_features },
> +       { INTEL_NEHALEM, &nhm_features },
> +       { INTEL_NEHALEM_G, &nhm_features },
> +       { INTEL_NEHALEM_EP, &nhm_features },
> +       { INTEL_NEHALEM_EX, &nhx_features },
> +       { INTEL_WESTMERE, &nhm_features },
> +       { INTEL_WESTMERE_EP, &nhm_features },
> +       { INTEL_WESTMERE_EX, &nhx_features },
> +       { INTEL_SANDYBRIDGE, &snb_features },
> +       { INTEL_SANDYBRIDGE_X, &snx_features },
> +       { INTEL_IVYBRIDGE, &ivb_features },
> +       { INTEL_IVYBRIDGE_X, &ivx_features },
> +       { INTEL_HASWELL, &hsw_features },
> +       { INTEL_HASWELL_X, &hsx_features },
> +       { INTEL_HASWELL_L, &hswl_features },
> +       { INTEL_HASWELL_G, &hswg_features },
> +       { INTEL_BROADWELL, &bdw_features },
> +       { INTEL_BROADWELL_G, &bdwg_features },
> +       { INTEL_BROADWELL_X, &bdx_features },
> +       { INTEL_BROADWELL_D, &bdx_features },
> +       { INTEL_SKYLAKE_L, &skl_features },
> +       { INTEL_SKYLAKE, &skl_features },
> +       { INTEL_SKYLAKE_X, &skx_features },
> +       { INTEL_KABYLAKE_L, &skl_features },
> +       { INTEL_KABYLAKE, &skl_features },
> +       { INTEL_COMETLAKE, &skl_features },
> +       { INTEL_COMETLAKE_L, &skl_features },
> +       { INTEL_CANNONLAKE_L, &cnl_features },
> +       { INTEL_ICELAKE_X, &icx_features },
> +       { INTEL_ICELAKE_D, &icx_features },
> +       { INTEL_ICELAKE_L, &cnl_features },
> +       { INTEL_ICELAKE_NNPI, &cnl_features },
> +       { INTEL_ROCKETLAKE, &cnl_features },
> +       { INTEL_TIGERLAKE_L, &cnl_features },
> +       { INTEL_TIGERLAKE, &cnl_features },
> +       { INTEL_SAPPHIRERAPIDS_X, &spr_features },
> +       { INTEL_EMERALDRAPIDS_X, &spr_features },
> +       { INTEL_GRANITERAPIDS_X, &spr_features },
> +       { INTEL_LAKEFIELD, &cnl_features },
> +       { INTEL_ALDERLAKE, &adl_features },
> +       { INTEL_ALDERLAKE_L, &adl_features },
> +       { INTEL_RAPTORLAKE, &adl_features },
> +       { INTEL_RAPTORLAKE_P, &adl_features },
> +       { INTEL_RAPTORLAKE_S, &adl_features },
> +       { INTEL_METEORLAKE, &cnl_features },
> +       { INTEL_METEORLAKE_L, &cnl_features },
> +       { INTEL_ARROWLAKE, &cnl_features },
> +       { INTEL_LUNARLAKE_M, &cnl_features },
> +       { INTEL_ATOM_SILVERMONT, &slv_features },
> +       { INTEL_ATOM_SILVERMONT_D, &slvd_features },
> +       { INTEL_ATOM_AIRMONT, &amt_features },
> +       { INTEL_ATOM_GOLDMONT, &gmt_features },
> +       { INTEL_ATOM_GOLDMONT_D, &gmtd_features },
> +       { INTEL_ATOM_GOLDMONT_PLUS, &gmtp_features },
> +       { INTEL_ATOM_TREMONT_D, &tmtd_features },
> +       { INTEL_ATOM_TREMONT, &tmt_features },
> +       { INTEL_ATOM_TREMONT_L, &tmt_features },
> +       { INTEL_ATOM_GRACEMONT, &adl_features },
> +       { INTEL_ATOM_CRESTMONT_X, &srf_features },
> +       { INTEL_ATOM_CRESTMONT, &grr_features },
> +       { INTEL_XEON_PHI_KNL, &knl_features },
> +       { INTEL_XEON_PHI_KNM, &knl_features },
>         /*
>          * Missing support for
> -        * INTEL_FAM6_ICELAKE
> -        * INTEL_FAM6_ATOM_SILVERMONT_MID
> -        * INTEL_FAM6_ATOM_AIRMONT_MID
> -        * INTEL_FAM6_ATOM_AIRMONT_NP
> +        * INTEL_ICELAKE
> +        * INTEL_ATOM_SILVERMONT_MID
> +        * INTEL_ATOM_AIRMONT_MID
> +        * INTEL_ATOM_AIRMONT_NP
>          */
>         { 0, NULL },
>  };
> @@ -951,11 +975,12 @@ void probe_platform_features(unsigned int family, u=
nsigned int model)
>                 return;
>         }
>
> -       if (!genuine_intel || family !=3D 6)
> +       if (!genuine_intel)
>                 return;
>
>         for (i =3D 0; turbostat_pdata[i].features; i++) {
> -               if (turbostat_pdata[i].model =3D=3D model) {
> +               if (VFM_FAMILY(turbostat_pdata[i].vfm) =3D=3D family &&
> +                   VFM_MODEL(turbostat_pdata[i].vfm) =3D=3D model) {
>                         platform =3D turbostat_pdata[i].features;
>                         return;
>                 }
> --
> 2.44.0
>
>

