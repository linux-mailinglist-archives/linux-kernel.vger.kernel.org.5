Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C495C810FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377438AbjLMLY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377582AbjLMLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:24:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3DBD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:24:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3333074512bso4173754f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702466662; x=1703071462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fckJlCTvThg4GMc4TI++ofVYKH1qSZws0GBdMNV6LR4=;
        b=WHOJnUlWPbtRlBcinkCSwbul06NJA0w5IOREDL39S5bDdiULumBnciPP6iRs6XTRlC
         36HSiYKs9QP+CtSmq8n/rB0fIU/gS9mvVl+OUQKmLqygV9jdZi2hjehDi9wP9XoQXMYa
         wt/DGSXaH7ttKkYbsZSjzsiL2nQiYXsTrZ0dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466662; x=1703071462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fckJlCTvThg4GMc4TI++ofVYKH1qSZws0GBdMNV6LR4=;
        b=QbgL5LiOUh6D9q+XOV7i7SOJvwSWN0XWd97o5x7Ybc9kNBSz3vhgYgr6Jwv+/CCubp
         UwP1VpR57hGk0XL+Kw2hZfbQDgyNsY/gDnA4yvkVdEFEkVwzSlL1a76qucS04pVBD92G
         bdM/64wWXn55CwROsSeEYvjXdsgo11rYcWKASCiRp6yV364gEmKvzhcOIstVTuP4LQH2
         9JUMdjPqDR0hJN/xBNWTlanVne1NrxMyY1lVehK6YB+z5yglkDwSbFKVQ5EkbArl/SBB
         2v5xknrEDdw1+FJAhoX7MnxnlEIQC/UYJP4kfNQw9BTuKT9BL8kPAWt/avFNHARCdxzg
         uqEQ==
X-Gm-Message-State: AOJu0YyI1KNh1B/D+oX+7VnioHYg76gGmUPOIhPhxHr7XQLeg3ctWWAJ
        yhD1A4FBxztO8gj3/7Tm78S8NujB9CScrCabXhUFkA==
X-Google-Smtp-Source: AGHT+IFo5FtTT55gXV2TFfpKTqbQSZEQmJDDSeppxR0QOmHa0fQBm9TR+nSf6LLBy9vpP3OZ6Y6AnQ==
X-Received: by 2002:a05:600c:520e:b0:40b:5e56:7b4a with SMTP id fb14-20020a05600c520e00b0040b5e567b4amr3729337wmb.147.1702466662385;
        Wed, 13 Dec 2023 03:24:22 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-246-113.cust.dsl.teletu.it. [93.150.246.113])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bcd09000000b0040c26a459b4sm666570wmj.0.2023.12.13.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:24:21 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     neil.armstrong@linaro.org, robh@kernel.org, daniel@ffwll.ch,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, airlied@gmail.com,
        quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sam@ravnborg.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org
Subject: [linux-next:master] drm/panel: ilitek-ili9805: adjust the includes
Date:   Wed, 13 Dec 2023 12:24:01 +0100
Message-ID: <20231213112401.2000837-1-dario.binacchi@amarulasolutions.com>
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

