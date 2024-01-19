Return-Path: <linux-kernel+bounces-31022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176188327AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664C02853BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C893FB04;
	Fri, 19 Jan 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Nu2l/pF0"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589A3F8F5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660257; cv=none; b=U63AIk+j+Y3+kISTAHB/vuaLddMyVW0yKMsUa27goVMsuBbHXxOBkW13Qcu/IGtpMUWNNefnNtvLw4s75ZOvBQMNlMxcj3dqb8+fEgyIuwI5OaP41GICv8ocpAGQDmcSR+i2/KZ7fNFpxL8DTvFzbfO4RcpDdANkWPHm66u7B68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660257; c=relaxed/simple;
	bh=PknrStiSFeg+3mCdlUNXpgCw2CuQmXxyTjIZlMddxGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLlVPb8bu0SLESKCGaVR6dh1tZjIzK31I9XCScMJS30UdZVYWpO1tO7mmyPYaM0iknOyXK6WGQUljliPgQLjmk5jxglGla/Qe/VP1p1gPln1+nIQI8xDtrVpwZtlVs+rSU+m+hwKK0aR8mzi3QWfLIuxWRwpFURgP4UsVVQDRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=Nu2l/pF0; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from localhost (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id C5A6F635B043;
	Fri, 19 Jan 2024 11:22:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1705659735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LttVVa3g+FcMM7+wKG/iSOZzeZ5h749vPmGrbkCjpb8=;
	b=Nu2l/pF0q6dusVkP/ar33zJYozomAOYl2Cw1WzBjw//WCvwH6X5QKUohAvvmGD+KKSrAtF
	2h4p2TuT4VT0glHtcO90hvQf1uhdjoewnmeL7ihlgv8SCtLowGZhomW7CwPma4xzm4+2I/
	O1KdE0FhZnDSTlI+eo/nx6E+FUCzBtY=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/display: fix typo
Date: Fri, 19 Jan 2024 11:22:15 +0100
Message-ID: <20240119102215.201474-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While studying the code I've bumped into a small typo within the
kernel-doc for two functions, apparently, due to copy-paste.

This commit fixes "sizo" word to be "size".

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
index bd61e20770a5b..14a2a8473682b 100644
--- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
@@ -52,7 +52,7 @@
  * @adapter: I2C adapter for the DDC bus
  * @offset: register offset
  * @buffer: buffer for return data
- * @size: sizo of the buffer
+ * @size: size of the buffer
  *
  * Reads @size bytes from the DP dual mode adaptor registers
  * starting at @offset.
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_read);
  * @adapter: I2C adapter for the DDC bus
  * @offset: register offset
  * @buffer: buffer for write data
- * @size: sizo of the buffer
+ * @size: size of the buffer
  *
  * Writes @size bytes to the DP dual mode adaptor registers
  * starting at @offset.
-- 
2.43.0


