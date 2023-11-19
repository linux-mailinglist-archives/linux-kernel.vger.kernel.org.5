Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCC7F05B6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKSL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjKSL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:28:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F511D;
        Sun, 19 Nov 2023 03:28:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso4906667a12.1;
        Sun, 19 Nov 2023 03:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700393313; x=1700998113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFS8KKprIzFM0zE+Ai6M4ORed6sy7M8DbezDgWX5KRQ=;
        b=mZlvyuBlW7GMvNyFJxq6yeqa5cl4Leuz+ikQEWTvNzeSCcK0on8gFi0vPdDls2YZ0M
         cpb3Gl8YQOSTgzpnGhXggHS8se9dKbX19G2XcMhQAmMqlyOj4VpGTs8H6/EkW64Nm2Y2
         GLvCTIxPnn4vKePnXXSwXrmT5v5O4ELIec+BXRZ4NzH29bkJi6t4ccg6lVJXrgqc6lVA
         ULC1fC3RChxlSFwQ6yYpODLrbNjR0cxcEOFDEUDmyX6CLXLEnP+abId1/drQGqgurtFj
         HtMAMkpsaiM91row+3LHePQPuBd+TcjbAE23tW/dB5yiWfneDhK+g+bZIQuJv1qpBgqY
         ei1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700393313; x=1700998113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFS8KKprIzFM0zE+Ai6M4ORed6sy7M8DbezDgWX5KRQ=;
        b=EE/wgCyZyfL6RPD+SqEtJUFrDyfpWg3efIzLDYKIbZoWoR8YkA+kym5snSSgRuquuK
         mIX8i8J825z280YpyF/OeMZW2CjX8mIpqAObirBFD3ixHGZD43WNsuRw8TtbW8BnvDQK
         oljT3IbnYgP/OfHoFzz2nv2mBEl5ViwbxhTIAveOQE+1Nl15CuV8lworqvdYqr5zC+J0
         BUu0I/rcFv4KGYdMAWgEmH0HRITM8mp06EB9TLW5SGB2yvQykb6PrKc7d7t83ZplgKtR
         rCEkO9zKKSyOgbX9rK+5PBn4fZqBhfBiOoYVbN2ZFw4l1jM/+44Dfjj/kAgML9kuYjhq
         6bjQ==
X-Gm-Message-State: AOJu0Yw1oGyz9D1V0L6pNLXpR/JuCIgIGKMNbe5jU/Dz0Sh/SrtDaSgk
        CU/y9X5XrO2xAGgrK3/E48U=
X-Google-Smtp-Source: AGHT+IGsco/wc6xKX5vo5lzmFcA2w842hBPgh5O17c6HmrxwSBPZRu/jKD563TwiQ42AUE9ZznEjpw==
X-Received: by 2002:a17:907:8b93:b0:9c7:6087:49a7 with SMTP id tb19-20020a1709078b9300b009c7608749a7mr3289054ejc.43.1700393313184;
        Sun, 19 Nov 2023 03:28:33 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b009f8af454d0dsm2420378ejj.112.2023.11.19.03.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 03:28:32 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/20] drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 12:28:09 +0100
Message-ID: <20231119112826.5115-5-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119112826.5115-1-hkallweit1@gmail.com>
References: <20231119112826.5115-1-hkallweit1@gmail.com>
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

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
index d1a65a921..f5f62eb0e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -302,7 +302,6 @@ int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
 		return -ENOMEM;
 
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_DDC;
 	adap->algo = &sun4i_hdmi_i2c_algorithm;
 	strscpy(adap->name, "sun4i_hdmi_i2c adapter", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);

