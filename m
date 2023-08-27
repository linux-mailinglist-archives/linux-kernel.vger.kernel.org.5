Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1414E789AF9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjH0Ccn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjH0CcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:32:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18F912D;
        Sat, 26 Aug 2023 19:32:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77acb04309dso75078539f.2;
        Sat, 26 Aug 2023 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103530; x=1693708330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D/qWo3eeniEHWUOvOQr5eDGJa7jMw5uJueo9l6EPmM=;
        b=XuMQgGVJ1bqauAc29S++ga38hDlTJkjWGKU5uK0vFROrjXgvz9scsjtDUwpHBBMQ6a
         MuGOdH8THZn5bnzaMKPan1vSCIruCZbbZl9OWsJlQWAP1DrLad7YplPuLKgaOI8bVKwq
         wchpegxIqKyH6hgv4nG4kuPstffzGut0tC7Jrgj0U2sRjA9EvNz0azn6J6iQ80HS3KdH
         MK3SIZUxYkJnYjOLsxDj93yVZ4mN1PmneXbG2H5STLZ8sIHN3+gY0l48qpZJxwbVAaFp
         iEa6sO8BWmmbkark8C+NOVzSYTdIgvprZLaN3HC7GkFXHhcGGKOYrHFJB83pJumLMU3F
         KZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103530; x=1693708330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D/qWo3eeniEHWUOvOQr5eDGJa7jMw5uJueo9l6EPmM=;
        b=YlWd45hnBfnLn3/KJUcdfXIv95CF5NxdzTTLNEHqn2EOaIYm5YU2T4vCMOSzhHHOBO
         n+LgaWXW2jzKqCwUvMh07MG9SbNClFCQ0lNqwhGGzaGAyysE9b17oXZKaJfnVCmW4fyI
         R6OkhmtdhDSaEM7f6GqxnwHlJYlAMr48EKHxS5bseulhVojzuJSSjQ3jDZkP2C2mRGHx
         XaWoJSdBP/1Z0/FUmqcgFDXmne2L96b2NOGP3ko++udocT+6sPbmy4M+yznUKDpoxQ28
         vIRcBuUTRSvn6tk2/fjH0tp3n0Lbl25YWXmhVjeuYpF60DQRkzOgoMPHR1kqTDXIfbRW
         I4tQ==
X-Gm-Message-State: AOJu0YyMDJZQLpdCKjc8Xhm+yqpsMpTCjVSbU7JC93G9ZrxiM+Mlbz20
        jp7x94mO0s2IeHiDsB76f+U=
X-Google-Smtp-Source: AGHT+IEpnvztJJ7HO3LB7tD86lnw5g8Py4biZ+7rJUaPiHU4q1Ub+9TbQ2YansqORcIItaDYEv3juw==
X-Received: by 2002:a92:505:0:b0:34c:cee5:4bf5 with SMTP id q5-20020a920505000000b0034ccee54bf5mr10148093ile.5.1693103529979;
        Sat, 26 Aug 2023 19:32:09 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:80ee:1859:87ec:6d31])
        by smtp.gmail.com with ESMTPSA id n18-20020a056e0208f200b0034202d05fadsm1581533ilt.72.2023.08.26.19.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:32:09 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] arm64: dts: imx8mp: Add micfil node
Date:   Sat, 26 Aug 2023 21:31:55 -0500
Message-Id: <20230827023155.467807-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
References: <20230827023155.467807-1-aford173@gmail.com>
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

The i.MX8MP has a micfil controller which is used for interfacing
with a pulse density microphone. Add the node and mark it as
disabled by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 79cdd4c066c8..b44851a2f579 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1473,6 +1473,27 @@ easrc: easrc@30c90000 {
 					fsl,asrc-format = <2>;
 					status = "disabled";
 				};
+
+				micfil: audio-controller@30ca0000 {
+					compatible = "fsl,imx8mp-micfil";
+					reg = <0x30ca0000 0x10000>;
+					#sound-dai-cells = <0>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_ROOT>,
+						 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MP_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MP_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.39.2

