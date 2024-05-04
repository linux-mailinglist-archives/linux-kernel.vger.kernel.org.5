Return-Path: <linux-kernel+bounces-168502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F818BB953
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 05:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A4EB22557
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570ACF513;
	Sat,  4 May 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWMRA4wg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3E28E6;
	Sat,  4 May 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714791969; cv=none; b=VaQsTkxUm4BBenrnDvjRXcTg3x+g+CFTo/Acn9KPDQjKvDXEiK4GTwZUgdcOLNQVCtRfa4kI7a+rceU0ZEgQZsEoqkAnO1shbnY+2ZkXiyNHXdgW+6O0Ko1Vc8hiZs5nUtDtuvaC86IjwkUR2cSNPKDDLChRw946AdkfXm2BvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714791969; c=relaxed/simple;
	bh=sIT0gCZXBEMj2w6zNJdI1vCzL451cEGf2/e3SNp2kyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJdrDOIs1XhQrea1WL9D0/sv0k76FuHyhOWR1rak7pq2Lq6w+EDrkezRiqSeTViynQOBrBpf9I5GxOIPU4mKAztFkkG35giKs/l6b6mbYWlH8v+9eOGkFxFoDXCbzSA40m6h8oaCLE0+lXDSn48sByFHDT6EYm6nolVOQKZ6Fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWMRA4wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B159CC116B1;
	Sat,  4 May 2024 03:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714791968;
	bh=sIT0gCZXBEMj2w6zNJdI1vCzL451cEGf2/e3SNp2kyw=;
	h=From:To:Cc:Subject:Date:From;
	b=EWMRA4wgV+09g3zSME+gFhl3bxKlZUPmkol+luei/stTaV7LeL8C7J74EZk8hvJuA
	 oGEnfLdW66eMiY1eHadfkdVa42bI/lfGFd/KSHsXdwNxBQ3DfG1fa13uTFBINDYgHM
	 91C4VmmE3kRWsEeWIa1uZNb1Y09c2JTQzKrn0VPXVFEp7zen2oiehbf7KwE1qDkFMG
	 rROu7ybULPP3++MeOUONCZChUhyzeMhO4YAMBiORBs89JenE7Kb3VfuZwuxJJ2htdp
	 +3uxXRnPxz1VpKU9x4ky+DxZRmBxok5S3gamrA9miGP4rOQl3b5eILxmyIIndSXFpk
	 IscOiLyu+KrCA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.9-rc6
Date: Fri,  3 May 2024 20:06:06 -0700
Message-ID: <20240504030607.999295-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d3e8a91a848a5941e3c31ecebd6b2612b37e01a6:

  clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port (2024-04-10 20:50:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to aacb99de1099346244d488bdf7df489a44278574:

  clk: samsung: Revert "clk: Use device_get_match_data()" (2024-04-30 14:24:27 -0700)

----------------------------------------------------------------
A handful of clk driver fixes:

 - Avoid a deadlock in the Qualcomm clk driver by making the regulator
   which supplies the GDSC optional.

 - Restore RPM clks on Qualcomm msm8976 by setting num_clks.

 - Fix Allwinner H6 CPU rate changing logic to avoid system crashes by
   temporarily reparenting the CPU clk to something that isn't being
   changed.

 - Set a MIPI PLL min/max rate on Allwinner A64 to fix blank screens on
   some devices.

 - Revert back to of_match_device() in the Samsung clkout driver to get
   the match data based on the parent device's compatible string.

----------------------------------------------------------------
Adam Skladowski (1):
      clk: qcom: smd-rpm: Restore msm8976 num_clk

Frank Oltmanns (2):
      clk: sunxi-ng: common: Support minimum and maximum rate
      clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-MIPI

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Johan Hovold (1):
      clk: qcom: gdsc: treat optional supplies as optional

Marek Szyprowski (1):
      clk: samsung: Revert "clk: Use device_get_match_data()"

Stephen Boyd (2):
      Merge tag 'qcom-clk-fixes-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fixes
      Merge tag 'sunxi-clk-fixes-for-6.9-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes

 drivers/clk/qcom/clk-smd-rpm.c          |  1 +
 drivers/clk/qcom/gdsc.c                 | 11 ++++++++---
 drivers/clk/samsung/clk-exynos-clkout.c | 13 ++++++++++---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c   |  2 ++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c    | 19 +++++++++++++++++--
 drivers/clk/sunxi-ng/ccu_common.c       | 19 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h       |  3 +++
 7 files changed, 60 insertions(+), 8 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

