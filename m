Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7464A7F9267
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjKZK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKZK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:56:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D860EDE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:56:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a03a9009572so445186966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700996216; x=1701601016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ea1jLeAmnQSy9N/+din3DyjLsbvTIXpsAIcN3X7QL+4=;
        b=njbt1USnhnvjDjHCQUSIY04J9Z/CuapK+l6mL4QDPaCWZbSDDU05KrhQv0te4MBfJ1
         LobvaWn4rfKlyWpJIv2jpkvnA7AXbz9N/ldzqhZtr8V74l7CiT4eEKnnegnMBqFz+cyf
         nt/hjbEtxd50rI9th8sjNFFLore5MpOhmi15oIQ2yRy4eeyI8UmOz9Zpu24VeiuW4FMw
         +6Q8A9CRd7Lw1LeHuBTtKk9ygh/MF3DQAePh6Vq7srA1MyU3jqKze89i7fIt4gDqoelr
         oygUyVmXJC2XGlReRuCKz1AxqJtGZWQMLlSX2AHNyyR2CTmBo7T1DcrM/2vz/YFd2KL6
         CuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700996216; x=1701601016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea1jLeAmnQSy9N/+din3DyjLsbvTIXpsAIcN3X7QL+4=;
        b=uDFYWvO3NuBUw0VkUiNsYRnuYFRcXlRA6ZQZ0Nn1JtY3katlyiFMveFRazpIoThUjW
         +jG2GGnJeaAtVuMVJA0lycy9N75ezSX/JNUW53UxW90V68GBmrXrsG85alJVEw7wEGDq
         LueiLtjupMiWG7XI52g1k4TQ6XV5tCLA8Lewfl2NEi+En+T1CNxIASBYpON93hmHCqmw
         DJGd2UMuMcPfhVk27ZWFYzbi2LoXDlN1GmKv7euJbheU4GvUS8XwqYKiFyXzHhdyMX6e
         nbGGq0y7FFoJef8FBNHYmTkkyA487vqPiuhR9KtPPoFS9HLugWWV115jvC2ArvqiXswC
         KvSw==
X-Gm-Message-State: AOJu0YwaopIa5oBDtTaPn4en6GwHNq+UQZ6cOj9uSI5gkz5RmtY9USKt
        EZ+8uROEEmoGVXzlQLIKOrc=
X-Google-Smtp-Source: AGHT+IG+GOdWj/VLVzcj/3gp7NPqtTAhePXdP862ib2/pBvG9jdmpQQQJ8+1VOz5rXcM4Gp99vR+SA==
X-Received: by 2002:a17:906:4557:b0:9e6:38f2:8439 with SMTP id s23-20020a170906455700b009e638f28439mr6350967ejq.60.1700996215660;
        Sun, 26 Nov 2023 02:56:55 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906145100b00a0949d4f66fsm3083431ejc.54.2023.11.26.02.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:56:55 -0800 (PST)
Message-ID: <a32406eb-1a3b-f8ce-9b74-1f5f09bb5f1e@gmail.com>
Date:   Sun, 26 Nov 2023 11:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/3] drm/rockchip: inno_hdmi: Remove unused drm device
 pointer
To:     hjc@rock-chips.com, heiko@sntech.de
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org
References: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
Content-Language: en-US
In-Reply-To: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_dev field in the inno_hdmi struct stores a pointer to the DRM
device but is never used anywhere in the driver. Let's remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 535cca30c256..ff7fa11dbc61 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -48,7 +48,6 @@ struct inno_hdmi_i2c {

 struct inno_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;

 	int irq;
 	struct clk *pclk;
@@ -821,7 +820,6 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;

 	hdmi->dev = dev;
-	hdmi->drm_dev = drm;

 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
--
2.39.2

