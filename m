Return-Path: <linux-kernel+bounces-54638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7BA84B1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BB3B24C53
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937C12E1CC;
	Tue,  6 Feb 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nwoSA4bJ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292512D765;
	Tue,  6 Feb 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213672; cv=none; b=XcDW3kcQl21D3Tmhif/wtOifJAfu1w3yr14G8bycF7BrXj0h97kPSge7NTxgmwQ/Lf4TucSSdGsh7CizeGmSmNPutkg3gMZH7qGYbbRWFduErKCbq7OwJwUA2wnt7Dt50Xv4pjNDtLFQ219kOpKLx3wFTe0oxv8I/yzP898PtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213672; c=relaxed/simple;
	bh=fvkHccuUm3JGOle1s599AZyd3lK2CqLwab+hDW8umO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8JF6RwzbRGAuBnZHWM8xHjRaOdvqehS605DuvHUi86Sj1RkAjMAalAAJ0/hL+NMWAXBJZuAgY9ElrgQaSoUykH9Geo+9XMVvjLmjiA1prZ4w9dHl8QOXhV4ajwceYwt6vynVQmF0tGonSYxycQBdZiYd7GW6+RSp6OnEQZDt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nwoSA4bJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC4BF240003;
	Tue,  6 Feb 2024 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707213661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aTvh+3x7oTaNuvvLeVrdbAtX6QCgQlVnVt3J44XGH0=;
	b=nwoSA4bJrMGSHeTAd29G+6K8AoJwn+qtHmkge70P026yvCy3z9WIjO+FWlp4zz1UnzawwF
	QaXtxIcRZzn8D2AOSIIiyjt3RlQTAQeVBWXA+L0hyVGRnvK2NVkzpJrGFMRe6347ifbISv
	lMQUHJKF2Ecs0joapz+gIDnuqLkBcBINdwEPTUKEmerwWC3Q79vyiQ/adZLSr/rmFvODXE
	0izyPLrnMQSOqBDbwsvZbUGguE/5cok7MQo9RR1sbq0B3DqkMJYfv3BiXsn2DsNQPFSMYC
	Nk8GRProH10cKCTsdOpJMW2cq2j3utJDu03HsRzGPEULVdMkd/nK8SoUuJe6hA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 06 Feb 2024 11:00:49 +0100
Subject: [PATCH 1/2] Revert "spi: spi-omap2-mcspi.c: Toggle CS after each
 word"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-spi-omap2-mcspi-multi-mode-v1-1-d143d33f0fe0@bootlin.com>
References: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
In-Reply-To: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=fvkHccuUm3JGOle1s599AZyd3lK2CqLwab+hDW8umO0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBlwgNb8Ahn/idxoF8xg3jWwqmVsQMCgPHYo0WLPz6U
 Wn95XNOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZcIDWwAKCRAgrS7GWxAs4s9FD/
 9vcX2THeOrHEjsMmk6VcQqgWhKvvWUxIZSax4V15PDlYfegV4Tm4/zkFqaiyhoEKwbJDwHaSBEz6Tr
 9ibfhA2FTXHPEuH2dOX/GCrCrvOYToMULlSFIR/3D111qUdj4RRY9FcEuxGO99nZliHU6fxHIW6ydh
 +2YOSrTwCCjwu/zEpACbx7i0iTCjDOt3+Q3scnjMNZ0Vzyb+XHB93nOAG8cnBCyiTmJzGPSbqXPb66
 1AtbCByQJ08qymMYFIfXAKBwCnLyOufZ8AvIfppCJ73RDsUC0wW9PrXQIxRtxkMhQoXoTx6k3/wH3r
 FGtmX148V+3HQkEpblfn0YdjCfd9m6SAioyQEfH3iJZavZrMTIyOpkgReyDJhBPYi9h5Kk7xGMfjzl
 KH2jYrso+GELiBkKIU9j5U7Uws3irvnG9t5557ArFB4I/6kJVOqlqn963lTetDgsEsj623bE7yzY2x
 098Jas1iNDb71jge4qBEou8X+khzJqyywtBdDcWMbeptPF8F6Sw2usZx5Ax6FOcJbn1Yi2hdux+s8r
 Z+XlnbgXva8WHXxbNmMpw9JNF4FuzRcsmqoTI9fe2Q8wfdYs0oyqkjzqpnnOrfhXRQgzbVZlae/Y1x
 2kIR3IZBl6z7PO1zbWUEf1Gq6+1guCg3/irf8LpNVc1e3kjJNcsT+C3lmVYw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Revert commit 5cbc7ca987fb ("spi: spi-omap2-mcspi.c: Toggle CS after each word")
This commit introduced the toggling of CS after each word for the
omap2-mcspi controller.

The implementation does not respect what is indicated in the spi_message
structure, so the CS can be raised after each word even if the transfer
structure asks to keep the CS active for the whole operation.

As it is not used anyway in the current Linux tree, it can be safely
removed.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/spi/spi-omap2-mcspi.c                 | 15 ---------------
 include/linux/platform_data/spi-omap2-mcspi.h |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a0c9fea908f5..fc7f69973334 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1292,13 +1292,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		    t->bits_per_word == spi->bits_per_word)
 			par_override = 0;
 	}
-	if (cd && cd->cs_per_word) {
-		chconf = mcspi->ctx.modulctrl;
-		chconf &= ~OMAP2_MCSPI_MODULCTRL_SINGLE;
-		mcspi_write_reg(ctlr, OMAP2_MCSPI_MODULCTRL, chconf);
-		mcspi->ctx.modulctrl =
-			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
-	}
 
 	chconf = mcspi_cached_chconf0(spi);
 	chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
@@ -1361,14 +1354,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		status = omap2_mcspi_setup_transfer(spi, NULL);
 	}
 
-	if (cd && cd->cs_per_word) {
-		chconf = mcspi->ctx.modulctrl;
-		chconf |= OMAP2_MCSPI_MODULCTRL_SINGLE;
-		mcspi_write_reg(ctlr, OMAP2_MCSPI_MODULCTRL, chconf);
-		mcspi->ctx.modulctrl =
-			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
-	}
-
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (spi_get_csgpiod(spi, 0))
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index 3b400b1919a9..9e3c15b4ac91 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -16,9 +16,6 @@ struct omap2_mcspi_platform_config {
 
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;
-
-	/* toggle chip select after every word */
-	unsigned cs_per_word:1;
 };
 
 #endif

-- 
2.43.0


