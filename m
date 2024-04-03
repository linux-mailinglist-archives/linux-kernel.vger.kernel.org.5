Return-Path: <linux-kernel+bounces-129988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B18972E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C821F28729
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006DD13A411;
	Wed,  3 Apr 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCGzBImM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A433EA73;
	Wed,  3 Apr 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155409; cv=none; b=Mvc4jxU/VPNk1XkpfWC52fZbp6DCmUwr8lFFpB/2LiEfIVz9mwDcj058LNW34oTNZqCdMTgxyBPxpZD2o3TEnjy3F3SUsoCVAOWhv1aUmFZFWM+hQQNw26PTId5tNL88EIkWUd78c/bJ7YK7e1UFhReCLHY3uXZ+xRzXkrOLJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155409; c=relaxed/simple;
	bh=tlMXic5oKCPutcJcCKDaFWginzrmNtARXxwOC45KnC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSPrjjPZgYv7na2osdXSkhLQGledACB3XRKQrHgaHRU8Xs6iYYvSIm8V3U0g+kfl+OT1yx6Cg0xtjhmBhtpxxXxcJLtNiZAfZiSKAINGPnPVadDeUrAQwefHBC2t1l+glGN0wV0sln4McV6klJr71qfYLlV4utdFFiZpzVvNpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCGzBImM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB23EC433F1;
	Wed,  3 Apr 2024 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712155408;
	bh=tlMXic5oKCPutcJcCKDaFWginzrmNtARXxwOC45KnC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XCGzBImMMzVRsDylX+t3VTpNLsGrdGFgCh1wXexTKatY5hFrFKDzW8TOxSKEtEl/v
	 ODofAhsYnqz2yzN61kbLvpJQesHBJCgVNHOQ9RB77QXbq/WKBJwBI9F87x8wiFYOVa
	 TnyRZArwCkC/JP0tpIw4ywQShKpfjl1nS8wKSEhWsu4CgmCbLxCwYiK3kFWBbvOfP0
	 +IpGXBw1BI/ht9ayxhk0/tK3WUTtUSOEdpoVfNWHyUtiXyo4TMtrPUzkQlN+ii+IbL
	 pTvIE5eUsY/Lw0CmKLSYmtNsC2LaB2MbQtyPJNuYp/BdDlLu+ZMyJEps6IpA2D7e9f
	 UtuXL79SQ0Ypw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a46b30857bso1558204eaf.1;
        Wed, 03 Apr 2024 07:43:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/LtEzPFiXTD+CYbMsHRw2T8tceN36HXTu5Xia2OKVUBYEbU+iE3WsqsAIgj6EHLY7OkA1q2JTWRIggxdsxbWmPS9DRwV4zdM=
X-Gm-Message-State: AOJu0YyWSehabvYrZQk4NK4otiU7YN9yMsuzCSl9A46w/ZG1SydXrPoE
	jOqVpbD6bZ1oPSkr2P5cNtwYJ5hbczCodzI83zY8BkSPU+OsLSk0AmDKMtIneVpcxtkVz7a99wz
	TT0woulEUqyG2ODPhSs4f6co4JPo=
X-Google-Smtp-Source: AGHT+IEktw5KB/rO4P7FHx+97yBpFU6a3DwE9hteSSSp0VzoxobMNIFalE+vbxCWftFVT8YNghIaWQta0VRV3b7UVtY=
X-Received: by 2002:a4a:a9ca:0:b0:5a5:2d09:4fdc with SMTP id
 h10-20020a4aa9ca000000b005a52d094fdcmr14212464oon.1.1712155408036; Wed, 03
 Apr 2024 07:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-28-arnd@kernel.org>
In-Reply-To: <20240403080702.3509288-28-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Apr 2024 16:43:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hDFLvqnKTMtee3m52tUDzW7HH41TorVEx4Ea+JSxUN+w@mail.gmail.com>
Message-ID: <CAJZ5v0hDFLvqnKTMtee3m52tUDzW7HH41TorVEx4Ea+JSxUN+w@mail.gmail.com>
Subject: Re: [PATCH 27/34] cpufreq: intel_pstate: hide unused intel_pstate_cpu_oob_ids[]
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Doug Smythies <dsmythies@telus.net>, Zhenguo Yao <yaozhenguo1@gmail.com>, 
	Tero Kristo <tero.kristo@linux.intel.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:11=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The reference to this variable is hidden in an #ifdef:
>
> drivers/cpufreq/intel_pstate.c:2440:32: error: 'intel_pstate_cpu_oob_ids'=
 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Use the same check around the definition.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index dbbf299f4219..29ce9edc6f68 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2437,6 +2437,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
>
> +#ifdef CONFIG_ACPI
>  static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst =
=3D {
>         X86_MATCH(BROADWELL_D,          core_funcs),
>         X86_MATCH(BROADWELL_X,          core_funcs),
> @@ -2445,6 +2446,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob=
_ids[] __initconst =3D {
>         X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
>         {}
>  };
> +#endif
>
>  static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] =3D {
>         X86_MATCH(KABYLAKE,             core_funcs),
> --

Applied as 6.10 material, thanks!

