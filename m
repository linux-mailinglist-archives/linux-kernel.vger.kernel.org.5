Return-Path: <linux-kernel+bounces-160757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF78B426B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012161F223C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35A3BBF5;
	Fri, 26 Apr 2024 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="PyMDwgGJ"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124F39AC9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172279; cv=none; b=XChefkU0twjfK5MSj+26dLhNdKuFGo33doO5J3D+VlrW7bhHGgGDv08/HVQ5SfGPyFMWm2W9m8aaLLKr9A+DOzVtbnVrclNBNW5LNlI+Id7mouh/wx1Dgqj7dGazTGBHGGVEtRZJ6HNsLe+eqW3D4ya/37QlMZQUMxrwy3t+7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172279; c=relaxed/simple;
	bh=jcYLChDAgnIUe4+iN8D3/9NndAF22/1Z60vNxCuSZTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erWf2uX4+dQw9O0ZBNyJWZAN4klLAzQMfZbLdebeyuAkSWKGU3056Oo0OXe2M1rhS+SzLhNnny5ui/aKsgOpHSpex3eYSlbWOATvmdFAA1IxiJgPlNZcE7zRDAN8u8gEhd/64pqiVtFMz8X17+iqTnNOY9ATu+8ttIqAd1SWmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=PyMDwgGJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714172276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KU3jl0WoeassL0fsNyvxyf1+jr7Lzh8USMHCS2SFuk=;
	b=PyMDwgGJogmpa6f+Up4ClCDkkfbFDqgE0FxFFdokAgFB6B05qFPdsdg1iAe+0lyH8biu2k
	VuW9RVfhDJc1AMP2A7zp/0R5DLW5yDpYh5s2ootpgOVliKPMlHKVjcLzOIXSlhWGOpn2PS
	czThUf0Rb/1TRQHS2nhkcQmgcvUAzb7Pcq5XrQ2YjAfZdxhYE8pfR6JkTHOOcWggLboTwS
	8VApmOQEq0TVmWlJS1mmV1HolJ54ZzrmhB/FTSvrzCD6MR6Awo3W7bCFZZSNb5UA74pMgZ
	eDQ/YMbwkzbmggPyzAo+jL3XiNFdCxH9dBBb78sFnUWvVseSmL+yA2tRulYl5A==
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
Subject: [PATCH v3 2/3] HID: i2c-hid: Retry HID descriptor read to wake up STM devices
Date: Sat, 27 Apr 2024 00:47:08 +0200
Message-ID: <20240426225739.2166-3-kl@kl.wtf>
In-Reply-To: <20240426225739.2166-1-kl@kl.wtf>
References: <20240426225739.2166-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some STM microcontrollers need 400µs after rising clock edge in order to
come out of their deep sleep state. This in turn means that the first
command sent to them will fail on a bus error.

Retry once on bus error to see if the device came alive, otherwise treat
the error as if no device was present like before.

Link: https://lore.kernel.org/all/20240405102436.3479210-1-lma@chromium.org/#t
Co-developed-by: Radoslaw Biernacki <rad@chromium.org>
Co-developed-by: Lukasz Majczak <lma@chromium.org>
Tested-by: Lukasz Majczak <lma@chromium.org>
Reviewed-by: Lukasz Majczak <lma@chromium.org>
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 6ffa43d245b4..6ac1b11fb675 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -991,8 +991,17 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
+	/*
+	 * Some STM-based devices need 400µs after a rising clock edge to wake
+	 * from deep sleep, which in turn means that our first command will
+	 * fail on a bus error. Retry the command in this case.
+	 */
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
-	if (ret < 0) {
+	if (ret == -ENXIO) {
+		usleep_range(400, 500);
+		ret = i2c_hid_fetch_hid_descriptor(ihid);
+	}
+	if (ret) {
 		i2c_hid_dbg(ihid, "failed to fetch HID descriptor: %d\n", ret);
 		return ret;
 	}
-- 
2.44.0


