Return-Path: <linux-kernel+bounces-114056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5E888823
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145122873AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2CB2310D2;
	Sun, 24 Mar 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPW25/jv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DA1FDB39;
	Sun, 24 Mar 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321337; cv=none; b=K2tlUaX0zwDRG3wUYoLuCA1EUmnKZ8+Zjui3SHPZIh4HCyE1fYdZZ/Si/BV019NligLmr3EAQ6NPMymmkOovt9yG51RIVBJi7+PFSY/tsiifu535mFIP2qP+GpEOyagFkuUpOu4M76OK4YeI0c0vhM8LG8a4djbNA9+aOLEMHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321337; c=relaxed/simple;
	bh=aDa8LlvKm/2ZXeeUmHNzrvWDnXaqmsLoBFx0k0dXmCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTJ/j228Y8hWg89rB5OpTEEsGhn+J1X8K3Syf8ilvwvViknf0w42gbun8kZp7Pl23lpZzjAHX1A7gbc+vDbcJxDBFlKdWwXywFSdLEGmmeeMhUknzmtbKC3dziWv6V8nYQ4rtXFjQ2wotizw6HPtPPv2Y1sXR76MG17SDVuhDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPW25/jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E1C433F1;
	Sun, 24 Mar 2024 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321336;
	bh=aDa8LlvKm/2ZXeeUmHNzrvWDnXaqmsLoBFx0k0dXmCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPW25/jvkQjdBnEPAGS00Erb39CMfwnG0CHBX6hCqjiaLoFxkEFPrH+Lbsi6qOodt
	 TtfqqnwXJGEuB/Y40Qvu7YGpIWOW7ZvKlhcf9XnmVhYgdRxZahHOGg4yA9GOdm/8VK
	 OYU7qtc+QQhyIqphBlA8bP/euOhVSnCdzP6CBBzz5Yq8hxfLt/8YL+jc2d/1mwvIeR
	 isBoJ1cfpJBZ/I0CvH+0ONZ32VCNaD2DofTZO1pYGJOkzAPFRn/hfRY3W1tNq1bpEn
	 Y7NXIlLJgCgqBfpyFfpy2iaxmD7fzAdlWxrdUmTFzZQsTec4X4+PDt2o5aIyvC3yGa
	 dlIwuQ9/dBdWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Raj Hassain <alrajhassain@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 060/638] ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table
Date: Sun, 24 Mar 2024 18:51:37 -0400
Message-ID: <20240324230116.1348576-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


