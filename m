Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC17857D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjHWMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjHWMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:20:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F131FE9;
        Wed, 23 Aug 2023 05:20:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so22372195e9.3;
        Wed, 23 Aug 2023 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692793220; x=1693398020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=10onvWGxz9bz3+icHMFZatKgP0llKlSrmA+LhRG/3vc=;
        b=QpqgWGJnq8YEdR7Qw8JhIphCBOW/YqbC2KRTgKsdh301J6i3tF00fuS5AESTEyN0HU
         NYkboE/jxvxdTTq/dpXAua3jwyGmy/Ua8/17DqkA4/M+85O0VTHeHpHsldC5skUe3GUS
         /T33vLL8/aLMWjuUcJ4T4hfWSAv3FKQf5vDiZJGfS0Mag1inz4E9g/X4raLQVA7GyvFm
         VA7qghOTtGryHxrdp8QYFRRCegxpkkEUCvKFBfe/HaoN2qE/j1QF+qbqvzsqfXQ/g/3T
         z4kxajgOtWlOioYIiVqq5nvM5N19f4ImrPjOPEXFGMh+YPHHg7FazK94gXQmBy9KGLFd
         elSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692793220; x=1693398020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10onvWGxz9bz3+icHMFZatKgP0llKlSrmA+LhRG/3vc=;
        b=Kk6Y3HkZawwTRXoGUUphbhmeR4xDTmZVot11BKa1hFfquJueKFaoflvy4LgKSV7W0W
         lEcujB0edC8p2KxmsRf2N3UoAE0DVJ96qm5PL5W5lEg6BF2uzDJ9QSPJEZvIDJ10HifA
         oXAo6Sk+qN6PeGWYWHdeXNXU/ml2efy7+uSTXQUsL64w8yJlzP6YROYW2O86eOMarvHs
         j8eWHBLSyI1xYZTZ2Tl2yHK+g5QeHIRr66zv/hEqdZ9mW+guuGPWccr62aO9JzwWXdG2
         YD+j3PTGnjuzI38f0+4Li5nQ54Gw+35I0d5kTSp0/p9RFWEoI9cJL8GJTSONpcVmkMKI
         Hh4g==
X-Gm-Message-State: AOJu0YzA2NO/EKGAbQ4GgATnXs/U35AhCRsSBlS/yIKpPkLOzeo6CGWd
        ajleXKP/rwGTvcP48WvQrnFL0tJU0m836Q==
X-Google-Smtp-Source: AGHT+IEEGL0YP7FFC1bI0GofVCUszxqRDbHrQu/PE1gdbXjKyUuDDc2CGIFkjNaWSGcH93fIYa3XHQ==
X-Received: by 2002:a5d:53cc:0:b0:31a:e2af:bcb6 with SMTP id a12-20020a5d53cc000000b0031ae2afbcb6mr9739011wrw.57.1692793220146;
        Wed, 23 Aug 2023 05:20:20 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003197b85bad2sm18909196wru.79.2023.08.23.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:20:19 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     jakob.unterwurzacher@theobroma-systems.com,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] TSD: arm64: dts: rockchip: use codec as clock master
Date:   Wed, 23 Aug 2023 14:19:59 +0200
Message-Id: <20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ermin Sunj <ermin.sunj@theobroma-systems.com>

If the codec is not the clock master, the MCLK needs to be
synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
on Haikou, causing distorted audio.

Before:

 Running audioloopback.py script on Ringneck, 1kHz
 output sine wave is not stable and shows distortion.

After:

 10h stress tests audioloopback.py failed only one time.
 That is 0.00014% failure rate.

Signed-off-by: Ermin Sunj <ermin.sunj@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 3a447d03e2a8..dafeef0c2dab 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -68,8 +68,10 @@ i2s0-sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,name = "Haikou,I2S-codec";
 		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&sgtl5000_codec>;
+		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
 
-		simple-audio-card,codec {
+		sgtl5000_codec: simple-audio-card,codec {
 			clocks = <&sgtl5000_clk>;
 			sound-dai = <&sgtl5000>;
 		};
-- 
2.39.2

