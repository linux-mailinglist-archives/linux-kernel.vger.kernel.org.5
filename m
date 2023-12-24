Return-Path: <linux-kernel+bounces-10754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8381DB4C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E86E1F21907
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6C1A5BB;
	Sun, 24 Dec 2023 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPrQvliA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B218EDD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2698eae0a9so378941566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432689; x=1704037489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fVNG4Y8BtKOiiWYZzA5tpbOxA0mNOHdL3iVKTq8o3c=;
        b=iPrQvliAaOxW7nbmBOVOeBfxHCUv+I2dNqyDkA3VZfHv7XQMhwxJBU0I3c81+l15G2
         TEa3dRt89vlO4okt/lpbUPzo+ijRE/dTpCB53Ccga+ndw1QmwkbreiOFxe1Tn9gisgfE
         ww0TqMOIx8uMg/BSHDWdc6a2HbaP/ioXTiJtvoUMA5aHe+ANxHB1I15nm540u9pgMqp6
         FbRx7QTfY+SVvLeXxtK/x6/mAcX67/VZ5MB5BGCbCHloaxGzBMhQSnqTrLejkLF06Vsz
         1R7l4Y184NjgJeNZrOsiKoCnGluSg98zqOBTyYBDCh2wavu08PkdNP71bDsCZYdaWSGJ
         PbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432689; x=1704037489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fVNG4Y8BtKOiiWYZzA5tpbOxA0mNOHdL3iVKTq8o3c=;
        b=pMBqlRtl5aHWL6ZsxEJR1quZjRUmtqIIVsUIOprToysSdtu9mWu65LvyT6K2BzVg5E
         eLaI+UCbaKmyEbPxDOaPKBRV0iP/zDwPwsBk1npg0VFExcN4gS3T2lwZOBw1CICIPPmz
         iPGmy+JtieTiRGRMpBiL2TjO37aPLGi4qJxQ/kqq3H5Yk8VOhwy71DtYVE0lb3Te6f6J
         RPvmMQyhySium40munyhYDzOdAwtorL/uPKWujfsBxeN3/aqPRYInla4MpYaRdSNhvbc
         UL2ZVnqevfHhsF9r66qUArBP7oF6uqU475AtJWQLcuwaAO9mz8zcv0yjE5ECci/rlDcG
         lsdw==
X-Gm-Message-State: AOJu0YwUy29WhgzC1dhK47CrM96yUrvKUOsUgLFYrfjFlYrH1NSFxal3
	3uN/m8NjGgwjdoucnJQVZactNt8k7HfXkw==
X-Google-Smtp-Source: AGHT+IHUFyGWrmseIr3JUDZ9dc9UtbQmz0vxAekPKcFcKPleItOlE7UVPDO3yuSk4SS0FfXFvzrlRQ==
X-Received: by 2002:a17:906:549:b0:a23:6258:bcc9 with SMTP id k9-20020a170906054900b00a236258bcc9mr2005321eja.64.1703432689199;
        Sun, 24 Dec 2023 07:44:49 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:14 +0100
