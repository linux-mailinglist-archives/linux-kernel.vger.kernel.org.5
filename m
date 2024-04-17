Return-Path: <linux-kernel+bounces-148133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411268A7E23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87E7B24098
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB47F470;
	Wed, 17 Apr 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxmhXOcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746E7D08F;
	Wed, 17 Apr 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342222; cv=none; b=JSsQOFb3C463TFUv0YCNvwx6GzQi26FHjH+0vpIrfjtaLhjsawy28I/Qq6jX9GXJrcy27qFm7HAG1lH82qRkD9mVAZx2bkZaCfANZZysAbUDxcVRUMcebK+OX2qOmJhU4vZloFBLEdkMG06Xi2YJHHYAIk+ij/gN5bDoQJ6xO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342222; c=relaxed/simple;
	bh=PzPHik40qRXIBSVgn8cohGP5vcPZ5pS+tPSMejQQd/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiuNgs8moXzZAwaPBK1Ps25qAG1nsw5KZD4RFnduy0vd++gRMPTMhtzR0HSId02TQH9NeMyuF/f4M46BvX8ibUUliMt4ce6MWGs/YRPWvns0rdcOunnzbL1vwdNHuDbFVXX5kW6bQ7qZZywdOtgQszbQcY7ZNVtzujsBpe7zaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxmhXOcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF89C32783;
	Wed, 17 Apr 2024 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342222;
	bh=PzPHik40qRXIBSVgn8cohGP5vcPZ5pS+tPSMejQQd/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kxmhXOcfK1s70GAFXkusWRsmemGoM96wlbixK7Nr2awefw+Pyu2hZ0k5PnSDAMp9G
	 mQCDsPWQAvCDF7Y2zDq9oQvr1IfNdX741Wmy8XYNufSoFvnqh/NuEpRIBS8o9DD/vP
	 22Hye1mBtRaYlVLNaG/Tx5jnYCo0NDk6skoroeXV9L04JhWJCyeS8jKxqyW/DmXb+r
	 zg4hVXRxT994iuvf6FsTrXCCsKwRmpymy2o+iwKADqQcXiGdoSGntzAAj0BnRmxnQe
	 Ih+p8D9/seWRrV4mIz3r0fLQzKd6CZgwYwB1kBc1i4PNcUTobDZLvlNcKOCGmqhXxO
	 toQxkmD7t0dMQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5acdbfa6e94so219403eaf.2;
        Wed, 17 Apr 2024 01:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxwc5eFIzRmn/WReR00j66b/AXXt/E+lOAQ5gWW9Ki3Ter2BNEhkuVtN8RQzg3bkd+gZMmjSwY5INKXHEq/ZKQ/gwmC2vAG2w=
X-Gm-Message-State: AOJu0YwE5zravoQKvjSkNeb6IOwSeztCIpDuDgtzqMESjAIHmyzTg804
	vggM929IrP9e4S9aga/TK2Jm7ame6QA5U60PF3TjdiXbDcTVeGr9ZxmmE4BZQF4MaYsO1sYf+3J
	oBBULpmQCmKXE3Ys4BIW30Rgd4Cw=
X-Google-Smtp-Source: AGHT+IH1XjxoGzsvqQtx3bEx7chObybM4zt/f7CX8mNjAGCQHR4R08+7Ry9J3HF1+jeyaNqa+ZQZALpDbfudkTJVwz8=
X-Received: by 2002:a05:6820:4187:b0:5ac:6fc1:c2cb with SMTP id
 fk7-20020a056820418700b005ac6fc1c2cbmr15325939oob.0.1713342221549; Wed, 17
 Apr 2024 01:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212253.9989-1-tony.luck@intel.com>
In-Reply-To: <20240416212253.9989-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:23:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmrWw-imb1Vr18LqmkdPVxquJPn0dH3N486-mUikPagg@mail.gmail.com>
Message-ID: <CAJZ5v0jmrWw-imb1Vr18LqmkdPVxquJPn0dH3N486-mUikPagg@mail.gmail.com>
Subject: Re: [PATCH v3 70/74] x86/cpu/vfm: Update drivers/thermal/intel/intel_tcc_cooling.c
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, patches@lists.linux.dev
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
>  drivers/thermal/intel/intel_tcc_cooling.c | 30 +++++++++++------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/=
intel/intel_tcc_cooling.c
> index 6c392147e6d1..63696e7d7b3c 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -49,21 +49,21 @@ static const struct thermal_cooling_device_ops tcc_co=
oling_ops =3D {
>  };
>
>  static const struct x86_cpu_id tcc_ids[] __initconst =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> +       X86_MATCH_VFM(INTEL_SKYLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_SKYLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_ICELAKE, NULL),
> +       X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
>         {}
>  };
>
> --
> 2.44.0
>

