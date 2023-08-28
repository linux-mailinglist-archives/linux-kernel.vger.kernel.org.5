Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714B78A8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjH1JUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjH1JTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:19:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065E119;
        Mon, 28 Aug 2023 02:19:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1e128135aso2485165ad.3;
        Mon, 28 Aug 2023 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693214384; x=1693819184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbS7rm6AM4XH8UoO3ynpeSvV1hwaSm51g+RnnML8YOM=;
        b=YodWdcxpmi1vlBOI6OdIF4vqS9vpCZDyBWxzACA2bSz2WMea3RmCvfFn5NrYB/FZeK
         g7FaxiQlRSkV9Uq0tgVz2bfbzQH4Whz/GNTDCuumlW4paVvTSZN99NL0MDuLBylykD+V
         EuYly0sKs/QoQBdFPR7stAyVv5e0Hy6wy9UOzNyHUMx0DnXXs0gtQzjZsJHrqJtKYaHf
         hePueIB6NMalm482Kuu7PZ6MMZSGqI03xKILXUaj7V/0DrjWh8Ew9tnB1PzTJbXke69e
         M3lo4Y96/4xLOgWtsbyKL9tbJpJTyWSSfkK/aXq3tn+X4S/opxfJB8GCmcJtT4u37bRn
         vXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214384; x=1693819184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbS7rm6AM4XH8UoO3ynpeSvV1hwaSm51g+RnnML8YOM=;
        b=EPERR6VcMvipTCqSuBtmMnuAEq7mcJAM87ldXuxb7cj7PV42az9sNuHPIuwxB6vLnO
         TvREn5HJ4h9YBpAhrLUvVT/6w1wb3yxoDVHuFft/BHf9koNlPSV65WRyypORq4+/EYk5
         c+QGgtCujfG5ythMCL1FnijzdIasJCe/I5b/8hB+nDgEWDBLiyYX9qZYmISkMGfUGMBc
         la2B78ZNVAzbDhXb7pH3JSK+ZEfxejJ6Bg5bkIt5cR4Bpo/hez8bzAqm5nnL/Bk9BxOR
         FSXoJWI+jnLPcNGpAvqoSeDnP3A34XeM3o1h/Qqc4Lui5N5A454gutvNkweK/5x1x50k
         kCcw==
X-Gm-Message-State: AOJu0YxnRLbLbBLVDeq0Q9mQfSL0vu4uUm5ON4NNdTA0bD0KlshE+IF5
        CSrFAHF66OsBweJ1bHUwcKI=
X-Google-Smtp-Source: AGHT+IH7odNiiF/hoGEiUynml4QiYQweYZlMdFY5WVPrB5CAncp5aLmyxy2VuIEH/hYtcsVoPVCQfQ==
X-Received: by 2002:a17:902:e741:b0:1c0:ad3c:c723 with SMTP id p1-20020a170902e74100b001c0ad3cc723mr14511699plf.10.1693214383807;
        Mon, 28 Aug 2023 02:19:43 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001bf8779e051sm6749403plg.289.2023.08.28.02.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 02:19:43 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v14 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Mon, 28 Aug 2023 17:18:53 +0800
Message-Id: <20230828091859.3889817-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828091859.3889817-1-milkfafa@gmail.com>
References: <20230828091859.3889817-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with
Nuvoton NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..13a76689e14a 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,24 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		vcd: vcd@f0810000 {
+			compatible = "nuvoton,npcm750-vcd";
+			reg = <0xf0810000 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>;
+			nuvoton,sysgcr = <&gcr>;
+			nuvoton,sysgfxi = <&gfxi>;
+			nuvoton,ece = <&ece>;
+			status = "disabled";
+		};
+
+		ece: video-codec@f0820000 {
+			compatible = "nuvoton,npcm750-ece";
+			reg = <0xf0820000 0x2000>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -554,6 +572,11 @@ i2c15: i2c@8f000 {
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.34.1

