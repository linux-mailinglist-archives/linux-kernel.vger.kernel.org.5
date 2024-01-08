Return-Path: <linux-kernel+bounces-19233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827FB826A14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89D51C21761
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFB1170F;
	Mon,  8 Jan 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTS/ZfIK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89B1118C;
	Mon,  8 Jan 2024 09:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99703C433C7;
	Mon,  8 Jan 2024 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704704568;
	bh=yuYERWoxvA9j1o8EdIPlUTS7GPEWdTAznT3MJAvA5qo=;
	h=Date:From:To:Cc:Subject:From;
	b=UTS/ZfIKbuUqBB2sLpDCbXqnASoo46S+eLmSDINojZKbIefAUfvVB8rVMpSSxiMAQ
	 RHlvVV3iNQ40K/8aHK4AzHaKHkizAysP/q9w9fi0zmg6hsXqTjgbG9gf47e+gTgT+o
	 /Sl73CSpDh2zLqisVsLf66g6ASf5VW6oyagFoCtkKGXN1i7372016D7I4cBI+pWxJe
	 y6t1n8/BFn6B4UfArjUexNxT1Iw98feliIh1TsxThBfixtQG6tkPZqyCMTwStVw/LW
	 OZlEboYNeKk1a5qJQZO83hxlXnXhMMkfrYOpv2gEl3C+pVftdUvDyBqLsNVELWnrEw
	 aS8MjFbqmmjLw==
Date: Mon, 8 Jan 2024 17:02:45 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform-firmware changes for v6.8
Message-ID: <ZZu6Na7lHZj2KU0h@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J0vjuWdR142Mvqaf"
Content-Disposition: inline


--J0vjuWdR142Mvqaf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull chrome-platform-firmware updates for v6.8.

Thanks,
TzungBi

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git=
 tags/tag-chrome-platform-firmware-for-v6.8

for you to fetch changes up to 09aeaabebdafbcf4afd1c481beaff37ecbc6b023:

  firmware: coreboot: Convert to platform remove callback returning void (2=
023-12-28 10:42:25 +0800)

----------------------------------------------------------------
chrome platform firmware changes for 6.8

* Fixes

  - Fix an invalid address access.

* Misc

  - Use .remove_new() for converting the callback to return void.

----------------------------------------------------------------
Alper Nebi Yasak (1):
      firmware: coreboot: framebuffer: Avoid invalid zero physical address

Uwe Kleine-K=F6nig (1):
      firmware: coreboot: Convert to platform remove callback returning void

 drivers/firmware/google/coreboot_table.c       | 5 ++---
 drivers/firmware/google/framebuffer-coreboot.c | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

--J0vjuWdR142Mvqaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZZu6NQAKCRArxTEGBto8
9EU0AQCambQ+5TGo+z9vLZmnpvmT3pYqUilERLBjBDaVR3PvzAD+OMF0MASm7VAK
V0AsBgF2jlKy713wKBxRDCs5mjdGewo=
=4sif
-----END PGP SIGNATURE-----

--J0vjuWdR142Mvqaf--

