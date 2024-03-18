Return-Path: <linux-kernel+bounces-106029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A887E7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97932281CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2886374C6;
	Mon, 18 Mar 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkCcUqQD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrMEe3/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEA3717F;
	Mon, 18 Mar 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759556; cv=none; b=c2jckpN3x/KjUn1FLgEOyGYvMmFzpNKJRyyKXsYhLBB8V5korVOGRqhObCmpyVjQRcgOj6S7LWeTdiseD1ea7kC/MMc2nwe8vAPI2cLj1zlqPst7S0TjEZqiRxAklG1YGVAAaQsM/Mco9Actk+zeIuA6ZXrMp+arm3N7mxJ2jLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759556; c=relaxed/simple;
	bh=bnv9GxdH+9sh2HzsViiXcBSRCqU6wGTdI+qvgucpP1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QLXSkr3LJX5ROca0I3rSxtKAdrLSZBbiJ25OCdLYksascUL2VUCqQ/XEORW+liOQurw3NBOwczP1IQsvnzipxMVsrVHz8RwYDlfNuTWjED5FHGXWimjF3Rh3GFmjh/5ZOSINNzoJ/CO4SD4sCB05H0uxxeMaXn1MPiLDbbN9qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkCcUqQD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrMEe3/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710759553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwoqE5c/d4fnX36fLkMhWRVTFmnpaAtys7VA/YdALZA=;
	b=TkCcUqQDiEoPHPuz+0CnhI/vi4E5sXMJLnrZESkM4pCnteOuHxgjgPtfeU9pG6XmCNywGS
	QhS69Dw6T3M/WCFsaEXAFDGrQVJHkP7YmyEaVDoi8ewxGFDFKwZFeNQpXdZcK/dM0B4ZrV
	QcJj08bH4+MzJWCAv8NJCT5pkYM62o+I+OxSTBw+hM8tx1u7w1Es1nWRl96rN8IQzOU3jT
	pc8l7TCliGx7MhYYCAlMA18h8aUsRbs6v9S6ZyHmdF7J3xVtLBO7vPUBmjmla0T+y5zefm
	A7jbRdfSZGlMY6KNViVNN+CemPqmo8Ddu7Am3vuJzUcHrBJsie7l+uYQ+X+SMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710759553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwoqE5c/d4fnX36fLkMhWRVTFmnpaAtys7VA/YdALZA=;
	b=DrMEe3/1nse5uSWum6w0Q36ZOmD8yZCt9exDMo6PYeGcJQxYYK/4FC2i2Sqt5E4lroI/pa
	IjnHzxeWUkisD4Bw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Nam Cao <namcao@linutronix.de>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eva Kurchatova <nyandarknessgirl@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up
Date: Mon, 18 Mar 2024 11:59:02 +0100
Message-Id: <20240318105902.34789-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The flag I2C_HID_READ_PENDING is used to serialize I2C operations.
However, this is not necessary, because I2C core already has its own
locking for that.

More importantly, this flag can cause a lock-up: if the flag is set in
i2c_hid_xfer() and an interrupt happens, the interrupt handler
(i2c_hid_irq) will check this flag and return immediately without doing
anything, then the interrupt handler will be invoked again in an
infinite loop.

Since interrupt handler is an RT task, it takes over the CPU and the
flag-clearing task never gets scheduled, thus we have a lock-up.

Delete this unnecessary flag.

Reported-and-tested-by: Eva Kurchatova <nyandarknessgirl@gmail.com>
Closes: https://lore.kernel.org/r/CA+eeCSPUDpUg76ZO8dszSbAGn+UHjcyv8F1J-CUP=
VARAzEtW9w@mail.gmail.com
Fixes: 4a200c3b9a40 ("HID: i2c-hid: introduce HID over i2c specification im=
plementation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-h=
id-core.c
index 2df1ab3c31cc..1c86c97688e9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -64,7 +64,6 @@
 /* flags */
 #define I2C_HID_STARTED		0
 #define I2C_HID_RESET_PENDING	1
-#define I2C_HID_READ_PENDING	2
=20
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
@@ -190,15 +189,10 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 		msgs[n].len =3D recv_len;
 		msgs[n].buf =3D recv_buf;
 		n++;
-
-		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
 	}
=20
 	ret =3D i2c_transfer(client->adapter, msgs, n);
=20
-	if (recv_len)
-		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
-
 	if (ret !=3D n)
 		return ret < 0 ? ret : -EIO;
=20
@@ -556,9 +550,6 @@ static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
 {
 	struct i2c_hid *ihid =3D dev_id;
=20
-	if (test_bit(I2C_HID_READ_PENDING, &ihid->flags))
-		return IRQ_HANDLED;
-
 	i2c_hid_get_input(ihid);
=20
 	return IRQ_HANDLED;
--=20
2.39.2


