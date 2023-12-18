Return-Path: <linux-kernel+bounces-3803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E439817206
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3831F26348
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B6498BE;
	Mon, 18 Dec 2023 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DOKiAw5d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE5498A4;
	Mon, 18 Dec 2023 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FE7B1BF209;
	Mon, 18 Dec 2023 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702908145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9hdpzX59dlQ8BbL4qFPt1i7iHlvmq58cF5p1A5NsrM=;
	b=DOKiAw5d7xeVSCsPETCVl3JSgk/hiu/3PuGa55ZqK+Mqil78nGr4xHia+JwjeUxMDrbhI5
	y3hnlnv+LZXEoRaVYDv8sTz36fwuCXuO+W8MN/u5l6DqOgluyW4NTGfhoQCJUsxmH3IMN8
	af0EqVjAzehFN+CFmBFMb4pNtYYYwpPvIiBo9sEHnUuNgNDItJvuo4jnMYAqie66OBAU19
	r7p/HUxwXAbjhyptKwWJyvnCiyMs57PaiBJ9BMU2gk6L047ISKzcrAS+scHnctBctydjaJ
	PMhepo1FjXI51w3WVgEnUE5Wmp8FWRklZzUDSMAn2vCPSb0+Wt9P72ymNQ2NeQ==
Date: Mon, 18 Dec 2023 15:02:23 +0100
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
Subject: Re: [PATCH 3/4] nvmem: u-boot-env: use more nvmem subsystem helpers
Message-ID: <20231218150223.000aacf0@xps-13>
In-Reply-To: <20231218133722.16150-3-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
	<20231218133722.16150-3-zajec5@gmail.com>
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

zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:21 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
>    mtd dependent
> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

