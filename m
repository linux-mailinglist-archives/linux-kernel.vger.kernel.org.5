Return-Path: <linux-kernel+bounces-164974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D6A8B85B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB68284450
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842FB4CB4E;
	Wed,  1 May 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PMaUfxN7"
Received: from msa.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858F31A60;
	Wed,  1 May 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546203; cv=none; b=jFOdnGaAz+IeHmPsxbkZaEiABaqKY9dY2edrJDFVK7lPUtIcfSsp0ZuaineQqDtb/HrC6C1+39NAWyg8J4HhGgLgn9B9G25+ChDRci1GApljXADog1U2CjeWS0UzdOinKB83V/pdC83CEdGvAGnd2/bZGJYN/AB01YmibJnDncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546203; c=relaxed/simple;
	bh=t23Emc2T1F1Cw/U1i0QRPENn/kEZ49dN8BCNoYSr1nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kpi5u2kiPmTgkaJh7t6TEg0TmaQOUzMMD7lhmHChIITFlBK3+hZ4fr59u64/MorpUztE66NtBURRsOYePTSq4iyfqHirsXm8N1bSCffQN+iOEsvTk8hQwJc+sPC/6BzuS5dm2hM+QWvLWoQTNBj0BLtyRmiBVtQIFnmg89sJ0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PMaUfxN7; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 23mvsRdFGq0Jb23mwsJg5c; Wed, 01 May 2024 08:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714546198;
	bh=xs+ZSpS0xVgBzBgXMojspa4y526RrOlky1cQlAdEKM8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PMaUfxN7fFAFoo7WAACYZc6MGZ1L2dp6k5zscZFxZ37GdlgxPwuq3VZMJZ3u5uWwf
	 jCZ2X17Ixi1lVYxvQKZcTPv3Vq4lls6AzhTNjtqZbb116ABLr++XG6U2TajmkXBQLj
	 d48fqCfUX4SLC7dCmxxi0bD+znrjFzgsNHw/+8c+Wprym5FKbY9kHRBKGUFCGsYe7s
	 pIyun4gS31fiXkJhrVuWXt3Jk46x5NnwI2uv9H45u5a8OPa7VzI1prK28FwIR1rlos
	 Gjs1E0wnKnL3a4wi3Aw3+ak3RTon2F4huY9tBBjUCO08JrkGMmvJDItxSmOtZMLkqJ
	 r0jfS/jDOvQog==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 08:49:58 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH] Input: cros_ec_keyb - Remove an unused field in struct cros_ec_keyb
Date: Wed,  1 May 2024 08:49:47 +0200
Message-ID: <6bab1449c01c4537aa2d9cb4481e1d5da8aa2389.1714546173.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct cros_ec_keyb", the 'keymap_data' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 6af6dc2d2aa6 ("input: Add ChromeOS EC
keyboard driver") but was never used.
---
 drivers/input/keyboard/cros_ec_keyb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 30678a34cf64..12eb9df180ee 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -35,7 +35,6 @@
  * @rows: Number of rows in the keypad
  * @cols: Number of columns in the keypad
  * @row_shift: log2 or number of rows, rounded up
- * @keymap_data: Matrix keymap data used to convert to keyscan values
  * @ghost_filter: true to enable the matrix key-ghosting filter
  * @valid_keys: bitmap of existing keys for each matrix column
  * @old_kb_state: bitmap of keys pressed last scan
@@ -50,7 +49,6 @@ struct cros_ec_keyb {
 	unsigned int rows;
 	unsigned int cols;
 	int row_shift;
-	const struct matrix_keymap_data *keymap_data;
 	bool ghost_filter;
 	uint8_t *valid_keys;
 	uint8_t *old_kb_state;
-- 
2.44.0


