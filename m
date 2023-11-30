Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D897FF36E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbjK3PUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346226AbjK3PUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:31 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956910E0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:37 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6DB5F40C50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357636;
        bh=DJHVa7mIKQwhZz/JHltxB0iKVUnDkFEjfRvqGAQUx+4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ivXxbZO5FV5n6b+uAnkBarCyQvRxyzCXbAn6Mr3Ceq9m0ulWFM8p3z00mO1T0mZQJ
         tkjtnIG7XSsMTn2snD29DM+GY3vWFXXujwjUSKJKtmlmcNlmUIBS4mHWV7cgNYNu4y
         mfNXzU1ZWhEx3K8rMm+1NxAUWrY6wKO1raaG535W4lMHfMrW+JrhZyAGVfCZQUGQvV
         B603voA1+pTcMmLgPxlNykTTYs6LISidRCvlg3r346FXr7Q4HjrI8Zv1ybDcYqxVJo
         yImgYvdh2UFQbLx12zQ8n9ROgzoYvhy2fkk/6MaJufzJvin+tJIqDCryWCgTb2hvVl
         76d88q9k+Pmvw==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-da1aa98ec19so1358708276.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357635; x=1701962435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJHVa7mIKQwhZz/JHltxB0iKVUnDkFEjfRvqGAQUx+4=;
        b=YdHQ3su5qGR6oXJAaQ8VL8pqdmoXkwr5En3NtkDpSQIzFIZ2EHjQInfv6/aE8qOaOg
         975qgwUtIgeGOY7VFopwCKh2FIufg5fsdV8gpw29rI3y1mNkDRP4JPEXDwRfRNiCSJC2
         ybACpnslb22IbRy/W+qhQiZLT8ZZsR30zngHeFquHJSNRP7sZMbYQPWqhgRHl9+hw3Bv
         sEGpqSxABEzzEr/0tHGJr4eCiYj/5QcGiPsShfXXLovhXFKc50bAzR4tFkjYzz5vb6Nl
         8Ww+y9L8wW7+lkkWxaahtngcCiVlFIhmeAZC0yPRvqqP5QAPM6WQNCynBUDi8Pt5KXLW
         KOFQ==
X-Gm-Message-State: AOJu0Yywt+SZ2LmghQNSFTxZFIGMh9ChZlrE8gKEM7xAUgn/Ea8LssS1
        /6R/KbrAvNaCAypmH6SJ9B68kq3Xb0neXujaze7qmKrLi/PWjws0SyAet4dOHaFTIt5NVxOBDtY
        BrCjwEf+dTMk//IF/fgIkcmyDE98s+kQwro0qsGTsIA==
X-Received: by 2002:a05:6a20:7f98:b0:188:290d:17dc with SMTP id d24-20020a056a207f9800b00188290d17dcmr23728144pzj.60.1701357614813;
        Thu, 30 Nov 2023 07:20:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7Mu2nDLembDBF+YwfqitZTioRcWFBD0XGtNJbp2zbw7AJm8Uh5SE/GyfEnowTrFxztj1irA==
X-Received: by 2002:a05:6a20:7f98:b0:188:290d:17dc with SMTP id d24-20020a056a207f9800b00188290d17dcmr23728123pzj.60.1701357614540;
        Thu, 30 Nov 2023 07:20:14 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:14 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 4/8] riscv: dts: starfive: Add JH7100 cache controller
Date:   Thu, 30 Nov 2023 16:19:28 +0100
Message-Id: <20231130151932.729708-5-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The StarFive JH7100 SoC also features the SiFive L2 cache controller,
so add the device tree nodes for it.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 7c1009428c1f..0cafac437746 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -32,6 +32,7 @@ U74_0: cpu@0 {
 			i-tlb-sets = <1>;
 			i-tlb-size = <32>;
 			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
@@ -60,6 +61,7 @@ U74_1: cpu@1 {
 			i-tlb-sets = <1>;
 			i-tlb-size = <32>;
 			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
@@ -154,6 +156,17 @@ clint: clint@2000000 {
 					      <&cpu1_intc 3>, <&cpu1_intc 7>;
 		};
 
+		ccache: cache-controller@2010000 {
+			compatible = "starfive,jh7100-ccache", "sifive,ccache0", "cache";
+			reg = <0x0 0x2010000 0x0 0x1000>;
+			interrupts = <128>, <130>, <131>, <129>;
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <2048>;
+			cache-size = <2097152>;
+			cache-unified;
+		};
+
 		plic: interrupt-controller@c000000 {
 			compatible = "starfive,jh7100-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
-- 
2.40.1

