Return-Path: <linux-kernel+bounces-2420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81C815CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12C2284711
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A9A32;
	Sun, 17 Dec 2023 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9TA16Kz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB7A2A;
	Sun, 17 Dec 2023 00:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA62FC433C7;
	Sun, 17 Dec 2023 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702774491;
	bh=xF0hPPsgIwECRtdPnmZnepFbxm3ZEpTFevspCbjMWpA=;
	h=From:To:Cc:Subject:Date:From;
	b=X9TA16KzEvFJ4zDubgkrZyRoaZgz2QusDqqyf40STQIFcCDVdFsGLZKbTdYeBPegR
	 /LwfHlDYw26wTihF26uNapF9zQr6u/XwLDbwNiiKgcLiCs+J+XoTM1D/OoFhXRN79M
	 M5OGuBS9+x42olow7vi2g3z6XBo8s0j6Im8225305rpQKk6Ms8Um62liSoXQ6XxmT7
	 0A6mN06LEmUNnG2J/HEmVbC8nlm85wcViHKHQsdkzMr6/lT3KUSvk6Tjj+E8p0KCDv
	 DYvQwZRDz1q+2Ft+7m4wvXyVzwopGpTlkKuXAYus0igzSWYFK3zmvs9LnSW2HFNaZz
	 vlqHbhVYELODA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.7-rc5
Date: Sat, 16 Dec 2023 16:54:49 -0800
Message-ID: <20231217005450.3575417-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 8defec031c40913ef10d2f654a5ccc8a2a9730c1:

  Merge tag 'v6.7-rockchip-clkfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-fixes (2023-12-13 15:26:24 -0800)

----------------------------------------------------------------
A handful of clk fixes, mostly in the rockchip clk driver

 - Fix a clk name, clk parent, and a register for a clk gate in the
   Rockchip rk3128 clk driver
 - Add a PLL frequency on Rockchip rk3568 to fix some display artifacts
 - Fix a kbuild dependency for Qualcomm's SM_CAMCC_8550 symbol so that
   it isn't possible to select the associated GCC driver

----------------------------------------------------------------
Alex Bee (1):
      clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name

Chris Morgan (1):
      clk: rockchip: rk3568: Add PLL rate for 292.5MHz

Finley Xiao (1):
      clk: rockchip: rk3128: Fix aclk_peri_src's parent

Jagadeesh Kona (1):
      clk: qcom: Fix SM_CAMCC_8550 dependencies

Stephen Boyd (1):
      Merge tag 'v6.7-rockchip-clkfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-fixes

Weihao Li (1):
      clk: rockchip: rk3128: Fix HCLK_OTG gate register

 drivers/clk/qcom/Kconfig          |  1 +
 drivers/clk/rockchip/clk-rk3128.c | 24 +++++++++---------------
 drivers/clk/rockchip/clk-rk3568.c |  1 +
 3 files changed, 11 insertions(+), 15 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

