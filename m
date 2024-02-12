Return-Path: <linux-kernel+bounces-62275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F3851DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA741F22B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C619B47773;
	Mon, 12 Feb 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zeprw5OP"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F741208;
	Mon, 12 Feb 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766426; cv=none; b=PhCpRzzeDlGbNs44rylRP4hwGXl9yeZGjc/MiH3EzT8V3yFTBpHBFHiPWmTCBq9ofSAFzLT3/Kr9hnL4cNsIPCzJkUdA0Rm9V7fZn/8iTGivcSobXpStcvIwsoOpWnfUnqm4zL0dJjgR9Rjep0ei2fSV003CGDYZ/ZLBZBPqN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766426; c=relaxed/simple;
	bh=VHD7V7W4qwRQhqwPSDefa6gX+ovxXlDZA21Vs4ZGEfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxuhgMLV3OYrTo7cH44H8FzW6yU4NkKd39tcpR6t85Jd8JirbMW93vwkL4Aci1ZbmUjKTx+Iyubr9AV7JVmZs+kzSqwJgx6kgakbmE6MYvJdb71kGDbzXJnx58SjojK8hPfIkp1fJ/8nW9ZsY/gElDJ3ka4LsBbN/i8umYRyo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zeprw5OP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0dc3fdd1bso37237631fa.0;
        Mon, 12 Feb 2024 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707766422; x=1708371222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oum1jt+Q8dDAhYrJmUGRUjhcfu3Z0CZYzh6RXzXRq4o=;
        b=Zeprw5OPYTpbybUt6cHCMv2QIRsycKomuoMpngNnzgp1u1j4NsWAfEuaOzTXkyDdJb
         mx4BtWFx3pauEWGtxVCdurUOL71KIIeKSo7cqa8a6CoRww1BFozdiA/XQkRhrhkjsBe4
         Wn0JUZECtIuluYBIxrXFa259ry3JEOlX+J5yt6IVBM8SEW0pC2eXxYBvw/fMzsv5IOnh
         HiET0MuL2TLY7iUnr9tigpAnb1NRwfBpzOjHHBoVD90SeWUPr8OCWVIzwU5xttdeFoSz
         wSNnGGGA+XshkCci7S7BOBKr1by4zOt6az07dckIHaNpn+iohP6EV8P3ocZO/qUez9hY
         Pbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707766422; x=1708371222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oum1jt+Q8dDAhYrJmUGRUjhcfu3Z0CZYzh6RXzXRq4o=;
        b=bOMpjJrz0wYjGl3PpCzY16JVhcl/lM9yIFxf9EAvmP3Y0J1sLhvX5rZETsCKI+fiFx
         shverDm4Du9FTpZjY/a7QtPFIYDNp405Ut5IHLzwHULxo43xETpSB+9DW49ftnnoO0Yg
         D77jcbT2hCXIUDitpVBbc/E814pTUpzdf184zVHORU0aH7avO3uKSltf3/5y0tGWBcLL
         L+UDPaZV5E77HQrvDv7l+n2RgPLObWOIXB31DUjej7XYrUZypc4ECRKRQqgspBy/Y+5s
         YUC4ddAzpFuOdfS9Uyor5FVgYhvSw6NEOjORGMrtkWcfJZc7WmuTaWbLT3PY7NWIozxS
         Otew==
X-Gm-Message-State: AOJu0YyodPxpiZTIMFx9Uy59pRrh4RURNFz+vBcpOB4Xq4slaWBzzv3O
	3osQNipXS3ZEMnzZnXlYh9CIS7Ws7F0nUfrCq2W0NlUlsMxmUAMn
X-Google-Smtp-Source: AGHT+IF4novuZ4Y+eA7hevM2fEuPwi4qeOPqKqpoEiAhRwgn1+MjD52hUUFLrsPXmYD3imwC5WJV+g==
X-Received: by 2002:a2e:9786:0:b0:2d0:7a98:a493 with SMTP id y6-20020a2e9786000000b002d07a98a493mr4846826lji.39.1707766422053;
        Mon, 12 Feb 2024 11:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoXX0vLop0ktvQhx4o6Q8IadytmX76FfJx/4Dz2GhnX8qNSE9lpa0Fp3T0rMcCPyfLqcRdfwMpebyEsY9Am8HG4orbqp+J1fS0slepcN47i42j07t58Wk3QyXZgqS09uapXkwrjpNsu3dSvATOEuv+fLHfhQZvE8XanUVnzdZucA9lTdOfr5tfQceK53hNGSjcoIeZ06I/JTDEoxEl249x0k51sSPLE6fhgVY6ocLYIRyMjwRTga2q2u7xMWVdJy+ZvGrVWOlzbal/YSqRo+W0wC6UKOTOeHP7j56isxWx9PTPrjtRO5s7i6OUJQFynIN8noEJ0tW6X+o2f1sfLuYZwHsG2JVrlhw73Usfa/mf//bhJAP0uQjNctesk6pI9b4QE2uGBUVFQcYQsoiImh+tpGLLIedkjm+yp3Ze0qoKhlIvpX3nfV1WT7BNjaHyCnA6BVt75Pl8Uk6joTGwYNy+M1mnUO0gaUIRwTOkJ4TDIRUswW2n+9Hv9iZaOSJFQCf6aCr1vhUXwjVuzUH/Dm8LuAbIfmDsHxSAuhES19435g6m5rA=
Received: from tkudela.. (c156-103.icpnet.pl. [85.221.156.103])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b00a3c66ac5146sm501104ejc.120.2024.02.12.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:33:41 -0800 (PST)
From: "T. Kudela" <ramzes005@gmail.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "T. Kudela" <ramzes005@gmail.com>
Subject: [PATCH] Add Lenovo Legion 7i gen7 sound quirk
Date: Mon, 12 Feb 2024 20:33:27 +0100
Message-Id: <20240212193327.59507-1-ramzes005@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sound support for the Legion 7i gen7 laptop (16IAX7).

Signed-off-by: T. Kudela <ramzes005@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index d74cf11eef1e..8a6b484b2184 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -95,6 +95,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -431,6 +432,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA38B4", generic_dsd_config },
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6994c4c5073c..0029f61d4693 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10260,6 +10260,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
-- 
2.34.1


