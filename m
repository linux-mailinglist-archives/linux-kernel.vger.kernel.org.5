Return-Path: <linux-kernel+bounces-143342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339858A3769
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F70B244A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D815217A;
	Fri, 12 Apr 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7GOo4FD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA514EC53;
	Fri, 12 Apr 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955464; cv=none; b=dgFWBHYj7Xb0xo6+B8KS07ybhBaK4fczFliVjFhJaFqSDHUUf/E+M+nKk0QQRt6r3hbNQrtem5DD+V8odW31i400NBaosoxV+N3eLeb8QbowlASaDpM83pxV6sVqGwIKE7DIy1Zx/rUXCqXCmYinUBdjHAUrrVux8e4e4pjflX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955464; c=relaxed/simple;
	bh=yybN5H4oObHCkRDUf64BlOIl6XPndTde/wZ7hvtw8Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqaOX27Fh1EYA30J8azeP/PPoEz9zRkw7n3ekhC/NNpCmcMfIayZoM7+6DtlfP7iMUF/6smAOprNOt1c/B6hJZIJN1D7WSE+96j1LkJI2Cj5WUCZ7JkjHzS1cWU1AJqafwWqjrcKdVyfD3SRXQGddPzaHApUPTQHeDjCPpPI3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7GOo4FD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343e096965bso773402f8f.3;
        Fri, 12 Apr 2024 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955460; x=1713560260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFTL/XPS8muIk2z9FaL0yqV+OQccgX5te3Uc7bDfhtM=;
        b=I7GOo4FDbQtIGDc8wbQuCmQkqgsPF8YDrcXqWNYKQdoBfb4g1BuaAviVvuff8r+Ise
         6+M3/PTQPSFas3ZFynHMkUbrfVTqN6DI7eMU+CgJDNzp1M2tQQiwBoVAzsO0yf2XTLWH
         ZaYP3fqZ+KxVbM7STXDd1M3U2SwjEBI31Xa23W2XFTn4TQqHzYvzhV5ofeNw6xT+2jak
         dsfzq6gjOWVesYwE/vxjXTCzFSu9a2yESgdSvHh7STgV2xlz/CtQCk2EqbmRHFdYZn51
         MeT0AOsqej25o+5tiM3pzIGY3LLj3NKIh5MzR5XpUXI8h7ypbUFkeE+U8uOB7b/WSGf3
         jp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955460; x=1713560260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFTL/XPS8muIk2z9FaL0yqV+OQccgX5te3Uc7bDfhtM=;
        b=IaiH2hSPj7Gfp/QJ3mdA6B2OQzfB8ZVH9DVM3D0B1JchSBp09TB3J/3Qv3EZHQmPgK
         tLqqVr1RQ3LFXGb+9sBh3KCGkofCwOWuyNCrz3iE2EJbeABfmyj4i0ygnhL7ClMd9CQk
         iAtDsvSI/haCNjh67J0/qpLQ7gxN99e03PxFvmIiywSRc65U8lQ88yiMlNZKXZQW5Jy6
         AnUjpf2PuiF5ngqAqbn9X1D2q8OwiT/moVyR8nKPn2E+RCJ8QYhp11DTtVyJ/isBcQvO
         WELyTP8JXi+otdZj4D5mW1YX01KOWruWj6f1bf5q0LONluTjOJf3sI8LqlFnQ2Nuwfzi
         e5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUgHhuY0yu/JteadlAg2aYveVq+jcK834x+rMAOM7PTfNESKSt8lKbs8aV4Zv/G9BVX08FV6e6MxjmlDC8x8UrHkSjZmE3rOBUnXFie
X-Gm-Message-State: AOJu0YxHS30jt6LiQ5mrsKORViBg/Z+2asCbT1mI+ReM7AAqlWQBowZK
	53ZzB+h2iU+CSiBkhkwZYElhTLHEwmdd17rF+n1juXxvaJl/6NZktfQuuy1X
X-Google-Smtp-Source: AGHT+IFpNo0IogBt5RQ2X11DQ1uFX5es7IxiMnKitgncxozqISbP/ErHtQ+WkjGYStx7sr8zu01odQ==
X-Received: by 2002:a5d:6087:0:b0:343:7abf:1a9d with SMTP id w7-20020a5d6087000000b003437abf1a9dmr2951826wrt.14.1712955460471;
        Fri, 12 Apr 2024 13:57:40 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:39 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 12 Apr 2024 22:57:32 +0200
Subject: [PATCH 3/6] input: gpio_keys: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-3-dbad1bc7ea84@gmail.com>
References: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
In-Reply-To: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=1502;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yybN5H4oObHCkRDUf64BlOIl6XPndTde/wZ7hvtw8Ro=;
 b=O1UMvpZsBrIYBxTC1o2mBCdut6xW2jrGI78N8KoibCQ0F6QmYzmhrcHtYofTYe6hVE8jJd6pf
 qHlQHbCw2twArYji/Lhb9irL+MOMLkdZgaGMZjk94YQcRua2tycS2Ax
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 9f3bcd41cf67..9fb0bdcfbf9e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -768,7 +768,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 {
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
-	struct fwnode_handle *child;
 	int nbuttons, irq;
 
 	nbuttons = device_get_child_node_count(dev);
@@ -790,7 +789,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 	device_property_read_string(dev, "label", &pdata->name);
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		if (is_of_node(child)) {
 			irq = of_irq_get_byname(to_of_node(child), "irq");
 			if (irq > 0)
@@ -808,7 +807,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button->code)) {
 			dev_err(dev, "Button without keycode\n");
-			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
 

-- 
2.40.1


