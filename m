Return-Path: <linux-kernel+bounces-63834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59713853524
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120F328410E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19F5F476;
	Tue, 13 Feb 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFPJBwyT"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731425F540;
	Tue, 13 Feb 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839500; cv=none; b=kXP56GTUwDN2Qh5OATNDl6JCKqBVqiIW1xHF7ywhI0tHtvnmUQfUp0kkQU7tp/DM2CRZF8OfSLxilSB2pPE4J69Bs0iFG+1aUJ5G8vv7s/Ar+BsXL9JA1H64xsNluR384h194mRpDRsq4EoeStIJELng1buRxP45LZqxUUpwDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839500; c=relaxed/simple;
	bh=zndtJdYyIg0ZsEuC36v5dBXusmTjXcfWjppgCbyTJOc=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HLBuTlKUCS3wcg4OeGIk6bwPIHZaYK/JDC5w078p4O9XrZZRXkCe4/9xGu/pn0LqhHxvcP4PqMBhW8PFo+aG43HdvtF9F6jKvIFjk4aAUbGRZmYvgl4TYgFb8rVxfOQ8zKZ/sPUkgoRMF6Lv5ewpL1DHXEO6aJrLlZMgjc/gUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFPJBwyT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d1025717c7so17198021fa.2;
        Tue, 13 Feb 2024 07:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839496; x=1708444296; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5nluc7rACTm9e7KyTW8p7QXPYnj/OIsgMqpSFU5hoo=;
        b=nFPJBwyTRzRnnAj0lLmksLr+ne+LOEAvSFgdEIXMk2ICobzWsqlxVAdQBtlQxpCYDV
         qp2hDm+phcztYw+yRF4yZNyjSO2wKm33O9BQ2x5MkXW6nUo3K1Fuh+YGIAxRTwKsfEHc
         RSpLelcy/HRprkJufIU0YUJznLdNwbMHd17TC7e2oacNCrIrtY1GMBnUWijnNFMR5lAF
         BUq1x417uBb93huv1Ft3DqbqNd1OL/UYH+u9vvy62iJac1KoecbBKR9dm7vofqpSqbsS
         gEQiSPpINkuoGU5xlYDHPBHHkFhYCzQLZDxCtE/YB6FmlP6tH2vd8bECn2mYXD5l+RG6
         vPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839496; x=1708444296;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5nluc7rACTm9e7KyTW8p7QXPYnj/OIsgMqpSFU5hoo=;
        b=RLZSgwWRSNQCB9pRTR2ys/pd7cbn1EF8OqfmMn3+JoWyZUogW122UbjOUc5RJjAMXd
         sIAlM35ndWBnGJJ/fuhLW/fKn7UoLv29eakoAYjJ5uz0+KDeXBHm+qVufzh134V27qmQ
         x2kUxdy1nwvaxaGESr96BDhBO42X9Gj2i+jf6IX6b9OxCaBX2+tRhm6mazDXyOxYPvx9
         te4tMnsyzkXR7QdxqkKiiRuuyilPZtcR20m2YAVjQSs7KJLSusL9V0oWPT28QuDnkpji
         ZsatAguJJAN/0TY+VB+tQpiDanxXtu81cFMAmwWqdcnRNwNQfWtw5PAi5H63Vt2egfEx
         Ixtg==
X-Forwarded-Encrypted: i=1; AJvYcCXy+WcAa7WwL8jOtU43xRdy8HdmEUzUzMiLieKxMaG71G7n+SVPJZ271w60Otf43s2U04AKW4ivT1kyOyQzf6hi7WtqQYJGtFDCEd00+q9n9EF7l5v86E3T6WaGDYFAl7Qi6eD9ddFmXoW4sW4oXNdH1zqHN95Jd3Zgs1xkFr9bad0=
X-Gm-Message-State: AOJu0YwgYmO1l14H7+IlAj6cbHzvPzd2ok2MTx9yaYG0dGMbvlCuEMsS
	fnN4+NQ7eRYVmMjwkhdsmvvkh7EwrwvaOcRggsJ0vIbi5Cb4hG4B
X-Google-Smtp-Source: AGHT+IFWyZC7z5UQHaeXsMQIqqpgCO/rfzao3TGvlmhOSjICYP0D1kLKY44LrpKKMyl7qF3fXdcQ5g==
X-Received: by 2002:ac2:46e8:0:b0:511:933c:64e9 with SMTP id q8-20020ac246e8000000b00511933c64e9mr3107277lfo.66.1707839495973;
        Tue, 13 Feb 2024 07:51:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2oInC5bB4kgCVw92bLjNBtS/DiMGH11yOilf5sZB3nJEhEzIMK5ObuBiemAzgrxXQX8ldO48VfVkhateEJLgxBjOgRw3/1c9D2hGGO2lCiTP0aW3iNECsttorD1dAiznuZW7O2OZobKuTBU7TA9GpwAukumir45Z3wotrHqqaMMuR750vPkB2xqcbdGumM7g0+WGghRHEZ86kchEnZCpgAI6jL36/qJPKt31Sgvh6eMudbWOzXSQO77YTV0FGdO7UGroFpmATuEsw1e7peKIdnUYlcHhRTzzMseThuiHpwYdhj/puLf5fS41Qy+ibjOMztsyACOtBSoqsTqfBjRe5QQD8nFbGqSuJbC7fvc/q+6TUTD6/A6h5afFEuBWI+xlyZ1GDxh0lu+3Y3me6XBTgU8yJits=
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ig12-20020a056402458c00b0056213094d7bsm140732edb.69.2024.02.13.07.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 07:51:35 -0800 (PST)
Content-Type: multipart/signed;
 boundary=cfa596c0b51d52dd3aecf0f90e9ae3c845fbf778d202ed71698f391c8fdb;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 13 Feb 2024 16:51:34 +0100
