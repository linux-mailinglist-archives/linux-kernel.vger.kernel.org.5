Return-Path: <linux-kernel+bounces-138319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3664B89EFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D3D28195B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E4158DB0;
	Wed, 10 Apr 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GMoX2O1G"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA2158A24;
	Wed, 10 Apr 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744651; cv=none; b=kjru5aYNmNrO878Q3HgzxP8QYHVp9uce5eZc+bdeNH3wtb64b296c5OSUSQHU5WXR4MX2+kW5NTn21lfFCRftCW0H/YdJC2689l+6kwWowucxGaMh+wdFIDiqeq5aQV7DRWHBRVOkKJxk06KHeJEEWeUPIhxN/2QWjAAD0bzIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744651; c=relaxed/simple;
	bh=RMe4Zpgtu5lgHf/0r65e7RdGffT8CNspf79NQcq4bhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moKBFmDG/flrnjHMXe7v0YVGhvhx+LLg7t3Ah/7UW6yDno+HOKFy1cNfnRSjD98UOYtRkgQDBhMO1d9NkI+elRtU3ts2Y7A83lhovDG9xHdBXYZ//PX51IYFiavDdsg8BoSSZH/cJkNqJLKTC/DEnqwWj9V2vZq2dCjOjl6Zkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GMoX2O1G; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAACEFF802;
	Wed, 10 Apr 2024 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712744641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/SknAElnT6j5HCw0JAN47JCCpbMZWq8jCtLo3WbP8M=;
	b=GMoX2O1GLeEWdq3Ksgs4NQSytZdT94CWaTvbV8+vCpznmR3+YvQhX86Se1T5n+sa9UYRRu
	7sjR5RBaUY5F9OCxxf1NscWUs7f2wbWClLClCmeEK6Cvxkez43ejEhudPvS4NM4t7arQr7
	jKkUYBRl0tF1IxAILLgPRxiiF9SkKaT67sb3JFsmx4YtoQMVoh0FHDgEQVuvj3kSDBlyl5
	xmwSOspIEDT2CRKLnCHlo1FIKJrdZ3ORsr81S3sZdPMXraiktKbHQKuZ6nieI6lnDqUNJD
	NpkrMsVyGQnGmRiH1ICqf2VIohsqjE9P06sFV08Z0MMrun8zZ9JfMFBuKfeJ5w==
Date: Wed, 10 Apr 2024 12:23:56 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240410122356.30852b3c@xps-13>
In-Reply-To: <20240409181025.55504-2-avkrasnov@salutedevices.com>
References: <20240409181025.55504-1-avkrasnov@salutedevices.com>
	<20240409181025.55504-2-avkrasnov@salutedevices.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Tue, 9 Apr 2024 21:10:24 +0300:

> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages located with the specified interval
> within specified offset. Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.
>=20
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 57b6957c8415..b86a1953056b 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -64,11 +64,25 @@ patternProperties:
>          items:
>            maximum: 0
> =20
> +      amlogic,boot-page-last:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM.

Shall we have a length rather than the last page?

> +
> +      amlogic,boot-page-step:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM (in pages).
> +
>      unevaluatedProperties: false
> =20
>      dependencies:
>        nand-ecc-strength: [nand-ecc-step-size]
>        nand-ecc-step-size: [nand-ecc-strength]
> +      amlogic,boot-page-last: [nand-is-boot-medium, "amlogic,boot-page-s=
tep"]
> +      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-page-l=
ast"]
> =20
> =20
>  required:


Thanks,
Miqu=C3=A8l

