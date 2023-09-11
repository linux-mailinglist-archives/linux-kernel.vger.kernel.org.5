Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56579BF65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbjIKVRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbjIKPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:46:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E40127
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-403004a96eeso25256465e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694447153; x=1695051953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtIhAxbGVK+7yj4SNMHYOQFab9XtJv/AFRYvoUE3Ztg=;
        b=fPs3jz9CNOYH604bpS2KaaS3ABUXJqD1nd4/6yGz19t0g647vHHgsoZnOOMyxm0Qgy
         PAhbxEDQTpiegYlylCmFUuLBAf4G5IJmcNrRuqSBIwQ9pndFt6yBZkS1A3xYIBJvy3i6
         IA5zIJNN7uWg2SIZ9aONjmnkJ3g5lnzBm2DyiZBF7VXVINsDNB+mKwv6UnDvsLxAbqmb
         vVtb075jFGL63+yj2PqihMsA2tX3/r4UwUtK1qz4O6t5TSM1MFoQtsupCCAZZKF68Ilq
         00YWkKthAkz1KnXNyy+aGtCZH4juJgcpzfDHI4PH15FLEjBuSEvH3MduYTnkZqkQmRPM
         kT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447153; x=1695051953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtIhAxbGVK+7yj4SNMHYOQFab9XtJv/AFRYvoUE3Ztg=;
        b=FJlIor7bO9PjB8nIabHWFxEQnM9k6yneianqOVqHSxjST4l6w+vsOqGFpHVHiFDt0B
         7B/iqTLhFmoJazuJdvRWDmRE6lYxLXKvazCNW2dDzpQzaXPXCaOgDAyz8e2bs1bEraks
         hzm5FvUIsVg12wQdUr04rQd2IQ03T5vwC0S7CH4RYx3jWqe/gDRmEheIJxAFUbCVK5Lh
         bRh1l4RWYyYAN+d3uXD/b+yvPrv+NifKyBEyDpxxwx8SpDNm0bzrY62lvyoOaFuMdz1j
         irdcEGzxW2YjhTqplyhWyRzkHdTAf7l0XsbVcLa95giBEDP8cbjcPPVTvXxsztYDZelj
         UFlQ==
X-Gm-Message-State: AOJu0YwrLvIdfkHJb0ZmuRcz+y5gzV8YY/xmfmHArcIY6UHn8ijmvL1n
        Sb6xIBPUi/KlYsQnws0ws+mi0g==
X-Google-Smtp-Source: AGHT+IFlHuDGD4y/pkzGSIaXA5xLAwU8gajS0add0DHyT1XivNj62MdgH/kpwUyCyIHaYB4pZmxRlw==
X-Received: by 2002:a05:600c:b4e:b0:3f8:fac0:ad40 with SMTP id k14-20020a05600c0b4e00b003f8fac0ad40mr9105096wmr.29.1694447153244;
        Mon, 11 Sep 2023 08:45:53 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c040c00b003fe539b83f2sm13616255wmb.42.2023.09.11.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:45:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/5] arm64: dts: meson: u200: fix spdif output pin
Date:   Mon, 11 Sep 2023 17:45:37 +0200
Message-Id: <20230911154541.471484-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911154541.471484-1-jbrunet@baylibre.com>
References: <20230911154541.471484-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

u200 outputs spdif on GPIOAO_10, not GPIOH_4 which is used for the LCD
panel.

Fixes: cfae4eadb7cd ("arm64: dts: meson: add audio playback to u200")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 2878e3ad7de2..8fa17a62534c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -396,7 +396,7 @@ &sd_emmc_c {
 };
 
 &spdifout {
-	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-0 = <&spdif_ao_out_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.40.1

