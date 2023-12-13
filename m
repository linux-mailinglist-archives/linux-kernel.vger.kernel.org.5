Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74A810FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377529AbjLMLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377447AbjLMLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:24:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1897DE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:24:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so44068885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702466678; x=1703071478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQvbhLysPu3ndFWzqkdoXhfbQL7mt17avjjy+XMKqZU=;
        b=NxuEO249coSjaCsjn3hPAdNQfphMxjYDWg6v4dvJfccInYuLbMZWVriE3u5sRolbJ0
         sIEirm97sepSHDSJwlqb5hkFiJ4EHj5MQGSBZY3Alm0CIWAhqhWKIlvneoXGGc6P2Qc4
         dvRtc9Zr/h0XMVmhCYTMIH4APvO7cnlmKwoHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466678; x=1703071478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQvbhLysPu3ndFWzqkdoXhfbQL7mt17avjjy+XMKqZU=;
        b=fDr975QZklQwCfKQYejCEUIwyie4WjugpSLmG0kOS+nwam0b0XkuLhuysXbjj4r5oR
         ITZwJLg3wvPRtyRzpk922D6Zc1soQ0ePPGJYhrPLelhA1A5Ft1Adab0xKWJS7lzL99UU
         zCXt3F4OqwU+WVTvlXnbngZSfz9+Z8PDqkyrJ3fYUukxbyp/fRIeQeACo9OvyTB4+LKa
         5rDrWnHLw5xsNEAa5rVywEv1knwenZ2NSGmG1F+R7JSFEeIvWMbR5aFOlNQEhGcf+PJ5
         w8zcoRR3CkJc+syNyWJlexbwpZbEqS1KffVkZPB7bZwR2t9YFvElQGjSiFAKna67e5BS
         srvQ==
X-Gm-Message-State: AOJu0Yx5yQSyPhxONhqEYmoqGiFIt6TbxoAcHwGSq+g77EclJPFr5as8
        VtnII9nx2KqDwG04/innggD0wPCrcVNGFjohb/0iFQ==
X-Google-Smtp-Source: AGHT+IGnUaoJ14140of/teVzgr5iy1MVAPb5b3vhT1bQpkqzccjQ4N3vgu9nBujQVmFkvJBUTyJ9lA==
X-Received: by 2002:a05:600c:331f:b0:40c:2c60:dc3d with SMTP id q31-20020a05600c331f00b0040c2c60dc3dmr1933541wmp.308.1702466677906;
        Wed, 13 Dec 2023 03:24:37 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-246-113.cust.dsl.teletu.it. [93.150.246.113])
        by smtp.gmail.com with ESMTPSA id fj5-20020a05600c0c8500b0040b2976eb02sm20294090wmb.10.2023.12.13.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:24:37 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     neil.armstrong@linaro.org, robh@kernel.org, daniel@ffwll.ch,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, airlied@gmail.com,
        quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sam@ravnborg.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org
Subject: [linux-next:master] drm/panel: synaptics-r63353: adjust the includes
Date:   Wed, 13 Dec 2023 12:24:32 +0100
Message-ID: <20231213112432.2002832-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/gpu/drm/panel/panel-synaptics-r63353.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 3f61fcdc550b..169c629746c7 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -9,10 +9,9 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/fb.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/media-bus-format.h>
 
 #include <linux/gpio/consumer.h>
-- 
2.43.0

