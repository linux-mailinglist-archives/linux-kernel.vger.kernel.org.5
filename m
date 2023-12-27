Return-Path: <linux-kernel+bounces-12144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541981F084
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96C61C219C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C12C41C66;
	Wed, 27 Dec 2023 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XHIUEj2o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678102574D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF4C240009;
	Wed, 27 Dec 2023 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703695226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WV2Dkh4X6V9DETcF8K3WF1QMiYnpkJSaG2LYRTpmYig=;
	b=XHIUEj2ofv8PqSFwvq9hnXalcBEcZEYyJnwS8hG+vB9cbdwLcB8/uEYHxxxRTZAITpxOK0
	TkpQAN/U+eY/6mQTBTar/OO+bOGS53u3mHpugJl2fIfKOP+IFiX1Rjo+U8Rzt4Cs+HMeGe
	USFcCDSEmtkvOQ5enbywBFS02zQ7UMEcPD42jKfR1ZhpqS25ElLISZFu6gj/FBiw1RdZHy
	/qN5W8WGaQt0lH/h+PZ2LejSfTI5EXjmsPN2VgYH6j+OS9uuFMIvqktyW8UGzKHRVhS9wW
	d0o+l/i0j9ghAzi6bZP7N8S91KqulpbVFDp/TgeQytIGls26IgPXGVfQS5GTvA==
Date: Wed, 27 Dec 2023 17:40:23 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v6.8
Message-ID: <20231227174023.346ec9fb@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Linus,

A bit in advance, here is the MTD PR for the opening merge
window for v6.8-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.8

for you to fetch changes up to 98d4fda8f2d4bc3fb97958d2ef4c90e161a628f2:

  Merge tag 'nand/for-6.8' into mtd/next (2023-12-22 12:45:52 +0100)

----------------------------------------------------------------
* MTD

Apart from preventing the mtdblk to run on top of ftl or ubiblk (which
may cause security issues and has no meaning anyway), there are a few
misc fixes.

* Raw NAND

Two meaningful changes this time. The conversion of the brcmnand driver
to the ->exec_op() API, this series brought additional changes to the
core in order to help controller drivers to handle themselves the WP pin
during destructive operations when relevant.

There is also a series bringing important fixes to the sequential read
feature.

As always, there is as well a whole bunch of miscellaneous W=3D1 fixes,
together with a few runtime fixes (double free, timeout value, OOB
layout, missing register initialization) and the usual load of remove
callbacks turned into void (which led to switch the txx9ndfmc driver to
use module_platform_driver()).

* SPI NOR

SPI NOR comes with die erase support for multi die flashes, with new
octal protocols (1-1-8 and 1-8-8) parsed from SFDP and with an updated
documentation about what the contributors shall consider when proposing
flash additions or updates.

Michael Walle stepped out from the reviewer role to maintainer.

----------------------------------------------------------------
Arseniy Krasnov (2):
      mtd: rawnand: meson: initialize clock register
      mtd: rawnand: meson: handle OOB buffer according OOB layout

Boris Brezillon (1):
      mtd: rawnand: Add destructive operation

David Regan (3):
      mtd: rawnand: NAND controller write protect
      mtd: rawnand: brcmnand: pass host struct to bcmnand_ctrl_poll_status
      mtd: rawnand: brcmnand: exec_op implementation

Dinghao Liu (1):
      mtd: rawnand: diskonchip: fix a potential double free in doc_probe

Fabio Estevam (1):
      mtd: spi-nor: micron-st: Add support for mt25qu01g

JaimeLiao (2):
      mtd: spi-nor: sysfs: hide the flash name if not set
      mtd: spi-nor: sfdp: get the 1-1-8 and 1-8-8 protocol from SFDP

Michael Walle (2):
      MAINTAINERS: spi-nor: add myself as maintainer
      MAINTAINERS: change my mail to the kernel.org one

