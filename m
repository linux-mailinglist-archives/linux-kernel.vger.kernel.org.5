Return-Path: <linux-kernel+bounces-6267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3681968C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56354288AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F321749E;
	Wed, 20 Dec 2023 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M87ghTIO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22D8C00;
	Wed, 20 Dec 2023 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso3511765fac.1;
        Tue, 19 Dec 2023 17:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703037091; x=1703641891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIe64+aq/lZJDDELMuKdnpexZanQFZNO/4y/47rTO3o=;
        b=M87ghTIOnr0tO0BlINWetR2NqCcePFxLo02NurXxXED5SwJj0CS0HNNQZi891faa+/
         7U9VfIVbLwKF5AsbD7hC2zvhH6JJSQjv7oHvUlDmi+qkhWGUz4yg59a452L2T3Oi2Pjf
         C7KCL0RPK4AK5aR45TXH2sGwXdCndAg/yeHkwj2JX36a9dCsWMxXsLIpcLdeyHP29n9B
         LoO5AtWKicb3TVBK52HrQUlbsrlAuaZpAz8IzP9bPTu7Vbs0LEb898YFQfllQ+SRW3R5
         ikXpMvdSoHERFyyNJwEiLh6gA26ZB+1caVnSAVPo4+Me6pd1SdA7fxr2TJebGZPBPHmf
         r5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703037091; x=1703641891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIe64+aq/lZJDDELMuKdnpexZanQFZNO/4y/47rTO3o=;
        b=WybO+f22SmwUDFhC4U+0rIxVzZxE4TgLR1VMh3qX6x+yeA3aJDU1KOmzsRkmZg+yqn
         kHujiOqIG/M/b8ysWo0pfLASZNUy+AvUx9O7szynT87Ij9cbUYnUPcu1FzF1DjweaFm7
         7NTDT3k8JQCF6JI4O+dOde5EtU67KwnE/UoEevcmHqrRmh/S8dtV+JHuTl/aQPUr1kG6
         Um8qO2yI8DWXBuSLHE7esGPSkeZBHVb8/Ed9c0Yf2F0+TZfRLdb0JTHGAhI1TqavomR7
         yR2riVsyI2GhyrULUDrqfxT67n+jnNg5CwY0bk+YiJ/FDGLJpswEV7cR4g364A3lX5Ql
         2lgA==
X-Gm-Message-State: AOJu0YyZnhYKRFycIFaf0D+r1abx2Zy0AYMIGGz34o/i1z1n4MQ3dHLQ
	ug2lvW7JtGgXnWo8sWnwmn7S3rBtNzQ=
X-Google-Smtp-Source: AGHT+IFxkRG0cU6SnrORzXnRdzehPmsDw0LEmjhih2PVUm5sK6VpGziQ6URRjSJ3mphPYOFXqLK8ag==
X-Received: by 2002:a05:6870:b004:b0:1fb:75a:6d2d with SMTP id y4-20020a056870b00400b001fb075a6d2dmr22449061oae.84.1703037091372;
        Tue, 19 Dec 2023 17:51:31 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id c17-20020a631c51000000b005b92e60cf57sm20133208pgm.56.2023.12.19.17.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:51:31 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 1/4] gpiolib: cdev: include overflow.h
Date: Wed, 20 Dec 2023 09:51:03 +0800
Message-Id: <20231220015106.16732-2-warthog618@gmail.com>
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

struct_size() is used to calculate struct linereq size, so explicitly
include overflow.h.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 744734405912..44d864f63130 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -20,6 +20,7 @@
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
 #include <linux/rbtree.h>
-- 
2.39.2


