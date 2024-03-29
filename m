Return-Path: <linux-kernel+bounces-125107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B54892037
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F913283CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C985C65;
	Fri, 29 Mar 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LsNdJ1Lt"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F791C0DF0;
	Fri, 29 Mar 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724694; cv=none; b=IlZH3657twegKr73ekRtNroEIRjp/1k7GwLGw9jDr3HWg0c3fzZPi0Hk8HVAO9npYi+gM1oqkar4Jqncwk04Lo9yxTPWdLnyivvUv7sOblI1dfaM2r+sRPGRvigYC9Wr4928LedyudjEvB/zg7Mc1CK1BW/Y+XmLNBcZmljXk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724694; c=relaxed/simple;
	bh=QPr73epDnfNI9hRAKDsQGY9i3JJUvUIidZoLlIKWyZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtu/NgmqF5wDafDcNp5CmDOBcNoQ4+VzsxcGLz9eYF/Kk9EWoiTVaioN44VxcRfWBuJxCaBZniy6IjxMt5c0RgFdWLTvgqaCVQn/xZ5tMCA25u0wvmVROgetk78RoLty5IOhB/CxRNeRuuJ/mjxVdR1zW1PoTOc1fYojQBTbOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LsNdJ1Lt; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FD9560007;
	Fri, 29 Mar 2024 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711724684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPr73epDnfNI9hRAKDsQGY9i3JJUvUIidZoLlIKWyZk=;
	b=LsNdJ1Lt0oJ9z0mqz6TlbRI8l1mbDgKIJ5zzl1ossv03wcL9woRWFh0Gs6Y9IS6u8yP+Px
	feUGQi6RcodKm4JuX4SmPB6VcliyuE8qbxiqqaIHt3T59gAu2qHrmZ8rsGWDECrKXCecX4
	VDS/Cs+qOCwzdBYXDm4frT8frQL1XzXx3xsMYhvop37l58/1Ler289gm9xR+nPBn+ZPAhY
	I08bFEm98VVZuCNWibrS/bcgr+Y+tzdLCAz6IJQG6ok0viZfUfY60mGt1R+8jjseSb432x
	E/FLe3PPXfkaBmFlgNtS+QIckH/IyKpmto5Y6MPAUPKBXNLYMlmzdSNGZHPgXw==
Date: Fri, 29 Mar 2024 16:04:42 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240329160442.0333a117@kmaincent-XPS-13-7390>
In-Reply-To: <20240326-feature_poe-v6-13-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-13-c1011b6ea1cb@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 26 Mar 2024 15:04:50 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Integrate the regulator framework to the PSE framework for enhanced
> access to features such as voltage, power measurement, and limits, which
> are akin to regulators. Additionally, PSE features like port priorities
> could potentially enhance the regulator framework. Note that this
> integration introduces some implementation complexity, including wrapper
> callbacks, but the potential benefits make it worthwhile.
>=20
> Regulator are using enable counter with specific behavior.
> Two calls to regulator_disable will trigger kernel warnings.
> If the counter exceeds one, regulator_disable call won't disable the
> PSE PI. These behavior isn't suitable for PSE control.
> Added a boolean 'enabled' state to prevent multiple calls to
> regulator_enable/disable. These calls will only be called from PSE
> framework as it won't have any regulator children, therefore no mutex are
> needed to safeguards this boolean.
>=20
> regulator_get needs the consumer device pointer. Use PSE as regulator
> provider and consumer device until we have RJ45 ports represented in
> the Kernel.

Oleksij, could you verify this patch does not break pse_regulator driver?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

