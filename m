Return-Path: <linux-kernel+bounces-81639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D248678A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D04B27071
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9A129A71;
	Mon, 26 Feb 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2vCt+/J"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9410FD;
	Mon, 26 Feb 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958029; cv=none; b=lttpXc8zrE5MH913SYdEsnehcN63EQ7pk4RfQAk9qRWbc/mT8k8PiA+QpE63h7i2VwZnNb6/8NtD+KwFD8Vwm1XJVojukk0BvQMWSjIlxdntQkvM+/Ii6W7Zq8b17fLlZSeOOnMfkwx4LsaZiAbP6TgLY97GnoRdXBBWvigyrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958029; c=relaxed/simple;
	bh=dT6v8U0ot3NdnGD7v4AKkIg9jGS5sjTxVUovtNIskWc=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s8LzN/Om6ft7MosIBOA/glGTtdoVmpLb5J/wImrLLK/WfiaoMBOC7+ZcfP33aRAz3PjIOqi5K/jdZyK/hcRG/YQbT/UJtq3HaJ273RnNyumt735GRy06x/sY50zdilK4yRY+UBv3feuP5/ZjtRQU4qR8aW/RE2inzLUPpvifanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2vCt+/J; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so3944275a12.1;
        Mon, 26 Feb 2024 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708958025; x=1709562825; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3N6Ym3bgXQzF5z7AmW2Qb4zuSJjYbLzuSuV+PTkZGxo=;
        b=S2vCt+/JwEkikaO9TpeU/p/AlGPtPghmbK74hT/0Jx1CUw3BGLOqNM/AUc2rovFcW4
         xrKrAXz90IBox1OeLmvKDcMdbEfDIyBzkDcgnfG6fHEnafl4xpaYD+6jqcsewPGsmobv
         mJTGF93y3PNDc+qbCNW7Cgf+SEUtvp1GIlP2/BcQEBGzpPZSqL5uoA8An0FwE+welTLN
         49Ji75lGo8RaqVNKOwFNAq0YJ2UuJOVoAcurKz9IfMxN+DnjBlXgyqhI93g7oWz2kEu/
         d2QqNLf7Eba3HprB8Qg3Lbm6vPc1UEpUcNeubeXa56OOJL41mh6RE89ITpFL6THt8qOH
         4+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958025; x=1709562825;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N6Ym3bgXQzF5z7AmW2Qb4zuSJjYbLzuSuV+PTkZGxo=;
        b=dOWwaL75CwNPZG9t/XDmdzjXAUs1cVsB/u4iayzjZr29iYtx5acVOU5cIM9/OMIav1
         530zXR6yvmChkjOPfslWFKGVngV7GquiQg0tYwdfMfqoHFCyc0p1IIlCTzQ/pelQCAEa
         UVRgv19u/yCIy5KlcynWtHAUb5hclU5Zii2HhHS1AxIL80i73odyJbV3CPzl+kC+n689
         9HBRHwmSD0Z+SQVJP9mkiVeUJSg5P8nmDdjMHIWifyvRHJOTan9rDOAXg0lOxQoTdiKl
         yWJ+5tYPDeo2VSMHlRdsM75ja3GU4km1UzSovpZFH1h+gXdTAGNIn1wDPHDxBxP51MSM
         4jmw==
X-Forwarded-Encrypted: i=1; AJvYcCUqvxTai0BlJ0gWrxg3yFBJHhoxtNpYALarbQmlYk1IiKscgPc/DQSwfPcIndcS03259cfG1xgJH2wmwAhUAdbPYM2ft1KzfYW2UokT5+N7cppvliefv6utHhEkMNml8pUmMQWcirkiuCjdpBoHBwdbWNz9haEIsbFG1aNjFoBmjAs=
X-Gm-Message-State: AOJu0Yx8T/hmYttoVa/CPKk/A8dth1pENEZIVnBO/z/MdcVwdX2XXrsW
	VOM6pVkk+ATl2WQF145BYXmfAczxazb0DtIuJP/IQxZPi5fhwPW5wowgjJiw
X-Google-Smtp-Source: AGHT+IHgys4HEymXkOTHp1yCx3gCB2tXlabzaPGh5szcy6U0nbuX8/uSEHAx937Ahxxw0TFO6/BZpQ==
X-Received: by 2002:a17:906:603:b0:a3e:fc79:c92b with SMTP id s3-20020a170906060300b00a3efc79c92bmr4479666ejb.31.1708958024993;
        Mon, 26 Feb 2024 06:33:44 -0800 (PST)
