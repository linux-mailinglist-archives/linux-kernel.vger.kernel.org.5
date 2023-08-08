Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B068A773B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjHHPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjHHPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:41:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590922108
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:29:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe11652b64so8046419e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691465374; x=1692070174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2a2fi6fo8O2qphEYAkmBRgnh3Id5Qk5HANh3JTmLrk=;
        b=Hv0EkMFwuoyzbj7wybAw2sah1r5PcEsI9FNN9nLIlvkNEpHSFHw4jcZKq/NkXGTw6z
         H42R1MPcMSc8IIbKlAyXG1c0yacNizA221RfmnShj84TS/hy3iWPjxmdPyQv7ZxU8TG7
         hpT6Z4tY0EZoJoyg6WfiTFEaPLh6C+jhz6GHGqJVIafQ68XNayOBx0xe/m5BsTf3D1HI
         j/rN/NYIuWU98uIvWBgGI0u17/cRIekusBpWhj45eIhdqLWoop2D5lE7uBdJ1OaeFKnx
         SQMjWMbfBsMbDrTnG5IAIcQnZd+a+ujSMOvp0lA9QUDdDk24tLRY/H73PpTXxQW61bd9
         Xujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465374; x=1692070174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2a2fi6fo8O2qphEYAkmBRgnh3Id5Qk5HANh3JTmLrk=;
        b=Qgq+86ExftfNr1gLnjLYgdiJhS4RZUQ+M8/N+yIZ2TnnFK27R1/ISpeYNqEip9hXGR
         sj3cbxPMPCDjzzNqfVQb3NGLaiQxoHGJUsm9msKF2tWBLx0oj9tPQp/PovJaEFjFMY9q
         zHG45NGiPjFLyAjpoN8I7miy9GCcJRVXwh+DGtcBp9Pemc9RJnCQb6oGmIWRPOcUaymB
         2SB7y8SZIx/fu2/2xTEK62hp3ymot2VzISX5R/JLfRv320V8tlE45VqFka8NkgxUbmdq
         j4RIKko8Rp7Y6vqOGytxe44Eph0jr3KuiI+95d7/iaSTevz5IN6syL5GlBw2eVb/eFRu
         HSBg==
X-Gm-Message-State: AOJu0YyW8j8nCcvlbgWITal97EO8sg5wfPGewK5kDzyD3rW+jnU0jWeS
        Irg8yR9McCKP/X3rLRWdEQjP5g==
X-Google-Smtp-Source: AGHT+IHUJlcYJA5OEaih3/uCPH2RSh8acayw3bMZ9xFGDbb2rx6os6/zhDaz9FaWTAYH/lOAbrlTdA==
X-Received: by 2002:a05:6512:34c2:b0:4fd:fe8f:4108 with SMTP id w2-20020a05651234c200b004fdfe8f4108mr6732753lfr.62.1691465374338;
        Mon, 07 Aug 2023 20:29:34 -0700 (PDT)
Received: from bear.local ([69.165.74.129])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b004fcdd81355csm1715321lfo.269.2023.08.07.20.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:29:34 -0700 (PDT)
From:   Luke Lu <luke.lu@libre.computer>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luke Lu <luke.lu@libre.computer>
Subject: [PATCH] usb: dwc3: meson-g12a: do post init to fix broken usb after resumption
Date:   Tue,  8 Aug 2023 03:25:10 +0000
Message-Id: <20230808032510.31754-1-luke.lu@libre.computer>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device connected to usb otg port of GXL-based boards can not be
recognised after resumption, doesn't recover even if disconnect and
reconnect the device. dmesg shows it disconnects during resumption.

[   41.492911] usb 1-2: USB disconnect, device number 3
[   41.499346] usb 1-2: unregistering device
[   41.511939] usb 1-2: unregistering interface 1-2:1.0

Calling usb_post_init() will fix this issue, and it's tested and
verified on libretech's aml-s905x-cc board.

Signed-off-by: Luke Lu <luke.lu@libre.computer>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index e99c7489dba0..2c07c038b584 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -926,6 +926,12 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 			return ret;
 	}
 
+	if (priv->drvdata->usb_post_init) {
+		ret = priv->drvdata->usb_post_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.40.1

