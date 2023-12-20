Return-Path: <linux-kernel+bounces-6268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FDA81968E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E420CB24522
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35398489;
	Wed, 20 Dec 2023 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoG0HsmL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96705C2D0;
	Wed, 20 Dec 2023 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-20389f2780fso3219782fac.2;
        Tue, 19 Dec 2023 17:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703037102; x=1703641902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI6OSf/Ga+zJKuJpAMMrUdNLhytpjOkBSW3YDAz3VbA=;
        b=JoG0HsmLRLBsDcJuSnTrOi3ZqCnqS8MYHstj4qydO80Lb9nPA22wFkW6Wl8S567vum
         JfC19jCDZej43AostQeAM/ibJ4BPjOruQPCPDbi4Q2uVNFvTJro4XUyh1lgNw+8U1TRS
         k0DtHdaVRZTZul/0V/NTkglcks3MG7QxrsbOIu0cRCIVTX/4yqHw1mhpdExQko/46qSr
         E+9A+qQRMj/EdzbzSxP+cLJVAqFGAhZjO44RHpN4oK9INpSENg8pfRd/vBTcaxwl3B5J
         qzlOeCoT+OppSGljC450QL80RoiOkgHjn0fLPuogVL+iMhSEicsvJKh0NMNDs46r/d28
         XPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703037102; x=1703641902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI6OSf/Ga+zJKuJpAMMrUdNLhytpjOkBSW3YDAz3VbA=;
        b=lyHyBdCFsisT73rIzMtnA2L7mR9+u9WBPBfNb1pLc69aIO5xe0qqoQVNF17cJ3qw+t
         5tQq3nBxWKBB0T2wkH1KESd4Il06RPaHNp+MeEMxAQidtP5+s3yKnmbxq3GxEosObJE6
         no1AnEVR63nv1NegJv9oewvWka1uMPEOtIYn2fB86/Tdc2WDiGpX4/gv6AHyId6FJoJT
         dNV8Vfdo7+L6m4q3De46MmhSG8k9lMJL1WIl+du5w3HXzwQdtLzZ+XQQTcPxvtPpCDsk
         2S+fjSyck4U5awS8mu5ghQM5e+N8+2c6LuoIHB5dyqDIFi6Ac1ty02bbjrebaKRIGv13
         27Ww==
X-Gm-Message-State: AOJu0YzWU4QI9hyON6hWWSUFwMkdL+/G7cl+IJNuJwt43bowh921BWTr
	osQj/0GndshKogZ1uF5YpnMsWWCf7cw=
X-Google-Smtp-Source: AGHT+IHFzIFF6a0ePjbWngSZRSYd/IrkhvcWRYCUQv9Ha6rZnD61c1gzcRuRBjowWYaPqGOHFghnvg==
X-Received: by 2002:a05:6871:452:b0:204:316:5eeb with SMTP id e18-20020a056871045200b0020403165eebmr1094714oag.62.1703037102543;
        Tue, 19 Dec 2023 17:51:42 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id c17-20020a631c51000000b005b92e60cf57sm20133208pgm.56.2023.12.19.17.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:51:41 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/4] gpiolib: cdev: allocate linereq using kvzalloc()
Date: Wed, 20 Dec 2023 09:51:04 +0800
Message-Id: <20231220015106.16732-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220015106.16732-1-warthog618@gmail.com>
References: <20231220015106.16732-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of struct linereq may exceed a page, so allocate space for
it using kvzalloc() instead of kzalloc().

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 44d864f63130..6fec793f5513 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1723,7 +1723,7 @@ static void linereq_free(struct linereq *lr)
 	kfifo_free(&lr->events);
 	kfree(lr->label);
 	gpio_device_put(lr->gdev);
-	kfree(lr);
+	kvfree(lr);
 }
 
 static int linereq_release(struct inode *inode, struct file *file)
@@ -1788,7 +1788,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		return ret;
 
-	lr = kzalloc(struct_size(lr, lines, ulr.num_lines), GFP_KERNEL);
+	lr = kvzalloc(struct_size(lr, lines, ulr.num_lines), GFP_KERNEL);
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
-- 
2.39.2


