Return-Path: <linux-kernel+bounces-21391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F0828E83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E5E287C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05023D96C;
	Tue,  9 Jan 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fns79K0X"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FA3D962;
	Tue,  9 Jan 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d8902da73so32229035e9.2;
        Tue, 09 Jan 2024 12:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704832182; x=1705436982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhFxPk9bq95VbdmA1a6BS885aCK0kZ8gAMJ7pYXAmuY=;
        b=Fns79K0Xjk+b+8Cg0psJzqlG7mExQdD+aNZgvxaR7yTuJ6XGx0t9hE8EI1798vQXc/
         cli/VdOipVDfOFHmg+hecDxeG/FOZlzuLtk94EqMYXptWhmLANNA5bAX6ekv8Cd2C046
         B5wo0pVZWjBM357mv6nvJpqZHcTrCHkwtj1zSOQQ7hTs6Sn/sy1lQnagA9lzfmA0Lo38
         VFB6oRvOP6sAF0smcwVrdBPP6rHdNEWZnmwXDeZ4Vl8avkWFPacSNK2ZAg2VCbp0gsbi
         lFSF0JmNPSMJFoIrAwRqx00ee6P/yldTtyf9yzfl7Acdu844hW5p5LfhhKvJiRdf8FXw
         /P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704832182; x=1705436982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhFxPk9bq95VbdmA1a6BS885aCK0kZ8gAMJ7pYXAmuY=;
        b=M6yaI5NQXT1BPhJQ+unTTHQuy0g2ZxNB/D4NsherYcE4lxApNJt3eqhSrCSScZYQ6B
         w0JISnVD3dgrirTlEtYcMZag2gDXnj4qp7MbdYLBCW69iKPX3nxMWqcJC4MVx+wrBLDT
         C4ZEaJqzpYpfealeQciwjWfeOGMQ+ioo6R17ZqnZukkA/XbhZtBKxRzst+Cj9gbKue60
         mmXBLCu/WQ1J0jqeOWQK1zp3He362XT3rz6LlTpZVtnn26xg85IJ2vqbqFIhzsJ+RI5r
         NtMN+56MoCKO0pdJ/vnFrPzZd2lg+Sw2M46dbQAQ/UqUvZjLcgCCM/Yvi3VUNApWM0K0
         yf/Q==
X-Gm-Message-State: AOJu0YyOk5gRCrYej1c6VntT3lJylgYzlzcdasHWrR+J5Rx7VpsDoD13
	3mcE+ARphjEy/9M7s4sTCsA=
X-Google-Smtp-Source: AGHT+IE5TnoT1XdEn0n5wgCIogYrdeyA0CMiYERCnMzgmb3h9FCnrk13KBv23kZ3Cm17VgQCyOeKbA==
X-Received: by 2002:a05:600c:1381:b0:40d:5aa1:8f9d with SMTP id u1-20020a05600c138100b0040d5aa18f9dmr3358939wmf.35.1704832181725;
        Tue, 09 Jan 2024 12:29:41 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-3-116.dynamic.telemach.net. [213.161.3.116])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040d5f3ef2a2sm15931585wmo.16.2024.01.09.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:29:41 -0800 (PST)
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
 Re: [PATCH 4/5] clk: sunxi-ng: a64: Add constraints on PLL-VIDEO0's n/m ratio
Date: Tue, 09 Jan 2024 21:29:39 +0100
Message-ID: <3461075.QJadu78ljV@jernej-laptop>
In-Reply-To: <87jzoug2jz.fsf@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <13411739.uLZWGnKmhe@jernej-laptop> <87jzoug2jz.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne nedelja, 31. december 2023 ob 10:10:40 CET je Frank Oltmanns napisal(a):
>=20
> On 2023-12-19 at 17:54:19 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmai=
l.com> wrote:
> > Dne ponedeljek, 18. december 2023 ob 14:35:22 CET je Frank Oltmanns nap=
isal(a):
> >> The Allwinner A64 manual lists the following constraint for the
> >> PLL-VIDEO0 clock: 8 <=3D N/M <=3D 25
> >>
> >> Use this constraint.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi=
=2Dng/ccu-sun50i-a64.c
> >> index c034ac027d1c..75d839da446c 100644
> >> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> >> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> >> @@ -68,7 +68,8 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_bas=
e_clk, "pll-audio-base",
> >>  				       BIT(28),	/* lock */
> >>  				       CLK_SET_RATE_UNGATE);
> >>
> >> -static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_cl=
k, "pll-video0",
> >> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(pll_vid=
eo0_clk,
> >> +						"pll-video0",
> >>  						"osc24M", 0x010,
> >>  						192000000,	/* Minimum rate */
> >>  						1008000000,	/* Maximum rate */
>=20
> I just realized that adding the whole ratio limits for ccu_nm is
> superfluous as you could just as well express them in for of a minimum
> and maximum range:
> Since 8 <=3D N/M <=3D 25 and parent_rate =3D 24 MHz, therefore
>   192 MHz <=3D rate <=3D 600 MHz.

Good point!

>=20
> These absolute limits are also listed in Allwinner's A64 manual.
>=20
> BUT, here the upper limit was raised to 1008 MHz:
> 5de39acaf34604bd04834f092479cf4dcc946dd "clk: sunxi-ng: a64: Add max.
> rate constraint to video PLL"
>=20
> With this upper limit the ratio limitation is effectively:
> 8 <=3D N/M <=3D 42
>=20
> Icenowy Zheng (added to CC) had the reasonable explanation that this was
> used in the BSP kernel, so we should probably stick to that and ditch
> the two PLL-VIDEO0 related patches. What are your thoughts on that?

Ok, it seems that these patches are really superfluous. Remove them for v2.

Best regards,
Jernej

>=20
> >> @@ -80,7 +81,10 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLO=
SEST(pll_video0_clk, "pll-vid
> >>  						297000000,	/* frac rate 1 */
> >>  						BIT(31),	/* gate */
> >>  						BIT(28),	/* lock */
> >> -						CLK_SET_RATE_UNGATE);
> >> +						CLK_SET_RATE_UNGATE,
> >> +						CCU_FEATURE_FRACTIONAL |
> >> +						CCU_FEATURE_CLOSEST_RATE,
> >
> > Above flags are unrelated change, put them in new patch if needed.
> >
> > Best regards,
> > Jernej
> >
> >> +						8, 25);		/* min/max nm ratio */
> >>
> >>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
> >>  					"osc24M", 0x018,
> >>
> >>
>=20





