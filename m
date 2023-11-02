Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BA7DF41D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376592AbjKBNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjKBNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:42:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A87197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:42:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1601702a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698932554; x=1699537354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtT6nxgsYYS4sdsaY7t86FYZfBLOlduBaZpsVAIl6mA=;
        b=c4qBMrA93TzGOmeAeaF2jkZGTwC7vfOxIsxOHtAU2zMyx2tdkDr/uNVMgjYYiPoX4n
         RsMbzkxVHl2eoGzkWp8OYB8UERx9LgH1aXi9U9+jddHRtYn1OIEafg81+GfsZF/jW9mu
         6cEQuMjwVQ78uvhHOBf50dGDql7dZKZu/JuHec70ZH53C0w5C/kEL5KKqzJ9uFkb4f2y
         8sRpkKKoPH7emoAFZGqHU5x+jfpVVst9JWAJhNazCJAqKzYQ0zbmzOyUrHtrX9nLvhOg
         DiWjRVTixpg3EyS1YzvHyuINITTU+QJb/QWSp/g9Fh4IG16vxN8dGAY1LhfZuwwSkv+d
         Mj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932554; x=1699537354;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtT6nxgsYYS4sdsaY7t86FYZfBLOlduBaZpsVAIl6mA=;
        b=IDciT2hxCfk+f1Yfj4DTI81sHEe6a4uCUdZzZx972dSXRo5NKbCYd1e9NzJU+qyYR4
         /NIiN8hiUbIYYW5CglQMwgOijbPLCIyroCCI4b4IB6SVg7Bs1c0TYsS7Ty+9rTSqUZbi
         yxFO6x2aQSvmL6uDXzLX48jgLk+Vfpmtn6svFz+/OJs49gk8+g504mTlcZaXwaOJrLwR
         xDWhFr49Ev0/Y5g/znb/E8xMnaLcVCKYcrDlfTG7OufRCr+Nsri4izBcvxTpOUGLbhJ4
         mCfbVP2uOEKB/2smYRc7YGhlx3e2BRPxu2XuxEjwRCz/8c7vEiGSL42y55jiGbMgYlls
         nJ6Q==
X-Gm-Message-State: AOJu0YyTrnVjlMhRlMdJTYwC1XMzQZ54+Y01sKaM0PHifvzjjWBzntFM
        guNhOmCzDLo2ILjOtTlp9xM=
X-Google-Smtp-Source: AGHT+IGhrHVKX8Mcwu1ULzEU38/CACnkgTDqYLqxetznwQ5sVClFv+wxqUtm2VH+CqBwnOqPQHgfDw==
X-Received: by 2002:a05:6402:2029:b0:53d:a7d9:5149 with SMTP id ay9-20020a056402202900b0053da7d95149mr14483614edb.6.1698932554131;
        Thu, 02 Nov 2023 06:42:34 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v3-20020a50d583000000b0053e89721d4esm2378618edi.68.2023.11.02.06.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:42:33 -0700 (PDT)
Message-ID: <813a0e30-a61d-7fc9-9ca6-11bf9c6fbe52@gmail.com>
Date:   Thu, 2 Nov 2023 14:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/4] drm/rockchip: rk3066_hdmi: Remove unused drm device
 pointer
To:     hjc@rock-chips.com, heiko@sntech.de
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
Content-Language: en-US
In-Reply-To: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_dev field in the rk3066_hdmi struct stores a pointer to the DRM
device but is never used anywhere in the driver. Let's remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index f2b1b2faa096..c51520ec58d2 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -38,7 +38,6 @@ struct rk3066_hdmi_i2c {

 struct rk3066_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;
 	struct regmap *grf_regmap;
 	int irq;
 	struct clk *hclk;
@@ -734,7 +733,6 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;

 	hdmi->dev = dev;
-	hdmi->drm_dev = drm;
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
 		return PTR_ERR(hdmi->regs);
--
2.39.2

