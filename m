Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C477858F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjHWNSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjHWNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5881728;
        Wed, 23 Aug 2023 06:17:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so8782423e87.3;
        Wed, 23 Aug 2023 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692796629; x=1693401429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBFiSqxtgE2qy8qbvWPPqSrYIOJ343wUW66KNQ39qd4=;
        b=IVzyWNbaRAJqaA3TurIA2O1yCof/v1W5K2F3Ent7kxd6jRrE8BNwkgYcaiVOgJF1Ve
         kEWfMkthjdKlhVQxDPXlLEE4BInpyokyJ+iWhOiFgqDxJqQY33v+uke3+tjJ7mItFgJv
         Tx9NTgmrT+A5JTZwQuT7mjO6do+LuVoHI3chiD4IiXyn3Q2kRP4L+P6kQK0cQR1j2Vsr
         1kt5f0a196emSX7/snmyUt1UzEn/ucDesbuKzeH8dhje+e/0suj+3R8bdhL4M/zM06GO
         vYT27r+KvlypY5dzOEyLOOs0HRTScPQ+iHrSGVjU6F6mVVtLVaZCFrFpwB60wn4TUig2
         bZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796629; x=1693401429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBFiSqxtgE2qy8qbvWPPqSrYIOJ343wUW66KNQ39qd4=;
        b=hLr+N8OhIGCr9lPWWmjdlkvGsp2JIHfB1uCMThTRG4h7bGkjGFbx326mvB69T8AI4V
         hleL9OASZCzisMCRWnX9k8p5GWddcIw/irvIQ6c6QOq6+mRuGpqzm9fRUZznCF1347zl
         E8dH2/NwfMrmb+iCcdIB1WJVujk5efUA8QDJpth121c0+zSEGchMD/0363iQ1+lPR0M4
         Pwxu7uEqNmwl8DF8vM0JSKJZ16NlXxbg4bap0I6fGVc+5E1gCevs2Z97GyhKdohCZ77A
         6cIOWBHLiTp5Ukhi8OaTkMLlrUrlwiWfloeZo9WI+QKLB+GJjjd2CyxL4XgE595QSdY+
         p5eg==
X-Gm-Message-State: AOJu0YwMy/Uovbz2IEgAIwfJBeh6MGWxSoRXqulQOAeo5Y6d74YGdEb+
        rVUINdmqRev7cl9U+yjrmd76Kdqm5g7sOA==
X-Google-Smtp-Source: AGHT+IHT0ZG43kF2bkH6Jx4v+vfepZPgwnJjLHSz7HzuHLiPqFJ/3p+IYo8/1XCMjlZjCIfyvrMDqA==
X-Received: by 2002:a05:6512:457:b0:500:920d:2add with SMTP id y23-20020a056512045700b00500920d2addmr2367594lfk.34.1692796628748;
        Wed, 23 Aug 2023 06:17:08 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c218100b003fc080acf68sm22463192wme.34.2023.08.23.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:17:08 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     jakob.unterwurzacher@theobroma-systems.com,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou
Date:   Wed, 23 Aug 2023 15:16:50 +0200
Message-Id: <20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.39.2
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

From: Ermin Sunj <ermin.sunj@theobroma-systems.com>

If the codec is not the clock master, the MCLK needs to be
synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
on Haikou, causing distorted audio.

Before:

 Running an audio test script on Ringneck, 1kHz
 output sine wave is not stable and shows distortion.

After:

 10h audio test script loop failed only one time.
 That is 0.00014% failure rate.

Signed-off-by: Ermin Sunj <ermin.sunj@theobroma-systems.com>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
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

