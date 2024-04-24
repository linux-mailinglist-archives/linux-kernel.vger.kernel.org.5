Return-Path: <linux-kernel+bounces-156367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A68B01E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A90E1C22575
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255301581EE;
	Wed, 24 Apr 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qshTr3Fb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5036D;
	Wed, 24 Apr 2024 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940488; cv=none; b=VJ+T+4YoaCPPfdXFNM0sXxcNS7+3Mv2uG8x3WDp0RZtsDUQgwXRYx1bkQIXTAa9e5DY8BJI1UBmq/71BzukWx4v0em+FaBtKBBWASKQPt1mqFgWMykRkZXL1ZI7WrODVR0+t1cwngoVn0vLD0+k/BHu4XS0T/Z6/EG/cmAiTE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940488; c=relaxed/simple;
	bh=NOJTom4sl0/r1j3Ss+jlqEt3iVwaP7N8FtTfssrmGJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UlmIswyRvQBHlii3/sdAf0RTYWmXOSgHWLXnB5Lu/m/EMmIhE0my0lePDx20/9afGgIqntE22vEilEiSF/1OM6DWJSoLHINMUWofDYVnhC+K/fPe4q8tkZ0SK/t4t2mlK5k2Fn+cXvjuTiWIjgfV87e0gmn1QGtuETLW1XVacCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qshTr3Fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E5C2BD11;
	Wed, 24 Apr 2024 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940488;
	bh=NOJTom4sl0/r1j3Ss+jlqEt3iVwaP7N8FtTfssrmGJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qshTr3FbpLI37jm2msIZjP7kfx8Tj2e5f6X2eCHqQ6gMxWGzLOBVk0pASOGa5sIOW
	 qKKdHN4DazQZBcMsN/NWJJvOLfCfubRm+4k2tOMCkdhE9hxkPukTW/f8dJ6HVVBuMQ
	 CEV4kNznmpwWf805EK+84Y76gn7WOj72hyOAnMDwaJvIbOyvMqoQxilgGy9v2mTNr7
	 Kf1VaN4XDp602S3W5t0SxKjrvwDU6Wo+VDrKZf0jmUwVAtYg3H7761gSynU26sMnwv
	 gEHAyXMcF8R0qAY1DCrirSSJAtp6s2SKA0X2cIVcGY3tsZK2kfhsGcQ8FmhZct0C3r
	 Zp2+TSjSyzhAw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:29 +0200
Subject: [PATCH v2 03/19] backlight: corgi_lcd: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-3-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=krzk@kernel.org;
 h=from:subject:message-id; bh=NOJTom4sl0/r1j3Ss+jlqEt3iVwaP7N8FtTfssrmGJs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfgAPBA13t4hzc75iF/9FhP/Ffy3+J0VROvv
 MQNlaGrdtSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin4AAKCRDBN2bmhouD
 1/I7D/9XENRlRBegukAR77dNn4HXPFTEUPEWKP00rQUchnrH4Ek6XbJiPJhcqD7lpz+YgLuRH1E
 ZtwQjfnlU5sCXl6G96L0EOVFdoLY3d+ht9IUEq0YGWxETNXLo5LhcnKIHTsUXWCTyhK+BI0oWyg
 gefS8iyjbuHgZEVTnODJQHFf2QsBWMuYBbjN4ibKS2hlsfeMbnG2hxMwQBYPieLC07M3RodDasn
 EjAqGnv16vtBo0TxHvn52v0bEzlugqgJJoPVtNWCtP64P3LWa6fbDrKfNIfE/W5xWYoTv73c44y
 FLa+cepeGiJej6sGZAUV+BBynGu2PHsICNlAm1vpreNep5S7r9jyBzl/0TnCeRuGZpZFm5EHzjX
 pf/ySG74FjCGokORdhS881hIf45atIpEwI8IgUzPZvgMfAtapHfIxPAtFhJWCghWHwOi6AMEjHp
 gmUrizcjO1DSPitHURvdz67bii8kQTIej7i2tE+IJfQYyEMCswqZX3n/TjoHpmeyCqscMIGObax
 r9Lft7ZwdEbszDdIW8DGRxryk10kIjKCnDOMUMj7nCG4o4QFqCdp07yCIvLLUj6e9SzOR68qyEJ
 8l3jO/b24veySctfWPbFUSg1UoAaiXRikqRP3HTtJ+gnneCnEUPC3RdsHMFWaksB7WoufEV27vu
 Hz+tElu8ckY7frw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/corgi_lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index dd765098ad98..aad1680c9075 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -380,7 +380,7 @@ static int corgi_lcd_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static struct lcd_ops corgi_lcd_ops = {
+static const struct lcd_ops corgi_lcd_ops = {
 	.get_power	= corgi_lcd_get_power,
 	.set_power	= corgi_lcd_set_power,
 	.set_mode	= corgi_lcd_set_mode,

-- 
2.43.0


