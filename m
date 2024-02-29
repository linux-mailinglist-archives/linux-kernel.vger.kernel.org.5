Return-Path: <linux-kernel+bounces-87018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC686CE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95291C21B21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969F1547C0;
	Thu, 29 Feb 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey9l9Kj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870A159E0C;
	Thu, 29 Feb 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221878; cv=none; b=by/+OPnn4kdaZrzyVdj9mMI/VA5d/QFxLtaBGibntzc4MDkkclOr+YZEThgyeOXIgOV368m3y4geadHr2UlhL09SwqZg14t20ECAm6nWlIc/2NuAQaafFYYGvsVnHOTflGMprTW7Qeim2Rr2yzItHrTWJfHTJNoLWLPl5Icc2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221878; c=relaxed/simple;
	bh=8vANWfrWNpLxtQjJ+V3xxVFjGXzaPGNXYBX9xlxgqls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIPd1xgDe3JCs3O+gImrR5Cp7Pjer4rXf7m/AvwcDSCbiaUgRBqnr6rUAoTfER43jOFuwhvU4CL4cYvNO9zz4BLN36x5RmOp20wORPlPbn7hNkjNxYIqqRNV9qWzEYmE7ATgrf7enNNCd8xi39ey43aSrnqPKrx75K8m/XRVZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey9l9Kj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B75C433B1;
	Thu, 29 Feb 2024 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221878;
	bh=8vANWfrWNpLxtQjJ+V3xxVFjGXzaPGNXYBX9xlxgqls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ey9l9Kj8lRXLY4rfS5vwNG0YVYvTUMfuKUJWXaEHwGRsMgESUQWwxCj7bxEcPORyc
	 Rd4jP5C6O4e5CfLIbI8wk+EGZXjfMlOJAMotQNd6Kg0bHmtJ9UQFcT1gDFI1Hds4x5
	 ZHKhTjSWritfqPaLNIrVPYGLos3LAHK34ZrY4BnnKW1p1X/LTa8e4GkhqvGAZ2zSn6
	 CIqlUmc5Iw+1tJfQi2E2J8GLcdtiKhP+XKAn7pud72NBHdkO5sBwYSiBQihe4R0rh/
	 HFBM3hsWhIFDWXSugIfuRATp655hM2qsA6zDEfEvtcawC790rj3/4AR1HQ9tCdaX25
	 7kAIxCcwuvG4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/7] ASoC: rt5645: Make LattePanda board DMI match more precise
Date: Thu, 29 Feb 2024 10:51:07 -0500
Message-ID: <20240229155112.2851155-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 551539a8606e28cb2a130f8ef3e9834235b456c4 ]

The DMI strings used for the LattePanda board DMI quirks are very generic.

Using the dmidecode database from https://linux-hardware.org/ shows
that the chosen DMI strings also match the following 2 laptops
which also have a rt5645 codec:

Insignia NS-P11W7100 https://linux-hardware.org/?computer=E092FFF8BA04
Insignia NS-P10W8100 https://linux-hardware.org/?computer=AFB6C0BF7934

All 4 hw revisions of the LattePanda board have "S70CR" in their BIOS
version DMI strings:

DF-BI-7-S70CR100-*
DF-BI-7-S70CR110-*
DF-BI-7-S70CR200-*
LP-BS-7-S70CR700-*

See e.g. https://linux-hardware.org/?computer=D98250A817C0

Add a partial (non exact) DMI match on this string to make the LattePanda
board DMI match more precise to avoid false-positive matches.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://msgid.link/r/20240211212736.179605-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7dc80183921ed..bc08f920a0d25 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3771,6 +3771,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		  DMI_EXACT_MATCH(DMI_BOARD_VERSION, "Default string"),
+		  /*
+		   * Above strings are too generic, LattePanda BIOS versions for
+		   * all 4 hw revisions are:
+		   * DF-BI-7-S70CR100-*
+		   * DF-BI-7-S70CR110-*
+		   * DF-BI-7-S70CR200-*
+		   * LP-BS-7-S70CR700-*
+		   * Do a partial match for S70CR to avoid false positive matches.
+		   */
+		  DMI_MATCH(DMI_BIOS_VERSION, "S70CR"),
 		},
 		.driver_data = (void *)&lattepanda_board_platform_data,
 	},
-- 
2.43.0


