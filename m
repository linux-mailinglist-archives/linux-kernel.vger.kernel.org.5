Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66070799998
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjIIQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346487AbjIIOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:44:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077DC18F;
        Sat,  9 Sep 2023 07:44:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so321708a12.1;
        Sat, 09 Sep 2023 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694270679; x=1694875479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nej0/398bNZdr2HyvdtcO9BJNRbt3FMJ9LgNhlCfcUs=;
        b=STu/u5fJHoh98bx5r3xPTxrktEDMwHrCGa+x1lt5WJZy5OhpPKhvKmzu4Atr1BOgaN
         sLGxsLXS+sWheKbJrkQ/8ucb1l5FZSgwUTUEgNFSk77GJPp5CoUUgIzyTsFd2fmWJTzI
         y0yTlRJE6qCgCxEoOW5g0/C4NtPybqCDpiU201xCk9a4I7sLvjiLJi6eATU3uB2ZqX8Q
         DhsfG5ihDh/3WMV+aw4JBtnxStYOpESWgq6IG3ZORizCuwizwo9VJE1Odf5KJ/O7XqLI
         Jcx0omr6Gzv3HKq3ac2Z5BLaNLbL5/BmNkGbQt1hVt6F6Gu6+bbSMQgLUFxyZE7Hdlmr
         JUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694270679; x=1694875479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nej0/398bNZdr2HyvdtcO9BJNRbt3FMJ9LgNhlCfcUs=;
        b=vUQCGsKtq18QNT43FDrzvCsAnSE581ovR3A17v4LHTPOAwwzW+komwAEOXeHo4wLZ3
         44gx7FlNckycL6QW9AaCdoVV3onfkjkF/fXLnoUKhutr9EdsNn78UHZsqLJxpESq/cZy
         6tUreRjyoBq3wMMPbJFzgIfwzEZFu6M/sllYlnbgfCudqQ7r/AEP5WFJtf+DGDIPIQbv
         G86vDq0GERQIzHgUDQhrWs79IGZPIznLzfZ47jU5w98Kya23x73MqkQAAicHAiR9NVj0
         ZWWuEqGJl+8pONI+tqyQwAi6Jf7w8wsqvxiKmjbnRAy160Pv0WB2e06sS8Nrbttsk5wy
         x70w==
X-Gm-Message-State: AOJu0YzvGLTOr7ml3qpquV0beHM4eK0gB9EKFXwv6uyb+m2WKG2ejCCw
        y7BYKrN5qEMO2Y3+enxGOWk=
X-Google-Smtp-Source: AGHT+IFHzKC+0At/DYBgP3WZpFSkxW99Svb/7clX08ja8nXiHh59vaxzYeiaEBwvDKoBHvLxw6X0jw==
X-Received: by 2002:a05:6402:2794:b0:522:582f:91af with SMTP id b20-20020a056402279400b00522582f91afmr10420708ede.9.1694270679307;
        Sat, 09 Sep 2023 07:44:39 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id d22-20020aa7ce16000000b005233609e39dsm2252399edv.30.2023.09.09.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:44:38 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/bridge: dw-hdmi-cec: Add arbitration lost event
Date:   Sat,  9 Sep 2023 16:44:32 +0200
Message-ID: <20230909144432.34972-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of arbitration lost event.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
index be21c11de1f2..673661160e54 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
@@ -145,6 +145,10 @@ static irqreturn_t dw_hdmi_cec_hardirq(int irq, void *data)
 		cec->tx_status = CEC_TX_STATUS_NACK;
 		cec->tx_done = true;
 		ret = IRQ_WAKE_THREAD;
+	} else if (stat & CEC_STAT_ARBLOST) {
+		cec->tx_status = CEC_TX_STATUS_ARB_LOST;
+		cec->tx_done = true;
+		ret = IRQ_WAKE_THREAD;
 	}
 
 	if (stat & CEC_STAT_EOM) {
@@ -209,7 +213,7 @@ static int dw_hdmi_cec_enable(struct cec_adapter *adap, bool enable)
 		cec->ops->enable(cec->hdmi);
 
 		irqs = CEC_STAT_ERROR_INIT | CEC_STAT_NACK | CEC_STAT_EOM |
-		       CEC_STAT_DONE;
+		       CEC_STAT_ARBLOST | CEC_STAT_DONE;
 		dw_hdmi_write(cec, irqs, HDMI_CEC_POLARITY);
 		dw_hdmi_write(cec, ~irqs, HDMI_CEC_MASK);
 		dw_hdmi_write(cec, ~irqs, HDMI_IH_MUTE_CEC_STAT0);
-- 
2.42.0

