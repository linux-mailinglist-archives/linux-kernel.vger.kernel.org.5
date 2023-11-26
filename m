Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29C7F9262
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjKZK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKZK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:56:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4E107
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:56:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso2658309a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700996171; x=1701600971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mN5h4JeQlyNJ6i5AWUS6aIyGqp9DnO+inxm6CANO/d4=;
        b=O9MjvXUkB7D+sxGe7RxYaJa8U5uhZPM7TfIkSyf0yWYq0gLe3/RL/62ChmBqrOvQUt
         2nWGYD5JUjHQAvGPTaHtAzgCC8xXF/uPjiaqHGXMhQhvW4paH3pLENT4lyCRjkrZgPBj
         16wAuyb+CuSA8HkfhdPPULpkEsXUCk4F+N7Xni8r0nDqUJYH6ePvS59VQxZSsre+ngXz
         QZxXnsVilDDXl9vJ3R2Mc0aNWgCAE6M7jCgwnzfNsZ+urZo7ZhWXyra98cmOOg4ljJdK
         FfSF/v6LRwuQ3ytOEGLQeEF6VbTAnz7+UWkY0TgTh6d1vdAchGYlsc3UqALtyvvWZk7y
         kCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700996171; x=1701600971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mN5h4JeQlyNJ6i5AWUS6aIyGqp9DnO+inxm6CANO/d4=;
        b=s05eZnPpYL+BfppIcYzTPL+MxcE2SqRwYBKrZxepDNZnogauHvH2uw/6FIoXO6b9R9
         fGd62jIJQuwd/4xh5YpromQq+x/Vd83/vxDGbFtx9UsaRu3mmYtuDmX81weCD3HqqqjL
         TpbuAsFmBqlKqn3Zx4lKJ6zhPFpyjV660v7w7vW9Ngenn3gQGbu4qn7c6nHHC/O3LTuC
         2XNOqutq3wGp9BOd40jaRfvK+1cVrEwHlB/J/ys51GyRDiYdUFUJh5jxgBrK8Y9p3SS6
         XKWMlYtcpWjKhdyFRaqmTeYJs/NXqjsU/94jrL5Z8SoVeG/8TiabwvlLiEsfc2T/0AKG
         V9Aw==
X-Gm-Message-State: AOJu0YxsMNY/7kuA9R83XDvlU9D/m1vfgeLtoxn+fQK2miKB4DpV6MA3
        /ltSMcUijC1IqFOlKC5Jzew=
X-Google-Smtp-Source: AGHT+IEOyqWMk44eN134q8IBZJzyDe7wGYih+f76HdhbtNuQJ+hi/1cY0IEENQqhqYe0kBJwSUOqgQ==
X-Received: by 2002:a50:8d4c:0:b0:543:5c2f:e0e6 with SMTP id t12-20020a508d4c000000b005435c2fe0e6mr5900684edt.17.1700996170898;
        Sun, 26 Nov 2023 02:56:10 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s25-20020a508d19000000b0054ae9d77989sm3281586eds.64.2023.11.26.02.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:56:10 -0800 (PST)
Message-ID: <1ae0d08b-4f99-39a2-d692-d0cb1efaef7e@gmail.com>
Date:   Sun, 26 Nov 2023 11:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] drm/rockchip: inno_hdmi: Remove useless mode_fixup
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

The mode_fixup implementation doesn't do anything, so we can simply
remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 6e5b922a121e..cc48cbf85f31 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -517,13 +517,6 @@ static void inno_hdmi_encoder_disable(struct drm_encoder *encoder)
 	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
 }

-static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
-					 const struct drm_display_mode *mode,
-					 struct drm_display_mode *adj_mode)
-{
-	return true;
-}
-
 static int
 inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_crtc_state *crtc_state,
@@ -540,7 +533,6 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.enable     = inno_hdmi_encoder_enable,
 	.disable    = inno_hdmi_encoder_disable,
-	.mode_fixup = inno_hdmi_encoder_mode_fixup,
 	.mode_set   = inno_hdmi_encoder_mode_set,
 	.atomic_check = inno_hdmi_encoder_atomic_check,
 };
--
2.39.2

