Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B17F5B75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjKWJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjKWJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:40:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0686D40;
        Thu, 23 Nov 2023 01:40:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ffb5a4f622so85767366b.0;
        Thu, 23 Nov 2023 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700732454; x=1701337254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkXe0QoGE+tlThXBz0xEA+Tvx0TKZmjc+38hqplAd1o=;
        b=GuLMxXsGoVW8n+01SueQcdlKIo/H5UOxqybayr853DB4se2zsuzBN3dHeVt+3/arVu
         bDQJ3k6swS/CSltIKsttcEr3OXsNOAysdPmQXjaNtrlszgCqzlFEHg1RDJyzduTHhGDt
         XKeqiE6AmZ5CKl3ja8gUm/QPLBsu2XhkLbxNDloBbk+8E05e1OicB+lOMyVgXTr3w1oA
         R2lPIDfpzWat9AbvLy52YQ2XMudoewFxgpifk1waC6KL5tjMGP/kpDM1TwJEod6zq/aU
         v1xPl8Hswv+CtvW0Q2p+9cL8LMG9W181Pn1efwZk4SpvQIJhfY/S/uT8wkSgMIHE7k/B
         mm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732454; x=1701337254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkXe0QoGE+tlThXBz0xEA+Tvx0TKZmjc+38hqplAd1o=;
        b=kK2x6ao9UBo5DV4D2pEjUvquwJIcm3aX0vr2/kxACVQdkCOC5JELRzJNC8NjpxN4pw
         ERlPchdc4n6GIcb0hJG/t00mAqIQfLV3BLDqm/x1lN9AfaK3YqMemwG2YoBKB+U4LUnt
         Omqv29avDYK/hKnxLzOqb/T3HpwMW2zO+Hx5nFfqhWBi5Rynpze4OWgaqVtIkD9fTHYN
         pqq92mwey0CjxaKPhNGVTKTccAo/g0FP/2BbOOPD2vbvcqt6hKu0tkotkc6o27REJlUS
         sb2z/72ZQ+aXSUN/AtzshoCCaeDr5qF5nFlj2Q383vCQvKe0214+fTYbaMhoJpzhTNfF
         7bMQ==
X-Gm-Message-State: AOJu0YwmZT9w7F/e0vdQl7jnoGKw2BL+gPAGj1n77I8Dw2tjF5I1KWOB
        3ko0K2fPlXK4I5uIdeMcjuo=
X-Google-Smtp-Source: AGHT+IGBaET/BPE0zfZXGFTIbLxGAcu/efNvrnEKBMMHB3R5g6zx8yTuME8af3epmG7VUmfNUgxQ8A==
X-Received: by 2002:a17:906:a38f:b0:a01:ae5c:f9b1 with SMTP id k15-20020a170906a38f00b00a01ae5cf9b1mr3755311ejz.40.1700732454188;
        Thu, 23 Nov 2023 01:40:54 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-c0f2-3200-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:c0f2:3200:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709066c8900b009e5ce1acb01sm546199ejr.103.2023.11.23.01.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:40:53 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/20] drivers/gpu/drm/bridge/synopsys/dw-hdmi.c: remove I2C_CLASS_DDC support
Date:   Thu, 23 Nov 2023 10:40:31 +0100
Message-ID: <20231123094040.592-12-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231123094040.592-1-hkallweit1@gmail.com>
References: <20231123094040.592-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 52d91a0df..aca5bb086 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -515,7 +515,6 @@ static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
 	init_completion(&i2c->cmp);
 
 	adap = &i2c->adap;
-	adap->class = I2C_CLASS_DDC;
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = hdmi->dev;
 	adap->algo = &dw_hdmi_algorithm;

