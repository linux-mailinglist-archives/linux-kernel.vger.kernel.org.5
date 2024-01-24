Return-Path: <linux-kernel+bounces-37160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524483AC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EC1F213D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB312FF99;
	Wed, 24 Jan 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu4DTE8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC457E79D;
	Wed, 24 Jan 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106643; cv=none; b=RyGUOgSPPpK1XMKNNzgt3jnIiuhHcwTCB5IEG8IN9t++PhhnAgE94k794ZCkgXnDNbqKryLgPn/ul9oSexVsDU/iQNzCwXMnTBJ/Qz+siY+zmAqQ1b2Wnpr5VPVdJHlW8FL2DxEfycjicS/0hUCvWreWD2RyD5/c21aL74Ggcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106643; c=relaxed/simple;
	bh=t0RZzSt1jjBgxGY4o0ZkWqVOeUyWAuIDWOZJMVJzbJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqJCPTvvCpP4jJvl3ZNLaqGjUWtJ148DdHejZpOd4im3xvtLmxD7gdbQRGr6j8erzmUvETwdiAl7l1xtqEdF16Lxo+TBiWsFMBdLng4VjwS8Kfuly0XeKhFOJ1JxzuByFSrUpkQvLdnexpqqs2fsXTy1M7Ql8bHjHBiWY1U9nbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu4DTE8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2F4C433B2;
	Wed, 24 Jan 2024 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106643;
	bh=t0RZzSt1jjBgxGY4o0ZkWqVOeUyWAuIDWOZJMVJzbJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tu4DTE8DmWsnv51jiEwStonyfqVFSonzTNMqkY20sUeuBShZ2V2Xp4ppnLY4RY5ko
	 ST+HpRvJjHKBCxG0ekWmKUI/2Pk+97E694PPBOLa83ZExnuk+hmalN/jgxZcHO2UAi
	 h0SrRabyab9eJw8TEGyxDtEhi7OZYSU04y2qMhmgLktShYxcTizH7lzFVfa5QxTuMk
	 HyNKZzoYjpDGXRkoqDlm2GqbjFvusd7dw79fW+YD8ccKN4NKUzCNRMfeP4Gcewvn0c
	 h3fQKRJGENcJQa85aNiiwpJVHUc/XaRnw0SZWwSwQDVcoCBTdSD6quBAmEyeVxInlf
	 /h9SS2kuSPE/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harshit Shah <harshitshah.opendev@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	pgaj@cadence.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 6/9] i3c: master: cdns: Update maximum prescaler value for i2c clock
Date: Wed, 24 Jan 2024 09:30:09 -0500
Message-ID: <20240124143024.1284046-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143024.1284046-1-sashal@kernel.org>
References: <20240124143024.1284046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Harshit Shah <harshitshah.opendev@gmail.com>

[ Upstream commit 374c13f9080a1b9835a5ed3e7bea93cf8e2dc262 ]

As per the Cadence IP document fixed the I2C clock divider value limit from
16 bits instead of 10 bits. Without this change setting up the I2C clock to
low frequencies will not work as the prescaler value might be greater than
10 bit number.

I3C clock divider value is 10 bits only. Updating the macro names for both.

Signed-off-by: Harshit Shah <harshitshah.opendev@gmail.com>
Link: https://lore.kernel.org/r/1703927483-28682-1-git-send-email-harshitshah.opendev@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/i3c-master-cdns.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 4a49c75a9408..b9cfda6ae9ae 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -77,7 +77,8 @@
 #define PRESCL_CTRL0			0x14
 #define PRESCL_CTRL0_I2C(x)		((x) << 16)
 #define PRESCL_CTRL0_I3C(x)		(x)
-#define PRESCL_CTRL0_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I3C_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I2C_MAX		GENMASK(15, 0)
 
 #define PRESCL_CTRL1			0x18
 #define PRESCL_CTRL1_PP_LOW_MASK	GENMASK(15, 8)
@@ -1234,7 +1235,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 		return -EINVAL;
 
 	pres = DIV_ROUND_UP(sysclk_rate, (bus->scl_rate.i3c * 4)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I3C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i3c = sysclk_rate / ((pres + 1) * 4);
@@ -1247,7 +1248,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	max_i2cfreq = bus->scl_rate.i2c;
 
 	pres = (sysclk_rate / (max_i2cfreq * 5)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I2C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
-- 
2.43.0


