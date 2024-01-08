Return-Path: <linux-kernel+bounces-19228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E8826A05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E303B222F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0610A19;
	Mon,  8 Jan 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl1X7BG+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CEE57F;
	Mon,  8 Jan 2024 09:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50773C433C7;
	Mon,  8 Jan 2024 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704704443;
	bh=Un4+C1PQAHh+yJxBQMWKfHOGr8dofZM7PsYXif/zvIc=;
	h=Date:From:To:Cc:Subject:From;
	b=dl1X7BG+y88oW6qoetvXc6sASteSw1zH8U6ytUePjogrVDWrtTrqetqqz2Bc+7UON
	 JV4K4ty7dNNT58hkjQ9r9+kpBOIIHYU83nhrXBiP6zEIo3Vt416PN0wCMzyfSVuSpY
	 zSqPaUQAypE9M1B2wzAPcnujV/4lVsl/vUY4j1K0sBnBIy7GzzR56gdacviOmABPri
	 YQXVJytoxOLbknw6X2SsHKXIH7rPUS7f6SajvbtrjqOQuBrUQD/FzsFEwK6Q9xwDmk
	 7By4mjSIomSGSqT9F+HeFtVMnjZYG0zTSPWOWWiUQcCaWDKoqCez2TF6MMQ0olwnsW
	 jsMR6AFssmKuw==
Date: Mon, 8 Jan 2024 17:00:40 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.8
Message-ID: <ZZu5uEwX6QgokecO@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xCWOF06ZBaUz7hko"
Content-Disposition: inline


--xCWOF06ZBaUz7hko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform updates for v6.8.

Thanks,
TzungBi

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.8

for you to fetch changes up to 57eb6dcd32cf6b49c38eff81e60e8fd471aa05a8:

  platform/chrome/wilco_ec: Remove usage of the deprecated ida_simple_xx() API (2023-12-18 12:44:38 +0800)

----------------------------------------------------------------
chrome platform changes for 6.8

* Improvements

  - Implement quickselect for median in cros-ec-sensorhub.

* Fixes

  - Fix an out of boundary array access in cros-ec-vbc.

* Misc

  - Cleanups and fix typos.

----------------------------------------------------------------
Christophe JAILLET (1):
      platform/chrome/wilco_ec: Remove usage of the deprecated ida_simple_xx() API

Gustavo A. R. Silva (1):
      platform/chrome: cros_ec_vbc: Fix -Warray-bounds warnings

Kuan-Wei Chiu (2):
      platform/chrome: sensorhub: Fix typos
      platform/chrome: sensorhub: Implement quickselect for median calculation

 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 74 ++++++++++++++++--------
 drivers/platform/chrome/cros_ec_vbc.c            | 12 ++--
 drivers/platform/chrome/wilco_ec/event.c         |  4 +-
 drivers/platform/chrome/wilco_ec/telemetry.c     |  6 +-
 4 files changed, 64 insertions(+), 32 deletions(-)

--xCWOF06ZBaUz7hko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZZu5twAKCRArxTEGBto8
9N6TAQDza566l8PrprZuXM5QQ/hMA+cx60FNUc0Y2BGEYon2qQEAt5aAhn1tQNOz
nfB/ZZa78HyHnuvatQifVG0+ksdv9AQ=
=jp0H
-----END PGP SIGNATURE-----

--xCWOF06ZBaUz7hko--

