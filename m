Return-Path: <linux-kernel+bounces-146712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458EB8A69B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7861F216F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955A129A67;
	Tue, 16 Apr 2024 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEzc3L2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B466127B4E;
	Tue, 16 Apr 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267441; cv=none; b=PuTKhcr6sA1G53RiF1nhOYEhsf+YkiNrV/yulK4l24STWnC0f/xD7UnvUktQj01Pmzz6HvATvMAeWA99OkW43FLztgGg2wVWv8FwHszx9e1u1yTf/ivQEuAh47j85o5cMFnViJeAQutbNcLXcmSGSphvirRwkYkbl8e1F879dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267441; c=relaxed/simple;
	bh=UyxbjKiyQT2TSVa74a/Hvt0YwGCTEEk9gpdwaddw9QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV5oz2mQ3UB4U3S4Dt2bJurCpA75IrI/WHTapKdsrNcj8A3DXOZZ/QMbNR1HjQeKtZI3ym4Xz+ckYWNMcF/pe8XjkyZpaakYNukQT1xIbcT4omXymTMXQY20KPB+ZL5qPp4D5dKmVQg1I+QCihEDSXmqOfeXTcnSMhJqHvnEap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEzc3L2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C659DC3277B;
	Tue, 16 Apr 2024 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713267440;
	bh=UyxbjKiyQT2TSVa74a/Hvt0YwGCTEEk9gpdwaddw9QI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CEzc3L2WfroEpK0zLJEoXgFcP7cXMaHNPbNfWRvSq3jupWQt7Et44r3snPc/knUGr
	 ObHzwLgwevlzeJO59r1cyJ2N85mdFbHbkSe7lpkq4pbq3DsNvIfdzp/jD9TadrJ3FZ
	 fH0WK4ptWwxf20/QWsPGYkvQbffSzkg1yEi8yBrU74QQ8Kak9ZYu+KTAh2xCEH13h3
	 peParTvmRIWSET1USE8y/iK9nhNFdSEbyaC0b22vDZwl4Gy8LiKyyuP0q4Onc9nefa
	 ghgn9h+0aT3Fo6eGYqLg+FojWdy2vkQRytwDeu8NsWzgVP1q/g6+bKBOEqtsX4t1fv
	 wH4qz8Z5fV7Cw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aca32d3f78so707346eaf.1;
        Tue, 16 Apr 2024 04:37:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpI5X/KzxVVYZOgIDHhqryyU533wss2E+G1/8mR0ztomTb6YiZBYZpnJ1ZWZr57DJlJtUAYKhg0v4iTcfEYqdJEwDwRUNuCXk9VVpwEenb5pGmbQTXj6Ya1CgCw/ThzhdR7yOsGBI=
X-Gm-Message-State: AOJu0YzFl5ShfU7/VV0VSzcxqMethHgICIODyboXZB3smO11po1157LN
	uSgm7SXI+x9VnG3+sbvIVF0IAeFCmUqyS8+WTVY8tUdniLqmz8crisuHO4CV/keEwJpepthvtJS
	SVvyXrzjAEhTnpVfzs9m/tIjIkx8=
X-Google-Smtp-Source: AGHT+IEY7Mo6AwubDZGT6wjxJ03CgcDJZG8cuE8RjfcYK0Yjqd5F4BwbEMXKErQ24aKFqmarhYO77+Az2Aol/GWWaik=
X-Received: by 2002:a05:6870:7099:b0:22e:88bd:6b26 with SMTP id
 v25-20020a056870709900b0022e88bd6b26mr14636512oae.3.1713267440099; Tue, 16
 Apr 2024 04:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408040548.249664-1-rui.zhang@intel.com>
In-Reply-To: <20240408040548.249664-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Apr 2024 13:37:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoEnDn5Cqi51924ZpO2sGu+ip1LUQdVA68atmK4gWXHw@mail.gmail.com>
Message-ID: <CAJZ5v0hoEnDn5Cqi51924ZpO2sGu+ip1LUQdVA68atmK4gWXHw@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for ArrowLake-H platform
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:06=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:
>
> Add support for ArrowLake-H platform.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index a28d54fd5222..c02851c73751 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1263,6 +1263,7 @@ static const struct x86_cpu_id rapl_ids[] __initcon=
st =3D {
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_sp=
r_server),
>         X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,     &rapl_defaults_sp=
r_server),
>         X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,         &rapl_defaults_co=
re),
> +       X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,         &rapl_defaults_co=
re),
>         X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,           &rapl_defaults_co=
re),
>         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_co=
re),
>
> --

Applied as 6.10 material, thanks!

