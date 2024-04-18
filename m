Return-Path: <linux-kernel+bounces-149745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED68A9551
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C8B1F21F86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575515AABC;
	Thu, 18 Apr 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM6RAXcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601D1EEE4;
	Thu, 18 Apr 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430129; cv=none; b=QmeCBp6zp7b04iTuxgBVhvdNt3mZbAqTmHmnD/HLhx3cgbwAbxE3h/AzpsCLGXcvQuqTC47eLOmE2RBzufCoVNwFDcQ4amGIJlrrFgTiRU6sfzbmd0I3L/3Nk+sglAn+njtmYPGelvTqdzUJ+AYS7VEbu+qlDmhmWa4tDEHEJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430129; c=relaxed/simple;
	bh=IcW5HH5uLJMQErQnLPAUQVaxQ2dPNEI1SzIPahK7MGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8j6U2c0oJW1M+QEvch5rBs3P6lwbdwXYGH37eo3IIIFUYJ70B14mEgL+lPXEC/2MFbV7zW9CKi2Y0YtA4GYzFx6Kz2vb9J6bxKJv65hExk1SUOg0Rmab4RAg40rxXeQdeT1csT+HxRQ8RY3n6Uybezb1kZkX3d5gZzmjv98+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM6RAXcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04DCC2BD11;
	Thu, 18 Apr 2024 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713430128;
	bh=IcW5HH5uLJMQErQnLPAUQVaxQ2dPNEI1SzIPahK7MGY=;
	h=From:To:Cc:Subject:Date:From;
	b=pM6RAXcYxLIpwPYr0Bu42IjhAZ46yUDnhVS/DYAHTONRJt8BuWL3GwTbiHIeFqBDj
	 b5N36zVUgol0TpndMnXUtwmgdfDP+iloJrqRZ97amj6exIVRQHk3HD0OApsPz5T+K5
	 c30nCckHwbVqnTGL3rAW1yjoqFbNaZtKN5bfW0zm7Gg8DBGafQbgDGED2RTr4mdzqU
	 2XfjCfbsJMVEKnRcIC6kdevqFarqqGuBLMOgkF2fiOH01rZWhCL1u6w8FFstKBmuG+
	 lmsrPJ8G3RyPc6PVI/tCGLYtWY5VPqLqKygARfjzOIVtXIWHFqYWlf2rDwmCg64QbZ
	 adZ/ORRWndwXw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1rxNRl-000000000uU-123p;
	Thu, 18 Apr 2024 09:48:45 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Brady Norander <bradynorander@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14 NBLB-WAX9N quirk detection
Date: Thu, 18 Apr 2024 09:48:27 +0100
Message-ID: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer Matebook D14 model comes with essx8336 and supports SOF,
but the initial models use the legacy driver, with a Realtek ALC 256
AC97 chip on it.

The BIOS seems to be prepared to be used by both models, so
it contains an entry for ESSX8336 on its DSDT table.

Add a quirk, as otherwise dspconfig driver will try to load
SOF, causing audio probe to fail.

Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 sound/hda/intel-dsp-config.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 6a384b922e4f..8e728f0585dd 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -46,6 +46,22 @@ static const struct snd_soc_acpi_codecs __maybe_unused essx_83x6 = {
  * - the first successful match will win
  */
 static const struct config_entry config_table[] = {
+	/* Quirks */
+	{
+		.flags = 0,	/* Model uses AC97 with Realtek ALC 256 */
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.ident = "Huawei NBLB-WAX9N",
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+					DMI_MATCH(DMI_PRODUCT_NAME, "NBLB-WAX9N"),
+				}
+			},
+			{}
+		}
+	},
+
 /* Merrifield */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
 	{
-- 
2.44.0