Received: from localhost (p200300e41f222300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:2300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vw7-20020a170907a70700b00a4324ae24dbsm1556647ejc.62.2024.02.26.06.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 06:33:44 -0800 (PST)
Content-Type: multipart/signed;
 boundary=d466fbf28d2645461829b3779913021bcae7500246ea7f2e1559fe55a58a;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 26 Feb 2024 15:33:43 +0100
Message-Id: <CZF325ZTG8X5.28VUA9EUUHHBK@gmail.com>
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
 <CZ9Z70HO2C7J.398BRNM8NBIG1@gmail.com>
 <kns2u6o4nhz4vda74r2mscyyp6yjgo2p62vryeenucm4o3ngzb@j6ch3sl6xha2>
In-Reply-To: <kns2u6o4nhz4vda74r2mscyyp6yjgo2p62vryeenucm4o3ngzb@j6ch3sl6xha2>

--d466fbf28d2645461829b3779913021bcae7500246ea7f2e1559fe55a58a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 23, 2024 at 11:24 PM CET, Serge Semin wrote:
> On Tue, Feb 20, 2024 at 03:28:39PM +0100, Thierry Reding wrote:
> > On Mon Feb 19, 2024 at 7:32 PM CET, Serge Semin wrote:
> > > On Mon, Feb 19, 2024 at 05:46:06PM +0100, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Allow the device to use bursts and increase the maximum number of
> > > > outstanding requests to improve performance. Measurements show an
> > > > increase in throughput of around 5x on a 1 Gbps link.
> > > >=20
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> > > > index bab57d1675df..b6bfa48f279d 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> > > > @@ -199,6 +199,12 @@ static void mgbe_uphy_lane_bringup_serdes_down=
(struct net_device *ndev, void *mg
> > > >  	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> > > >  }
> > > > =20
> > > > +static const struct stmmac_axi tegra234_mgbe_axi =3D {
> > > > +	.axi_wr_osr_lmt =3D 63,
> > > > +	.axi_rd_osr_lmt =3D 63,
> > > > +	.axi_blen =3D { 256, },
> > > > +};
> > > > +
> > > >  static int tegra_mgbe_probe(struct platform_device *pdev)
> > > >  {
> > > >  	struct plat_stmmacenet_data *plat;
> > > > @@ -284,6 +290,9 @@ static int tegra_mgbe_probe(struct platform_dev=
ice *pdev)
> > > >  	if (err < 0)
> > > >  		goto disable_clks;
> > > > =20
> > > > +	/* setup default AXI configuration */
> > > > +	res.axi =3D &tegra234_mgbe_axi;
> > > > +
> > > >  	plat =3D devm_stmmac_probe_config_dt(pdev, &res);
> > > >  	if (IS_ERR(plat)) {
> > > >  		err =3D PTR_ERR(plat);
> > >
> > > Let's get back to the v2 discussion:
> > >
> > > On Mon Feb 5, 2024 at 1:44 AM CET, Serge Semin wrote:
> > > > The entire series can be converted to just a few lines of change:
> > > >     plat =3D devm_stmmac_probe_config_dt(pdev, res.mac);
> > > >     if (IS_ERR(plat)) {
> > > >             err =3D PTR_ERR(plat);
> > > >             goto disable_clks;
> > > >     }
> > > > +
> > > > +   if (IS_ERR_OR_NULL(plat->axi)) {
> > > > +           plat->axi =3D devm_kzalloc(&pdev->dev, sizeof(*axi), GF=
P_KERNEL);
> > > > +           if (!plat->axi) {
> > > > +                   ret =3D -ENOMEM;
> > > > +                   goto disable_clks;
> > > > +           }
> > > > +   } /* else memset plat->axi with zeros if you wish */
> > > > +
> > > > +   plat->axi->axi_wr_osr_lmt =3D 63;
> > > > +   plat->axi->axi_rd_osr_lmt =3D 63;
> > > > +   plat->axi->axi_blen[0] =3D 256;
> > > > =20
> > > >     plat->has_xgmac =3D 1;
> > > >     plat->flags |=3D STMMAC_FLAG_TSO_EN;
> > > >     plat->pmt =3D 1;
> > > >
> > > > Please don't overcomplicate the already overcomplicated driver with=
 a
> > > > functionality which can be reached by the default one. In this case
> > > > the easiest way is to let the generic code work and then
> > > > override/replace/fix/etc the retrieved values. Thus there won't be
> > > > need in adding the redundant functionality and keep the generic
> > > > DT-platform code a bit simpler to read.
> > >
> > > You responded with:
> > >
> > > On Tue, Feb 13, 2024 at 04:51:34PM +0100, Thierry Reding wrote:
> > > > I'm not sure I understand how this is overcomplicating things. The =
code
> > > > is pretty much unchanged, except that the AXI configuration can now=
 have
> > > > driver-specified defaults before the DT is parsed. Perhaps I need t=
o add
> > > > comments to make that a bit clearer?
> > > >=20
> > > > While your version is certainly simpler it has the drawback that it=
 no
> > > > longer allows the platform defaults to be overridden in device tree=
 I
> > > > would prefer if the defaults can be derived from the compatible str=
ing
> > > > but if need be for those defaults to still be overridable from devi=
ce
> > > > tree.
> > >
> > > Currently available functionality is easier to read and understand: b=
y
> > > default the data is retrieved from the DT, if no AXI DT-node found yo=
u
> > > can allocate/create your own AXI-configs, if there is AXI DT-node you
> > > can fix it up in whatever way your wish. Thus the default behavior is
> > > straightforward. You on the contrary suggest to add an additional
> > > field to the resources structure which would need to be merged in wit=
h
> > > the data retrieved from DT. It makes the stmmac_axi_setup() method an=
d
> > > the entire logic more complex and thus harder to comprehend.
> >=20
> > I suppose that's subjective. Being able to let the driver provide
> > defaults that can then be overridden by values from DT doesn't seem lik=
e
> > a very exotic (or complicated) feature to me. We do that elsewhere all
> > the time. Do the comments that I added in this version not sufficiently
> > explain what's going on?
>
> I have perfectly understood what was going on since v1. My concern is
> the implementation. Here is the way the platform-specific setup
> currently works.
>
> There are two structures: stmmac_resources and plat_stmmacenet_data.
> The former one contains the generic platform resources like CSRs
> mapping, IRQs and MAC-address. The later one mainly has the DW
> MAC-specific settings. Yes, plat_stmmacenet_data has been evolved to
> an ugly monster with many redundant flags (fixing code and data here
> and there in the driver) and with some generic platform resources
> (which should have been added to the stmmac_resources structure in the
> first place, like clocks and resets). But still it's purpose is
> more-or-less defined. Both of these structures can be filled in with
> data either directly by the glue drivers or by calling the
> ready-to-use DW MAC platform data getters (stmmac_probe_config_dt()
> and stmmac_get_platform_resources()). Most importantly is that
> currently these structures have independent init semantics: no common
> data, no fields used in both contexts. There are tons of problematic
> places or questionable implementations in the driver, but at least
> this one is more-or-less defined: coherency is minimal, logic is
> linear.
>
> You suggest to break that logic by introducing a new stmmac_resources
> field which doesn't represent a generic resource data, but which
> purpose is to tweak the AXI-settings in the plat_stmmacenet_data
> structure. The pointer won't be even ever initialized in the
> stmmac_get_platform_resources() method because it's done in the
> stmmac_probe_config_dt() function. Based on all of that the change you
> suggest look more like a fixup of the problem with your particular
> device/platform.
>
> Let's assume you patches are accepted. In sometime an another
> developer comes with a need to pre-define say MTL Tx/Rx queue configs,
> then another one with DMA configs, MDIO-bus settings, and so on. Thus
> the stmmac_resources structure will eventually turn in a set of the
> tweaks and the plat_stmmacenet_data pre-defines. That's how the
> plat_stmmacenet_data structure has turned in what it is now. This
> doesn't look like a right path to take again.
>
> >=20
> > > The driver is already overwhelmed with flags and private/platform dat=
a
> > > fixing the code here and there (see plat_stmmacenet_data, it's a
> > > madness). So please justify in more details why do you need one more
> > > complexity added instead of:
> > > 1. overriding the AXI-configs retrieved from DT,
> >=20
> > Again, overriding the AXI configs read from DT doesn't keep the current
> > default behaviour of DT being the final authority. That's a policy that
> > should remain intact. This patch (series) is about allowing the driver
> > to override the AXI defaults with something that's sensible based on
> > the compatible string. The current defaults, for example, cause the GBE
> > on Tegra devices to run at around 100 Mbps even on a 1 Gbps link.
> >=20
> > > 2. updating DT on your platform
> >=20
>
> > That's one possibility and was in fact the first variant I used, but it
> > has a few drawbacks. For example, it means that I need to create the AX=
I
> > node just to make the device functional, but if possible it's better to
> > derive all necessary information from the compatible string. Having thi=
s
> > in a separate AXI configuration node is duplicating information that's
> > already implied by the compatible string.
> >=20
> > Also, on Tegra we have a few instances of this device that are all
> > configured the same way. Since the AXI configuration node is supposed t=
o
> > be a child of the Ethernet controller node, we end up having to
> > duplicate even more information.
>
> None of that sounds like big problems. The default behavior doesn't
> make your devices not-working. Yes, the performance is poor, but they
> still work. Regarding the AXI-config DT-nodes it's not a problem at
> all. A lot of the DW *MAC instances currently have the AXI-config
> DT-subnodes. It's absolutely fine to have them setting up the same
> configs.

But that's precisely my issue. In my opinion the default behavior for a
device should be to be able to run at optimal performance without having
to resort to extra quirks.

All of the AXI configuration parameters can be derived from the DT
compatible string, so it shouldn't be necessary to duplicate that
information in an additional AXI configuration node.

> Once again having the pre-defined configs is fine. All I am worried
> about is the implementation you suggest especially in using the
> stmmac_resources structure to tweak up the plat_stmmacenet_data data.
> So the easiest solutions in your case are:
> 1. Initialize the plat_stmmacenet_data->axi pointer if no AXI
> DT-subnode was detected by the stmmac_probe_config_dt() method, after
> the method is called. This will provide almost the same semantics as
> you suggest. The only difference is that it would work not on the
> property level but on the node-level one. (Note the implementation
> suggested by you doesn't provide the AXI-configs pre-definition for
> the boolean properties. So it doesn't provide a complete AXI-config
> default pre-definition.)

Quite frankly that would not be useful at all. If there's no way to
override defaults individually this becomes very brittle. If somebody
wanted to override just a single parameter, they would need to reproduce
the entire AXI configuration node, using an exact copy of the defaults
for the parameters that they don't want to change.

> 2. Add the proper AXI-config DT-subnodes to the respective device tree
> sources.
>
> If despite of all my reasoning you still insist on having a
> pre-defined setting pattern, then we'll need to come up with some
> better solution. On the top of my mind it might be for example a
> pre-definition of the entire plat_stmmacenet_data structure instance
> or using the software nodes.

That sounds very impractical. We'd need to make sure to deep-copy the
pre-definition structure and such, then deal with reference counting of
the clocks, resets and whatever else.

I'll drop this series and stick with AXI configuration nodes like
everyone else.

Thierry

--d466fbf28d2645461829b3779913021bcae7500246ea7f2e1559fe55a58a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXcoUgACgkQ3SOs138+
s6FFBRAAvNmKW5F9JaZOWoRbNCOa24mgbUt2118hqt2TCYg5cU/lFowjl6Gg7vcL
fVJ7RjCI/d3BZzXd2Lgvr5HW1BPpbG80qw+vZ1Sk7cotpBKch23rKlHr/4yNF/bJ
qLYCTDetGLgdmxVGgTH5pSdAZr/AwdQBWGVe+ey3iS5g5cNa/ci4Dyeu6atg2CLI
3fFK26jTN3UHKCGayh5F9viDzC0iJgOweVTfeRMN3vVBCE8dosCNyU7PvpUff6lV
BR11OqwLYgBpQRAyhYIT+LC8kxCB8IDrcZzxs/P2+E5BPySADmKhtvEJB4AshRuA
2NSgahz4lMMTFYMLRMhbWEw5IItAubUQynqBjQK/vIRLwZoeE29oIaJrggLzpgcS
r/db31k6zgxjMpo8pW5vg5kPqeTQk3Ixlp/4QGp4eOut4wcOgH92erV2mlHoIOoV
4GuTp2h3MgBpP3HQ/GkalaaBoCjVhHC3S9gw/iehocnU+tVeWXSXibmuhtvLVrgZ
Q8eaBRDEZpj3sAjspUJus1UtcoQakt645qYO1dRT4xdM5UgmfmTO9O4x7T9YrKm+
u8fk6WcwKvVmSmsvT2bbaVsyideKDh8FTeSwPBotlZyblx7jc31EQ57SoQH7rDK8
Hc+DehK0PQm1aaMqVY0V32A7n809vQzDrhilQyskekLwYgSLOFE=
=Ivt5
-----END PGP SIGNATURE-----

--d466fbf28d2645461829b3779913021bcae7500246ea7f2e1559fe55a58a--

