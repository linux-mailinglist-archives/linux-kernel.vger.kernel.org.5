Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A387FB10B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjK1Eyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbjK1Ey1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:54:27 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FFB1A1;
        Mon, 27 Nov 2023 20:54:32 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35c7971a374so9520425ab.2;
        Mon, 27 Nov 2023 20:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701147272; x=1701752072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNceZKOO+3PgAe77vYkS4p5mUHqXVjcNpHRywKWrUJE=;
        b=fJEZySqe1Ql8o9xYoOK67a3mvaDut5U6zgo1C7dm39m2Par8eoZMPpTfkuLY4jlris
         X5jBoULkHsTb9hpwu/IP/Y0w/5Z/cr3wGqMxNa0iGrM/rjkTP5ntWio5a4l7T+TvBSi7
         38X0Yrl1pbHkLZ+SzncYnWoCPW/5s3ZijvixVyNEj+i9ujtTijaAfJPjG2AyYTe6MGiU
         6RGQAfmHqcSjh/1JF3U4mZyoXnNVaRMi8LjHFAI0/jwF9BZ6Rrlgw/P1DH5EyCS6GtXt
         HLTObHhkpCkj/rbTqvbTGQidp+NLMUQmr+23RLExnMsXxK0diwxmwmmjjsi7ZWL49nGU
         F9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701147272; x=1701752072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNceZKOO+3PgAe77vYkS4p5mUHqXVjcNpHRywKWrUJE=;
        b=PTQhxFncBEaf5tochsqb6ndJDoawpc2E3v5Q84vPJaecb7wOSxrZ/l7MZ/QRBDWLfn
         /vOfAMoi9eg6K2VCrIyhrpgO33SlZaPLi1sYhVBFv4Ujn/sW9kXplP3blgMXme5bhQf5
         q1W6/YVOq6G202Z2Q0KjAyOBerSmoabBoMd4Y5yPal2MjZv8pbf1iqk9mYzQ7SS/15nX
         0dk51UNP6cSMdW7onGVMjhbA97wtsrHTN3G8DZAIk9/kE1hr21vTZCBW8sT6//vIvXl4
         qvxVPRSk4Y2gSv5M0lrW7gnzETbjq3IP320D3PlLzxgcBtQesSQdRhtT/gVkos4Xv0gR
         1SIQ==
X-Gm-Message-State: AOJu0Yz5piXtfJtZ6IQZqRFKqRFIzaKaYWSUS3K19hbBNmiAptW6XtGG
        +yZW+4xS/tjcN1k3oBW6SUX8Z1eSGs0=
X-Google-Smtp-Source: AGHT+IExnDh815yNXcdkZQfo9IX7WR97yNJG3EUz1x0WT2HG5Y2G5t4wO/8aeDBpZWykVIfrcsDVTQ==
X-Received: by 2002:a05:6e02:1c07:b0:35c:d4c8:b272 with SMTP id l7-20020a056e021c0700b0035cd4c8b272mr5638454ilh.30.1701147271815;
        Mon, 27 Nov 2023 20:54:31 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:5d62:b359:8b5c:90ac])
        by smtp.gmail.com with ESMTPSA id bo33-20020a056e02342100b0035b0b05189bsm3357251ilb.38.2023.11.27.20.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 20:54:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembeded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx8mm: Slow default video_pll1 clock rate
Date:   Mon, 27 Nov 2023 22:54:15 -0600
Message-Id: <20231128045415.210682-3-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128045415.210682-1-aford173@gmail.com>
References: <20231128045415.210682-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8208181fe536 ("clk: imx: composite-8m:
Add imx8m_divider_determine_rate") the lcdif controller has
had the ability to set the lcdif_pixel rate which propagates
up the tree and sets the video_pll1 rate automatically.

By setting this value low, it will force the recalculation of
video_pll1 to the lowest rate needed by lcdif instead of
dividing a larger clock down to the desired clock speed. This
has the  advantage of being able to lower the video_pll1 rate
from 594MHz to 148.5MHz when operating at 1080p. It can go even
lower when operating at lower resolutions and refresh rates.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index a3dae114c20e..669fdd2c54e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1131,7 +1131,7 @@ lcdif: lcdif@32e00000 {
 				assigned-clock-parents = <&clk IMX8MM_VIDEO_PLL1_OUT>,
 							 <&clk IMX8MM_SYS_PLL2_1000M>,
 							 <&clk IMX8MM_SYS_PLL1_800M>;
-				assigned-clock-rates = <594000000>, <500000000>, <200000000>;
+				assigned-clock-rates = <24000000>, <500000000>, <200000000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_LCDIF>;
 				status = "disabled";
-- 
2.40.1