Subject: [PATCH 15/15] media: s5p-mfc: drop static device variable in
 s5p_mfc_pm.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-15-a3b246470fe4@linaro.org>
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Aakarsh Jain <aakarsh.jain@samsung.com>, linux-fsd@tesla.coma, 
 linux-samsung-soc@vger.kernel.org, 
 Smitha T Murthy <smithatmurthy@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=16454;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hxNRpET1TD7wWdvfDUE12WprGqdoNFx+n/H4LB7+u3U=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHbN0m9OIqeTiRrH6SZ36lxQUr5mM+jMmy/w
 vmnzQcPf2aJAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhR2xAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PXm4wP/2kAVl3TGxBeMbzCR4c5E3CpbdGAG+iAprZBp+xXhv2ndG4
 xW9+dg/vrnASrfFQJEXd/QtmgVe9+joCGv9ULMcVc9e5NroL9XsFago9t89gzBc348N+EgiwK33
 xbuQcnpAjnyLXgJlTVYphb9Tvu6dpsa93SUhFdEWMhEFbbIud5Y5upjVJxq+KsPkZCHIjVAom0q
 8H9ly5MNARySKhAlsHLXMy/Ib7muzp6uEW8r6llcpYw9spLBPsLdbDegcJpmN++KdfkbfCBb1L3
 PP2tW4C4NoQBJr1NkN+cYnqUTKji+FGzEhQrL7+RBH+QJDgoJPjMEHUMx8Ft3e359FYKAvIfPAZ
 LISmEPE5cXRvTFt6NAWBZ92aeyqrxXcA8a+hjt64aq/2pfD6XJV5iyD0Fcb/Dy1Obr116yJ4ob0
 oBRYQaxT2dn1ehmh6Aht4Hr3BT3M0PdmbBtbp1lr15T+z12ogkR3GUepLz8iJJpMp0OyxKRpRdg
 Jj+kbaS2ajLSJiYOjoxqNMi8z1LUuFPNdIJ1IQXUSGjKvboWYrK7ck/ejmSPo8ftePaSrDXKbcX
 PLiHf1g/p+4MssPi5ti/1opbASfr7sZnIJTUEsKJm/iVbz5y+mkplIWrfyoxhnn6bxbiNk+gYw3
 T7GPS3AN9HHzSupqh2HTnzYk5B28PGZGPvIZc
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Change the interface of power management functions in s5p_mfc_pm.c to
accept the pointer to S5P MFC device structure. instead of relying on
file-scope static variable.  This makes code easier to read and modify
in case more devices are added.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   | 42 +++++++++++-----------
 .../media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c  | 26 +++++++-------
 .../media/platform/samsung/s5p-mfc/s5p_mfc_dec.c   |  8 ++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c      |  4 +--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c      |  8 ++---
 .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.c    | 40 ++++++++++-----------
 .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.h    |  8 ++---
 7 files changed, 67 insertions(+), 69 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 5d10c1cb8b92..f0bda2f7f1c2 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -183,7 +183,7 @@ static void s5p_mfc_watchdog_worker(struct work_struct *work)
 		mfc_err("Error: some instance may be closing/opening\n");
 	spin_lock_irqsave(&dev->irqlock, flags);
 
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 
 	for (i = 0; i < MFC_NUM_CONTEXTS; i++) {
 		ctx = dev->ctx[i];
@@ -211,9 +211,9 @@ static void s5p_mfc_watchdog_worker(struct work_struct *work)
 			mfc_err("Failed to reload FW\n");
 			goto unlock;
 		}
-		s5p_mfc_clock_on();
+		s5p_mfc_clock_on(dev);
 		ret = s5p_mfc_init_hw(dev);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		if (ret)
 			mfc_err("Failed to reinit FW\n");
 	}
@@ -393,7 +393,7 @@ static void s5p_mfc_handle_frame(struct s5p_mfc_ctx *ctx,
 		s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
 		wake_up_ctx(ctx, reason, err);
 		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 		return;
 	}
@@ -465,7 +465,7 @@ static void s5p_mfc_handle_frame(struct s5p_mfc_ctx *ctx,
 	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
 	wake_up_ctx(ctx, reason, err);
 	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	/* if suspending, wake up device and do not try_run again*/
 	if (test_bit(0, &dev->enter_suspend))
 		wake_up_dev(dev, reason, err);
@@ -509,7 +509,7 @@ static void s5p_mfc_handle_error(struct s5p_mfc_dev *dev,
 	}
 	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
 	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	wake_up_dev(dev, reason, err);
 }
 
@@ -565,7 +565,7 @@ static void s5p_mfc_handle_seq_done(struct s5p_mfc_ctx *ctx,
 	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
 	clear_work_bit(ctx);
 	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	wake_up_ctx(ctx, reason, err);
 }
@@ -601,14 +601,14 @@ static void s5p_mfc_handle_init_buffers(struct s5p_mfc_ctx *ctx,
 		}
 		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
 
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 
 		wake_up(&ctx->queue);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
 		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
 
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 
 		wake_up(&ctx->queue);
 	}
@@ -636,7 +636,7 @@ static void s5p_mfc_handle_stream_complete(struct s5p_mfc_ctx *ctx)
 
 	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
 
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	wake_up(&ctx->queue);
 	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 }
@@ -688,7 +688,7 @@ static irqreturn_t s5p_mfc_irq(int irq, void *priv)
 			}
 			s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
 			WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-			s5p_mfc_clock_off();
