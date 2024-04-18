Return-Path: <linux-kernel+bounces-150541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC48AA0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14BC1C229D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D56A171E57;
	Thu, 18 Apr 2024 17:07:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8A17109D;
	Thu, 18 Apr 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460039; cv=none; b=YzhFfXKY5WZeRX39nswPpReZaDDoPJvrLvzhMazeWf4Ut/8D3F8J+96tVPf719dVEgI0Ha7CPctZJBfy07iDW1Uw9PNEQpbchvynI9HSTHhybpA3gYIotxumnuPtdpB0TvL1hBEUxOXG/jfsBFnvWMlyXulFyIqSkxj9QtDvgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460039; c=relaxed/simple;
	bh=WC30OFMc14/UNKx0UaMstGBJDDBM8TR/dxv2o6feHjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U95Q8vbRYAOyIKhYYX1AGNtfNC+O5kRG1Ol5E0Vb2d2ipAZsatGRdOM1DuBxTV5Uc6WrKiDP7bdR42I574JKZv0Z70rSF8GLWwBwLUzSV6xZeOCzAjrgaqAywhgmkpXKxjJSk7je5CGI5m/zg3EuDkModjBiGFCjalnBPcMU860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxVE5-0000vA-Kr; Thu, 18 Apr 2024 19:07:09 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, amadeus@jmu.edu.cn,
 FUKAUMI Naoki <naoki@radxa.com>
Subject:
 Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions for
 Radxa boards
Date: Thu, 18 Apr 2024 19:07:08 +0200
Message-ID: <2603669.Lt9SDvczpP@diego>
In-Reply-To: <20240418-attach-tigress-bc2b9f844fc7@spud>
References:
 <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <1888572.CQOukoFCf9@diego> <20240418-attach-tigress-bc2b9f844fc7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 18. April 2024, 19:04:44 CEST schrieb Conor Dooley:
> On Thu, Apr 18, 2024 at 06:59:42PM +0200, Heiko St=FCbner wrote:
> > Hi Dragan,
> >=20
> > Am Donnerstag, 18. April 2024, 18:26:19 CEST schrieb Dragan Simic:
> > > Correct the descriptions of a few Radxa boards, according to the up-t=
o-date
> > > documentation from Radxa and the detailed explanation from Naoki. [1]=
  To sum
> > > it up, the short naming, as specified by Radxa, is preferred.
> > >=20
> > > [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-=
601b-4d4a-a513-4924b7940076@radxa.com/
> > >=20
> > > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> > > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Do=
cumentation/devicetree/bindings/arm/rockchip.yaml
> > > index fcf7316ecd74..ae58e25c29ec 100644
> > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > @@ -767,22 +767,22 @@ properties:
> > >            - const: radxa,rockpis
> > >            - const: rockchip,rk3308
> > > =20
> > > -      - description: Radxa Rock2 Square
> > > +      - description: Radxa Rock 2 Square
> >=20
> > I may be just blind, but what changed here?
>=20
> There's now a space before the 2.

ah, now I see it too :-)



