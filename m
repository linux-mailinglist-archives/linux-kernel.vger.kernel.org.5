Return-Path: <linux-kernel+bounces-163156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E58B666C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2066BB22D58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAB194C9E;
	Mon, 29 Apr 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="amN4irZ5"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0F194C8C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433998; cv=none; b=M0dsZYqs2k3bKHwFK9Jc/SlyVeZKi8BdcHyuuXbV82S5fGwEaddkpEzaVN5dNv2v7Av3w0Y/3F27uOtJLSur7c46t1MSZv9yHpTfLKmG3qidyPqRi7jjc/iQaMcigVwTihqJSlFRZh+F2pUeONDoArxSQopfkWPGh7MSA5lUp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433998; c=relaxed/simple;
	bh=BClq4mDPmyZgU0qr+f9VFy4skql2e7wKlGAmZ6Hi+vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JB0xrSxibSfewKyCsffPX3UI448t3QoMkLn0Ll4Vnt3XYUJU8WJ8wwJpKRtLJD1eftXd6bVVOkIVTfZgkeUjaZfbBoDCKOrEfPPSqV3Q0UkIM5VyfDSKGx9oIkQ1hOjIy7K5/K2RV8EkweSKjdB5e7PrWm9C0SpRd7yh3wEs95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=amN4irZ5; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714433993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdRWlVXmvhwr8N4NqwgJPMuCGKujk/MjJK4ya7Ikf4o=;
	b=amN4irZ5KoJZ4oYNiAEWeoFyQIpPEI1EZZmc7YV3B/GlLFGaGJtA69PVBuK75gyXYfBxf1
	1Ji2OEfQ5ibuSgZD0EcFvdbgWtxB1hEHkhs96WTxljxfppvZoSVVcVZp6F3NaMYTKQ9CDD
	a0cKUbYUb3PNQ6NHoLdYB+XNqdCMGejiY6c1YVw/HgbKNDgKxH7y5xiv6iQTxzS2cDYlWi
	UJO0vy+tC3AbP5IGlG3ekTE+2xOX4J0HW9ou26M7w0NzmS+V9HZ1sXSBJfWuxZ4SrO0HW/
	6gip3x8ESAYpLsvTHm7fcopziXTjfbvcs+wxMffWP+wFUX3UnwpERX02nGbCdg==
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
Subject: [PATCH 1/2] HID: i2c-hid: Retry address probe after delay
Date: Tue, 30 Apr 2024 01:33:14 +0200
Message-ID: <20240429233924.6453-2-kl@kl.wtf>
In-Reply-To: <20240429233924.6453-1-kl@kl.wtf>
References: <20240429233924.6453-1-kl@kl.wtf>
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
come out of their deep sleep state. This in turn means that our address
probe will fail as the device is not ready to service it.

Retry the probe once after a delay to see if the device came alive,
otherwise treat the device as missing.

Link: https://lore.kernel.org/all/20240405102436.3479210-1-lma@chromium.org/#t
Co-developed-by: Radoslaw Biernacki <rad@chromium.org>
Co-developed-by: Lukasz Majczak <lma@chromium.org>
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index d965382196c6..a40489bb7643 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -163,6 +163,24 @@ static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
 	return quirks;
 }
 
+static int i2c_hid_probe_address(struct i2c_hid *ihid)
+{
+	int ret;
+
+	/*
+	 * Some STM-based devices need 400µs after a rising clock edge to wake
+	 * from deep sleep, in which case the first read will fail. Try after a
+	 * short sleep to see if the device came alive on the bus. Certain
+	 * Weida Tech devices also need this.
+	 */
+	ret = i2c_smbus_read_byte(ihid->client);
+	if (ret < 0) {
+		usleep_range(400, 500);
+		ret = i2c_smbus_read_byte(ihid->client);
+	}
+	return ret < 0 ? ret : 0;
+}
+
 static int i2c_hid_xfer(struct i2c_hid *ihid,
 			u8 *send_buf, int send_len, u8 *recv_buf, int recv_len)
 {
@@ -992,8 +1010,7 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
-	/* Make sure there is something at this address */
-	ret = i2c_smbus_read_byte(client);
+	ret = i2c_hid_probe_address(ihid);
 	if (ret < 0) {
 		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
 		return -ENXIO;
-- 
2.44.0


