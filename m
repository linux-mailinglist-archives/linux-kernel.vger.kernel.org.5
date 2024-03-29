Return-Path: <linux-kernel+bounces-124833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D9891CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048F4289474
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5E149E06;
	Fri, 29 Mar 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOpij4LK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271571B6758;
	Fri, 29 Mar 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716257; cv=none; b=lLWXT9w5xQfDP4hYxwffun1iugmx/9QIttqxFgvOiRuOJGDIQrzkaBKYB511J6v8QfIXxi9sK+F7IVlABAtK0kxDZOYAu5UId6+tvYR4++bVpK/uLwg+p+s+N8ZdYskLLJ9+8QFZThcYzr9++0coxaszXHRpoD/w6atjLJDHTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716257; c=relaxed/simple;
	bh=IcBZv3SzKonQC6Je+MdRBI/FShiONCtFBUzie7WvtW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx6A9bw1qEwBS+ZgPbM5nD3tF1VsgQJ50O8OBItaWrWlJTb/01yX0lU2sBQbzaUe48j71SsoYu9V85K0CzY70K5+QT929gm5IikMkiLZ8jsM3JlsyNWZQQHCjBlQY4o7uLDAjg1FnuzeFZB5vLZy1sfw1DAd6G4hwZDHlQaX1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOpij4LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F228C43399;
	Fri, 29 Mar 2024 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716256;
	bh=IcBZv3SzKonQC6Je+MdRBI/FShiONCtFBUzie7WvtW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOpij4LK+7++k/CQgp+/S6ll7VMljB0HXSbeGzFZP1RUWsGuCUNE8+afA1pms/XXr
	 u/Ye4jbBhHHdBcGlkP835uq1H6J1r0i/blnGMwH9cOaTnulJ44eAl0zjRzrlfuRv8w
	 Sv5tlotpvOUUuyGKZ2e8k9JcuIgU0ZH3qeYH8IfHHiSM7S7y2HB0sIvse+nOKSKu0Z
	 /Vt6E9/KRqhya716ei3hZCNw7Jyco+Yav6L88wmmlopiitzxC9PCtISuriIMsm4lE/
	 RSi6gS/TZQAzC4qA5hFhyuLewVM2zIp3tiDmQ9AOrrmHAppRjjM+at8AG7eHvVk/Mw
	 j2aqHWUKLJMSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Sandor Yu <Sandor.yu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	rafael@kernel.org,
	festevam@gmail.com,
	u.kleine-koenig@pengutronix.de,
	marex@denx.de,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 24/75] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain
Date: Fri, 29 Mar 2024 08:42:05 -0400
Message-ID: <20240329124330.3089520-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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


