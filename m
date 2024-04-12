Return-Path: <linux-kernel+bounces-142676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54018A2EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722F71F22E24
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0B5BAC3;
	Fri, 12 Apr 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awI6En4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8A4436E;
	Fri, 12 Apr 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926993; cv=none; b=C9VAmy6FvwVm8cpFMuCwCuriCSJ4NryI11XT7/HDCBCU3vhj6lluze7G35Ggb3WrW/KLXL/4i/wgHZztY5SaIHif3ivbZxMbWpJvqP1IAYWh1MzTtX5CZ2FNgGVJFtwJYTLpswO7KKiCYoH7Rnx8aI9ey39iDyK7cV1rnKzR6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926993; c=relaxed/simple;
	bh=8wdevPfrdtepk0PCtS0tbraBxnU6ILXWXbU+kfU/aQ0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=l1uMaRBBcHxF8F2RhQbnr0z7H5s841xvQDjmhX+gnzLuLTZl9ovO6eJlTxDxdhqiv8JZU8hOjQ4Q3PVA999QXi18ZhM+cJQqWseXM64Firk0hJZ16WSOj6KsxJW5pqatFdrfij0R2H4Kd/LB9/hi5QSi/RvXxkJM+66IRVUa+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awI6En4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F856C113CC;
	Fri, 12 Apr 2024 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712926993;
	bh=8wdevPfrdtepk0PCtS0tbraBxnU6ILXWXbU+kfU/aQ0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=awI6En4BnoNZRKhvZawTzXVzsV/D37RfCZWVwb0jDF/U9AMWf1YFeiczSz5Lh/Zl5
	 V3fWdznlkQSyZeB8AvsmqDewwWXIISMDenlbET0aoLX2zzeWeA1PfTKYh6lcdb/JYi
	 G4UpelDztrOemmvQ+mbH/FjKboE/JfPRBfECavtTL38QibxOLqZMQ40NGUJosK3A8h
	 1Yy4pXxHAZB9xUayJCyeomyRO8ibLsjrfF2zljJAzqbgAmLDNym2vqjZKxkWBDA0dq
	 f4rmv3QdM/IFJc2wY++J8r+a2bMBhMAcOhnCfLOBzxSvC2R5XTneHc9YLqLNS7XoQO
	 akY2/Eo0aHpRg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next] net: phy: phy_link_topology: Handle NULL topologies
From: Antoine Tenart <atenart@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, =?utf-8?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Date: Fri, 12 Apr 2024 15:03:10 +0200
Message-ID: <171292699033.4917.4025686054785818967@kwain>

Hi Maxime,

Quoting Maxime Chevallier (2024-04-12 12:46:14)
>=20
> This patch fixes a commit that is in net-next, hence the net-next tag and=
 the
> lack of "Fixes" tag.

You can use Fixes: on net-next, that still helps to identify which
commit is being fixed (eg. for reviews, while looking at the history,
etc).

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_li=
nk_topology.c
> index 985941c5c558..0f3973f07fac 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *top=
o,
>         struct phy_device_node *pdn;
>         int ret;
> =20
> +       if (!topo)
> +               return 0;
> +

With that phy_sfp_connect_phy does not need to check the topo validity
before calling phy_link_topo_add_phy. The other way around is fine too.

> @@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
>  void phy_link_topo_del_phy(struct phy_link_topology *topo,
>                            struct phy_device *phy)
>  {
> -       struct phy_device_node *pdn =3D xa_erase(&topo->phys, phy->phyind=
ex);
> +       struct phy_device_node *pdn;
> +
> +       if (!topo)
> +               return;
> +
> +       pdn =3D xa_erase(&topo->phys, phy->phyindex);

Same here with phy_sfp_disconnect_phy.

Thanks!
Antoine

