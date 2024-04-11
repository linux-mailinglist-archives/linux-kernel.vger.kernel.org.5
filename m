Return-Path: <linux-kernel+bounces-139805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8128A07E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D681A1F264C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6A13CA83;
	Thu, 11 Apr 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nat5vkfW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBCEADD;
	Thu, 11 Apr 2024 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814543; cv=none; b=EIaZjLHiioEAMTfc5HBmiNNQ+X7VFCPIiHjRFosJU8YZEUevp16QJnHT4/BgMTj9B2+FA3uv+OQhCT96HWARaVVUJYaAV5cqk1mPL94Rv91eKdJJUtxLLxNyB4ZaFdnHbHs3tszTZIlWzOe/fs3iQcZB3dsuVkzQeMneEiGQDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814543; c=relaxed/simple;
	bh=gsCSrX/Y8e5qo5BvPTSuqoVrJ8DIn6WYPkZctRBz9U0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jLUf+GOHPVeXZkSkaI+2iuWRUcC5D6H62Rmdk7ylOsPDHe5vCYjuAiTP75ocqtWQYRHrQkjzjJYKj10JBAQTYyoCLd/WwnP9J77myp6ujnHRWi1PFs0MS6dd5wx/swURcK/Ls37LLKkxbwmHSIgGDIXyXToeVDwMC2qcahEUH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nat5vkfW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712814539;
	bh=FG/2S59wXxALO9e7Nx6mv9/Kl+nnBCma+9NJuqb816g=;
	h=Date:From:To:Cc:Subject:From;
	b=nat5vkfWZCpGU2kEXeUzWHPM7aZAzyKJIduC7Q8/U8/wtDQzq3CcSgYPQqw9xi6TW
	 FGPMscnuyT/79I8UCSTfFQqi1k9s0qs8ZBuVu8tNXyl7tqec2yfH75t7H2CSyE1bcO
	 OsVQtoODOT9q/X9PozGe26jHcg7eWKgWb3I3Tv64q31QbA6Mkuoz4bYQ2O6tWjT67c
	 mvSvEG/BWY0MlKKOU+K2Wym2UJyzQdZgaZalmAyQBMl1fiqKFUxH8hycLzvLbWmeJ5
	 +aMM4gYmG8lc+upHHhxnnA23UtNKFpKMCYcqRseMtkt8/v1xEmVQVEsPiiMHwEjkTY
	 6ZffP2KIpIBKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFTK71TY3z4wx6;
	Thu, 11 Apr 2024 15:48:59 +1000 (AEST)
Date: Thu, 11 Apr 2024 15:48:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5?=
 =?UTF-8?B?xYRza2k=?= <kw@linux.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the devicetree tree
Message-ID: <20240411154858.522858c5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u/gERtubcGCxO8+Yf8HrNJd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/u/gERtubcGCxO8+Yf8HrNJd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the pci tree as a different commit
(but the same patch):

  680ee54f272e ("dt-bindings: PCI: rockchip,rk3399-pcie: add missing maxIte=
ms t
o ep-gpios")

This is commit

  267870fdbd01 ("dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxIte=
ms to ep-gpios")

in the pci tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/u/gERtubcGCxO8+Yf8HrNJd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXecoACgkQAVBC80lX
0GxXhQf/WSSbcw6xBggmCNUVi+A13l3x5muiOmYBJOkdXqaxt47wf2C1lNs3loRj
fNIHf0UpGanUWU8WHXTSAEeYtgv/2YaSFEwzNqeu2+MySarXkqAEp1rSrj8gR57f
OmAlZQ+P2PeQNSoZ5ijHFl2CoS8rus5wSx92YdqiSme7GxKE56iQqHDqsuVw/UbM
g1sNVGrHBfN6XyAdrns5bFR1kaFS1dzFJWagHbDetg3jlsiQ6dXurkfVc6YCZvXV
diHCHu4ob0vpH0hxDv3YYP1QOSnOQAVMXQdqIZrYdwsfU55oWVcPnw86f0A3kXmi
tVYVaUK5vvEeP3yZzLSwY5SjbIw+tg==
=G9OJ
-----END PGP SIGNATURE-----

--Sig_/u/gERtubcGCxO8+Yf8HrNJd--

