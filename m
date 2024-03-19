Return-Path: <linux-kernel+bounces-107331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F48487FB25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0B7B218A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F17E0F2;
	Tue, 19 Mar 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LyzUosUW"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0737D091;
	Tue, 19 Mar 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841998; cv=none; b=P6WzyhgVqDcDgpGSnxbFKwWLBLkXZYr6Di5ZaIx2T9ySBvo2P7kSSc03pbqNp35ZtRBJuMWnODzsmMIFAhpqS9T6k+DAbGm4F0Xw8RnVcbM5L8TFK1UTt4CtIzgOxuubqJt/XjHT55vi9HUcE3ZTMSw6XNFZJ7N8D4yRb/y0KWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841998; c=relaxed/simple;
	bh=+EBDDiNG/eNmY+ueIncptOoRVdMb4em3Z5Wr8wvDjWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eT599ovg/h5gksf2peHpljZwiDViu2tXiZysqg9Bue1Vclz+uCcWAd1DfKeeJQAVCPWrNav/K6tB85rJ13rxWMY6jxeenEC4zNWQoMwg2f3yH0Xpkc8wmzkY9rJd52x1G7/bRE5sRxBeNrIgrPh82HTH+zD/Uyav2iY2GhR5atI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LyzUosUW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3CB1FF80D;
	Tue, 19 Mar 2024 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710841993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EBDDiNG/eNmY+ueIncptOoRVdMb4em3Z5Wr8wvDjWc=;
	b=LyzUosUWbZmhrAA4qvwA0ojyg9rDBL6yH+R73/Cl/AGOQYhPpeDYpbVg1jJWu+O1/a6MiY
	GBtEWVlXLRdBYAfeMbmpOHGLpgAKW+VDmM+X3OTurys03prNWASCLdD7QloxLQT5lWKEcK
	Jwor7i4jxb3XKQjqvKriBWQQpRtMnJVJicefmt3ecDm2AlHMHsSaMVfI95oAdTr03N/yRg
	+qp5UgKZGXIpdlewjym3wvEOhprR6T9pCv9wPgYXSxkC5i1o17+vt8Cbj0CF15sCTGTSpK
	SRTtIkMjzAFEMh75v0eGJSLFpvSufCkkMYqFgr3oJdm08AfYkBdvYQMPZiXCvw==
Date: Tue, 19 Mar 2024 10:53:09 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Manojkiran Eda <manojkiran.eda@gmail.com>,
 patrick.rudolph@9elements.com, chiawei_wang@aspeedtech.com,
 ryan_chen@aspeedtech.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, richard@nod.at,
 vigneshr@ti.com, jk@codeconstruct.com.au, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/4] mtd: Replace module_init with subsys_initcall
Message-ID: <20240319105309.7cdfe106@xps-13>
In-Reply-To: <4e3fbff7-6edc-4196-bc72-1095f14d0dfa@linaro.org>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
	<20240319093405.39833-3-manojkiran.eda@gmail.com>
	<4e3fbff7-6edc-4196-bc72-1095f14d0dfa@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

krzysztof.kozlowski@linaro.org wrote on Tue, 19 Mar 2024 10:51:00 +0100:

> On 19/03/2024 10:34, Manojkiran Eda wrote:
> > While engaged in development on the espi kernel device driver[1],
> > I noticed that the espi flash driver, utilizing the mtd subsystem,
> > appears to initialize before the mtdcore subsystem registers the =20
>=20
> NAK
>=20
> You incorrectly ordered your call, so now to fix this you incorrectly
> re-order rest of kernel. No. Fix your code to handle modules, probe
> deferrals and device links.

Agreed. You shall not need this. Maybe just moving the driver to the
right location (spi) might fix it.

Thanks,
Miqu=C3=A8l

