Return-Path: <linux-kernel+bounces-51112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198D8486A0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EBB1F2433E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D25DF07;
	Sat,  3 Feb 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHRVpgXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE655D90C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706968961; cv=none; b=JXYKLeGePGkflP6DPvAFlZOPUKyMiJGPQloEJ6snYJzHVljPwYqip0wnjjwMSydEnGT8G+eSAsQwyumYzEWvMwKBXrRQTXNCz1UsFbmNBtrRDE5OAaksMRcXq91//UFrnmADTKVdivM/BKuXc2dTnzgnUhHntDsnr1e8hFiEZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706968961; c=relaxed/simple;
	bh=a5MBvZSR49n8uXGeFnHBpyVIps52UV2ryLIVtoM9Iks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gzCUjzITmNkJtr+3/0etPBOJoNQNkR47jktZfwAVbJcuWKyYHg4FCH0rSGIwo0XZyJ1xv7fQcWPjJ51Qc+4ub8tL+5xnxQifvu6FfMl0hrQRMTQVkPCY0wfjlAhlIcV5FqekWy8CltA6OGEIIbCNSSNDR9yn65ZF/HJrW1kG2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHRVpgXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FB1C433C7;
	Sat,  3 Feb 2024 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706968961;
	bh=a5MBvZSR49n8uXGeFnHBpyVIps52UV2ryLIVtoM9Iks=;
	h=Date:From:To:Cc:Subject:From;
	b=FHRVpgXEUJPB0T8bqvFvr1OxSFFzsrk97+TfMh6kwF0AYnuiF9janfPfmVhbwRxBL
	 HC/+yyyjkYf9Jv5CbqM8Gp9uQNzC/zf1sKgqjyzRWf17iIntea326OIGgTrQImc5Gd
	 SD3yZrL7EP2r3HHKglI/BkSqdeCMUkeSNxqhPuxHPJW4re1sR87vnpi3abzISN5aWO
	 4ScBUlsIcDSw6jr1h7gSbTwh6Mn2cAA8CcAsvc90TvVI7WN8yYmI1ytfUfPc3zuP22
	 WOwmQmhDKn5FYbNwZk5qWDc1kXnrXqB+WUftsql5cbI68h0XLFkYG3XGfBCO1cWnfS
	 xvAMTZ0uzaO6Q==
Date: Sat, 3 Feb 2024 15:02:38 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Generic phy fixes for v6.8
Message-ID: <Zb5HfmEU0dBJxsU4@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="koAfHpCkQU2fVMPx"
Content-Disposition: inline


--koAfHpCkQU2fVMPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive minor driver fixes for Generic phy subsystem
collected.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.8

for you to fetch changes up to 7104ba0f1958adb250319e68a15eff89ec4fd36d:

  phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP (2024-01-30 =
22:41:11 +0530)

----------------------------------------------------------------
phy fixes for 6.8

 - Driver fixes for
   - TI null pointer dereference
   - missing erdes mux entry in lan966x driver
   - Return of error code in renesas driver
   - Serdes init sequence and register offsets for  IPQ drivers

----------------------------------------------------------------
Horatiu Vultur (1):
      phy: lan966x: Add missing serdes mux entry

Mantas Pucka (2):
      phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
      phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

 drivers/phy/microchip/lan966x_serdes.c   |  2 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c  | 30 ++++++++++++++++++++++++++++=
--
 drivers/phy/renesas/phy-rcar-gen3-usb2.c |  4 ----
 drivers/phy/ti/phy-omap-usb2.c           |  4 ++--
 4 files changed, 32 insertions(+), 8 deletions(-)

--=20
~Vinod

--koAfHpCkQU2fVMPx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmW+R30ACgkQfBQHDyUj
g0fTfBAAts7CRok94jOzZBceFw8IxR5B+DuHCRmRxhrdYV4paY89iob1qRUuMd23
6JP+M1PrVj+VY4cUJ8XeoCv+CjUAof9NU8taMEtOzIHtqD1UucOgKgOgA3AB3ZX6
kwyG9KHiZg06ER4HVhYN/SOHA3l4NYG0oC3CEUvim3t5Eizo2fbTAZZklxmMDtk3
8dSkmfTH5PlvQBEGjgMJAGgdwe26kFI2XS503Iag98zdPGbvyy7bUCKV7b1z7CRv
IbXb9IYEad+U1Nfyqds3IgIpeJL0PQ9wSt1pLvstonTSD9bv4NOkmjhFX5I7xWHE
fJgP+v69rj+oVbMQmBR9FMqtLhetEZBBpjncXmygUza5UVvshyF4u/1U6gE4RUJ+
bl3lHDTIdj59DygJ2ecTVfZguv+BCNczeu3Yo9P3MyPHqtjOS5Z5C7lZQ4GgFNp+
PJHBISTzndXOMr+BuPooq7K1E/fyGWH0h/7o0FIVrgTXQ3tBQ4kEw2hattzFZgva
XIAuQBuyvwaVyYXJwyA8wpEX6LI94Lpa/9Ztw4gfq4JRSDeYfdi7e2ye4PSobwD3
MkHCRmla/Z+zYxBKezZkfEeG3dR7QSsRMNVvR0XMc5JgGD6vBLG2JeWEkdkm6Ai5
n1m/fw4fqT+t8n/u3iQ7dJG/6yTAI2Lyz1kaYjK+Au1q9AN8Kwg=
=c5wR
-----END PGP SIGNATURE-----

--koAfHpCkQU2fVMPx--

