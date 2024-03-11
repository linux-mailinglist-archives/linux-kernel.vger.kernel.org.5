Return-Path: <linux-kernel+bounces-99382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C8878797
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA82867C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098258AC1;
	Mon, 11 Mar 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIT3Lwdp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8758AA6;
	Mon, 11 Mar 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182220; cv=none; b=otS3v+XK8QU4+SAuHJuj5VYvYHzwekvKO5xq6CMz4oNKhtpyilBEebf5df9menct47KYxQw/8avtH4OoihJkYwnALFyfdQXQOuUdTi/sV4t5jSJ/bEpMOXapEHsNCHHTx72a3sydtAFWTp6oTEdtwqqC8G+YVk4knET5nwHpvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182220; c=relaxed/simple;
	bh=y5PTPZ8gniX4MbpvGANx/OZzRS4utU/V31kCwdYd9ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuUNmJqkYb9NZib22HTGYS71Z/cIXuXAK/vl1DTwE9cvEupbWmGKj1X75BxqH2J0aW2PYtIDX8VzYfTMKBrqZPGQyr5UMY1KvNQWt29FjXw5rN1qY0aYgjPUkkUFc3at31b6dUBNkfNybII0hJdfT7I7nxSv732Se5UE7MjWieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIT3Lwdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EDBC43601;
	Mon, 11 Mar 2024 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182220;
	bh=y5PTPZ8gniX4MbpvGANx/OZzRS4utU/V31kCwdYd9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIT3LwdpdEd9X056SIs103POySCMGDQ5vLBqC6ZmXitjIGhgKCzAPGM0zIDkQCp08
	 /ORqChAkghgHipeq3TEzYfudm+yC4AE6JZk9RfGP2MreFCgEpRX3wQ9rnS5qpUbZR2
	 8xIUahbw0KkDCcix8tUAvpC1n2k2QmDx7+J2l1cnJ27aEpuOg7brFHMHWMEL/tPHws
	 rGRY7FOGfSnybqsh6WFpeaADFjp+WqZz0eksv0FUS120h5w6R9FIfAPqkcS8zSdYMW
	 D2TosHAEe8ytdJ/iWjhJLsYW96lI87r5sK7zuPBs62gG3eBV9+2Xa+cYvoWYzEg3qi
	 N7M/LXs1y7Z1A==
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
Subject: [PATCH AUTOSEL 6.7 08/14] ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table
Date: Mon, 11 Mar 2024 14:36:11 -0400
Message-ID: <20240311183618.327694-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
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


