Return-Path: <linux-kernel+bounces-99394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250F8787C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066D01F24DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76035F475;
	Mon, 11 Mar 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRNoJKao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A55F466;
	Mon, 11 Mar 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182282; cv=none; b=KNcqVGQKkpPsNF702zAryTfCjQTihXlzHCbPeyjhlC1XFg3FwnmIr3xDtf8wU85+Ur+DVZYniH6nO+/SWtgK9lAcMWsXROuU1HPE5K+6kBCYft15XeirFkrUIGytZedQ4EX940rsyHa/9V33f+Lh7iXNZi662fVCa5Xc2frt5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182282; c=relaxed/simple;
	bh=y5PTPZ8gniX4MbpvGANx/OZzRS4utU/V31kCwdYd9ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0wubOr1i5Wus4SFc7VB1CHa8sVaSDA3ENRLeGObXKaDmZvlR4Ifjswm6L4w3TXnVw46rOaQsN1ZY3BvYJOAKj3qXFGvIGtlJTzARSnW4PTWAFIjUu6cNKtzzn4ND9ayyRW3NZ81EQgQhyiyxATkcig7MkrC22f3IqlWp4rzw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRNoJKao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E122CC433B1;
	Mon, 11 Mar 2024 18:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182282;
	bh=y5PTPZ8gniX4MbpvGANx/OZzRS4utU/V31kCwdYd9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRNoJKaou9yD8Au+Zd2EcPGlfMcwPy1WFB5iXAYl78lBe/nuRBJQSm0kGTGqQ4tfX
	 tUK/ye7HfUA2Rd1QK6gcXODfvWznqkWu1Y+NZFkRNUr7g9ULNlI8TET4P6lkVtlMqk
	 W8e309ww2dsU1ZaV1y8Vuwvdy4b5CCLMb1MjQg2e9Ec7cIFT8Z4hqVUqGVPJt8EPgm
	 H6kcr7eXWLaGw90nMJzvRfHAghBMUBkl9F49tgDNS9bxWUxS/RK9sLvYEG4KzCpFI/
	 76VJlt+wEqUDfnc4u3/xgL8p9n/3pMFe0aDoVjAeEzWiIB9E7hjXOEUfsXGTXPrS/x
	 14bba18dxG5eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Raj Hassain <alrajhassain@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.6 06/12] ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table
Date: Mon, 11 Mar 2024 14:37:20 -0400
Message-ID: <20240311183727.328187-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
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

From: Al Raj Hassain <alrajhassain@gmail.com>

[ Upstream commit b3a51137607cee7c814cd3a75d96f78b9ee1dc1f ]

The HP Pavilion Aero Laptop 13-be2xxx(8BD6) requires a quirk entry for its internal microphone to function.

Signed-off-by: Al Raj Hassain <alrajhassain@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://msgid.link/r/20240304103924.13673-1-alrajhassain@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 80ad60d485ea0..ea9512efa6fa5 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -395,6 +395,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8BD6"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


