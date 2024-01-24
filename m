Return-Path: <linux-kernel+bounces-37150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7B83AC12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C6E1C20F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B012C527;
	Wed, 24 Jan 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq2knoRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BB12C549;
	Wed, 24 Jan 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106611; cv=none; b=mSH4nonx8QlWBhd/Nmif7IWkgbmlUWlrJsW+/mK522U2CjsETk1WAZ6+695Vy+zfinBkbjw8oRlVfNT3ijMSOCC67s11LkGcUc+1wo93/RV7+iEq9FwfUkMQniALUvh0OyHuGD8z2BNxlR8zcoATMe2L4cy+7QOA32Bhe6jzH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106611; c=relaxed/simple;
	bh=/ZOKt8q62n+xcJ9/BHJPf2N1L0ZW8oatoN1gijTh1do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7OXE9DrPESb2WghiypogIQTzEx7gTXn8l8aQFFWdc0NHnx+29GGs4Rna7+I8Ls8IC6hVUXRx9a6yk0is/zDUcfbWVToxa59fSvC0FL1wLdnEb0a+LGLuWJOiUhXY+kTM/8fAhRorhzyWIUOPcdUUKrMjl8FwP8jJ9j4Kyc8M1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq2knoRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F0C43390;
	Wed, 24 Jan 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106610;
	bh=/ZOKt8q62n+xcJ9/BHJPf2N1L0ZW8oatoN1gijTh1do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bq2knoRcZGlDS878akC2tHQX0xp54q7JD/2ga+Nq26LKDECwyue9+PyDVK6avav7z
	 9UTYpOzivmD5kGBuLwXIaWyhfuVkl1wJaVBJh6/1cmrvz1LNspDvF3CqJ3QrOQA1h5
	 2y/KziiGOloWHdXZdh9F/rndhAKTKZPhwU7sJ6gQ+zdbAxCwhZblDgWeveYH4dpd15
	 UEOBqzEEYS7NFTYLyhOd48IP0VoJXG8LUhf0zE8LfgUspesh6oDO3EJ70jP3v40wm+
	 7v7rpe2Rls8CRKyC4OeKk5rOM4jWljurmFbotClXJqemI9JMVn4wrbROrKxehs+zr4
	 aHQ4pUtQxmoXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 8/9] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:29:38 -0500
Message-ID: <20240124142949.1283818-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142949.1283818-1-sashal@kernel.org>
References: <20240124142949.1283818-1-sashal@kernel.org>
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

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 284d16c456e5d4b143f375b8ccc4038ab3f4ee0f ]

The ti_am335x_tscadc is specific to some TI SoCs, update
the dependencies for those SoCs and compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Link: https://lore.kernel.org/r/20231220155643.445849-1-pbrobinson@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 9da8235cb690..43cb511fd8ba 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1440,6 +1440,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0


