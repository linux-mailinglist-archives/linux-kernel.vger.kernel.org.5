Return-Path: <linux-kernel+bounces-164049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DBA8B77BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D589A1C22430
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3685F9D6;
	Tue, 30 Apr 2024 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su5ioAEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219C172BA5;
	Tue, 30 Apr 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485539; cv=none; b=mo278cTPaSuIcxria0YUAAyqWgebD4o809zpNo8ktZwOe9M2RxxUuqU8zd4VP3bs+EJk0UHA/dXn32CRBlv0LunI1rnbgG2+O926f1sL8jleyoNAwS4iRK6DGXX8Fv/x9DLQzj6ObcYM8p5Xy0wXE8qDEo2gTQ5+VRFT8nzkZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485539; c=relaxed/simple;
	bh=h5tVx/WOx/kTAZLHLPVnXLUPYCNpavvsHOekbq3Gtx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dtq0Dz9riLdkiWO6+sTzWUnAKsKAALEklFWbMoikAfJOyK94HGiWBxeYJSar0GsbKwoe8Bg7SXcMTYA+nVzDfB7oVm20nCC3xYHt5Ma0UUlMefcacNUdp2yeXOBCp7sdnHV4f+uT6/IYJMBukKhJ9xsAJuk7lLjjtwQJfu/7yTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su5ioAEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BEBC2BBFC;
	Tue, 30 Apr 2024 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714485538;
	bh=h5tVx/WOx/kTAZLHLPVnXLUPYCNpavvsHOekbq3Gtx8=;
	h=Date:From:To:Cc:Subject:From;
	b=su5ioAEgUh5upo8euVL1KW9WrtoAeXsCiubBpKF34jyLBJck72SV3c0EFJBwBtA8P
	 KKCG/T5HoE4oVKs4iE3tuOE/IeOzl2p9do1SgOTzTIjlrjLwc7vQVk4Bt1zKjzxOqf
	 hDw0D9QQMBmV713VYCDSLSBQjKPNwwMtpavw/75OIn3MCZemxL+rV9yYnU52pJPaY0
	 TDeKoAHMo1iYd1s8iywub/m8m8RSjIlwRS2xgsXVzvy0YuL4++j2tVbZS0+F0JdDGw
	 Qw9Nr0iuG1h89ueSyVu90pLPjJMS2uVxxlp0Sc1gaX0V91R7rYbQmGtq6JTUWI/Eme
	 mkOn3ElgtjoeA==
Received: by mercury (Postfix, from userid 1000)
	id 5BA80106074C; Tue, 30 Apr 2024 15:58:56 +0200 (CEST)
Date: Tue, 30 Apr 2024 15:58:56 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.9-rc
Message-ID: <vreefzn65ijap4kxzxgfk5bom7uz5skoy3rn7fktydd7mgavbj@kfhvex76iw2z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uqqpcdjdj7ooh7ah"
Content-Disposition: inline


--uqqpcdjdj7ooh7ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.9-rc

for you to fetch changes up to 1e0fb113646182e073539db96016b00cfeb18ecc:

  power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator (2024-04-15 13:31:37 +0200)

----------------------------------------------------------------
Power Supply Fixes for 6.9 cycle

* mt6360_charger: Fix of_match for usb-otg-vbus regulator
* rt9455: Fix unused-const-variable for !CONFIG_USB_PHY

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

 drivers/power/supply/mt6360_charger.c | 2 +-
 drivers/power/supply/rt9455_charger.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--uqqpcdjdj7ooh7ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYw+RYACgkQ2O7X88g7
+pr76g/4pqjJIQBpeAgQZexr8iZez4hI+lc0Rxpx/oFt6K7kojhpXbLCyVdYowLD
5g0pYq7jmVfXx8uFJSZxTJxMP7g1F54RhvkLuhvujb45zqU9zPQrLo6KcveVoLqa
vBlYCJ1+4Ju96uQyIEBnFLMZHPrPQvUJBUbJ/Ia7optmgqIRiVznMOba0eqbhBCl
wMjhQoZBRriExl82pWVqMMDB0FP6gHq8PB+6ygt5FwqfgKS3bWCMnrEDXKsSxn85
AS7H69XXAQAwMP91/zaW9epqmuH/tIiafQnIo0/g1R/zCqJSuSUOhvQbg9yLtP0S
ogWdiIIjXKjdl+EmX1lqEPQCFGo0I4onwonwxneJ5cRoWp7mTd68OSwC83wZfwWS
CHwAzkyoCeMBiE1/EdWtm26l8+Huow1pcJ92OwxEI+NRR63UsUt9ZEOrj0Ito647
hrxpzndajUnzXUlvNOl2vuGeztgvgygI4PZphYg8HBJZ3RG2iwI32P/1bPA8tPGh
O/EWjzO09rHjpSOm1eaZoGyIo2xSQJKug9GYByTR9uOiQ8psfv7lhMcMAvWNCUei
Ran+8JnYRQL5oKsJ0XxS3Hw580IuBPiYq7GbIsJIKdDLYVDl1BepDXwJw/z22ChK
ua8cYYiOhu3CNerR9L0h8h8QFZwoAluic65g2VCoepbIUZATrQ==
=MboO
-----END PGP SIGNATURE-----

--uqqpcdjdj7ooh7ah--

