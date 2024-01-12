Return-Path: <linux-kernel+bounces-24628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930CC82BF67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B1B1C24000
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386616A00F;
	Fri, 12 Jan 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DvjVeClZ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866467E99
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd853c159eso20474981fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705059725; x=1705664525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/rump7FJVJNPWGDY7eQkIygw/qM87nMEtv54Kd1xEhw=;
        b=DvjVeClZhnKc60WELMH/5aVdlL0M4HuqaZ5UiUZKPC7YBhRhS+xZMTVTDE0bBU5sFo
         0uHCLBjpA1LrZuOYh045hx3P9soxpv+oSpP1h+Dq8HSo1tfV4tQKMGtoLimx8DMvXBNY
         g9+2UquVBfRpHLarvlpAB3GKepQDn4ProFIN1z1FWeSthAKrHLRb12e9n7mHqfNcC3xN
         rLOgzbnDbY/Yg4UAylsM4kAnQe1QgqHIp1Xfx7FkmZxj6ZYsuFPmtAlvGFOc4p2zBkv4
         ejGRcjPri/ue5A+sLSYMXSrPS6nMyL2kT9HDyP+/qOGRYTvvUw0Ld7PCCgD9LxQiHYz0
         Ot3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705059725; x=1705664525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rump7FJVJNPWGDY7eQkIygw/qM87nMEtv54Kd1xEhw=;
        b=EDNvzC6xvBpxmzqOwfqt3XLET7uDUmmudobYRqODPb2hpktXvs2OnZE7FeGJiQE9EP
         rzjMFLiy4fRn0z9Pa5gWxGHrxHJ9bxSUdQ2vLV59SghHHYKZ59qiDtsABwbGvlv1Ww2Q
         NSt6aOcLyYuDgST5FaeCyUrSVcPEqFQvgA9kB4/tLPCiBTOnHi3SM1ifQXI0kyg+cRQU
         fvN9MkpRO+5L6E0+eDgXa2V9TMxROBrtAeWyeacnKIdyMCwbQhi8BqJthatU3J0iJieV
         38hJQit3hOrqlLrE4PcrNmx+intWhzEnkDmyHrWkmZBOHRL2gjKCR9A5Z7V1J5hJ4E0P
         LSCQ==
X-Gm-Message-State: AOJu0YxjsLMnMcAbhvzuKH+MuJ9MmnP8P3KkU6UMIGHUBUCy0z+ovONr
	EaC2yPOXTYE8oQEYmxVBUDx6BTOLGw1+4g==
X-Google-Smtp-Source: AGHT+IE4w/nFjCzljVEDAPK0XNlU8n5xrN4aXj734ZNsjQ41zwqRmP98QLtd8L+nPaXRNeAkqJWPog==
X-Received: by 2002:a2e:b17b:0:b0:2cc:e48d:d0f3 with SMTP id a27-20020a2eb17b000000b002cce48dd0f3mr624955ljm.79.1705059724916;
        Fri, 12 Jan 2024 03:42:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id cw3-20020a056000090300b003367a5b6b69sm3667726wrb.106.2024.01.12.03.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:42:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	yoshihiro.shimoda.uh@renesas.com,
	takeshi.saito.xv@renesas.com,
	masaharu.hayakawa.ry@renesas.com
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] mmc: renesas_sdhi: Fix change point of data handling
Date: Fri, 12 Jan 2024 13:41:47 +0200
Message-Id: <20240112114147.1977955-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On latest kernel revisions it has been noticed (on a RZ/G3S system) that
when booting Linux and root file system is on eMMC, at some point in
the booting process, when the systemd applications are started, the
"mmc0: tuning execution failed: -5" message is displayed on console.
On kernel v6.7-rc5 this is reproducible in 90% of the boots. This was
missing on the same system with kernel v6.5.0-rc1. It was also noticed on
kernel revisions v6.6-rcX on a RZ/G2UL based system but not on the kernel
this fix is based on (v6.7-rc5).

Investigating it on RZ/G3S lead to the conclusion that every time the issue
is reproduced all the probed TAPs are OK. According to datasheet, when this
happens the change point of data need to be considered for tuning.

Previous code considered the change point of data happens when the content
of the SMPCMP register is zero. According to RZ/V2M hardware manual,
chapter "Change Point of the Input Data" (as this is the most clear
description that I've found about change point of the input data and all
RZ hardware manual are similar on this chapter), at the time of tuning,
data is captured by the previous and next TAPs and the result is stored in
the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
If there is a mismatch b/w the previous and the next TAPs, it indicates
that there is a change point of the input data.

To comply with this, the code checks if this mismatch is present and
updates the priv->smpcmp mask.

This change has been checked on the devices with the following DTSes by
doing 50 consecutive reboots and checking for the tuning failure message:
- r9a08g045s33-smarc.dts
- r8a7742-iwg21d-q7.dts
- r8a7743-iwg20d-q7.dts
- r8a7744-iwg20d-q7.dts
- r8a7745-iwg22d-sodimm.dts
- r8a77470-iwg23s-sbc.dts
- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774c0-ek874.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc-rzg2ul.dts
- r9a07g044c2-smarc-rzg2lc.dts
- r9a07g044l2-smarc-rzg2l.dts
- r9a07g054l2-smarc-rzv2l.dts

On r8a774a1-hihope-rzg2m-ex, even though the hardware manual doesn't say
anything special about it in the "Change Point of the Input Data" chapter
or SMPCMP register description, it has been noticed that although all TAPs
probed in the tuning process are OK the SMPCMP is zero. For this updated
the renesas_sdhi_select_tuning() function to use priv->taps in case all
TAPs are OK.

Fixes: 5fb6bf51f6d1 ("mmc: renesas_sdhi: improve TAP selection if all TAPs are good")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c675dec587ef..f86260800076 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
@@ -312,6 +313,9 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN	BIT(8)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA	GENMASK(23, 16)
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA	GENMASK(7, 0)
+
 
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
@@ -641,7 +645,14 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	 * identifying the change point of data.
 	 */
 	if (bitmap_full(priv->taps, taps_size)) {
-		bitmap = priv->smpcmp;
+		/*
+		 * On some setups it happens that all TAPS are OK but
+		 * no change point of data. Any tap should be OK for this.
+		 */
+		if (bitmap_empty(priv->smpcmp, taps_size))
+			bitmap = priv->taps;
+		else
+			bitmap = priv->smpcmp;
 		min_tap_row = 1;
 	} else {
 		bitmap = priv->taps;
@@ -698,6 +709,7 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	/* Issue CMD19 twice for each tap */
 	for (i = 0; i < 2 * priv->tap_num; i++) {
+		u32 val, cmpngu_data, cmpngd_data;
 		int cmd_error = 0;
 
 		/* Set sampling clock position */
@@ -706,7 +718,10 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
 			set_bit(i, priv->taps);
 
-		if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
+		val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP);
+		cmpngu_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA, val);
+		cmpngd_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA, val);
+		if (!cmd_error && cmpngu_data != cmpngd_data)
 			set_bit(i, priv->smpcmp);
 
 		if (cmd_error)
-- 
2.39.2


