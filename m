Return-Path: <linux-kernel+bounces-909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE108147E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E4D28589B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209D2C863;
	Fri, 15 Dec 2023 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="bASdyfDL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD12D021
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c00:2fa5:0:640:c484:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTP id 9850561127;
	Fri, 15 Dec 2023 15:11:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xAkSiXC7ZCg0-EBrPXiGt;
	Fri, 15 Dec 2023 15:11:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1702642261; bh=lZeX91pSyKjX9MalpRfW5x58QbhpjjA4uel8bsqd38c=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=bASdyfDLxjkqXLdON+HHxDpFfxAXEzhcyAv3Z+h0zfaMznOphofMOWzjoKiA9Zfnb
	 SvbzcJniuSh/kiEFiW3x54JWrzvou066XphnW7NbyI3CAj0rYB/iW9WRmhdOszMhrI
	 36jRHfapqAd/YWmv0vybVncvE0IhpD71I0hgV4hU=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <4a47fe75a4df63e732d0d4bacef279cc91288d1f.camel@maquefel.me>
Subject: Re: [PATCH v6 20/40] mtd: rawnand: add support for ts72xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Nikita Shubin via B4 Relay
	 <devnull+nikita.shubin.maquefel.me@kernel.org>, 
	u.kleine-koenig@pengutronix.de
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>,  Arnd Bergmann <arnd@arndb.de>, Linus Walleij
 <linus.walleij@linaro.org>, Christophe Kerello
 <christophe.kerello@foss.st.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Johan Jonker <jbx6244@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Date: Fri, 15 Dec 2023 15:11:02 +0300
In-Reply-To: <20231215111648.196c0c46@xps-13>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	 <20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
	 <20231215111648.196c0c46@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Miquel and Uwe.

On Fri, 2023-12-15 at 11:16 +0100, Miquel Raynal wrote:
> Hi Nikita,
>=20
> devnull+nikita.shubin.maquefel.me@kernel.org=C2=A0wrote on Tue, 12 Dec
> 2023
> 11:20:37 +0300:
>=20
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Technologic Systems has it's own nand controller implementation in
> > CPLD.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> I'm fine with this version, I could collect patches 19 and 20 through
> mtd but I saw no clear answer to the cover letter, regarding who
> should
> pickup the patches. Let me know what you prefer.

This is still planned going via arm-soc branch, as these patches are
pretty useless without ep93xx totally converted to device tree.

>=20
> Thanks,
> Miqu=C3=A8l


