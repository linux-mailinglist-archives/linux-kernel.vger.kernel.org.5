Return-Path: <linux-kernel+bounces-156368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933EE8B01ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C511A1C21D35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA29158211;
	Wed, 24 Apr 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC6lkDvd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190141C67;
	Wed, 24 Apr 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940494; cv=none; b=Az8eRozYv7C5AHqP6lnVbDXuHXeJj17CUyei/xR5n+gjUzpgDCvBNqwRPBVv2PlyY3RjPOsmKCz8szbyr6SG3jYtaQdiI4RGwq0k0cJ5IPW9a70xAYJOKK86x6nDw8uJcjW+l1dfnGp3TPv8zGbWWuY9sENKQ8o7OpPjvutMJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940494; c=relaxed/simple;
	bh=NVCidXNtdRLB67P8hr8y4kewhrswWSzn5zoSydb49Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPJMwG/tD30+RMiVG4OVwtj3zQmn08faLtnqvbKHFiffxa6PF3nS7PodppQFGBVau6D9xk0JVa8Tcr0G34zLLy6dYPmIR+KB6r15AaNV7zNq4f3R4zb2PQlzlg/Q3Pi8Gq0a/VVdVKXpyRdkTSdcU92K9ZlxJBPJRqaVlWNlXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC6lkDvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C2AC2BD11;
	Wed, 24 Apr 2024 06:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940494;
	bh=NVCidXNtdRLB67P8hr8y4kewhrswWSzn5zoSydb49Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iC6lkDvdo3BzfOZ8nC9ldvIdK46dWYqTj7Ei1w0kiM1hLFOBQqjX9Q+AEkXAk0SId
	 JFFUQ3/zjomsxsuy2i5UDpCJvm905n5OWon1sl/xnAnZ3EPaji9b2gngsSBfIUG5L3
	 eazCW23TY+79ys86Yc6s5lR0zXm/XHGE+uNHlSMCeHxMinvjqFGKSE+m13qn+2mF33
	 /OJVkdpA9omhddjTt9uc9j4Mqv5R16PAGCDXk9AdNdDmZSdGRBDEdwJoGvijZAU9+V
	 6eYw9rQZmTNoTtVy2ePy/DAVkuCWNSrqKYl9WH1laUVyYjs5jYzLdFR7Znvngi5h/M
	 hEpvF4df2hzKA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:30 +0200
Subject: [PATCH v2 04/19] backlight: hx8357: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-4-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=krzk@kernel.org;
 h=from:subject:message-id; bh=NVCidXNtdRLB67P8hr8y4kewhrswWSzn5zoSydb49Aw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfgTV/fcvZp74csJyRHQ2DjuVoXh0+Gqa6ko
 9yq+pZCo9iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin4AAKCRDBN2bmhouD
 18H6D/wKsHdxf4mP8bNrqmLewggNw25tOX/NDarTbpWMzhLhYBQVsuWUfeZbims5qUdVcfCKgKU
 uUDKWtk4ysWbvtR4YC6g78H21o3nHpjls2eobHLtHOhN+nGIxaovz5udv0SAs47B0o4uttyIjYV
 thMkB7o/QCavb17TcvHUxgCJ0C4TknD8TyzEAge1RvroPOnKlqOuFM438PopEt3aULPItS33CPl
 MKOKreOVAZ+cLqZX9RaCKcKPrNwMHVIF5hNjxrypuEDOuw/PjR/5FROh7n2sCyEG+jjnCrCMpoh
 sBXBDylYJ+h67DGMKCm96NX7hSX0SLPBiIctUxRA6FNvHNX3tRSKwDgUXKMU/jiPL1MpQfWW/Lc
 gFzrpDnSS9Nu+HYXWkfEDJBv/d+b0EYa1Vrg1A7HGjphhA1YNgR9CPjiKM36jXSQ0v5JA1HIPGA
 RTmsJFpjkuIGAcRzO7SQrHmqBnrgvz9XgBXUC6bpaDQyDWvsi+FfgIp3wneFVUybXAx15E2kBTg
 +N9CvmrtPRC/uqyu269Puqwjuf3k3slJ8hCMS79S+hs6h4kQTtlt+MtYyhGtzQDoUk9iychIMv4
 4vKKDxz9GI3AdeSU2PjgG7+bFN7OhvDkqD8JUg1OFeC3KiZqP+x6NrFGpG8VoQOkH78eHa/fial
 HOx8tAPlGRITEPg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/hx8357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 339d9128fbde..cdd7b7686723 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -559,7 +559,7 @@ static int hx8357_get_power(struct lcd_device *lcdev)
 	return lcd->state;
 }
 
-static struct lcd_ops hx8357_ops = {
+static const struct lcd_ops hx8357_ops = {
 	.set_power	= hx8357_set_power,
 	.get_power	= hx8357_get_power,
 };

-- 
2.43.0


