Return-Path: <linux-kernel+bounces-73180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D485BEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5834F1F252F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AFF6FB9D;
	Tue, 20 Feb 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJgEeFBh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327276DCE4;
	Tue, 20 Feb 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439325; cv=none; b=aPAVWis+Ad3W6ZFKzHiB33B/5rTTW3kLgBwXhV5N/bcW+vfSi2jXitZGW9gQVK/NJtUWovJe7+tzK4JMmzWpJol2cvj9RXG/L/NnCskTbIibUJW1vmzrbK3zV2zgfM1druaY1Dy7txjsf2Tm3m6Pukka3jOGdQf6cC4wfHRE30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439325; c=relaxed/simple;
	bh=FL3M7xKJ14hnC6urx1eoKV1vZUT3l8eiXsraM73jfXA=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bQ2oQ0Vy8UzEIuP14j/3M3MsGxhgJcnj2GlZa9Mqg3Qiz7B8SBvA99oud5N+3QSuKqnf4CjUx3D06ecI4s91JOOplzd/one86bx2Xn9ClXC/dsqvVxYnTV6VRUE2KR6UJ02TEuoYeclJtE8hFQzrosU0GGIiR5wfn/0BAnHuUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJgEeFBh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e706f50beso312150566b.0;
        Tue, 20 Feb 2024 06:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708439321; x=1709044121; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vz5RzTNhpTPMTVMz3nxEsmiIaAzAhCmMLP53qUjHq3g=;
        b=jJgEeFBhxVfMx46rd78x/YQUO+MtlbFzkg1HZUIq19ko/BiQAcQVyYTJ+z5PlksNc1
         5+z+9it+iesgjksJ0RGALBycLkj/LbYeJNDZ2ZYa0xXAsddeBXueG0XqAgmO3Ta5lnck
         Fc7A/ou4t7R5zu8nT+H851UA0mSGISjFxjFdpx23ZTEPyhP8tjGJGHGvaDmzH9LdnTRy
         v5Vh3K/m5FHo//JokUTRGWGMcUYwYXnGY3mKJewgiuCVJjy0fUprLJUKPhMQZlxAVmrC
         HPliNBrmXis0oMCNNFjkcszQKyXW0opwsWWwcSWKkIY8/iIB2PsbVfLlt8RTrg3eb3+x
         /yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708439321; x=1709044121;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz5RzTNhpTPMTVMz3nxEsmiIaAzAhCmMLP53qUjHq3g=;
        b=V2eORr3AmKHBQU3XA/oCt61bovkOXx7IDMk6Pjm71L679UfPgtKSvvl6O+/VnFK9sp
         79RWXtduSztAFeT5bNcWm/ZEV2i4oldbB39Tg06U2RubP9ifvKUhprZKhdZjxy9Rj9ul
         hm+Uk9ie4zrhhjZKqsT7QWKkUGrpFYrMsV5LpduVB451eSsKPNLj7fQjA7F3e9M56JWf
         38T70DS9Nd0j2S59ZgVZUk+7bNoMJv2vW5Yg0REvPrTCWeJKyhSE1oFoTLan59Pd0ZBe
         0GA877Sbsmlr1CMJ7nz6eiSLgG79sOpvxQRdEBhQGWU1KUL4VIGzB8IXk6jXg2CDHx1S
         Yp8w==
X-Forwarded-Encrypted: i=1; AJvYcCWlCu88GLelYDd8dNpAkS+9Zz9bc/NjsbzcikyKzsFBnJQBKnyvUbk5GW5RcTiJe6M/mNP8HuRMRCSesOjHiuIjiP15kLx0GT+l73yYA4hfGIQ1RvpbqeCvwrB/Op3Fuh3QuRtRfgVlp5s0WTyr09XPaphZKX0dmiwAUxHQlIvsMrU=
X-Gm-Message-State: AOJu0YzbKOG+1OSbU+v0XGJAeEPm8i5ohH/Ft2pmMzYuFDcVIW1VAMvE
	Sr42f7IV9WquYbFgqpfhoQCRtu95CJK2N2053ZEDOdPWX3qr3Viz
