Return-Path: <linux-kernel+bounces-7116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565AA81A1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D2F1C22345
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019D3D98F;
	Wed, 20 Dec 2023 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+2d/xGt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34D43E467;
	Wed, 20 Dec 2023 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d2764c0f2so23556905e9.2;
        Wed, 20 Dec 2023 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703084999; x=1703689799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpNq0mGAO/ID0JEaLZ8hDs6wkvqKfsMQXHlt+mgq8b8=;
        b=c+2d/xGt5H4IzSF90vSZc8bO4z4Oab0WtiSPbGbSTqkBWUXa/Ca22bBFjn8rVm6EXt
         17/8uzb4qKmZlTxLDLcXi/PjqHQW8jfDi+ef8WxRslFf+02U/o1lHNnDrup5UMp7K3vQ
         RhKGrTs0ei1IjdeXg0b/AsLYhJ3IJdLQIZUkuEAqJ/yW7RyaL3aMoUD8RYaYxfJ9Ajad
         0eo/xGWOO2fjDrqTA6X7c/IzZvGxSlWa2sEr9rhNRheOpnBUd7/vFQ7xLvKBU6nV83Tk
         psaAx4DaQw0+mGry+2HvbOj42Dg6DHcoPl2vc0aLHIIBDirQIu9luvOD2MYZ4Mv5EW86
         vp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703084999; x=1703689799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpNq0mGAO/ID0JEaLZ8hDs6wkvqKfsMQXHlt+mgq8b8=;
        b=XuJKipsHhekMu2zfC73R2DchM9Prlb6D+iSX/Z4LCYCoCupRzXJeg+MLSSL+Q4WNzB
         jgar+EcFVY3a2VW6dNe+lrEhO6RiEykMXt2PsYlX05sNYAbgfoBMikYG9aiFg01zU6S0
         rw2LVIgev10Ft+p/tqQPFE+6ZGai7VPfkPDBIADazUoLQ5O36S6rl7Vsd8pdQZocZN5L
         s0le+hfkhyQOzKyK7lhC+jd4pz3SBuPxMpSjdJ09GWIs6c3rbZ1b3y41PTx71ZqSPxuH
         S7KV57fR6MbjsVXcWyW7tbLzAqA5Gmat6cpNmDwn+BaTgjNXFPRMjJLY+IXQ01ZYyZDx
         d7Rg==
X-Gm-Message-State: AOJu0YxkaOCDxTB8tUSk2UV/cIP79jXwP9zqbyd2sYoDrxGRmUAP84zF
	N/cfmzTYpbcn2Cqw389Nudo=
X-Google-Smtp-Source: AGHT+IErSAIMtKMfbJ6ITLfsl9Oe7KWcu4MMxZlvFn1ZUPhaJ21o+kfiDGYLYtG+Y4FMDqDLYBgDbg==
X-Received: by 2002:a05:600c:b43:b0:40b:5e1f:6fe0 with SMTP id k3-20020a05600c0b4300b0040b5e1f6fe0mr9713821wmr.53.1703084998936;
        Wed, 20 Dec 2023 07:09:58 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0040d1a925beesm7917351wmp.3.2023.12.20.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:09:58 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject:
 Re: [PATCH 1/5] clk: sunxi-ng: nkm: Support constraints on m/n ratio and
 parent rate
