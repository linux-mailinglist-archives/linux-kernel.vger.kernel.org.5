Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E627B7CEE06
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjJSCXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:23:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC59B;
        Wed, 18 Oct 2023 19:23:18 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-419787a43ebso47763561cf.1;
        Wed, 18 Oct 2023 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697682197; x=1698286997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dimg1l+YMRLp1DFCSJLkXMuU0P+ufAjg83AOKIFzRrw=;
        b=dezZrkqLJj+pBhm8MW8RKBAAHTDD7Ei/1NG2B7p6NT8IZmBT0JGx/eSvmrN+hCGBUm
         3fRtdcNR65Gu7qH/lP9+l233S1a2BRtgAMdn8POYtZTIrRLJJVYxT4T7AH3phHBi7240
         cRLwQDkOYaGZ6aBk31S5y3sR1Miwu5FCR/Abtb9NoFwzFuhhnTQ6DX0hnGqGsSP+h1q4
         meXggAXasHSeczUfaZpf4DlJTT4XXV58R5l/3+zNwAgAGOWOBveqWjAoM6vP7PD4huhi
         rSXgHX4N6U68W0vQwSVK/XcClCeljIo/JBxSLMW035UrQ6EfbpwC/0AlMicKya7zj14L
         befg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697682197; x=1698286997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dimg1l+YMRLp1DFCSJLkXMuU0P+ufAjg83AOKIFzRrw=;
        b=JOdgC3KjbH515w1FuahwRyIT+robOn7ZO07gusddSbCOOxYqA1ebNb6FdbuHNeXbwW
         Wf5NJHfcoZrxN5tcvcn9TeUm+rS3u1vCT6SxKNhyI1TD/yDQvN+tkhnxTQrIUrkkwY9e
         gc0HwR0FfC1zxKkFcP0Ss6dOolIXclnD3J1Dkn3BKaTSCKtWljh0iVSJy+pBZG8c2mye
         3e7Cz2kMPquLgJeYg8pVy2ewoOqahqjPAkfedpYhC277NlYu3//SBuok1QyRJzTorsj4
         ZvQaP2EDtbuUdOxbwjq8xz0Zt1IjPHJraloc6/sjsW3iOYp9LswIWruOaoLWTdVscSjX
         hTQw==
X-Gm-Message-State: AOJu0YyLNqVecLB0/yarYkLqi+C7AP3xgv8xcgLrAdzwAM2VZA6WDZfl
        KkVzncgyN7bVwap4clNkVE4=
X-Google-Smtp-Source: AGHT+IFtBGeoiy3MCLbcZKi8dHYnpcKWxNyVsIueWbslKVXXGLB4mmBVa9IPLrvRbiuhs1y/wTjn5Q==
X-Received: by 2002:a05:622a:1910:b0:412:14a8:24c8 with SMTP id w16-20020a05622a191000b0041214a824c8mr1212595qtc.8.1697682197359;
        Wed, 18 Oct 2023 19:23:17 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:be33:c8cc:260b:4a5e])
        by smtp.gmail.com with ESMTPSA id jz14-20020a05622a81ce00b0041cbf113c28sm414336qtb.40.2023.10.18.19.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 19:23:16 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Add NPU Node
Date:   Wed, 18 Oct 2023 21:23:00 -0500
Message-Id: <20231019022300.1588041-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NPU is based on the Vivante GC8000 and it enumerates as

 etnaviv-gpu 38500000.npu: model: GC8000, revision: 8002

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9a610ba4836..1ef8d17726ac 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2012,6 +2012,25 @@ vpumix_blk_ctrl: blk-ctrl@38330000 {
 			interconnect-names = "g1", "g2", "vc8000e";
 		};
 
+		npu: npu@38500000 {
+			compatible = "vivante,gc";
+			reg = <0x38500000 0x20000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MP_CLK_NPU_ROOT>,
+				 <&clk IMX8MP_CLK_NPU_ROOT>,
+				 <&clk IMX8MP_CLK_ML_AXI>,
+				 <&clk IMX8MP_CLK_ML_AHB>;
+			clock-names = "core", "shader", "bus", "reg";
+			assigned-clocks = <&clk IMX8MP_CLK_ML_CORE>,
+				  <&clk IMX8MP_CLK_ML_AXI>,
+				  <&clk IMX8MP_CLK_ML_AHB>;
+			assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
+					 <&clk IMX8MP_SYS_PLL1_800M>,
+					 <&clk IMX8MP_SYS_PLL1_800M>;
+			assigned-clock-rates = <1000000000>, <800000000>, <400000000>;
+			power-domains = <&pgc_mlmix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.40.1

