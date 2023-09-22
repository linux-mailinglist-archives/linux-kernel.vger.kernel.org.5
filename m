Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06437AA8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjIVGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjIVGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:24:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401F83;
        Thu, 21 Sep 2023 23:24:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1073814a12.3;
        Thu, 21 Sep 2023 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695363860; x=1695968660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ce8/QAABUl/Q3jFyxxZV+5lP94Ev40T9XLcoA3tCOQ=;
        b=Zr8rmfwQhtAqwuH6NnT83eOyxPTYNG4RTX7nsGfLG5zZAG7SoGnr4TV8d5w48c9Bsf
         31WrDI7zDMC+N4RhtUrWozXvn61sVzgxdWVYNK9rpDMqvJeBYI7fjFVCOjuz039QfgFe
         X/nCOkkyVypWgfprc6rYpA03xvOMzIf1448dErgjgfP+iCkCaKgSINK+97PH3IaKE3PH
         47NcT01ub6YRuXz3PFg/5V7AviV6gvB5R73YHgmcvuAy/+KgXYF+BR6f6E77EpGGHVXK
         l0sQ71yjK4LiX0g8mCiBcqyOKinVRUL0MynE9oSmLEUAMc1QYsGe0lKZjlV50UMO8u4k
         Gvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695363860; x=1695968660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ce8/QAABUl/Q3jFyxxZV+5lP94Ev40T9XLcoA3tCOQ=;
        b=b0jiUYgGiURnl/GJ93uDq80idUnz0ZhVIrxPV1XvL4TXAOFPijb4QaWDlKOUplk2hx
         HYZ6QIJG4+Fd8XdJELTc1m3eCmytyYhMKV8vDAsdUM94kC0HfDKbwMZzbLfQ7TfcJmuu
         ZHfHAus7O/AWuT6ZUL8TneyivbS1/fKVzDJl7HoUWJr/twAdOMutkT8WvTcZx4xBqQNC
         MhKBDTkBziXqjxINo4jR+oGZP7DedNqlSKtG/2YBTupdCM/lGSy0xCZFsDu+opFjBvwl
         GGIkxzLo6/qRcHJv22OxJ/eFmBUBnmEwrgoszLtWnAju6Yi+8NJF6SvmF5iXpaD0gpj1
         NUjA==
X-Gm-Message-State: AOJu0YxLG5XdbHfIK0ZiQUTPDfKzk4NwEWyA72Muqhbwm0OfLQu3kiPS
        30spR3yjDRQI/EZnglk4IHc=
X-Google-Smtp-Source: AGHT+IFhQjVuS1CC2PunRJNz0HYPfEL0rk671Tl12LHtA+Xp+2Kx8/034wdXuS2gi56Zjz+3ZlNGsg==
X-Received: by 2002:a05:6a20:428e:b0:157:b453:dbb9 with SMTP id o14-20020a056a20428e00b00157b453dbb9mr9153065pzj.6.1695363860460;
        Thu, 21 Sep 2023 23:24:20 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090ade0b00b00274de7c8aacsm4157417pjv.45.2023.09.21.23.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:24:20 -0700 (PDT)
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
Subject: [PATCH v16 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Fri, 22 Sep 2023 14:23:59 +0800
Message-Id: <20230922062405.2571850-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922062405.2571850-1-milkfafa@gmail.com>
References: <20230922062405.2571850-1-milkfafa@gmail.com>
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

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with
Nuvoton NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..e69746948f5e 100644
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
@@ -563,6 +581,11 @@ i2c15: i2c@8f000 {
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

