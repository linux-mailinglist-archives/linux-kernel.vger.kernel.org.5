Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685CD7F9677
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjKZX2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjKZX2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:28:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E5133
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:14 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B8BB40C4E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041293;
        bh=Vqg7fThbBt+8kUZZ3WC9X56u6PAz1V4l82aCCquh0FA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mnjkk6zWpEKw/y+GCW70v258ONf5b+sNmoz6P0vz6lbs1Ys7uNEYVfBx7c3KnW92g
         hZ4PX9U4oGKD0GvqYyFkN/tcM/WI0j3gQMwCrkEZtqQ1wrEXufWcVuQ0tHi+646jnf
         rrQJaG9LTXvwG+4Ar0yCeAbmodlBH5Kw3WkKhaCKTs2pW12gVFHLzeedomDsMtfjnU
         sa6w6wkVHMyuXnzcE5Tz9I+iEvKdSAgYlrjjSM7nlVQfsbjKX/+1IV1mTcOGPID/Pp
         n48RrtYpzIoj0gkhsSjF/PgI6C8071xn6IY324LmhW4V34VlKuo+JPTiBh481WOfl0
         8BgbRe/VGdFUA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c16f262317so3434904a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041292; x=1701646092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqg7fThbBt+8kUZZ3WC9X56u6PAz1V4l82aCCquh0FA=;
        b=MaVL4Cky+cwA6ctprRgPmYk7tg3cWQe8PFGReUp0mA54eYFwfXHmvDOnwOrI9nRBwG
         +lOTHjj8ILlgwQ5phRV3qBfawWzumTneQkS2/JpkCpf0TRbP0GyM/w1ma2/LiOFP3Q4F
         yu8gx/sh6yGqT1cuXnxJoRZYDVXEss4324GFP8wg8tosbiUdedRfUhCb0PTD07dvTJQY
         rwNBd5D3hKZ7oPSS/BOzvThkXCguTlUHQ2SBC0tVN0TFmToX7cIDWlsHRveA9MTgGHAn
         1n1WfBxja6q46xwWa2VtipTnX1fY5rnuK9Ukwwys3OIyrBlNxMq58RGUbE5XdAJUS0lz
         Js1g==
X-Gm-Message-State: AOJu0YzYcnjWVC1io0+GIXL3vIRK5hLKBmglghJsSyKLvi47Yt2Det6M
        xWLeN/ailQOUfbDFzR/a4rs5sRy4CYWqGQBPhJp8VQtaP2bYFrBag8CDdiiknPQlTxzmYyUZB29
        4EqMLTyOn9WU4b77XkoA4PS+/kgPNdfW69PmJWA37/g==
X-Received: by 2002:a17:902:c942:b0:1cf:87dd:5138 with SMTP id i2-20020a170902c94200b001cf87dd5138mr19675991pla.29.1701041291909;
        Sun, 26 Nov 2023 15:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNetELMWc4XmW/Du0+GF8pso9dZtHfzTB9OE36Oakvb80NDQtS6s7ixj3rGx/02k0I+BSaKQ==
X-Received: by 2002:a17:902:c942:b0:1cf:87dd:5138 with SMTP id i2-20020a170902c94200b001cf87dd5138mr19675962pla.29.1701041291569;
        Sun, 26 Nov 2023 15:28:11 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:28:10 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v1 2/8] riscv: dts: starfive: Group tuples in interrupt properties
Date:   Mon, 27 Nov 2023 00:27:40 +0100
Message-Id: <20231126232746.264302-3-emil.renner.berthing@canonical.com>
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

From: Geert Uytterhoeven <geert@linux-m68k.org>

To improve human readability and enable automatic validation, the tuples
in the various properties containing interrupt specifiers should be
grouped.

Fix this by grouping the tuples of "interrupts-extended" properties
using angle brackets.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index e68cafe7545f..a40a8544b860 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -149,15 +149,15 @@ soc {
 		clint: clint@2000000 {
 			compatible = "starfive,jh7100-clint", "sifive,clint0";
 			reg = <0x0 0x2000000 0x0 0x10000>;
-			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
-					       &cpu1_intc 3 &cpu1_intc 7>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>;
 		};
 
 		plic: interrupt-controller@c000000 {
 			compatible = "starfive,jh7100-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9
-					       &cpu1_intc 11 &cpu1_intc 9>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
-- 
2.40.1

