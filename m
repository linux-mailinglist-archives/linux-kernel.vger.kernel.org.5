Return-Path: <linux-kernel+bounces-99060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206988782FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED3F1F24AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763A52F7A;
	Mon, 11 Mar 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJfTE2uw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E7524AF;
	Mon, 11 Mar 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169964; cv=none; b=UA4Zh0GIVMipfVqjP5lDb2ODtcIihe0OspJw3pqzkfiyWpB0cr3Szyl0HirT+YGtXRO5J8CLIZFAOAmOT2VO9o6I1ObspRJ1C09rc0JGI0UFt9EpzykyIWHsQodxtzn4bFco0VWSXDMrEtW0tDAOxGCaULEpHynf1NiWiRDrdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169964; c=relaxed/simple;
	bh=l/Bd3krpOcAVTkApY/kXI+PTs5uv+u9Z0EBakS4REvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc0Jja3OwW5KWnM2UBBPiKgkif3ivNwKIao1iR3aYlt8IZvvWg65TrezQLt1Xos+GccuOfvUzFY+b8KR1DUlXy5IZEpMcMrBlPSIYXv07h9DYMqs6QQHmbGuBtrxNgiVQPQAY6R53qxZ5eP2lRf9H1iKVO9QrYaudpPp8klHw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJfTE2uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98977C43330;
	Mon, 11 Mar 2024 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169963;
	bh=l/Bd3krpOcAVTkApY/kXI+PTs5uv+u9Z0EBakS4REvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJfTE2uwgpV6yJc2zA/Dh9rSWJvmFDR5Ltdd+qVNpfpBMLRlZop5GVpc4Am1e2t/C
	 wgYB2l70YU+FMZkh6Y518Hi4JDq5mgHdjUDuhzIz5bCKa0wqcwRL0GTAwiHHlGHzXS
	 RW5AHUwpyPE7cTJtIvXw55r61Ymr7+Hg1qmW6M7XdXL0b4c1TU/bGq5dwNk3dWX7QD
	 IJH8t8huRtfqoxJArF28voScms5qSXK5ZHQcPs5RiTvrIi4O9iYHCSMC34dcXYxbMZ
	 3+N6yH5xRo+s61qyhOWqZG7FCwqv55sBeSwqYtbxU/AZ0qlL/xJ0wVO4xo0MPsyGfD
	 PCrL8P6NRY3aA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johnny Hsieh <mnixry@outlook.com>,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	jeremy@system76.com,
	git@augustwikerfors.se
Subject: [PATCH AUTOSEL 6.7 12/23] ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table
Date: Mon, 11 Mar 2024 11:11:52 -0400
Message-ID: <20240311151217.317068-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Johnny Hsieh <mnixry@outlook.com>

[ Upstream commit 50ee641643dd0f46702e9a99354398196e1734c2 ]

This patch adds Lenovo 21J0 (ThinkBook 16 G5+ ARP) to the DMI quirks table
to enable internal microphone array.

Cc: linux-sound@vger.kernel.org
Signed-off-by: Johnny Hsieh <mnixry@outlook.com>
Link: https://msgid.link/r/TYSPR04MB8429D62DFDB6727866ECF1DEC55A2@TYSPR04MB8429.apcprd04.prod.outlook.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 80ad60d485ea0..17c8ff7558694 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J0"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


