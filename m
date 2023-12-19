Return-Path: <linux-kernel+bounces-5209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B30818800
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DF51F216CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA718EA1;
	Tue, 19 Dec 2023 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="XEYHBUBu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE551BDDE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3365424df34so3191092f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1702990312; x=1703595112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7eqSad8qYVypHDv1PfcUABuIzKnHh55QiKj9dHA+Cc=;
        b=XEYHBUBuPoBUd5uljV/4a5LVGc0o0G/LYe1Ysb82YtoTDg3qPXDUcbqqwaNIgzgskq
         zHwzsf0P5pOzenFdqM0PMTu6P23XjCIwDpgfo8DUmyS3Ml3TKCElWDN190ePQScuSnor
         sYCXDs24utXGLKHtPLOq+fX0Z/s8mTvgCSRQPYxCTmi7tUvDShq7Do7lUVGEebYnJveh
         mubW1zjr8Dqqj/PVBg2g+yXen+p5fmwTsZyQhznC6+L+nNaU8gej9xy8hvf9pkUAAxLU
         B2wMSLlNIVik4rfsKx1J0PMvIbrNJbGT+ZmhaC5SAr8k+mT0z3Or5h/q4lOEamF7QPk1
         BvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990312; x=1703595112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7eqSad8qYVypHDv1PfcUABuIzKnHh55QiKj9dHA+Cc=;
        b=M602yxplGfmi+J9BAi4TIdxkkRNs7upTzeoEyDziLIOZ+UIjOXVG4zc8b3Yz+Fi5GK
         LgbJYteQhQZz5CRGKoK+WHpXTotnCCEywTihx0pR0Ek7hi6GuLkwXOWWu/q92b+oJlxr
         1C8wDca8Pnyo6qwPBqydkXszHGRpvhCnq8khDnJKOMEIysef9tPhBYgFEbuQBEm43TUi
         Ay9Fx2eptWNlB2VxpFZBbpwJOQYfB17vEvU4zoa14DtNktUx1g3TuHKpID5Ms+6EeyA6
         5YDix5EF9ck6mCvvb+vhCZOXaouyc7kt5kepA7hvV35QzYco7CM8KVZMV2LSf7BvqwRI
         Ld7g==
X-Gm-Message-State: AOJu0YynKZvPtHjupeqxhVftM7Xg8tqVvofnkHgKewGHAy2BlXVtXx9f
	VTgOM/UasHLH0oj4Ul+jUbQDuF5UHkNKKlsJZObgDA==
X-Google-Smtp-Source: AGHT+IF4f5c27MUdOhS8Li/cY3KZcZCwjgFHkHAYgaEtVL2Y3Ckh+8+WRv3R0iNFNEbSV7D9B/hwZQ==
X-Received: by 2002:adf:dd82:0:b0:336:5c84:51b8 with SMTP id x2-20020adfdd82000000b003365c8451b8mr3450966wrl.141.1702990312299;
        Tue, 19 Dec 2023 04:51:52 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4bd1000000b00336607f6630sm8311579wrt.47.2023.12.19.04.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:51:52 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pinctrl: cy8c95x0: Fix typo
Date: Tue, 19 Dec 2023 13:51:16 +0100
Message-ID: <20231219125120.4028862-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo to make pinctrl-cy8c95x compile again.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 4ccfa99ed93a..a8c7f00cceef 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -822,7 +822,7 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 	gc->get_direction = cy8c95x0_gpio_get_direction;
 	gc->get_multiple = cy8c95x0_gpio_get_multiple;
 	gc->set_multiple = cy8c95x0_gpio_set_multiple;
-	gc->set_config = gpiochip_generic_config,
+	gc->set_config = gpiochip_generic_config;
 	gc->can_sleep = true;
 	gc->add_pin_ranges = cy8c95x0_add_pin_ranges;
 
-- 
2.43.0


