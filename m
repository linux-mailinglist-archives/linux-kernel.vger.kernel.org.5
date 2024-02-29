Return-Path: <linux-kernel+bounces-86110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120186BFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9DD1F249F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685A3770B;
	Thu, 29 Feb 2024 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku3TJ9Jv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501D37165;
	Thu, 29 Feb 2024 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179518; cv=none; b=XYwwgumu2DXq2pL2GjWuG0kqQcleflO9bwXoGN9GKVz1ybZnSso3nYivB5jIrfU4Vwyvw/6U9AES2oZD8UTcrLgoFeCGr70Pg9+v/StCTvHNw3ysdXicDymoAWFFY5dlSY+0ucqbj+NbP12lkroxec3y/4wh5HKv//Ct1C3g4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179518; c=relaxed/simple;
	bh=j4RybmKO5z0+jOU5Q3bgVmNyKqmwl5OF6DdBnB6iTOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQzHB9gRD5j8ooXb0K1OhvY3RFuX4LIQEpUQF3Wq4NkSifGS1uFAlpt51BmTHjlVu9CY+G95jQejWoo5afQK7H6erNMjQynHTi6nuYCc7y2Gn54zX3UkXLrahpLUE8RghtD6Fg3i2WVHcNUv+sel61sagQAOpD4lnpn8ax0cpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku3TJ9Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A54EC433C7;
	Thu, 29 Feb 2024 04:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709179517;
	bh=j4RybmKO5z0+jOU5Q3bgVmNyKqmwl5OF6DdBnB6iTOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ku3TJ9JvMsZRW9Y8+kYLiSuQn8yfuYHrVpOmC9k81z1UISiws/VioRMjVDK2hn/va
	 vxHV1BYGS0IuN+rxDOxdz6pX6rl+qHmyFSWB4Nw4+IcG4IKuyEUH7Jh/OTpobXy0bA
	 pv+8IN3wSeoNbaiMAhyccYNjxaBHKIAkvz8Hnk09C0LSs7bUmqXgSqhC+zY4P0vyXh
	 c2IDW2EtfyvCZ5sV3PiOveKSB4LRfYTQc0RtM8WO7pylBUwwZhl6jdbFi5R8Dm/wFT
	 XpgRgqTrQeSwwou27b8gMc1OAoauVpevfX6QtkyduMys3Nj7szSLvkQVpfAev5OGXq
	 sRWC0GRLP3wCA==
Date: Wed, 28 Feb 2024 20:05:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSw=?= Jorge"
 <Jorge.SanjuanGarcia@duagon.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "r-gunasekaran@ti.com"
 <r-gunasekaran@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Message-ID: <20240228200516.1166a097@kernel.org>
In-Reply-To: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
References: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 11:13:23 +0000 Sanju=C3=A1n Garc=C3=ADa, Jorge wrote:
> Since commit 8940e6b669ca ("net: dsa: avoid call to __dev_set_promiscuity=
()
> while rtnl_mutex isn't held") when conecting one of this switch's port
> to a DSA switch as the conduit interface, the network interface is set to
> promiscuous mode by default and cannot be set to not promiscuous mode aga=
in
> from userspace. The reason for this is that the cpsw ports net devices
> do not have the flag IFF_UNICAST_FLT set in their private flags.
>=20
> The cpsw switch should be able to set not promiscuous mode as otherwise
> a '1' is written to bit ALE_PORT_MACONLY_CAF which makes ethernet frames
> get an additional VLAN tag when entering the port connected to the DSA
> switch. Setting the IFF_UNICAST_FLT flag to all ports allows us to have
> the conduit interface on the DSA subsystem set as not promiscuous.

It doesn't look like am65-cpsw-nuss supports unicast filtering,=20
tho, does it? So we're lying about support to work around some=20
CPSW weirdness (additional VLAN tag thing)?

