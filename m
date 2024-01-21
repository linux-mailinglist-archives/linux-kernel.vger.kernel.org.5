Return-Path: <linux-kernel+bounces-31977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E78354AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 07:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA891F2376D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0403612C;
	Sun, 21 Jan 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7EBNXJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0E1E534
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705816879; cv=none; b=mYDKJE/5yCBGHlN8iv3YPeFNUszARStsCpDSv8i2qjzfxJ+rif92YSKipyrhVIIEIUKvPGR6qTqjEBZ3dzVuK8v7+elbo9VOk/KuN8VTObXkrDGnQpKcktTN/VfvOPiySsUe5XvCS2GnvhpXeze9pWzxdMY+KhOWuy8BTzz1WJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705816879; c=relaxed/simple;
	bh=NhuWvOK0Ww7kWbZZ5RP94AqOzv5GR82HM8u8uXEYXoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XrThdx/NnmozuIOAS/V8S0rr+WaUGj9yYO9JBYoAoKvP5p5iDUcuMj2L3a8fl4qx7TKio5kN7f/1eZmKWuFO8igGSw0BtngEvJqLM1HZNbXcLLzdLJNSV4e3icXJNvEHxteQ+bWWm80gbnaatYDXbgYmcxMGwlapCBNtnmCd98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7EBNXJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F70C433F1;
	Sun, 21 Jan 2024 06:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705816878;
	bh=NhuWvOK0Ww7kWbZZ5RP94AqOzv5GR82HM8u8uXEYXoE=;
	h=From:To:Cc:Subject:Date:From;
	b=r7EBNXJGZQpC+3aNfH8hPNKK8Moi2IktJH5QBxGfFERpiGuhdBOFsQSw3s4unNLpt
	 6EM21rgFFfUK62e/vhWco8G3L+IgfgrSddS3JRsqOOKX5guIvElzZRgGdeppIlkc40
	 x5HKTLHufrkg1m4W+CfX4XmtGYdCkeO2XNfQg5eUc27p3kmzZpFm6xcIBSYRUvGO+Z
	 mhK6YWKC0AJd4emRusaBFychz/IS2eBeBDiNpAaJc6kP/yUYgIu1MIA4RqS4BTff3Q
	 zpRtLafeqx7li8Lzfb7jraLfKaf0edOONBICP1LoUbnTNs42gUel74cNNNuvZxJud/
	 PMWjeyblrmrZg==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-2 tag
Date: Sun, 21 Jan 2024 11:31:11 +0530
Message-ID: <875xznql7c.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc fixes for 6.8:

The following changes since commit d2441d3e8c0c076d0a2e705fa235c76869a85140:

  MAINTAINERS: powerpc: Add Aneesh & Naveen (2023-12-13 22:35:57 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-2

for you to fetch changes up to 18f14afe281648e31ed35c9ad2fcb724c4838ad9:

  powerpc/64s: Increase default stack size to 32KB (2024-01-19 00:10:14 +0530)

- ------------------------------------------------------------------
powerpc fixes for 6.8 #2

 - 18f14afe2816 powerpc/64s: Increase default stack size to 32KB BY: Michael Ellerman

Thanks to:
Michael Ellerman

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc/64s: Increase default stack size to 32KB


 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTYs9CDOrDQRwKRmtrJvCLnGrjHVgUCZayyTgAKCRDJvCLnGrjH
VlgzAQDkYdg1/DjYNR4Ie/i4MdlYj2cA4s4kTR1x25QHHb6t7AD/URA8U20cMSla
etAHTJ3/Y/B/C/nL4GsC2uC5nYZ+bgo=
=WIHK
-----END PGP SIGNATURE-----

