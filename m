Return-Path: <linux-kernel+bounces-156514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13D8B03A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDD4B2782D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95641586D2;
	Wed, 24 Apr 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l+QuAGlE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08322157468;
	Wed, 24 Apr 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945562; cv=none; b=ZKdXscUahLIjUmBaBMoQ4sUNlhEFe28kJozCVsgigB4fz8CEPPpR7u1UUglHu+Wl8r//ZrlO5xiYvfod/BHimEE3fwqhXOhJThiQNInx/EozU/sCccfN7PE38HahW0NdzGPYy+eYkVsFgaaucuNN/HzMwP/b+Jzh+6G445XMUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945562; c=relaxed/simple;
	bh=HsIJdWWpSQKAlczShDDiGD7bOAvC75m1tGVYAIxvngE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnA0igitIzjsGx5CVHv2rPo2ev6zlomwdKU8fsXV+elSwZ7Fxrg+8iz/JwJ8IeFDWd68GVhiZthYbimKKtacEA9RdoxWE8frcsmLuDoq/BrmquBvD9QBsYOMf7bqWgd+ci54JjRmEx/VxgnzcW2U1Lx6DGcetKBBhmcdaudO72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l+QuAGlE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 527072000D;
	Wed, 24 Apr 2024 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713945556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsIJdWWpSQKAlczShDDiGD7bOAvC75m1tGVYAIxvngE=;
	b=l+QuAGlE5COpRrBRPKXK3Hy+kNWMl0m84IPbLpuuVIV+S0xVjYIztXGdGRt1yHMeuQhPGv
	wLnaPkUeaScO0bN/A7tzWq7UfOSuOwYcfUGX+9TUrOH5J/y4n/qB8V0YNiK0Di2UHbWSdc
	8auzm5abl5EexOrzkBi3zEXO9r9fZLLCwpsu5xL+RAKD5SmCVwZ8+EmJVK8cv5Mx/yCfDo
	h7kQnKdJ1W250bV5vUAW9WocbFGb8tcWq1KeeKt3/RGVpssfHaKoB2PYkIRhL5Fbl826Er
	qTwJ4cW/8PvpE0xzkk1QX3VkZB1JraJ7OROQWB3NzjWVJIGOgm/ThW71ij3Hkw==
Date: Wed, 24 Apr 2024 09:59:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 02/17] of: property: Add fw_devlink support
 for pse parent
Message-ID: <20240424095912.15f5ec44@kmaincent-XPS-13-7390>
In-Reply-To: <CAGETcx-fZ4uuYsgpWcPFsuNKAkBarwC19_Ld=WX5EhYJ3Lovig@mail.gmail.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-2-e4bf1e860da5@bootlin.com>
	<CAGETcx-fZ4uuYsgpWcPFsuNKAkBarwC19_Ld=WX5EhYJ3Lovig@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 23 Apr 2024 22:48:12 -0700
Saravana Kannan <saravanak@google.com> wrote:

> On Sun, Apr 14, 2024 at 7:21=E2=80=AFAM Kory Maincent <kory.maincent@boot=
lin.com>
> wrote:
> >
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >
> > This allows fw_devlink to create device links between consumers of
> > a PSE and the supplier of the PSE.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> As the fw_devlink, I'd have preferred to be CC'ed on this patch before
> it got pulled in. Especially since Andrew thought this might get
> fw_devlink in a knot.

Oh indeed you are not on the CC list!
I might have forgotten to run the b4 command to update the CC list after ha=
ving
added this patch. Sorry for that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

