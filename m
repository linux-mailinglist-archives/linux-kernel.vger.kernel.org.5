Return-Path: <linux-kernel+bounces-18733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D838261FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E323C282521
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02039107BD;
	Sat,  6 Jan 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgOP3q4p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B4101E3;
	Sat,  6 Jan 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ba8e33dd0cso40710339f.0;
        Sat, 06 Jan 2024 14:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704580806; x=1705185606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjMgdeRpctwTJ7F3CFnuysHXKhIpRAp8TwJ6AUfLDG4=;
        b=cgOP3q4p95nx0zj5ZtKQ7kGZqSW23grCuabNMXaiXOFQjzzU97RI4y7zXClkW24kxF
         j/wCoxYxZZDlCVK8gmrcFWY3iKbzDNP9Gn9WH0BirU/abG/oR8HtClJPWd+Vih7vPbiU
         Uo331tSs0C+GBZLwznUXtljFebb19eShSXKTCecvy04nffMHpGsO4UQifsVhGP6yyo5z
         Hj+QL3xf1I6G2szt7gtzudmGutsdVRT2P7dBP/J87Gwe29VweLfhsyI98yO3scYSuyVL
         +sUSWHPduky0htJjKZQ6kmfsZFDLadcVwNIk7fzJiyDHzdeSRhWEExiFDb06J8fpf9ST
         dRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704580806; x=1705185606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjMgdeRpctwTJ7F3CFnuysHXKhIpRAp8TwJ6AUfLDG4=;
        b=hcdEi6Jnx1OHohYuypPDEGkunnDzyM5SwqtaIZK7dCq9bLT3G32evzxZ2k6qO6ok3C
         uhB5drSr2ZJkb4pvzWUsELXX4jzL9APf7ygebDMjxwCPqj7K5HvWvUoqMUIC5rHlDyWu
         fonxW+OmW03duUA8UbKnkxpG9RUzSOklp9Ul3+Q3YIjuiS/pUd1HX7twY1W/DrrVqXOl
         IXZZlsUVY60Gjh8jaVOXXnMDwYqVUkhP0FslGLpPkkrgJR3Xr9sD9n0k6Ye6Xdj0LtrP
         ux++jLcDTZvo6+4oWhfxFJBG8vdVOHjk45cAjCwQJpf+x5sxNLK4k1eb4LFfYMa++gGf
         XinQ==
X-Gm-Message-State: AOJu0YzKMeGme657fGtRZLwmhQGD4fLr/HtRbl+u1pU5ATvgX+KDql4/
	Dzys4DDv+o9EMAODBPQHnS3Z8J5S+2oyeA==
X-Google-Smtp-Source: AGHT+IH6sL6lYSC6STeoHI+PeiaWMCl/uvrhXHbpVW3sbXBLqzbyLho0XvENXWhiIPVRFPYJCUkyuA==
X-Received: by 2002:a05:6e02:2402:b0:360:8928:2170 with SMTP id bs2-20020a056e02240200b0036089282170mr507707ilb.26.1704580805888;
        Sat, 06 Jan 2024 14:40:05 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:af2f:17f0:33a3:d6fe])
        by smtp.gmail.com with ESMTPSA id l13-20020a056e021c0d00b0035ffe828182sm735346ilh.37.2024.01.06.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:40:05 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>,
	Sandor Yu <Sandor.yu@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain
Date: Sat,  6 Jan 2024 16:39:49 -0600
Message-ID: <20240106223951.387067-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106223951.387067-1-aford173@gmail.com>
References: <20240106223951.387067-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of
hdmi rx verification IP that should not enable for HDMI TX.
But actually if the clock is disabled before HDMI/LCDIF probe,
LCDIF will not get pixel clock from HDMI PHY and print the error
logs:

[CRTC:39:crtc-2] vblank wait timed out
WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634 drm_atomic_helper_wait_for_vblanks.part.0+0x23c/0x260

Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
The original work was from Sandor on the NXP Down-stream kernel

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e3203eb6a022..a56f7f92d091 100644
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


