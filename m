Return-Path: <linux-kernel+bounces-52046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B884934F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A164728109B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC1B671;
	Mon,  5 Feb 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bWoE8uPh"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748FB653;
	Mon,  5 Feb 2024 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110625; cv=none; b=Q8vhXnSBPPfvZlFlSAo2/5iuxF++pzVd0hRh1YOABvpEg1m/sHeM4yh8uZkk4GKO+xliKKjud3jqkDzr/33j1BNoxVUwxkRlfDbIM040FLIB51FEA37oLnJCEQ7JogK8y8E9X6AYioP43daIPBMGQJw/5YLVGl39IpazpMRrtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110625; c=relaxed/simple;
	bh=Gd7JS6Gku20E0wCgCAayC1ONDP+psOELw5nrfogvBOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nXF6DAxiBFTHAd4ON1DT1hW67zQfHao4o1Wpr8+/TmYKkrlF1F+O77yxBV0PWlgo4lDJTfua7Fc4CH4N58zULC4yVWNWHPf3kjTpJT0UvAuik+hY6S4OG/vR0bWBO9HZK5L/ePTyPmnG9u0+XsKydPeS1eH6KiP05UPBCAKSaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bWoE8uPh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707110621;
	bh=z6fVA6uhxt5+QO8Xz8eJuSoaG8ddxccEMPFEXgAeZeA=;
	h=Date:From:To:Cc:Subject:From;
	b=bWoE8uPhqkkr0a3IhoQpoci+AmC4SCjr+dpk+VMo2j5JtiIlUMQR8QG7n44AD2tmp
	 hCsN88lLchQ4D7SbpBmxzA3qSxJy91g2MH+b1Ma+/RJMtRZz/c926h1EQc2rhupaVH
	 QUWareQHO4HlQlZQUr8U8vM1eVoi9WuEvTeMsxs7Ricz8fkQikb3xGM5t2g2OIJo/C
	 wDI2awMMTIf/ajBBWMlI7B7mYqC0FJ5QuUnnuc6h8Xltfeb7CnQhf/B4mC2CPTJj/S
	 JC8qUrl+z63GK75tuOG8u/96YmddblEyx6kQizKiuRdjTHUeFjfSNNWiaQNRLvO82z
	 yzpu96Ae8dvDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvtP0TZBz4wp3;
	Mon,  5 Feb 2024 16:23:41 +1100 (AEDT)
Date: Mon, 5 Feb 2024 16:23:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20240205162340.14e08463@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W5FT71okcsg2XecIVDSm9Jx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W5FT71okcsg2XecIVDSm9Jx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  41ef33da2c49 ("iov_iter: Avoid wrap-around instrumentation in copy_compat=
_iovec_from_user()")

This is commit

  40bd16cd9ec8 ("iov_iter: avoid wrap-around instrumentation in copy_compat=
_iovec_from_user()")

in the mm-nonmm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/W5FT71okcsg2XecIVDSm9Jx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAcNwACgkQAVBC80lX
0GyAIAgAnclY979qS3ZLXioDOdfzoiqTY56p420NyVEybUwBOXczveFQtVu8KAg7
tjOJNoT7y1xpFVlP8LewMIXUYrkukJY4kvyX0h4/PLx2jetDx1BxTRzZKKZNO/oE
9g2vdtcai2uJPEskVQEf/6FcSEp+47mwvU4HjEJMmodf70diwCXwuWOQpUhMbSZ7
3YrUdY05ht1kuUGrtZy1Q/rwJ7tdRQ053wJr+AQPOmcgbbYTdnc2rFbxNOIj+1fO
fkF5Rmq4xo6q0FpTgIsg81lpF8Ep5sn0cb03D2I4BBDIRGeKjCwMz4TSArFw5Hy0
IztS2qpQDtQro8w1OFC2Icbff05T6Q==
=9/L+
-----END PGP SIGNATURE-----

--Sig_/W5FT71okcsg2XecIVDSm9Jx--

