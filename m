Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DA7A1881
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjIOIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjIOIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:21:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE858420A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:19:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4018af103bcso12333805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694765963; x=1695370763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiFcpf2wLcf/YIfsCPE49E87uqZdxujW2soFuaVwGVg=;
        b=gnfkUaKzRQXL7IycvJpD2Otuqp6an+/+gne9ObRAQOaqwhgYBZYsWrPKKS1VoCAoCV
         JBBbP4+kgBvjbASDUSQpOnYF2HbJYTWTrfBpD2SBEaID72SgORrz37yznohvdFF8syU2
         QrguegbigvnzbDQLDwwJTIG33vuDiPJOsjkkyLZZhJWN9Sk+42br/yt5DiptPyXDmkWd
         pxeyzHRe1FbeQaa5XaE0S1aZv5Brg/s9lG+Sliavy0DYgWVV2J9pEOSqTDkA1OoO3HiJ
         AV24RylOYosEZlAlDT5s4EB0sG2c2/aw1pEdLljo+MDn7qpGcZFediPoVJe/m/JiDUL8
         isQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694765963; x=1695370763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiFcpf2wLcf/YIfsCPE49E87uqZdxujW2soFuaVwGVg=;
        b=GAcfimXdly6NVrqpjILTp0baFzQ/j3+kUOSurhMQU+CdTM60UuNSmVcWF5h1BRYZX+
         uiJ6yypW/PVtoMRGUo6ZOPKo9cqyHB/LpIwgdUfNFW5Wrhlskwl81dmiK7+2HO1jKSpE
         v+DQqCtxpsyqHYDbGaOE3/RYScfkDQZlfD1v1rTR6UTl5c+HcC2nzf/gmgSmxAt3Wa29
         CSDxSkWx/XjnZKPg1eEIaf/YM62uOyHpNpcOx75tFCrWwkgA6Ipie+r/A8FsCMBw2aU8
         O1CRA82c9blKjvSZw7y4YBF6JYxGySl64aqSZKbOCrEbB8X4GammdxSTgEcAsXrma3Be
         GVLA==
X-Gm-Message-State: AOJu0Yxv33yaotWqfihNCCZYjfoliuRHm18/ken34VlDJD9eriod0FXC
        wfv4bKPgVLB+7T/J0Vv612o21g==
X-Google-Smtp-Source: AGHT+IFXzNFNR749dSovFhgKLlWMgw4PZnj0RueOlEVM+d1kUCki23FYGgz8dPsbomfUaXNFUXtojA==
X-Received: by 2002:a05:600c:895:b0:401:b393:da18 with SMTP id l21-20020a05600c089500b00401b393da18mr3232700wmp.6.1694765962718;
        Fri, 15 Sep 2023 01:19:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm6878763wmr.4.2023.09.15.01.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:19:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ARM: dts: aspeed: greatlakes: use proper "mellanox" DT vendor prefix
Date:   Fri, 15 Sep 2023 10:19:15 +0200
Message-Id: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mlx" Devicetree vendor prefix is not documented and instead "mellanox"
should be used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
index 7a53f54833a0..9a6757dd203f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
@@ -66,7 +66,7 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	no-hw-checksum;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 	ncsi-ctrl,start-redo-probe;
 	ncsi-ctrl,no-channel-monitor;
 	ncsi-package = <1>;
-- 
2.34.1

