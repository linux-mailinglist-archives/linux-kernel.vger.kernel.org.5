Return-Path: <linux-kernel+bounces-156376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5E8B0216
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C29EB2443B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E884158DBD;
	Wed, 24 Apr 2024 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDRLUPLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A115749E;
	Wed, 24 Apr 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940541; cv=none; b=fwkjVHFoVxDJzziOLlum0MxemPjkHrfQC3vq2z+fFhseauYWXiMTcCqq7Fl4Wf/sZ+M+5VIndn3XUnmgFwMPgfxXTdp+SU1MAbxJkZzL/Jq5DmV720+fSj6xM3KO4FLUwo9frnjgwSwBAFHmRLaNdkAx/FzbaL7+NjqVGIZzJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940541; c=relaxed/simple;
	bh=Ur6Mwq5k3eb2nkdD2bgZyuoX+vud6tFhJdXqqhEBZ9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUhXQBiarzhpyH9NmvX4q7cMqiBKnQ1pLm20RN5z7EHB2oXrNHIVc8ZjtdCfNXVNMLtkhaRJQmkKgFxFS4y6uun90GC1nXFu0n1JXh3Hqm6ykz/6gzjfvuQhfGLOeiiHMqs77/d74vbdWn+PzOojgIqPoRHWZ4aH7H7FpukLaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDRLUPLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BF5C113CE;
	Wed, 24 Apr 2024 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940541;
	bh=Ur6Mwq5k3eb2nkdD2bgZyuoX+vud6tFhJdXqqhEBZ9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EDRLUPLcJvhWuamrXZ7Di4pDIzF+AeJnYu2ysGq4H8vft7bc6ZxTS3Lid/bRCyGnt
	 t29MYcDHwAnDGLxhDNo3u6rbJL/vuDTHjZalh1jAY5zwl658d+IXwAHiKZDG6ImjHV
	 UkM8sOYaiVrbNtinSOCmZoUWTA2GaHP6qIfthcw/Mkm0y0wqaO0PmKdmfsr/LWz5ae
	 GqyE+YkHxTS3KY7eFjRCTU8Gc9+kwlPTMd3FpS9IM+sJuWwF8BYgbOoX3Zom8WkZc2
	 De5uwhO5SnIV3mkd5/8OnSIqiWfYOpYXnY6WvmYiN3h2r6OZF+5bN2zAifmaydBagG
	 bEiMFHlQcFtPA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:38 +0200
Subject: [PATCH v2 12/19] backlight: otm3225a: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-12-1aaa82b07bc6@kernel.org>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=krzk@kernel.org;
 h=from:subject:message-id; bh=Ur6Mwq5k3eb2nkdD2bgZyuoX+vud6tFhJdXqqhEBZ9Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfo7bu7xOTYJd4xu78MNjpQFCsVQcpVt2PGe
 Dq2iEckJYWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin6AAKCRDBN2bmhouD
 11G0D/wILA8oLcbvIuxXdwPcnumJjOYb2f2CCq8MT2y6iJFasyu0KdtPsxP255aifCmYSyfoStF
 z4ypYX9kXVhH9okSb6OEHP8G7GoI+1z9HqMiOlK9kPS4ESKUx4oIzO6YXpr8euVy1nlOa2nCjey
 kIdHI7NqXuYzJUk134rTKVtht1heKAWW1BCBJFYNb+/fOCY8pVnrkztX3mkj92URX0oRipAFPO2
 RSaUUGLk8r7cZp/p7nPfa30ZN/GegjG0B7VWX4hUg+JDMoItwwIgmNRS4af1QSzXDhfhJ+j11eE
 8qZEbVC9D58LN3fvbzVSsI0v3mOhZIVm6bmy82qhlrz6EFJKQvqrAQLcaH9X5NakxqguDVVfPtV
 spMXAD3V/LMxWDhWpq9cOw5MeghArD84Q+TZHwIai7h2U1GgkNN8TLjwkCTXcLRpSZ7Z/x4nixL
 XTpevBoY1jK3opV6LXbYAX3BkYO4pEmLPFxwQYYfMqg2KA/h+ZDeonCQHTTUVSX4rAsesqnXyRF
 I+5pe4v8jPoSKBUczKAmhCiRxOAEmnTkiQZAUfYjf/5j1aHjtMKvUvXfC6Sl/XqGIJTDVkfOvBF
 RjxcNzc+X5DZac6x00KZeQCDxeNrrqaKT3Ov+ZOE3hiLYRvdDQ35r2C/XzKlg2WrQ92r46/KY9Q
 t1xENOlAL4KWu6w==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/otm3225a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/otm3225a.c b/drivers/video/backlight/otm3225a.c
index 4568020abf3c..efe52fa08b07 100644
--- a/drivers/video/backlight/otm3225a.c
+++ b/drivers/video/backlight/otm3225a.c
@@ -205,7 +205,7 @@ static int otm3225a_get_power(struct lcd_device *ld)
 	return dd->power;
 }
 
-static struct lcd_ops otm3225a_ops = {
+static const struct lcd_ops otm3225a_ops = {
 	.set_power = otm3225a_set_power,
 	.get_power = otm3225a_get_power,
 };

-- 
2.43.0


