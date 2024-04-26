Return-Path: <linux-kernel+bounces-160756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB468B4268
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE6D28282F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B63BBDC;
	Fri, 26 Apr 2024 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="RYZd9Zxo"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1D3987D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172279; cv=none; b=kVVqSzfSBrdpQi2tCOZCdiVl6L+sZCA716r6kFKBr5gTIXC3e6pDC+0rfTAmRf+djy0s1mhmig026ZpNrjlW4CW5K4jAEDZJH6kM2UKGSVhsFmViYTgSwwfM5Ud/fbl4qJwz90ah43UQ8Vv83Wg0enYjcnudxVcvus9Vupz9Q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172279; c=relaxed/simple;
	bh=bmGxBMb81JYd9eJGESmHcK3CwPvy/AwmJGpMgmU9o2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTJmkEydr7r37qQAjuv5xgv5KKreECVjV9K1ZqM/juZ198kdkBrrDzPmLFzfQU4CWXMXJfW8lsRBnhP6iI5Y02sXmiCeG6P8aHiNMYfuiWCMmAk1lNMaZ7ug4N9AV3E+17T2Ud2hPZTPOM47Z/OzISRmRvmDUZinkfl495Mn0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=RYZd9Zxo; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714172275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SXRaVoQrN/XQKemgL4uLkkyAHkvGBUXAQSxAzF5ceM=;
	b=RYZd9ZxoUP/vsNRSnoVMy0oEicyeddd/AkpJaaufnVB6kHdY6p1HJu/+AViwPfVDSWe2OS
	qTys5Nsel+rb7n9QeVjXfPsCtOatVvY7aGzf3BpHs7wdBwDMgwihn9O7Gef4D7FgdVOqwr
	wqfwLbGQOjS5W2TRZLvvzUJaCS/Nm5kGcShoLULJV8ahkebSFZBClnPX6w+Tiu3iiotpVW
	k7V2N93qk6659A0WXxyOk/gqzdp8PRBjUfzEp3roOpfSN0vxxxYWcfVEbfm+/7HU0gbVcQ
	CZ1MRvJSbuLqNQvFyAjVcowytTBsFXoUhwaCH2s+LROJS8L08WRrwMTqa3VGzw==
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
Subject: [PATCH v3 1/3] HID: i2c-hid: Rely on HID descriptor fetch to probe
Date: Sat, 27 Apr 2024 00:47:07 +0200
Message-ID: <20240426225739.2166-2-kl@kl.wtf>
In-Reply-To: <20240426225739.2166-1-kl@kl.wtf>
References: <20240426225739.2166-1-kl@kl.wtf>
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

Without this probe, i2c_hid_fetch_hid_descriptor() will fail internally
on a bus error and log. Treat the bus error as a missing device and
remove the error log so we can do away with the probe.

Tested-by: Lukasz Majczak <lma@chromium.org>
Reviewed-by: Lukasz Majczak <lma@chromium.org>
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index d965382196c6..6ffa43d245b4 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -872,12 +872,11 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 					      ihid->wHIDDescRegister,
 					      &ihid->hdesc,
 					      sizeof(ihid->hdesc));
-		if (error) {
-			dev_err(&ihid->client->dev,
-				"failed to fetch HID descriptor: %d\n",
-				error);
-			return -ENODEV;
-		}
+
+		/* The i2c drivers are a bit inconsistent with their error
+		 * codes, so treat everything as -ENXIO for now. */
+		if (error)
+			return -ENXIO;
 	}
 
 	/* Validate the length of HID descriptor, the 4 first bytes:
@@ -992,17 +991,9 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
-	/* Make sure there is something at this address */
-	ret = i2c_smbus_read_byte(client);
-	if (ret < 0) {
-		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
-		return -ENXIO;
-	}
-
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
 	if (ret < 0) {
-		dev_err(&client->dev,
-			"Failed to fetch the HID Descriptor\n");
+		i2c_hid_dbg(ihid, "failed to fetch HID descriptor: %d\n", ret);
 		return ret;
 	}
 
-- 
2.44.0


