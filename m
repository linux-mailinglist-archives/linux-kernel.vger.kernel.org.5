Return-Path: <linux-kernel+bounces-134300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B67889B010
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB30281E67
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16618643;
	Sun,  7 Apr 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JHGV5+Hq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GlSSkK2t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqEgif3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7F2GIM3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BD1803D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481893; cv=none; b=pOD9io8kaFT5KsdRjb0n/c1L8OKp/5b+4KVtkmw6kPbzNK5yXP+U+ELkTaW/omV58kWU6nMY5MjemXaNmke4gyOrtOovGh36tqPovNkfhk4EP2nWCo1E0ADHtf6QLEPPKUDJ+40J/4K04duKhl4qDCWmKs4ckWXN73O6+fwfFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481893; c=relaxed/simple;
	bh=XYZphytF9AR8KcBBDmN2fVv0DZs6f7zCKwOOdht76ps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MzyQ8estNjWD3Ai50jBRIn58EocImNgjJOwII+lYsV6hGLirq123kb0v/5zbB8G8CTBXVCQh8TjMIOZAY4ix+UAjelf2xrwN2d4ESjI1ubzrmxDbGY8ns2qixg7KARKnplsdHdbgALmi0apRRVQZghbbVWyWZlxVrTUsjVOTXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JHGV5+Hq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GlSSkK2t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqEgif3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7F2GIM3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD44B21B34;
	Sun,  7 Apr 2024 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712481890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=txYUBd75n3Jws+dLx4TpfNx6XOQtmVdIzZJDJv7/Xeo=;
	b=JHGV5+HqLcytt0sgkmJwaMzVhWT5e+OD5ydtGP+Nwvm5WKF6ehHv+UfCfU+FMU4Saw0wri
	pPicCWROfkfNxkCMqQDMQaW422gHoDR/4LFushOBMzVvGV2MYJScuJ1DdWq5kB3lta8Q62
	lmmdbPp7VCOAJYeA+pybPCfv2dd6ooQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712481890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=txYUBd75n3Jws+dLx4TpfNx6XOQtmVdIzZJDJv7/Xeo=;
	b=GlSSkK2tJ0AYMWIP/GbhVaLLuD+aj5phQ6BIvUs1sVK9MsoyYFQZGMHZg/2m0VTl1onXIM
	8kEGhc5O/hQ+5+CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gqEgif3O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w7F2GIM3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712481888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=txYUBd75n3Jws+dLx4TpfNx6XOQtmVdIzZJDJv7/Xeo=;
	b=gqEgif3OKeq01scdUCF4UpGqjYZKwu4qBcmHWqgLHX/U4Ll/Kb97N4HVonYvgn4BQT4jq4
	r6JrVpfz0Mof21QddfM/mDzdUOzTzmn2TPPOLbGd9vugSbyI3ucgnlZTpA2pc04ZdhKnq8
	CBBNq4NQY9c2WdDJGRS/47qv2mnJL4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712481888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=txYUBd75n3Jws+dLx4TpfNx6XOQtmVdIzZJDJv7/Xeo=;
	b=w7F2GIM3cozb06NYtjJObBkwbGo1bWvCk/CEVLGlqjA6Ll2uqweIktg2IvL9TOQgCf7CWt
	AMpeN2OkBkI1TxDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 65422132FF;
	Sun,  7 Apr 2024 09:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Qtd8EWBmEmaQUQAAn2gu4w
	(envelope-from <jdelvare@suse.de>); Sun, 07 Apr 2024 09:24:48 +0000
Date: Sun, 7 Apr 2024 11:24:45 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: Tidy Kconfig dependencies
Message-ID: <20240407112445.503bcbc6@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[16.89%];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DD44B21B34
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.51

Drop unneeded parentheses for clarity and consistency.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-6.8.orig/drivers/mfd/Kconfig
+++ linux-6.8/drivers/mfd/Kconfig
@@ -292,7 +292,7 @@ config MFD_MADERA_SPI
 
 config MFD_MAX5970
 	tristate "Maxim 5970/5978 power switch and monitor"
-	depends on (I2C && OF)
+	depends on I2C && OF
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  This driver controls a Maxim 5970/5978 switch via I2C bus.
@@ -458,7 +458,7 @@ config MFD_EXYNOS_LPASS
 
 config MFD_GATEWORKS_GSC
 	tristate "Gateworks System Controller"
-	depends on (I2C && OF)
+	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
@@ -473,7 +473,7 @@ config MFD_GATEWORKS_GSC
 
 config MFD_MC13XXX
 	tristate
-	depends on (SPI_MASTER || I2C)
+	depends on SPI_MASTER || I2C
 	select MFD_CORE
 	select REGMAP_IRQ
 	help
@@ -1109,7 +1109,7 @@ config PCF50633_GPIO
 
 config MFD_PM8XXX
 	tristate "Qualcomm PM8xxx PMIC chips driver"
-	depends on (ARM || HEXAGON || COMPILE_TEST)
+	depends on ARM || HEXAGON || COMPILE_TEST
 	select IRQ_DOMAIN_HIERARCHY
 	select MFD_CORE
 	select REGMAP
@@ -1418,7 +1418,7 @@ config MFD_DB8500_PRCMU
 
 config MFD_STMPE
 	bool "STMicroelectronics STMPE"
-	depends on (I2C=y || SPI_MASTER=y)
+	depends on I2C=y || SPI_MASTER=y
 	depends on OF
 	select MFD_CORE
 	help
@@ -2116,7 +2116,7 @@ config MFD_STM32_TIMERS
 
 config MFD_STPMIC1
 	tristate "Support for STPMIC1 PMIC"
-	depends on (I2C=y && OF)
+	depends on I2C=y && OF
 	select REGMAP_I2C
 	select REGMAP_IRQ
 	select MFD_CORE


-- 
Jean Delvare
SUSE L3 Support

