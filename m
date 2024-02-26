Return-Path: <linux-kernel+bounces-81047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57348866F81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD190B246D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F854664;
	Mon, 26 Feb 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCsSThtx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA1D53E;
	Mon, 26 Feb 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939567; cv=none; b=rDmwag8WejgfG0ic5BqRhyHBtxKGauU5UPqVd4GEBksd/ElBEZrIxVoHkFwE2VCJt1tXPRT2l0B35KlGtwl8z3H1e/Nxsbbmqd8/3yukgREDSMHwOygpsLCi9afv6OPWCaOR644gpqj7hw2sWrJar6nPbuzv4LhHl5DuwSeZ5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939567; c=relaxed/simple;
	bh=rhKsZfosCmhfCCGc9/653wNP0wWHZyBXR7wGPOOIK9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hWpV4PMWpfiSud/QAbWXGifdx8l4V0S6+z49jtwXn9bIOCUsJN571gZiE4RhHOZBycSTGVrqk4UVKhXl/Tm1Jff/ZQXzSwlu9EVVemQXomKJgqw13EO3lULAVxkOaPE4DwH0BpAZnBj8JnP83yoD2Q5O5hHqcqsyf3/0CrAhyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCsSThtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD094C433F1;
	Mon, 26 Feb 2024 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708939567;
	bh=rhKsZfosCmhfCCGc9/653wNP0wWHZyBXR7wGPOOIK9E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tCsSThtxIEs0BWU27p1URISK+m4fGl9Y5sVs2O/E+a3CyrvayclzVFW4ol9HkAVza
	 TykVzfOfRP/mqsygjo95992jS5ZuTH/Rbn8hV+Ze89eaKEUDm2NLJP6v/ErCHLICYT
	 v7jYXIJHF4SSrFQFpjhhsRBiE2KZHFWUPsEc/t8JFXeD73fCzCtEqJJeWrteAyZRjL
	 nQum5fZL7XkZIIoyZM0A4qsiF9MKRlDj2T16YKaQNqVYd3e0JKggxne6nzFUIQ7TzF
	 K1HZnxPSaR0UYK49DOOBxN3XUUvcznDBw6NsxIqAv+7vFa1nAVvBXC5ltNv9qCXeMh
	 BHlzZbNM9KqfQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:26:03 +0200
Message-Id: <CZEWILFMZ5L1.2TCZXVS7GTDKZ@suppilovahvero>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240226062245.2279635-1-jarkko@kernel.org>
 <eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com>
In-Reply-To: <eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com>

On Mon Feb 26, 2024 at 8:49 AM EET, James Bottomley wrote:
> On Mon, 2024-02-26 at 08:22 +0200, Jarkko Sakkinen wrote:
> > Add TPM driver test suite URL to the MAINTAINERS files and move the
> > wiki
> > URL to more appropriate location.
> >=20
> > Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
> > Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: linux-integrity@vger.kernel.org
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > =C2=A0MAINTAINERS | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bf77be03fb2b..6380c1109b86 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11947,6 +11947,7 @@ M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mimi Zoha=
r <zohar@linux.ibm.com>
> > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-integrity@vger.kernel.org
> > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0keyrings@vger.kernel.org
> > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Supported
> > +W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://kernsec.org/wiki/index.php/inu=
x_Kernel_Integrity
>                                              ^
>                                          Missing L
>
> James

Thanks! I'll fixup that.

"linux-tpmdd-test" is the suite that I'm using to test your patch set.
It has swtpm integrated. I wonder if there was easy to way to tweak
swtpm to emulate "interposer", i.e. reset its state while it is
running (preferably not by restarting it).

BR, Jarkko

