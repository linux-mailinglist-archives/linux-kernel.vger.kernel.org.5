Return-Path: <linux-kernel+bounces-729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4965814541
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761D51F23F73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1CC18E14;
	Fri, 15 Dec 2023 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eQ1k0BSC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695918C3A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A00DAC5C2B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:17:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 680B860007;
	Fri, 15 Dec 2023 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702635416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LSzPU419DcHPOBSlIFjlVD+3xwo2DSPCaE+1kmur2s=;
	b=eQ1k0BSCvr+L6QmKolSWPqT6RyFMefvgGiQiCzpd1Nh0KftMkTQ+WIKBNSeKfl2ApK7oJ/
	ugRgLjLATXELcsy3HeKGaX3zshPYcQhKa5fXa5iDusts3e9AssHvQZix6F2Z2Fevkn6iC3
	gGmCmnRnEE1bIBFYfZ+zN5tqyd4ruMgoeReaugdSyVhnQNeTm6Jpf+0+oFb/MvZkHFriOu
	9AcrFbEsp/CNN6IiKn6h2/FGm29C317TCzUUU4jMBwW8Gx2Ynh98MFKJZyF8CL6++vVZ1j
	6jIGg8SSwd2z5LEGI/zs1zCt7T4LaUmZnjXdCarIckvCCicrkE2acudx/CsbDw==
Date: Fri, 15 Dec 2023 11:16:48 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc: <nikita.shubin@maquefel.me>, Richard Weinberger <richard@nod.at>,
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
Message-ID: <20231215111648.196c0c46@xps-13>
In-Reply-To: <20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	<20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
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

devnull+nikita.shubin.maquefel.me@kernel.org wrote on Tue, 12 Dec 2023
11:20:37 +0300:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Technologic Systems has it's own nand controller implementation in CPLD.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

I'm fine with this version, I could collect patches 19 and 20 through
mtd but I saw no clear answer to the cover letter, regarding who should
pickup the patches. Let me know what you prefer.

Thanks,
Miqu=C3=A8l

