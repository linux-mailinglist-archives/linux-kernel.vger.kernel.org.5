Return-Path: <linux-kernel+bounces-156377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EBB8B021A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70451C22156
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D9158DCE;
	Wed, 24 Apr 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewnGq0po"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90410157A46;
	Wed, 24 Apr 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940551; cv=none; b=O0/R/ak32ee3Hxf1PyKUSkHI8jLRLU+unphsAqjD8+jlrVx3sGTgPXr2bUuVBWl8sqSMs9UFdEuCR9oTn1pYrqe4AlJS+owpZrepDpKbJI5q6ejXvgy/FC7A4T+VgXIZAyA2UkBAZOX+GZnvQDpADPzciid/iGGcQodlJidVFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940551; c=relaxed/simple;
	bh=4qoQGYmdNWiD9RfbIvJFIJBVJ1Ici8hCHnU6hL42oy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/eYKA9/bET9ZHEd+GWtqgCD+gxS/W0E3UKL+yxS+ihf8+z7khJ+8NXUgo/eQyGb/gHyaR8kTnsCmMuPZweujfxFQJH8B0tOKFnNXHoWQ5Z+mq8hUceR9esHIHalfQd5EOG2PdEXhJiSv3uE8V5MpuwwzmQx0qqsCW2SDs/EuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewnGq0po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2842FC113CE;
	Wed, 24 Apr 2024 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940551;
	bh=4qoQGYmdNWiD9RfbIvJFIJBVJ1Ici8hCHnU6hL42oy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ewnGq0poDy9+TDkQUCpSjdelbeZOwP5u/2jtCcVn9sekYyxWc2Oq1drSz3f1G4utN
	 5/2MAISA2cd7xU5CUjs/eUZL1ywNQX4OHSg7CNJ+KxFlLLQ3U63DrRNf+oUlyGdBzk
	 XWlsGb6qiacCJQTSfDIMOdaWvdADVJYgEwkmEJxDCQ5JAui8e8ze8L/m8LU/8PEWUf
	 GiXT4q23SUX3BcBPcQYyM1j9EoibdDN52kjDrs/Y3V0jvTlm7xwq0axK7pGYoUNv2W
	 fdlv/MJ/BHrfs3ICVzrXwen/jW9cU7YymyqX5c9a2xMC1YOi3qvww1Z8V4WdVd/hr6
	 E7aYQiJQgSoxg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:39 +0200
Subject: [PATCH v2 13/19] backlight: platform_lcd: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-13-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=krzk@kernel.org;
 h=from:subject:message-id; bh=4qoQGYmdNWiD9RfbIvJFIJBVJ1Ici8hCHnU6hL42oy0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfotvXMS26Bm9o16qYnTMjLHsAaBX/IQGlmI
 Is1PMn2p5iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin6AAKCRDBN2bmhouD
 15OWD/91gLK/6GvyELK5f5l5DdJs11mnTF9xOVpPVb9dGvHZmON4jZturAsHjNrrSf5/+UWXoag
 W110QTksE4yQebupLAvPZGChnEr/zculm00ZuVHd7iKEjwhOqSDvx16YeknDKXhSoCIq8Hpm7IW
 kx4SvvyHnTSp9BsOy2UzPYFZOCp9UD/x8rOBao9PfjFhvUyUSLvJRW+nBm+2XdKxftCxH4lnqzm
 B3a7fIhODTTv7HR40r/4IJA3UDUUIzKdkQsiAqQMzRbXa7dW9MAdpi2Z0OfDw+hlmxI9VWwQ/5w
 Nh9Eq5Upyrt9ffRej6I1iE9dAdWNdo3t+CI0w1nuP9e14gU1HJuXSDjnne5cZsW+HbkMYsHVB6U
 PZxzeo9mJWHNhpzNbLsDEe711CGGbxHqv68grIgghaaneo2IjYCA+/Ra/zIREmXdryiIpjM5DKj
 g9sa0/iKja0TSHG6pQ7L4srkGK/tYww0UljQ0etcmhYqpBqacFcZ/eBwBfAoqrYHzhIsdhI5Sr8
 ArFz17c7yonyAqjSrCB5mayXbkLf1Hx8AorvuqAdFsEVMd8ekpIDYQgFG67tU8h6Iqeq0+Sxf/L
 Dspo+RTgkkErsqn+ajU8L3KZk8fy90VYTFjyZgnOis7hJDTKm9CZOWAh3NTnl7IBXcrg6nwVsML
 CJTFjQoJfdE/+zQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/platform_lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index dc37494baf42..76872f5c34c5 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -62,7 +62,7 @@ static int platform_lcd_match(struct lcd_device *lcd, struct fb_info *info)
 	return plcd->us->parent == info->device;
 }
 
-static struct lcd_ops platform_lcd_ops = {
+static const struct lcd_ops platform_lcd_ops = {
 	.get_power	= platform_lcd_get_power,
 	.set_power	= platform_lcd_set_power,
 	.check_fb	= platform_lcd_match,

-- 
2.43.0


