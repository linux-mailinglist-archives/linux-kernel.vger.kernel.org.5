Return-Path: <linux-kernel+bounces-81155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1086725E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B035B282A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86694D9EA;
	Mon, 26 Feb 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eaGvoC/r"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51F4D9E1;
	Mon, 26 Feb 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943045; cv=none; b=dt3jAVRb5gn9Gh/+jiH8l1yEQpKMNhdx6n2PRTHOqiOB1zCUaSwXRXW0fZj3ZtR4w6l0EwJbqMIe41A2SNEUmgqYyrpSMwv8EGKfvDRhgMgP60gO1XHCQStmK9qXUUciJK1g8Jj7mXK46v38+Ufut0AvzUp7Mh8heHSBSNPxZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943045; c=relaxed/simple;
	bh=bv9zQCDIFjU9iZ/siR5BjYkMJRSOD9B3H7xbDz0eK7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCaCjNG31oKEWtPDamMdYb3jC8pMFduJbV7m5pBjGdoYi+SKpeQ8+l7xzvL3IoPbTQK/d+KjaPJuSdgKBhPKi990xwDyxEzIIl3yPnEFyatwQdByhl/NEvXIOQshcNq2zx6G8qt8rUY+9/g3PEftDG6py71y5RyRLKocA29tFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eaGvoC/r; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90B14FF817;
	Mon, 26 Feb 2024 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708943041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bv9zQCDIFjU9iZ/siR5BjYkMJRSOD9B3H7xbDz0eK7I=;
	b=eaGvoC/rz3Snz5oDpSrZH3zPnKeH/TqGVVnv/kS72xHt0rgy7dLVEQkjsr5+SOjfPK/+vE
	j5jUp0myNjKS+8CuAD7WseUeyrk44n8Q9SVSr/4OU8TAChvkQ9w3csAw2KZCbowP+z9soB
	0ca+aCuNlk57C1/TKawJM6qtNvSqEmPX33uAqfHuRqd6aNHEwo/q9LO2RVvEnpDpND0zbf
	BI6uFD0ITbv73r79b20mm2bkz3+0jmscIbMn4zTfSaXt5x9IEALEYO8QfaSudKkP6E9Wnh
	+1ppkzGKA8p5XBs9qILDHv94TsUqG8b7aza2FmYpoDtcD38q9av4wPtTN59D+A==
Date: Mon, 26 Feb 2024 11:23:59 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Cc: <sam@ravnborg.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Randy
 Dunlap <rdunlap@infradead.org>, linux-parport@lists.infradead.org, "David
 S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mtd: maps: sun_uflash: Declare uflash_devinit
 static
Message-ID: <20240226112359.3c3cf74d@xps-13>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-3-1f186603c5c4@ravnborg.org>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
	<20240224-sam-fix-sparc32-all-builds-v2-3-1f186603c5c4@ravnborg.org>
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

Hi Sam,

devnull+sam.ravnborg.org@kernel.org wrote on Sat, 24 Feb 2024 18:42:24
+0100:

> From: Sam Ravnborg <sam@ravnborg.org>
>=20
> This fixes the following warning:
> sun_uflash.c:50:5: error: no previous prototype for 'uflash_devinit'
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes glob=
ally")
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>

I was about to take this but linux-mtd is not Cced, so I'm letting this
to the Sparc maintainers. Please resend to the mtd list if I need to
take it.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

