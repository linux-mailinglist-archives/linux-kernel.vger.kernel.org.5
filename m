Return-Path: <linux-kernel+bounces-671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E29814442
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BCBB22952
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191DF1865A;
	Fri, 15 Dec 2023 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xls5bJBP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67118C38
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3363aa2bbfbso343542f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702631390; x=1703236190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj6QtZTA2I0OVS+eyi8MQNjFWf+Es3zCzRk8YMwznmA=;
        b=xls5bJBPd6wAQc8FBf36ZQ47pAy1fS3D2xg+Ra9KtLkmJODqFGCezyaYlCgozQPsoV
         LtBzgj6k3A1v2bf40jWm8l7jU1ekdDYHUqHZjU/JydJ2RmgGE4UHYBKEQbbVBznv+Prx
         pUxvw579yP6vbXXwQHL8VncSP0NXsztLczkhrkaIDGaZF93RODDlzy5vr1XNX1a2EF7l
         0EnTbtKQK/FyykEShJnJduOV286sktAxkZRQIwqCP6pwGt99HgdRbbue5MftXK6epa9N
         1xmbB0cQnnSwR7+IOMwtAjcPJFctCcEpMMaaBwnRwreIjxpALWr7liRs+6p1JAWbLLmR
         L90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631390; x=1703236190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj6QtZTA2I0OVS+eyi8MQNjFWf+Es3zCzRk8YMwznmA=;
        b=aDNPqrd5OzdpRD3zM8tmDfWaq7XaHq3QI9L7PcIfbv+Yzwt7PHZBlbLiPttAtvengP
         Cs6RXIZJghq/KyQg9LwI/gj89xJAmjU4tRCLxm/vqMrWtoJHHxSQCR8V6TV3zhRg5xz3
         xk8CuU3g0T6sX++FHpfRL4ANWBgqEVYNFfiSeG/kdDYkUnMds8r8YQIJXyCn8Fu/tZ7W
         YHJoXYtbDcjlFGIY8A4NOgLq+VkdHZv5+w6+GTIcogklFEAHA+YOex4LmFzSDcVN9mJP
         M1CesXz4TngsdyotLP6fzQ5FBxV9CaEQDnDVwUyVtcsxp3FD7S7zX71Ti03OkZzlxKcL
         QR/g==
X-Gm-Message-State: AOJu0YyHcdF8AbB85n4cyIRUkoUuP4j++Bz+fbjE9YBGkLr2CYEM3d3u
	UHr5Tj3uhNEDng5t4a8Vmql5Zg==
X-Google-Smtp-Source: AGHT+IE51RhOZGeMS6Ncp3Iyk1Or4Fb83Y1h5+77AWpU6uraafcxHJqLd7paYhdMn5mNyR6TmnegBA==
X-Received: by 2002:adf:f391:0:b0:336:42a8:4fcf with SMTP id m17-20020adff391000000b0033642a84fcfmr2186459wro.32.1702631390043;
        Fri, 15 Dec 2023 01:09:50 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8672:e2c5:37d9:3743])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d458a000000b00336463625c0sm4178706wrq.51.2023.12.15.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:09:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] gpio: xilinx: remove excess kernel doc
Date: Fri, 15 Dec 2023 10:09:43 +0100
Message-Id: <20231215090943.9245-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The irqchip field has been removed from struct xgpio_instance so remove
the doc as well.

Fixes: b4510f8fd5d0 ("gpio: xilinx: Convert to immutable irq_chip")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312150239.IyuTVvrL-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 823198368250..7348df385198 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -52,7 +52,6 @@
  * @dir: GPIO direction shadow register
  * @gpio_lock: Lock used for synchronization
  * @irq: IRQ used by GPIO device
- * @irqchip: IRQ chip
  * @enable: GPIO IRQ enable/disable bitfield
  * @rising_edge: GPIO IRQ rising edge enable/disable bitfield
  * @falling_edge: GPIO IRQ falling edge enable/disable bitfield
-- 
2.40.1


