Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448A077AA03
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjHMQ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjHMQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:29:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF81BE4;
        Sun, 13 Aug 2023 09:29:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-790cadee81bso107370439f.0;
        Sun, 13 Aug 2023 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944153; x=1692548953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cwCNs6X4jJcwApJaNSkv7YlnkadabMnWiNmxCJPzIk=;
        b=s1Llsb0zuv3RvKl172ebqYoUJ7ExuiMBapH7bui0VG/0n9OCww2xTDWS/Jd2fKw8Qu
         8H7kzhPbnDF6Y/YH6tOGY1FhNyVdLyxH2rEDRj2NEi6EPZHDh2X0bcOe3Du6IefxLOmI
         bzGhiMmRp24jrrZxznM13ROlkST4397AfjXLQZiLUyw16IOkvu2y2XqcPl0GGoQnXdGr
         JDbMi5QkIY4OjVJ0GhHrL3LCqhfPznzzS/5qMQNgAHJtxBjumneqhYMNpv5BJBqMRkBu
         +kr0l5yzvcFtPnYlJ2Y8mpD+ORMmwZwX/wYpmfGGphICNkd/Lk9XpwhWTcit3ves1jV8
         j+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944153; x=1692548953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cwCNs6X4jJcwApJaNSkv7YlnkadabMnWiNmxCJPzIk=;
        b=ijyd+Ueov55v9ik2fFvHbaoOsI5qzP8K1xQGJvaALz2G3zmC28TM3nwva7882uidX6
         cZH8zA7TJp7Ll9opyqRPEY+5RZRCtJgmFOFeP93NPszS08SLAvqGfMhgVzHIv0k/0evf
         dTfJBPKnrRKF/3x3cN1LJNl4GIWXEZcNorHA5suScchFq6vYH5S5BF53Y1/jspRy0oFb
         vkHYj2vTvzC4vQrirEM4dlpHOLo1/X3yrpluYCaXuRw8CrXxtnucKcmVEjyv7R75ybiQ
         +vzAFq1gm7gKBjFVq51blJDpU5oWsOrYwSkimG9zj+WjimnygENxb5rwTLk+dJaK+OAU
         LTRQ==
X-Gm-Message-State: AOJu0YzwDm2QJzSi9+9p2f5OGbgSnMawMPDP+Lcs+2gLCStaMX+iiV1Q
        HZ1y9cnii6omNa/WlM11xBYw2NooCDA=
X-Google-Smtp-Source: AGHT+IFBO6DdSxulJCL01P2Lxc06UrO+73c8UExGsPeBdNbmi7kj9S34TR9Qxs5alyyeR0JpKdzBTA==
X-Received: by 2002:a6b:5c08:0:b0:790:c9a9:d760 with SMTP id z8-20020a6b5c08000000b00790c9a9d760mr9174772ioh.16.1691944152951;
        Sun, 13 Aug 2023 09:29:12 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:21ab:bc25:b29c:7b7e])
        by smtp.gmail.com with ESMTPSA id fu11-20020a056638668b00b0042b6a760c31sm2454767jab.28.2023.08.13.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:29:12 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
Date:   Sun, 13 Aug 2023 11:29:05 -0500
Message-Id: <20230813162906.22640-1-aford173@gmail.com>
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

A previous patch to remove the Audio clocks from the main clock node
was intended to force people to setup the audio PLL clocks per board
instead of having a common set of rates since not all boards may use
the various audio PLL clocks for audio devices.

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

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..408b0c4ec4f8 100644
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
+								       <800000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
-- 
2.39.2

