Return-Path: <linux-kernel+bounces-145628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C489F8A58BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642FC1F21367
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A818126F1E;
	Mon, 15 Apr 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="qtN+DFJ9"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103C84FDD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200753; cv=none; b=LY6aVO876/oqJ/QXQNxn/uJuhZV2HGsOpthLcpmjsgSmbW7L6hBaHKrNn6ZftZjCDkSEJSE96PdUzjFSooBdBUFDZqei/5xF4h0cd8slwTgzqcRAbb2g4LFFIhSNY5E+XKMA/aakn3v4qZzJRZZjt9p9XB7QzHMssKeVD9J8i64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200753; c=relaxed/simple;
	bh=/owCXnojrcK1rPeZ+23v2V4Et11EpdLYIdz8dAbiBSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvv5LWUHjPi8sakILdszrnLkQmXHMGzPNffdE+sH0gISpGCSi8JB/63HEyvx3ji1VyLPgu3v8FTFrLDOk2xsTplwgJqqtUkvBCCElQXK5xXF7MCKvjv/THbxBZFJaPnRvp/1datVCDysk2fLKxQUMR7BSuRfvaqkzhYrygLJHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=qtN+DFJ9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713200750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WfmmS5PxSX5CFZyjQLLWweyw/cLTYP+dIZNO+as+8A=;
	b=qtN+DFJ9nSgl1ggQcGdR5Rvb8WamgFzvKuWuS14fqyLJx4Sq4xAGotXjRchgmVA2iOOwAe
	pU67DlEslVx3lk1UmdX+onUyiHOCKCmFxUKFpqBny+/Cvx90rR25p19EVVYfkv0TNMVt7D
	wb/+G9V2cTCDV0X7Bpt16GNF5yP45f/aYdeZbiIxMkzOIx+vQ7yTnN0ZNG0dnVI/R9l9Xw
	Icu/zw4MG/q8dZXQOlppS/M4WrTWkeQ6cIeHZ8la/tYdWPNo6X0oTpKWaztw5/ljy8+fD+
	s3rAc8TIARFNs6EH7DxZI/sUxnihXnzTXPa60ciQpLJB64+fhKNuVAZf02M32A==
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
Subject: [PATCH 2/3] HID: i2c-hid: Retry HID descriptor read to wake up STM devices
Date: Mon, 15 Apr 2024 19:04:12 +0200
Message-ID: <20240415170517.18780-3-kl@kl.wtf>
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

Some STM microcontrollers need some time after rising clock edge in
order to come out of their deep sleep state. This in turn means that the
first command send to them timeout and fail with EREMOTEIO.

Retry once on EREMOTEIO to see if the device came alive, otherwise treat
the error as if no device was present like before.

Link: https://lore.kernel.org/all/20240405102436.3479210-1-lma@chromium.org/#t
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 515a80dbf6c7..ac661199d2c8 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1010,7 +1010,15 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
+	/*
+	 * Some STM-based devices need some time after a rising clock edge to
+	 * wake from deep sleep, which in turn means that our first command
+	 * will fail EREMOTEIO. Retry the command in this case.
+	 */
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
+	if (ret == -EREMOTEIO)
+		ret = i2c_hid_fetch_hid_descriptor(ihid);
+
 	if (ret == -EREMOTEIO) {
 		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
 		return -ENXIO;
-- 
2.44.0


