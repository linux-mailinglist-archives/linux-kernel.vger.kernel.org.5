Return-Path: <linux-kernel+bounces-919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608381480F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35FF285E42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27212D033;
	Fri, 15 Dec 2023 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G4Zx3Zi9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360AF2D02B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 95643C2965
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:27:14 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3A1FFF813;
	Fri, 15 Dec 2023 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702643227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IZYbaAaZtghBRBPHJKTFh+2UDzsyuLF2d2HRcrhVq0=;
	b=G4Zx3Zi9MtdsgR/304rHUaSdcB+XDN/Gt6C/mMuZD5JZHzYh4ACnzr0HihJUfiiI7ZKpcj
	Tfln8V4Z2Xg25dzAR1N1iopjQpVpLobNmGvxIryh7COGptEyxN2J+hBJtZkxYWhCSvSyVu
	T7tVX2IYI9NiAqgstZc0GF4FE5L/LH/KW1MDZFf4rpmfX1CwR17haufvmAk3Zu5Anpf8WV
	EGBvvZx+7gBcitykuDKMv9JpoLyhhkwj0cRTekSjt4Tnkg+tnJjyglFHhIEmXizP7XPUrb
	7EBz9BCsfYy5ieQiJdY2nK52m6Kw5IcFkWYbvNTJYAzcpUECfqTUQxlk5oGA9A==
Date: Fri, 15 Dec 2023 13:27:00 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Nikita Shubin via B4 Relay 
 <devnull+nikita.shubin.maquefel.me@kernel.org>,
 u.kleine-koenig@pengutronix.de, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linus
 Walleij <linus.walleij@linaro.org>, Christophe Kerello
 <christophe.kerello@foss.st.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Johan Jonker <jbx6244@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH v6 20/40] mtd: rawnand: add support for ts72xx
Message-ID: <20231215132652.0be1a92d@xps-13>
In-Reply-To: <4a47fe75a4df63e732d0d4bacef279cc91288d1f.camel@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	<20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
	<20231215111648.196c0c46@xps-13>
	<4a47fe75a4df63e732d0d4bacef279cc91288d1f.camel@maquefel.me>
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

Hi Nikita,

nikita.shubin@maquefel.me wrote on Fri, 15 Dec 2023 15:11:02 +0300:

> Hello Miquel and Uwe.
>=20
> On Fri, 2023-12-15 at 11:16 +0100, Miquel Raynal wrote:
> > Hi Nikita,
> >=20
> > devnull+nikita.shubin.maquefel.me@kernel.org=C2=A0wrote on Tue, 12 Dec
> > 2023
> > 11:20:37 +0300:
> >  =20
> > > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > >=20
> > > Technologic Systems has it's own nand controller implementation in
> > > CPLD.
> > >=20
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me> =20
> >=20
> > I'm fine with this version, I could collect patches 19 and 20 through
> > mtd but I saw no clear answer to the cover letter, regarding who
> > should
> > pickup the patches. Let me know what you prefer. =20
>=20
> This is still planned going via arm-soc branch, as these patches are
> pretty useless without ep93xx totally converted to device tree.

Alright, so I will not take these patches for the next merge window.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

