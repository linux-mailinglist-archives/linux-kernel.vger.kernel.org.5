Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6E7D4B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjJXJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjJXJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:07:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F7120;
        Tue, 24 Oct 2023 02:07:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5b837db1b26so2400925a12.3;
        Tue, 24 Oct 2023 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698138427; x=1698743227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89is/1LnKO4AiNutFqqrfRo5OqHC095NE9dIPIBTM0w=;
        b=Zk/qjyqUPSamNrIK8xkPGLRGM9DBeX2hst17oKRjHDr7GscrxtfOQ3eMgWLEVddGso
         c1pUYsyRnuDkgRe6olM0nkLYejnb9M8qLHPr/yEStCAfhLEjghtLurRbwyYWj3A98e+2
         xVI5JG1dpwLj5C27y0Y8ztx9on4LiS71k/jNuOZawz83tkAk2b+lAR4Bz4ygW2NBYCOE
         eSU3ITihlKgipzl5rYhb9OZjOodB1w/ukp7/46G5Aopb99Y5bFFPTS7DsU7IOlZqMW7E
         UwcviFLUq11HqGSi8eafx3Cim+uW2pxg3jc+1wLGDe4h2/7gxPrV83wl4rg1ptEKEJjF
         Z+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698138427; x=1698743227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89is/1LnKO4AiNutFqqrfRo5OqHC095NE9dIPIBTM0w=;
        b=YE/HfzfrLGNHXepv84LZpdvFfrV42IUR1xDCA+D2gHd+gB1LAXZf0iNRMdKaFKUhLi
         4Aocdr/IWTshcwHgwNlLL/x1LZzrCLl5L8Rs/Qm3d+4jq3BICwC83PaFd3mc1FUVZfXq
         LahtEKkVWklXPM8LfJwLwlYBWtIk41LLtmEyNSYdfWb6g4Sq7nk6JRoQxTLI28aYR1VH
         koXM5nxspW/5d2r0+huDLXJpTAnPn5D72Yh/WKCpZbsDg/iKDnqQc1yB/hkCNh3vedor
         1W3MyyxQK1eyXplKH0P1RQLbS3RZQ+U/6jbVQxxXdcDwyWy4tt2cI7LVF2IHoBHty3x+
         xhDQ==
X-Gm-Message-State: AOJu0YytdA0wY4ZEMd/wUCgW7LKmi03DNSTT+ihooM1NUZd6W422X8lQ
        czzY0ekEbE4MuGGdLLktkuA=
X-Google-Smtp-Source: AGHT+IFXCVSLmAd/Gy9fHDpoMR+ks/WKOE5Azs1P5XZslfAFdwlkPp3EP3ooHLrNau/WIBImlRnVAA==
X-Received: by 2002:a17:902:e80d:b0:1bf:d92e:c5a7 with SMTP id u13-20020a170902e80d00b001bfd92ec5a7mr10570535plg.28.1698138427012;
        Tue, 24 Oct 2023 02:07:07 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001c9ab91d3d7sm7055324plz.37.2023.10.24.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:07:06 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     jim.t90615@gmail.com, JJLIU0@nuvoton.com, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v6 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Date:   Tue, 24 Oct 2023 17:06:30 +0800
Message-Id: <20231024090631.3359592-3-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024090631.3359592-1-jim.t90615@gmail.com>
References: <20231024090631.3359592-1-jim.t90615@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO controller to the NPCM7xx devicetree

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v6:
   - remove bus-frequency
   - check with dtbs_check
Changes for v5:
   - remove npcm8xx node
Changes for v4:
   - add npcm8xx gpio node
Changes for v3:
   - modify node name
   - modify in/out property name
Changes for v2:
   - modify dts node

---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..df91517a4842 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -372,6 +372,30 @@ &fanin12_pins &fanin13_pins
 				status = "disabled";
 			};
 
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@80000 {
 				reg = <0x80000 0x1000>;
 				compatible = "nuvoton,npcm750-i2c";
-- 
2.25.1

