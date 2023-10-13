Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D547C8CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjJMSRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJMSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:17:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AFF83;
        Fri, 13 Oct 2023 11:17:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4054496bde3so24506175e9.1;
        Fri, 13 Oct 2023 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697221050; x=1697825850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9nTHaFndFfh4gMEpmSZ2pg3B4FHQG8rnUIGTQ2gc1Q=;
        b=eaDVRIETxZjuepcdt4NyIkGX8DjgfMPiCg3UZ1SI3ZOGen8Qv32+NEXu2P1cnpqsG2
         nJHMcLpQaUqjzF/lzsl4Dj9JhAilk2YoZMIxQ+tbGdaW2kKDbenYi68D+sO+XmTDJZmt
         3EUibuAhdxtAsDT28rUIO/7F9UThZPmnYAAwG5XVHBSb2DIn1retqsc7mypS2gJdOYbK
         nWP7Tqw7NhBpynaxFctiU59FDP9PNhJQUx3j5Um0xpfFjlpYu4ownkDH/yib/HPkGPzk
         9+EAW7l8C6pZ6+TAgr40tu4ODCVdw4GW33bDd8dsoNKp5/s+FXKPJRbmiNnJ5i3E5bZj
         ii2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697221050; x=1697825850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9nTHaFndFfh4gMEpmSZ2pg3B4FHQG8rnUIGTQ2gc1Q=;
        b=Cwl5xPcL+6x35yFvRgcpZNnTeaLtbzvjWShhdbZQsVZ295ZHAlE2LcbvGQEeychZVI
         vmknV7SZVR14aImVWsdQpw8V6Fti4OL0XEJztmGcDh1C5qpPQ08kMYfVf1QmLrgZlaMM
         ekd2DemolqVX41rw23evxOxtQrgUQaqWIJ5ZlqImxr90WtBQyZ7tid3FncgmXDQUH4sB
         D7ymG5PuyZAAuXfevcymuHLvqhSUaCQqI3dwlokV5ebBEBUydAYJZxA2ZCZeivfdH7lg
         xXJ99rmefvALx0+MszNptdzwWxZAbLvFQx7k2B+pEarsnAmfpG2+6EvZxNS5AjIq6hCG
         az8Q==
X-Gm-Message-State: AOJu0Yz6n0TiNK5j2VfO5+I2hH8mVQ+64QresdplR1LmaRCw0nzN5ppg
        bpoZ8h9L9/r7fEydVjBvn3E=
X-Google-Smtp-Source: AGHT+IEMQY+8CQG2bWBaKCxftHAZJe3ebRiK21zhKCFBNlUyZOjkFnTF7uZ1aniwLQKOsBk9CH5xOA==
X-Received: by 2002:a05:600c:3586:b0:406:849c:52c3 with SMTP id p6-20020a05600c358600b00406849c52c3mr23139477wmq.22.1697221049878;
        Fri, 13 Oct 2023 11:17:29 -0700 (PDT)
Received: from localhost.localdomain ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b004064cd71aa8sm800127wmo.34.2023.10.13.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 11:17:29 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     wens@csie.org, samuel@sholland.org
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH] clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change
Date:   Fri, 13 Oct 2023 20:17:12 +0200
Message-ID: <20231013181712.2128037-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While PLL CPUX clock rate change when CPU is running from it works in
vast majority of cases, now and then it causes instability. This leads
to system crashes and other undefined behaviour. After a lot of testing
(30+ hours) while also doing a lot of frequency switches, we can't
observe any instability issues anymore when doing reparenting to stable
clock like 24 MHz oscillator.

Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Reported-by: Chad Wagner <wagnerch42@gmail.com>
Link: https://forum.libreelec.tv/thread/27295-orange-pi-3-lts-freezes/
Tested-by: Chad Wagner <wagnerch42@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 42568c616181..892df807275c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1181,11 +1181,18 @@ static const u32 usb2_clk_regs[] = {
 	SUN50I_H6_USB3_CLK_REG,
 };
 
+static struct ccu_mux_nb sun50i_h6_cpu_nb = {
+	.common		= &cpux_clk.common,
+	.cm		= &cpux_clk.mux,
+	.delay_us       = 1,
+	.bypass_index   = 0, /* index of 24 MHz oscillator */
+};
+
 static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
+	int i, ret;
 	u32 val;
-	int i;
 
 	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
@@ -1252,7 +1259,15 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 	val |= BIT(24);
 	writel(val, reg + SUN50I_H6_HDMI_CEC_CLK_REG);
 
-	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_h6_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_h6_ccu_desc);
+	if (ret)
+		return ret;
+
+	/* Reparent CPU during PLL CPUX rate changes */
+	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
+				  &sun50i_h6_cpu_nb);
+
+	return 0;
 }
 
 static const struct of_device_id sun50i_h6_ccu_ids[] = {
-- 
2.42.0

