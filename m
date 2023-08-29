Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCF78CD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjH2Uie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbjH2Ui1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:38:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D69CC3;
        Tue, 29 Aug 2023 13:38:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99cdb0fd093so638513966b.1;
        Tue, 29 Aug 2023 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341501; x=1693946301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9DunujICwW+FdyG9ifMFQMXRh/n/3eNMexEB6m+XBc=;
        b=KqdTmlRbTTDDMWiKdgApOgOI4Po/+Kk+Usnx42GjJrLg0XJM2pCr7vfqH4jvu7jT5x
         Sul8WIfCYJFwJ28oQK2kAxQP9TlfnBoFbjLBlLWiZSBCYb8bE+Bk63RrhV3gwAWn5jBw
         1K398ttnewO+FvFQoFhVE6cLR4dbd2BnguoeDXaw9Nd0IW6S/CrZPyu50h+TQmRRoyhv
         1nsAYCBGI1rHIueM5ReabF5U+jJpDU4Z4YSeeUkRoX1vwPKjK/x3O12rxPKi7mlAxIj6
         +HKnLjyrkzMJuTiTISJScG1u+hjdhgP4VSmvPB0CF/qoO1eQ8gpNtjIwcIL5NDX3J9Uf
         DwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341501; x=1693946301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9DunujICwW+FdyG9ifMFQMXRh/n/3eNMexEB6m+XBc=;
        b=Gl0qDW+Td/Gepy5Tb+vrF0X2Nhm3r3S7us8vnNpNtOkjLLiQRGOHTKIp9njmHx08b0
         tLZAIibmAlpO8KGLGdVwzEH0qSZGyUyeF4LsoNtwNWmKe/MeBKJoyWY8IzQkTywYpdsm
         0aBRNzfE+Qa9oclw//1er2QZ29XQbSTQ/7TuxC8jpvKJ1tA0F8I7vQsrl5y0m6l3SrD1
         ZK1beWnhzxbsrvzi6yDuzZga6b46XHx+DDGJvdEV2Eesb/8aXCcPRMhs4AlDTRe8cqu/
         3s5Oj6h1vJBmjBkSUaYVxO3I/eITnBBd+F9AO/0gvsZgFrpY56U5OSZV2OwmLLQtlKvH
         YuSg==
X-Gm-Message-State: AOJu0YyJOIffyI9ZfAbptGQgntfKJOaCCGDNnRKShrmw5wX76Uucfx5o
        3UiCYa4hs2LoGfIjmKVOvQ==
X-Google-Smtp-Source: AGHT+IGzovbuvRi/NoA+BSlRDFpWfGddCHO/7MqVFe2h+n0fapdIraX3TlcPIRaGWebC8sszbwVGXQ==
X-Received: by 2002:a17:907:8b8c:b0:99b:de31:6666 with SMTP id tb12-20020a1709078b8c00b0099bde316666mr96013ejc.22.1693341501628;
        Tue, 29 Aug 2023 13:38:21 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm6301908ejx.102.2023.08.29.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:38:21 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 1/5] ARM: dts: rockchip: Fix i2c0 register address for RK3128
Date:   Tue, 29 Aug 2023 22:37:21 +0200
Message-ID: <20230829203721.281455-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829203721.281455-4-knaerzche@gmail.com>
References: <20230829203721.281455-4-knaerzche@gmail.com>
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

The register address for i2c0 is missing a 0x to mark it as hex.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index b63bd4ad3143..2e345097b9bd 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -426,7 +426,7 @@ saradc: saradc@2006c000 {
 
 	i2c0: i2c@20072000 {
 		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <20072000 0x1000>;
+		reg = <0x20072000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clock-names = "i2c";
 		clocks = <&cru PCLK_I2C0>;
-- 
2.42.0

