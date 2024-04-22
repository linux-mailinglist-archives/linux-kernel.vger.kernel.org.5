Return-Path: <linux-kernel+bounces-153912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87408AD4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E82B21F48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6813156232;
	Mon, 22 Apr 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QsyvjeVu"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD415532C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813603; cv=none; b=hnkHjfQgqhQERNJqsq75dR3dqXJwd0SC4oTdRK36NVnNASrV6zneDDOyD+9giEauSn2KRcJh3W1ZtQzmK0/fADBsUg4pPms+IM/+RxO+haLw4Fh/IpxbLYCogDaL0EhhvNicFwbSA5hEaexvFBiwgEP3pPm8g2LogKXddMMxFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813603; c=relaxed/simple;
	bh=FKu2CUeypOd/48X9drHNO1XXLTwz2jJXcmw4HHbE7bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xm/iJF9TjRvtq9z5YaXCBBgj4+dqMS29Nid8fXV9kftCM4L2z8lPMyASul6F4f0z80stTpzVk5T0SEEXBlToKEmuuEX0DCeOcKUKjWkmHhAhY7yyLxV5Eu17yYIKGu6MnLQmt0skCdeMsZcvbnfthDmNeg/lo8Ds/qyH56RUWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QsyvjeVu; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLQX3xwwNRyCA4F+ralsXdsqs/AGr4cJodEaBXIoFjw=;
	b=QsyvjeVuiitreg+RWW5zNEO0mARwEUAThwgl8NWlzMIlg+avMtrHDWF02ExkLBvp7UVL+h
	08O6IqF3ZbI+8kcabTp/RGkYf71ZiQD2vIiQP73Fge5qR1nmhGqNOhJEDYUu6XSUJeGxIC
	MpjIkQ/maeZoUe876Jn3UkJNFENHTW0=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Phong LE <ple@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v4 9/9] drm/bridge: tfp410: Add platform module alias
Date: Tue, 23 Apr 2024 03:19:03 +0800
Message-Id: <20240422191903.255642-10-sui.jingfeng@linux.dev>
In-Reply-To: <20240422191903.255642-1-sui.jingfeng@linux.dev>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Otherwise when compiled as module, this driver will not be probed on
non-DT environment. This is a fundamential step to make this driver
truely OF-independent.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 58dc7492844f..6a0a0bbe3c6b 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -504,3 +504,4 @@ module_exit(tfp410_module_exit);
 MODULE_AUTHOR("Jyri Sarha <jsarha@ti.com>");
 MODULE_DESCRIPTION("TI TFP410 DVI bridge driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tfp410");
-- 
2.34.1


