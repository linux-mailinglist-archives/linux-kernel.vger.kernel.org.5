Return-Path: <linux-kernel+bounces-115310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F10889A97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308D51F334CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743051D8DCF;
	Mon, 25 Mar 2024 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKDfpw/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AC80632;
	Sun, 24 Mar 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320514; cv=none; b=OclBjzXTQ9Y8yxWn7BK/7VmRx/twPpI+AozsFBmmeNS2jBqL69K9cMITX6aPyYb1TeKQ4Im/jBtH5s8pVOyNK97FzUh/Ri5sL019RqKzac1Ol7z8H7e2hMQjfkiRQBFs8tljY8XZu6sVmhiCnX802kP7CISR2ZbISeDmtWMzONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320514; c=relaxed/simple;
	bh=aDa8LlvKm/2ZXeeUmHNzrvWDnXaqmsLoBFx0k0dXmCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndbSVuoia0Iy5fTX1//lCCtZXT7seiM0KqfmDHwBGP8t1KWGxQHS/Q7edL4etEwA7joGdh6HNiSq1fnBBiXkDmMOZyVlE63FF+MZg5aau+/CKqBvBt0r1U8JTTINLuWbvX70ZovNlXiYYwZY4467mg85pq8aiMuwpH0tLDyO3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKDfpw/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FABC433F1;
	Sun, 24 Mar 2024 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320513;
	bh=aDa8LlvKm/2ZXeeUmHNzrvWDnXaqmsLoBFx0k0dXmCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKDfpw/hZgVc2nayIouybOhHSQibMyL5SvELwINtJNpESipW69yIaXQ0IMH1qHqLe
	 zqXank+WMm+KVIKvhqqxJDqINyzTAHRFIeayqtNj3Z5h79vVIx/0TuGMYhCmS1Kn3E
	 qebSIqJmnlro/akJvx2TcKudexNuaLVRPZM00HIjBGTU4lADrvuSYFvTFL3+x6TzTK
	 EjYGYsDuk8MAqcu0wECE3/oiAV/ZiwTLEf8XCgVIoA4KZILqSqBIFaCwhRiD9VzxdK
	 zwOuOYAN+vPRvPatliPaOEKfHy0a8XFTOvgxaeOMqNGWM9oPVH/K0N419A1PoG8rNs
	 sqfQhoFg5VePQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Raj Hassain <alrajhassain@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 074/713] ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table
Date: Sun, 24 Mar 2024 18:36:40 -0400
Message-ID: <20240324224720.1345309-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index abb9589b8477c..90360f8b3e81b 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -416,6 +416,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
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


