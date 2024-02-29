Return-Path: <linux-kernel+bounces-87011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D850686CE39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F131C21617
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93960156D3F;
	Thu, 29 Feb 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRUTkNAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45C156D22;
	Thu, 29 Feb 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221862; cv=none; b=rGqi5VB70Knj4pdRwAQQZfeUo+5uKkno2qZGYmvGpxs5x+k22xAASYDiPgz45NJ+BO3I+T90yYiC3IPqpc0yYD/WUTxiZtmM1wQ0wooeR9PM50ARd4G8i9tv2vJTc3Uva4wcQ7/YgXlOV47xvJV5IfV5UxIfGzNYneJ6BHm/za4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221862; c=relaxed/simple;
	bh=1aBbQYkEyYRbxRaz5vqMjWCkJLAVVwIEVE4jU/Fyqt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNpaYJzjO2A2HKY2TIAN334QVyWvBY1sR2m/DQAzAFzwkEJ/x9ZGAS5Lur4EU5uTqHWzY/f/DroKsP80oC9+5E/SOpUD/YE0CywLIB6737ZCjSvRPuAzgtE5f+pXh6CFfCJk1tyqJ8q1BZ8EsecZHOMCSdvQ8QuUOr8j5rIc3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRUTkNAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ABBC433B1;
	Thu, 29 Feb 2024 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221862;
	bh=1aBbQYkEyYRbxRaz5vqMjWCkJLAVVwIEVE4jU/Fyqt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRUTkNAPVBwWUs+j/VBs4JLB6fVhfNjack0vSqm+ce9OjEzivGADIkgp579XoYukW
	 4ZJrV5WkymriIuyhi+SZJv5TsKK5EzjDEdTHbQOhGbC01au20ix1+OpZo0vDvaGjNE
	 /Gya3v3xSzFgRbGNEzWqAVHm14ZNBQO3bVru36+Q4T13l3It8bhndd0UA6y1fc6SgC
	 ZZ3zASPpm2wTLMrN1BhU9S5DOe/TgLE7T10UrfJGLGnHs19HyjQYKM5mhFQgxcT/zX
	 YCWm1vO2cLJhM2VrDj6R0Tl/K8doIYSitTa8vjpic21VlfkWvgM1KW5aV3CJG7HCLO
	 +unIFML4AF76g==
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
Subject: [PATCH AUTOSEL 5.15 3/7] ASoC: rt5645: Make LattePanda board DMI match more precise
Date: Thu, 29 Feb 2024 10:50:52 -0500
Message-ID: <20240229155057.2850873-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155057.2850873-1-sashal@kernel.org>
References: <20240229155057.2850873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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
index 2fdfec5051926..1e940da4414c9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3802,6 +3802,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
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


