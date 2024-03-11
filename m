Return-Path: <linux-kernel+bounces-99096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4D878365
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0307283F66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA3481A6;
	Mon, 11 Mar 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iESaQPXn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F74629E1;
	Mon, 11 Mar 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170045; cv=none; b=ciYPcabFf3vUcZopStWE+9Sb4r/0wDVE++glmul+WBUideaXHdbPd2zPFDPWljFYk9zzSAf1XXjHs08CmBwfLxWGvO3vDzxkl5PPFJv6BYWX5DAeE5TfjrlDPxz6uGFmB65xwJ7jJXbftlkQFlUX5pSfEqOKAaX1Wy+gVetbGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170045; c=relaxed/simple;
	bh=Blrg69C+BiV8sx9Bnm8HgGPDsdyIz8dKCm4eySND/KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg9lGXGNk8gc4pu7bP0nCWW8pE0V0x//9och3mMzlvDLms50wAX14/CzFTKzj6w8O0Midgw+qABiR+BydU7zmTuHn2d79hkeCRUa912B5cSJ9Xut3ZC2Bg3HXBuyv+KLtbJC0yrkEQNLgVI5vn7Dyp37NPagVc93SlYKo6vi1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iESaQPXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AA4C433C7;
	Mon, 11 Mar 2024 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170044;
	bh=Blrg69C+BiV8sx9Bnm8HgGPDsdyIz8dKCm4eySND/KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iESaQPXnPbYc9P95AWUNrcP8OL36nOtR0JXDvY+whSdxSb5rLnGZD/8kHjdrR4usA
	 EBwUBykBnoIlhy2m4KE/0qZwwYToaLalK56kueKL4ScRVzIk9BPoyPNKtbj/3Gu9/+
	 1EeyFM/xgP+h6kWQyp93Jjy4YJdx4xuitszHjjwMSK4BeJmRaM4Zx1lNz7vX/WYxDK
	 uDWzHbvt5VuMxWbsTwt/1WgWDww+xivszZ9rP/O6qYlixqIR5W7zjtTUWvghSML80l
	 5gt7OUVswd43e2CZgFn2HlB8T3H/HgnNcGEJPN2IN3Tr6WRayDwUF3g6ww3qHBD8bc
	 JCfFDFA+5n3tQ==
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
Subject: [PATCH AUTOSEL 6.1 05/13] ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table
Date: Mon, 11 Mar 2024 11:13:40 -0400
Message-ID: <20240311151354.318293-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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
index 28da4e1858d7e..59f72bfec8e1b 100644
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


