Return-Path: <linux-kernel+bounces-155158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C218AE5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8811F23160
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323D86134;
	Tue, 23 Apr 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="hoHRGL96"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357284FC5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875170; cv=none; b=O5M9zF+izjSLU2ONl+jHGB3H0O96oLQyLqjQl9Dn2vUMiI6vg3+o3tJIoKXsCzGq53Zv0prcmD1Bs005wpMVbnYj96OOIWp8B7Urv/oM250e2/PxLgyc6z7pCrORLxLM3bC/WYfvZh1mxlDdxTFp413oanb6Aicb6Kx5BJhYUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875170; c=relaxed/simple;
	bh=zynGQTuIFxXRQEi59otUwDM4ji/FKEmTQC80pJpa32Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bH4iG34TidAV9cRZvZF7/t1CJzQCiYq9aNicILkWMocLPX/Hgyo3FeofD9plhoaw1FZp+goAg+exdO1qXLiCsmOZ2PYuM+1A1SnyLh8Yk2xwHFrKtbs8kV3mZSpOdWEqD1ywskvbPgs3m9SonS3rBZm5JyxXZHBD2qF/udTNYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=hoHRGL96; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713875167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa97cXZFvKrCM3jeo6QEdrj3udb4p0ze6uH1S8/3A2k=;
	b=hoHRGL96OWQJJq1pbBIWueMeA5VH/1BT0MNoXLQN/iPZumyGudECGU6rnxeC2Bh/gWSgR+
	k84Uby8Y/K1JL/woO7RcPFmA7DDQbHZe8rb924rqWW6Kzz9CTQ7Ef6w4ebV4kuAF1Ju/Pw
	8F8kF354s/C30TSvxKo6CthuXlBng0wAtF6ws89znzqZVtsbGsCBHs4UovFQzKi2Y+jC19
	24egTTWSL665g8mUNcHkYe+JBsdCby6BFjBkiquremAoN2AahRfTVT6axfnZUIylaQNhZb
	nMb3NI8O+fCrCJ0z4u8H0Zoq0luqVQlBarD8gttxy+J3z76FswI3VCuYhgJNgg==
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
Subject: [PATCH v2 2/3] HID: i2c-hid: Retry HID descriptor read to wake up STM devices
Date: Tue, 23 Apr 2024 14:07:54 +0200
Message-ID: <20240423122518.34811-3-kl@kl.wtf>
In-Reply-To: <20240423122518.34811-1-kl@kl.wtf>
References: <20240423122518.34811-1-kl@kl.wtf>
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
command send to them timeout and fail with EREMOTEIO.

Retry once on EREMOTEIO to see if the device came alive, otherwise treat
the error as if no device was present like before.

Link: https://lore.kernel.org/all/20240405102436.3479210-1-lma@chromium.org/#t
Co-developed-by: Radoslaw Biernacki <rad@chromium.org>
Co-developed-by: Lukasz Majczak <lma@chromium.org>
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 515a80dbf6c7..252ccb3b71d1 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1010,7 +1010,17 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
+	/*
+	 * Some STM-based devices need 400µs after a rising clock edge to wake
+	 * from deep sleep, which in turn means that our first command will
+	 * fail EREMOTEIO. Retry the command in this case.
+	 */
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
+	if (ret == -EREMOTEIO) {
+		usleep_range(400, 500);
+		ret = i2c_hid_fetch_hid_descriptor(ihid);
+	}
+
 	if (ret == -EREMOTEIO) {
 		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
 		return -ENXIO;
-- 
2.44.0


