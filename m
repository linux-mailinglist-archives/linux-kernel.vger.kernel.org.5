Return-Path: <linux-kernel+bounces-33335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C911836881
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BD02855B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8194627F3;
	Mon, 22 Jan 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekgC1HhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128216169C;
	Mon, 22 Jan 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935911; cv=none; b=egwIxe6hNDZdmtNwh+mjb7g/0fkFrub4/JrFu8GZZIWk+rVLF2QMIvnz5VYQbupD+HY7xiiXF2Na7LSA+fIE+g0HETzsM0OBZrhS5jC5rMUpCQzTIivc7QjYwtqfuD7RR/eoRq23tGiVf8axwgmGbIoYyy3oUO9kd0nCp6GoSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935911; c=relaxed/simple;
	bh=4WsiqzmZCalFFQa5mWmmulVG52SGUVu9YnuJ4R0nN1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vicn9IO3WPBctqeHoic4am3jOvcxLPBPrUCe+NPsIDNUaFb/wtUSwvXuT5P7vqWe/5rBQFb6s94WFp8zkKTFV0Sj8AFdazJab2Z4tJZg1KCvKAcDikJlwJrgj+XB84LN6ZlnkfXfzRqccEDrrCX1lNXCMw1qV8wnnx21uBcYmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekgC1HhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61887C43394;
	Mon, 22 Jan 2024 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935910;
	bh=4WsiqzmZCalFFQa5mWmmulVG52SGUVu9YnuJ4R0nN1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekgC1HhCyLDRcZmuEcLMHZL9GJxToK9Gj0I8BLEP+8sRpdF0BDX3JTs7mwigh/ed+
	 BJrfzm/pK50mm5IpwYeuD4fo2xHaA6sp/UeVIUckrR0CylF8AyK7cRNcq27e+XaAR7
	 Z6oaUaW86M+CQfTfeiHlwnVtWBjXCftmGf+1BUtrrhWfuT635LobhTN8jxiRODJgrK
	 Fvjxr+D/bytohM8lOVw04CpkeILOO1xmtVLUR5G30sf29/DaTO84esJ8wLHWSw28Ca
	 HeZn22vS+nDbA5vsYB33vlvrLGVrCDUjXzdbCeyuM9g43/W8uYwGWhWrFq3OOP8KYQ
	 0DGlf+248DCoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Vijendar.Mukunda@amd.com,
	posteuca@mutex.one,
	emil.velikov@collabora.com,
	cristian.ciocaltea@collabora.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/73] ASoC: amd: Add new dmi entries for acp5x platform
Date: Mon, 22 Jan 2024 10:01:28 -0500
Message-ID: <20240122150432.992458-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit c3ab23a10771bbe06300e5374efa809789c65455 ]

Add sys_vendor and product_name dmi entries for acp5x platform.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://lore.kernel.org/r/20231206110620.1695591-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index f27c27580009..955145448c23 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license. When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2021 Advanced Micro Devices, Inc.
+// Copyright(c) 2021, 2023 Advanced Micro Devices, Inc.
 //
 // Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
 //
@@ -47,6 +47,19 @@ static const struct config_entry config_table[] = {
 			{}
 		},
 	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+					DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+				},
+			},
+			{}
+		},
+	},
 	{
 		.flags = FLAG_AMD_SOF,
 		.device = ACP_PCI_DEV_ID,
-- 
2.43.0