Message-Id: <CZ42KOP6ECUC.EEIHWA147NV9@gmail.com>
Cc: "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Jose Abreu"
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Configure AXI on Tegra234
 MGBE
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Serge Semin" <fancer.lancer@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com>
 <20240202-stmmac-axi-config-v2-3-64eab2bab17b@nvidia.com>
 <uzzzxx3mv6yoslijhhzdzyossvcvi52jgbulza54uqh2wrm5kd@ddd5o56b2dhu>
In-Reply-To: <uzzzxx3mv6yoslijhhzdzyossvcvi52jgbulza54uqh2wrm5kd@ddd5o56b2dhu>

--cfa596c0b51d52dd3aecf0f90e9ae3c845fbf778d202ed71698f391c8fdb
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 5, 2024 at 1:44 AM CET, Serge Semin wrote:
> On Fri, Feb 02, 2024 at 12:53:35PM +0100, Thierry Reding wrote:
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
> The entire series can be converted to just a few lines of change:

Sorry for the delay, I missed this reply.

>  	plat =3D devm_stmmac_probe_config_dt(pdev, res.mac);
>  	if (IS_ERR(plat)) {
>  		err =3D PTR_ERR(plat);
>  		goto disable_clks;
>  	}
> +
> +	if (IS_ERR_OR_NULL(plat->axi)) {
> +		plat->axi =3D devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KERNEL);
> +		if (!plat->axi) {
> +			ret =3D -ENOMEM;
> +			goto disable_clks;
> +		}
> +	} /* else memset plat->axi with zeros if you wish */
> +
> +	plat->axi->axi_wr_osr_lmt =3D 63;
> +	plat->axi->axi_rd_osr_lmt =3D 63;
> +	plat->axi->axi_blen[0] =3D 256;
> =20
>  	plat->has_xgmac =3D 1;
>  	plat->flags |=3D STMMAC_FLAG_TSO_EN;
>  	plat->pmt =3D 1;
>
> Please don't overcomplicate the already overcomplicated driver with a
> functionality which can be reached by the default one. In this case
> the easiest way is to let the generic code work and then
> override/replace/fix/etc the retrieved values. Thus there won't be
> need in adding the redundant functionality and keep the generic
> DT-platform code a bit simpler to read.

I'm not sure I understand how this is overcomplicating things. The code
is pretty much unchanged, except that the AXI configuration can now have
driver-specified defaults before the DT is parsed. Perhaps I need to add
comments to make that a bit clearer?

While your version is certainly simpler it has the drawback that it no
longer allows the platform defaults to be overridden in device tree. I
would prefer if the defaults can be derived from the compatible string
but if need be for those defaults to still be overridable from device
tree.

Thierry

--cfa596c0b51d52dd3aecf0f90e9ae3c845fbf778d202ed71698f391c8fdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXLkAcACgkQ3SOs138+
s6HY6g//TyBX07vSPy79ApF01cK74bhK4woNCTlScH1jk/Pky8il9Yw+GrXfnnEk
9d6LiXfIWLHIvPLS4xcvwM0dT/FTTdDjgS41G2X0p06Bn7BGTHVJ+xuPjKh6yRuv
mVbYhtqUJynPHkT9R3OIBKZ6E3nTNGPp8ocpAe82uN6Opl1QI4BRJ8syKYciUcHj
REtkb1HZBXlxYhnWlFCHEsyD+mNdnZ1Z1mD50lauYCdkjhu/GnL8Czt1ScCy8q/s
URZ/Ft5r+6M8aBVyfRfR+r9XalZiRtxksOL2Ova79dlistCGl8S2NNWw7M3vxHPO
HvfhWMHyf0ywdQXoYEhTW/pt98X+fJPtIhnCfSrdOac58+WRSCiKekarM2WkS4ma
lUm4Azh/xK5z4zexVXB6j5Szgb9Hz/u3twxKvnNxu/frAJL7WesujOUy2RR+g2CM
KI3xDH9t2yuWE45vhv2MGAuPEeAtVmG5R2OxV7duuCXHCsY7njs6bZLyT1nX6eC1
ON9D4tsIj6TGo51UPokLNU04KzDB/D2xEqzqeV1GUuEXe/CsJIey76JpFT0UvJry
D1/UtEp+lAczY85TRiILc6z+NqSCq4p3kEqi+txrfr806bkHfBmRz/ZxlZbgrYPZ
ijRgUxzyXZxcL0ci0o8g+YFcoXfTJhD5cTt8NvBoolThfwHM/aY=
=vhC9
-----END PGP SIGNATURE-----

--cfa596c0b51d52dd3aecf0f90e9ae3c845fbf778d202ed71698f391c8fdb--

