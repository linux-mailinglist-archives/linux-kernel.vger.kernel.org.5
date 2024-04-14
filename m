Return-Path: <linux-kernel+bounces-144249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA08A4394
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346361C21098
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924FB134CD0;
	Sun, 14 Apr 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpARtQbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D16134CC7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109804; cv=none; b=OUfx70Faw7M5X0vhpquaoFVOLN4xPIzzcUIQmB/CSYNu1lDpz4n3SP6Xn0iI57OnoCenRpyZsUWZCRsoInN4l0UmKeAj7dDDmsYlzNXPgUIdv1p7sehOb0OYREC6ZjQ7cSg4hwRgQd1xdk3qXjTxuFPz7vbQgU9fVNYB0DiD1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109804; c=relaxed/simple;
	bh=OdvuLRFOyPbK9M1u502x2SaqLqdv5YEh3Og0kbbothY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/LsKcc+dmHwM1M+pHiR7gkzWtdMapBaMrN1IBFjqSLbUGil9AoGg3l6XoeOaCDmePF5d/9Atm1Lzu4NyTFbRdqOgdlM3UeX1QY2QAAuiTV0mZbaFInRMZ88jGuoEnYqx9mWPZoGT9DDw4INCGB813CvNM08UGcP8G5VCHsTAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpARtQbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60193C072AA;
	Sun, 14 Apr 2024 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109804;
	bh=OdvuLRFOyPbK9M1u502x2SaqLqdv5YEh3Og0kbbothY=;
	h=From:To:Cc:Subject:Date:From;
	b=OpARtQbTUsjfG/5pAejSz+e2ikl1HFSrtRp+fqeLMtqz/fvbm3o/p5BeA5P3pmtwL
	 BG7ffpuii6HLP+zHKH7C6tMbZV9I4FCTt8NAUCUVX9NMzQeDHMthI4cPEnzC1QLIgC
	 C0HUpgugz8pS0p8hBiBgq4i2GONU+bE18/STHJ2hFNfIFQS/mD25Lu4Ztk7Rs7KaNa
	 HFVD26XlWz7ZaeGhhQDmJIO0UA5o5/riI0Zu74CiJVTh6GzEu3EXzllY9cpg40W2AX
	 8KsaMucB8StkNMwTek4XHYSutGALlqtHN76V/U/D4dv+mC/1yv2zz8/gaE0nfWkfkv
	 GeWQCT+tw/HoQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] eeprom: at25: drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:49:55 +0200
Message-Id: <20240414154957.127113-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/misc/eeprom/at25.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 65d49a6de1a7..595ceb9a7126 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -529,4 +529,3 @@ module_spi_driver(at25_driver);
 MODULE_DESCRIPTION("Driver for most SPI EEPROMs");
 MODULE_AUTHOR("David Brownell");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:at25");
-- 
2.34.1


