Return-Path: <linux-kernel+bounces-92715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CB8724DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10951C22E60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD1DDAD;
	Tue,  5 Mar 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CZbUipyX"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE70134A0;
	Tue,  5 Mar 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657582; cv=none; b=nX/pRd0YFW+c9x/yrsaYGOBR4QrMinGPGo3wmDrNbz86xWfFHr19IKc/NrGYrwa36AuBFbvFe5O/F+lM9BlDV1HT/sKGxjpVhFnd1j7YUYo8yvTIzlRjbXTfqPKZtzQ/8+G38PYorYh6OZvQnc4oEvRldy+SugY4rGZ7oYyHN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657582; c=relaxed/simple;
	bh=wtYtDVJZiqM1pogoWHG3mgthzJAbRFC3EtRyyF4qw5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIXBHLtGwe1MrU17NfbLPYAnyZFyco9rN8njlaI7S97uUu46mGwHFGsMLPzHT1MijVXe/5KsW3mZ6tSAZ6pAZ5nhwy0bc3hVxPB7leIK0yw838wj9p3tgbmTQVfSub3HhAt+6Ft6x/QmvwwkLlIN3Z2hCY+3foP20v2hyZOrGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CZbUipyX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98E236000F;
	Tue,  5 Mar 2024 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709657576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/DJ06AQj7j8kFaAT82/9WOuSylUEZa/XluKSMLVR2c=;
	b=CZbUipyXh0uIDFs7UIuHYQbXhuzXMGFrVmVOGNvAhHvPowzAFnNVPDo2G/WiPUra5Kgq0s
	nztEcaah9if87869LbLxZjfBOoc/e9AacgFZ5R3KbDRf2/uRkTrszDuq7Pc/SCVHJY91qd
	0n7stiMeN+EqUFlWfmwXcV+p1ZcqcH49S3SyerF8mgpHzyT0H53xLK2/CDc97S3VsnFkVF
	8CgFoaUyaUL8vVMw1/BchY9/KmgNwAGxqCUpGMjhKTkrvRjxZiQIMUVmc5fyekQ+tDeo9N
	Kw1PXxCRBwrLfsb+MlxSCquvAMBv0NTv+drYyOmrEi5kK8fsL2ihc9QkXM1toQ==
Date: Tue, 5 Mar 2024 17:52:53 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Message-ID: <20240305175253.764f041a@kmaincent-XPS-13-7390>
In-Reply-To: <20240304192733.1e8e08cc@kernel.org>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-12-455611549f21@bootlin.com>
	<20240304192733.1e8e08cc@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 4 Mar 2024 19:27:33 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 26 Feb 2024 14:40:03 +0100 Kory Maincent wrote:
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index b3f45c307301..37071929128a 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -426,6 +426,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN=
] =3D {
> >  	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  =3D "option-tx-swhw",
> >  	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
> >  	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-tcp",
> > +	[const_ilog2(SOF_TIMESTAMPING_GHWTSTAMP)]    =3D "get-hwtstamp", =20
>=20
> What is this new SOF_TIMESTAMPING_GHWTSTAMP? If there's=20
> a good reason for it to exist it should be documented in
> Documentation/networking/timestamping.rst

/o\ Sorry I totally forgot about documentation here!

> > +const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX +=
 1]
> > =3D { [ETHTOOL_A_TSINFO_HEADER]		=3D
> >  		NLA_POLICY_NESTED(ethnl_header_policy),
> > +	[ETHTOOL_A_TSINFO_TIMESTAMPING] =3D { .type =3D NLA_NESTED },
> > +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST] =3D { .type =3D NLA_NESTED
> > }, =20
>=20
> link the policy by NLA_POLICY_NESTED() so that user space can inspect
> the sub-layers via the control family.

Ok thanks!

> > +
> > +	if (!hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] ||
> > +	    !hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER])
> > +		return -EINVAL; =20
>=20
> NL_REQ_ATTR_CHECK()

ok.

>=20
> > +	ret =3D
> > nla_get_u32(hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX]);
> > +	if (ret < 0)
> > +		return -EINVAL; =20
>=20
> How's the get_u32 going to return a negative value?
> That's the purpose of this check?
> The policy should contain the max expected value - NLA_POLICY_MAX().

Right I will use more NLA_POLICY_* to check the values in next version.

> >  		return ret;
> > -	ret =3D __ethtool_get_ts_info(dev, &data->ts_info);
> > +
> > +	if (!netif_device_present(dev)) { =20
>=20
>  ethnl_ops_begin() checks for presence

Ok thanks!

>=20
> > +	if (req->hwtst.index !=3D -1) {
> > +		struct hwtstamp_provider hwtstamp;
> > +
> > +		hwtstamp.ptp =3D ptp_clock_get_by_index(req->hwtst.index);
> > +		if (!hwtstamp.ptp) {
> > +			ret =3D -ENODEV;
> > +			goto out;
> > +		}
> > +		hwtstamp.qualifier =3D req->hwtst.qualifier;
> > +
> > +		ret =3D ethtool_get_ts_info_by_phc(dev, &data->ts_info,
> > +						 &hwtstamp);
> > +	} else {
> > +		ret =3D __ethtool_get_ts_info(dev, &data->ts_info); =20
>=20
> Not sure I grok why we need 3 forms of getting the tstamp config.
>=20
> Please make sure to always update
> Documentation/networking/ethtool-netlink.rst
> when extending ethtool-nl.

Yes sorry I forgot!
The three cases are:
- get hwtstamp config like ioctl SIOCGHWTSTAMP
- get tsinfo of the current hwtstamp
- get tsinfo of a specific hwtstamp

> > +	if (ts_info->phc_index >=3D 0) {
> > +		/* _TSINFO_HWTSTAMP_PROVIDER_NEST */
> > +		len +=3D nla_total_size(sizeof(u32) * 2); =20
>=20
> That translates to two raw u32s into a single attribute.
> Is that what you mean?

Oh right that's not what I want. Thanks you!
This is better:
len +=3D 2 * nla_total_size(sizeof(u32));

> > +	if (ts_info->phc_index >=3D 0) {
> > +		ret =3D nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX,
> > +				  ts_info->phc_index);
> > +		if (ret)
> > +			return -EMSGSIZE;
> > +
> > +		nest =3D nla_nest_start(skb,
> > ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST);
> > +		if (!nest)
> > +			return -EMSGSIZE;
> > +
> > +		ret =3D nla_put_u32(skb,
> > +				  ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX,
> > +				  ts_info->phc_index); =20
>=20
> You can assume nla_put_u32 only returns EMSGSIZE, so doing:
>=20
> if (nla_put_u32(....) ||
>     nla_put_u32(....))
> 	return -EMSGSIZE;
>=20
> is generally considered to be fine.

Ok.

> > +
> > +		/* Does the hwtstamp supported in the netdev topology */
> > +		if (mod) {
> > +			hwtstamp.ptp =3D ptp_clock_get_by_index(phc_index); =20
>=20
> This just returns a pointer without any refcounting, right?
> What guarantees the ptp object doesn't disappear?

Could the ptp object disappears within rtnlock?
Maybe I should add refcounting.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

