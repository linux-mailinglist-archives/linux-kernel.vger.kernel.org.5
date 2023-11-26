Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8767F967B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjKZX2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjKZX2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:28:24 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1B134
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:28 -0800 (PST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C27E40C4E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041306;
        bh=ooP6PggRSm/MvoVaaWC7Qd0T8g9hHs1exEm2Idgm5Vk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=KZi+788ElKxojDUJyanMurB8Egk886Q5oA5ghrIuimxfijvBMNwS8slj1uSUYxZ0j
         4l/l9RweaCWZxfCovcDnVGLr2ej8UEdSNP4D31AGpnTmrazCPXMgCx6n6PL3gbX80c
         Pxv1OLkLCUyDf6Pc1oS8Jk7bZ8kM3nabhRiKeYjJqy4nkv4fNnqlPzo23VMqbQNrV+
         B9pXjr7tzFSud4ySabUiGXxsQgPDgoh7zeqfgR8zTZIu3NMrEsClOTmHd6OWZB7NtA
         eM23eq18Gq1rbKWoEPe9SQ04jQCZ/bqvber1NEhss2OqnajaNs4LCIrdRWH9nZ+jdk
         WWeSV4j5mAEEw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c27822f1b6so3518169a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041305; x=1701646105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooP6PggRSm/MvoVaaWC7Qd0T8g9hHs1exEm2Idgm5Vk=;
        b=bkBRhdGOk9tmClhshsNjwiAxPnoVvKAZdKRIgu04FwQ1sxQX/O40csrdrYZS/FXfd6
         L0EvbAbShdXL2I6QoQqLFC5q4rbKbBQ3Yf6Z9FVItAUaPKE+BLU5/Mk3qg7qh+n1S5h1
         kaBgjWe/H8anrZRR3CqSjm6ICzXUp2EX/HaGBR0kqusEvjBhSEGfr0yTYst0z5FM6ZbN
         1PbSqvP0LBJ6Iv8x15QCn/teP0VvbvWXMrvKbGrysuhURrd99mss1gubO3Ts5n61uSp8
         GkDNk1BpQRSaBve07FE9KLfDqodZMvmBr0uyxlVqBPXn0s+7L5LouM9JMin0fFyQjj7J
         Rblw==
X-Gm-Message-State: AOJu0YxDKRhSBelVm2WUFtgMCTTrcz0JD+4jRMjn/VEAoH23Yt7LrXW2
        MwepLegWo7MTSbrnMfBG9V5DZsFO7O9E84lOSuyoanCYBbVrs1EgsGNKXZKbvu8C3LlQwQiBO+G
        cUAlJDjB0t6UFQQrYPk5Q7BS8he1IKS2lJGbNmifydQ==
X-Received: by 2002:a05:6a20:d396:b0:163:5bfd:ae5b with SMTP id iq22-20020a056a20d39600b001635bfdae5bmr10808814pzb.15.1701041305141;
        Sun, 26 Nov 2023 15:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6/+46S+tGsJEGamPcALc1jASvPx4ZKJR3bsxdW8PeeYicEZOnptpK9l7LnyTwdz3qboVPLA==
X-Received: by 2002:a05:6a20:d396:b0:163:5bfd:ae5b with SMTP id iq22-20020a056a20d39600b001635bfdae5bmr10808799pzb.15.1701041304797;
        Sun, 26 Nov 2023 15:28:24 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:28:24 -0800 (PST)
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
Subject: [PATCH v1 4/8] riscv: dts: starfive: Add JH7100 cache controller
Date:   Mon, 27 Nov 2023 00:27:42 +0100
Message-Id: <20231126232746.264302-5-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
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

The StarFive JH7100 SoC also features the SiFive L2 cache controller.
This SoC has non-coherent DMAs, but predate the RISC-V Zicbom extension,
so we need the sifive,cache-ops property to use the cache controller for
cache flushing operations instead.

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

