Return-Path: <linux-kernel+bounces-121536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAA88EA28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0365B3C7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DD41311BF;
	Wed, 27 Mar 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl/zDVix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888EF1311A4;
	Wed, 27 Mar 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553363; cv=none; b=Mvt6oZCVn0RVYSPS6+H4sSNHej5Ow7QNKpRmB4DC0jEPlKXvqe0dwEezKAXOgSCy4LjKpQ0Wg4vJGLvw9agd1mgyq3L1vvS6mGFqsrjuqhdWgJRRQjawUMg3+HBaxg+ojmL69ibD5MuepPE2OvWzfH5S3G6EB7PVToLwhVvr06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553363; c=relaxed/simple;
	bh=J0FtqkoqtSoPeUA98W8fjiXSUWfIrwK4RE1QO+34rPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE6dblQLRQZewlJAOulu1O7BvLcKrge2drzLrdJfeyuIJjyI3WA+RcxuPRi3Q/YjnNRCUnKjg48YxBJ4o5VQ6Wrq4876irovcx2b1fyzXAHPJRri+rS85FSx9a2h9UjItTDBLvplzPaZWB+B3IBDWIEFWB22ARM4Vl5Ul4BP9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl/zDVix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C417C43390;
	Wed, 27 Mar 2024 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553363;
	bh=J0FtqkoqtSoPeUA98W8fjiXSUWfIrwK4RE1QO+34rPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nl/zDVixGrTLeyXsUz126UKXQtIBJpjLSBMiXPt2B6wuqWjtineWSmEc+c8gI7SwW
	 dDQ2toiEL3xzGoDbc1meDoU5Ii3vR5L9laK9tNQLl/7fiLjfUCNeYpxoUUSDyW4Sbf
	 hMsMI8ih7So4x2i9bFEMv3Yi3JHwDl2Gf7Fg3btifFMr3m3s2CEBtlWpXnbQMOoVjy
	 KvqhTUAyMvbdfozYJ75BF+KEtlkO8Z3+xjkNZCtCgFX6FBgY0i8seR15NhhXpET/cX
	 cx1x1oAPhlcOUKPxjhoXCLGPQd7pDcUzsMrAs+8cN4bIRV/1MLXOQwNxA8FMOG/jZR
	 lB5cvwCsBNAsQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22a10ce0e0bso48942fac.1;
        Wed, 27 Mar 2024 08:29:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/dpFMLGBtopZtPk5FtPQMWyXLk3bSV88B/84fLDJkQChxEpOJwX9ABPBVDhWq8qFrzzPx5oR7hm3PDq/edTq2SfiQA5JSvgvFrYW6p9WoVcYa1R0hrsc2wsOXZ6UxDVGAXB8+j5k=
X-Gm-Message-State: AOJu0Yy5y0vlKpmEh7O29YYGqcV6S98js9Hx4LM7R3CumdE7FwrMrzO6
	wErK3eiv64ASIxYyEgoP9z0PT5dUfJWpHBXUmvhYE62dBZphwvwYYCEsQafAFiW4T3W9XCPwNxR
	pwiv3XLjuS9hPVgy6asgwSbs0XAA=
X-Google-Smtp-Source: AGHT+IG07sThI/qV4cALaRKmThkl0638APMo19Co2Zmx32nhPGF86ucjLP5HzUjuGu6a64ZLWksTrngsuIAMFom9xuE=
X-Received: by 2002:a05:6870:17a2:b0:22a:1e39:8be4 with SMTP id
 r34-20020a05687017a200b0022a1e398be4mr11684284oae.2.1711553362025; Wed, 27
 Mar 2024 08:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321102100.2401340-1-ye.zhang@rock-chips.com> <c7b2cb6f-3e14-45c3-9e22-11c0a9422bce@arm.com>
In-Reply-To: <c7b2cb6f-3e14-45c3-9e22-11c0a9422bce@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:29:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hE+erpYAiYGbQS_D8u==-ovvut_cyGAMj47Rm5FD7HVg@mail.gmail.com>
Message-ID: <CAJZ5v0hE+erpYAiYGbQS_D8u==-ovvut_cyGAMj47Rm5FD7HVg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Fix perf state when
 calculate dfc res_util
To: Lukasz Luba <lukasz.luba@arm.com>, Ye Zhang <ye.zhang@rock-chips.com>
Cc: tao.huang@rock-chips.com, heiko@sntech.de, daniel.lezcano@linaro.org, 
	finley.xiao@rock-chips.com, linux-rockchip@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:50=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 3/21/24 10:21, Ye Zhang wrote:
> > The issue occurs when the devfreq cooling device uses the EM power mode=
l
> > and the get_real_power() callback is provided by the driver.
> >
> > The EM power table is sorted ascending=EF=BC=8Ccan't index the table by=
 cooling
> > device state=EF=BC=8Cso convert cooling state to performance state by
> > dfc->max_state - dfc->capped_state.
> >
> > Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model =
and use EM")
> > Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
> > Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> > ---
> > v1 -> v2:
> >    - Update the commit message.
> >
> >   drivers/thermal/devfreq_cooling.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfre=
q_cooling.c
> > index 50dec24e967a..8fd7cf1932cd 100644
> > --- a/drivers/thermal/devfreq_cooling.c
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(stru=
ct thermal_cooling_device *cd
> >
> >               res =3D dfc->power_ops->get_real_power(df, power, freq, v=
oltage);
> >               if (!res) {
> > -                     state =3D dfc->capped_state;
> > +                     state =3D dfc->max_state - dfc->capped_state;
> >
> >                       /* Convert EM power into milli-Watts first */
> >                       rcu_read_lock();
>
> Thanks, LGTM
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.9-rc material, thanks!

