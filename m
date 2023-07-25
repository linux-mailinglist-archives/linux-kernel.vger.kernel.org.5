Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0988C761B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjGYO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjGYO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:27:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC882682
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:26:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522462d8416so1301215a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690295202; x=1690900002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu+SOH4cepAU3He/10eBbbigpHdBSsePlh/8VUX5+Ec=;
        b=nrDcALCBsURrCYIIx3musDDrXuazEXW7Oj1ljTKV94TayCIqzepAJjratlWbrHog2V
         /P3qC6DjqNzsD4oa92jZH0Mcjnhxnkye8jCzw4avSPIO22Xte9ExGPPFM6zhFx1AE1sE
         IawdoM5xVDgGp8TzlAm+51U3/2W2qV/gcFPPND/KcjL+E54EOQ4S33MIUz/EGq1Vsw/t
         GdXJPGjIFE7GaAp5DULAIwbr8+X7ZQ/u5TDqTkC6RWI16TeRTauEV7sC4MpLo5dgbNoH
         Jo3Lp5RN4J4PZjXZM4GKuzQW4W3/szJE5B6d9M6bijy/0tsDobZcNFsVd1UQ4WI0QfpH
         QrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295202; x=1690900002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vu+SOH4cepAU3He/10eBbbigpHdBSsePlh/8VUX5+Ec=;
        b=eNXZ5cNtJd13VBARaibjp48Uvn5/x5ZJDgH4Y0N7E05pYMZGTTSi87i0a0WG93bbNi
         YOBG+pyppbMhi8TxQha+vYxe12Xyi6Daf+FlaHBSzQLqrErhWURsBBueFXB2Zq31kvAM
         IbcudvFLH4iKVr596aw3Et5bazJ4fEPRh+k8jFdVdwj+Dx3229+RM7NisPJt1sk5CFH5
         wPTNbdZ6JLVI+9GwlQM1G3GnikYnDq2hmLjwr/cLdMPJ+wWawU7up9WiJMVQt+cqu/iP
         WC/n7gCvdXpPCtBQVpiPuThtRjM31Qj8e8LakF6wtiHqSJOfM/2xNu3zsBEBrRqRC/M0
         8SPQ==
X-Gm-Message-State: ABy/qLbcpvcyld63Dyqr/ZrvVb4DbybNyXSiObLdeqO5+mV5kE/LOOYV
        9AGo9gN/qAFOeQ11uOJuFNETjA==
X-Google-Smtp-Source: APBJJlHe2WaCVFFIhqEkOPLYn/lx1GMUgdYHp82/ZIdmUHgA6YkokG2wKA3Ec/xAodRbKTF1DXwBTg==
X-Received: by 2002:a17:906:31d6:b0:997:d4ee:1b53 with SMTP id f22-20020a17090631d600b00997d4ee1b53mr12297667ejf.48.1690295202211;
        Tue, 25 Jul 2023 07:26:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm8313621ejb.84.2023.07.25.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:26:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: tegra: drop incorrect maxim,disable-etr in Smaug
Date:   Tue, 25 Jul 2023 16:26:38 +0200
Message-Id: <20230725142638.157449-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "maxim,disable-etr" property (but there is
maxim,enable-etr), neither in the bindings nor in the Linux driver:

  tegra210-smaug.dtb: regulator@1c: Unevaluated properties are not allowed ('maxim,disable-etr' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 80476893fa57..53805555dd2d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1395,7 +1395,6 @@ max77621_gpu: regulator@1c {
 			maxim,dvs-default-state = <1>;
 			maxim,enable-active-discharge;
 			maxim,enable-bias-control;
-			maxim,disable-etr;
 			maxim,enable-gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 			maxim,externally-enable;
 		};
-- 
2.34.1

