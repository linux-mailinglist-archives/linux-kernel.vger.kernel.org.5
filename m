Return-Path: <linux-kernel+bounces-8262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A581B4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94031C23317
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478736ABB4;
	Thu, 21 Dec 2023 11:07:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DE4120C;
	Thu, 21 Dec 2023 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba32e9554bso152237b6e.1;
        Thu, 21 Dec 2023 03:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703156820; x=1703761620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFySEnepUE+tDIi+pM++FTPD8l5vR/6BAzQA3Eq9QBI=;
        b=TcN/a1CMQhkmPbONm+8IZ+nttxmPSze4HZOdv7QTISbjc1Gz2egch1Z38sYz+cUlO4
         pEmNe9s69Pocy4cUvxhnzzJvhyD1QciYHTec9wMdfYBOMrqLzH6rQGv5Y/ID+7aeGA/g
         MZS+n0mbkqbFa+Uu3XfZ54nK5oIvuDBG55T79rexiafKgGAjREzzQwaTruMRMUjcqZQG
         lBS3oeNYWTIR4QUeGbm2LYgzgMMWb72q6asP5gErOBJUgDkSUnoyLhUXl710bY/OIenV
         5xJolMj+swlfAfBrrw5e/ztrS1MKZ4V7mtcBcWmnEhwv8448MazJ+LfuI7PZ387GZA9J
         FhSA==
X-Gm-Message-State: AOJu0Yynb84NzQ4dHxwAW5r9pOUSvx4OHfqYL2jnV3F/Z6kSITslm4BY
	1KrKxmDZz+gIDEJi60RpmI4vK357n9ubxtRnt70=
X-Google-Smtp-Source: AGHT+IFccL6Z2EozfxozVM+x3rnOqtP5HKLCPF2ejd6EdNcwGQZ4mIq/rAebsMlg8Gb8tYZb2RRqGanQUw3wiHS8YAo=
X-Received: by 2002:a05:6820:2484:b0:591:4861:6b02 with SMTP id
 cq4-20020a056820248400b0059148616b02mr25687361oob.1.1703156820529; Thu, 21
 Dec 2023 03:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221055144.24862-1-rdunlap@infradead.org>
In-Reply-To: <20231221055144.24862-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 12:06:48 +0100
Message-ID: <CAJZ5v0j5mcxRMQR3T+tmuL89Y+GjrWYwK_hj+fYikczp=Ey3Fw@mail.gmail.com>
Subject: Re: [PATCH] thermal: cpuidle_cooling: fix kernel-doc warning and a spello
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 6:51=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Correct one misuse of kernel-doc notation and one spelling error as
> reported by codespell.
>
> cpuidle_cooling.c:152: warning: cannot understand function prototype: 'st=
ruct thermal_cooling_device_ops cpuidle_cooling_ops =3D '
>
> For the kernel-doc warning, don't use "/**" for a comment on data.
> kernel-doc can be used for structure declarations but not definitions.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/thermal/cpuidle_cooling.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_coo=
ling.c
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -66,7 +66,7 @@ static unsigned int cpuidle_cooling_runt
>   * @state : a pointer to the state variable to be filled
>   *
>   * The function always returns 100 as the injection ratio. It is
> - * percentile based for consistency accross different platforms.
> + * percentile based for consistency across different platforms.
>   *
>   * Return: The function can not fail, it is always zero
>   */
> @@ -146,7 +146,7 @@ static int cpuidle_cooling_set_cur_state
>         return 0;
>  }
>
> -/**
> +/*
>   * cpuidle_cooling_ops - thermal cooling device ops
>   */
>  static struct thermal_cooling_device_ops cpuidle_cooling_ops =3D {

Applied as 6.8 material, thanks!

