Return-Path: <linux-kernel+bounces-60562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC78506BC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CB8B25A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F660DD1;
	Sat, 10 Feb 2024 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGQE/Anw"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12960DCD;
	Sat, 10 Feb 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602025; cv=none; b=ASTR6zsZWfQu39HMkZS9xma+9vx5Kw0rnNYMUob+kaoijd1X8ZAIIY8lOS0PNa/NZF4CtYMYRjsBCdw3wXrifrpRCbsvzslJJGN1kZu0T9FuYisjBnRt6iUXS+sI5oE9HOwezwq6ltfLajAwDsVnXxKfFyhho6Waf8AwiVOdHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602025; c=relaxed/simple;
	bh=GNaoWdeQpKU9AVOEB3jYJkdbwqnSb7noVHcccptmsVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWWS69zmyR0UDg1iHJ5N7fFV8cWUnDGtpN6BnD/pVhBn1zEJREjBd1NYy0Ub8RHJS62ONqgVR+R8GjEPHFXkg2huzIvyK0BWtme1DHD/9j8rtW50FkTvk/g37h25GBn8Jjyo4wq5ZdZj6FBqTwTV43gFxqbVUBpJ73RPzYdq4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGQE/Anw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51185c33626so499793e87.0;
        Sat, 10 Feb 2024 13:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602022; x=1708206822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZiCL02JzF0+cmAi1UQWcFqubmumV+rMpnfD27eX/H8=;
        b=ZGQE/AnwQnVmIRwy4HLdq+2Gnbt5EYWPPZjsi1DRfzVZT8uI6n4HxhhULcrfY/WSeO
         OVciLRksR9S5y51dS81yAdv9Bhc52LLop/ZC/S21ryDqkS6yzuX3odEBA6t1v7BfAdLP
         5AZMO8TqU2MxqEm/xmgT4W3KfmT4ycmHb8kJ5PGNE25eM8ioKuAGbbsGFeQttFE0LIFN
         bt1JNhBT4s6k2g1Dc+BIONK/Gc+lrMA5bWquhJi/koa2qeDFHwL3OePQ16xbvAAWbnzz
         VaicZ2HFbeBbk2L0gpgrGoQ61Vvi9dbj3zTXQNGL9lPf3eARp9V67+r2t1rLppwL4NsH
         FyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602022; x=1708206822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZiCL02JzF0+cmAi1UQWcFqubmumV+rMpnfD27eX/H8=;
        b=ahlTM8h91bg4rOX2o3mqHsa9n7ry35IRMVjjafI7OxCug58HBTl398zGD/seNwAxeo
         d/dzJkLwDulo0QtabysYP/xjfjhB+4nOlvTk4w/M0ltoGJolh4DZahLY3MB9aFhXJ7A+
         /1wpW7gm+v4Zwo7iZT6wnB7x4j1cnX3Zu8L6wD+wyeIzgwPHyi5iiArLyCsT+x4Jnq2L
         RiaGtD1TCVv2M4Ja3wITZ0p+smo4DVRmKro75pk6vMp6NCu3OYfJ30nEYbcWruZqQi7y
         +36u7YJcICoZgl9b/NlXuT1o4uxe/8jsC6MOb+5R1u2D7qqhbq3aoadRVuL1MJYndwe+
         kK1w==
X-Gm-Message-State: AOJu0YwGhvcw1ONWZ2XmMqe956pSsBs4+7bWUZoxzYaib/oPSIb4CE5a
	vBEa7Twc08KOIhBMezmJ+w+ibluTx/Wqa75ZIwC9JHILDK5//a+h
X-Google-Smtp-Source: AGHT+IHi1MP5EoY6rqmM5OT1pXXhNbPfdcYp8ZDZ3YCzteaVP2NQu+kqpqaA2H4zOs03qJN94S7K6g==
X-Received: by 2002:a05:6512:3b96:b0:511:674d:88c5 with SMTP id g22-20020a0565123b9600b00511674d88c5mr2410949lfv.13.1707602021749;
        Sat, 10 Feb 2024 13:53:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQrAe84oRhlYTBEbGuA4c/x3OkV5e1en9F9UQ1FnnwVa8jgdYkf5N/9d9Q4mrjrDJ7I1JMOtO/eeYKDHadMJw1JBueVTEVMxsT9vmnxn15RflgdR7+zYlaVZz4cQKRMvqBH54OVcr5awc2fJdP/dAQLnnzGSsuBtulGhRTlR3UfhPIhPMhGx+z2X6WV9QWSSKKmWfchmvM6jEzSwSEI/CS/MLhl9I9i/7oylM4at1yRXRc0qDbKiHDu/+u5fKpbMHKQVvCooIcPCqrNIxXhDGRmiGA6MVyGF8Z0DnRsJhjGYLRLfIyoSHT9Xb1pU0Mhc446yo9WJjTlJEmPYgNO/kQLgprlmkHyNoYrfhDNCyzRrl92mtmKA==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:41 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 15/19] hid-ft260: uart: remove FIXME for wake-up workaround
Date: Sat, 10 Feb 2024 23:51:43 +0200
Message-Id: <20240210215147.77629-16-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FIXME is related to the wake-up workaround cancelation - do we
need the reschedule_work flag alongside the cancel_work_sync usage?

The teardown sequence is as described below:

Upon tty session termination:
   ft260_uart_port_shutdown
       ft260_uart_wakeup_workaraund_enable: deactivate wakeup workaround
   t260_uart_cleanup
   ft260_uart_port_put

On rmmod:
   ft260_remove
       cancel_work_sync
           ft260_uart_port_remove
               timer_delete_sync
   ft260_uart_port_put
   ft260_uart_port_destroy

The ft260_uart_start_wakeup timer_work can occur after the cancel_work_sync
returns, rescheduling the wakeup_work again. The reschedule_work flag set
earlier at the ft260_uart_port_shutdown time prevents it.

The alternative could be performing the timer_delete_sync first, preventing
the wakeup_timer and wakeup_work from rescheduling, and then canceling the
last wakeup_work by calling the cancel_work_sync. However, we still need the
reschedule_work flag to enable or bypass the power saving mode according to
the requested baud rate.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 1c113f735524..52ccee83250e 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1585,7 +1585,6 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 	struct device *devt;
 
 	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
-	// FIXME: Do I need that if I have cancel_work_sync?
 	// FIXME: are all kfifo access secured by lock? with irq or not?
 	ft260_uart_wakeup_workaraund_enable(dev, true);
 	/* Work not started at this point */
@@ -1721,7 +1720,6 @@ static void ft260_remove(struct hid_device *hdev)
 		return;
 
 	if (dev->iface_type == FT260_IFACE_UART) {
-		// FIXME:
 		cancel_work_sync(&dev->wakeup_work);
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
-- 
2.40.1


