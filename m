Return-Path: <linux-kernel+bounces-30589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7683213D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447F028AB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460931A6B;
	Thu, 18 Jan 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="SNygzZwl"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460F2E848;
	Thu, 18 Jan 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615225; cv=none; b=AM38J6gQvGzdqSptVER+eQHj+M1nDgFKmJzcNRu6y6vCDt9n+muAfGppZOWQuEFRM6hIlP+M/G9wZ6b1I8u1M7m+JMk9BKEWs0FLjyrXFeFyheAbu8Xdw9TYAAdhkShaPAVqePlebFj6w9k3dW4IM0jZdQC1IKEgn3tUpzwqnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615225; c=relaxed/simple;
	bh=wLvsv08eBZtYU7ZaISCpiqBuWqPFTTvXPV3fWg3VUvE=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=lvDJxyU9HM6+fdVtRvQo6+oxCZiuedCRNgase7XSvxTwsUKfgaFa/1uo5eJWAzPRKBURFNG/rzCeTOhzWwLFOLFZ6sudaKKJhweynEn8B8SRP/qx4//VfFzZLihrUcmfFGxOGs9zt9wvLokKN6GvGGftTqer32u5tmbYFBqbEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=SNygzZwl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1705615201; x=1706220001; i=frank-w@public-files.de;
	bh=wLvsv08eBZtYU7ZaISCpiqBuWqPFTTvXPV3fWg3VUvE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=SNygzZwl8NfRCJswcMPa1qVnqtVMkWjHZFA8tBNg4DXhCdz2eroL9vQ3dbkRQ/Ni
	 aj7x406MCWWHhVcekTs/Ba8hCs6VsigS3bFLa1UwnMyk9lZb7ZHDs6OflttwxQZJ1
	 nvMcMdnSzcOJUDp64TZx7g1ThNYgkiRnReat+IQ/bbSTQiwLese2F6/Yy4n6AfZqu
	 gmhRIf+u9XOcljJqD2OF1TUDfuqTQTlfbriHhNvPkS7AOI+kzGMjt/mwM4/X2Rfu6
	 c1yQPaB5n2/OnV+dJphPqXqt3kLdC6X8XD+PmvnlPO3LY2ljEiGTyAe+HAgqvQqHx
	 Ir5lZe60hBiIPyD3DQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.198] ([217.61.159.198]) by web-mail.gmx.net
 (3c-app-gmx-bap21.server.lan [172.19.172.91]) (via HTTP); Thu, 18 Jan 2024
 23:00:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21>
From: Frank Wunderlich <frank-w@public-files.de>
To: Conor Dooley <conor@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <linux@fw-web.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988
 reset IDs
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jan 2024 23:00:00 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20240118-calcium-krypton-3c787b8d1912@spud>
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
 <20240118-calcium-krypton-3c787b8d1912@spud>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:i7cKlr7pbBOeeo2MJju4eygi1kMNVyLIp+PFrgFTenIkemr6mJ/6zZ1a/Lg1H9bvFTdMp
 TI7kGYsJ+UQM26RzgcW7nABwCLt3D1kj+LOIj9a0Cq6nZrtefigXaCJBaeV3x/mcPy6KsMB7kXU9
 dM0jDKxM9ibIjtGnclsOb0Mqoog2SEyR9Cko1fqakeMUdslD4rpxVB2ypJfppjPFxuXFdFYGPzQP
 6O3N8pLs7UnnLzru6iS1jFdOxB0t/+rjiqYhxiD96PppyYlpd6CUzg/T4yYBP9pq3BNDAGSOm9e5
 ik=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gzu+rTj6VvA=;AFUqbzs2KLld0OIuq1bzMhSKPgl
 Kd7wJWth+9/ff1+bN2OyVvlJR0rjHQ7GcdSOu5Gg2jgh331Cni4J64RQFLkLC/EaHwzxmS2Uz
 XL44FMFv8vE4oCmSOzKtD24Nr1ISiK9JraRdcY5PZPfIDv122vBbvsk3DHmEjbM+q9fjkMb+q
 YmREoZ5tY3k9jH3P9QMpN3UYxARaUzCezNsWzSsRDitvRXFPI9fyn9SYTqT9tRfC1Uh9cnCyW
 m6plg3l/HV2u/4ItKFKwD/yX8o6kNWsy6th/2u0qO4+EDzy7hMz96zo4kkzFTzjzPdATfYYG/
 CcQ65Cxeo/Q3IDz/NmtvkpGq7/d+hIR3pNHpweLsy50DWTic+PHXlQ+wc4c3JxdIY/+eJgar9
 9dSDWS6xBkRSUzCX26dPWzEowUPPaKtAPl0kkQY9BLoXZmlM1LuzV3oHW0TpGiPXsVR6bPWw+
 nhxlc2CGClYR2an6957v3MOMdYtqbNnanhl79XeoEMFIqgqHYiDPrO834OqDPg4AM6b6qIVF1
 WR7gsIYRWrdXsS+lhb/FHdIOt+wwG8hBHQ6ihMBrnrUSgm8xTWHEJM+v6a4U3ZQYLeQPEUJn7
 omzxu8D1RDFlLgxRO9viMu0N/xh0Qr9W2niMCedv4y4VEjFJMhxK+ygXRKjwzastXE3TYNJea
 WlA+RXaGs7BDFDEXjBV1DJDzATdgGqXq8AnOW9CtWyrrirW9TJpTV0IRbj6No/L8d5pqf01oj
 E8+0bhGoBMcdz8f6cL6gqxMCoGGAH1tVzG9IlVljibVUcGPRy8IhPXyxK5yFok+EerEmSq2tL
 b5i84Et/qC1kETeXvhxKK7ew==
Content-Transfer-Encoding: quoted-printable

> Gesendet: Donnerstag, 18. Januar 2024 um 17:49 Uhr
> Von: "Conor Dooley" <conor@kernel.org>
> On Wed, Jan 17, 2024 at 07:41:10PM +0100, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add reset constants for using as index in driver and dts.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v3:
> > - add pcie reset id as suggested by angelo
> >
> > v2:
> >  - add missing commit message and SoB
> >  - change value of infrareset to 0
> > ---
> >  include/dt-bindings/reset/mediatek,mt7988-resets.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/incl=
ude/dt-bindings/reset/mediatek,mt7988-resets.h
> > index 493301971367..0eb152889a89 100644
> > --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
> > +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> > @@ -10,4 +10,10 @@
> >  /* ETHWARP resets */
> >  #define MT7988_ETHWARP_RST_SWITCH		0
> >
> > +/* INFRA resets */
> > +#define MT7988_INFRA_RST0_PEXTP_MAC_SWRST	0
> > +#define MT7988_INFRA_RST1_THERM_CTRL_SWRST	1
>
> These are just "random" numbers, why not continue the numbering from the
> ETHWARP?

i can do...basicly these consts are used in DTS and driver only as index.

@angelo what do you think? I though also in leaving some space to allow gr=
ouping RST0 and RST1
when more consts are added, else the numbers are mixed up.

so e.g. let RST0 start at 20 and RST1 at 40 (or even higher, because RST0 =
and RST1 can have up to 32 resets).
That will allow adding more reset constants between my values and having r=
aising numbers.

regards Frank