+			s5p_mfc_clock_off(dev);
 			wake_up_ctx(ctx, reason, err);
 			s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 		} else {
@@ -752,7 +752,7 @@ static irqreturn_t s5p_mfc_irq(int irq, void *priv)
 	if (test_and_clear_bit(0, &dev->hw_lock) == 0)
 		mfc_err("Failed to unlock hw\n");
 
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	clear_work_bit(ctx);
 	wake_up(&ctx->queue);
 
@@ -837,20 +837,20 @@ static int s5p_mfc_open(struct file *file)
 		dev->watchdog_timer.expires = jiffies +
 					msecs_to_jiffies(MFC_WATCHDOG_INTERVAL);
 		add_timer(&dev->watchdog_timer);
-		ret = s5p_mfc_power_on();
+		ret = s5p_mfc_power_on(dev);
 		if (ret < 0) {
 			mfc_err("power on failed\n");
 			goto err_pwr_enable;
 		}
-		s5p_mfc_clock_on();
+		s5p_mfc_clock_on(dev);
 		ret = s5p_mfc_load_firmware(dev);
 		if (ret) {
-			s5p_mfc_clock_off();
+			s5p_mfc_clock_off(dev);
 			goto err_load_fw;
 		}
 		/* Init the FW */
 		ret = s5p_mfc_init_hw(dev);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		if (ret)
 			goto err_init_hw;
 	}
@@ -927,7 +927,7 @@ static int s5p_mfc_open(struct file *file)
 err_load_fw:
 err_pwr_enable:
 	if (dev->num_inst == 1) {
-		if (s5p_mfc_power_off() < 0)
+		if (s5p_mfc_power_off(dev) < 0)
 			mfc_err("power off failed\n");
 		del_timer_sync(&dev->watchdog_timer);
 	}
@@ -959,7 +959,7 @@ static int s5p_mfc_release(struct file *file)
 	vb2_queue_release(&ctx->vq_src);
 	vb2_queue_release(&ctx->vq_dst);
 	if (dev) {
-		s5p_mfc_clock_on();
+		s5p_mfc_clock_on(dev);
 
 		/* Mark context as idle */
 		clear_work_bit_irqsave(ctx);
@@ -979,12 +979,12 @@ static int s5p_mfc_release(struct file *file)
 			mfc_debug(2, "Last instance\n");
 			s5p_mfc_deinit_hw(dev);
 			del_timer_sync(&dev->watchdog_timer);
-			s5p_mfc_clock_off();
-			if (s5p_mfc_power_off() < 0)
+			s5p_mfc_clock_off(dev);
+			if (s5p_mfc_power_off(dev) < 0)
 				mfc_err("Power off failed\n");
 		} else {
 			mfc_debug(2, "Shutting down clock\n");
-			s5p_mfc_clock_off();
+			s5p_mfc_clock_off(dev);
 		}
 	}
 	if (dev)
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 6d3c92045c05..8eedf6524c39 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -215,7 +215,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 
 	/* 0. MFC reset */
 	mfc_debug(2, "MFC reset..\n");
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 	dev->risc_on = 0;
 	ret = s5p_mfc_reset(dev);
 	if (ret) {
@@ -243,7 +243,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 	if (s5p_mfc_wait_for_done_dev(dev, S5P_MFC_R2H_CMD_FW_STATUS_RET)) {
 		mfc_err("Failed to load firmware\n");
 		s5p_mfc_reset(dev);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		return -EIO;
 	}
 	s5p_mfc_clean_dev_int_flags(dev);
@@ -252,14 +252,14 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 	if (ret) {
 		mfc_err("Failed to send command to MFC - timeout\n");
 		s5p_mfc_reset(dev);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		return ret;
 	}
 	mfc_debug(2, "Ok, now will wait for completion of hardware init\n");
 	if (s5p_mfc_wait_for_done_dev(dev, S5P_MFC_R2H_CMD_SYS_INIT_RET)) {
 		mfc_err("Failed to init hardware\n");
 		s5p_mfc_reset(dev);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		return -EIO;
 	}
 	dev->int_cond = 0;
@@ -269,7 +269,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 		mfc_err("Failed to init firmware - error: %d int: %d\n",
 						dev->int_err, dev->int_type);
 		s5p_mfc_reset(dev);
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		return -EIO;
 	}
 	if (IS_MFCV6_PLUS(dev))
@@ -279,7 +279,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 
 	mfc_debug(2, "MFC F/W version : %02xyy, %02xmm, %02xdd\n",
 		(ver >> 16) & 0xFF, (ver >> 8) & 0xFF, ver & 0xFF);
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	mfc_debug_leave();
 	return 0;
 }
@@ -288,12 +288,12 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 /* Deinitialize hardware */
 void s5p_mfc_deinit_hw(struct s5p_mfc_dev *dev)
 {
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 
 	s5p_mfc_reset(dev);
 	s5p_mfc_hw_call(dev->mfc_ops, release_dev_context_buffer, dev);
 
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 }
 
 int s5p_mfc_sleep(struct s5p_mfc_dev *dev)
