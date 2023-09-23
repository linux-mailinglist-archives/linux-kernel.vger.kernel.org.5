Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BB7AC339
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjIWP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:27:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12970A9;
        Sat, 23 Sep 2023 08:26:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99de884ad25so465100666b.3;
        Sat, 23 Sep 2023 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1695482815; x=1696087615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=su6WYbPXHqLnNDFrNX/cj9aw9V1j7eGBIGjhoDpKtWE=;
        b=mAL3feOzczhBdWIzpb7Iqe3Ts9fQNdReE9ERKaWGjfWr6SN2AcSALcoMNQ5egTEegA
         CMqGStaUzqgkrfeW4IPOAw7fnVYS7gIfjnohk3NngtlXm1YjRRuXHtyF4mYk8GfjuusF
         hnz7m+xwpQdyp55SwdVm8GgjYJFL0TvoBRv2WjeI+fFAsz3tUqCKn8hZNsoa2sadMuLY
         VdaIyaZEyAw00ILtUZG2RDYcwQMoCku1kGl9IK0ombY/XIPymgRWzgLR6KKBoTJD3GLp
         60npMP1wTIRICgmQgBm1VjVTTvAd3Rz+d3CgGr2nzkeovlYgSbCNAxI67gZF9f7oUGF8
         ZkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695482815; x=1696087615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=su6WYbPXHqLnNDFrNX/cj9aw9V1j7eGBIGjhoDpKtWE=;
        b=a0Vgg2NT2SYzc+Jzr4gJqMFsfIIkh9CAFEhQcOny8P3vtfCMXMfQbJCImzBay29cfz
         bSLhDh/xapI3YMUwBncm1kwfjlsYmc04JMn446qUJ/cnSw/mvSqGNBFridpQ9/BI0fy7
         9FMn98LXnk3iTUjWSu3EjtISOu4jdEvErLD5ZqwVOp8Xq0Lcx/DkldjXO/JocZKd+Z+Z
         wcg2Kh3U5frhi1Yp5KNr1jxC0tcQdRpgZLJc52R5bW3U6TUqTJ07kH0mFrdHAaB163l9
         jtsOGd04cTflE+z12YaBDuv8J7wYZk4AD2g6coXXgLuNvxtW73+wgwFbCDljyxWGEwZQ
         aVtQ==
X-Gm-Message-State: AOJu0Yy3Ivh3Xd1RJuS11YUD3ZB6960Xk3tn9lNfppCaqtCmticxTWIy
        8ehtb5rMA1VsEw==
X-Google-Smtp-Source: AGHT+IFoH2k1RhzmFyq3NWLYhDgDBjvsmXXcDn6IrBtEaB5273OwXVlXds6aaSc1IEDF0vwczySL9w==
X-Received: by 2002:a17:906:328a:b0:9ae:284:c93d with SMTP id 10-20020a170906328a00b009ae0284c93dmr1941980ejw.5.1695482815280;
        Sat, 23 Sep 2023 08:26:55 -0700 (PDT)
Received: from localhost (ip-005-147-049-011.um06.pools.vodafone-ip.de. [5.147.49.11])
        by smtp.gmail.com with UTF8SMTPSA id sa21-20020a170906edb500b009add084a00csm4007325ejb.36.2023.09.23.08.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 08:26:54 -0700 (PDT)
From:   Daniel Maslowski <cyrevolt@googlemail.com>
X-Google-Original-From: Daniel Maslowski <cyrevolt@gmail.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Daniel Maslowski <cyrevolt@gmail.com>
Subject: [PATCH] riscv: dts: starfive: Add VisionFive 2 PHY supplies
Date:   Sat, 23 Sep 2023 17:26:53 +0200
Message-Id: <20230923152653.3371216-1-cyrevolt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I checked the schematics to see what power supplies are needed.
This allows for using ethernet without other drivers enabled
that would coincidentally enable the same power supply. ⚡

Signed-off-by: Daniel Maslowski <cyrevolt@gmail.com>
---
 .../boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
index d4ea4a2c0b9b..bc1ac12bc71b 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
@@ -16,12 +16,14 @@ &gmac0 {
 	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
 	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	phy-supply = <&vcc_3v3>;
 };
 
 &gmac1 {
 	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&syscrg JH7110_SYSCLK_GMAC1_TX>;
 	assigned-clock-parents = <&syscrg JH7110_SYSCLK_GMAC1_RMII_RTX>;
+	phy-supply = <&vcc_3v3>;
 };
 
 &phy0 {
-- 
2.34.1

