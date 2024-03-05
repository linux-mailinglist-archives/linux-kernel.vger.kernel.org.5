Return-Path: <linux-kernel+bounces-92905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F68727D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36811C273AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DFF5BAE6;
	Tue,  5 Mar 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="jB/xRRLV"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30335675D;
	Tue,  5 Mar 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667744; cv=none; b=dWfvwq2/yroKXgYjTh5ASndRMFIY/3cG+mfZ0slUMH8Jep2sXAR1cM8/74NgFWIqF4lV2eb0bru6lJUFfmuNIug+6g+VgHhXYngeyQpnfOYpAx+W/+k1TtmaEj1z1/lrPYs22OMnznhXtaOCTH2Lw/DI7zxLjmEmYjxtYAlr0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667744; c=relaxed/simple;
	bh=sWeqlDdrCvrscZ1nizJTiBx6SzjcdhujOsJuJ00B4Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EYElMUbVpHJm7m4guTL69LrUE2gfbVYmYrl36PPVBsBNbPfhC1OU+A3s6lorTAUcn+3q/YL8zp7aa+zA219eqoGl7IwWVCpaCLtbVmEZeWUqmKKXhPSpBPBnlIyKUygd95uNISAgtVyht9u8SDEUrgPnVNgsm8EtWTZMcIHQsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=jB/xRRLV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so5488827a12.1;
        Tue, 05 Mar 2024 11:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709667742; x=1710272542;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW8n563iIpVzHpbfeVLjRX5pvgGzhzJJv1hAgvnjd7Y=;
        b=WDRn0MMFqf/FogeacMwz5XaYNv2NtQ+daH+Na5mD39/rEI0HXkyqql94oDqDTPydDd
         IeMTgRRGMEAie2W21LU/21H/1O9owqi3CQROP7LP5w94KsF6L4kAXL0QwNh5eGihFNhx
         rl0+bQ4geWfuQ+0IfS/Bb1o+miw8OjMBv17TIXeWQF0TQ791ZNepIruzLwCsY7WwHdiQ
         uJZnb6a6IKT+CMdAlJHoXaTH9Q+NkoANo9ozmpJlgmoXSzmh0zrRz2uM+hWWMCBwokXB
         cuBNukyUqB5WHaqqbs46b8FNSmsEvxsDOTKYKWnk+PGa1IRZxi1LUxKp5t1JHx/kZ61i
         sRug==
X-Forwarded-Encrypted: i=1; AJvYcCUcu1D65EArvajTCwQk4h0BUBy2YidJTllMRg0BtASTuDIuvnOBwu9FCYqGkMkCTSlBJObJy4dQE+A6pIMAu7mP4ZLpxmEr3rGpAXC+
X-Gm-Message-State: AOJu0Yx83tt6IcBnGjxgax7fOhLvuu/5umHUo//zOqCseCoZcqujKxTM
	Ndl8zodogR60uaez1koAhONMVeDDxpzdBfC2OuMUjgFhbWqXmtxNtcsaC8/EGjECKg==
X-Google-Smtp-Source: AGHT+IErAFQrwK7MEJODrnd3UOpnvJS0xdH1NQHqHvmgs8vZIzmRJeO3ap0ElbYfnH/FBOfKoVQq6A==
X-Received: by 2002:a05:6a20:438b:b0:1a1:4a45:b393 with SMTP id i11-20020a056a20438b00b001a14a45b393mr3013322pzl.30.1709667742291;
        Tue, 05 Mar 2024 11:42:22 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006e3a69eb6c4sm9250865pfu.219.2024.03.05.11.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:42:21 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709667740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QW8n563iIpVzHpbfeVLjRX5pvgGzhzJJv1hAgvnjd7Y=;
	b=jB/xRRLVz65sPHrDvbAzA2UhUftXl058vFpf7FdlhQmY+vr2JYh96Bm7b3QQl3cZNe0wCi
	Ut1OqarpVj6rcErlMGkO8jewUviGu7YUJSwEtuhv+pYqUJH6JiODGQzDJ2OwfS1zOcwHmX
	8l1En4a10IdtdT35Jd9wVN1o+d2P3bSVfUFHvbhURE1LQUxgnjY2owIJhQwgHX54vEJerx
	PqSJIR4uZJ2PWHMjFDpP4zAp4Lr7CplRMB4vQhggflOU6f/Ia89BmvBy63Fi/Gd4GEEq6m
	mjA44qGU9MxxdvfVaF+6Yh0Dr/fdhtyBGFWi32oZcOs3nezAwiSEb2plskFX6Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:42:13 -0300
