Return-Path: <linux-kernel+bounces-19421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CB7826CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F3C1F22602
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD32136D;
	Mon,  8 Jan 2024 11:26:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6082940D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4T7sFk2TdTz4x0bB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:26:18 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d323:2fd4:4f64:e281])
	by andre.telenet-ops.be with bizsmtp
	id YBSA2B00Q0Qz0eJ01BSAsB; Mon, 08 Jan 2024 12:26:11 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMnl3-00Estg-Gm;
	Mon, 08 Jan 2024 12:26:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMnli-00CeHk-LV;
	Mon, 08 Jan 2024 12:26:10 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.8
Date: Mon,  8 Jan 2024 12:26:06 +0100
Message-Id: <20240108112606.3014783-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.8-tag1

for you to fetch changes up to 6b9c045b0602cf64b33ea6da5e6aa6f81dd47ae8:

  m68k: defconfig: Update defconfigs for v6.7-rc1 (2024-01-03 13:34:08 +0100)

----------------------------------------------------------------
m68k updates for v6.8

  - Make the NuBus bus type static and constant,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.7-rc1

Greg Kroah-Hartman (1):
      nubus: Make nubus_bus_type static and constant

 arch/m68k/configs/amiga_defconfig    | 2 +-
 arch/m68k/configs/apollo_defconfig   | 2 +-
 arch/m68k/configs/atari_defconfig    | 2 +-
 arch/m68k/configs/bvme6000_defconfig | 2 +-
 arch/m68k/configs/hp300_defconfig    | 2 +-
 arch/m68k/configs/mac_defconfig      | 5 +----
 arch/m68k/configs/multi_defconfig    | 5 +----
 arch/m68k/configs/mvme147_defconfig  | 2 +-
 arch/m68k/configs/mvme16x_defconfig  | 2 +-
 arch/m68k/configs/q40_defconfig      | 2 +-
 arch/m68k/configs/sun3_defconfig     | 2 +-
 arch/m68k/configs/sun3x_defconfig    | 2 +-
 drivers/nubus/bus.c                  | 3 +--
 include/linux/nubus.h                | 2 --
 14 files changed, 13 insertions(+), 22 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