X-Google-Smtp-Source: AGHT+IFqSZIGLTjK5nMNqJ0mC/A+H31d6ZqUqt7xA4Zv5XlbR7MTAcjYaOiWvzrP3SvxWDabVUin/A==
X-Received: by 2002:a17:906:b0c:b0:a3e:5b7f:6d31 with SMTP id u12-20020a1709060b0c00b00a3e5b7f6d31mr4677754ejg.5.1708439320970;
        Tue, 20 Feb 2024 06:28:40 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vi10-20020a170907d40a00b00a3e7713dcbesm2523386ejc.39.2024.02.20.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 06:28:40 -0800 (PST)
Content-Type: multipart/signed;
 boundary=54d881cc30ca662a73cfdacbec92cecca394f1f83ef4012a7b29e0247a47;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 20 Feb 2024 15:28:39 +0100
Message-Id: <CZ9Z70HO2C7J.398BRNM8NBIG1@gmail.com>
Cc: "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Jose Abreu"
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, "Thierry Reding" <treding@nvidia.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Configure AXI on Tegra234
 MGBE
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Serge Semin" <fancer.lancer@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
 <20240219-stmmac-axi-config-v3-3-fca7f046e6ee@nvidia.com>
 <xne2i6jwqaptsrd2hjdahxbscysgtj7iabqendyjb75fnrjc5z@js7n7qngtzym>
In-Reply-To: <xne2i6jwqaptsrd2hjdahxbscysgtj7iabqendyjb75fnrjc5z@js7n7qngtzym>

