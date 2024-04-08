Return-Path: <linux-kernel+bounces-134795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0789B700
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E7E2812F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F06FC3;
	Mon,  8 Apr 2024 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDLEQU8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034231869;
	Mon,  8 Apr 2024 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712551742; cv=none; b=M4kNVeY+GXCrzLGnX7snKycXRcm/sgYerzlR8BzgWElnl24Q7GX5wixt5cEt6peJlfKT2bGk7hKMGBf1eUeFgYnP1/kEUFVcrUU3Ti6riJVv6xoLlIfLsehcY2DY33acEXDuSmZAoeN+zI5n19QN2aom+Nf8M6ymsXIhFfNkm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712551742; c=relaxed/simple;
	bh=y0uQm0GWht2PsG/ONzt4jj/tppBT8a3wXPqhnjmD6TA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kuNcfxBmYWvoxdg7C2tySKo+jBBXOMnWm46RaBm3rAY+yzjfBT4veF9HtxaVdXPhINWn/+286uEeCQ0eGt+gWJCgead+ArYMQ205PLdnrR6l/8Mubmzs13GWgjLTuyzSPoBzPcH40hm52WNWabCj5yGYKP9I3o+8o7ZnGy8h3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDLEQU8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D48C433C7;
	Mon,  8 Apr 2024 04:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712551741;
	bh=y0uQm0GWht2PsG/ONzt4jj/tppBT8a3wXPqhnjmD6TA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QDLEQU8bkkwb7veH38llOXWkW5TsvpjXoGgd8rBgH0kHOwSMJkorCHfKXArPuAyaE
	 OMv/0+Am4jpwcJQFHVyL5QYncHJ5D1IG9FIi4AiTwsJgR2+6L2O90R3kiSjszNcN+b
	 70+O0DL7gEHuhF+2m3zczw4LcLqhL94SOhl2vexmp5Sv+zKkW0qErI17ALnTx37vkv
	 9lXuXGobwjg2WGN79k5jWqiGQJkZxLmPDytpqcQ9IRiWhhijwguF+QCvRg6ggiA8jw
	 cb7U28wZrGYlJ2SDyinKknVEwkyqFjUhTjp84PYBH2t53PZmoqf30Bv+1XcKjb73Ya
	 BdOGwr3tm7HJQ==
Message-ID: <90ac6d2dce33e8078db7cb5681fb94d7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325210025.1448717-3-cristian.marussi@arm.com>
References: <20240325210025.1448717-1-cristian.marussi@arm.com> <20240325210025.1448717-3-cristian.marussi@arm.com>
Subject: Re: [PATCH v2 2/5] clk: scmi: Add support for state control restricted clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, mturquette@baylibre.com, Cristian Marussi <cristian.marussi@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 07 Apr 2024 21:48:59 -0700
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-03-25 14:00:22)
> Some exposed SCMI Clocks could be marked as non-supporting state changes.
> Configure a clk_ops descriptor which does not provide the state change
> callbacks for such clocks when registering with CLK framework.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/clk/clk-scmi.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index d5d369b052bd..fc9603988d91 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -18,6 +18,7 @@
> =20
>  enum scmi_clk_feats {
>         SCMI_CLK_ATOMIC_SUPPORTED,
> +       SCMI_CLK_STATE_CTRL_FORBIDDEN,

Can it be positive, i.e. SCMI_CLK_STATE_CTRL_SUPPORTED?

>         SCMI_CLK_MAX_FEATS
>  };
> =20
> @@ -230,15 +231,19 @@ scmi_clk_ops_alloc(struct device *dev, unsigned lon=
g feats_key)
>          * only the prepare/unprepare API, as allowed by the clock framew=
ork
>          * when atomic calls are not available.
>          */
> -       if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
> -               ops->enable =3D scmi_clk_atomic_enable;
> -               ops->disable =3D scmi_clk_atomic_disable;
> -               ops->is_enabled =3D scmi_clk_atomic_is_enabled;
> -       } else {
> -               ops->prepare =3D scmi_clk_enable;
> -               ops->unprepare =3D scmi_clk_disable;
> +       if (!(feats_key & BIT(SCMI_CLK_STATE_CTRL_FORBIDDEN))) {
> +               if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
> +                       ops->enable =3D scmi_clk_atomic_enable;
> +                       ops->disable =3D scmi_clk_atomic_disable;
> +               } else {
> +                       ops->prepare =3D scmi_clk_enable;
> +                       ops->unprepare =3D scmi_clk_disable;
> +               }
>         }
> =20
> +       if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
> +               ops->is_enabled =3D scmi_clk_atomic_is_enabled;
> +
>         /* Rate ops */
>         ops->recalc_rate =3D scmi_clk_recalc_rate;
>         ops->round_rate =3D scmi_clk_round_rate;
> @@ -288,6 +293,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomi=
c_capable,
>         if (atomic_capable && ci->enable_latency <=3D atomic_threshold)
>                 feats_key |=3D BIT(SCMI_CLK_ATOMIC_SUPPORTED);
> =20
> +       if (ci->state_ctrl_forbidden)

Then this is negated.

> +               feats_key |=3D BIT(SCMI_CLK_STATE_CTRL_FORBIDDEN);
> +
>         /* Lookup previously allocated ops */
>         ops =3D clk_ops_db[feats_key];

