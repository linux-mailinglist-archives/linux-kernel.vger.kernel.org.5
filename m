Return-Path: <linux-kernel+bounces-37136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3A83ABEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD37F28D828
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C87C0A0;
	Wed, 24 Jan 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGuHu9NI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B212837A;
	Wed, 24 Jan 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106569; cv=none; b=qDaKdhmQXYd4vDoPxZtzrdIcYvZyC4c6r6lV3fx6br3HioP3Pj+D2wx4LbtMnh7pjaPQQ4/FkNTBFqS/EdNGbevKIHWDv8ycEG4NcK29muwdQR+7bpf6Xs1/GTgT8Xim/X8T/6TuWwkk5IDCTWyLBnYJK7O5uZghHD+V75lee7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106569; c=relaxed/simple;
	bh=yw5VLAu6HaIrKQU2W0638c2aTqRWEALE65CVfbIVBI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7XNTboptPPBe6JuEstheUmd2YMObSNmcIcQZ1WV4Aa/r6E9x712hSg80DZBh7rBF3O1opwQ5+Fn6R//aOSMdxQMfFfTthBO2CzwAfATLMwyEnzNoP2xeAGzZtrLZBgucefXOj1cXK5LabfAwlJ4dchimR0mlHUbOr314w+o9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGuHu9NI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA14C43142;
	Wed, 24 Jan 2024 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106568;
	bh=yw5VLAu6HaIrKQU2W0638c2aTqRWEALE65CVfbIVBI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGuHu9NIlyjAKN8UN4GjZPEtHIajhqxbhGKc0MvICm1xomtdaX1dRF7KDHEAGXJ+2
	 ewEYMSzBfAOT/YThxVNGakvgv3f79aavqTt9Cyy4/jLBmlHLA27vQE5l/tsWOypRL1
	 KBQuUshhW2Cblpyp7V6sRpzs9GmrDUVWj49lwxwdHzPFDEHJrm0SVBTuIhhIzlWSD1
	 yBAUajjzA5OloqsyDXjBBhCDaiIgdQhKgkNHcqdk2BLogR+H779iZlve8ThIp/MWM9
	 jHp+6BRWLE9YY5CJMxgu74oS61JA77rALqbHRLCn3BiPGnpaIlCEpsqTqNpiHc4Faf
	 /VDNVnL0Ub07g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harshit Shah <harshitshah.opendev@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	pgaj@cadence.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 07/11] i3c: master: cdns: Update maximum prescaler value for i2c clock
Date: Wed, 24 Jan 2024 09:28:50 -0500
Message-ID: <20240124142907.1283546-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142907.1283546-1-sashal@kernel.org>
References: <20240124142907.1283546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 8f1fda3c7ac5..fa5aaaf44618 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -76,7 +76,8 @@
 #define PRESCL_CTRL0			0x14
 #define PRESCL_CTRL0_I2C(x)		((x) << 16)
 #define PRESCL_CTRL0_I3C(x)		(x)
-#define PRESCL_CTRL0_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I3C_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I2C_MAX		GENMASK(15, 0)
 
 #define PRESCL_CTRL1			0x18
 #define PRESCL_CTRL1_PP_LOW_MASK	GENMASK(15, 8)
@@ -1233,7 +1234,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 		return -EINVAL;
 
 	pres = DIV_ROUND_UP(sysclk_rate, (bus->scl_rate.i3c * 4)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I3C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i3c = sysclk_rate / ((pres + 1) * 4);
@@ -1246,7 +1247,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	max_i2cfreq = bus->scl_rate.i2c;
 
 	pres = (sysclk_rate / (max_i2cfreq * 5)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I2C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
-- 
2.43.0


