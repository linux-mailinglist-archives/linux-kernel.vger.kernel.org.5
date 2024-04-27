Return-Path: <linux-kernel+bounces-160907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B18B4463
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2F21F23242
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E942053;
	Sat, 27 Apr 2024 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka4wubfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379C42047
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714195879; cv=none; b=NaMO8qJDkxVKc9bY7aeZmrh1Z5pmbbV8usbgYjQJZMn8Oaz6/P6o2z9IqLPea41pnFh8bKMjHTdKuDBsUy1lJ6HrX5gSyYIKyB4nZD59O9e2/1wZM+cP1ZfvXwg6GZaeLOzwuxJNLSK+POe8RQyrJMi0yKVURj/kO5R0Fwks++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714195879; c=relaxed/simple;
	bh=jCGCnQYYAB5z/OH6q2TDHXIp3uoHtH/DUWsdqJBiBbo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tINvoD+Tfc5wM1F0uziOMSu+9oiWFetxTFcy9/gkr6ItAAWTVbxdKjKR8x7eltCENNjzN0hJhKjvXZHeoGQQlvHRRreHmeLriuoS6Vori/DnBHp0YZMkG6BlMhgbkdsD96JtsWg0rRLZOklDlID2qkTA88NyZkRCcjkOQj8/eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka4wubfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB2BC113CE;
	Sat, 27 Apr 2024 05:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714195879;
	bh=jCGCnQYYAB5z/OH6q2TDHXIp3uoHtH/DUWsdqJBiBbo=;
	h=Date:From:To:Cc:Subject:From;
	b=Ka4wubfONE9jPzqNfqBgVZ2oZYFwK/T7dEa94QhtlrbRKCJlHTkMAgir9+YpTtbY+
	 YJpyFYadnUmuDI7Tk0CZ7mLFUWUKXeX/mARktyGVS/6XwnKOE1zt9RG4L0QlhHEQ9E
	 YgHAPQ0oYS16pxEyUYZyQt40wkjdIpKGVPCQiefTJIcFliyfvNFyeOEguDgM9aPWjM
	 cqKr01lbokT+pz0qoe6Mr4dQcdGd0WcpUiMxfj6RYely2LXGDKKxJhDBYeJ64Idx8T
	 tYXtMLVk7DBFMULc2wt2wWPGdO8MAIKoNZuEnCxtlPfo7SAoQSy0kqQCyez3q+HvB+
	 Qidw+XN6GjgBg==
Date: Sat, 27 Apr 2024 11:01:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.9
Message-ID: <ZiyNohV82k_NTxKZ@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WafzuL1t1lOHN71H"
Content-Disposition: inline


--WafzuL1t1lOHN71H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,=20

Please pull to receive dmaengine subsystem fixes for v6.9. This has
bunch of odd driver fixes for the subsystem

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.9

for you to fetch changes up to f221033f5c24659dc6ad7e5cf18fb1b075f4a8be:

  dmaengine: idxd: Fix oops during rmmod on single-CPU platforms (2024-04-0=
7 17:56:06 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.9

Driver fixes for:
 - Revert pl330 issue_pending waits until WFP state due to regression
   reported in Bluetooth loading
 - Xilinx driver fixes for synchronization, buffer offsets, locking and kdoc
 - idxd fixes for spinlock and preventing the migration of the perf
   context to an invalid target
 - idma driver fix for interrupt handling when powered off
 - Tegra driver residual calculation fix
 - Owl driver register access fix

----------------------------------------------------------------
Akhil R (1):
      dmaengine: tegra186: Fix residual calculation

Andy Shevchenko (1):
      idma64: Don't try to serve interrupts when device is powered off

Arnd Bergmann (1):
      dmaengine: owl: fix register access functions

Fenghua Yu (1):
      dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix synchronization issue

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Fix wrong offsets in the buffers addresses i=
n dma descriptor
      dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver

Rex Zhang (1):
      dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue

Sean Anderson (1):
      dma: xilinx_dpdma: Fix locking

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP st=
ate"

 drivers/dma/idma64.c              |  4 ++++
 drivers/dma/idxd/cdev.c           |  5 ++---
 drivers/dma/idxd/debugfs.c        |  4 ++--
 drivers/dma/idxd/device.c         |  8 ++++----
 drivers/dma/idxd/idxd.h           |  2 +-
 drivers/dma/idxd/init.c           |  2 +-
 drivers/dma/idxd/irq.c            |  4 ++--
 drivers/dma/idxd/perfmon.c        |  9 +++------
 drivers/dma/owl-dma.c             |  4 ++--
 drivers/dma/pl330.c               |  3 ---
 drivers/dma/tegra186-gpc-dma.c    |  3 +++
 drivers/dma/xilinx/xdma-regs.h    |  3 +++
 drivers/dma/xilinx/xdma.c         | 42 +++++++++++++++++++++++++----------=
----
 drivers/dma/xilinx/xilinx_dpdma.c | 13 +++++++++---
 14 files changed, 64 insertions(+), 42 deletions(-)
--=20
~Vinod

--WafzuL1t1lOHN71H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmYsjaIACgkQfBQHDyUj
g0dezBAAtJ8eaZ/AgUhacP7YsBAAs3GuujwEM1D5b2B8MHSr5yw/O5f+dlxxMBLG
nfa74w4gRxBZO6PxW4hqAM1Vd6OCGFJxX8b/Uu85gxLuq0D3KCabiEzw1KUcAnNp
uUr+jNQwPrl7h24KeLeOTc4WwqCEEjlBzAfZ3vT9l3AeyYeOevXdUYc07m9/WVjr
6O7cdKjvkXUN7gfyvP4Lxqs59+STxIdC8KvEoVEUdDNHrUdsF7FWa94u51GsgrU+
VxSF5JRGAEvTU9NvOhXH6Cq+COy11PKnLQl4jgAive6PbkvoqTRE4EmaXPrM6KBq
py6vQPxDly4pmud4Rq99PM7b6tv3pCzaS8vno3MgbOVK2cfIHWeO6jIxwzWcIb0y
MCkBcAL9x00BnovYkFaG9q5UMNHAjn0iXXcQpukE+LXX0wS5hcfzYDE2D+j9oUql
TAyqhVp/54KHgNLddG2p2b6x/xrchKSm2V2WqmDhUnhZwGt/tdTMTzfR2CCLReB3
9NM3qSX5i8p0ABEIyTSAJJV+zAGBZAYQL5/UWkF1YqqLclJyMLMkcqAsc0IBnp5P
3x/ltil5+uv7B0ZyZyV3mb48sRY1qq6vNuGwOlMuHxcuhMKQ1bjgyxdZeIzJ50PB
gf5HXottOe05pqYUTPsv9zwGvzblH62c0Ak42+0/EwtMwDT05Fw=
=d9l1
-----END PGP SIGNATURE-----

--WafzuL1t1lOHN71H--

