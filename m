Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376707DF416
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjKBNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376595AbjKBNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:41:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB989A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:41:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so140217266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698932510; x=1699537310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=525ntZUU9IDbVV4Jw2CWfdlqQxiLo8Ec66BuDOeD0GA=;
        b=HOPp+UT1mZycwWWMFCveZaaACVEW6VvvEe1EdoJjjwOCm149DGB60L54q8m+JvKAb2
         EP8UVQ0NWre/HRbQnfYfMeWRPPzmSJOcdf2TbYEK1kwtJ6v/hsoemS9KZ2+AhrZt2bzu
         D5zKZk1MiHJniuWAuST3kAlOtwCnlEbfA+Hn/lJd5iIu4Wr6yc/VapXjl7c9XGK+UiIM
         MmpFHGpSgsas9f6A4vGSHKdWhO1+qca0S7e8t3Gj+3zoK0/HwANz3CX3tJ0Uw2NlDzZz
         DBH83t3YLKoZzLHygs1KETxpjffTzQfWLZw815CwSheSlNVJQ6/fazqx+PbQ6E6hWXdy
         ozXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932510; x=1699537310;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=525ntZUU9IDbVV4Jw2CWfdlqQxiLo8Ec66BuDOeD0GA=;
        b=Ypn9ZWSAl4XOJe9wmCsOJBcZZmFswwMC9yA5pyh1CJMAJ5Efs3izEvmUufkXWHGByy
         dX4wr4pmEadFjsBODl6zOEnXi8qqKH3mf9QTnFYw2OvgJ2dbBAli6twf/YWecVPzx9aP
         /kUj4wN0yxZmEgvugUlxpaaR/6lOOsyBwI4EjdyMMOcjouvw4oCR3wJNrW386kqOKlMu
         08PCeDFNt9sUdvBEzZcuRMq9k/FUrwgFCrp97UZXuJSW5ywpOC2fBarQSQMCFAvJt/lN
         29wJkteIVUwL1KCxD8mApJSonDgHgmcJ6DnMRzE7tdWEZdI9F1amAttAiXXSvsvWqyi2
         ZdqA==
X-Gm-Message-State: AOJu0YwxrDpXaR+RtCSn3vWyUty3E9Wg64ctFlT/1/eRXsYLlwaLsKNm
        89axOQ3kQo8xIhnpBiBXSUz/ubYKjVA=
X-Google-Smtp-Source: AGHT+IH973wFt6bqHW7cDZN0wKW+UkKsLKCaRg36hSJokndjWn786idIO5cQuLHCEfTXF8UIDskt1w==
X-Received: by 2002:a17:906:eec3:b0:9b2:b153:925 with SMTP id wu3-20020a170906eec300b009b2b1530925mr3895676ejb.21.1698932509891;
        Thu, 02 Nov 2023 06:41:49 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id hb9-20020a170906b88900b009adcb6c0f0esm1157638ejb.193.2023.11.02.06.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:41:49 -0700 (PDT)
Message-ID: <5649ac03-db92-42a9-d86a-76dfa1af7c64@gmail.com>
Date:   Thu, 2 Nov 2023 14:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/4] drm/rockchip: rk3066_hdmi: Remove useless mode_fixup
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_fixup implementation doesn't do anything, so we can simply
remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index fa6e592e0276..5c269081c691 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -434,14 +434,6 @@ static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder)
 	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
 }

-static bool
-rk3066_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
-			       const struct drm_display_mode *mode,
-			       struct drm_display_mode *adj_mode)
-{
-	return true;
-}
-
 static int
 rk3066_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 				 struct drm_crtc_state *crtc_state,
@@ -459,7 +451,6 @@ static const
 struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
 	.enable       = rk3066_hdmi_encoder_enable,
 	.disable      = rk3066_hdmi_encoder_disable,
-	.mode_fixup   = rk3066_hdmi_encoder_mode_fixup,
 	.mode_set     = rk3066_hdmi_encoder_mode_set,
 	.atomic_check = rk3066_hdmi_encoder_atomic_check,
 };
--
2.39.2

