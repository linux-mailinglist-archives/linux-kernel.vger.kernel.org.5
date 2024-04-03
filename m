Return-Path: <linux-kernel+bounces-130293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3689767C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A381C2974A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5F157E6E;
	Wed,  3 Apr 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHvQg2o7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184F157A7F;
	Wed,  3 Apr 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164658; cv=none; b=Gz5nKmrkIu/5TC89lnvnadYyznHnKAa4gAI6mkNn75l+/H0SuGxbGalPmWg/C2lgGl+59nB4ECsKuIg5yKuPCUH76mQP9cvtCTHQYzhduAlUmTQfQzO6yZecl90tdAgPjmIWGjSpWWkuLdQ4VxX38J87VnmZUr9DIRNsu/Y9LO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164658; c=relaxed/simple;
	bh=14ju8kaKPiLMQuaNs8+sYRsrdQWfGeWHA+5ZkSs0iKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMVn8px+YproLDEqu5nNGruBH6lWWgLMohMDhhON8KzNG8Rq+gCGkwMwKO/+stGYbh23K7jHeAPk3CVObMmmBTQUy82LaaLtAoqzdZgbBEuua/S5+uFSe+AsBfRjgh7EvRpel8lct6Zbh2ViqEukE0a+SYfMeIdGo3thl0jahwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHvQg2o7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D3FC433C7;
	Wed,  3 Apr 2024 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164658;
	bh=14ju8kaKPiLMQuaNs8+sYRsrdQWfGeWHA+5ZkSs0iKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHvQg2o7lFrc9aOyWsqM6T/xiO7Q0i6IyZZ61FT9NTcuJbqqTjIvMN0viMNMFXWu1
	 EOqFA/YKQ4tuRuVmNwrv0LmOHgAINSQ+prWDfem17dZHY94n7+jhubt3zjgkor/bri
	 lon4rBEcKwl1HQHU9l06WnhjjCXxxZPDC1zSzMRspH7K7h0N1CnH6kBBq541R/QSsI
	 SKG6za1NOLyi5MUbVnpdw0ishugeE7SyE2ART1D2cqCWQyR1cvXJUDLyOqhnXu6Rtd
	 /WYhjBORWUdB2sCyG8KtCMDCKiCGqEUQhpdPlcCVLOBckiX6R+5+ncdaoMVR+7hBTr
	 KZ54DSt9pePxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 19/28] ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"
Date: Wed,  3 Apr 2024 13:16:21 -0400
Message-ID: <20240403171656.335224-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Jiawei Wang <me@jwang.link>

[ Upstream commit 861b3415e4dee06cc00cd1754808a7827b9105bf ]

This reverts commit ed00a6945dc32462c2d3744a3518d2316da66fcc,
which added a quirk entry to enable the Yellow Carp (YC)
driver for the Lenovo 21J2 laptop.

Although the microphone functioned with the YC driver, it
resulted in incorrect driver usage. The Lenovo 21J2 is not a
Yellow Carp platform, but a Pink Sardine platform, which
already has an upstreamed driver.

The microphone on the Lenovo 21J2 operates correctly with the
CONFIG_SND_SOC_AMD_PS flag enabled and does not require the
quirk entry. So this patch removes the quirk entry.

Thanks to Mukunda Vijendar [1] for pointing this out.

Link: https://lore.kernel.org/linux-sound/023092e1-689c-4b00-b93f-4092c3724fb6@amd.com/ [1]

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://lore.kernel.org/linux-sound/023092e1-689c-4b00-b93f-4092c3724fb6@amd.com/ [1]
Link: https://msgid.link/r/20240313015853.3573242-2-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1ab69a53174e6..69c68d8e7a6b5 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,13 +199,6 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
-		}
-	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


