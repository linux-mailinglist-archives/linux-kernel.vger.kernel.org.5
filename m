Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD5781920
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjHSKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHSKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:52:24 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974851B316;
        Sat, 19 Aug 2023 03:50:14 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34bae4fa2a8so6261655ab.0;
        Sat, 19 Aug 2023 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692442214; x=1693047014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbeZQ2le3QtFAiVegoQee4BG0sxJfK1rPbRwkbBgjUU=;
        b=EQX1sOvvQGxUahz1mDZkIRZIWFPKspEuIrX2EEYZuowtSFEreEGJak6pyk/Rvj5Q3W
         Wy1VX4ks7xdlRU08zcIP+JsHSdZO+B6uKv+/VaSJtWIOrkUUz2juJjtYZN3pLX21x7ca
         x+WUxlj4fccRG7GrJY4ebweGkrV4/gFee0wPMNrhjljlJKt/V3EUPFyFKYnbGTupw87C
         Ktqw/HVEU1s4P4op4U/sIM2phjfMykyhrNUTAVvcSjaXDpNuEWEqH0ZRuWKslc76w3s+
         lBb2qm06qUwbF+lgNcUNhlIgxjN4aAYO4gK7Ykmy/f4up2jV8q99CFJL4dRtleg5ozvQ
         itMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692442214; x=1693047014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbeZQ2le3QtFAiVegoQee4BG0sxJfK1rPbRwkbBgjUU=;
        b=NEXAlFCnk9CxnDKLQ92ZHEtAOqCdgmN8mNX+Gp5dqlvWEzwxdClzzAe9umqpVaNo8U
         ww9amWmlPshWbZx/8JQFIKLgXe/vc1l+shgGxWPbqk7zqhmsHk+BYp2GKjfyIuf9wd9v
         yvbdtk3EzxeLO9u2wQEeGNlDGBdTkv/MprvN8MaXj85ZY7qdEvUV+mNqei6J8NMi0+89
         bKDZ+bQX70B54XISytO5an/RjUa+wGhjl11maFly5YT5MKd6dlKvWwc54kICEaPALdN9
         a5pebucRiMdmeXIxVDn7FeMXc1CBaelE6d0ZkWA3c1D/y+WQTAxAS9sniRHgmWRNHCeI
         EVbA==
X-Gm-Message-State: AOJu0YzCPzUdf/pd+C94ByeunXxZQN6HNrurXr8nulWcindMz+WM0aOY
        g8j+cqMikZNMslaMl2BSumc=
X-Google-Smtp-Source: AGHT+IFUw0ajLQarhK4ZPWbmihPnfaEUnAWHuo0k02mh1YcKSE2jirroj7XTRp5Vb64fRDfC+ojpbg==
X-Received: by 2002:a92:cd09:0:b0:34b:ba9c:78ac with SMTP id z9-20020a92cd09000000b0034bba9c78acmr2319943iln.25.1692442213672;
        Sat, 19 Aug 2023 03:50:13 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:4a28:99c7:cf07:4f94])
        by smtp.gmail.com with ESMTPSA id h16-20020a92d090000000b0034ac4ccd097sm1116470ilh.33.2023.08.19.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 03:50:13 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
Date:   Sat, 19 Aug 2023 05:50:01 -0500
Message-Id: <20230819105002.132750-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks
from CCM node") removed the Audio clocks from the main clock node, because
the intent is to force people to setup the audio PLL clocks per board
instead of having a common set of rates, since not all boards may use
the various audio PLL clocks in the same way.

Unfortunately, with this parenting removed, the SDMA2 and SDMA3
clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
and that clock is enabled by pgc_audio.

Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
AHB, always 1:1 mode, to make sure there is enough throughput for all
the audio use cases."

Instead of cluttering the clock node, place the clock rate and parent
information into the pgc_audio node.

With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
400MHz again.

Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  Update commit message wording.  No functional change

V2:  Slow AUDIO_AXI to 600MHz for nominal drive.  Individual boards can increase
     this to 800MHz if they have the proper voltage configured.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..83d907294fbc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -790,6 +790,12 @@ pgc_audio: power-domain@5 {
 						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
 						clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
 							 <&clk IMX8MP_CLK_AUDIO_AXI>;
+						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
+								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
+						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
+									  <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <400000000>,
+								       <600000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
-- 
2.39.2

