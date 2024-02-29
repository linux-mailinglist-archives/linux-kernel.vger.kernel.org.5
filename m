Return-Path: <linux-kernel+bounces-87450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66386D48E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C242CB22A55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE3154454;
	Thu, 29 Feb 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDwXGLX4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44115443B;
	Thu, 29 Feb 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239085; cv=none; b=rvJ+xci9NV2HkmtYjxh+oCPBXkAJF2qsNBvwiQEPMCTW5rfB9/JPxHLZLEph06GK5Wh4KU2cmSJjuUKgqTXl7f3QZZt86zTvXZsPjBDHpywbeLWdKRkoJ54UV9ys5MvmV0CgNc3p1g6NX7QnvdEktklVOc2dX66HXwjvonyVrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239085; c=relaxed/simple;
	bh=hQUbd13s4ll9bhRZbwYb/6PahcuZYCN+X3yVUaUpNtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbNphqmZmwjc+j+9bKe1Aa0zZNq5XiouWVrWoiMurlcW/Xqr0Grt10nZGSsNMJBdeOhFhe+5kcPwF0x/z4YNGzXD+4GnFqV6ym4tBGuu5FoE4+1RrmRnvbjqV6CY+EEa3AfNEyeiw7Phqm6wBML+cX0Ecemo/yLylH2auWoRAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDwXGLX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A16C433F1;
	Thu, 29 Feb 2024 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239084;
	bh=hQUbd13s4ll9bhRZbwYb/6PahcuZYCN+X3yVUaUpNtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDwXGLX4uFiCOHcCl6S1Fv2jjJO0Ct6VH8iKT8Fr5LqaKBY0csUA3GN2WK/k94Dk1
	 dhqHlwTUko6p7kfgM6AV/ZJq0YUfhNzAqURR9V9kLiphXz8kTQB3my74iL/k50cWNN
	 0w5kzlObXNDRwKHoZ4hcuygko7BnSrKKYZd90JUVxfs+WhlwsBq18xZxAtBIZ8Th3r
	 kmS9EZhu0xA0Qy/oQzdAGpZk+9EP70GIvJWQeH+ec1ooo2UUcx9aMe7JOoiEHG3Vhe
	 dQ1vCLjMUmhqdfwhlwXF0TuVX/xsXdT3DdCGcSuJkI8XY/+U7luANhdvM3FEfjRaNX
	 7V+SwznNH3jqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 17/24] platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name
Date: Thu, 29 Feb 2024 15:36:57 -0500
Message-ID: <20240229203729.2860356-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index bc6bbf7ec6ea1..278402dcb808c 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -68,7 +68,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table acer_b1_750_goodix_gpios = {
+static struct gpiod_lookup_table acer_b1_750_nvt_ts_gpios = {
 	.dev_id = "i2c-NVT-ts",
 	.table = {
 		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_LOW),
@@ -77,7 +77,7 @@ static struct gpiod_lookup_table acer_b1_750_goodix_gpios = {
 };
 
 static struct gpiod_lookup_table * const acer_b1_750_gpios[] = {
-	&acer_b1_750_goodix_gpios,
+	&acer_b1_750_nvt_ts_gpios,
 	&int3496_reference_gpios,
 	NULL
 };
-- 
2.43.0