Subject: [PATCH] input: make input_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-input-v1-1-0c3d950c25db@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJR152UC/x3MSwqAMAwA0atI1hbqv3gVEakxakBqaVQE8e4Wl
 28x84BQYBJokwcCXSy8u4gsTQBX6xZSPEVDrvNSF7pSuFmRATey7vSKnT8PNZsKTVOPRAYhlj7
 QzPd/7fr3/QAZv/P5ZQAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=sWeqlDdrCvrscZ1nizJTiBx6SzjcdhujOsJuJ00B4Mc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53WaZvuwdVxpKYRoI+8PpkMTCOHmT1aEdwNLu
 HKzmGqrLPCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed1mgAKCRDJC4p8Y4ZY
 pinnD/49at5Y3+Xcs6zF5pDBSpeg3hSR0G8YYlqp2LCtns5PyEdvhxkP8lLvdAKl2lanYu9OU60
 3p1jIW64AMvWEHgpMpjC0Mw+vrljC+QeV5v8GsXhOt8QPALKnQpFJ4fKv4ZwLgT8P+HlgKGvZp6
 R7SLeYbrKcZ5Qpm9CdG0gCdN7uJYahuZg3qIDgxngTR6P21TDrXPRNJ0jAZ7Z3SMMf96TsMpFJ9
 qu7ZqDyGhKG6p+UG6bQGx2icFcyfk2hiHhHYuwLDLwevtDaQFElBaNXB7TLYdhm1q+1GveD1xa7
 JN7CFa9k1omv4TMiroGw8+ERRUa3UaX33VZSgVnH4oSTSbZbffU2wPT4in+18tSazLvG8fysrvF
 ZB5NZA2W98LZv7NaV/wVXNfQdJqjVva0M37FYdjfNumCrNvvmIFStNmt0fAbnifFFTNjF9c7xIZ
 vtT2UgiW5s2ZVo+lcSGrj/qJ1sMUEbvpMlPgzcqHsD1clSElxWbL/lz4EKl93oqq28XNjpj74Hl
 sGm6yXuyNppt5sixcTAuzW354x4FuCUKam0lGw1pZrhc+JCh0CmZQhZzboEUtmUFPNWRIaKjAsC
 dgo4Nv3AJROQWDUsAjZ3g29EZ6yGShj1gqtjK0iVFMdSDFV3yOAduK2YCRlppQHXvW5bEjJn01I
 7wt44+pWklLRCoA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the input_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/input/input.c | 2 +-
 include/linux/input.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index de7884a5be39..711485437567 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1918,7 +1918,7 @@ static char *input_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
 }
 
-struct class input_class = {
+const struct class input_class = {
 	.name		= "input",
 	.devnode	= input_devnode,
 };
diff --git a/include/linux/input.h b/include/linux/input.h
index de6503c0edb8..c22ac465254b 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -514,7 +514,7 @@ void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
 bool input_device_enabled(struct input_dev *dev);
 
-extern struct class input_class;
+extern const struct class input_class;
 
 /**
  * struct ff_device - force-feedback part of an input device

---
base-commit: b0f3f9ab419c243389da6c0dd6a9db0eea560146
change-id: 20240305-class_cleanup-input-f85c876bee8c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


