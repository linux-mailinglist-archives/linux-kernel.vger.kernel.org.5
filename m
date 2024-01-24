Return-Path: <linux-kernel+bounces-37171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F383AC42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF52821D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5148133986;
	Wed, 24 Jan 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxiYV92b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8E133431;
	Wed, 24 Jan 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106672; cv=none; b=FNQTbKtmSkc8gyD0F5DuO+Lnf+XQL6xFz85mTTOQgX+c9NKay6XO5XCiJ5MJg0ircW1ivDy815NV9Lo3S019IKIcLWVpq/dN5i7LfBq3TBmiXCZVYjx7lAgxzuZLY0s8ytMq6UoVkK4Yz9AqwKEABPTDjFk4olBNsuz9WVfFo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106672; c=relaxed/simple;
	bh=3a0w+hq9uIG+lF49GSCkqotCjAnLCzJvjuyURWaDobs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cit6fDf5Kx4aX4EAdI+2AiSGlkWwUbYlNbU+NUqmY92Z6GISVREHsXcgQfTyhiyCy5Z5vSqBg0tfp4vMAx7gqqgtnqIp/iXHRYLSlM6/nEVQ/ZLfaHLeqKflbiKtj0zdKub64GvCsoIyng2IqRHY/036Z1QZopfY3N+A8R0M0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxiYV92b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96195C433C7;
	Wed, 24 Jan 2024 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106671;
	bh=3a0w+hq9uIG+lF49GSCkqotCjAnLCzJvjuyURWaDobs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxiYV92bv+Xz+kDhOFtCbzWjtfg9LdeuKWdJmjtyHLI3J1pH3HeGsYJMO5BsCFLcI
	 N43OpKDxjyw+RZ0h7ByR1RanP/Ps5sI2U/n1Y7jQYVRBVKquPTvaEFGVysFRvX543g
	 N3Ry5sq72QVLsZDC9nESMUHR9N+F1uAiCEK7U5mEgCs9sNSnep6jCuw0WSsPQsNXqQ
	 7/Sgi/LUneHKfAbCiff3s5LqNklkdp1/neh2s0gCHcrvGbJ8nW43oD7E2b0S1CquCn
	 XkFvXxbp4lC9PYGNqkxRJXKrts9dpn/yTw+kf4c2FjxiDlVm9MrXY9tWEDQL7AE0QL
	 Zh5PpO+Hu8djQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harshit Shah <harshitshah.opendev@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	pgaj@cadence.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 5/7] i3c: master: cdns: Update maximum prescaler value for i2c clock
Date: Wed, 24 Jan 2024 09:30:46 -0500
Message-ID: <20240124143057.1284274-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143057.1284274-1-sashal@kernel.org>
References: <20240124143057.1284274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 6b9df33ac561..6b126fce5a9e 100644
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


