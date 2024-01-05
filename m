Return-Path: <linux-kernel+bounces-17700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A56825152
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA37B1F21CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9F24B2A;
	Fri,  5 Jan 2024 09:58:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2AA24A05
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rLgx5-0002Kf-AW; Fri, 05 Jan 2024 10:57:19 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH] drm/rockchip: vop2: Drop unused if_dclk_rate variable
Date: Fri, 05 Jan 2024 10:57:18 +0100
Message-ID: <13141620.VsHLxoZxqI@diego>
In-Reply-To: <acb52035-4f0c-430d-a2d2-26ab37805d7b@rock-chips.com>
References:
 <20240104143951.85219-1-cristian.ciocaltea@collabora.com>
 <5867171.29KlJPOoH8@diego>
 <acb52035-4f0c-430d-a2d2-26ab37805d7b@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi,

Am Freitag, 5. Januar 2024, 10:04:55 CET schrieb Andy Yan:
> On 1/4/24 23:58, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 4. Januar 2024, 15:39:50 CET schrieb Cristian Ciocaltea:
> >> Commit 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> >> introduced a variable which ended up being unused.  Remove it.
> >>
> >> rockchip_drm_vop2.c:1688:23: warning: variable =E2=80=98if_dclk_rate=
=E2=80=99 set but not used [-Wunused-but-set-variable]
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >=20
> > in general, please don't send non-series patches as replies to other pa=
tches.
> > It confuses tooling like b4 way too often, as this patch is not designa=
ted
> > as a 2/2 (similar to the first one not being 1/2).
> >=20
> >> ---
> >>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gp=
u/drm/rockchip/rockchip_drm_vop2.c
> >> index 44508c2dd614..923985d4161b 100644
> >> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >> @@ -1685,7 +1685,6 @@ static unsigned long rk3588_calc_cru_cfg(struct =
vop2_video_port *vp, int id,
> >>   	unsigned long dclk_core_rate =3D v_pixclk >> 2;
> >>   	unsigned long dclk_rate =3D v_pixclk;
> >>   	unsigned long dclk_out_rate;
> >> -	unsigned long if_dclk_rate;
> >>   	unsigned long if_pixclk_rate;
> >>   	int K =3D 1;
> >>  =20
> >> @@ -1700,7 +1699,6 @@ static unsigned long rk3588_calc_cru_cfg(struct =
vop2_video_port *vp, int id,
> >>   		}
> >>  =20
> >>   		if_pixclk_rate =3D (dclk_core_rate << 1) / K;
> >> -		if_dclk_rate =3D dclk_core_rate / K;
> >>   		/*
> >>   		 * *if_pixclk_div =3D dclk_rate / if_pixclk_rate;
> >>   		 * *if_dclk_div =3D dclk_rate / if_dclk_rate;
> >>   		 */
> > 		*if_pixclk_div =3D 2;
> > 		*if_dclk_div =3D 4;
> >=20
> > with the code continuing with those static constants but the comment
> > showing a forumula, I do hope Andy can provide a bit of insight into
> > what is happening here.
> >=20
> > I.e. I'd really like to understand if that really is just a remnant or
> > something different is needed.
>=20
> This is not a remnant, in my V1, I calculate all the div by formula, but =
Sascha prefer
> more for a constants value[0], so I keep this formula as comments to indi=
cate how these value come from.
>=20
> [0]https://patchwork.kernel.org/project/linux-rockchip/patch/202311141128=
55.1771372-1-andyshrk@163.com/

thanks for referencing the source of the change.
Leaving the formula in there was the right choice I think

That still leaves the issue with the "unused" warning.

@Christan: in the hdmi block itself can you move the=20
	if_dclk_rate =3D dclk_core_rate / K;
to the comment block please? And possibly reference the use
of the static values in the comment message.

The if_dclk_rate var declaration at the top of the function can of course
go away.

That way we still keep documenting how these values came to be:

  		/*
		 * if_dclk_rate =3D dclk_core_rate / K;
  		 * *if_pixclk_div =3D dclk_rate / if_pixclk_rate;
  		 * *if_dclk_div =3D dclk_rate / if_dclk_rate;
  		 */

Thanks
Heiko




