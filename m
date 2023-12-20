Return-Path: <linux-kernel+bounces-6461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB205819950
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2565C1C253C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35015484;
	Wed, 20 Dec 2023 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hiMCouBw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DB14A8E;
	Wed, 20 Dec 2023 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB40D240003;
	Wed, 20 Dec 2023 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703056767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6fzl6vcO4Hv/XujG9Dw3Folx8t279iaf7fTJn0KvN8=;
	b=hiMCouBwpjTDotM2nWPy4MfCqL59dT0H4ebnMP4Wh99CZIvg5xa8mCUGrn/d5LI6eRQAIX
	ir/6d8YLTlLQAFv2T6USU0WnkFWRkEDY7oE/2dpeXvueyhjIEsdJcPXYojokq4jnNvcu/B
	GE0jb4PceNrrxwakYSszdrR/RvF0kV6Qg7FqnEj3M3IHlafqoOBioPjMw5a146+AN5AWHS
	cKz7pFHemYRdjEWo7+fq3vBWL1ix+wLsy6PoNf422Md0FbUyzavzb3+/DL6js4YHt866XY
	6L/s3Ts5bSFWE7/Dpt4voAPef9a7pFYa3nnsnyJrxoBhGkS1A2j04qHBg2DyAA==
Date: Wed, 20 Dec 2023 08:19:24 +0100
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
Subject: Re: [PATCH V2 4/5] nvmem: u-boot-env: improve coding style
Message-ID: <20231220081924.39b96ec4@xps-13>
In-Reply-To: <20231219174025.15228-4-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
	<20231219174025.15228-4-zajec5@gmail.com>
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

zajec5@gmail.com wrote on Tue, 19 Dec 2023 18:40:24 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> 1. Prefer kzalloc() over kcalloc()
>    See memory-allocation.rst which says: "to be on the safe side it's
>    best to use routines that set memory to zero, like kzalloc()"
> 2. Drop dev_err() for u_boot_env_add_cells() fail
>    It can fail only on -ENOMEM. We don't want to print error then.
> 3. Add extra "crc32_addr" variable
>    It makes code reading header's crc32 easier to understand / review.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Looks much nicer :)

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

