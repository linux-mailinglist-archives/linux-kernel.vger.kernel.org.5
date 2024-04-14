Return-Path: <linux-kernel+bounces-144411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D8F8A45E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8F2811C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0DB137759;
	Sun, 14 Apr 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ic8b0c5y"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A593136E39;
	Sun, 14 Apr 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713132261; cv=none; b=VgtBCaIhsYieeyJNEl6JecPSxQkxOOEbWIZl3MCIXUYLDZ4lHvJbz7QiR4CEkBVLV8ofiISbVz3dtf98ra+CJL+bVm6qGqjtiLy3CCUoujQt8Cp4dY2e/7k7KNyXbl/u1dHMm5D7q8GIvgDibTEW2UUTY+yo/w9V81PstvOEFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713132261; c=relaxed/simple;
	bh=0tuIlz7XkkggqEQcQYHs2OTjrP8E89MPwJxhBxpe38I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gB+qNLXChPesW3TcRHRmAuqFJ959MfOw8cgZx6LiVy9jVf8crWaiox/nPganU0h3rw17QgL2p79AvrumoLYLpzomzwErQq0mS7upGmJdK11qqt69ShYi4L9vmyc5V3o98c0q/S9z1Di0g+zN0JX0tl3PIBn/2eog33a+Tf2fZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ic8b0c5y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713132248;
	bh=kanwhq59ffMP6H1mkI6fT2pOObc1neNRzYW/im94eIo=;
	h=Date:From:To:Cc:Subject:From;
	b=Ic8b0c5yT6Gc2K8skSQpELcRt69HI6Pc+bSgF2t5zxJqsWbLL/mZFmYqAiqdXMR+g
	 kzLX1DSg0S8dykEuIXX1+WX8whmFjQFj/ONR6j2LqLvs9gMnNn5g0/yec+zKfO9pvL
	 DVWfZG1U0Mgzt5xnzhf3ADtC9xV7r7VBMA4Wc0aB+HCvP4wAdf0AkWpHOml4IhyM5A
	 d1fcP5xuVnQ7X2jExdUcZxjaU0ZizqKRFVPBCoT+7T+Q6sabnZL7jR9E+w79riP4fT
	 sREj5xeQ2U1Vx8UjCjRqcEvyNUEs+FjSymJVxR+Dc/MGrc63lBq8xfkhx/sFODm9Wu
	 wxI+y4MujR0yQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHkpw649hz4wcd;
	Mon, 15 Apr 2024 08:04:08 +1000 (AEST)
Date: Mon, 15 Apr 2024 08:04:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the battery-fixes tree
Message-ID: <20240415080406.51d34d53@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SEJPpBq+yPxx4u2JZOMRGRA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/SEJPpBq+yPxx4u2JZOMRGRA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bcbdcffd94ce ("power: supply: mt6360_charger: Fix of_match for usb-otg-vb=
us regulator")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SEJPpBq+yPxx4u2JZOMRGRA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcUtYACgkQAVBC80lX
0Gyn5Af+IlONYQ7+Ryr23AD5cmpns3blLzMwDmqJ/eio3tatiOhVYL2TSwl0+B99
fgFx3tWDoxZTUhsPUHAPaV9TJCe1xKO4cFEeLhy0nWJuF6e2Huea03aAVSPGk7M1
PfXiWa/45bjLpGBk8Iox7khkpaaC2Ptl6yC1JXS/sQQYN11As/4I2slz+mYGyV9S
fV/oDWghEUvDdv9/IZpCGsmbOzcVRIiHdtdZq/Nwv8s7IXDajhczW+QalQpPXsL5
kmJ8lnIkokTTDYhc8HwhTpZeRN1CpaemQO43/RHowMYNe5GEgOuu9OGKbIFgKxQk
b133fcSFfV9X8Z0JE6M2Cxs8nJZL3g==
=edVk
-----END PGP SIGNATURE-----

--Sig_/SEJPpBq+yPxx4u2JZOMRGRA--

