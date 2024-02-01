Return-Path: <linux-kernel+bounces-48211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC718458A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BF91F27F62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6AE5B680;
	Thu,  1 Feb 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tnXpvvYb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC762141;
	Thu,  1 Feb 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793170; cv=none; b=gpg5A/HByvRI65sJFzdtHrpiAw3cHwoB1UAB+EdyWmd22dvsDs/o52SNb6fpErxhy9wuHHjxiuYA3TK66uqtzaWPCdpfcGkiHujJ5S908krmSstnRYmPARCccDqwL7WxtqeLAZNWRgayedsCGGkhO7rXPy/eS9V37tdmUk4rQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793170; c=relaxed/simple;
	bh=qvtQsVUpv6mrbOusIihe550/VZAo/qI5LTEF9Sr+vYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZXmpyf0dfecKh82qe4n7/BqYZoEQrEdt3livDNt5vpMFb2miHNs/YI9eAshsZQoxpykZqfeS2dn2TVFylVHhGmH3P9H89vIsCGFak5Cu04IW20rZoEHpxGwPG+FhhYC1mOxng38FE0RAVczgFOsGI4P/E+SXBkINlhPG7aoYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tnXpvvYb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706793169; x=1738329169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvtQsVUpv6mrbOusIihe550/VZAo/qI5LTEF9Sr+vYc=;
  b=tnXpvvYbOg9GNGZJTIfv1k59HOOELkzDc2fBILKzb611pVZs2H+jmUh0
   JNqzV1KR4nvZLrCd1Te3TlWOfyGiInkfSRulCmVZZUP5DN5FOHYDQ49eK
   y9Rp3RTcXeXzMDJkWjNHOBU7SB0tg17Kq75/EDbZR1x4sTs2TJr5Uk/wo
   JsOXWvb9fhVVHRBCg6VtBVOhqhzjmDbvt5+PUWBWAdtt+IkiiNohKFrhg
   LciGzh7KWOT1TF3Kv8dCuu4rbZJTHkkm36CHWuiQphqT0/M795IdALFkv
   pXNiTTSUECCrypC64j6i088L2hSDlU06Tdy6G7xE9mqkExciIxJZPAmOB
   Q==;
X-CSE-ConnectionGUID: DojxIC2fROuGfno2oWJAig==
X-CSE-MsgGUID: UGxvDEb7R5C65tm/xwNFig==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="asc'?scan'208";a="15617257"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 06:12:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:12:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Feb 2024 06:12:18 -0700
Date: Thu, 1 Feb 2024 13:11:39 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Frank Wunderlich <frank-w@public-files.de>
CC: Conor Dooley <conor@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Frank Wunderlich
	<linux@fw-web.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Sam Shih <sam.shih@mediatek.com>, Daniel Golle
	<daniel@makrotopia.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: Aw: Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988
 reset IDs
Message-ID: <20240201-goes-passable-0ba841d36bc3@wendy>
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
 <20240118-calcium-krypton-3c787b8d1912@spud>
 <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21>
 <43f946cc-07e1-48c5-9b31-40fc9bc93037@collabora.com>
 <20240119-dupe-obligate-707b3a01b356@spud>
 <0EA6A126-DDC0-4E9F-BEBC-FD018B08CA84@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7WXHEjVDjRcKaa45"
Content-Disposition: inline
In-Reply-To: <0EA6A126-DDC0-4E9F-BEBC-FD018B08CA84@public-files.de>

--7WXHEjVDjRcKaa45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 12:40:17PM +0100, Frank Wunderlich wrote:
> Am 19. Januar 2024 18:04:36 MEZ schrieb Conor Dooley <conor@kernel.org>:
> >On Fri, Jan 19, 2024 at 10:28:30AM +0100, AngeloGioacchino Del Regno wro=
te:
> >>
> >> The resets are organized on a per-reset-controller basis, so, the ETHW=
ARP
> >> reset controller's first reset is RST_SWITCH, the second one is RST_so=
mething_else,
> >> etc. while the first reset of the INFRA reset controller is PEXTP_MAC_=
SWRST.
> >>=20
> >> That's why ETHWARP has a reset index 0 and INFRA also starts at 0.
> >> I think that the numbering is good as it is, and having one driver sta=
rt at index 5
> >> while the other starts at index 12 would only overcomplicate registeri=
ng the resets
> >> in each driver, or waste bytes by making unnecessarily large arrays, f=
or (imo) no
> >> good reason.
> >>=20
> >> This is one header, but it should "in theory" be more than one... so w=
e would have
> >> one for each hardware block - but that'd make the reset directory over=
-crowded, as
> >> other MediaTek SoCs have got even more resets in even more hardware bl=
ocks than the
> >> MT7988. That'd be something like ~4 reset headers per SoC (and will in=
crease with
> >> newer ones)...
> >> ...and this is why we have one binding header for resets.
> >
> >That's okay. The commit message leaves me, who clearly isn't a mediatek
> >guy, with no information as to why these are not one contiguous set.
> >IMO being for different reset controllers entirely is fine.
> >
> >> On the topic of leaving space to allow grouping RST0/RST1: -> No. <-
> >> The indices have to start from zero and have to be sequential, with no=
 holes.
> >
> >Agreed.
>=20
> Hi,
>=20
> Just a friendly reminder.
>=20
> As far as i understood, Patches are fine so far and do not need any rewor=
k,right?

I suspect I was asking for a commit message that explains why these
numbers don't continue in sequence. With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> But i have not seen them picked up yet in linux-next.
> regards Frank

--7WXHEjVDjRcKaa45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbuYiwAKCRB4tDGHoIJi
0pvVAP93MxxzBvNZvtpY9olFpk98CWj6rUSSZNqZsc6xps/yEAD+Kke0OXNnExQZ
iR3rlwQAtPweOolLZJS0LiATIRpshgQ=
=wI+F
-----END PGP SIGNATURE-----

--7WXHEjVDjRcKaa45--

