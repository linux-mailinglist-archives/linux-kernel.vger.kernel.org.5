Return-Path: <linux-kernel+bounces-115288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDBB88939A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9797DB2232F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BAB15EFA4;
	Mon, 25 Mar 2024 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srSP5sQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CB482DA;
	Sun, 24 Mar 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320481; cv=none; b=i5V2eHJNEl5sLJPKd+Ttn9DGQesfwXzVI/YRzI1OG6F4qOeR64gu83v4erk3qGR3EW6Zu7ZRfL9ExbM09HlaPEv79XKQUWvcTA8RijP65Sb5Jf9zwug9AdL/ZIqy/i/Gux1uBo8aJCsX6IimOWxQojmaf9Eh0XDg6kRjdHZqb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320481; c=relaxed/simple;
	bh=hQUbd13s4ll9bhRZbwYb/6PahcuZYCN+X3yVUaUpNtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1JO+7g30PXsStEMHj8IXSLfsIBamaUI7mrIN6zM/58F4tLFvBW4mvnpUypQAYp2/tKOGm4TqRd6l0zpNHOVYcoMV9SqP3GUNENgCbElSlOod6ELy5UYSzeOyD05wGMWX9u5WfROp0dj1NY3/gtqTa/1mU/5G1ZYNl3fJl0XQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srSP5sQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF74C433A6;
	Sun, 24 Mar 2024 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320480;
	bh=hQUbd13s4ll9bhRZbwYb/6PahcuZYCN+X3yVUaUpNtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srSP5sQVGG8IzdJiiiIG6dw9DXmKZFpzArLIQKUt7oxeg8Z96Rhf/7jiyt8e5/pnA
	 YgiIGGe4X3fiY/2dcVPep2jalc/ioandkXYBRqd2D8A+rUAmcUcYVbkTQvi0ZKrzFK
	 AG7O/f3K67Q1UhsFuXbC+jePlgqj1t7LGlLpZQ+Gik159kVgQPT9iyEmnnwld8omAR
	 yH5vWO4SPbt7Ff12rKVqvH/EA9hKR/6VccfhNwA74bUO5F8yQz4Ju/lPsDtJ8DvjE5
	 kDmCahzH7l2nbzmOqM536oxBr5KIekWBuOPbWK/xkSLXfZ672nmWXvxPqMT8bo90Ed
	 ugIpmovsJWZrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 040/713] platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name
Date: Sun, 24 Mar 2024 18:36:06 -0400
Message-ID: <20240324224720.1345309-41-sashal@kernel.org>
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


