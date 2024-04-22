Return-Path: <linux-kernel+bounces-153454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD908ACE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E535B1F220FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5452814F9E3;
	Mon, 22 Apr 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wpb4UBjr"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166714F9D9;
	Mon, 22 Apr 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792745; cv=none; b=OS2HH8zl58kltUI2I+DQBWCjujcIYE3Mnx+sruvZCMg0/w3OXUfOOwHDGJclhWJl4FFl7s1cMhQu1goBdLyCyLlgr3+ChucD708e2SDDY05KbdQCWhKcSUVte7Ayk9Di3bbKq4jT0XqaNqz880E2m6Rhy0ELmyKnSaBrubCkfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792745; c=relaxed/simple;
	bh=MKR5Lo9BnmJ3qVhI4ZQde4lFiXD+bqDR2A0VRwJiKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihujcbHE2vDrCe1APNFvIMHU4Ktkb67kdGvlenoN7jNuonWy4iTzTNBT/z861qqrkjIxBk5avp1u9I2akgIwy9D/HsHCaUCrCS8rrguDACUmbmznp1FmgtK7uePdYmtxwY49Q9W90V/KZYZckjwQ60F0U9rCBCGN/R1jR0itbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wpb4UBjr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D565FE000B;
	Mon, 22 Apr 2024 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713792741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKR5Lo9BnmJ3qVhI4ZQde4lFiXD+bqDR2A0VRwJiKeo=;
	b=Wpb4UBjrTKNJP8VZ7yd6ASEDgyWx5+P3FLLgGD8Typl2Wl0brxY/asvOtbQVS858t0vSXE
	qlPvI0E3DMg2VZJkBBi2XQHMy5qVPqW3JsDVXJ2N9i4i65YYbIOdR5eGyedgLiCNfOlLqa
	tNtO41Cei5WT4Z83Dmbw62MS4yw8HW0Ya0MblWxoBUvZh0Gmb/31ciRigiQpEyIVbdsvx+
	NAa67yMYuHSyiJSVZ7n3PCYr0pRtFXVeFixHgu5JsP6Wu0cXYh9CJr9j0rQ0f+145Yzk8I
	hCucljSsVe+7YzH3oYJaz/dFtRqyaKKNgbvI5DN1s9U34X3OLe8sr3IOGmlHxw==
Date: Mon, 22 Apr 2024 15:32:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next 3/3] net: pse-pd: Kconfig: Add missing
 Regulator API dependency
Message-ID: <20240422153220.1697f2d1@kmaincent-XPS-13-7390>
In-Reply-To: <6a88f4f0-940c-4e63-8520-5ab23e96c480@lunn.ch>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
	<20240422-fix_poe-v1-3-811c8c0b9da7@bootlin.com>
	<6a88f4f0-940c-4e63-8520-5ab23e96c480@lunn.ch>
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

On Mon, 22 Apr 2024 15:17:27 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Apr 22, 2024 at 02:50:50PM +0200, Kory Maincent (Dent Project) wr=
ote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > The PSE (Power Sourcing Equipment) API now relies on the Regulator API.
> > However, the Regulator dependency was missing from Kconfig. This patch
> > adds the necessary dependency, resolving the issue of the missing
> > dependency and ensuring proper functionality of the PSE API.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202404201020.mqX2IOu7-lkp@intel.c=
om/
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202404200036.D8ap1Mf5-lkp@intel.c=
om/
> > Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE
> > framework") Signed-off-by: Kory Maincent (Dent Project)
> > <kory.maincent@bootlin.com> =20
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Oh you already put your reviewed-by on the whole series!
So efficient!! Thank you!
I can send the v2 then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

