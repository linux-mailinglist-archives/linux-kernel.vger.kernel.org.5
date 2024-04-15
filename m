Return-Path: <linux-kernel+bounces-145627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2708A58BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203D41F20933
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8086AEE;
	Mon, 15 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="QgL3lZAp"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054682D93
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200753; cv=none; b=oog3cwzOExb15hAdIopTLtBJ70NS66LqfRjMKRh70Dn/U57kAw7PDgrEfNsm9HVkzjwwKUT0wAjmufX3GgpyTlncIW2xnRg8z+Gvy/zil9f8XGZFNK9ZvY35v17J4BuVQN9t9oWrjyPBbkZENgiiAE1VhrWnRCbdsZ/55609m90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200753; c=relaxed/simple;
	bh=TyJU+YaqvfJsyrWAilPAS5rTdJU0SPQM2vyBu+LTUow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSelGNouHcGyoLSdz+36LoQonBSYVDUuuxlNffb7RjONDIu2uovhyj9vhM/4+ChtGAuxt1fukiZjXcp1MdwTBOuz8DSLkycS3Qdq/Gijzlr0mqO4eoHSIqWsAGlgvq3+8qsy80BlEEjjHF22sxD0bO8o2oxhmSthaOs9Asr4Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=QgL3lZAp; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713200749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb/WuZCiCFBxtB3cKvnMCuh+1XORhT3HDmIS6d/Oqgg=;
	b=QgL3lZApEHhlq3uh8KkxmqpNt7l9RAlXERe2hOzpUhWRTwwckd0haPGoqnNu0JzEuRUU1w
	3nNquZW3KA8w2qwOdmf4JJ0U5m9991KnS9Sasm2Abg/nFPFT3Ef2sgSRHQ8JJCjp5pyMFa
	SM0lXIWx+6gZfzeGV9xu7sk54NZ+no36G319DFeO89Vm3QTxDng4oZNfNvQlHnkhWcX9Q7
	jMsL6MVhfj/OR4P6YkUAFM8x9vaz21PHeiSsCIZei42aV6VCwrox2evMcMU0lBZaaXthka
	43QWnKN02Eh/r/Z+ijJT5MGnPOebTD5s131xcwekJjDcWOMsUdEpd8PUO0Q3GA==
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
Subject: [PATCH 1/3] HID: i2c-hid: Rely on HID descriptor fetch to probe
Date: Mon, 15 Apr 2024 19:04:11 +0200
Message-ID: <20240415170517.18780-2-kl@kl.wtf>
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

To avoid error messages when a device is not present, b3a81b6c4fc6 added
an initial bus probe using a dummy i2c_smbus_read_byte() call.

Without this probe, i2c_hid_fetch_hid_descriptor() will fail with
EREMOTEIO. Propagate the error up so the caller can handle EREMOTEIO
gracefully, and remove the probe as it is no longer necessary.

Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 2df1ab3c31cc..515a80dbf6c7 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -894,12 +894,8 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 					      ihid->wHIDDescRegister,
 					      &ihid->hdesc,
 					      sizeof(ihid->hdesc));
-		if (error) {
-			dev_err(&ihid->client->dev,
-				"failed to fetch HID descriptor: %d\n",
-				error);
-			return -ENODEV;
-		}
+		if (error)
+			return error;
 	}
 
 	/* Validate the length of HID descriptor, the 4 first bytes:
@@ -1014,17 +1010,13 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
-	/* Make sure there is something at this address */
-	ret = i2c_smbus_read_byte(client);
-	if (ret < 0) {
+	ret = i2c_hid_fetch_hid_descriptor(ihid);
+	if (ret == -EREMOTEIO) {
 		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
 		return -ENXIO;
-	}
-
-	ret = i2c_hid_fetch_hid_descriptor(ihid);
-	if (ret < 0) {
+	} else if (ret < 0) {
 		dev_err(&client->dev,
-			"Failed to fetch the HID Descriptor\n");
+			"failed to fetch HID descriptor: %d\n", ret);
 		return ret;
 	}
 
-- 
2.44.0


