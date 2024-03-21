Return-Path: <linux-kernel+bounces-109813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87443885604
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DF81F2130A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C728DCB;
	Thu, 21 Mar 2024 08:48:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718851BDE5;
	Thu, 21 Mar 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010883; cv=none; b=eOCWhAaLK5hLHo9Vzi7IWUDF7LJS27dsRFICrlCyGzN14GZUj5LIjJyD6t0sBpmvGft1PFWfEULtaMcs3v+bPbh3sCHiRTsrt4U71AJy+7mDYOLIOTL6P++9S/dfPbrLlPTnMBSTibJ3X4dwsbxs4XlONJMA1WKXKWuq6KHPq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010883; c=relaxed/simple;
	bh=jC7DMV4s7D8STLTAJFfyaKYItQwdwJmIzld+olmPC1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb8ffiSZaUbBXUfWkAPzwMjhidgbCwlK0lezxnfX9ID8aR5KdSZG1CDtz4i2I3mVHRapkUZp1wzcflmx0yOrlxtfW5qcmhpXczeMUzwf91Za9UjLfMEgreSehY1zo6/WuL3UW8SeduSZDLBkOeL3z8ScW230fOsvkpHbq71PzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rnE5N-0007Gb-C8; Thu, 21 Mar 2024 09:47:41 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
Subject:
 Re: [PATCH 2/4] media: dt-binding: media: Document
 =?UTF-8?B?cmszNTg44oCZcw==?= vepu121
Date: Thu, 21 Mar 2024 09:47:39 +0100
Message-ID: <855507987.0ifERbkFSE@diego>
In-Reply-To: <4c05d3c0-aa79-4ce0-918c-7d0967ace520@linaro.org>
References:
 <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-3-linkmauve@linkmauve.fr>
 <4c05d3c0-aa79-4ce0-918c-7d0967ace520@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 21. M=E4rz 2024, 09:14:51 CET schrieb Krzysztof Kozlowski:
> On 20/03/2024 18:37, Emmanuel Gil Peyrot wrote:
> > This encoder-only device is present four times on this SoC, and should
> > support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> > encoding).
> >=20
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > ---
> >  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml          | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-ve=
pu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> > index 9d90d8d0565a..947ad699cc5e 100644
> > --- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> > +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> > @@ -17,6 +17,7 @@ properties:
> >    compatible:
> >      enum:
> >        - rockchip,rk3568-vepu
> > +      - rockchip,rk3588-vepu121
>=20
> What is 121?

That is the strange naming of the ip block inside the soc.

I.e. the rk3588 TRM lists a number of different video encoders and decoders:
=2D VDPU121 is decoding h.263 and mpeg1,2,4
=2D VDPU381 is decoding h.265, h.264 and some more
=2D VDPU720 is decoding jpeg
=2D VDPU981 decodes AV1
=2D VEPU121 is the jpeg encoder above
=2D VEPU580 encodes h.264 and h.265

Each of those are separate IP blocks with their own io-memory, their own
interrupts and their own iommus, etc.


Heiko



