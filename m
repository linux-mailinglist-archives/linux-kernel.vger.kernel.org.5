Return-Path: <linux-kernel+bounces-122416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06188F703
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1464B1F24B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EB2E62C;
	Thu, 28 Mar 2024 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbEKRtXz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928579ED
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602734; cv=none; b=D4ApWgy9llLGmh4YiDTFA0XdsEmV1QIQcyyeEZNRl3rQz4Kl3humU/62Z2she0VzXcLUTAIwXJaZL7E0WQg3Dnnwyyz0eoL86Rluf2wx4YqmAcNAD9qy7WnbtU92aW4Wm8ere7TnRo6CK+Lfh7LTQkIQph3tNF5pHrTkdykMoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602734; c=relaxed/simple;
	bh=gexJfflusgQ/GyqAw3FQjyewcbI2QUIs6xMnySU3dLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyFln8Qa++jsKewTbs+Rjo3BUWCrryWpKjBOBZ3zXQ8fKj8AUpYDo+dKL4OuodUEownpoUpJJjOV3NbKid/gmdo+uNAtLPNKfZTPCpNdV4xYfy8A8NNseQ1C6jrHfHRzwIRyQY0e0hi1TPzZLQvN4hUy8XvC4kTwQazG5/+u8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbEKRtXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A18DC43394
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711602733;
	bh=gexJfflusgQ/GyqAw3FQjyewcbI2QUIs6xMnySU3dLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JbEKRtXzCanI6FL0vzasXRadw+Z3f9WTW8phi5PDvoMbuec8w/ODS05gUZ4Ic0f8D
	 hofh5t6wyrujcYL9RzvgXhESWst2QE145g+Q8lk6be2iySwDAn58swNk1SlFojCAbI
	 Z1xmPjSza79OwVCXwuIcxBo+PQ32nu2nkx8IH7K6ChMqqxfhN3WlnYDWU1VXeUATou
	 7luLK+upPTks6Eina9+dXvrXWKdnRjWV2zWrAao2kS001KIyUb7IOnrDq4GRalywuD
	 Dtwkf6yn9ZNIiYxP3hhlLB3xioWkl+QLb/WFhkVnXJ2SqzvdpCq6D4xUVW2e3PutSc
	 MsSTRmbTfhzSQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2684029a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBSX4ROMfUTBM4Nnh//61pi8v6roaJe9K/XxZBwadtpSdfZgWsC45OwULJF3bDGHVII6Fp7C/5iE0q4/bMI1iaS2I1Lpmza9CPgGOF
X-Gm-Message-State: AOJu0YxNPPxoMSI5sTqieCsCYpVKO3gFclHsnwbIWADP07DeCJS8FFLu
	d3yx6Hrg7ENAJ2H2L1Asu/umT3TmOs/NQvbs1YPBkQ1K2WIIO3Lpbup1XTYvCRPbGrtHwja5iRy
	pNY8klLOOnD2YCMiCAJaKV5eAeYEsyj7oAQPB2Q==
X-Google-Smtp-Source: AGHT+IF5JFRIO2nhg/69SM6oEIdMb4hGXaeUL+g9pMxCflNLtr+2xSZ6szW2nsQJFaTGuU/BwhHj2+7ivLaNDW74SfU=
X-Received: by 2002:a17:906:8415:b0:a46:d786:3672 with SMTP id
 n21-20020a170906841500b00a46d7863672mr1101436ejx.13.1711602732038; Wed, 27
 Mar 2024 22:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328050230.31770-1-quic_priyjain@quicinc.com>
In-Reply-To: <20240328050230.31770-1-quic_priyjain@quicinc.com>
From: Amit Kucheria <amitk@kernel.org>
Date: Thu, 28 Mar 2024 10:42:00 +0530
X-Gmail-Original-Message-ID: <CAHLCerPfkWfg2bYP3SK+dPXsu6Yh1w_pCBj8SztGhfffYFnxsA@mail.gmail.com>
Message-ID: <CAHLCerPfkWfg2bYP3SK+dPXsu6Yh1w_pCBj8SztGhfffYFnxsA@mail.gmail.com>
Subject: Re: [PATCH v5] thermal/drivers/tsens: Add suspend to RAM support for tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:33=E2=80=AFAM Priyansh Jain
<quic_priyjain@quicinc.com> wrote:
>
> As part of suspend to RAM, tsens hardware will be turned off.
> While resume callback, re-initialize tsens hardware.
>
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
> V4 -> V5: Remove unused spinlock from tsens_reinit function.
> V3 -> V4: Make tsens_reinit function specific to tsens v2. Add
> NULL resume callback support for platform whose versions < ver_2_x
> in tsens ops.
> V2 -> V3: Remove suspend callback & interrupt enablement part from
> resume callback.
> V1 -> V2: Update commit text to explain the necessity of this patch.
>
>  drivers/thermal/qcom/tsens-v2.c |  1 +
>  drivers/thermal/qcom/tsens.c    | 31 +++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h    |  5 +++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens=
-v2.c
> index 29a61d2d6ca3..0cb7301eca6e 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[MAX_=
REGFIELDS] =3D {
>  static const struct tsens_ops ops_generic_v2 =3D {
>         .init           =3D init_common,
>         .get_temp       =3D get_temp_tsens_valid,
> +       .resume         =3D tsens_resume_common,
>  };
>
>  struct tsens_plat_data data_tsens_v2 =3D {
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 6d7c16ccb44d..1c9df4f84641 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -17,6 +17,7 @@
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/thermal.h>
>  #include "../thermal_hwmon.h"
>  #include "tsens.h"
> @@ -1193,6 +1194,36 @@ static int tsens_register_irq(struct tsens_priv *p=
riv, char *irqname,
>         return ret;
>  }
>
> +#ifdef CONFIG_SUSPEND
> +static int tsens_reinit(struct tsens_priv *priv)
> +{
> +       if (tsens_version(priv) >=3D VER_2_X) {
> +               /*
> +                * Re-enable the watchdog, unmask the bark.
> +                * Disable cycle completion monitoring
> +                */
> +               if (priv->feat->has_watchdog) {
> +                       regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +                       regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +               }
> +
> +               /* Re-enable interrupts */
> +               tsens_enable_irq(priv);
> +       }
> +
> +       return 0;
> +}
> +
> +int tsens_resume_common(struct tsens_priv *priv)
> +{
> +       if (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM)
> +               tsens_reinit(priv);
> +
> +       return 0;
> +}
> +
> +#endif /* !CONFIG_SUSPEND */
> +
>  static int tsens_register(struct tsens_priv *priv)
>  {
>         int i, ret;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index cb637fa289ca..cab39de045b1 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -634,6 +634,11 @@ void compute_intercept_slope(struct tsens_priv *priv=
, u32 *pt1, u32 *pt2, u32 mo
>  int init_common(struct tsens_priv *priv);
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>  int get_temp_common(const struct tsens_sensor *s, int *temp);
> +#ifdef CONFIG_SUSPEND
> +int tsens_resume_common(struct tsens_priv *priv);
> +#else
> +#define tsens_resume_common            NULL
> +#endif
>
>  /* TSENS target */
>  extern struct tsens_plat_data data_8960;
> --
> 2.17.1
>

