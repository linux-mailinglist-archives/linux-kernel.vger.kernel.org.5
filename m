Return-Path: <linux-kernel+bounces-48543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB54845D78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F851F26548
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5D3FDB;
	Thu,  1 Feb 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmDmAyJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC602C1B0;
	Thu,  1 Feb 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805632; cv=none; b=Lrd/tqcl1YU6YSi8XmcZayBaT/jd2R5JAnNAsaOr3gfv6kGvJANd1YVigxXj32TIuQsUPgQNMRW7ljWDfw1AoQ9Z+91P7S/HXfBGVvhdgx8bBV+GxGLZzD/Z9n7O9ZdnzjCw/1j8oJ9XHrIwgC9jLqka3y7QyIOE9XE78UQQgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805632; c=relaxed/simple;
	bh=1uDUyfxjxc7ZnmKbXWn7c4080mDYIoyCn8OIHNE86Do=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=FEqCGEJvNSw0NNGlMeIcdXzPLOB/maz88Ek1WNy0epXkjPT377ow4E+ZZQmasS4FecuY7pxy8CZMKO7gHvL85MCWx0RqUGhE1TYWy3qEsUXLbFsX7rfviqaE1Dvoj4xZe4I/4emXFEMR938oOoyn1gaXCuqA/+ggR1Eh3qgwlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmDmAyJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED34AC433F1;
	Thu,  1 Feb 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805631;
	bh=1uDUyfxjxc7ZnmKbXWn7c4080mDYIoyCn8OIHNE86Do=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=NmDmAyJI7oXl7gcgFhi3lr6+03TWmLAbJZU+wUiXVk4W1c71yCNK9V/PbFOCkhEYu
	 WzgxZwkrQkpyZzkyOewO7UnApEN2OsJCki760LTK1zhDCoW0vWtzkvcKaoQBEbLi3R
	 5Q+XvnIpY3EibKFsBlqxXAXLdi7UDkPsh+Zzw2W7pO/cRKDBeQvw5jJ5P+Unjdej6a
	 XgMLVAqcVTD699HdwsVBim0W9vLZMDGo55Gmwv65lXGsUWhIRFqdJlxoFfifGkGWiP
	 gHiSosa7R+ENx6DDudg6ECj4B75PMg5UTC8VGAsH7GARMh0TBejZdT532Gw+PxVmTl
	 hjwN0vK7sytDA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201151747.7524-4-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com> <20240201151747.7524-4-ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v5 3/9] net: phy: add devm/of_phy_package_join helper
From: Antoine Tenart <atenart@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Conor Dooley <conor+dt@kernel.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Robert Marko <robert.marko@sartura.hr>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 01 Feb 2024 17:40:28 +0100
Message-ID: <170680562826.4979.15332968112575820833@kwain>

Quoting Christian Marangi (2024-02-01 16:17:29)
> +/**
> + * of_phy_package_join - join a common PHY group in PHY package
> + * @phydev: target phy_device struct
> + * @priv_size: if non-zero allocate this amount of bytes for private data
> + *
> + * This is a variant of phy_package_join for PHY package defined in DT.
> + *
> + * The parent node of the @phydev is checked as a valid PHY package node
> + * structure (by matching the node name "ethernet-phy-package") and the
> + * base_addr for the PHY package is passed to phy_package_join.
> + *
> + * With this configuration the shared struct will also have the np value
> + * filled to use additional DT defined properties in PHY specific
> + * probe_once and config_init_once PHY package OPs.
> + *
> + * Returns < 1 on error, 0 on success. Esp. calling phy_package_join()

So, < 0 on error ?

> +int of_phy_package_join(struct phy_device *phydev, size_t priv_size)
> +{
> +       struct device_node *node =3D phydev->mdio.dev.of_node;
> +       struct device_node *package_node;
> +       u32 base_addr;
> +       int ret;
> +
> +       if (!node)
> +               return -EINVAL;
> +
> +       package_node =3D of_get_parent(node);

Is the node put on package leave?

> +       if (!package_node)
> +               return -EINVAL;
> +
> +       if (!of_node_name_eq(package_node, "ethernet-phy-package")

of_put_node? + below.

> +               return -EINVAL;
> +
> +       if (of_property_read_u32(package_node, "reg", &base_addr))
> +               return -EINVAL;
> +
> +       ret =3D phy_package_join(phydev, base_addr, priv_size);
> +       if (ret)
> +               return ret;
> +
> +       phydev->shared->np =3D package_node;

Just looked quickly, looks like ->np is uninitialized in the !of join
case.

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_phy_package_join);

