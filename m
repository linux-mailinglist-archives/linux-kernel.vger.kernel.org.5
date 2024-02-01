Return-Path: <linux-kernel+bounces-48520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC2845D36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5401F21DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093195E236;
	Thu,  1 Feb 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3viytOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A47E0E5;
	Thu,  1 Feb 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804740; cv=none; b=ZOEtcCjQCkE925YoUYdWLKNDQp86cSW+C0JyQQRU1AQLc7MhZgckL7iR9J07OGgMBOLVH/Y/H5a1BNDk34UfsBELedXa6YSFZhgZiu4DLwsmBZLaUwP+E+RyjsS6WhEcmPv9n42DzNz75KH4+Lnxjx6CrQkAUf6TZgMwzUemJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804740; c=relaxed/simple;
	bh=r33SDu8/DM+zYKaYrvveD9kjvKPsy8EfeVfboKSVxPM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=VZuERazOe58z2bqDLG+DyXabdg6CcfyzRIhVd14jpfatC7CLvhjYXxkRIIBNv1sjKi8nCW7lbW+2je5Td+2bs3xs2nhRjd9jlPvx7eF2xXThrVZiouPTt8QMH9/uOMyclhgyq6z+B1FgL0r52z+x2KY6c86bwMCqmZ3OarXtG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3viytOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381D3C433C7;
	Thu,  1 Feb 2024 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804739;
	bh=r33SDu8/DM+zYKaYrvveD9kjvKPsy8EfeVfboKSVxPM=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=u3viytOjwSNjSnVkgzp2uAPROok+mMNDNYZk4Q+0x+XlJ74NdrGuNDjrou+uuaRS4
	 WB56T4MxsZF8A25dCZQaI1d15Xc2w98GIdZk0tPRZRjJaizzgsVbqHNUB19ETTOgTf
	 qOYx8R4RHtvrvHAgmZJYvgauhy42IVf+92/3vIj/0naFRCKecYewRQGh09MiD+2W+U
	 h+bFpjdOevJCcu2QD5FemcC7jDX0EXVMOtiAjy9894TN/dyOYbffvhmTnVnkOSA/BS
	 0kcDkYfkmFx1LeLhi0z4bf0eFSszovujShUkmK4aLP9YGwLju1txIHkVO+Vlsw83uz
	 uH+4QepaYkM6Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201151747.7524-3-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com> <20240201151747.7524-3-ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v5 2/9] net: phy: add support for scanning PHY in PHY packages nodes
From: Antoine Tenart <atenart@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Conor Dooley <conor+dt@kernel.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Robert Marko <robert.marko@sartura.hr>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 01 Feb 2024 17:25:36 +0100
Message-ID: <170680473689.4979.1991415008659281513@kwain>

Quoting Christian Marangi (2024-02-01 16:17:28)
>=20
> +static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_n=
ode *np,
> +                                  int base_addr, bool *scanphys)
> +{
> +       struct device_node *child;
> +       int addr, rc =3D 0;
> +
> +       /* Loop over the child nodes and register a phy_device for each p=
hy */
> +       for_each_available_child_of_node(np, child) {
> +               if (of_node_name_eq(child, "ethernet-phy-package")) {
> +                       rc =3D of_property_read_u32(child, "reg", &addr);
> +                       if (rc)
> +                               goto exit;

This means a PHY package node w/o a reg property will prevent all other
PHYs in the same parent node to be found?

> +
> +                       rc =3D __of_mdiobus_parse_phys(mdio, child, addr,=
 scanphys);

You might want to save passing scanphys down, PHYs w/o a reg property in
a PHY package won't be "auto scanned" later.

> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index afbad1ad8683..7737d0101d7b 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -459,20 +459,33 @@ EXPORT_SYMBOL(of_mdio_find_bus);
>   * found, set the of_node pointer for the mdio device. This allows
>   * auto-probed phy devices to be supplied with information passed in
>   * via DT.
> + * If a PHY package is found, PHY is searched also there.
>   */
> -static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
> -                                   struct mdio_device *mdiodev)
> +static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *m=
diodev,
> +                              struct device_node *np, int base_addr)
>  {
> -       struct device *dev =3D &mdiodev->dev;
>         struct device_node *child;
> =20
> -       if (dev->of_node || !bus->dev.of_node)
> -               return;
> +       for_each_available_child_of_node(np, child) {
> +               int addr, ret;
> =20
> -       for_each_available_child_of_node(bus->dev.of_node, child) {
> -               int addr;
> +               if (of_node_name_eq(child, "ethernet-phy-package")) {
> +                       ret =3D of_property_read_u32(child, "reg", &addr);
> +                       if (ret)
> +                               return ret;

of_node_put

