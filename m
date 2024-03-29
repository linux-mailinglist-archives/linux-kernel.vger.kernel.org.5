Return-Path: <linux-kernel+bounces-124572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4F891A18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CCEB224DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746712FF8C;
	Fri, 29 Mar 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Ing9a2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B031553BE;
	Fri, 29 Mar 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715436; cv=none; b=ngDHZBO1qegpDtLTehCd9pNyX0M2ezQkJfAruxR+quIidakzxNKtNz0XIyvY/6uSSG4DgCEYhvqz2ADGhSJjDfEkmvfjH1blMgWduMqHmsy+VSgU+gH72PuyNML1hDvj+UQ8cAFvzAw2iBk4IuJDpnKfgMj44/AnMNlhgcuXfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715436; c=relaxed/simple;
	bh=IcBZv3SzKonQC6Je+MdRBI/FShiONCtFBUzie7WvtW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1rjM9xVh94yxrjp+8RpqDSjGAKgcUmdbHdOoDVLCP5WYaadjlmj0I6ztkL4/r7c1s6lgAdAn95GbKtXJfNagkgYC7vlAjSNYJzgKACQTzzCmiVkKLaeyXlcbSXaPZaN7ocjutYNLrLqUImdPS8zREiDtN65oQTKf+e4Juy5M2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4Ing9a2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79E0C433F1;
	Fri, 29 Mar 2024 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715436;
	bh=IcBZv3SzKonQC6Je+MdRBI/FShiONCtFBUzie7WvtW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4Ing9a252IQLn4CWSZcqNdlJsLoZ+EyOQSyKZ79GExvDmFQ80KsXZdciRf9m98th
	 Xxwe2+EhIezgTwUaW2W2NofZG8ZZvBB7uTaToA7bsG+TGXGd98k5YuEew5yLOHPpjm
	 I6D3PuIctqjnCyb2BgsZ60xKM1DFpBYpsSuTT0xQ6yzqd1iRiHCNF/Rj9jJ8veLagn
	 bPy/yg/vwi9RYI8EQzbMHWYWgkpOt+fWE7dNvSVBFs56krsfHb9P/LIskSyE82BreB
	 tkWuF4X20wqcBVtdMG05GY9eWWI0owclIq6v4FaHvKToO8cIJCcSqaIYTqnpH2Wx7R
	 4GkcDhBVTZLDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Sandor Yu <Sandor.yu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	peng.fan@nxp.com,
	geert+renesas@glider.be,
	festevam@gmail.com,
	marex@denx.de,
	u.kleine-koenig@pengutronix.de,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 21/52] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain
Date: Fri, 29 Mar 2024 08:28:51 -0400
Message-ID: <20240329122956.3083859-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 697624ee8ad557ab5417f985d2c804241a7ad30d ]

According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of
hdmi rx verification IP that should not enable for HDMI TX.
But actually if the clock is disabled before HDMI/LCDIF probe,
LCDIF will not get pixel clock from HDMI PHY and print the error
logs:

[CRTC:39:crtc-2] vblank wait timed out
WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634 drm_atomic_helper_wait_for_vblanks.part.0+0x23c/0x260

Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
Link: https://lore.kernel.org/r/20240203165307.7806-5-aford173@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index c6ac32c1a8c17..31693add7d633 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -55,7 +55,7 @@ struct imx8mp_blk_ctrl_domain_data {
 	const char *gpc_name;
 };
 
-#define DOMAIN_MAX_CLKS 2
+#define DOMAIN_MAX_CLKS 3
 #define DOMAIN_MAX_PATHS 3
 
 struct imx8mp_blk_ctrl_domain {
@@ -457,8 +457,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 	},
 	[IMX8MP_HDMIBLK_PD_LCDIF] = {
 		.name = "hdmiblk-lcdif",
-		.clk_names = (const char *[]){ "axi", "apb" },
-		.num_clks = 2,
+		.clk_names = (const char *[]){ "axi", "apb", "fdcc" },
+		.num_clks = 3,
 		.gpc_name = "lcdif",
 		.path_names = (const char *[]){"lcdif-hdmi"},
 		.num_paths = 1,
@@ -483,8 +483,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 	},
 	[IMX8MP_HDMIBLK_PD_HDMI_TX] = {
 		.name = "hdmiblk-hdmi-tx",
-		.clk_names = (const char *[]){ "apb", "ref_266m" },
-		.num_clks = 2,
+		.clk_names = (const char *[]){ "apb", "ref_266m", "fdcc" },
+		.num_clks = 3,
 		.gpc_name = "hdmi-tx",
 	},
 	[IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] = {
-- 
2.43.0


