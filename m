Return-Path: <linux-kernel+bounces-5562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38781818C45
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB621F2586F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC120315;
	Tue, 19 Dec 2023 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rybegmk2";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="neTMlc54"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8961D54A;
	Tue, 19 Dec 2023 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003465; bh=4Uv9T6s4wh/LXg7ZHtJ7w1pHCYlvw7d96NQ/caKWDUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rybegmk2K2ZQ80aClNkJqaX4WobeLc1uhZ59Hd5Tt2pvEuY8f9HtbrUEeiVfPS6SH
	 5lv10dohxVDqSY5i+bs7k6I29kLrJSVKQsTLKNBTFnN0BVHM0TwfVSq4gnyOg4vgUq
	 aH83fRaxbtiFKD5+9dQJ7z5xJ1vieroN3wVTrUzxCre1Mee0PcEnq78zZ3K98fC+8u
	 IgGPn/0M0ESF8tHGIH6+a+G0TVd0/ZInrZGdw91OajP0U8a2L85rjEnYAajlUhINfR
	 u4fqP2Hmtad7ZGzcLvyHtBoAf9wYm3GZ+5Lx9/w0d0HNaY32OTPOQexp61pCQ5lode
	 84/aesFtEA1ag==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 4271A100A09; Tue, 19 Dec 2023 16:31:05 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003448; bh=4Uv9T6s4wh/LXg7ZHtJ7w1pHCYlvw7d96NQ/caKWDUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neTMlc54I0LBHj5Fn1Lz/nCDT4Tryb2AuIsu883fcLTKXbapZkwKK2zRoWD39vlyp
	 2DIdh0CWqvprloHwErCYArkB1bw5EzpMjHhMYSCoUTLUI4HXYYP04CkEK9EcUc7Ho5
	 diWvEQkgG4dCljbLPjlrgU8TnZordJKcGzqLA3gBui6pbpFgXM7wofVat6I0A+w6nr
	 cSp9i5R+1g++1CCoKZ+QF9fFSeqYQ5ZYCF62M5TW69ZTBaQvKxV32BnvvhSZl4fLYj
	 bmuON7OOHC8OsFpXXokxrI4/V09MmegC47U/P9MAdsY11aRZEwl1nLQqIjAicxQAiV
	 P8ZjuK/laKeSg==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id CC10E1000CC;
	Tue, 19 Dec 2023 16:30:48 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/6] pwm: renesas: Remove unused include
Date: Tue, 19 Dec 2023 16:30:26 +0000
Message-ID: <c0960122653739a9ff6e4e90f6dceeb96819f7ac.1703003288.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703003288.git.sean@mess.org>
References: <cover.1703003288.git.sean@mess.org>
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


