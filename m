Return-Path: <linux-kernel+bounces-124879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6395891D63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610271F26B87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88820FA92;
	Fri, 29 Mar 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeB6x4oC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8E204054;
	Fri, 29 Mar 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716333; cv=none; b=MXupMkjXp4t260Tftrm6UL4WM2D//IzFF7MZZMLhOuywzL7Av1WPwQNwphXhkpfjcGPJMucCjhI9SXxu9tRjArSdrpooNsYGYTjtWQeMLIAqp1uNPyt0mYIdHVJMCGRGsOepTuVzPeHeCJ9qPyzr4TmzPgcRg8uuoR3grDpPB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716333; c=relaxed/simple;
	bh=3o/CuBphMJvJQCkiYuvD/itep/WB5d2yyRYl8PtwFWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7WYAwyD0PH0eOJeOFyZ/OnplQyIepepnCMshmmsRL1+MehOhXcSJW2/oQdUxXef9Wcz8mp5UnN/mnTR2Pmlq0sM1oPbvJKAxlzm2aVC/J6E4u3V5lQI47U6orx75VmSYYoJ5+aGGr3LJom+u9H0Dm1XTndWE239cGEaMYwtz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeB6x4oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E3FC433C7;
	Fri, 29 Mar 2024 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716333;
	bh=3o/CuBphMJvJQCkiYuvD/itep/WB5d2yyRYl8PtwFWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeB6x4oCfneiItgqilMPgKJWEJV6XbPw0578qRWinmj9jJmstL7MJrFB0TrW8s74x
	 IlRPrlB1b0WDUonIQLmC5E2JSoCv2gHZNobW01QmxUs+0jRRUpCwPWjVrTaJ9ExTRx
	 XVPEfE0DHIwDsy24AZlwO81ONuUaJKdAiHQj+5jk9+IijdSDts98cobCuokAeVdWqC
	 XB/8xWPBFd1Ie//4THR/Ent5hqW+TauhSV5xncNA/M0JYSPmrRGM2JemR6LCzWCCT2
	 d5w6N+vTwV6yQENOKDI0Iny6J4PqzPVazVHzv9UKgG7/j1RiBQS1LJ70dQjIqWCWIW
	 3QNA3Jux9QrUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 70/75] platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet
Date: Fri, 29 Mar 2024 08:42:51 -0400
Message-ID: <20240329124330.3089520-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Alban Boyé <alban.boye@protonmail.com>

[ Upstream commit 1266e2efb7512dbf20eac820ca2ed34de6b1c3e7 ]

Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
Link: https://lore.kernel.org/r/20240227223919.11587-1-alban.boye@protonmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 969477c83e56e..630ed0515b1e9 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1222,6 +1222,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 		},
 	},
+	{
+		/* Chuwi Vi8 dual-boot (CWI506) */
+		.driver_data = (void *)&chuwi_vi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+	},
 	{
 		/* Chuwi Vi8 Plus (CWI519) */
 		.driver_data = (void *)&chuwi_vi8_plus_data,
-- 
2.43.0


