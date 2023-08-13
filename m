Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927377AA04
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHMQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjHMQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:29:28 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE741BF7;
        Sun, 13 Aug 2023 09:29:15 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34aa0866014so387735ab.1;
        Sun, 13 Aug 2023 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944154; x=1692548954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA+ZWuyHKJYTTZUzLnuxcZhi2heRAd+OrRpIKUB1wiU=;
        b=QdH9YumwVmjEsIUbUB7j19JLn2O0caIdEoBwnQYJ7g7iEX4suyHTjp8FInDY3eVfHc
         5unAcqep3MOSY1ww5GvIYAhVl71UQ4BzWJFTg5mtwaE07DmUigTZkLllphM/DJ7QRTnd
         DVooy5S9vRnswwuXVsH+ovxUnv77uFLb+/x4bE368aku0Ml/14fyyNeHKGyYxUt54ozu
         YoZJZvaEsei/kgZKom7bW5eUAArr2/0G9kTcZBGqP+y3SF7Z2IwO4yN44jmUIHJ8zeBR
         Jh4l7U2raS/yMEHmCoMyMgagCTTNjDPesnf3+g4owOcRNHTyFySQ7qP+1i8ATz216Yao
         wL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944154; x=1692548954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA+ZWuyHKJYTTZUzLnuxcZhi2heRAd+OrRpIKUB1wiU=;
        b=fJ4t/dVcO4R9c+mKOpWaEGqf3ImAzSkTh0QAvHoIMID0KaNrQHBhHaA7cBLHYMlgZj
         sTvsZUjFRBOhp8/mxrn/Lbbkud76HV69Pjz9GFFQo1J4ZdsIFsLs4GAwEXO1J/8jjCBF
         7lUnSLaUBrDrFtexRTiAoAxIds0xQNGDtAdoA1aWRJEn3Dsc03JCNy2ZVJ88VyqM7svp
         D++mv8Oc79yPCGXRCtCZASWhCPQ8f55e/DtC1TEr2aJICEn4j3d5/MRYj3je13v06ry3
         JPgZUoETZiQc82/29WPkb5q0gmoBcu35rOUbxh2ZFlvHv0coMVf7l19kclOvVVmWcy+z
         vxmw==
X-Gm-Message-State: AOJu0YyIFE7zxzcBwf3hNIc7SdUsti97CLCyo3EtvhCl4ZgHHZmddKHG
        nA6GYIlJSal7766Qt/2orCQ=
X-Google-Smtp-Source: AGHT+IHgoAHPGWRVRZD7DETU0nXsOcsrlg27kCfVkL+zoPENg5flmlObvJHbBJLDIuN3BUZ9IDVFPw==
X-Received: by 2002:a05:6e02:1154:b0:348:8542:a673 with SMTP id o20-20020a056e02115400b003488542a673mr8750265ill.22.1691944154263;
        Sun, 13 Aug 2023 09:29:14 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:21ab:bc25:b29c:7b7e])
        by smtp.gmail.com with ESMTPSA id fu11-20020a056638668b00b0042b6a760c31sm2454767jab.28.2023.08.13.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:29:13 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock
Date:   Sun, 13 Aug 2023 11:29:06 -0500
Message-Id: <20230813162906.22640-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230813162906.22640-1-aford173@gmail.com>
References: <20230813162906.22640-1-aford173@gmail.com>
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

A previous patch removed the audio PLL configuration from the clk
node, which resulted in an incorrect clock rate when attempting
to playback audio.  Fix this by setting the AUDIO_PLL2 rate inside
the SAI3 node since it's the SAI3 that needs it.

Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 06e91297fb16..acd265d8b58e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -381,9 +381,10 @@ &pcie_phy {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>,
+			  <&clk IMX8MP_AUDIO_PLL2> ;
 	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
-	assigned-clock-rates = <12288000>;
+	assigned-clock-rates = <12288000>, <361267200>;
 	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
-- 
2.39.2

