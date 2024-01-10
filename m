Return-Path: <linux-kernel+bounces-21971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C1829752
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30A6B273E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0D40C1F;
	Wed, 10 Jan 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvFtRv/A"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174453FE40
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e4d515c9aso25724875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882071; x=1705486871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4iYdXj/TSCgsEZp2b2vJFAs1qXmGMx2hLD5PPyxfe4=;
        b=YvFtRv/Aj0WzE6T6JVyC9vI3o48kV5b3VhioXCfQUA2NNmQ0eRbh7NY9m952Rji0LP
         K8TyYyQJO29Vp9TCsipUwvA6CY0Yjsss/ItgOLMkKUCn5CG0Xn/4sjres+RpUTBirHJe
         EaKm+dkNp4bTLheTStRSsaE7i71c14F3zs5swX4N8lCbGsyvwNH11/KgS6eBTaIS0Cfb
         q16+ahe/532c1crhJldrJYAJZLpikeYUDxypnyI7NCL5QeVVlwLrnMPBz46WMAqSwBTn
         +yvJLsElFf3BZCldefewu3XRWszfTwB8tE7xJwwZjTgHQzG3E1cF/2Wb2JA467hbKpsi
         lWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882071; x=1705486871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4iYdXj/TSCgsEZp2b2vJFAs1qXmGMx2hLD5PPyxfe4=;
        b=jacMlxdVnK37puk8TbkUojL2+598E+gUOB6kK8tnHGz++4jGw8UD5uED0oYDkkbJYz
         ka3azesl/xoKXcEohm/QZRkTcARSq8nqqv6QEgFnwlz10QLMc+j9edWuTAe2B+0wDbno
         qgJ6wx6yHXMp1SQuFNceCgYItTGj+SsrQ0QnUD7vq6lMH1n9qfGNViKEwVzpBEVHKvMG
         if4HA6WSB1U6IYSFpPrmRWeNQLGXhSRWUQwkJh1Wp7yCUK2s4lRt2o9DaNDL9vzYjFAU
         2hKxxb3Cstsuo+mW+UNzSmAHnDRaKUIfvwk6dh1BItOaFD6FEiH/1rTRlDgJVVTFJ1pc
         9yjQ==
X-Gm-Message-State: AOJu0YzxXyRPZHz0ZmlacZ6FIXUYMZVwRzjOxtMXWtp9v9xX2fcVa+0h
	qiefRLmOPO9bSEMeYySMBa90PC3CaDo6bw==
X-Google-Smtp-Source: AGHT+IEJaLJEuywZyJ4sRLPFSPZQHxuethScWjz9nRPWcCw2dTCMG2kd8LT+vUP10sFOjNedK0JasQ==
X-Received: by 2002:a05:600c:3d1a:b0:40e:461e:26a6 with SMTP id bh26-20020a05600c3d1a00b0040e461e26a6mr471328wmb.36.1704882071439;
        Wed, 10 Jan 2024 02:21:11 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:10 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 05/18] tty: serial: samsung: explicitly include <linux/types.h>
Date: Wed, 10 Jan 2024 10:20:49 +0000
Message-ID: <20240110102102.61587-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samsung_tty.c uses u32 and relies on <linux/console.h> to include
<linux/types.h>. Explicitly include <linux/types.h>. We shall aim to
have the driver self contained.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index f37d6724bfe5..b8b71a0109ea 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -41,6 +41,7 @@
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/types.h>
 
 #include <asm/irq.h>
 
-- 
2.43.0.472.g3155946c3a-goog


