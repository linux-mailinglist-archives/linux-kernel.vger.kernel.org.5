Return-Path: <linux-kernel+bounces-144280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACE8A4415
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94F81F2131B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9D0137C54;
	Sun, 14 Apr 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXrIiOsz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB413665C;
	Sun, 14 Apr 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112646; cv=none; b=UqnZGX68yOFE5JdX4G4hxtH52H+mH5C1hVRfIZ0TKOW1fWxMBKB6BsNck1qjxTHe/tTZZ1//uAU0qXjx3PmKmtcst5UsXUaTAo7pliIRhgYCe8oJ+vixth/HX9o0ZP1dntWWTQeBy0Rv810nHxKDbAKU0F1T5/w+08O2GTWmr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112646; c=relaxed/simple;
	bh=72zXnNjUdpDz3J1EN0eijgGIcKOy+AlM1twfomkwYnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dg6vEMQrg7C83PjI4Uhsti2h3ZAz04BuE0bL6ef9H0qOg+GV+dCpo33/frP/FOHwujZNWPryuVcOxxLQTd5mGN2V9LiNC1plu99Z4ZgyNTO5zZxi5FOhsCQlIKpP//jdzROciadvZ3hbCLSloGOudGBiatzbgrMI5HWYxXecui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXrIiOsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4791C2BD10;
	Sun, 14 Apr 2024 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112645;
	bh=72zXnNjUdpDz3J1EN0eijgGIcKOy+AlM1twfomkwYnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dXrIiOsz9ay3mhzrL0bubMJEsvHQSskCxSc06c5ZTEni37BPqr2c6mYd774iU0tOr
	 GxPAoVYiCBZXnBAe/yPcIj3QKuXGvQ6W0IV0nDaVYiFtBkpffVet8oJjbAQ2iGCvFV
	 5QFTpzVQIIpXYUs5OFkxbyYnr0JAPMRQUilCyJ2f9+97p4jJ10TCftHRwIJlw6GXSI
	 lgk2GX3naud+nGW1UCxWEhGwLW+EAPXN1WU/obGv7XXEjPGL0mrTAWxUVGevztGKcJ
	 12Mm8uoJKucU/1zoRqILuvpEtOsVrHPJBl7A0iO4oN5hCNt/trYabB2ABE5wPkwDTn
	 aW8/fu4stLASA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:10 +0200
Subject: [PATCH 12/18] backlight: otm3225a: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-12-9b37fcbf546a@kernel.org>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=krzk@kernel.org;
 h=from:subject:message-id; bh=72zXnNjUdpDz3J1EN0eijgGIcKOy+AlM1twfomkwYnw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX9J08tTKsH8bkcCNd4a2dRxuCvVsUpu+71P
 I+QwkzyLVqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF/QAKCRDBN2bmhouD
 18qjD/9DlmbHY7O5ZDXMXqLVupRiQYh+N52BSEI7d9Kys+JjEz9pSzZ7R13XxnW2RNYglgnf3Bx
 mi+WTXOhSmpdotNq7WI2fXu1TsnvZC28i+Ufd+Uklk0yfsrJQKrnaD/vhiD21H1kBRH8/1b7NVv
 XL+0lXf7IiMjsAcTwNdmhPviyhQi3euKNkJ6uuKl7GICNQAuf31JVxcYjkJslyENDjHa7NdVk2J
 mnTwn0761xjqNvJz1pmZhXfmt9ViYzSYkkWY8HKZJQk0FaybDhqLZbMyjiTy/rM+AQCsCYuz9D7
 gJPVODPPA+McpdaXqA1rD2Rs3q2OZ05kP4sS3HqOKPHDDmk0Boim2Y2aQZ3ZDz3W1ngm727yXXU
 oBkRpSUfQXu5TQMxcMLxrnpbRfTHqwiHgrVKfCpVlBFyIZ0nPrnmhcAfluZDRKXzIXDPx4l39tb
 v/lUuYX6+PDlzE9GYfzkvukCBwwNo0O5/UfU4cs48YRSurmiRasycBAn08y/eoWCkzSkHkq81PW
 aNlvFMvEffamhCP/UY9zw74gcl9JVdLsVMA+rjzUbaV+YYTzxWmm1UuoCRwC/B5MpZ8S7rcYASz
 pwzKWcsafIrf7fZt+7FpBfV+6MsIWe4yofB39Bk75+9sd+BO0JQLsQyHPUCjtZu6e9RXvbd4IQn
 5qUMsk9hRj/Sekg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

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
2.34.1


