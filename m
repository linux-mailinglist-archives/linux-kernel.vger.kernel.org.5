Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0480E08B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbjLLA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjLLA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:56:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CAB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:56:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0a7b72203so44872835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702342565; x=1702947365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VII/LMlRWrPvYBfcRDAQD7A22/Kx5Gqvp4PO6BWVrDg=;
        b=eTGscO3FKKVYnqTVIFqA//eGs+yIecl/Jy5zV2jnFp9ltxuwSIweG75uky/8NGwMDW
         7ir6ZAPnkkwz56fFb6RXuRA7h4h0lvlfhtPeKLRHhJPEsvYE4pM+iLzJtDxPgn8Ei48T
         G7WzRBbPL8ehFnNGYylvn4jY1W3FO+s7Kao4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342565; x=1702947365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VII/LMlRWrPvYBfcRDAQD7A22/Kx5Gqvp4PO6BWVrDg=;
        b=akBT6iyBO9PqXgvaAAd6PGbklwiritHQk++yf9l71kAIwgSxeSNGJA/badD/HPcUEx
         RIBSAkHC+sEU3mrH7mzVxTDsU0F1csPtAQooIWGb4u9HMeEBF0uy/6SRmot/mOu1zWQI
         iSZIT7BlIoQhn+vr974ZPeh8AOYjX7fE6uJfEwErQuZ3RQgE/zD/x7FzJ070S7pzPbcu
         05UGrzYDz5sBJW2331vRgueNtlozvcZW/BB4/5DYt/aKIFR1M9ABUuDUdJHMSTZE/tQQ
         9g1Z/o0U5ypD8CtUTJeh3YQJ/N6RK/q2/5YeU4XrovHg842wfW0Hk2gc+X2FFOKgnuk9
         3LKg==
X-Gm-Message-State: AOJu0Yzm5xO8Q2WMYnqeBsdQScf1NM7Nzk09x9ygqPF1bvGroPdwEtDR
        sBj08wQW/mMw0LHLtvdUWLt1zA==
X-Google-Smtp-Source: AGHT+IHFyTsa/iL05H+WM4XTWvOGMGTVZlGEhQBpQMBoRW2cN0R6Hrp3MXN3u+9yFFV1wxd9YuCrhQ==
X-Received: by 2002:a17:903:1206:b0:1d2:f388:6df3 with SMTP id l6-20020a170903120600b001d2f3886df3mr6013703plh.48.1702342565555;
        Mon, 11 Dec 2023 16:56:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5c08:e1ed:d922:d30c])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001cc311ef152sm7251271plt.286.2023.12.11.16.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:56:05 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi86: Never increase the length when reading from AUX
Date:   Mon, 11 Dec 2023 16:55:27 -0800
Message-ID: <20231211165526.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231211165526.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
References: <20231211165526.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For aux reads, the value `msg->size` indicates the size of the buffer
provided by `msg->buffer`. We should never in any circumstances write
more bytes to the buffer since it may overflow the buffer.

In the ti-sn65dsi86 driver there is one code path that reads the
transfer length from hardware. Even though it's never been seen to be
a problem, we should make extra sure that the hardware isn't
increasing the length since doing so would cause us to overrun the
buffer.

Fixes: 982f589bde7a ("drm/bridge: ti-sn65dsi86: Update reply on aux failures")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 5b8e1dfc458d..7ff465241267 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -527,6 +527,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	u32 request_val = AUX_CMD_REQ(msg->request);
 	u8 *buf = msg->buffer;
 	unsigned int len = msg->size;
+	unsigned int short_len;
 	unsigned int val;
 	int ret;
 	u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
@@ -600,7 +601,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	if (val & AUX_IRQ_STATUS_AUX_SHORT) {
-		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &len);
+		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &short_len);
+		len = min(len, short_len);
 		if (ret)
 			goto exit;
 	} else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
-- 
2.43.0.472.g3155946c3a-goog

