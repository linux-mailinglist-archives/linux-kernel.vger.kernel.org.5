Return-Path: <linux-kernel+bounces-114033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0880888802
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E6B293E13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42414A0B4;
	Sun, 24 Mar 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/6rv8jU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426161FC0F1;
	Sun, 24 Mar 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321313; cv=none; b=tvCFThWY7uFBvu9CbdM/aRjDZXadkfL8rVn7SmsMDjoqy5H6nTcudOt+WPNx39HQ4A6ZbSAdsGJgkzmP4uAecOiz4i5VfK2LNR0ijzNMS8xynsFG+E668aS8UlZuzLnmvm2m+6JqOcyRpWblGKOy/cDZlUlnHuJcte+4HB5QLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321313; c=relaxed/simple;
	bh=NkYNaqC8gUpfieNnjfBQsil8TTp5PmLuCYEYfbeDJzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQFBEoX8SQwdX0AU723GS8MUvDRxHgRCxm9S+G994KoAAbKYmGB/GF53e6mk+NOgEfj7G3cNMeDPWVEaafZb76Ew5NdWXSkmQq/E0NKOBnblKeorCZPpkG12ujYyF6Ht851E28yGqniU7rsf7qbdcXy2mzL0midv/Maiy/O65c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/6rv8jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E4BC433F1;
	Sun, 24 Mar 2024 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321312;
	bh=NkYNaqC8gUpfieNnjfBQsil8TTp5PmLuCYEYfbeDJzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/6rv8jULjhbJOd0oc9FmSoqf+5dQSbn6wkcIkzNqxDQw6V0sy+yjLqt4m9UrmWKF
	 BhsCbjzgE/lWHCFt7/P7cWcyggXwqybK2HdOYXMwjwcVPtEbazYaSZFu2wZ0NpwP3N
	 rF6vxrk4/jr5CV8dBGBJ5TLkIMzpCoDWV26QzMFc6U/orw3I68tIEaH1K9jX2JGOcE
	 2oLpo4ptt41jJt6QE6K0sJ/boJuV/xCYsYRwR7Zy09K+PBnZfEFNFF/+pdYqFiv0I+
	 xMwJxtrtx0r/GZUuyIeBXQTZbRq8vjXVZDgy+/CEXnW5myE4t6MU3OwkdRbCG5jSOr
	 a6vnrgBAj7Axg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 035/638] platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name
Date: Sun, 24 Mar 2024 18:51:12 -0400
Message-ID: <20240324230116.1348576-36-sashal@kernel.org>
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


