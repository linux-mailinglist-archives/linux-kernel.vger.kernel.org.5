Return-Path: <linux-kernel+bounces-138686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA5A89F909
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668B51C27CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD086171654;
	Wed, 10 Apr 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IzDMXIcE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EF16F0C9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757263; cv=none; b=VVoPTqa6VHonQKTol3a0+KNvndEPQNbqy2SHIV6hXRmfuNNliBxqBVwUsOdxH6m0YpFNsuIey25RE8CHlfTzlz7wchfcuz32yFdofWm9gj95Oe7f/DSuj5GSvt4hKbOosJbIVXiOSA97NA/R90GR7rthp78jxBDZYGGWw72TJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757263; c=relaxed/simple;
	bh=FA/JdKZlZ4wileZrc4xp1llDql17/NQkyQ+ez5FGdwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0wzj7O8Mhz63F/TUhXp5qTKJB+lsjVKrNqdOsju9sWe1l5KJ5UoJbw4/wAfmjDmKPUWCjYXJwvyMvXzkUUN3NxphLERZjk/+lelqSZApEdmYgDZAfCM5oXrb06cFu0BDhdztDrjyRkkoy9OrBee6Q+3+B10cRK/tskJ/dHRvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IzDMXIcE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51d05c50b2so443478766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712757259; x=1713362059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=om0OP/V4nCTPs4aw/OiE4dwxH9wZZxHeDC9s7eqLnZs=;
        b=IzDMXIcESBv5IrpIpcW0X1lmc+XKu6Zt15PO4BYAj+k6KhlUY+rEaJ2/xfD5Zex8J9
         Va4A3MCsgWm6x+k5DyJrWn9mK9XN2mDe0UYfTnwAwmkwtkBv9zg/oLFtjokWoigLaDjJ
         8eSDhOAeLObXl6TgaUyNBC2iQCVOyt3bv/supk4Qiyvxq0DKhJLu/f2sh15iyplApeEl
         7FgAP7qMzVEWSY6ooCLvZuxnVLNcORaaj5F+x7d/5dgo/3N4IiXp+51vXXwwq/NZUY7p
         ATSIgp5RaLQvVU7RUmAPy8dM1qo9bIF/9XOliLIFyIfl4IJCgCiZ9AAtmVJ9uBRDpQBD
         9BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757259; x=1713362059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om0OP/V4nCTPs4aw/OiE4dwxH9wZZxHeDC9s7eqLnZs=;
        b=lcTD6P+3nDkFxWmuaOuz0EHFBOcAwVMm2cTMg8QW27Ngz6gg5Zak5U03PEMdv3F8Vf
         4zzpM0aWt7uaj3XrxnFmA+jPmq+LYGXFakf8egkWJc/KIFOtHR+D30LStCiKDPBghNuD
         xquGNtJC/MRTZbb/pGYlY64jntdYLhCfzmI/pYjkLVItwGrr5MynSVzicEK7pd4k7pOU
         FhRcvh3tAgaT6TcleYCktCFHQjVg7+DP5dHRcMRUVM/BrTGIFB4tSk2XrNFGVsGRGeoW
         TOYQdY7RNJ2pV6M5/OMgfaueGZbj8xYm20dmCJL/bl/QfyBJNKzSsPBYwuaUbekcmg8T
         +iiw==
X-Forwarded-Encrypted: i=1; AJvYcCWFBSm9pUlkzU2cnl4SkPpfM5hJ8pnHnQWOCnkJw4VhlB6r2zg2DaNYNYF+MeYm8MrnrBdiGkR+YBC+pUlQfWAiMkDf9gl1JzDL9TSG
X-Gm-Message-State: AOJu0YxPSrGChbyEIpgfR8MS2SCMFPL5ePCL+E8Al0IAifm9jM5vorbn
	3W7o83dhPYBzQVX6hEwzVwegQe7WXww7s1aiMSRzAxlvFNjfLsAPmoqiOvJFF4xNNqMRA0YEAJZ
	M
X-Google-Smtp-Source: AGHT+IGFaK7YauW3aftv+Qevb50NofJrq4hZ5pzMklC6FKomV3FAiFrZZzWTPk+ZoftKIoNvunVBHg==
X-Received: by 2002:a17:906:4a54:b0:a51:d1a7:ad6 with SMTP id a20-20020a1709064a5400b00a51d1a70ad6mr1598346ejv.76.1712757259608;
        Wed, 10 Apr 2024 06:54:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id j24-20020a17090643d800b00a51d46c684csm3979691ejn.89.2024.04.10.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:54:19 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
Subject: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 10 Apr 2024 16:54:16 +0300
Message-Id: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For development purpose, renesas_sdhi_probe() could be called w/
dma_ops = NULL to force the usage of PIO mode. In this case the
renesas_sdhi_enable_dma() will not be called before transferring data.

If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
call from renesas_sdhi_probe() will configure SDBUF by calling the
renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.

To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
removed from renesas_sdhi_clk_enable() as the host->reset() is optional.

Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- fixed typos in commit description
- limit the comment lines to 80 chars

 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f84f60139bcf..5233731a94c4 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -589,6 +589,12 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			priv->needs_adjust_hs400 = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
+
+			/*
+			 * In case the controller works in PIO mode the SDBUF
+			 * needs to be set as its reset value is zero.
+			 */
+			renesas_sdhi_sdbuf_width(host, 16);
 		} else if (priv->scc_ctl) {
 			renesas_sdhi_scc_reset(host, priv);
 		}
-- 
2.39.2


