Return-Path: <linux-kernel+bounces-164946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A28B8551
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617F8284A34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D016495F0;
	Wed,  1 May 2024 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qwz3qeDO"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E60481A3;
	Wed,  1 May 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541543; cv=none; b=UY2UtZ4sFK5Mv5iWjwffKD88BPTEFdRUc1kGkGWLUuHODWfFUbKr57y7i+kwFu279rRqfIDe3ZQWamBDJG+dHLfjKeWFfFntPoJxkRcD/cnqdAUa2YSEjhV7r0thglt+rXUlkugrVoJ2WGEsvGQ3ZXyrykgmbBII8yRF/UQozKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541543; c=relaxed/simple;
	bh=ArOXPy7P1rDCISOetC7udZv3vahyD59OFDoMpu2TJss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb3XbVpkKmZkDTizkLPwiEi/s3zXBEBcsTskVtGpZhQ7H2JHWFUWouSRvA1BDsocEsQISoaBL+pndV82kTcB3sh+Dri2SdRjxR9N40pJRWd0rdtf85SO0AOeukU2XPyQnRRgA3+Iz4IAu+g9J6OMJgP0Al7szn06zduJF9M/Edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qwz3qeDO; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 22YcsEsBRAF5O22YosxtZt; Wed, 01 May 2024 07:31:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714541478;
	bh=PKg24I0LA3FDiDUWAMdwYK2Up/UUtvN46WwgU2Vuv+U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qwz3qeDOGFZtq2o1uiGHa2FXUydYvXEJCRia7jopwBrhcbjIOfFU0aKIOz5OjJBwl
	 VlqhfRhpiK2pMCjHkOjpGjmBfm739M2qcXOaGlD1rsA7v/KDI7x4v0k4fblgNKdLhh
	 VJb4+wX2NxcpVblrZTNGg4utZFgiKqSdmh2RJidzE5HlzzSQBHjrjaxXQPW0w8p3fI
	 SLDGXVHMbJOm/BYWOSdwfc3Cim32m5/1Kdm7yo26ScUJSbTlxpko6RlDShJpSAiVBE
	 jzGYY2zM/1H62BLeqh4FxxfQpA/hWQYnO00uyv0lecRt6Q7ChPTpCKoan+gmhTp67Q
	 2AJIG5SBL0mzQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 07:31:18 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org
Subject: [PATCH 2/2] Input: tca6416-keypad - Remove unused struct tca6416_drv_data
Date: Wed,  1 May 2024 07:30:55 +0200
Message-ID: <3e6fd1d0875ef3c90ecaab7adf7fd4a5e8e6f708.1714541432.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <926c0f40040671565dcc54d5146a8f9511fb6d46.1714541432.git.christophe.jaillet@wanadoo.fr>
References: <926c0f40040671565dcc54d5146a8f9511fb6d46.1714541432.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct tca6416_drv_data" is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 30ba3ead0576 ("Input: add keypad driver
for keys interfaced to TCA6416") but was never used.
---
 drivers/input/keyboard/tca6416-keypad.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 044401d01bf6..fbc674d7b9f0 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -32,11 +32,6 @@ static const struct i2c_device_id tca6416_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tca6416_id);
 
-struct tca6416_drv_data {
-	struct input_dev *input;
-	struct tca6416_button data[];
-};
-
 struct tca6416_keypad_chip {
 	uint16_t reg_output;
 	uint16_t reg_direction;
-- 
2.44.0


