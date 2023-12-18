Return-Path: <linux-kernel+bounces-3214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A081694A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DD61C2262E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8326F125B6;
	Mon, 18 Dec 2023 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Q8Q++5gh";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="VZANn3yQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BC111A1;
	Mon, 18 Dec 2023 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890436; bh=4Uv9T6s4wh/LXg7ZHtJ7w1pHCYlvw7d96NQ/caKWDUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8Q++5ghCmF2m4LEceslU3Tkgl3mmWb2WZuc8OQ+tuuFW/NseyyesI/r+aqOo6RxW
	 zJfIh6EhLECuP1rgJ97JqIv+KPY/r2bEmCpsiUy+DAq+8G08ZfZadZFIBlgfvHX6N3
	 eUIanTzwcjF4F6pUuwxWjLlhzxWxp2t5uzVV7hWOKMFXYvcC4i6PRXnCqQ823A3faN
	 as5fNmFmxwxNrw+2vGEUx7JYmdnbxnIfmnK5NBnQpsb79xcyehGhM+sbSifVxRBRX7
	 AWyr0vR0mhkBQLLj9D/sG0J5ilDVm7Mg8wHRPD6jPhm8taoZjvJOBbOUHF2/APG26y
	 IwD0UHTOzgJwg==
Received: by gofer.mess.org (Postfix, from userid 501)
	id AE980100A00; Mon, 18 Dec 2023 09:07:16 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890420; bh=4Uv9T6s4wh/LXg7ZHtJ7w1pHCYlvw7d96NQ/caKWDUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZANn3yQEyw65xlkedEQD3QAHxG8/Oyqw0lIhoD6YcuN+B3IBtgNEWv80iTLycZ23
	 d4nJTNK5CJoCnKSDjP+N7x2rkgxHyf4+TYvyC0xW4rTNpfyriYwgMHdJ2ZZ8YCoSZs
	 S9RTBhtWAUOv2jcnAKlO/jMWkeEMD8+dYcTMY6+9ygh6jUtl6npONx6BwI+Nm9xh8Q
	 ge5FiYXgps6T4bGX25SUNs55g/VuyEYoZ5Hs7oAyzPlIgwupgjxaulcyrFjPZQZ3uO
	 CSuGM0VwRkCHTSXMbRpFjPl/qjjWGmp1dZKOQfXSjScsMirvAo2NA4Cnj7SNudgJd+
	 ZhxHUGJE1VPOg==
Received: from localhost.localdomain (bigcore-79.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 436401000CC;
	Mon, 18 Dec 2023 09:07:00 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/6] pwm: renesas: Remove unused include
Date: Mon, 18 Dec 2023 09:06:44 +0000
Message-ID: <c0960122653739a9ff6e4e90f6dceeb96819f7ac.1702890244.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702890244.git.sean@mess.org>
References: <cover.1702890244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No mutex is used in this driver.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-renesas-tpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index ce92db1f8511..28265fdfc92a 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0


