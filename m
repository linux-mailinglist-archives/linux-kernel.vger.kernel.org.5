Return-Path: <linux-kernel+bounces-86223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3C86C1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3351F24C47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C04595A;
	Thu, 29 Feb 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y+5fl9EG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59444C63;
	Thu, 29 Feb 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191178; cv=none; b=E2eF4J9vhTXADdSJHcMCY4el5Ns+c1lGrEo/JQfkKQfosoQGJTzN93LRsLo8nsf0XKPf8vDsq9TipLsvj1wL9jemXPos9NySC5HxvPyYTpcdl09o+m92o3t0tJW1C8xDo5Sh4N/UKomSmW08EdKW3wHpk47EGf6RD/yKmn2QoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191178; c=relaxed/simple;
	bh=eR3NtE9MXtWW4Zw3NEsGxQH+GyzrzX8HIKqT3LM5NUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwwzlVWL+sfHei4one34M7sqBBSDnqppEtDYX1SBJBzdDn6jOccMHICrFpvVg3a2yxukEjnj/l2iP4Z/4L14YOhAE09dc/XOlEnAm453hYJwqpj3N6OpYNsrYy92DC8QdFT1r5ptXQvWgCqH2E1J/OcVRNHuH7J0D3tjeh/3gV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y+5fl9EG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yn+LDoAkyjMCRYlmC4iTNINlHwVp0l0T/r2Qk9tY2v4=; b=y+5fl9EG4wfZksZigWU6EAPC7s
	nvfRcP5rK8X35hGsHagpwydSunswNSU1tk+ANtFwqDOZUWT6JEAlusewcg33oB89opdo12A3y6PIL
	KUvQayRTjlUXpAHuclvUSpPqILRtSkpimlBqEPcfDMksZJoC6b2YQojwO46Op9BMVtoF4ApGcZ+9y
	knuSQMAPDcEB5E08nHqVyfhOf2DR9vqoN40EXE5LJmMWONOOByMsHCWOq0MoDpAdu9t20x3jeQ7H/
	cpRPx3/43yM9IfkanRTCdkI5Eyf4wmfBs8ui7ck+c6WGo1VlfOVJ8yYOP5+KKaCDMq9c6yqC0XO5K
	coTE3XAA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfahb-0000000CRbT-0Sah;
	Thu, 29 Feb 2024 07:19:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 1/3] leds: lm3601x: fix struct lm3601_led kernel-doc warnings
Date: Wed, 28 Feb 2024 23:19:29 -0800
Message-ID: <20240229071931.7870-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229071931.7870-1-rdunlap@infradead.org>
References: <20240229071931.7870-1-rdunlap@infradead.org>
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
v2: make the 3 leds patches a series as requested by Lee;
    make the Subject better/unique

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

