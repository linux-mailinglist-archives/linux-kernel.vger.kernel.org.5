Return-Path: <linux-kernel+bounces-6484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798481997A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9961C25869
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62889168C6;
	Wed, 20 Dec 2023 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hB0lZsR6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA422306;
	Wed, 20 Dec 2023 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D75A2FF803;
	Wed, 20 Dec 2023 07:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703057258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbbso/rgR9y8n9297RvIV+sw+BGrsloKuu4p5wYQO8U=;
	b=hB0lZsR61TYKM10x74jyfOy+y5SCHQcGukvQOGQPgiuahRFZGd1suchlA+vbYiQ+Q2FpDt
	VpSB961mr4K9f0Igroc2u1n5r46fVBNrUAhFHr0KgS1AV0noZwCdHBeFPTUA9pDlo3/LY4
	Via/zwOJ3hxigJjAVaaS239v9SwiXEvOzQgqLe/umC4kZSEQn89hNUS5YoInC6b70QP2LT
	wXwHjzXMfpi7BVMS+W/ur2yTzJHEc5ysWFWn2vpgVeL7fb31ByuVwTFE7Pal8RHMcAM0Tj
	ctMslWbq5RoUnjar0AHqsMIALmMgH7rducCnhhjh7veXU2i2oHM9ngqko8rMQg==
Date: Wed, 20 Dec 2023 08:27:36 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 5/5] nvmem: layouts: add U-Boot env layout
Message-ID: <20231220082736.246e947c@xps-13>
In-Reply-To: <20231219174025.15228-5-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
	<20231219174025.15228-5-zajec5@gmail.com>
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 19 Dec 2023 18:40:25 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This patch moves all generic (NVMEM devices independent) code from NVMEM

Nit: In general we avoid starting with "This patch does..." and instead
use the imperative form, like: "Move all generic code..."

> device driver to NVMEM layout driver. Then it adds a simple NVMEM layout

					Then add...

> code on top of it.
>=20
> Thanks to proper layout it's possible to support U-Boot env data stored
> on any kind of NVMEM device.
>=20
> For backward compatibility with old DT bindings we need to keep old
> NVMEM device driver functional. To avoid code duplication a parsing
> function is exported and reused in it.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> V2: Support new compatibles & use device_get_match_data() helper
>=20
> IMPORTANT:
> This is based on top of the:
> [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback arguments

Thanks for the move. Looks good to me:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