--54d881cc30ca662a73cfdacbec92cecca394f1f83ef4012a7b29e0247a47
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 19, 2024 at 7:32 PM CET, Serge Semin wrote:
> On Mon, Feb 19, 2024 at 05:46:06PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Allow the device to use bursts and increase the maximum number of
> > outstanding requests to improve performance. Measurements show an
> > increase in throughput of around 5x on a 1 Gbps link.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> > index bab57d1675df..b6bfa48f279d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> > @@ -199,6 +199,12 @@ static void mgbe_uphy_lane_bringup_serdes_down(str=
uct net_device *ndev, void *mg
> >  	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> >  }
> > =20
> > +static const struct stmmac_axi tegra234_mgbe_axi =3D {
> > +	.axi_wr_osr_lmt =3D 63,
> > +	.axi_rd_osr_lmt =3D 63,
> > +	.axi_blen =3D { 256, },
> > +};
> > +
> >  static int tegra_mgbe_probe(struct platform_device *pdev)
> >  {
> >  	struct plat_stmmacenet_data *plat;
> > @@ -284,6 +290,9 @@ static int tegra_mgbe_probe(struct platform_device =
*pdev)
> >  	if (err < 0)
> >  		goto disable_clks;
> > =20
> > +	/* setup default AXI configuration */
> > +	res.axi =3D &tegra234_mgbe_axi;
> > +
> >  	plat =3D devm_stmmac_probe_config_dt(pdev, &res);
> >  	if (IS_ERR(plat)) {
> >  		err =3D PTR_ERR(plat);
>
> Let's get back to the v2 discussion:
>
> On Mon Feb 5, 2024 at 1:44 AM CET, Serge Semin wrote:
> > The entire series can be converted to just a few lines of change:
> >     plat =3D devm_stmmac_probe_config_dt(pdev, res.mac);
> >     if (IS_ERR(plat)) {
> >             err =3D PTR_ERR(plat);
> >             goto disable_clks;
> >     }
> > +
> > +   if (IS_ERR_OR_NULL(plat->axi)) {
> > +           plat->axi =3D devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KE=
RNEL);
> > +           if (!plat->axi) {
> > +                   ret =3D -ENOMEM;
> > +                   goto disable_clks;
> > +           }
> > +   } /* else memset plat->axi with zeros if you wish */
> > +
> > +   plat->axi->axi_wr_osr_lmt =3D 63;
> > +   plat->axi->axi_rd_osr_lmt =3D 63;
> > +   plat->axi->axi_blen[0] =3D 256;
> > =20
> >     plat->has_xgmac =3D 1;
> >     plat->flags |=3D STMMAC_FLAG_TSO_EN;
> >     plat->pmt =3D 1;
> >
> > Please don't overcomplicate the already overcomplicated driver with a
> > functionality which can be reached by the default one. In this case
> > the easiest way is to let the generic code work and then
> > override/replace/fix/etc the retrieved values. Thus there won't be
> > need in adding the redundant functionality and keep the generic
> > DT-platform code a bit simpler to read.
>
> You responded with:
>
> On Tue, Feb 13, 2024 at 04:51:34PM +0100, Thierry Reding wrote:
> > I'm not sure I understand how this is overcomplicating things. The code
> > is pretty much unchanged, except that the AXI configuration can now hav=
e
> > driver-specified defaults before the DT is parsed. Perhaps I need to ad=
d
> > comments to make that a bit clearer?
> >=20
> > While your version is certainly simpler it has the drawback that it no
> > longer allows the platform defaults to be overridden in device tree. I
> > would prefer if the defaults can be derived from the compatible string
> > but if need be for those defaults to still be overridable from device
> > tree.
>
> Currently available functionality is easier to read and understand: by
> default the data is retrieved from the DT, if no AXI DT-node found you
> can allocate/create your own AXI-configs, if there is AXI DT-node you
> can fix it up in whatever way your wish. Thus the default behavior is
> straightforward. You on the contrary suggest to add an additional
> field to the resources structure which would need to be merged in with
> the data retrieved from DT. It makes the stmmac_axi_setup() method and
> the entire logic more complex and thus harder to comprehend.

I suppose that's subjective. Being able to let the driver provide
defaults that can then be overridden by values from DT doesn't seem like
a very exotic (or complicated) feature to me. We do that elsewhere all
the time. Do the comments that I added in this version not sufficiently
explain what's going on?

> The driver is already overwhelmed with flags and private/platform data
> fixing the code here and there (see plat_stmmacenet_data, it's a
> madness). So please justify in more details why do you need one more
> complexity added instead of:
> 1. overriding the AXI-configs retrieved from DT,

Again, overriding the AXI configs read from DT doesn't keep the current
default behaviour of DT being the final authority. That's a policy that
should remain intact. This patch (series) is about allowing the driver
to override the AXI defaults with something that's sensible based on
the compatible string. The current defaults, for example, cause the GBE
on Tegra devices to run at around 100 Mbps even on a 1 Gbps link.

> 2. updating DT on your platform

That's one possibility and was in fact the first variant I used, but it
has a few drawbacks. For example, it means that I need to create the AXI
node just to make the device functional, but if possible it's better to
derive all necessary information from the compatible string. Having this
in a separate AXI configuration node is duplicating information that's
already implied by the compatible string.

Also, on Tegra we have a few instances of this device that are all
configured the same way. Since the AXI configuration node is supposed to
be a child of the Ethernet controller node, we end up having to
duplicate even more information.

Thierry

--54d881cc30ca662a73cfdacbec92cecca394f1f83ef4012a7b29e0247a47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXUtxgACgkQ3SOs138+
s6FwXw/+NI5f4NQaxXMdNTZw4i9JMgVZR8IurQ/Weei3I0HDz7t17hwB+g3eRjuk
6XhD92hL3YpUuV6Ii96Wfb0JrtL5j651COCXyaRxaGU/vRvtYJvwEmpRLKEds35H
6oARkoy40FoDUKKbnsrVT81ERAKSZgVNyAIFWM3byS4ez3R6Kp+Lf9BiRjkVlvbo
KWdb1KfGC+EOCv2WIVFZA2R4OH1H4AmOp2cJa/PWha3+FW66aj9Xdgena7wu4KiJ
R/Q+gmFK3uPG6pBO3O2+HF1SkI8ECAW73rX90qzw/3Ie0i5yPaqPo8yxmLI29AhM
mPY7vq8hGnCTKiYwvy4je86ajKD/zrjiaxCNlgl155dk3Q+2iYNgDXcFlIb0au9Q
AK6Mu8AAxrVkp14t94gpkZvb5EnUKYQO1OtZKiv+jmKXYyoaESSlmw9kvmySifJY
T6aNUw91fFA5eiRu59oHnjbz2WIt+/yLTgJyVZURT+4E8Ajvs6v4kLVvv5hGp5d7
E5gU8XQGnWcCFlDT0ojxQXV55arCHXuP85ijD+sqFJhjBAcysNBRgEHLH0lHs6/W
NmO8VFLECjL0932LLbhiZV4XrP9ou4wSP4Hz576nGLMlJRmNAlOepaOO8XYFyOuc
J/afiFERL2IogN5FYu075zt3Tg2/4jXPJMOJE1BQMPNwPAirrbo=
=1yTl
-----END PGP SIGNATURE-----

--54d881cc30ca662a73cfdacbec92cecca394f1f83ef4012a7b29e0247a47--

