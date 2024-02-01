Return-Path: <linux-kernel+bounces-48883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661568462B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931CF1C22FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFF3DBBB;
	Thu,  1 Feb 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFC8k55D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9B2FC29;
	Thu,  1 Feb 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823576; cv=none; b=PE5vrWUj3LOD31mlhdr/F9RvLEwc3vVVje4xA5QtkUn/+cYlY81obks37Sn82uJvyQyhCywFrC03L8SCwCldUpt2Sq00y27X1X3qiuOc9iBmpovcVw1ACe1gNO2c6vbrRDbu+OGSMg2bsFr1i8z/BPy64RyL17LQ5DRUuPCc7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823576; c=relaxed/simple;
	bh=LNjFvMgTDG23nMl2xYzW0OPkJx61zxz2zju131rD4Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DypCYy5uhbaVajB10NL9Zyq9pcHgidic3q8vluS2GbGE6wTkspJdOpYJVO37MPfcQdXL6VCkhv/miAQsyafpsiRUfQjboL/Yhe05Rsqqg8cfXpI8NJ789HFZQgyGzavW+FxOVU4Xxao7MVYwt//xl5/tPl7I+xicMaxm7bSRqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFC8k55D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D9BC433C7;
	Thu,  1 Feb 2024 21:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706823575;
	bh=LNjFvMgTDG23nMl2xYzW0OPkJx61zxz2zju131rD4Vk=;
	h=Date:From:To:Cc:Subject:From;
	b=UFC8k55DK/8P4m3dhtK7K99FmGyu8t6JICM6FgTrW0veIb2DN7Uqf/7wQZuekRZdz
	 Ij82Fw3TmOw0I/NGnQFEXRfWmnOMKXXHj8tJMpMTAK6tawWtP+Ejx2T8Bhd8cpmKPe
	 Qcw4HDMBOvxnc/WrAUlmsWZXOnRiAjJUStJ6clwdExeMzgptZmbOu/YtSw0JV6xQqk
	 b15EtFwnRIAORYQLp4enP8Lne+TDFyimqTXSVvCSKDP4QzRDLjpVa+LNzZNMUM3bfv
	 Sy1fakoy30OTiU1rXPQtOlR55CgpHVSFkbs6tKEomUf93MA9JF7GBZyfLTt5ZVFxaR
	 ZAzR3LwmjC6OA==
Received: by mercury (Postfix, from userid 1000)
	id B24901062449; Thu,  1 Feb 2024 22:39:32 +0100 (CET)
Date: Thu, 1 Feb 2024 22:39:32 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.8-rc
Message-ID: <h5ljtaj5ytq3mdvcqrjak5dq7lrabcl33kx435k7jrufxuapkg@hrnhnok2dwzp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q46yyp3xgvov2knt"
Content-Disposition: inline


--q46yyp3xgvov2knt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-rc

for you to fetch changes up to d0266d7ab1618482d58015d67a5220e590333298:

  Revert "power: supply: qcom_battmgr: Register the power supplies after PDR is up" (2024-01-26 22:45:58 +0100)

----------------------------------------------------------------
Power Supply Fixes for 6.8 cycle

 * qcom_battmgr: revert broken fix

----------------------------------------------------------------
Johan Hovold (1):
      Revert "power: supply: qcom_battmgr: Register the power supplies after PDR is up"

 drivers/power/supply/qcom_battmgr.c | 109 ++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 60 deletions(-)

--q46yyp3xgvov2knt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW8D5QACgkQ2O7X88g7
+poW0g/+OSsOIvOG7fT2UGotbsB4QrHpp3rHI30Kh/+deiRkA3cRM2+0i6Qw9zEs
vBpRjvoubsoli/GCmUlEsZCasvm5wuRZVJJOYi285/a0bWxObtO9N41I1B3VDAjv
Iwa+d94aojyjgtiIGQd/GYRwwAIZRB+PYk4e+iWpm/j4fvNeljV43ecJpsfpPKrY
1ivfNQGkjR6GTf9xIeCgzDf4V4miuTokrZ5P9UnDaigPQJt4EfCSQLfwGVIO2uK+
6Q4wZNsoj6jvqg6GD69cZBn57bcbl/K6Sb60y7CyTXvBVPHhfNXbH9js5ZKsEbjV
Qv8QMxgerL4acnZK0sK4FsnQucSjOIYZj7o9vCG7yOlvOFMdcRKrZj63Fy+x4Bek
zfbL11re6D9Kyh0OSucTQ7Wk0o1h8SyJpaCk4NvmzdC4ZiwFP6k43YDUkl26HBDd
Dsd7MbfTQRE0+puOdWlsHTDjmm472f271CteKKmgU569YwZNNtasufap3ehA7dJG
njdlbPXHE2MCWCPNmxIrtjo89Y1sB0D60gv/3uPOQnsIrZhYFSd/Uwwp/t0ROhRt
Yz1XisYIMExNjslRwMzZHqz0kDmjHtw38VXFNM9uY5/TqYXptW6EVboqvQsHrwTf
vgDcGQ86vavLRCN0RuFDwnPaBs77dx2P8C68hds78RMVbU3HR8o=
=VsGn
-----END PGP SIGNATURE-----

--q46yyp3xgvov2knt--

