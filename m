Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80C7F9680
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjKZX2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjKZX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:28:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A1189
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:40 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B6FB43F885
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041319;
        bh=OuMn6YJcnYA0SdFjV5QIvrMlS1FQMrQ/PHdRB99f0NE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SOeL1YT6bSbk0XdhgDWSbLQ3Oy2/R330q1FZW9Otql84J+LVo+a+ftyWioX7X+XLE
         WsxSrwwg/P59pPDLYmxOJAl/9TCz1USYBQgmpN8hXweRkD3i6Bf0moQR+W54rQT5VD
         H+vQL8+7CsGj71XsrVF/gLCpx1htMw5a6FAUB+tdZdIFso/ohrT0kG2Pd6iPeOfCTF
         +drDqIKz/kEztmbP9ijGw/XyKRMhKRQT1tjyl8CgZvKAlZqqZVs5zlYkr78aooDeJn
         D2Ca80EAPxvcRPKDIVxDVq75Vp5RdfKH9n0Au6CImu5fIqu534LWbQTrwJjaAwWatG
         qBuf15ArBLASA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf9dded6fbso41735415ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041318; x=1701646118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuMn6YJcnYA0SdFjV5QIvrMlS1FQMrQ/PHdRB99f0NE=;
        b=ott6IR6v2uVLI0JHHLk8lTvFnDbPS7DhI04wS1t/C2Nbp18HlVMgI+Ne0S9RqO65XC
         g/PSfps2aCg9bHalKRTIdaKuf2of12/TQ4WtY/P4j4+uyXo/GokB4AGqQtpUhPP5STTV
         6fU/YfqvAPUQzFygKUGZP0e83TwqCFTc1bZKyl/AM+fgYQ9jlizinrTN7V9I04sf1NhJ
         3oX4gB7ueGcGnx3AhiXvfcSB8gAwZMACwwzdjKhMpwunjS/G6f5o9//Wtm71SB/7w+do
         jx30nxnzG46uM/I9DUNEvPNcY9wWd8/1TOG05VyzEFXW6heheoeff3AD+WweuOJHg3LM
         Ipsw==
X-Gm-Message-State: AOJu0YzAuVWAOpT0mu+kiNMISIJppY+Av4Xyj72x+Il92apCVKnBXGvM
        aobF/Wok53MJHPePKRWs5zf8mboLsDxo3ODanjNWOuhkSIsbM6JVllmqIIyF1mNJLi5Q23s4DC1
        F4gsJgxhqagYYYLsGIenBMJqr75Szn6Mtnh5OCKIy9A==
X-Received: by 2002:a17:902:e80d:b0:1cf:b56f:5359 with SMTP id u13-20020a170902e80d00b001cfb56f5359mr6002915plg.16.1701041318485;
        Sun, 26 Nov 2023 15:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJoOhGmXHm3ZFgs42HkJ4RCFLyzcurPDAEjQybVEulGwZcrjrwFmdT8LY5fG5jxKouwWX+bA==
X-Received: by 2002:a17:902:e80d:b0:1cf:b56f:5359 with SMTP id u13-20020a170902e80d00b001cfb56f5359mr6002901plg.16.1701041318277;
        Sun, 26 Nov 2023 15:28:38 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:28:37 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v1 6/8] riscv: dts: starfive: Add JH7100 MMC nodes
Date:   Mon, 27 Nov 2023 00:27:44 +0100
Message-Id: <20231126232746.264302-7-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for the Synopsis MMC controllers on the
StarFive JH7100 SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 0cafac437746..c216aaecac53 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -178,6 +178,32 @@ plic: interrupt-controller@c000000 {
 			riscv,ndev = <133>;
 		};
 
+		sdio0: mmc@10000000 {
+			compatible = "snps,dw-mshc";
+			reg = <0x0 0x10000000 0x0 0x10000>;
+			clocks = <&clkgen JH7100_CLK_SDIO0_AHB>,
+				 <&clkgen JH7100_CLK_SDIO0_CCLKINT_INV>;
+			clock-names = "biu", "ciu";
+			interrupts = <4>;
+			data-addr = <0>;
+			fifo-depth = <32>;
+			fifo-watermark-aligned;
+			status = "disabled";
+		};
+
+		sdio1: mmc@10010000 {
+			compatible = "snps,dw-mshc";
+			reg = <0x0 0x10010000 0x0 0x10000>;
+			clocks = <&clkgen JH7100_CLK_SDIO1_AHB>,
+				 <&clkgen JH7100_CLK_SDIO1_CCLKINT_INV>;
+			clock-names = "biu", "ciu";
+			interrupts = <5>;
+			data-addr = <0>;
+			fifo-depth = <32>;
+			fifo-watermark-aligned;
+			status = "disabled";
+		};
+
 		clkgen: clock-controller@11800000 {
 			compatible = "starfive,jh7100-clkgen";
 			reg = <0x0 0x11800000 0x0 0x10000>;
-- 
2.40.1

