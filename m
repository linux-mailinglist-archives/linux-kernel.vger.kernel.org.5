Return-Path: <linux-kernel+bounces-148130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCD8A7E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8268DB2593B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871157E799;
	Wed, 17 Apr 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dogaSANW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69D200D2;
	Wed, 17 Apr 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342150; cv=none; b=XC7q6bLftsRnOcemx0DRflL2w6wLyJuyzCJODgwhY+ViXuCbJvqko201wscAG8UbPLO0SoILgfc1iN7WMIfr/AuEvH5jKUGzyfW5gagH7nfSSN35KfCbXh8W7TTJFCwN8eYMmSI5nET+XNGINcZJt+cMOhhkT1jOGVEZ5OW+Gt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342150; c=relaxed/simple;
	bh=vxL+yxEBtW69wT2VNPtV3o2n6+YTBPYdeGmwrvtUUYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULsyIpOciG3Zp0KeGBfHGlvcehKpBXZm6h9O5fTousx38zJ0DEpBhn5avPupi/E5G6pzCRPce0lW2HHZW4HVzWMamx0eWQTRBEQEQbkF1Sv5c0KpWMCaiBAAWkkg5axCqF+iSioeYjvU3xIZDLW/quiV11mkR5HSNG+FEQiqI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dogaSANW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A324FC072AA;
	Wed, 17 Apr 2024 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342150;
	bh=vxL+yxEBtW69wT2VNPtV3o2n6+YTBPYdeGmwrvtUUYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dogaSANWv2AzM5+rClXb1dimseX9oKu/we3riLUBqQ5+mS6q7bGPetgZPkCQHvFEa
	 djOxTqbQLPIJNNqQq6Q794U/zcMiv2ksLhKDyjjcrBo1W1v4jocPVN0MwxGY4wQmDa
	 ieb9jevlcp3HSFuJOjx/X4dd85q/5fraTZMIsxXZdPWRKd/lpgs82ipEna7i+EDBIw
	 g56OJR9vz2+oDG7e/Y9RCNYYXB9nKJf317qGCUek9uGrGJcOTR3CncpEYJ8wD8Fqx+
	 UTYx99XkpC10r+zq+2qp0ylkfWcT9+N2LkhZyq6z7+mrifsUOrFU11S4iCKsSvgD3Y
	 SK6944R91yjgA==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eba841d83cso51078a34.2;
        Wed, 17 Apr 2024 01:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw0hVFuZSeWHzLhPIpcRk6DqI3p9AOk/vnvB5DbpI6lRtncKQQv460UKEbkPjfDNFUPuxog/A1nRX8XUQhypmuqNl98xMaUTc=
X-Gm-Message-State: AOJu0YydzgSB7KoNPbJ6PGlgzKjYdBejYkg/o6BY9taoQa57NCkebtCF
	e02NtxDRl5vC7h5Yy6cfgLCPCbbyFOD24RJoep9gDXUUmMfi8oO0L5fQtF7q1t+B/asYPXrRq2r
	TgDT4u1mtp48UK94nUv2PXIlxfUg=
X-Google-Smtp-Source: AGHT+IFrSekiz2ow8oMM1nzzDDUyICAfK9eLF583H9K9wsJGYqysgZFcvoUQKjCJpVjwMuMvfXAQPk4VISJFQP+//g8=
X-Received: by 2002:a4a:e9f0:0:b0:5aa:6a31:4f53 with SMTP id
 w16-20020a4ae9f0000000b005aa6a314f53mr13550582ooc.0.1713342150021; Wed, 17
 Apr 2024 01:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212245.9929-1-tony.luck@intel.com>
In-Reply-To: <20240416212245.9929-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:22:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFqbysg5Qm2SD+Y2QqONAxbUnOOKA2viCxoGnFzVxpgw@mail.gmail.com>
Message-ID: <CAJZ5v0gFqbysg5Qm2SD+Y2QqONAxbUnOOKA2viCxoGnFzVxpgw@mail.gmail.com>
Subject: Re: [PATCH v3 67/74] x86/cpu/vfm: Update drivers/powercap/intel_rapl_msr.c
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, patches@lists.linux.dev
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
>  drivers/powercap/intel_rapl_msr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index 35cb152fa9aa..733a36f67fbc 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -139,14 +139,14 @@ static int rapl_msr_write_raw(int cpu, struct reg_a=
ction *ra)
>
>  /* List of verified CPUs. */
>  static const struct x86_cpu_id pl4_support_ids[] =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
> +       X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
>         {}
>  };
>
> --
> 2.44.0
>

