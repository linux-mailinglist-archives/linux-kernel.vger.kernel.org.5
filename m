Return-Path: <linux-kernel+bounces-137018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552B89DB2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014EF289C25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171512FB0D;
	Tue,  9 Apr 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Iy4NTzVF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6112F39A;
	Tue,  9 Apr 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670232; cv=none; b=GiiNmgGvcrhGEFua5Impk+4NViFnxkD9JkqKaHHsxmf+9uWT41CXdg9yOr9vC27oyQFjLGc8CxqGgAnX0578A+SadefZdLj9KUAiu4AnB1+yq2ArrPOiag9MRp4E5sw51cM5pz1dJ/bgQz+zGPQ27TT1Yh38ID4zSGNxlVITlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670232; c=relaxed/simple;
	bh=y/xaSl/jhXl08yoalUQ5vH76MCEpZVtsR/1x4w43g8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6C78SBbRtpG7KbDxKkgD8DzeyqBFfgqlTVvCwWmRACM+WabTR6+024ZCVtvceOVSEOxGbURpvl8p4XaYmtpaXIcPTAumig3dXcUMi3RtMjjw6KwGhxur/CXLSstNNjZG5Chw5p52SqvzcVj3ebpNrXukEMgWyqk2Qve76nByUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Iy4NTzVF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3041F240008;
	Tue,  9 Apr 2024 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712670228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5UDulmenCwJXHuGMpELuxhDA4GFyujVsdxEaX2Dr8g=;
	b=Iy4NTzVFWYIISKvZb3P1zAUEKQXE6VFTgx/iZnMms4cEObuZ97PE1okjL+Zx6GUOhH358F
	2TUZr25TtQN/aJaJVeGL0chkGZ/cllV0WOROlZwrnz63KbJg+ZWwW1XRb/T5jK5+dLIdsD
	O6x426KxtkdX3k+CnUx7Fzlrl714fiPVBxr5l5EutPwJJSKtFdwl3I+E/IUjaelg4j9R9B
	v4tvJls4ZOgiyxBiOvO7UHwoBygwhpUxWCetIkKY0XowlW2uLs5g0zh17FV5u96wtMk1nh
	hPIClv4uh+Ulc8a1PD8GzVB7Svcg0wZuAFHM0GL3R6rVBVu0As4CvUsd53TT4Q==
Date: Tue, 9 Apr 2024 15:43:45 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 14/17] dt-bindings: net: pse-pd: Add
 bindings for PD692x0 PSE controller
Message-ID: <20240409154345.7a2a73a5@kmaincent-XPS-13-7390>
In-Reply-To: <20240402132834.GB3744978-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-14-c1011b6ea1cb@bootlin.com>
	<20240402132834.GB3744978-robh@kernel.org>
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

On Tue, 2 Apr 2024 08:28:34 -0500
Rob Herring <robh@kernel.org> wrote:

> > +    patternProperties:
> > +      "^manager@0[0-9]|1[0-2]$": =20
>=20
> Unit-addresses are typically in hex.
>=20
> Is 'manager' something specific to this device or should be common?

Specific to this device.
=20
> > +        $ref: /schemas/graph.yaml#/properties/ports =20
>=20
> This is not using the graph binding. Furthermore, I don't want to see=20
> new cases of 'port' node names which are not graph nodes. We have it=20
> already with ethernet switches, but 'ethernet-port' is preferred over=20
> 'port'.

Ok I will remove the ref then.
=20
> Why is this one 'managers' and the other device binding 'channels'?

Here each manager can have up to 8 ports.
The ports in tps23881 are called channels in the datasheet but I can use the
port naming for both if you prefer.

> > +        description:
> > +          PD69208T4/PD69204T4/PD69208M PSE manager exposing 4 or 8 phy=
sical
> > +          ports.
> > +
> > +        properties:
> > +          reg:
> > +            description:
> > +              Incremental index of the PSE manager starting from 0, ra=
nging
> > +              from lowest to highest chip select, up to 12.
> > +            maxItems: 1
> > +
> > +        patternProperties:
> > +          '^port@[0-7]$':
> > +            type: object
> > +            required:
> > +              - reg =20
>=20
> Any property you want is allowed in this node. You are missing=20
> 'additionalProperties'.

Indeed.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

