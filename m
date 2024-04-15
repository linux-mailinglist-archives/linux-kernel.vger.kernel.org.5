Return-Path: <linux-kernel+bounces-145629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9A8A58C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B051F21A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4391272AE;
	Mon, 15 Apr 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="M54NEGVz"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668818526C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200753; cv=none; b=odX0UV1QV1/2aLLMi4WHZDYkVyOXMRZFkYON/1SLHch7Un736krR4yhqo3NKetYc0hUtyWRkyeh6PYwHSZ6L6ODnk/FQuCCJ2SXyO23HyUAliwGjmU3eD0TybF3Brwffc2LoZ1ifWWL7wDQHFvl/S6h//NPOitWANsi4LS+qu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200753; c=relaxed/simple;
	bh=0mJpgs4aUQEhIiZHyXeNH/EklJ0LtNa/zt00pTK4jZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLM42CG6eK0zQw4aFqX6kL5s8BSn1OgiZN7JGBgHF6z4ZJO7Cmy3uVeg1RD1/1200K9+bJpFzask9RytjoV0lR1+n46OqWKRUWLiNhtDLu97xb6S4/zZRefE7SjcXomi395fonxn/tqd5qHUHzdRtx2jO9jMZ3aO05eKnEuEZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=M54NEGVz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713200750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptoV88Ij0/j9NhFFGW6zsh8KfISiHRwnC9zklzCEC5s=;
	b=M54NEGVztU8esR0V50Z57mvarN+dZN/XS/51m37T9NlZ2lFFhUyXWSE9k53KPbRaqxUypZ
	IA+FtEmMnA3YbalvGaBpMcEruXs1Qaj6GMsvDXL+IGwi0zlUWog0VxUreeYbBLPeEp2gJs
	7lpqqc78KIF6/gdRfAcZIaC2F4AQ0y3CCUPUbkoSIEFBMxMCq5FY6wMXsoWRXl6yT/fIjv
	6Y8rtCM0ZUcW9nJaPi6nqjgi4hQ1GQujWH0iLaWf8VR9aTpCMzCTHDTeVOSe4dsi+Hr59X
	VE6SZ+XX3R9r9VfOusekSX2s3XBsERJrPtDsoVVUkckxE5MQXx/7TX5pJCEOfw==
From: Kenny Levinsen <kl@kl.wtf>
To: Jiri Kosina <jikos@kernel.org>,
	Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Cc: Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH 3/3] HID: i2c-hid: Align i2c_hid_set_power() retry with HID descriptor read
Date: Mon, 15 Apr 2024 19:04:13 +0200
Message-ID: <20240415170517.18780-4-kl@kl.wtf>
In-Reply-To: <20240415170517.18780-1-kl@kl.wtf>
References: <20240415170517.18780-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Instead of retrying on any error, just retry on EREMOTEIO and simplify
the retry handling a bit.

Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index ac661199d2c8..998e7aa140d7 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -395,21 +395,14 @@ static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 	 * The call will get a return value (EREMOTEIO) but device will be
 	 * triggered and activated. After that, it goes like a normal device.
 	 */
-	if (power_state == I2C_HID_PWR_ON) {
+	ret = i2c_hid_set_power_command(ihid, power_state);
+	if (ret == -EREMOTEIO && power_state == I2C_HID_PWR_ON)
 		ret = i2c_hid_set_power_command(ihid, I2C_HID_PWR_ON);
 
-		/* Device was already activated */
-		if (!ret)
-			goto set_pwr_exit;
-	}
-
-	ret = i2c_hid_set_power_command(ihid, power_state);
 	if (ret)
 		dev_err(&ihid->client->dev,
 			"failed to change power setting.\n");
 
-set_pwr_exit:
-
 	/*
 	 * The HID over I2C specification states that if a DEVICE needs time
 	 * after the PWR_ON request, it should utilise CLOCK stretching.
-- 
2.44.0


