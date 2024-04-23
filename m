Return-Path: <linux-kernel+bounces-155157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3B8AE5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9711F23073
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2884A54;
	Tue, 23 Apr 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="AcWl+9di"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64184E02
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875170; cv=none; b=SE1ixCevHrr2NqFexW5Ww4umdg5qi2lYPb78OcWp7/iWXGr8xjRumUIbCGXnJX4YCWfelvRWE68grfyAkvEDfk915GpT30g0Ot0YexNqxKT9OaoYv2K0c+vAigmc1d/OhlaOQI5UhV9RUt2vHMdlGlGGgRs3o+QYRLsjntE6BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875170; c=relaxed/simple;
	bh=TyJU+YaqvfJsyrWAilPAS5rTdJU0SPQM2vyBu+LTUow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZERZguxyFgd5ph6bgUYA9ccTC6n8dV3pX71drHZW1UzQWf5p+rm8pPpBMlDyQFHSCZH/fF35RF9Tgf3leV+bznRnmHDTJZUo7OlgC8tUNaYWKqqAMx7INaHBk4k9RUSifDANoHMaoTxxhY6mdyTzxo/OQaIkfbf/nFZkzFkCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=AcWl+9di; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713875166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb/WuZCiCFBxtB3cKvnMCuh+1XORhT3HDmIS6d/Oqgg=;
	b=AcWl+9diIvh59/Ir5rOQf+TnonxuDVZNGbTEQfnN4dbHnIBR9GOZfT1q7mZu8EwY3yRsS9
	08Shxp4MXzA+SbL1+MDGMM6ZXycyzp5SdyvL4K9tw2JgiVuY85XgtRFcFPpF0zRyks5J8L
	Q0gd3Co9+aJnkA01AfQLUkNOvCsgsIf6ApcIOiGW8VQMa/XGzNfFkq6pzG8i8uZz6NVQUY
	CB80cjdCtn8R39toCXqyo0n3OS7albhUI4lF9BawvjoEauKJbI2NS1RocuofVTALCMtLSS
	1wqzEKQPx/RRIZRi7VrZK8HY833qrCf/pEsxSsrme6j2pIFUaYkNW0e6g0+W6Q==
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
Subject: [PATCH v2 1/3] HID: i2c-hid: Rely on HID descriptor fetch to probe
Date: Tue, 23 Apr 2024 14:07:53 +0200
Message-ID: <20240423122518.34811-2-kl@kl.wtf>
In-Reply-To: <20240423122518.34811-1-kl@kl.wtf>
References: <20240423122518.34811-1-kl@kl.wtf>
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


