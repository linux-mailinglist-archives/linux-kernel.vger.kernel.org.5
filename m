Return-Path: <linux-kernel+bounces-127269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CE894901
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C74F2844D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CBD27E;
	Tue,  2 Apr 2024 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="X4y7ooI/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="By5EdEgK"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7B79F5;
	Tue,  2 Apr 2024 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022702; cv=none; b=HGpCG91CfKkp8V74jje/u8WtvJJNPf3v+w4dOlFJwJ6FC1ZcMP5I0Uzkrw0getYEn8VNXds82MsJ9ckLITUgNmkDZGoXNIeIk3roI3yHmJcHO4pD5RWnpaAcguvxKavIEIFfjG39CVaEymKN3yaRTUCxxDSuFQaol5xiaGfRzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022702; c=relaxed/simple;
	bh=yVklnQZkvuukUb5TI3+wA5MCAtaQ8hORKgo5k4bzUCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOe4xLDrf8faKHAOy8pKpATfXcat3P07jSz/WeEWjglHDW9Vpox5qaSktwwATWlrkUF28H5qJvolKe997VSs7nb8xY+nyM8nY2YOZxBkyq2zNYyxCJlEYZQYxlX6wcgthL/yDzSfYFae/G1jomaaqHwm4Y7jEYzL4lVnqYW4uCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=X4y7ooI/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=By5EdEgK; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2A143180008F;
	Mon,  1 Apr 2024 21:51:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Apr 2024 21:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1712022698; x=1712109098; bh=wKpiPWBbBrJfJ1GZmz9eV
	aeSFAsiH0SYmwmSOg718gI=; b=X4y7ooI/Mv4GEBIMWodAe/qTWZYvyJnqAXYMG
	SXmupajCMzJRSnrr4CIU7N6epm1aFKUjk28STQq3rpi6sXMi0Jn9FcP3jUEdhDuV
	ttBlhQUhqtIGX8eJyTDn/qGd+nk063hqt422m1/4tYLKIGkLVJMhOk7TYZvGE0ht
	kjVSLVaCqLjt75G/WDJ6CtivM+8SppNnWRxPhtdPPlfvmVjhHLugUVRXyZWMksZa
	+CufLRcnxFrIYab08YJSIfZ93JLaxxTqN3Qt90C0nO0fxdJMX2GXS50HdljzT4ju
	XAkRAU4ibUjABXAR0PDckCHynJTyLWM/4p5p2eVfLWhp31cGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712022698; x=1712109098; bh=wKpiPWBbBrJfJ1GZmz9eVaeSFAsi
	H0SYmwmSOg718gI=; b=By5EdEgKA991Sut2s1QMithRDFoUUuSthQZvNMJk3ZjZ
	I+C8Ctb2P58cCN94GYBK9DO4f4xJoI8kQ/Rd+hI4OeKD/UfGDV5aIywmDvouf9jE
	jLH+/KF7hQ/PdNxK5OqjyRkTGDIa7i+NiAvmuv5K9soQ1WcXQMmAqPKHGt1mVgA2
	DnhSm/3iiQL42EOcgMhkuW7RQZ3ka4OUxnek8kkXJ3czOmdRP65N0ZMPNMLw/L/7
	8c5ch1YHxcNLqtAwdudqdqA+upcdau0GPpNCbFruOaD1SSMw+5RtAdTbjthCeUXg
	2EjGTAXmP4MC5qXvV4MLm+JzzNOaIBQO1kz8tAqRAQ==
X-ME-Sender: <xms:qGQLZntOi2jHlO4ynoYwRh_Y0_v_t1gKo9q43jYufo_f0P5GRlq25A>
    <xme:qGQLZocILfesoGYJNQ0UvaGjWb3ZUk6P5cpIqz21FzQdLDbpgl1bP74uy-z9XVHKx
    -38CjjsaQDGTF5Aw9c>
X-ME-Received: <xmr:qGQLZqxDqplJFZXvcG-ZpGP4fdeWfonXjxxlb_FHvwKcFZoh-meQfbqMB6Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:qGQLZmPEvjU2R71cMKi-xsDn3_TIvfkR8zI5_yW2wLJLNBERIpGVjw>
    <xmx:qGQLZn9UMmgtJ2JkcVAw2M7fJYXYQiHv4ki40TapBA2gszG5MfbhOQ>
    <xmx:qGQLZmWwUh0rGm-qqwaGekDbG9CCS2gwsLFpU46d0hdBZBmQcc7TsQ>
    <xmx:qGQLZodqaWxZCArrQLvsZ3bsJyG2bCzRcckGyvKjXfDxbyIADemAHA>
    <xmx:qmQLZtcRll8JUMgVHPgbydl6a4IjDHL6v4MA9BzBGFHUPg6vOLmoknSz4jg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:51:32 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: tiwai@suse.com
Cc: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	foss@athaariq.my.id,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR
Date: Tue,  2 Apr 2024 14:51:26 +1300
Message-ID: <20240402015126.21115-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the realtek quirk to initialise the Cirrus amp correctly and adds
related quirk for missing DSD properties. This model laptop has slightly
updated internals compared to the previous version with Realtek Codec
ID of 0x1caf.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 72ec872afb8d..25c117db3317 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -108,6 +108,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
@@ -496,6 +497,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "10433A60", generic_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA38A9", generic_dsd_config },
 	{ "CSC3551", "17AA38AB", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a17c36a36aa5..8da2827bb3c3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10133,7 +10133,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
-- 
2.44.0