Date: Wed, 20 Dec 2023 16:09:55 +0100
Message-ID: <23332183.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <87msu59wrc.fsf@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <5736273.DvuYhMxLoT@jernej-laptop> <87msu59wrc.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne sreda, 20. december 2023 ob 07:58:07 CET je Frank Oltmanns napisal(a):
> Hi Jernej!
>=20
> On 2023-12-19 at 17:46:08 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmai=
l.com> wrote:
> > Hi Frank!
> >
> > Dne ponedeljek, 18. december 2023 ob 14:35:19 CET je Frank Oltmanns nap=
isal(a):
> >> The Allwinner A64 manual lists the following constraints for the
> >> PLL-MIPI clock:
> >>  - M/N >=3D 3
> >
> > This should be "<=3D"
>=20
> Yes, good catch! I will fix it in V2.
>=20
> >
> >>  - (PLL_VIDEO0)/M >=3D 24MHz
> >>
> >> The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support f=
or
> >> these constraints.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 23 +++++++++++++++++++++++
> >>  drivers/clk/sunxi-ng/ccu_nkm.h |  8 ++++++++
> >>  2 files changed, 31 insertions(+)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu=
_nkm.c
> >> index eed64547ad42..2af5c1ebd527 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> >> @@ -16,6 +16,20 @@ struct _ccu_nkm {
> >>  	unsigned long	m, min_m, max_m;
> >>  };
> >>
> >> +static bool ccu_nkm_is_valid_rate(struct ccu_common *common, unsigned=
 long parent,
> >> +				  unsigned long n, unsigned long m)
> >> +{
> >> +	struct ccu_nkm *nkm =3D container_of(common, struct ccu_nkm, common);
> >> +
> >> +	if (nkm->max_mn_ratio && (m > nkm->max_mn_ratio * n))
> >> +		return false;
> >> +
> >> +	if (nkm->parent_wo_nk && (parent < nkm->parent_wo_nk * m))
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +
> >>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_com=
mon *common,
> >>  						       struct clk_hw *parent_hw,
> >>  						       unsigned long *parent, unsigned long rate,
> >> @@ -32,6 +46,9 @@ static unsigned long ccu_nkm_find_best_with_parent_a=
dj(struct ccu_common *common
> >>
> >>  				tmp_parent =3D clk_hw_round_rate(parent_hw, rate * _m / (_n * _k)=
);
> >>
> >> +				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
> >> +					continue;
> >> +
> >>  				tmp_rate =3D tmp_parent * _n * _k / _m;
> >>
> >>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
> >> @@ -65,6 +82,12 @@ static unsigned long ccu_nkm_find_best(unsigned lon=
g parent, unsigned long rate,
> >>  	for (_k =3D nkm->min_k; _k <=3D nkm->max_k; _k++) {
> >>  		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
> >>  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> >> +				if ((common->reg =3D=3D 0x040) && (_m > 3 * _n))
> >> +					break;
> >> +
> >> +				if ((common->reg =3D=3D 0x040) && (parent < 24000000 * _m))
> >> +					continue;
> >> +
> >
> > You already figured this part.
> >
> >>  				unsigned long tmp_rate;
> >>
> >>  				tmp_rate =3D parent * _n * _k / _m;
> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu=
_nkm.h
> >> index 6601defb3f38..d3d3eaf55faf 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> >> @@ -16,6 +16,12 @@
> >>   * struct ccu_nkm - Definition of an N-K-M clock
> >>   *
> >>   * Clocks based on the formula parent * N * K / M
> >> + *
> >> + * @max_mn_ratio:	Maximum value for M / N.
> >> + * @parent_wo_nk:	The minimum rate the parent must provide after appl=
ying the divisor,
> >> + *			but without applying the multipliers, i.e. the contstraint
> >> + *			   (parent rate)/M >=3D parent_wo_nk
> >> + *			must be fulfilled.
> >>   */
> >>  struct ccu_nkm {
> >>  	u32			enable;
> >> @@ -27,6 +33,8 @@ struct ccu_nkm {
> >>  	struct ccu_mux_internal	mux;
> >>
> >>  	unsigned int		fixed_post_div;
> >> +	unsigned long		max_mn_ratio;
> >> +	unsigned long           parent_wo_nk;
> >
> > What about max_m_n_ratio and max_parent_m_ratio, to be consistent? This
> > should also allow to simplify description.
>=20
> Jernej, thank you so much! This is brilliant! I was racking my brain for
> a good name but failed. Now, that I see your proposal, I don't know why
> I hadn't come up with it. It's the obvious choice.
>=20
> I'd say with the new names we should be able to get rid of the comments
> describing the new struct members (also in ccu_nm.h). What are your
> thoughts on that?

Ah, I missed that only new ones are documented. Yeah, you can skip it.

Best regards,
Jernej

>=20
> Best regards,
>   Frank
>=20
> >
> > Best regards,
> > Jernej
> >
> >>
> >>  	struct ccu_common	common;
> >>  };
> >>
> >>
>=20





