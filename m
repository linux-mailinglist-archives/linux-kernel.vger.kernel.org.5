Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F827E9B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjKMLYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjKMLYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCC10D8;
        Mon, 13 Nov 2023 03:24:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso35129685e9.0;
        Mon, 13 Nov 2023 03:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874652; x=1700479452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihe5CWoYwzVYQa0PIBn4FXCZubjqfqZzL14QGGmAy2E=;
        b=bypWkQacXTTf8eEkiHkyM7p4sq3mTlwbq9+o5b2jBC9c/IrJE/vURYsPth4u/H6JEg
         COw19AHyxknCX/NaytA4QfINtzB+X8eMP9Dzw8TEnw0HkTcAVVdcoNztlC8mlENk/ClM
         pYuGTbqGdA3WieE1J1OTTelCK/U+VvXuSp/+2AaRS5nQ3GK0oau0zjtdcr4njJdms6ZO
         b/dcUnG41ARoZp8xTknA9VynQJjRW8hd5L6204/wgiA77OWSDUClHEHi5YK4scoq4yTa
         YbptRPUH3+2vWQiiVojQfoTVHkWNl0MoEZpP9OT5ArkZv8YXZqyaen1R9JmIlFr+PFc0
         Xafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874652; x=1700479452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihe5CWoYwzVYQa0PIBn4FXCZubjqfqZzL14QGGmAy2E=;
        b=HJFWEdwASbyap1B/ktUWvWxBmlp8Bu0Dn5ewOZuyp26x7iKOOAV1K0yQt6AvLhaKBG
         EQGMoizgH12F/PMuR9Q/G3dnVucRlC3BItQJgTBVx2v6U3E+5w4WYWL9AE2iDUgHGCBd
         S0ohD8DJDSyiI5nlm86IBY+nqTCSMD2pVcu0tn13ACK5PQqMdozR4hS2EiayPbVeG5lo
         2UIra8kG4C1jWGQAzAZ115cdSoUuYBC3HB0vxycD9beUBFEjCLv2hh6BwzUGMRDiKy0q
         QRyrvCRjE8YyloVrqNo6izQrDe/erXvf8/CwtwqtQHci6oIBx/DnUJztl/DL+PqU+o3C
         EnAQ==
X-Gm-Message-State: AOJu0YzsEfQ/LiI9G24i3F6nmpk4U5E5ewP/vZBZhqIRARI1w+FrFdHj
        1E8nexqwxUU5jJ1HzXe95lLeLi2VIvU=
X-Google-Smtp-Source: AGHT+IEb96vRjjDVhf2WWvt4ATSMI0ZIHMZT2M821fnApL0F6zP0tqP/mZlSqQGsQCCeZ+/3gKjOXw==
X-Received: by 2002:a05:600c:4f09:b0:405:336b:8307 with SMTP id l9-20020a05600c4f0900b00405336b8307mr5644653wmq.7.1699874651755;
        Mon, 13 Nov 2023 03:24:11 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:11 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/20] drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:36 +0100
Message-ID: <20231113112344.719-13-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index d675c954b..54e46e440 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -297,7 +297,6 @@ static int mtk_hdmi_ddc_probe(struct platform_device *pdev)
 
 	strscpy(ddc->adap.name, "mediatek-hdmi-ddc", sizeof(ddc->adap.name));
 	ddc->adap.owner = THIS_MODULE;
-	ddc->adap.class = I2C_CLASS_DDC;
 	ddc->adap.algo = &mtk_hdmi_ddc_algorithm;
 	ddc->adap.retries = 3;
 	ddc->adap.dev.of_node = dev->of_node;

