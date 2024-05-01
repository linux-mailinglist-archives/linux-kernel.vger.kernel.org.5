Return-Path: <linux-kernel+bounces-164947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A808B8555
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9CC1F21180
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A004CB4E;
	Wed,  1 May 2024 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Su0SsbPE"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BF48781;
	Wed,  1 May 2024 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541551; cv=none; b=Gy6hAC5yBlZpi0qjlO/kewC0HqfhocqVwfEJlW4jNOLsyZqYXowfdfLXDadcBbtAKZ3pooyTYP9sFMoxoEkyIlvIzAXqMb6aivsRcvcIwA8g18aWkcUaTe/9QcWph5zmXR5Yzl0OiNRxeGRSlJzICI7lpMwYoO1W1r3sfYtzgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541551; c=relaxed/simple;
	bh=XGnwqzGVRVLKMqUxqhbPMjTk3pC1cEJXJekJTprHVbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7B8smJc+qBygTaL16I1elJwy8dYDPwqJtGvk9XFclyiqfjztidnY55l8rsQ3ObJC4Gbux0z5OIzKD6Mqabdz1xZ8TZ4iGgjuKG1KL3LqOEXUILF+VuLPmeWvHpWXRJGTTiYEZkeF5ThFszi8jVEvc5qUCk+1DCmRtcr6ctgG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Su0SsbPE; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 22YcsEsBRAF5O22YcsxtZ3; Wed, 01 May 2024 07:31:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714541469;
	bh=gkHbjdcpVGhYwhArziDiurlEAkgTgXQtE1ztZgQ3NT0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Su0SsbPEuir6j/Zux1shoe7hWU5cHbMmAjZeNs+AcGlPQSQzH6xK4g3hpG/lvEYMo
	 4PIs7R86sjYyJBuc8U4bGpMUTnaiLPi7jJq1qJYqDndXtMdUsG+Bg3UiMlYt2oEqzH
	 uLz1xQciAnlGsatK1tLkvNwo02V0pHtM7GQNygrpGOB443fIH8qyHwoLKojrFXi/hV
	 1AhKneC8872Xdz8T3HJkWr/NEf91mmgnvUyuPlBQuTTZdAbnsBAnJ39g5dghr/OGVn
	 ZvyOT1V7D551eaLhKwrldwt3LZdXQKLu0YFve9CyrMVNwAL5PfinnDdg+zo5Xt7nkI
	 ylq36OpLmWmHw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 07:31:09 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org
Subject: [PATCH 1/2] Input: tca6416-keypad - Remove an unused field in struct tca6416_keypad_chip
Date: Wed,  1 May 2024 07:30:54 +0200
Message-ID: <926c0f40040671565dcc54d5146a8f9511fb6d46.1714541432.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct tca6416_keypad_chip", the 'irqnum' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 30ba3ead0576 ("Input: add keypad driver
for keys interfaced to TCA6416") and its users were removed in commit
687fe7dfb736 ("Input: tca6416-keypad - always expect proper IRQ number in
i2c client").
---
 drivers/input/keyboard/tca6416-keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 677bc4baa5d1..044401d01bf6 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -45,7 +45,6 @@ struct tca6416_keypad_chip {
 	struct i2c_client *client;
 	struct input_dev *input;
 	int io_size;
-	int irqnum;
 	u16 pinmask;
 	bool use_polling;
 	struct tca6416_button buttons[];
-- 
2.44.0


