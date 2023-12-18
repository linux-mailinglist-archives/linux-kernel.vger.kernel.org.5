Return-Path: <linux-kernel+bounces-3078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE4816701
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A32A283F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71F79F9;
	Mon, 18 Dec 2023 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="an2/oE4i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4279C7;
	Mon, 18 Dec 2023 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 289BF1BF205;
	Mon, 18 Dec 2023 07:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702883110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pCADSogZK79IR7x+P2Nc6fAgr4N1layvnkqfeF/Lhk=;
	b=an2/oE4i6QfChTNyT07C4TXk44v2PDcwGykdhvSYxJ+RSkA+q2egcUGKEpaQIrVm0cgWht
	XJ5b5giexmZkngiS4cspqdfVZG0shzQfpBGW/6cn77TD+cq5dAONrACmB1V9m55UAw7gRr
	txPOMfr4ThzaJvh336DNy1Yc6QxSMMTqXvK2tkSEug4sAS+eZARoK94HQxMsgbAcsfw1SI
	kcsOkbS0WJHvzXPZatffQK17XAGMXYjg2JOQjSLBALANWl8AcHqftWc+s4wMBhgl4T/Nho
	A8g2BlnfZQ3v2o6TcXkc22Z98fAu6XIRGaZB1rQXud+kF4B+JTuoxYK2xTzEgg==
Date: Mon, 18 Dec 2023 08:05:08 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: mtd: ubi-volume: allow UBI volumes
 to provide NVMEM
Message-ID: <20231218080508.1803ac17@xps-13>
In-Reply-To: <778eaad045dbf9e10448dc5db7c0ef468191488e.1702850093.git.daniel@makrotopia.org>
References: <cover.1702850093.git.daniel@makrotopia.org>
	<778eaad045dbf9e10448dc5db7c0ef468191488e.1702850093.git.daniel@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Daniel,

> --- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> @@ -15,21 +15,26 @@ maintainers:
> =20
>  properties:
>    volid:
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Match UBI volume ID
> =20
>    volname:
> -    $ref: "/schemas/types.yaml#/definitions/string"
> +    $ref: /schemas/types.yaml#/definitions/string
>      description:
>        Match UBI volume ID
> =20
> +  nvmem-layout:
> +    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> +    description:
> +      This container may reference an NVMEM layout parser.
> +
>  anyOf:
>    - required:
> -    - volid
> +      - volid
> =20
>    - required:
> -    - volname
> +      - volname

This should be squashed in patch 1.

Thanks,
Miqu=C3=A8l

