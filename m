Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2A7A3EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjIQWlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjIQWki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5112C;
        Sun, 17 Sep 2023 15:40:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401da71b83cso44664655e9.2;
        Sun, 17 Sep 2023 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990432; x=1695595232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmO+eglOY/5LVFBKrEFIX+3fDVqUYjkPrRJqtH5JB30=;
        b=SquOoCsH2dp5wpiAJU4Yd/OCW0mWlmWI2IXwwNROol79+i22MLuTBZ5jHRaTENwPgL
         8HzfRHCeZi0FyxMO38qYGqMz5kopYlp64l4rme7lbJbnolv+Qjcwu6x3qbTUn6b6Oq/k
         CzXg4imPrBcW2l31ZOR4uIr8Ev3xk4RPcU8z2MjJP1y3K49/S4QGbqdzBGJMXTlomC8G
         ekqBzWz6vNMyB2zMmqA62xuwKP9y55tmICSxPgVMlWMI7o668SjlnVp72a6SuwUXUbc0
         gSWAl7pVrzDKGxpkfDV4EMvyM/1lkvzE9px32nK4autzs7rtMkKm6QgxJtkTQtF/QzKW
         QIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990432; x=1695595232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmO+eglOY/5LVFBKrEFIX+3fDVqUYjkPrRJqtH5JB30=;
        b=rsw486R6bov89vTaJ4byHTSBGdd9XyU2pLuPt3Oy2SBnyf9OoZwiu+ZxOizyJXRagY
         bZklmUa1Dda/868T2Crv0JkIgV+SFVqqPfTgp/VoDe5i6DXeJiIK41JUIOppL/MeVyVn
         zQsepnWb94MB1zzcEHVYMnX6DWjdmd55LGgkFHa4DydodhdfKIUStpZSVs1xJsiipgzj
         suR1NXnGxWSa6cJVPTKyGSWONWV2VXrSg6WIl/Xva/AbBdfTRj9PoKniHDBFbvJok6qj
         rMsUI+o/i27nrqWwIKF3kGDwMpOipFUtlfhaazI83/KwFa2Yb1RqN9Nlp643txtk7Gpy
         aI5w==
X-Gm-Message-State: AOJu0YxBpb4dg0HkE/mk6s+64VN5nUc8JRY6Ogf3XaG4+YaT7TII7EMt
        r3nyHYph+PrXYRs9MoDrQBs=
X-Google-Smtp-Source: AGHT+IEMfrglMLkY6LiOZruW5Eu9EIdyssNQV8UWd87FhNhVYDTWF2RQUGOCbHKA/qe4SgVjsAspLg==
X-Received: by 2002:a7b:cc84:0:b0:3fe:1c33:2814 with SMTP id p4-20020a7bcc84000000b003fe1c332814mr7137683wma.30.1694990431717;
        Sun, 17 Sep 2023 15:40:31 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:31 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:39:57 +0200
Subject: [PATCH 01/13] arm64: dts: imx8mp: lvds_bridge: use root instead of
 composite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-1-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Use the actual root node of the media_ldb clock for the lvds_bridge.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..c946749a3d73 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1760,7 +1760,7 @@ lvds_bridge: bridge@5c {
 					compatible = "fsl,imx8mp-ldb";
 					reg = <0x5c 0x4>, <0x128 0x4>;
 					reg-names = "ldb", "lvds";
-					clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
+					clocks = <&clk IMX8MP_CLK_MEDIA_LDB_ROOT>;
 					clock-names = "ldb";
 					assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
 					assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;

-- 
2.34.1

