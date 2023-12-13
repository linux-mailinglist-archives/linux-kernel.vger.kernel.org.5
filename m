Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA246810E03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjLMKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjLMKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:03:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA6DD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:04:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso33104805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702461843; x=1703066643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQvbhLysPu3ndFWzqkdoXhfbQL7mt17avjjy+XMKqZU=;
        b=oXCHYM7iey5XsjEDiXUkFc2KHgmNK8ArAyeoe+Lveh4pTDb0VmEqPZTtkhmLUUfNSB
         JMIyjtd49ScKHguoURFuwMH6V6/eLZssL804T2IeVxYYMCvzM37Uup0eiJXQosQxALG0
         sYqdNBlrA7ReSslGslHhzNLBX3ISeAWa5xx4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461843; x=1703066643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQvbhLysPu3ndFWzqkdoXhfbQL7mt17avjjy+XMKqZU=;
        b=wQ2uKu4LRJQVuz+JSGZ4kyEFhQJLKrjpnx2Mpg5bxmIlT34yb08N0zaNDy7OAi3zx0
         s1Vxl7E2nSiKwt4045Z1WLJf1IMd6tx+7JXJNr37r66lBemjIzBREJdt/NTSIhfbMmeU
         CgONtOAhiXSVDzl0/GxVwsGzbZvrXw9qB18fRC3abQ+czuA+7ooRiHOYoGSWHJepCaTO
         0VNGQEvZLpe+A283JqT6Y3QbHa6hrgEAgVjcMlik7J6ZmGUuFYE/sbs/6aMA6u5U1K6J
         Y5LNKqanzw1I1vY/fQoEbMXxzDq8iKC5nUOxb2cWAUoNi04wlED8CkYLLQmVi5Kg9X6S
         HnOg==
X-Gm-Message-State: AOJu0YxSG7Zrs6TrimRbt5/kcBO88Ncw4hzaXmF7ChhEJcTtHiYeXS8M
        zbTcvYPgTKqX85RFNYmho2vbVw==
X-Google-Smtp-Source: AGHT+IGrIx6WDTAYy9s/LpYoREn1HE55NP5TLUMwSc8D72KRO2JHeuwV1i0rP1IkYxlMaNviX7wzYA==
X-Received: by 2002:a05:600c:1e2a:b0:40c:2ace:6e58 with SMTP id ay42-20020a05600c1e2a00b0040c2ace6e58mr4011158wmb.182.1702461843600;
        Wed, 13 Dec 2023 02:04:03 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-246-113.cust.dsl.teletu.it. [93.150.246.113])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm21902157wmo.16.2023.12.13.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:04:03 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     neil.armstrong@linaro.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com
Subject: [linux-next:master] drm/panel: synaptics-r63353: adjust the includes
Date:   Wed, 13 Dec 2023 11:03:57 +0100
Message-ID: <20231213100357.1799057-1-dario.binacchi@amarulasolutions.com>
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

