Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E4810E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjLMKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjLMKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:03:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A3D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:03:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b5155e154so77020645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702461831; x=1703066631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fckJlCTvThg4GMc4TI++ofVYKH1qSZws0GBdMNV6LR4=;
        b=EGCVD5eTSCNplEIH3jgSUwHyBcix4OMbQklBR4DXzvqYbbLssUffzr+eMmKXVNLDGY
         77hRGWDX8gf7xThUr4x3HdRiah30RA+QDXujoHDEnqlrWMVEzPcKXqyS/blFyQ9hagcQ
         AiLATu07coaNtMcs6PqhjOX9gd/PdCbTSa9rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461831; x=1703066631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fckJlCTvThg4GMc4TI++ofVYKH1qSZws0GBdMNV6LR4=;
        b=fAJHQAKZ17aCcl1vm2xh4dIXf4SuZNAai2Ar/W6xHimzHDnuPlFOppAWQZMdRl97MG
         ocuV7nc8h/SlZDqSF0fsYwmvZB4RYqFx6NIachvyrlu6eFu/sE2XFZUsNe99h1JP1Gw6
         RpvswD2n291VIe1mLgthubCYXWsGN6XHP8h/lTDnQUQVTZeFNsozvH5HrMTOkLAauRzt
         6BbhYjgNbQrAuTVP4inB+F5061j0ubyntZaYvPYGuk5bqDcBPDZmzAaT5vJFlzD4NBV6
         8MbbL6lRZGdxs9pcM6ffcNIlzx4avaa70BCZxfgVmnz5FqYTfxqGKBuh3E24ZNDleM+n
         gw5w==
X-Gm-Message-State: AOJu0YwLlMw/E0ogdCz3BStypcDbFspQ72wYM76nbvEAszDE9+KgTBEo
        bYcJHoo05w52s9VXJrSncegRXg==
X-Google-Smtp-Source: AGHT+IFPOekualiPp3Db8cNpwKmLCjnpsnslqnoE79lPCxnEecqaBCjfPUAVzXmDA4lY3VrdYH4fLw==
X-Received: by 2002:a05:600c:468d:b0:40c:3150:3d5e with SMTP id p13-20020a05600c468d00b0040c31503d5emr3349425wmo.237.1702461830678;
        Wed, 13 Dec 2023 02:03:50 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-246-113.cust.dsl.teletu.it. [93.150.246.113])
        by smtp.gmail.com with ESMTPSA id v16-20020adfa1d0000000b003362e9b75c3sm3478010wrv.88.2023.12.13.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:03:50 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     neil.armstrong@linaro.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com
Subject: [linux-next:master] drm/panel: ilitek-ili9805: adjust the includes
Date:   Wed, 13 Dec 2023 11:03:34 +0100
Message-ID: <20231213100334.1799034-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the includes to explicitly include the correct headers.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 5054d1a2b2f5..1cbc25758bd2 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -7,10 +7,9 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/fb.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
-- 
2.43.0

