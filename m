Return-Path: <linux-kernel+bounces-98846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2961878033
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8E0284287
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6B3D3A2;
	Mon, 11 Mar 2024 12:58:57 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBF3C478
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161936; cv=none; b=mL2m31CGoLAeYajS+xAukQA+RPF/TdyHyQ2JmISPzgSl3XS2KakJl7dhpMGzBiDqMsycnQdb9GaUwSnMogd0OPNqkwbQZGLHXuLnS6EYm+v2cJfPlmNMqNIVI/G37geBtTnrmyZjJxeM/237t/bXM6aJ0H5+p+y0IWek+YPRDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161936; c=relaxed/simple;
	bh=ii49fGC3mhpaFd3v6s+iIuIloF621GLYoYUtHbdDJwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dlv8hz3dmeDfanjwZhOmQ0YEQO4so9jxCd9g7Kq79ZFhMiiHa0XljqDIEBhWZR1FwaAtg7nA8UIocI3WVur6Eq0vBoyzkoc5povspwdSzlNKj5lc44KJ8QT9Z3Ogy40vnYnGbuFmaOXaB1GzeCJGUTDG1I4O/OjScP8PucE938U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by laurent.telenet-ops.be with bizsmtp
	id xQyl2B00W0SSLxL01Qylb1; Mon, 11 Mar 2024 13:58:46 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjfEc-003Kri-EN;
	Mon, 11 Mar 2024 13:58:45 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjfEr-005R5v-NB;
	Mon, 11 Mar 2024 13:58:45 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.9
Date: Mon, 11 Mar 2024 13:58:43 +0100
Message-Id: <20240311125843.1295782-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.9-tag1

for you to fetch changes up to e8a7824856def1c8608401b0d7d05566d6e81c95:

  m68k: defconfig: Update defconfigs for v6.8-rc1 (2024-02-19 11:11:01 +0100)

----------------------------------------------------------------
m68k updates for v6.9

  - Make the Zorro bus type constant,
  - Defconfig updates.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.8-rc1

Ricardo B. Marliere (1):
      zorro: Make zorro_bus_type const

 arch/m68k/configs/amiga_defconfig    | 3 ---
 arch/m68k/configs/apollo_defconfig   | 3 ---
 arch/m68k/configs/atari_defconfig    | 3 ---
 arch/m68k/configs/bvme6000_defconfig | 3 ---
 arch/m68k/configs/hp300_defconfig    | 3 ---
 arch/m68k/configs/mac_defconfig      | 3 ---
 arch/m68k/configs/multi_defconfig    | 3 ---
 arch/m68k/configs/mvme147_defconfig  | 3 ---
 arch/m68k/configs/mvme16x_defconfig  | 3 ---
 arch/m68k/configs/q40_defconfig      | 3 ---
 arch/m68k/configs/sun3_defconfig     | 3 ---
 arch/m68k/configs/sun3x_defconfig    | 3 ---
 drivers/zorro/zorro-driver.c         | 2 +-
 drivers/zorro/zorro.h                | 2 +-
 14 files changed, 2 insertions(+), 38 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

