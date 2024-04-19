Return-Path: <linux-kernel+bounces-151639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8A8AB16C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785D61C22BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405412FB2D;
	Fri, 19 Apr 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILOpVh9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A312FB18;
	Fri, 19 Apr 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539544; cv=none; b=VyE8aKfhlsyzUA9+G9AVurptMlMmfQLd8ROnJvma24MdEDYOVCRrV+Xt0iqVXV1aUcmKXd7x+f5sw6sbDxwavoY51thOqxFUSP4o1cf0zPXQEhyYUeje8j0Lj7M7szp+zkldZsZQQuUTl7aG2PtfELYifHuyNAPlXK9PIf1of5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539544; c=relaxed/simple;
	bh=xQEphaQblCfW5AQQOS56beHxi0XAQWru7AWiLautQ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pPseVRRH9c8335KbhDdsChUFJDPdTf3qVqK48KkamU+S1kgsm9iUje1HaQFIR6GLz0kTLipE6KArUROl5axj9DixD1OFR9F0gYm/3MwL6FGmT8vcFA7LbPHJeqclqPXmJrgNhGqEsvVw+1e6sMcQb/fkfzgBQ05ZRrwxF/2XvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILOpVh9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9682C072AA;
	Fri, 19 Apr 2024 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713539544;
	bh=xQEphaQblCfW5AQQOS56beHxi0XAQWru7AWiLautQ2A=;
	h=Date:From:To:Cc:Subject:From;
	b=ILOpVh9KWtBQTPY7rnovDMii6R5GX3+uYENBstpvsUGgP1Tq2ZmQCQljbXL2ljt20
	 pEY7rmFms58EMS4ihwmrZ154fY5iQGPljG1DLTRSjAiQuc4AYlwW2YqpHM0akxHGKy
	 BF5xpvfrjQ2B8Y3rLED1wUOfCc0Z3XFlfzFLigL9v5a6NGPHX2xK37kb/tWaUnrBEe
	 n69KoVAWvS/7Fbo9RXPd4UALkHYQInjVOdpS0M/5owr80QzKJyAs3FdahHL3va4/nb
	 fnvT7x/40q9H7DUoz1Hk10yl7Df0mVjrlWkWLOf9oiSGFUJvpVvkFQq0wY2PS6W1Qa
	 ztimxvi+ERv6w==
Date: Fri, 19 Apr 2024 15:12:21 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/9p fixes for 6.9-rc5
Message-ID: <ZiKJ1Q7Ib6Fj6I9S@3f3e8491d9e9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O+hS8P7x9X5RAHSB"
Content-Disposition: inline


--O+hS8P7x9X5RAHSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8d025e2092e29bfd13e56c78e22af25fac83c8ec:

  Merge tag 'erofs-for-6.9-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2024-03-27 20:24:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-fixes-for-6.9-rc5

for you to fetch changes up to 7fd524b9bd1be210fe79035800f4bd78a41b349f:

  fs/9p: drop inodes immediately on non-.L too (2024-04-11 23:40:55 +0000)

----------------------------------------------------------------
fs/9p: fixes regressions in 6.9

This series contains a reversion of one of the original 6.9
patches which seems to have been the cause of most of the
instability.  It also incorporates several fixes to legacy
support and cache fixes.

There are few additional changes to improve stability,
but I want another week of testing before sending them
upstream.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

----------------------------------------------------------------
Eric Van Hensbergen (2):
      fs/9p: remove erroneous nlink init from legacy stat2inode
      fs/9p: Revert "fs/9p: fix dups even in uncached mode"

Jeff Layton (1):
      9p: explicitly deny setlease attempts

Joakim Sindholt (4):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: fix the cache always being enabled on files with qid flags
      fs/9p: drop inodes immediately on non-.L too

 fs/9p/fid.h       |  3 ---
 fs/9p/vfs_file.c  |  2 ++
 fs/9p/vfs_inode.c |  7 ++++---
 fs/9p/vfs_super.c | 17 +++++++++++++++++
 4 files changed, 23 insertions(+), 6 deletions(-)

--O+hS8P7x9X5RAHSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmYiidUACgkQiP/V+0pf
/5jo3w//Tp8RQDwtPFXyeSa2SEEAUyNXE5UhaqlSfKnNdDn+QaiTmjxGFq7tLVh/
e40eBdRVnuoucBXW5POdmv/7wuG9dYPwE8N1Ic6U2l+Gmz2poNr3Afly4BskudPz
XRbdnir4Iefw1CpWdwZrkZLPDCB5LZGCMhIsV9Zdokve5QNpKenJ+OKiG+hNoSdb
5iyQHSIvWOYP9jlalRMtEPoV2kqUy4Xzuu7/h6rvfMNoKBDY8brsD0wol95XuJAA
TPslEvdn2nZ3CFYtGC1+vozlvaqnIC1TMJ4p4beQgODe5bfsSZxDnQGIHBvbdlRz
hjjrEWCz2rOdl4LpdywTEWSXBKqpg71WuKub6Emxrs8q3ylw92urE2DLw2LovVIx
rUCEFXDVF/DorQ9aQbNe01AdsCkY/bCV6S91lyTiud2Tcrqoto7fTQNA00L1r263
smpYiwnv7kvqEb2teLbQ0gDfzVNZz1RMQ100eTftoYUvHu6089G4eGp2DZZKbvJv
2TFgRFacknf5672Lm2yXfSCd8sIIvCL9LROM2kUGGgzewbY30PgOZxF09dtP3HdP
jdpcoBTOHjUog22LRLOHyLooP82b1kjRQtOaI/SfGGGMZbIeYfNtKYFlvLhmYpns
WaUMfh8PRHlOoZ11QanbbqLB2kqXUKA5YQhltXliKC7pF/ECthY=
=Yiod
-----END PGP SIGNATURE-----

--O+hS8P7x9X5RAHSB--

