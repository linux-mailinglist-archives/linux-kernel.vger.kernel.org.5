Return-Path: <linux-kernel+bounces-33413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914D836964
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880281C23F29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B907FBC9;
	Mon, 22 Jan 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C78JlUop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED77FBBA;
	Mon, 22 Jan 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936225; cv=none; b=uNLNZrEiEZid1CnHP/j5QsEF7YRpI7KIi35CWs5ujXVfxSftyuk/OlP4i/dZwcASetyXl+EAuZ2ZjkJm6Yjbos5U8ZL86K7O8S2VNqW6LiNU4af0lPEh8FEYUR5k9boj4hJz6stDSm7oQHS8L2AdpxAZoY85JdIHawej/7h9vM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936225; c=relaxed/simple;
	bh=kVIYlOYLVqalaQnOMDEKOJ+nnyTguATuIPG6OEDzO/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3UUduwof3l+VfblTWYmIKlKpqqR6Yj+imNeeQk4y7saZFVlj6EyjgHr4v6Dx2+S9m/+TtZhDjSfHuLFobAMqjQlb0dpgfbtMKUzBS4zy9r1Awyr/jaKzExsgNMLYeBk0iklFzXcpRsLjWQSBearJFa1EZKE2pv/yE9HxTy+q24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C78JlUop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB761C433F1;
	Mon, 22 Jan 2024 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936225;
	bh=kVIYlOYLVqalaQnOMDEKOJ+nnyTguATuIPG6OEDzO/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C78JlUopUZJVkiya0fRTqslYfZy8soxwCwUvpxZxcDfMLp27X6nABG3M5+ssGHmeX
	 dbo9CMRMlgclVvL02yfA7x5rPFAna0cmjdJPPQLHINwQ6g47uCIU58RxAcGi090u76
	 Xujvg1j98fSUQ04nxjW+wFj5cnFLhIAK8qoovVHBr+EM4vVHvNAST8onRSdxw4vFX/
	 NBO4H20YOjbM8AmxEOF6JG9CsUcdoJu2v5EINUO8GGyF7lpKLqePWVMgGMPcLX18AX
	 quYKwY0iXkM3PVEMO4hdxiuoYB2jUeeyIoY5pCCWCC1UvnzhP6XucI6x0mE3b4kol3
	 YjBdgjOr2lomQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	posteuca@mutex.one,
	Vijendar.Mukunda@amd.com,
	cristian.ciocaltea@collabora.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/53] ASoC: amd: Add new dmi entries for acp5x platform
Date: Mon, 22 Jan 2024 10:08:14 -0500
Message-ID: <20240122150949.994249-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 0932473b6394..9ee71a99a087 100644
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
@@ -35,6 +35,19 @@ static const struct config_entry config_table[] = {
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


