Return-Path: <linux-kernel+bounces-49641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305B846D53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0D28D003
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFF78B7C;
	Fri,  2 Feb 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzo8R8xe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6013FE2;
	Fri,  2 Feb 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868363; cv=none; b=NqiQUH4tRM1ekFo/YfQ5dzBRmExw1RwDDA8PAuUx+WikF4+BW9ffsOVEcAXkkcoYIdj0Awq36MtIKM6wP3dAHnBaL1U7uSGYv7GJu/y+ljumLMHCPeHGV8JWrmmgGLBbSI9DVHrxP4afPltO9QRp0DiGHjV5RjGLVToTPxFO7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868363; c=relaxed/simple;
	bh=uTfOPhF7lGGU9a7RPw0FBYAE8vU05wC8egd2y8enBZM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=D8LYDyVNIpmLpWi2PbYllrfhiw+dzrdwRdpSb5OIhmhLRVg0PZrCQEzDB5sRvMPe894yISIiYyZj0FgbM7e29OXwtcEyndolye/PElfqJ4va9sQDbObguAFJYdzZbuvACuK4zauB2GdnhjTHy6g1SoGC2dy18SJ0eeMG2QBH0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzo8R8xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D272C433C7;
	Fri,  2 Feb 2024 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706868363;
	bh=uTfOPhF7lGGU9a7RPw0FBYAE8vU05wC8egd2y8enBZM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Dzo8R8xeVWazqmpA+8BHjGKyvFBT8CZho4MztMK+7zLhCg26U59z+N1CDX7z6NZre
	 k/b3y5lz6mu6dORw1F+aAlPhC0ufiIiCJ0i5VHA+4a8vR4K04+ebpkC0Vvm9ZOfUwv
	 dP0Bo4QVQ+rMN1STKB4dRWrqUKOu8dAwZQc2TFgKNj2MKThWjTfIVIvOUXrDb13Ieg
	 bGT2og5yu/gm/8KJ0gN8qs/MvNx0JTQKluU9l1wU4IbpCIsuyzwASPMi8Wj39+wOsq
	 BUNUZdcl/vN9W5r9YWjRRmSsSKfLNoTUddmM4LRubkm7HrsKG7WImAJLVj9gzh7h10
	 kwdX2KoTHRz1w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65bbd2ce.050a0220.5ff09.69d5@mx.google.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com> <20240201151747.7524-3-ansuelsmth@gmail.com> <170680473689.4979.1991415008659281513@kwain> <65bbd2ce.050a0220.5ff09.69d5@mx.google.com>
Subject: Re: [net-next PATCH v5 2/9] net: phy: add support for scanning PHY in PHY packages nodes
From: Antoine Tenart <atenart@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Robert Marko <robert.marko@sartura.hr>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
To: Christian Marangi <ansuelsmth@gmail.com>
Date: Fri, 02 Feb 2024 11:05:59 +0100
Message-ID: <170686835980.5216.5174621768810456847@kwain>

Quoting Christian Marangi (2024-02-01 18:20:10)
> On Thu, Feb 01, 2024 at 05:25:36PM +0100, Antoine Tenart wrote:
> > Quoting Christian Marangi (2024-02-01 16:17:28)
> > > +
> > > +                       rc =3D __of_mdiobus_parse_phys(mdio, child, a=
ddr, scanphys);
> >=20
> > You might want to save passing scanphys down, PHYs w/o a reg property in
> > a PHY package won't be "auto scanned" later.
>=20
> I might be confused by this, but isn't this already done? (passing
> scanphys in each recursive call so we can set it to true if needed?)
>=20
> Also I think the scanphys should be skipped for the PHY package
> (assuming we make reg mandatory, it would be an error condition and
> should not be handled?)

Sorry if that wasn't clear, this is what I meant. scanphys doesn't need
to be set to true in a PHY package (both if we want reg to be mandatory
there and because my understanding of the auto-scan code is PHYs in a
PHY package won't be auto scanned anyway).

Thanks,
Antoine

