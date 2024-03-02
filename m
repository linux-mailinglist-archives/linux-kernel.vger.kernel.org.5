Return-Path: <linux-kernel+bounces-89269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918786ED9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D4F1F22A1E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5162323C;
	Sat,  2 Mar 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L81xOxo/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4B10E3;
	Sat,  2 Mar 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340642; cv=none; b=bNtqjQSK0gSgHDJa/61SMGytHSlUK6p2jSXOH73h4gWi4e9TrVPU01JEKr1ukYqI/deKgU7MJSXzLS72xJv9GS6I5oSac3L/24VkeehHsyKIyVs7vAg0DGQUDXYaNxQhWq/yxZqTF5Wxhbh2f4fPYYnEhwaHaLlQjZ9SFZ9bkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340642; c=relaxed/simple;
	bh=GPkwwNPqyq1g0xLLDF8ViTjGJ0lyDruGjZpNUxhCq7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J6oTAe40Zsv6NSdUcE0m3juXdyTXQZLHdefPlJUDCGPyLj/Ax1A+pF97P9e1Gw/cDcZ84GjF8WbxNfDk/A1SyQo4EYSTJ/RST5FP7bhTBF1ttTuM63KURHwmijMDgvtSFX/D5CqnONrnXCG/bQByqGODPhw4CvsyRo/CUxb86Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L81xOxo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F761C433F1;
	Sat,  2 Mar 2024 00:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709340641;
	bh=GPkwwNPqyq1g0xLLDF8ViTjGJ0lyDruGjZpNUxhCq7Y=;
	h=Date:From:To:Cc:Subject:From;
	b=L81xOxo/Q6PRLcxzCMO4mCLbmqJMtv+EirWPQ96keqB28pzC9Kpg/cuj65jBAsCfU
	 yNW+h6SOxEgkclVD+7rvykTAzhI2P0KiNTuRoa9XnBfpzdEUmsCQF2LxlIBYiVkjTo
	 6UR7a1dbjLP1s7ssawW8evS2shwwewM1orJFOnoxeewyA3tctvOVPatzzLyAtPTJFE
	 1GexnNnY9/CiKSd1jmHDyp/xy11ZEHBE6Nxc8OmuvuUL8vaVA25WpbmA5QnqJqoDOs
	 WY1Sh5LgCgGKkw6t6HwgwL+3qajUrWLz5tzyKgVpxhgIbeSe97LCLVfx481lfiQPY8
	 nACtJrgqVKlWw==
Received: by mercury (Postfix, from userid 1000)
	id 6F87E10633B9; Sat,  2 Mar 2024 01:50:38 +0100 (CET)
Date: Sat, 2 Mar 2024 01:50:38 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.8
Message-ID: <l5h2m2msmj7xp2awqq26u3qbllvjtk3xj772q4ek5ty7vqjmno@2epgarrb3v4d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4k3nsds7pyah66t"
Content-Disposition: inline


--p4k3nsds7pyah66t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit d0266d7ab1618482d58015d67a5220e590333298:

  Revert "power: supply: qcom_battmgr: Register the power supplies after PD=
R is up" (2024-01-26 22:45:58 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.8-rc2

for you to fetch changes up to 2df70149e73e79783bcbc7db4fa51ecef0e2022c:

  power: supply: bq27xxx-i2c: Do not free non existing IRQ (2024-02-16 23:4=
2:38 +0100)

----------------------------------------------------------------
Power Supply Fixes for 6.8 cycle

 * mm8013: select REGMAP_I2C
 * bq27xxx-i2c: do not free non-existing IRQ

----------------------------------------------------------------
Hans de Goede (1):
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Thomas Wei=DFschuh (1):
      power: supply: mm8013: select REGMAP_I2C

 drivers/power/supply/Kconfig               | 1 +
 drivers/power/supply/bq27xxx_battery_i2c.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--p4k3nsds7pyah66t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXid94ACgkQ2O7X88g7
+prIjA//evXrbYl0cATsDrxRnL7xed7Zv5akAK91FSF/ZGcMZNRdGrmH2hYyP/tj
R4nR6fyOdNIlX0jsmQHeUsUYIkkhEQmyIQWWqYMlAEJd2yDyAcusjPaOwyIaOL3g
0TI/lSLmENS1n9pQ8a70nJRy2HxPg/CTSZkiwD70ID7J1WqssOTD+lrbqMvkmzZo
yWt39LaumgyzpPwyZV0KbM1GuzBu8imyChfr9rnQcX+YuBlHL4RkjzI3KokJXv23
ljM28QlVJaNcwdUKIYBGu6EDybFkGVc18tKe7PaCM7DMe8sF/gOGQ3e5HK7yVGTc
nq3/M0pV7PbTon3NWKaDQiPdXFTssIHhn1WlDOGeCqyBE38JiXl7SHKzmQt1fHX8
YSZSS1Uw10baS930FNED3YY5YZkGpKqBwGNjSTJEowi2eigqFx2ttPlxcrdv4EI6
hrmYrylukpPRkcOb/HmYJsvEqzN8s1gK15mCxcrCOJEtdK9MIAFPGPdCOlQOusYF
e7ZOoAMmPYR3EhXOIp20AY+tsGdRKS9euLSzZpt6i45S47lbUc3utQkggC3U/4Ms
j+dYsDFut8w3bLgbEAB3SC+F7XKSNrUgFMhSsB+8P1JxZZZXSFgo77/68rEr8sla
haLDJYR4sgPlRkMADtaFnB9bP/ERhEXmT2bu4fndZMAjSik+nTg=
=G+NU
-----END PGP SIGNATURE-----

--p4k3nsds7pyah66t--

