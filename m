Return-Path: <linux-kernel+bounces-33230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A248366D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ECB28B713
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007F3DB9C;
	Mon, 22 Jan 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0FTl3v/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AE4B5C8;
	Mon, 22 Jan 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935413; cv=none; b=Tn4YR9rCQblpdMqHXt5WpnpPHfp7PJSRzr8I0VndSfuHhsCrZmQy/N+PVjKsfKKmOuV3obP0tx4aRw2kWo4OaEwdEQ9/WBly3QS84hcVRkEyfL3btg+/cTI41IfSyAdsYzwmZpgY1GBf8zYD36yfr7p9PF3fmsLFeaz/GHGTHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935413; c=relaxed/simple;
	bh=QKDGJiDIBub2/mUyIE0u++Y6msmlrtpCaas4Ze4FJno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyKZliUDa/2jip259cF2I+c57UrgSl9Sh0sKXGScByNjnU1sfEVicP8jlpiqozy+kMeP9G90HfsrSfIcwBWuFSxuWLf7MFJKzqFzQQqTpZlMlIhnqO6GXWRASk7nj57oRNJu+X7mwF7ig6s7s9I5mC5dJOTBBgxTm4/S6F0Ytpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0FTl3v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF19BC43390;
	Mon, 22 Jan 2024 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935413;
	bh=QKDGJiDIBub2/mUyIE0u++Y6msmlrtpCaas4Ze4FJno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0FTl3v/yHxSqcvAR8KjFfBklMs9g79uNk2wL/Xce8WHLYlx6pawhWUMf91QHnoWs
	 UAWoCg/paMnZCV1HEzkeFwUnLToehNe8ITkErR9Nj6pIbSwM0lYk/q+bbxl1EndzFj
	 BbrHJjumCNgqV5txGutKF+Z3wrjJBg/wJPsFJQSfX4UQFGY7i2GGrkNpULbVky3gwg
	 EJs3qgCtOkr3G0qGu7o9do6w3Hgj3ilZK6+Fh/ABHP/2+zMjh5ERYttYyCQwUOOdXl
	 GZMXB5vf9Xi+jOWt3jX8hW6bM51kxJRyf+TPB4OwoIoZKvW2mrJJ6gLqyVkQ30H6AI
	 pq6I/23swO1dg==
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
	cristian.ciocaltea@collabora.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 16/88] ASoC: amd: Add new dmi entries for acp5x platform
Date: Mon, 22 Jan 2024 09:50:49 -0500
Message-ID: <20240122145608.990137-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 3bc4b2e41650..dea6d367b9e8 100644
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


