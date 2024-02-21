Return-Path: <linux-kernel+bounces-74115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47CD85D021
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80495285B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31E39FC6;
	Wed, 21 Feb 2024 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0AoillDi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE52B9B8;
	Wed, 21 Feb 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494727; cv=none; b=a6ABP/oR0b7d34Yxamu5ah33qywcNcSXOlKDqw/QB0O9X4PtBJaaUfpwVD5EMbLm8Di90bL4o2L1qj66I533mkSaNrFGlCNH6UVudWzIzysB24Vadz7IPP11tihITRWLqg9WFuv1ZdxydvpiRFxqzaMgrwpCengbf7VeGOQunis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494727; c=relaxed/simple;
	bh=mGRiv/m1ePlRL1YC8KEXlYdn9wXNyRW98wi++RwA94o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcNXrNHDQP0Iklg/PSoP5lld6PUDQxvprDkaWyp3KF/XYcx9QoygygqzfzjSvHK1XkcgS+ArcfaXVTNM+8Uj8bAY1TW2GcSHU2mxyYv8ooT1U0EJWQHQHG07CD2m0uqzbPvfOtfbD1u1oYWhhbz/oNfcTpzvYAI0cbDTmBSQWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0AoillDi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8PCwdblCqut/ML3KnTOH3qRXV1Ybferr3oAWvvLiw3I=; b=0AoillDislWUHM8umRGvZuVYN4
	oOwksUWzNafuHEbJxwZOlgc0WkdvWnaGM96QOVCP0y9RNiyyAuXfcDn3u+MqAUPiU39lp3z4wRNJA
	hyNKoG4WnfAaRffvodXFJ7MezbTBPRh6k9UId4ttCfeZOtRzx/qy+UPZwbC/zOVIxzoy03EBvIIfh
	6+7BepXlyljAJd6++7KXDx2V2oQi1zVnqpsm3qWk/MGGuMbcHSP+5SalWG6pxKshOufLbeDjDXGg3
	j/qGgDObum3dmwcRqF4ztyw33H42hT+grdDYtHJer0+TbnEhp1k1KGlJQvUSeZucXp+WELELuRZuA
	6L+wRJiA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfWW-0000000HGss-1E4z;
	Wed, 21 Feb 2024 05:52:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH] leds: lm3601x: fix all kernel-doc warnings
Date: Tue, 20 Feb 2024 21:52:03 -0800
Message-ID: <20240221055203.26052-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a short struct description and remove one extraneous struct field
description to quieten these warnings:

leds-lm3601x.c:73: warning: missing initial short description on line:
 * struct lm3601x_led -
leds-lm3601x.c:100: warning: Excess struct member 'led_name' description in 'lm3601x_led'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
---
 drivers/leds/flash/leds-lm3601x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
@@ -70,12 +70,11 @@ enum lm3601x_type {
 };
 
 /**
- * struct lm3601x_led -
+ * struct lm3601x_led - private lm3601x LED data
  * @fled_cdev: flash LED class device pointer
  * @client: Pointer to the I2C client
  * @regmap: Devices register map
  * @lock: Lock for reading/writing the device
- * @led_name: LED label for the Torch or IR LED
  * @flash_timeout: the timeout for the flash
  * @last_flag: last known flags register value
  * @torch_current_max: maximum current for the torch

