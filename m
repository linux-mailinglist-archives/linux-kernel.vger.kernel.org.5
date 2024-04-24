Return-Path: <linux-kernel+bounces-156372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B225E8B0206
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DF285197
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03D158A24;
	Wed, 24 Apr 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+zYdMiu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466A157E76;
	Wed, 24 Apr 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940518; cv=none; b=sIutf3Vw4850zM7IRJlF2PSzTKkKtQ8c2TBG1U65lRCj2l7B6pqyFX6EldA2O8pq/1hWdFbNeBjEw8xnMaZWdW0PMEZp+GIUZ1x4mtas4DKip6NQ1JLJNGTDrg3VXLTW1BDQjJLOP4/pe7ecIwALhgqGzK/XCtAgjSnotqm0poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940518; c=relaxed/simple;
	bh=CEfgA0oELJOz8zvb6Nr80IYQhRv6FJqaM9RUu8IYCmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWykBCbDBTX9xFdZMp1KWZcJvsQFbH3lvYferkYiWKBMXt4lp+O3TjDbF8MmRryoXk2lfsamLZcJQFYxcqzAfiJTBhYh6tNrtJzyZGeD86sxvlDDvDgis20hWWudenuG/D03Fwka+eYU6jvR3Z9sR4tnKd7qmxUfHM22mt0PAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+zYdMiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0647FC2BD11;
	Wed, 24 Apr 2024 06:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940518;
	bh=CEfgA0oELJOz8zvb6Nr80IYQhRv6FJqaM9RUu8IYCmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+zYdMiuoHmlUXAozP7JvGxs1/BBHVb6A/1Wqw7vQZQr5LIj8PWYVIB3QV1WaVQU4
	 G1P3W/QguqF0Nqz0M6BlN6LN2Ts+Y0FHyTawMGHFhU7CNIhHehyi9OvPeA9oFE45nU
	 qwIDKE8LAekD2TQExNA4cenh5Y8IVlJmE/2LqMGn3hWr9DIxAW7l5FZyNsLqPVgXQ1
	 XpbPvdo0j4q0mHQhkJ98lz0bYl1gGM+X8qFUDHRE5QQK+6IfWtGJ3+RK6YA1AvCcC2
	 uXmz7twI5Wb+CfTs1FhNxLta5pKlTQ5MUHdNavwXpYqjRivpVLKnSNzASpi0mDCbuJ
	 IKlufIurvZqqw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:34 +0200
Subject: [PATCH v2 08/19] backlight: l4f00242t03: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-8-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=krzk@kernel.org;
 h=from:subject:message-id; bh=CEfgA0oELJOz8zvb6Nr80IYQhRv6FJqaM9RUu8IYCmw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfk5EmRUP/OMskgfwTpVvJdKVOsnvbUPDtRI
 gZNsfKqLmCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin5AAKCRDBN2bmhouD
 1x9bD/41s1qi8ODzYh2QLVdEnCbY2bsumCATwNpDO2xtfAhQTtdQl4k1xitz39bhv9G00h5bkj6
 OQt+X7a03rrHVo1LcNMrsqPpftc885Vs1IrHBzJIAupROnC9L4CwMZ0IwrJmp/rsQ6keHApZCRi
 9NI5oQkbPbEowGTwqAy7zNSDymk7t3iF+hZHQJk7duCVgP6vyS3VzJB9oC9dxRT7H0iMvzi2/JE
 rxN14hl+n4lkb41Pk2YhnQew/nb3Pk3nQq0BfNZ7mCfJaQbn0yRTtX5ZXNkb0fdKsMCe3iCSErg
 F2379PJnhLpON4xKsVHS9JniHNhMx7obJaYSTfloXkPaDbXJT3+ExR479bS6zQIgsbrK0k6VcWa
 qk+ipGyyLnBoyugAwDnxKpJVbgWziUmo+VJafRgYdooCBWfB/veCOd8UdM1XhYEHCkaHl830UOk
 a6yLQlFyH407/Rb1ILfMHY3bpvrQ6dPZ8WOmpPFl129WkiB3nDL3Woc4K8oGS/w0QIVvACJtXiF
 IPxxBghC1k0l0mQ5vDqbKlvLJy3osYAXuAm5vVzHs+4icHP4p0QAfzvpG2S+BhX65J5piIEdQa1
 iEUKjU8JnzW7sMQQLN+iy4fpbTR7CclU8WsDqleSaoC49s/irrdQKbJjbmg+z3N1xHNSGasWPE3
 d57ifB/epA4UnIQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/l4f00242t03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index bd5137ee203b..dd0874f8c7ff 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -158,7 +158,7 @@ static int l4f00242t03_lcd_power_set(struct lcd_device *ld, int power)
 	return 0;
 }
 
-static struct lcd_ops l4f_ops = {
+static const struct lcd_ops l4f_ops = {
 	.set_power	= l4f00242t03_lcd_power_set,
 	.get_power	= l4f00242t03_lcd_power_get,
 };

-- 
2.43.0


