Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1D7FF36A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbjK3PUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbjK3PU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7C10F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:32 -0800 (PST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D26203FA53
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357630;
        bh=OuMn6YJcnYA0SdFjV5QIvrMlS1FQMrQ/PHdRB99f0NE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Qfay1odAmPI2ThEtelo1cVm7XYA0zuOAwD63dO8pfJehiix9h7jR9TVYFwSOqcVej
         DBUSr89DY+UUZ1K/ogy/KQNaAJWCymbcYi0eYuH4JA334o2hvnGQiZHVAjmVmFc58M
         XXiXflIYogGsSHRDnQHCs4msfC50FGb28dIK3U6Dx7KSK83GSVs4C6b/Sy3rsl47YF
         Z8NDjgW/OjbzoZaIa8qVGm+QXn0XjJZwbG1Lz6uYFn2ChsuLIZX5JjOB3o+c1i+5Z/
         cAQt6Rlp64ri4IugSWRRywNTz0OeWe9VdqNTMH9rfU8lOpHRulI5JRpT+HA6/GtKNH
         vnud3lZ6mZGAg==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6c334d2fd4cso1391210b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357629; x=1701962429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuMn6YJcnYA0SdFjV5QIvrMlS1FQMrQ/PHdRB99f0NE=;
        b=FjDSXGF5s1EkvgpXEZc31f7Dsn7ht1UnVXgonMQtgJoakWpsanKXRDL/2W3WmzbgIX
         zk+c/WhvBFvIqSSIv/vEsnyOuDjf85+snXRtbPS48ItDnD+0A+sFrHMUzwUOfvHCGf0o
         iZhDo1CMmGSNtn7pNRjMDGdAb2aYpgX7wRzCBvErZinXJLLuhlef+9lBAB5z8gM6YWO+
         rOsY335TVqmSezTn48N9btBcsvzBCMEvroT1jWVCSK6M6EOL79wg9mbXi2wntbcXhloF
         j4DpCn7hqZlEMAnrHyJOBZqfvSISeqfV/UG7eQduq4dQ33pGdys225upeWGFfdEtvl/U
         LZcA==
X-Gm-Message-State: AOJu0YziK1Ec4suHghwpBQeT5lY5SNGWsuBPXZOKGgbHncjCGO9T65wy
        O90fRWOsiVgRgQ3ebCrCYpd8DvvDEldFwSKvW8KX5xB8Rfqst2haXJ/ReUIyJJCW4hjNPQ8u4ez
        nhQ6+IMEaOhvtlCHnNtI1fIKLCIdxxRF8IQ5Yxyxr/w==
X-Received: by 2002:a05:6a20:6a23:b0:186:aac2:26b9 with SMTP id p35-20020a056a206a2300b00186aac226b9mr20943944pzk.30.1701357629205;
        Thu, 30 Nov 2023 07:20:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc8h5qPGi0AL06XqejO2yd59FH5mJfnnR0twNHQ5dxExg0fBfVTX56EPNQ52lvJlQlNYmCOg==
X-Received: by 2002:a05:6a20:6a23:b0:186:aac2:26b9 with SMTP id p35-20020a056a206a2300b00186aac226b9mr20943918pzk.30.1701357628950;
        Thu, 30 Nov 2023 07:20:28 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:28 -0800 (PST)
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
Subject: [PATCH v2 6/8] riscv: dts: starfive: Add JH7100 MMC nodes
Date:   Thu, 30 Nov 2023 16:19:30 +0100
Message-Id: <20231130151932.729708-7-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

