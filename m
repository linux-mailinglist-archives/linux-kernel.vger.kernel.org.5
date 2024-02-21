Return-Path: <linux-kernel+bounces-74326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6589285D2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E011B21AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD40F3CF49;
	Wed, 21 Feb 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bioarchlinux.org header.i=@bioarchlinux.org header.b="sQR0zNoP"
Received: from bioarchlinux.org (bioarchlinux.org [194.169.181.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF773B793;
	Wed, 21 Feb 2024 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.169.181.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505411; cv=none; b=kuJxJGqH0Nz3rVJU9kgtsCy2GnCSX+UvgtV0n2vBRsUcakQ2pilQN2IbJU24dFZRfVDUL5SfOCnji473A/d/T/pc0spPgBlzi23/NnjBwtNarXY9MMtAmA2LsQ7PuCVIlM0CABITk5E2il8cRLa1fDMswR/6w6+a2yuCSjaTrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505411; c=relaxed/simple;
	bh=u9RZVNHmoguHW4+QAiRhir6A/moENxliS29YW2DJD5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XljLXH5UqlOAS6400SV6xJtaOcU1UT7wgJTDIBpPAy2jAkqrt54VUlCC1xI4jAomvo5NTs+mpLOap9dqW+5Vds1eprY6KjbVPAJDCRwE5p6QFKV+t+d0SyNjfyYF3cp+kjhuCcRzjJ7lVJ620AtrBz30Z2lnrvzGqKtDMLgrgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bioarchlinux.org; spf=pass smtp.mailfrom=bioarchlinux.org; dkim=pass (2048-bit key) header.d=bioarchlinux.org header.i=@bioarchlinux.org header.b=sQR0zNoP; arc=none smtp.client-ip=194.169.181.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bioarchlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bioarchlinux.org
DKIM-Signature: a=rsa-sha256; bh=d0060id0R0zVW8i2sFEopZ4wmRxTFwkqlvBcU/pCIlk=;
 c=relaxed/relaxed; d=bioarchlinux.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@bioarchlinux.org; s=default; t=1708504470; v=1; x=1708936470;
 b=sQR0zNoPQAMEeU9zmwwgCCAfYshgfuHPqBos7n64iv4ib0aH9rQQLcJkDNNlereocX4kQo54
 L6LnPS9zls7XefjIvL54cu4njwExbHrDc/EHY3jmck78t4coQnNMNor6aQyS+N4xCj3NyOUl5/E
 6qf0k0d4dhwKU317wT99L2sjt8rNHwJavsFO4Qpetb0jm9AFe49z6mmt2ls7sM4uYPF0ViTu4JI
 SYIfmWzFIu99IGHphlm9QpPPaLy3c83MB/1Kxk01RosXkgTV3TCkvkN3RVR4yyjipEf0YxEAkxu
 zDc9Xy6PYQYZT3U8IiLFAa7sBCDFm3XYhqDDvEpAJNGnA==
Received: by bioarchlinux.org (envelope-sender <kuoi@bioarchlinux.org>) with
 ESMTPS id 74a676f5; Wed, 21 Feb 2024 08:34:30 +0000
From: Guoyi Zhang <kuoi@bioarchlinux.org>
To: sre@kernel.org,
	wens@csie.org,
	hdegoede@redhat.com
Cc: Guoyi Zhang <kuoi@bioarchlinux.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp288_fuel_gauge: Deny ROCK Pi X
Date: Wed, 21 Feb 2024 16:34:25 +0800
Message-ID: <20240221083425.440108-1-kuoi@bioarchlinux.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ROCK Pi X is a single board computer without batteries using the
AXP288 PMIC where the EFI code does not disable the charger part of 
the PMIC causing us to report a discharging battery with a continuously
consumed battery charge to userspace.

Add it to the deny-list to avoid the bogus battery status reporting.

Signed-off-by: Guoyi Zhang <kuoi@bioarchlinux.org>
---
 drivers/power/supply/axp288_fuel_gauge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 3be6f3b10..8f67f5d0d 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -599,6 +599,14 @@ static const struct dmi_system_id axp288_quirks[] = {
 		},
 		.driver_data = NULL,
 	},
+	{
+		/* Radxa ROCK Pi X Single Board Computer */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "ROCK Pi X"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Radxa"),
+		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
+	},
 	{
 		/*
 		 * Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks
-- 
2.43.2


