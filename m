Return-Path: <linux-kernel+bounces-163202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE3B8B6720
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09DDB2175F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC1211C;
	Tue, 30 Apr 2024 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bKnrwO8p"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D817F5;
	Tue, 30 Apr 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439076; cv=none; b=AOoctnPGOVXdSuZz1+XvyGDDD3hzknELgCziYfvqqRa7wJfM7fSqRkVL9cg1bbCco/CZQJR14MpbHD8ZeVyd6UDA809gK1EAy1uqNZe9RsArjKB+fqQ6N+buqCjTcYzG56O+8ZExmsc9cfcaHD6G8O30FQCqtUMsIYdstdacDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439076; c=relaxed/simple;
	bh=xIka4GzwqbHzymnQRdsDvesNVFW44WrLeBBhpVkSn3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lGRVGCzWV3xFtFc5Qmz5JTUKJAnsiK+mFJGV/31GOx0JchZ/DfPtIJEo+w6C0lvcWfy/1jNLCYFv/zHaUY9Qpz3pSO8l1bofaJDbFRpREEUDbsbJb1M/do3sLd7Igxsu0Gg7YPJIntrwYhfGItXvbKLdBkzePQqRYSxAoVVi5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bKnrwO8p; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714439069;
	bh=G7JNY7J45OW8/zvJc3N+xIcvrFtkJvZusWpiHZbZsAI=;
	h=Date:From:To:Cc:Subject:From;
	b=bKnrwO8pyps74QJo62T2ITg78nmAAUniIV6AV5bFJzbQGn8H39hEJh8DJ5Chv+mTm
	 KmR1SeqdkJAhrF8oKiGKHOnfi5kVBJi0QSYQLNe1BLVpLCp60WAdiULXBzaK3psDQE
	 FuXz2paM1sT/aI9ClV4PG2UPkKiqQ6hsflulSNDhKAQOWKkKXK6z9gYAus98j2uKXb
	 9VJu37T0ZGtP/bnj36vmvGwHjXPzBpwYOeFNQRu0oYk8DuaZy25i3h/pDI1PZHJlBY
	 GRG7Z+WpHg0qTpl3imLbsv3PJntcwSdHUgBRNqtdpwXEd2s4Nhz0Mm1WaeZpAOUlNR
	 hDNJeZKaZZT3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT2646T9hz4wyq;
	Tue, 30 Apr 2024 11:04:28 +1000 (AEST)
Date: Tue, 30 Apr 2024 11:04:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the stm32 tree
Message-ID: <20240430110428.30432b2f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vc9nAuzvxGBtK8ilfzaP1ly";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Vc9nAuzvxGBtK8ilfzaP1ly
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc tree as different
commits (but the same patches):

  0087ca056c73 ("arm64: dts: st: add all 8 i2c nodes on stm32mp251")
  2886ab7437de ("arm64: dts: st: add rcc support for STM32MP25")
  385ca8e3841f ("arm64: dts: st: add spi3 / spi8 properties on stm32mp257f-=
ev1"
)
  3e7d579c9fca ("ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x =
boar
ds")
  4ef09379d765 ("arm64: dts: st: add i2c2 / i2c8 properties on stm32mp257f-=
ev1"
)
  5e6b388d7bcb ("ARM: dts: stm32: move can3 node from stm32f746 to stm32f76=
9")
  7442597f90ba ("arm64: dts: st: add i2c2/i2c8 pins for stm32mp25")
  7c12d95564a2 ("ARM: dts: stm32: add LTDC pinctrl on STM32MP13x SoC family=
")
  7c3d4f99a920 ("ARM: dts: stm32: put ETZPC as an access controller for STM=
32MP
15x boards")
  808691f7389d ("media: dt-bindings: add access-controllers to STM32MP25 vi=
deo=20
codecs")
  881bccce217e ("ARM: dts: stm32: add LTDC support for STM32MP13x SoC famil=
y")
  8fe31699b83d ("bus: stm32_firewall: fix off by one in stm32_firewall_get_=
firewall()")
  9e716b41a2b5 ("arm64: dts: st: add RIFSC as an access controller for STM3=
2MP25x boards")
  a012bd75abf6 ("ARM: dts: stm32: enable display support on stm32mp135f-dk =
board")
  aee0ce48516c ("arm64: dts: st: add spi3/spi8 pins for stm32mp25")
  be62e9c0c3fc ("bus: etzpc: introduce ETZPC firewall controller driver")
  c7f2f2c0ace8 ("ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1")
  cab43766e000 ("ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x =
boards")
  d3740a9fd78c ("dt-bindings: display: simple: allow panel-common propertie=
s")
  dccdbccb7045 ("arm64: dts: st: correct masks for GIC PPI interrupts on st=
m32mp25")
  de9b447d5678 ("ARM: dts: stm32: put ETZPC as an access controller for STM=
32MP13x boards")
  ede58756bbe5 ("arm64: dts: st: add all 8 spi nodes on stm32mp251")
  f798f7079233 ("ARM: dts: stm32: add PWR regulators support on stm32mp131")

--=20
Cheers,
Stephen Rothwell

--Sig_/Vc9nAuzvxGBtK8ilfzaP1ly
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwQ5wACgkQAVBC80lX
0Gzuhgf+Ok/MdBCbmqHI/uXjho52A/7Hk5K5/XmjI6gumq3A5neK4WZjq9p9+CME
E5ux3yA6J34nRu0IOrFuKuDc4+bkaaGoXVgIuzKhEXO8s1I0KJfe4J8QPB2O8x1/
jx6scGf+4BKdNMLgsS89ofhfCd8ewfjxsMiU5QYyqrUwaLJP+uqqFGP/dAt+cfFd
+Jgk1wKDcQSCvc3x06hp2auioK+kyAi7orBI0fBJbk2b4vQr6RBGfhgyUCB2A4Tq
ypqrToPJVnEUtrasZI2XqcyLP1j7++bhpqYHLWu/VpTzcC9hMSm4u2ghjmblyFU/
1fxgPcCa5Wd9oT8CmFdPEFArnd+LgA==
=n/fk
-----END PGP SIGNATURE-----

--Sig_/Vc9nAuzvxGBtK8ilfzaP1ly--

