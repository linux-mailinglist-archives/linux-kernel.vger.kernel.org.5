Return-Path: <linux-kernel+bounces-99081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11FB87833A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1A71F270F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AA5F473;
	Mon, 11 Mar 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgBkeELP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7575EE97;
	Mon, 11 Mar 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170007; cv=none; b=Z2Fp46ESMLlO56rBZcPBTBKEEsEYyPrxUn7iSnOAXnIQMW7AQa5MhWgXIktHFrs3IPlPVn2D+1NIsgZyImBlO5sWG31mnM6UgLMuMV73X9bzpnM41T6iWPMzVZ9DzRtRqQFKPc5bTG+aIYm82Ie+/wkYlOsABv9R2H5CfGyZUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170007; c=relaxed/simple;
	bh=l/Bd3krpOcAVTkApY/kXI+PTs5uv+u9Z0EBakS4REvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtCBSXqfRzvr3VojZc5kWIMs5u44dR7QcbrvJnrvYpZ1m4JG0gFjws1f99n1GLrzRPKLGk8836+eRH/9rFRQKZBafOq2lfjJtH+jGazHs0WBB1Dp+tcWumLr65kX5HLzBjj2NSWYpB0W7OdeQc7W53Lq1TyQTH6nju1fqHjsU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgBkeELP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE042C43394;
	Mon, 11 Mar 2024 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170007;
	bh=l/Bd3krpOcAVTkApY/kXI+PTs5uv+u9Z0EBakS4REvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgBkeELPhcLraOKKj94cX4rNA0WIpkRf4HZYNl8ERHzeJt6pQjX6bo8BWzA8X/TpT
	 /X1MjMbejIOCQejGgu5VsAdlvm6OV/SEhc54wdXWYGokprvM4z1dFPbEPrSMfgoIlB
	 yBu+s8aiLups+SVrH6ds6pwPkzPnVjyGcVRFtrHBsqEjd+iyjgBBco9utvUOEQIro2
	 P39ej9hTDH15jhpUF2lm/YIi85yfA+EchkNoC4VGG3t/8Mceicy0DTFk11DAfJWE7M
	 hAuXZf7t9XeeArR7DJVwUUDM/fsXpwYim5XdFu0UjqNCebBk7OLbrz+Ma3VHqTuh+K
	 gdAFiFaOes6vA==
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
Subject: [PATCH AUTOSEL 6.6 07/17] ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table
Date: Mon, 11 Mar 2024 11:12:58 -0400
Message-ID: <20240311151314.317776-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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


