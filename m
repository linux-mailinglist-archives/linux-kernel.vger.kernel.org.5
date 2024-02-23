Return-Path: <linux-kernel+bounces-78958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE8861B54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1521C2350D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A0146911;
	Fri, 23 Feb 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="a4W6EDFG"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2841448C3;
	Fri, 23 Feb 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712117; cv=pass; b=FYJVDkUYyW1G1usmL/55/4UyTozxK2vfGo2UcAT+gBHDUK/R7+dYZj3yiU8KtNC89mxRpMGerLfdKRhw5HXwvB2P/Y+yWadmFgw2xtXSh4VClqTFpqfwLTsPhxX4iQkhAnWDJx0CaA1dweDYdUS53gRYowY3rxS020qsJM0JFTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712117; c=relaxed/simple;
	bh=WqCQnR+yf94SdIYZnyGag0TszxHaJ7hhPosA+SsHm8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0mjqXOP49HNpeUF4xUads7G5jG4x0dnunS5Ax88EqQH4wPEhVDrez1stSXCb83z8LUauk1Qpuve0Ded8oNn9TICGGULmDTWWaYU1wrqEHYT7eYhI5eqWZGkZSd9g62fAv3DeOctbr3SrS3XBNxs9tcCMXDOREJ6aeBh7F7Mypc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=a4W6EDFG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ThJ8953Rqzyyw;
	Fri, 23 Feb 2024 20:15:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708712106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7wWfneG8wRyf2KX1pRWaaUVIRBRh/PwM028DaY3q+E=;
	b=a4W6EDFGmKyOr2SdmLZSg3dUSlW+X4E/6GXl8FL39otWtcVoID++QKWaFFsR8uO+BcgPV4
	qAa5WxjBCgUiKUuzLesfUOBlSiUFY/KG8QrFQkOfNYvbRvI5QhNTIJBoGkKG6Hk9GD6zcT
	rhaWpLPfiAjBeErQEk7W+xXyo+Gb/X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708712106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7wWfneG8wRyf2KX1pRWaaUVIRBRh/PwM028DaY3q+E=;
	b=LaxA6mjN49qayqu7alMxl1Kw/R+eFqEACpZYvYg60tz5JlhsWTWLJlrPahWh7CQZ4HCvS0
	LmjuXISGbjVaCTizFsFT7yySbmkeOlLE7FwAUPeBVxBUd3iMEjdICtdGk51uG/s2rxzk6N
	2hVnhxmQVQ60eMocWrohF+BYDT/IHmw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708712106; a=rsa-sha256; cv=none;
	b=wCIlShYVXNVTP/xsvjSlt22TjqT7r4xG+k3R3FAQCVm5tereqBPqgJdX74xqTw72DUm1tU
	mUhgdmBuHKxkNcgkN8jtTT5Fs6kUIn+q5mzkofrKonPWEh9BheVnTL5MJxV8X9Aj1qGyYg
	oN4HRT5G5F/6A0fl8/7ZnUC6RpPv9bw=
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 5/5] MMC: OMAP: restore original power up/down steps
Date: Fri, 23 Feb 2024 20:14:39 +0200
Message-Id: <20240223181439.1099750-6-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
References: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
moved Nokia N810 MMC power up/down from the board file into the MMC driver.

The change removed some delays, and ordering without a valid reason.
Restore power up/down to match the original code. This matters only on N810
where the 2nd GPIO is in use. Other boards will see an additional delay but
that should be a lesser concern than omitting delays altogether.

Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 50408771ae01..13fa8588e38c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1119,10 +1119,25 @@ static void mmc_omap_set_power(struct mmc_omap_slot *slot, int power_on,
 
 	host = slot->host;
 
-	if (slot->vsd)
-		gpiod_set_value(slot->vsd, power_on);
-	if (slot->vio)
-		gpiod_set_value(slot->vio, power_on);
+	if (power_on) {
+		if (slot->vsd) {
+			gpiod_set_value(slot->vsd, power_on);
+			msleep(1);
+		}
+		if (slot->vio) {
+			gpiod_set_value(slot->vio, power_on);
+			msleep(1);
+		}
+	} else {
+		if (slot->vio) {
+			gpiod_set_value(slot->vio, power_on);
+			msleep(50);
+		}
+		if (slot->vsd) {
+			gpiod_set_value(slot->vsd, power_on);
+			msleep(50);
+		}
+	}
 
 	if (slot->pdata->set_power != NULL)
 		slot->pdata->set_power(mmc_dev(slot->mmc), slot->id, power_on,
-- 
2.39.2


