Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446247AC7C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjIXLiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIXLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:38:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64962139;
        Sun, 24 Sep 2023 04:38:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692b43bd804so1854695b3a.1;
        Sun, 24 Sep 2023 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695555517; x=1696160317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul33TqpD3VQ4mK3/9LxJs7GhSg/Yt+Ru6Sjot+t3GL0=;
        b=ZOlZAz5T+VrfIMdSIjsP/ZG2ykGru9yD46U+P/Rj1ycMXxBCi40QdyXK03kkMV/SaX
         F7D2rC97Enn3EiIKEXpWU2iJKHkCNsAObPxPtQO0fxheCzxMvTqjgWPO0rq4JkJoOnTT
         A3d5ojtGdZaeWJESSeEwdRV36tj0+iVF8ihjAX/cQodu8oJDBhTFOAvaHOsJ5woxzshp
         BbPcuhb+jKeFk/mftTIz3E4mVtPBRsPm0nF8rrPkaUsCXqPWTOc587BbgQGkPHnoA6TM
         Bly3vxzYew4ZLIhi6QL9s48waWra8Hs6obgH9rx3F1rRpGlBHEg20mJWyTZnXR1ojW1Z
         g5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695555517; x=1696160317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul33TqpD3VQ4mK3/9LxJs7GhSg/Yt+Ru6Sjot+t3GL0=;
        b=uln41+WMhYU/wz9F6QfzSjVjbdfOxYAAbQA5tANOcQSs3aqW8RgVc0QJWJ5OVcrEOl
         OObA7Z1h7SxVgB3JyCxKsd/jAG0u7krMvaC5tK2l1bXvcCT9zyCkoXwNz3NgGNcJMGVG
         O8pu5WZA68nmANktamdn+v263zY2eN1GL5x6U4TOvX9lcYA1Vq5hUwA/CgLAf3zU755q
         UYVIZV77irQI3W1+YKB+NqDu0nil57MmrrrMy5G3C3VXc5/pZC2wJZZxN/L6sm2o0r/Z
         BSWYPSiouKr3uwhOWA7cDeYOf8+KsnNl54vx98xVqKqHRiJNuF1gCIRPSzBbUBVeml6L
         lN8Q==
X-Gm-Message-State: AOJu0YzsUJ3Z7i82TgHSuAXDi6j7Z+eD6w6kXmmkc8CdIimQy0Uh30mG
        Ln48FLJRWHBFrq/F5XgBwEE=
X-Google-Smtp-Source: AGHT+IESOUWBAFs+Ltaz90JcqBTiNhA05cnMgzrSgkq9/0A6aoTHEl2HZln4Na+j8B2rwkcoGAO+lw==
X-Received: by 2002:a05:6a20:8e08:b0:13d:5b8e:db83 with SMTP id y8-20020a056a208e0800b0013d5b8edb83mr3211081pzj.9.1695555517561;
        Sun, 24 Sep 2023 04:38:37 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a6e4200b002775281b9easm422376pjm.50.2023.09.24.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:38:37 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Date:   Sun, 24 Sep 2023 17:06:59 +0530
Message-ID: <20230924113725.164948-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924113725.164948-1-ayushdevel1325@gmail.com>
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeaglePlay board by BeagleBoard.org has a CC1352 co-processor. This
co-processor is connected to the main AM62 (running Linux) over UART. In
the BeagleConnect Technology, CC1352 is responsible for handling 6LoWPAN
communication with beagleconnect freedom nodes as well as their
discovery.

This mcu is used by gb-beagleplay, a Greybus driver for BeaglePlay.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..5d46f907468f 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -870,6 +870,10 @@ &main_uart6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
+
+	mcu {
+		compatible = "beagle,play-cc1352";
+	};
 };
 
 &dss {
-- 
2.41.0

