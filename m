Return-Path: <linux-kernel+bounces-160586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D438B3FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC652854F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C118B672;
	Fri, 26 Apr 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gy9Ml43x"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541E46A4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157494; cv=none; b=Viqa3JWWA4QjEj/3hnLqI+fS+fxroKEKwTuI4xfCXD4hcChIiR4u3nG5BO7xVISva1mMN74ebE3/+EsFb56/3RjqgzR49w29xX1cuPWz6wQCma4/72m1P9ZfpGVvhEPWc24gDtfymWAvSvfi5wggjs4lYQhYr9aXJ5JZmEX5eYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157494; c=relaxed/simple;
	bh=DkEvngDBB3MNfELbAt9f5hlbt6xYbf9ijwH0JaDlDio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I8i5n/wvmdlwFYdn1PZ9vKu7coCBXPD8IMQMxnLOYy3+lkJjh2T+lyfX2vMin3mBZotEcRMudh1XcMjNAZbgSqFbqIoSCqd6hsQXIYX/45Jz5sC2O62SX/HvsUEJUDhWhYSE1nKfHbV1kNLyfic/Z28BkjGLnYNIBUxrWFGyWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gy9Ml43x; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 194BF1C0002;
	Fri, 26 Apr 2024 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714157484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BGDwF3LmHI8vTp9didlTcp3I3mEcoXABuDaz4YLe+zg=;
	b=gy9Ml43xUjrjg/Gi5x1lst7/Sa46RY9YXzQeYroTafjQg8xrRb9+zqzVLfekcTmiKRL4c6
	XE1Dyymun20Oo44Lki0ct7AiMGLdeoXSxqG4+aidGUCcx6nHzDEPaArSX16bMplHVZjmSC
	sAcO2jYexgRUU5gzYdvXJWvBp0tTPmwHGop+fc3RL92IO50BZCiUNZX6g9RYiUK1RP/YTh
	aOx1hFsuaAl6u00cO9M5rG2+Tv7Xt8HGnZemwkSqtpPDkj77VbktzVM+2Tpu+mDrq8n7hl
	jAarOaWQfMePDKfck0Qm1ilb12t6E3WCUIMe8AMs/9xRGMEibn1nuSwGdJRrfA==
Date: Fri, 26 Apr 2024 20:51:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v6.9-rc6
Message-ID: <20240426205120.36804cea@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

This is an MTD fixes PR for the next -rc.

Thanks,
Miqu=C3=A8l

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.9-rc6

for you to fetch changes up to d2d73a6dd17365c43e109263841f7c26da55cfb0:

  mtd: limit OTP NVMEM cell parse to non-NAND devices (2024-04-15 12:04:37 =
+0200)

----------------------------------------------------------------
There has been OTP support improvements in the NVMEM subsystem, and
later also improvements of OTP support in the NAND subsystem. This lead
to situations that we currently cannot handle, so better prevent this
situation from happening in order to avoid canceling device's probe.

In the raw NAND subsystem, two runtime fixes have been shared, one
fixing two important commands in the Qcom driver since it got reworked
and a NULL pointer dereference happening on STB chips.

Arnd also fixed a UBSAN link failure on diskonchip.

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: diskonchip: work around ubsan link failure

Christian Marangi (2):
      mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_c=
md_type_exec()
      mtd: limit OTP NVMEM cell parse to non-NAND devices

William Zhang (1):
      mtd: rawnand: brcmnand: Fix data access violation for STB chip

 drivers/mtd/mtdcore.c                    | 2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 drivers/mtd/nand/raw/diskonchip.c        | 4 ++--
 drivers/mtd/nand/raw/qcom_nandc.c        | 7 +++----
 4 files changed, 7 insertions(+), 8 deletions(-)