Miquel Raynal (11):
      mtd: rawnand: pl353: Fix kernel doc
      mtd: rawnand: rockchip: Rename a structure
      mtd: rawnand: rockchip: Add missing title to a kernel doc comment
      mtd: ssfdc: Remove an unused variable
      mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
      mtd: rawnand: Prevent crossing LUN boundaries during sequential reads
      mtd: rawnand: Fix core interference with sequential reads
      mtd: rawnand: Prevent sequential reads with on-die ECC engines
      mtd: rawnand: Clarify conditions to enable continuous reads
      Merge tag 'spi-nor/for-6.8' into mtd/next
      Merge tag 'nand/for-6.8' into mtd/next

Randy Dunlap (1):
      mtd: rawnand: s3c2410: fix Excess struct member description kernel-do=
c warnings

Ronald Monthero (1):
      mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response

Stefan Wahren (1):
      dt-bindings: mtd: partitions: u-boot: Fix typo

Tudor Ambarus (10):
      mtd: spi-nor: use kernel sized types instead of c99 types
      docs: mtd: spi-nor: add sections about flash additions and testing
      docs: mtd: spi-nor: drop obsolete info
      mtd: spi-nor: add erase die (chip) capability
      mtd: spi-nor: spansion: enable die erase for multi die flashes
      mtd: spi-nor: micron-st: enable die erase for multi die flashes
      mtd: spi-nor: remove NO_CHIP_ERASE flag
      mtd: spi-nor: print flash ID instead of name
      mtd: spi-nor: mark the flash name as obsolete
      mtd: spi-nor: drop superfluous debug prints

Uwe Kleine-K=C3=B6nig (4):
      mtd: rawnand: brcmnand: Convert to platform remove callback returning=
 void
      mtd: rawnand: txx9ndfmc: Switch to module_platform_driver()
      mtd: rawnand: txx9ndfmc: Drop if block with always false condition
      mtd: rawnand: txx9ndfmc: Convert to platform remove callback returnin=
g void

ZhaoLong Wang (1):
      mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor      |   3 +
 Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml |   2 +-
 Documentation/driver-api/mtd/spi-nor.rst                     | 262 +++++++=
++++++++++++++++++++++++++++++++++++++++++++++----------------
 MAINTAINERS                                                  |   8 +--
 drivers/mtd/maps/vmu-flash.c                                 |   2 +-
 drivers/mtd/mtd_blkdevs.c                                    |   4 +-
 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c                |   2 +-
 drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c                 |   2 +-
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c                    |   2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                     | 408 +++++++=
+++++++++++++++++++++++++++++++++++++++------------------------------------=
-------------------------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h                     |   2 +-
 drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c                 |   2 +-
 drivers/mtd/nand/raw/brcmnand/iproc_nand.c                   |   2 +-
 drivers/mtd/nand/raw/diskonchip.c                            |  10 +--
 drivers/mtd/nand/raw/fsl_ifc_nand.c                          |   2 +-
 drivers/mtd/nand/raw/meson_nand.c                            |   8 ++-
 drivers/mtd/nand/raw/nand_base.c                             |  99 +++++++=
++++++++++++++-----
 drivers/mtd/nand/raw/pl35x-nand-controller.c                 |   2 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c              |   7 +-
 drivers/mtd/nand/raw/s3c2410.c                               |   2 -
 drivers/mtd/nand/raw/txx9ndfmc.c                             |  13 ++--
 drivers/mtd/spi-nor/atmel.c                                  |  16 ++---
 drivers/mtd/spi-nor/core.c                                   | 170 +++++++=
++++++++++++++++++--------------------
 drivers/mtd/spi-nor/core.h                                   |  24 +++----
 drivers/mtd/spi-nor/debugfs.c                                |   2 +-
 drivers/mtd/spi-nor/micron-st.c                              |  59 +++++++=
+++++++--
 drivers/mtd/spi-nor/sfdp.c                                   |  29 ++++++++
 drivers/mtd/spi-nor/sfdp.h                                   |   7 ++
 drivers/mtd/spi-nor/spansion.c                               |   4 +-
 drivers/mtd/spi-nor/sst.c                                    |   6 +-
 drivers/mtd/spi-nor/swp.c                                    |  25 ++++---
 drivers/mtd/spi-nor/sysfs.c                                  |   2 +
 drivers/mtd/ssfdc.c                                          |   1 -
 include/linux/mtd/rawnand.h                                  |  15 ++++
 34 files changed, 740 insertions(+), 464 deletions(-)

