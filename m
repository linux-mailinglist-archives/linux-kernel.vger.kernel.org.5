Return-Path: <linux-kernel+bounces-28598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754B83008A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBECD287C67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7DBA56;
	Wed, 17 Jan 2024 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CAER3jUp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049D522E;
	Wed, 17 Jan 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476692; cv=none; b=pOlnzz7itgmoDKrNF9Tf7pxDFdA84oNU80PDa8Vqa7U3QBGv5mvrjwhvg3jJV2Fh+gD9pCtokmTCplc08dVSzBka2wHHgDoES5cOblJwh0TklExSO7T/s+p5e8M/qLEImbpKXI6NsIKHvRaCYp/T4IkB7hJQ1ldyXj4NlVYKa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476692; c=relaxed/simple;
	bh=y+v72DxdaWwPawAjkgAWECXv7AEd+Wv5JYD3EdJHzFM=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type; b=SdzdNwB8O+hCplQgfuCyzWjPWxaldcnSAj3PP8G6xqoDFZZa0Qh3F/10j3fyCeA9wqqGAc/gAo6rnOCE9bYPwh//ol4f1R/YTcogdoktp5Joj4JhO2wYgbQGVqXeIEn7Bk2Wxs2q7E7xq5fCAePNHKuOXdObjxRSGTHZSAp3ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CAER3jUp; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705476689; x=1737012689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xNnBrvieWWbB+ps1YZihprwsk4SZEYccvgQBAmcfzPE=;
  b=CAER3jUpXWSxKdOzxUmedr+N+KshcSljkXqZGZ9A0poHYW7D9WDlGCYh
   Pd35TZZs0tAojDYRNb76kGFPJfQisuE8PoJavf1ZlIUoT776Lft0hCtYZ
   iVUOsgS8daisONa3DfW/HAurSa6U7qYRTBxDxYxQz5q2s5Cbz8VAlrbAG
   +TKwdKzBgVA2IdRqaYwuMf623PPqKSNQG+KjQQfS58zt//lcJCwTg01kv
   JHknAOfJUdAKv7HnTooOGHpWsgvZeKx0fVySUNlAZZyoPu18+QCdUIPq+
   vOEHUJ+ai0FYbzym0WCicgZssgIYoSaiVNWE1jHw8FWDBVlmOjQAfg/nI
   A==;
X-IronPort-AV: E=Sophos;i="6.05,200,1701126000"; 
   d="scan'208";a="34930894"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Jan 2024 08:31:26 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 57C70280075;
	Wed, 17 Jan 2024 08:31:26 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl, irqsteer: Add power-domains
Date: Wed, 17 Jan 2024 08:31:26 +0100
Message-ID: <13433324.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240111-dullness-blooper-37644405c825@spud>
References: <20240110094338.472304-1-alexander.stein@ew.tq-group.com> <9230083.CDJkKcVGEf@steina-w> <20240111-dullness-blooper-37644405c825@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Conor,

Am Donnerstag, 11. Januar 2024, 17:49:03 CET schrieb Conor Dooley:
> On Thu, Jan 11, 2024 at 09:59:54AM +0100, Alexander Stein wrote:
> > Hi Conor,
> >=20
> > Am Mittwoch, 10. Januar 2024, 17:09:07 CET schrieb Conor Dooley:
> > > On Wed, Jan 10, 2024 at 10:43:38AM +0100, Alexander Stein wrote:
> > > > Some SoC like i.MX8QXP use a power-domain for this IP add it to the
> > > > supported proerties. Fixes the dtbs_check warning:
> > > > freescale/imx8qxp-tqma8xqp-mba8xx.dtb: irqsteer@56000000:
> > > > 'power-domains'
> > > >=20
> > > >  does not match any of the regexes: 'pinctrl-[0-9]+'
> > > >=20
> > > > from schema $id:
> > > > http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yam=
l#
> > > >=20
> > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > ---
> > > >=20
> > > > Notes:
> > > >     Please note that both the board dts and the DT node for irqsteer
> > > >     being
> > > >     used, are still work-in-progress.
> > >=20
> > > The binding doesn't even support the imx8qxp's irqsteer yet, I think
> > > this should be added alongside support for that SoC. Am I missing
> > > something?
> >=20
> > I'm not sure if any additional SoC support is actually needed. 'fsl,imx-
> > irqsteer' is available and that's what I use in my WiP. Also imx8mp also
> > just uses the generic compatible. Only imx8mq uses 'fsl,imx8m-irqsteer'.
> Why doesn't it used "imx8mq-irqsteer"? Should it not have its own
> soc-specific compatible?

I would assume that "fsl,imx8m-irqsteer" is for the whole i.MX8M family. I=
=20
don't think a soc-specific compatible is needed at all. On top I can't see =
any=20
difference between i.MX8M and i.MX8/i.MX8X.
If a soc-specific compatible is preferred, fine by me. But I don't expect a=
ny=20
difference despite imx8qxp/imx8qm requiring a power-domain.

Best regards,
Alexander

> Cheers,
> Conor.
>=20
> > AFAICS the bindings support the different amount of IRQs already.
> >=20
> > Best regards,
> > Alexander
> >=20
> > > >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3
> > > >  +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.
> > > > yam
> > > > l
> > > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.
> > > > yam
> > > > l index 20ad4ad82ad64..cb4fcd23627f6 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.
> > > > yam
> > > > l +++
> > > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.
> > > > yam
> > > > l>
> > > >=20
> > > > @@ -42,6 +42,9 @@ properties:
> > > >    clock-names:
> > > >      const: ipg
> > > >=20
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > >=20
> > > >    interrupt-controller: true
> > > >   =20
> > > >    "#interrupt-cells":


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



