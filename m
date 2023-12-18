Return-Path: <linux-kernel+bounces-3804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D9817218
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE42B23807
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF48498A5;
	Mon, 18 Dec 2023 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KStf55k3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD94FF62;
	Mon, 18 Dec 2023 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26EE2FF805;
	Mon, 18 Dec 2023 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702908194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOdu4nC8A547RSrmQaxjTwDGTHM+CV5BhhKgD0gmeTo=;
	b=KStf55k35pwB3Kf+9oYro7aVUbzOX88GtQSkvx2+3d9QuT5CPmNp8cPZb1hhaQXobbp/PW
	NbpyQvc9Nkj1P4yR2b4Trd3QGZIp2QMThiPUbyTC2uelXRCPGxvdwSxiRJxg9W2n2BqA3e
	D3hP3YUq4441ekhB49ki7NFpLhseKqfgvY7CCEqtK0GPcWnq1mmReLN2l0P+m8n3rpC9u/
	rO7Imna95yvuffMOoXMNVYBqTT8QBhWT5xIyQhPrWBYl004cL/IJXfpz/UzrIsjT1ynOx4
	6Wq8r6ad9OmdumDTjyYSeJ1ksOfy/SllnGI2Fp4RZb6ab2+/Yp7YJcbO4ZCpvw==
Date: Mon, 18 Dec 2023 15:03:12 +0100
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
Subject: Re: [PATCH 2/4] nvmem: core: add nvmem_dev_size() helper
Message-ID: <20231218150312.01bc1472@xps-13>
In-Reply-To: <20231218133722.16150-2-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
	<20231218133722.16150-2-zajec5@gmail.com>
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

zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:20 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This is required by layouts that need to read whole NVMEM content. It's
> especially useful for NVMEM devices without hardcoded layout (like
> U-Boot environment data block).

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Thanks,
Miqu=C3=A8l

