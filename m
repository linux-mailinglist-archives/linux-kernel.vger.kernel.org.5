Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8E7F05E2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjKSL3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjKSL3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:29:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A17D6D;
        Sun, 19 Nov 2023 03:28:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e62f903e88so451517266b.2;
        Sun, 19 Nov 2023 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700393322; x=1700998122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwYQsxTIlPnpbp305mlbq5GplvUv/n/Jh48i1GH8+AY=;
        b=Clx4z0E8CoQF5EKOlW/9+L2J742/5lMlBEEpbMg+5c2MvLcSMOj2XzqGYraXCMrHXy
         MFszHM+Wl8LSACOlC31i5Il+k3M+Ax4h/aCjybCvXewGcM00urY9gU5eGLVMmbIgdsdb
         fVA6VMpz2DGrNx+5tLiwLii4PwFzgu+FEA0Ds+CuoW36x3K8MQq1MaYxFJWkkFGx5Nen
         hC4QkWykI3H6bgRdFS4ueYcSbA+tpdXAGY5Pzc3lF3mPUzXr1cA7DNtx4W0Hwhcr8i6q
         0orA5JfrUAKHZT7M4MZ6g3zJxvuS2fOr0ricTqFptjEHbo8KJh8/cCR6B+iNxpjbzR53
         wTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700393322; x=1700998122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwYQsxTIlPnpbp305mlbq5GplvUv/n/Jh48i1GH8+AY=;
        b=C/pJ3eYLtRv+GYXj8gnFAWDk8UD5kBjUnpTo3yPi6QnkJoAl9X3DsddgaR0EjFUpRo
         EQ1hNykpoZXoLOxih8avriApftVJyNUTLOZxKtFf/csq5iOK+ZDRGQmaGztqajYHjrG5
         RawTMMwprwF1FWpSmGzQW6rNnqXIg3uCo+dANAqw6P1WLEXtfnMmJE98fS1UNxuN18Dt
         hAHpJzQ7T/ZD2b89AYuRTPVh0vWp0TEwB0cVJ21RqhaCNDgB2FKcpeTiurJV+X21U+0S
         QWKi9E6QKAVZUxsrYCAf3KNsBCzmWMCpvqfwbwr+ieJoJXOSp50ZeaomS9zbqbcUToE8
         xvrQ==
X-Gm-Message-State: AOJu0Yw8/fb8QhpaSPVdPKteBFrmNsrvbwUCa0dDmfBd5akI4vkNOAJB
        kWvvilzuU2cHI6nwVToB7o8=
X-Google-Smtp-Source: AGHT+IErpTouVgXqlh3TisiJyv9Y7lrxQ2t5uB7O/C5V8sCHaKfqSNKhBvmGLqTZ7BYeJj6wkdbyzQ==
X-Received: by 2002:a17:906:1099:b0:9fb:d7cb:6e03 with SMTP id u25-20020a170906109900b009fbd7cb6e03mr1924992eju.20.1700393321970;
        Sun, 19 Nov 2023 03:28:41 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b009f8af454d0dsm2420378ejj.112.2023.11.19.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 03:28:41 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/20] drivers/gpu/drm/msm/hdmi/hdmi_i2c.c: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 12:28:19 +0100
Message-ID: <20231119112826.5115-15-hkallweit1@gmail.com>
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

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index de182c004..7aa500d24 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -249,7 +249,6 @@ struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi)
 
 
 	i2c->owner = THIS_MODULE;
-	i2c->class = I2C_CLASS_DDC;
 	snprintf(i2c->name, sizeof(i2c->name), "msm hdmi i2c");
 	i2c->dev.parent = &hdmi->pdev->dev;
 	i2c->algo = &msm_hdmi_i2c_algorithm;

