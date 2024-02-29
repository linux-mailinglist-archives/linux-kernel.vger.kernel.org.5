Return-Path: <linux-kernel+bounces-87475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697786D4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C34284B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55D160886;
	Thu, 29 Feb 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKQn4wiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7915FE37;
	Thu, 29 Feb 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239208; cv=none; b=Cp1AxSSLZmP2KRLYia2OGUPyYvRgZGAOjenRxRK5JLrhwPEaYhXiBM6sCv6hp/4HzKdflCSa9vXaJNE8GDusJg99Bl73MwaU2k5xpBXVNOxi+6HX7CwHzLPA2LhZ9qBpgsB/L/Uyoho84A2EIlEnnpcwFFuQP/VB0Zj57hfDkoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239208; c=relaxed/simple;
	bh=NkYNaqC8gUpfieNnjfBQsil8TTp5PmLuCYEYfbeDJzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icZ1ciKkgMC6R+J+ft3xxJQtETxJat+jkx4i8FHyGPdoeLzCMQF7IgBoaAQ8B4tLzHI7RsJz8ze++mAD+lvx5VITXsPHowrvDQ3HTHD3kajBKpCCAEFKSKZ4T20enKrR9nV8oK5pnQS33uQB/kkvQwDrLhUzi4GlD1ibX+F31Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKQn4wiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F10C433F1;
	Thu, 29 Feb 2024 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239208;
	bh=NkYNaqC8gUpfieNnjfBQsil8TTp5PmLuCYEYfbeDJzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKQn4wiGMZnPlOVpuXAvMhX7Dtv/UM2C5JCqUi1Nrj8zOSjkjgYSL9lmNNoA4Iqyt
	 i4z6whE3eOQ65z02mjaTjQ6emVZVRjNj4jxNIWGXI9mzF6viIXE3+WVV+5/ia9Mv7V
	 F3WIAz91cxAHuH46oOnv9kT6OY7ROm5DxeNPgHZ8ZCMq7wFOFPsSOFJ+9Cgu7mWMFm
	 x71fWLti1T+UUPTs6+DoK0qIkwPmMuKKRcBDhpsXWY51EbRvVN7wSO9pqBm9cMWddO
	 2JRKs8iL1nNpSjMY9n+9LRdhBLc6lqTSdZq4A2ZiDmQk6cTVuCTTqXrAJoZeSokLPg
	 b6WReoCZcKC7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/22] platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name
Date: Thu, 29 Feb 2024 15:39:09 -0500
Message-ID: <20240229203933.2861006-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8215ca518164d35f10c0b5545c8bb80f538638b8 ]

The Acer B1 750 tablet used a Novatek NVT-ts touchscreen,
not a Goodix touchscreen.

Rename acer_b1_750_goodix_gpios to acer_b1_750_nvt_ts_gpios
to correctly reflect this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240216201721.239791-5-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/x86-android-tablets/other.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index e79549c6aae17..fe5f68fa7bca7 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -66,7 +66,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table acer_b1_750_goodix_gpios = {
+static struct gpiod_lookup_table acer_b1_750_nvt_ts_gpios = {
 	.dev_id = "i2c-NVT-ts",
 	.table = {
 		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_LOW),
@@ -75,7 +75,7 @@ static struct gpiod_lookup_table acer_b1_750_goodix_gpios = {
 };
 
 static struct gpiod_lookup_table * const acer_b1_750_gpios[] = {
-	&acer_b1_750_goodix_gpios,
+	&acer_b1_750_nvt_ts_gpios,
 	&int3496_reference_gpios,
 	NULL
 };
-- 
2.43.0