@@ -301,7 +301,7 @@ int s5p_mfc_sleep(struct s5p_mfc_dev *dev)
 	int ret;
 
 	mfc_debug_enter();
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 	s5p_mfc_clean_dev_int_flags(dev);
 	ret = s5p_mfc_hw_call(dev->mfc_cmds, sleep_cmd, dev);
 	if (ret) {
@@ -312,7 +312,7 @@ int s5p_mfc_sleep(struct s5p_mfc_dev *dev)
 		mfc_err("Failed to sleep\n");
 		return -EIO;
 	}
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	dev->int_cond = 0;
 	if (dev->int_err != 0 || dev->int_type !=
 						S5P_MFC_R2H_CMD_SLEEP_RET) {
@@ -384,12 +384,12 @@ int s5p_mfc_wakeup(struct s5p_mfc_dev *dev)
 	mfc_debug_enter();
 	/* 0. MFC reset */
 	mfc_debug(2, "MFC reset..\n");
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 	dev->risc_on = 0;
 	ret = s5p_mfc_reset(dev);
 	if (ret) {
 		mfc_err("Failed to reset MFC - timeout\n");
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 		return ret;
 	}
 	mfc_debug(2, "Done MFC reset..\n");
@@ -404,7 +404,7 @@ int s5p_mfc_wakeup(struct s5p_mfc_dev *dev)
 	else
 		ret = s5p_mfc_wait_wakeup(dev);
 
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index eef26d4e02cf..b620db8896e1 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -477,7 +477,7 @@ static int reqbufs_output(struct s5p_mfc_dev *dev, struct s5p_mfc_ctx *ctx,
 {
 	int ret = 0;
 
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 
 	if (reqbufs->count == 0) {
 		mfc_debug(2, "Freeing buffers\n");
@@ -514,7 +514,7 @@ static int reqbufs_output(struct s5p_mfc_dev *dev, struct s5p_mfc_ctx *ctx,
 		ret = -EINVAL;
 	}
 out:
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	if (ret)
 		mfc_err("Failed allocating buffers for OUTPUT queue\n");
 	return ret;
@@ -525,7 +525,7 @@ static int reqbufs_capture(struct s5p_mfc_dev *dev, struct s5p_mfc_ctx *ctx,
 {
 	int ret = 0;
 
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 
 	if (reqbufs->count == 0) {
 		mfc_debug(2, "Freeing buffers\n");
@@ -568,7 +568,7 @@ static int reqbufs_capture(struct s5p_mfc_dev *dev, struct s5p_mfc_ctx *ctx,
 		ret = -EINVAL;
 	}
 out:
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(dev);
 	if (ret)
 		mfc_err("Failed allocating buffers for CAPTURE queue\n");
 	return ret;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
index ba22c6a3219a..87492db83536 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
@@ -1346,7 +1346,7 @@ static void s5p_mfc_try_run_v5(struct s5p_mfc_dev *dev)
 	 * Last frame has already been sent to MFC.
 	 * Now obtaining frames from MFC buffer
 	 */
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 	s5p_mfc_clean_ctx_int_flags(ctx);
 
 	if (ctx->type == MFCINST_DECODER) {
@@ -1422,7 +1422,7 @@ static void s5p_mfc_try_run_v5(struct s5p_mfc_dev *dev)
 		 * scheduled, reduce the clock count as no one will
 		 * ever do this, because no interrupt related to this try_run
 		 * will ever come from hardware. */
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 	}
 }
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 08545213caa9..8908c159a91e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1992,7 +1992,7 @@ static void s5p_mfc_try_run_v6(struct s5p_mfc_dev *dev)
 	/* Last frame has already been sent to MFC
 	 * Now obtaining frames from MFC buffer */
 
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(dev);
 	s5p_mfc_clean_ctx_int_flags(ctx);
 
 	if (ctx->type == MFCINST_DECODER) {
@@ -2072,7 +2072,7 @@ static void s5p_mfc_try_run_v6(struct s5p_mfc_dev *dev)
 		 * scheduled, reduce the clock count as no one will
 		 * ever do this, because no interrupt related to this try_run
 		 * will ever come from hardware. */
-		s5p_mfc_clock_off();
+		s5p_mfc_clock_off(dev);
 	}
 }
 
@@ -2088,9 +2088,9 @@ s5p_mfc_read_info_v6(struct s5p_mfc_ctx *ctx, unsigned long ofs)
 {
 	int ret;
 
-	s5p_mfc_clock_on();
+	s5p_mfc_clock_on(ctx->dev);
 	ret = readl((void __iomem *)ofs);
-	s5p_mfc_clock_off();
+	s5p_mfc_clock_off(ctx->dev);
 
 	return ret;
 }
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
index ecb3065c33c9..ae4241408383 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
@@ -14,13 +14,11 @@
 #include "s5p_mfc_debug.h"
 #include "s5p_mfc_pm.h"
 
-static struct s5p_mfc_pm *pm;
-
 int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 {
+	struct s5p_mfc_pm *pm = &dev->pm;
 	int i;
 
-	pm = &dev->pm;
 	pm->num_clocks = dev->variant->num_clocks;
 	pm->clk_names = dev->variant->clk_names;
 	pm->device = &dev->plat_dev->dev;
@@ -50,58 +48,58 @@ int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 
 void s5p_mfc_final_pm(struct s5p_mfc_dev *dev)
 {
-	pm_runtime_disable(pm->device);
+	pm_runtime_disable(dev->pm.device);
 }
 
-int s5p_mfc_clock_on(void)
+int s5p_mfc_clock_on(struct s5p_mfc_dev *dev)
 {
-	return clk_enable(pm->clock_gate);
+	return clk_enable(dev->pm.clock_gate);
 }
 
-void s5p_mfc_clock_off(void)
+void s5p_mfc_clock_off(struct s5p_mfc_dev *dev)
 {
-	clk_disable(pm->clock_gate);
+	clk_disable(dev->pm.clock_gate);
 }
 
-int s5p_mfc_power_on(void)
+int s5p_mfc_power_on(struct s5p_mfc_dev *dev)
 {
 	int i, ret = 0;
 
-	ret = pm_runtime_resume_and_get(pm->device);
+	ret = pm_runtime_resume_and_get(dev->pm.device);
 	if (ret < 0)
 		return ret;
 
 	/* clock control */
-	for (i = 0; i < pm->num_clocks; i++) {
-		ret = clk_prepare_enable(pm->clocks[i]);
+	for (i = 0; i < dev->pm.num_clocks; i++) {
+		ret = clk_prepare_enable(dev->pm.clocks[i]);
 		if (ret < 0) {
 			mfc_err("clock prepare failed for clock: %s\n",
-				pm->clk_names[i]);
+				dev->pm.clk_names[i]);
 			goto err;
 		}
 	}
 
 	/* prepare for software clock gating */
-	clk_disable(pm->clock_gate);
+	clk_disable(dev->pm.clock_gate);
 
 	return 0;
 err:
 	while (--i >= 0)
-		clk_disable_unprepare(pm->clocks[i]);
-	pm_runtime_put(pm->device);
+		clk_disable_unprepare(dev->pm.clocks[i]);
+	pm_runtime_put(dev->pm.device);
 	return ret;
 }
 
-int s5p_mfc_power_off(void)
+int s5p_mfc_power_off(struct s5p_mfc_dev *dev)
 {
 	int i;
 
 	/* finish software clock gating */
-	clk_enable(pm->clock_gate);
+	clk_enable(dev->pm.clock_gate);
 
-	for (i = 0; i < pm->num_clocks; i++)
-		clk_disable_unprepare(pm->clocks[i]);
+	for (i = 0; i < dev->pm.num_clocks; i++)
+		clk_disable_unprepare(dev->pm.clocks[i]);
 
-	return pm_runtime_put_sync(pm->device);
+	return pm_runtime_put_sync(dev->pm.device);
 }
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
index 4159d2364e87..9c71036f0385 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
@@ -12,9 +12,9 @@
 int s5p_mfc_init_pm(struct s5p_mfc_dev *dev);
 void s5p_mfc_final_pm(struct s5p_mfc_dev *dev);
 
-int s5p_mfc_clock_on(void);
-void s5p_mfc_clock_off(void);
-int s5p_mfc_power_on(void);
-int s5p_mfc_power_off(void);
+int s5p_mfc_clock_on(struct s5p_mfc_dev *dev);
+void s5p_mfc_clock_off(struct s5p_mfc_dev *dev);
+int s5p_mfc_power_on(struct s5p_mfc_dev *dev);
+int s5p_mfc_power_off(struct s5p_mfc_dev *dev);
 
 #endif /* S5P_MFC_PM_H_ */

-- 
2.34.1


