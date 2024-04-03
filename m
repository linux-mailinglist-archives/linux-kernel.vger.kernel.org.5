Return-Path: <linux-kernel+bounces-129794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE1896FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5086290E11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DD1482FE;
	Wed,  3 Apr 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fntAMqlz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7201482FA;
	Wed,  3 Apr 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150165; cv=none; b=GOuL+210I4KqfmU27fhlAaLRXjQ8obvUBojv6pBEV0ach1dquY/dRvbBRiXClx+tIXwg/7p192LrxOHWOB2ox6jiB6lt38y5nNy3mAoUeqk+2Nfxn1DcEbqg3mcCiJ+kp9sTUzctcTyRakOfpvlkwH2V/ywhtAlZ1X+QfQjtBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150165; c=relaxed/simple;
	bh=gf3MqlvAfPhm28HSeu0EfynLEsXAvdxpBH5JHE7FHqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5kcRleaWM+4NzvCYmYmvG26iIhcQk7u04rkJ/5rsmNCXgyHm1+8W6FnjlFOV250nYbLh2xxha8gLQ7QmJXXQKYrT/QcCONMUWrce9GDh53rLL8/efL2wn/4Lz252i0/29sHb4igJb5V5k8PRLIBv9kzrP0d1HYDH4gYIIi1Kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fntAMqlz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e293335cdeso5351755ad.3;
        Wed, 03 Apr 2024 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150163; x=1712754963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXX95CmikpvOlJoplD9duJ00qCkk0drRKIjEhwaSflw=;
        b=fntAMqlzlBAPPtNu0rQP4I41lldN51//+E886aU8z+aHh5T3aFQSbRUUuNzVZ0gvDO
         C0EZceB0q86w73fnAqW7uvw8O/NDpTRPPz6o26CqX5WJWGeunF8lLd0b5jqjpmn+ub0W
         V1RD3TKZKhXnnnysad8evrtcLDPp+e2Q5B+7UXJK6ke83cU44HOCJJ4M+SQYMXEqoG23
         Hk7+3P9RkGi5YTSHX3nBquIu7n36VH7QgLDFe7Dq/U25eVvmaCpOZj+9R7lmmpDkJ5OZ
         vrfh9ts7xPu5cmARJWkZYgynUCby2Gt7qqvtw9v6tlgeIinyPmB+J6IqXg++gdCiSCmq
         SLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150163; x=1712754963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXX95CmikpvOlJoplD9duJ00qCkk0drRKIjEhwaSflw=;
        b=IbQPuIUhPJqYiOetp8cQ6sTuzWKFHR3yGOa4i8gLN3uarZwVcMHqCQDSO6z7D5uYL4
         JkSdz2s48GlubpF2mbQ6QHL2zq5qqhBkZHtsRpQIMWflQPAUxifWEX03qKkYabXJLb+O
         mr5zAhssAGiCg8silONeL8cMld4/jgyqJDn2ElxGtnJPUcHFQsoh/yLIyC7JXOFyZbjQ
         qQ4UYKiQ7kTseiuS0+yMq1iwzGEo+Ocura5IP7lL8gkCXoLvs89/yR+bulsD/Xe32yo1
         V5FDvFSy2LlvGa+wGVUnHLivdB+rSyV0khvwYCaasewg72frSsAF6LPzge2qrUxunlap
         2FMA==
X-Forwarded-Encrypted: i=1; AJvYcCWIb96gZQQUJjxv5vt5JHQhdW0JuOZi4tmFrTCXJx2AB4Be6UwAFJSaRcoQfhiVbFOREgZxS14dMX5nrgXJJiHjtyPdFsjnsp0U07t+3nRLuOzZrOSZFLqY2LkEvZu2Iqr3YA==
X-Gm-Message-State: AOJu0YxVRUAgh6HSrRSHXXHI2kdP6wklOqWi+ZkTUFR8ChkKWaqLyNxY
	mxqUITC5KiihGwk+6eAH4sbppABxkn1ESAKpCX1ALdYbSxW17QDZq04weMiZ
X-Google-Smtp-Source: AGHT+IFII7xjAZ2WMYbgP6EAvRjyl4BRF21psXCT2xkIbfQfbEyhYdeCX9ffjFyoG7ZFQK+rKSDeEg==
X-Received: by 2002:a17:902:e94f:b0:1e2:59d8:be7c with SMTP id b15-20020a170902e94f00b001e259d8be7cmr4440000pll.25.1712150162756;
        Wed, 03 Apr 2024 06:16:02 -0700 (PDT)
Received: from rigel.home.arpa (194-223-186-215.tpgi.com.au. [194.223.186.215])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902784e00b001e010c1628fsm13417604pln.124.2024.04.03.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:16:02 -0700 (PDT)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/2] gpio: cdev: check for NULL labels when sanitizing them for irqs
Date: Wed,  3 Apr 2024 21:15:18 +0800
Message-Id: <20240403131518.61392-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131518.61392-1-warthog618@gmail.com>
References: <20240403131518.61392-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We need to take into account that a line's consumer label may be NULL
and not try to kstrdup() it in that case but rather pass the NULL
pointer up the stack to the interrupt request function.

To that end: let make_irq_label() return NULL as a valid return value
and use ERR_PTR() instead to signal an allocation failure to callers.

Cc: stable@vger.kernel.org
Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting the interrupt")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/lkml/20240402093534.212283-1-naresh.kamboju@linaro.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Kent Gibson <warthog618@gmail.com> (rebased)
---
 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f4c2da2041e5..8112ec36e55f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -730,7 +730,16 @@ static u32 line_event_id(int level)
 
 static inline char *make_irq_label(const char *orig)
 {
-	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+	char *new;
+
+	if (!orig)
+		return NULL;
+
+	new = kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	return new;
 }
 
 static inline void free_irq_label(const char *label)
@@ -1049,8 +1058,8 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return -ENXIO;
 
 			label = make_irq_label(line->req->label);
-			if (!label)
-				return -ENOMEM;
+			if (IS_ERR(label))
+				return PTR_ERR(label);
 
 			irqflags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
 			ret = request_irq(irq, debounce_irq_handler, irqflags,
@@ -1165,8 +1174,8 @@ static int edge_detector_setup(struct line *line,
 	irqflags |= IRQF_ONESHOT;
 
 	label = make_irq_label(line->req->label);
-	if (!label)
-		return -ENOMEM;
+	if (IS_ERR(label))
+		return PTR_ERR(label);
 
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
@@ -2224,8 +2233,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		goto out_free_le;
 
 	label = make_irq_label(le->label);
-	if (!label) {
-		ret = -ENOMEM;
+	if (IS_ERR(label)) {
+		ret = PTR_ERR(label);
 		goto out_free_le;
 	}
 
-- 
2.39.2


