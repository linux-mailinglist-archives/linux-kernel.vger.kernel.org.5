Return-Path: <linux-kernel+bounces-115308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E318893A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81231C2E804
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900AA1D5F94;
	Mon, 25 Mar 2024 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpNYx5ku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5B482FA;
	Sun, 24 Mar 2024 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320500; cv=none; b=bFzi2s8v0khdiVoLAVjaak0KNgNU8Cj24EqOYK0Y2gkUwfFkJWyW0yZ1XxihHtrjGdz5B/Y1+jCrlZ76abh7rqzrzkLEHvJ622UTKmkQzQ0hzxUHfEHoewTOTWVFY/nXQf/Joo0mUUAwZSsexqO7RCmqz3hZ9p/3cE7N41QJkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320500; c=relaxed/simple;
	bh=oZM8KMIQOEe1NkhuP82yx6UpYRUZXW+a3NEGlch/gKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkpOSE3w7r+slzTZBTrkSWgVzSDNHyKu0zAz2WjmDfzBJK63PFW5uV+RtqO8BMVFC62CrbuPB0COv1s3AmbMjTbw5RuYgv2lThU/e8JX6RE0Uwqk7KeiXY9aNN1HnpSor8QWsRjSxjlZfZ/vMfJLziL45ehaoOW6udfn9N55QnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpNYx5ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0065DC433F1;
	Sun, 24 Mar 2024 22:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320499;
	bh=oZM8KMIQOEe1NkhuP82yx6UpYRUZXW+a3NEGlch/gKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpNYx5kuJwyRxVvFzvkGMT1mM1N2Qnfx6NI3PQ6yD3tcVZn46vtLZkwO9kZ6jMprD
	 WPAb1WDAqy+Bf4pI5srCkZ7z++/DkWBnSvdw+XSqDkhLsnL8BUV01WpISgBoIzvOQa
	 eKj6ezZUZ8DGU9GRbCHyGRadeSf0UicuqNi4jPVooOCn4UY9jsYoERrN513WErcPUF
	 fTKZ0WUU5Q3daPIgz0UWfm4AP8myQ5uNhiWM5pjypjUPR8vxSHSduxBhpFd3EmuYiK
	 K/5l3Vl7iD+M1GFkezD0rzN9XXwJOxrQluY0OGDUAzU4M6fhBu4RmbE6xI6I22eWEy
	 jDrJTROqL0rvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johnny Hsieh <mnixry@outlook.com>,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 059/713] ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table
Date: Sun, 24 Mar 2024 18:36:25 -0400
Message-ID: <20240324224720.1345309-60-sashal@kernel.org>
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
index cc231185d72c3..5587198751daa 100644
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


