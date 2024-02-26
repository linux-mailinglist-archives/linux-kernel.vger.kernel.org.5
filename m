Return-Path: <linux-kernel+bounces-82303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A12E868220
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C51C22981
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1172130E58;
	Mon, 26 Feb 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cUFSVx66"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEB12C7F6;
	Mon, 26 Feb 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980810; cv=none; b=VZovVbne7JV2cIatGeLlBOGOGw2ECVkGJ7+35RvhG0XkfiQBa7ChF8LmTZ7QM8cQG9aCCgEy41cF2kY4E1fuFc2i6/7W2gcsaXR8QjScUQdoOnOaa23gpnyX02UGgSA1Td+TXNMxnCD7naLFKrOhZfvLcDYuSOAHsZjlQpiLj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980810; c=relaxed/simple;
	bh=0uuyXwtXBhT4lKZPab76TWhVhwVGMx+Z82IxNhoFkJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WVlzEa8Igj/kfXClyU0Gbdh0vRgMyeHZXkHwh8sfbcKu6/dI4g036Vu0JmuRAfmJe0o0VO+tajJsPIx+gf7WgLB3m93MSBZ5U3YUwLFaf9sbFZChbSL9cRIADRjbNIzVEux4UCFqsWqtI/xL7Gz9WOBvBiOW1pE3QLg76e4WF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cUFSVx66; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708980804;
	bh=VXJnkZmX0FPhcwZxkySoznvdUiSDnw5EemMrFJowppg=;
	h=Date:From:To:Cc:Subject:From;
	b=cUFSVx669T0DvPz8Ywpe/lCahs7JYL2jrmUbp47Ls7XGCoTfiWQCL0Z53ZHStZt4F
	 cz5a2xnUJ05ORoBzPxYNG+yvMzhx6OGIkwExbSKN1w44jdTIdrZwVmjKGj0gJYIapr
	 zqRcoWJlxIznkDmmKzcdGMOUvHDJeSI/e+6nw7vRY5dkbJHLyAYJVM/XU3IgoTicuW
	 bI+S3J21grbERWfUF6wouP7m3Tz4Hbo4RiJDSaXeRDnNb+UURvswvpDVx7sNw+9syt
	 dG8+0gQ8JqBmya8e1MrrMMzX9W/R+5Dg6tZ4j3+8Yr7VWzDwFqr3KGtr/ugZu1PQG8
	 6V+JDSIg1/ajg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkCWR6y3Lz4wc6;
	Tue, 27 Feb 2024 07:53:23 +1100 (AEDT)
Date: Tue, 27 Feb 2024 07:53:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the loongarch tree
Message-ID: <20240227075322.15f084b7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/92sZMzJ0992hmEkcQyEN7dW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/92sZMzJ0992hmEkcQyEN7dW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  58aeb61a338e ("LoongArch: Add ORC stack unwinder support")
  a6bbf4a71828 ("objtool: Check local label in read_unwind_hints()")
  81168bc899dd ("objtool: Check local label in add_dead_ends()")
  545dcd435e0a ("objtool/LoongArch: Enable orc to be built")
  da7492437f53 ("objtool/x86: Separate arch-specific and generic parts")
  f7af74356cf9 ("objtool/LoongArch: Implement instruction decoder")
  b68e6ed546d0 ("objtool/LoongArch: Enable objtool to be built")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/92sZMzJ0992hmEkcQyEN7dW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXc+kIACgkQAVBC80lX
0Gw0Mwf+NVwXGRXdkxd+z8xmlMkZH1Im7E0A9LOD1m458YbodhqQ6DXKTQWHe7lv
AS/voOt2B+0mdjn0m8bTgAubDYPzYIgC35SJWLCPksXeCI7gEs+fDsAmZA/Ltz+V
06VbNzE8ISS6dmj2KN6NmBq0GaxNOCcJyaOsjgKfkuCSt4FSn3yDORikp2e8rj2d
l13lBEv9QYRvjpQiN5wMpGcQ7/aUCSYomddBAvpHu7ND7LxoJrb2MANOGbC3bOK5
zUy7QU9h4ZDuh1zpPfMP7uMiFoNi4YacznesbCVwa7ugKWTq4hh9XWcdsjrfRBaa
WcMg6zyhhCXD2BhCUSAqApEbZkuQ6w==
=Z0vk
-----END PGP SIGNATURE-----

--Sig_/92sZMzJ0992hmEkcQyEN7dW--

