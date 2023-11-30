Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC08F7FF35F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjK3PUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346231AbjK3PT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:19:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747910F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:02 -0800 (PST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E97440C50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357601;
        bh=tj9HPh6BvRLNZqMKySfyhhevyeW6ZzHpiXvh8Tdk9iY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qn0lkeldt9aAfO7a1JfrFQ6B1mo3I0Yazc3vuKglEVFfZ02Z/qWkuyS2Yly4ChaiH
         p53p5EXdpRkUKHteWmk3Nse9AoagTDK+4cKgnuTDdHBP8mHziMrfOdlCvhBrKim4Wa
         W+onP/Hs4yQpYPnFq078ZJ/odtPojCsCT36Zb97peTBynFBnSVZrHVHFjoHZmZuYYG
         MYMzknRSn7p6ipJPTUV0uwU26xDVCJATQRcvAp5w7GT/itup+vuyEj+s2IbHBxmZqd
         g0xGorB/GHjmMgFz5x5pVaIPC1/G3EihGCgt4nw9r+EYNrTXC0qbtVO4Gn91s758+h
         PUZIMioHUTQ+Q==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c6065d5e1bso1006216a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357600; x=1701962400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj9HPh6BvRLNZqMKySfyhhevyeW6ZzHpiXvh8Tdk9iY=;
        b=tl0+HoEIGtTq8keJKgTLlB3k6CjkZW0SeVh4t3GR5+1yjK2VrMrxK/TZA1fVbJZ54Q
         OaFlg7AWg1Uqs/JOms1DTTFbHgHRvlTysSaqI7p9ctvvFgTAmKWzpFI4VuafJpbVuXly
         b02P+c5NMsO8eaD4IflTDCcsrmuAZbdIlEL2N/+TwQjV+AtIG/uFScYk25XxPtOiIY1M
         GKeY2BPV7V89pEZHP5Fne6MX6bxYxfNxXd7geFeBnvAqAd7y/aonq1LFg6NSuwnlaYwd
         krtmFBZrIwtptSZDayNJct5p7rtfc1kRoe2oLj2du6fI7qRqIVqx3GDCK7/ya6NPbD4G
         /Ewg==
X-Gm-Message-State: AOJu0YwG/ycCZlgI2pKB8HSGt931kHVc8vTtSTLkbgUkIqsD/fmT4rYX
        TD0zshGCicctGGQslr+qL/qJ+hSb03jKpZI82kmpcnJ6xWlVOhSs/0pQpKC/DA0sBb6T3e0lScW
        eDUMM4oVUwMNhAOBrTouBd4CyWDJn2U9NfLJO8U/3zQ==
X-Received: by 2002:a05:6a20:2445:b0:187:f7d3:fe4 with SMTP id t5-20020a056a20244500b00187f7d30fe4mr23989920pzc.11.1701357600049;
        Thu, 30 Nov 2023 07:20:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1mvOn1/uJNCv0eb4azsQCzjyj+9l3Hl/zvOgcVmnx6qLHRyWHQAlXD/AuQrB0F0f5KVnWrA==
X-Received: by 2002:a05:6a20:2445:b0:187:f7d3:fe4 with SMTP id t5-20020a056a20244500b00187f7d30fe4mr23989897pzc.11.1701357599785;
        Thu, 30 Nov 2023 07:19:59 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:19:59 -0800 (PST)
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
Subject: [PATCH v2 2/8] riscv: dts: starfive: Group tuples in interrupt properties
Date:   Thu, 30 Nov 2023 16:19:26 +0100
Message-Id: <20231130151932.729708-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
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
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
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

