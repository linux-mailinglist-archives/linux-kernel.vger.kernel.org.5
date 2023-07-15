Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7752F7547AF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGOJSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:18:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194235B7;
        Sat, 15 Jul 2023 02:18:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9352ff1aeso28381fa.1;
        Sat, 15 Jul 2023 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412712; x=1692004712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml0O9v4adwaXBJEIaQ084479cQpZdd+qXOYWMXt4ElA=;
        b=XXh3zvoVnJjyw+Vw1oB7KtQZbYBRIaUkMaa2x991IFW0s/OZ/kSSYGNrCDOxKTKYSS
         ZL8VA1Eu8gzIpmqN46PkaZpKdMzSsNwWOOYDfbN2WMv5nLEcrIJZPdhk5Apgva7LqSvX
         Mep8qlq7D+CRYNI+eWLfM1wLJIyhu41m9AnwXuNl0sjNWTtoCDbXVO1Eeii8QIXK+4FO
         v+TMjRBVlMlfwrL8USiNrcmwZcVnsFD12XaaKAARJlULo4cqpaYlLtUmKaK2d6Nkekka
         Uc7865qWaLXql6ZXEjTwVN+E0gH+luOuNY6Nur8QLI1EoasrBJax258VzZHzgw+gi8Vw
         N3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412712; x=1692004712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml0O9v4adwaXBJEIaQ084479cQpZdd+qXOYWMXt4ElA=;
        b=hF6/jojYZ/Dfiqndh5Pyixkw75MlHRhTFxg4s7MHRZ5gUhVT+cnzHCQIuMFAUyYrI8
         mwHr2YjYngbCaBKCWOHAq12boyp8C9S6fvIX+rPPeskvZDwTmN7kARI6kEsZwztYh0ns
         82BNK8hSzgFOazzaYd+IBqzPHthcOv08fW4V9OYljzdnTPx81sqQnLdLlaROzrnPQxLU
         UJnTSP6Pb2emctp7VLLFt7Ub+HiEDucR1p0BSs08EwBhYJTwNJ2DBIPD9Qtgv7Ca+zyg
         ikhpF4L8Yl6kBLUWTwaSolRRqKbMNsNqISgRNnH9E/7VCvqvczxfSap/6LrQX/U4mcp4
         FrxA==
X-Gm-Message-State: ABy/qLawXi7S1A+i6NESpEVyFlHvYeh0rH/iRHDlcQiwOw/U2UclJFkP
        6BafeZI85nNYskVYjor/FgVCdiR2Jj8mhQ==
X-Google-Smtp-Source: APBJJlH2MjuUkNhIv3D5y271CR9dnERIGeG6VJrEdFCX/0Z5fkvnvbXOAyVQ9MxF3mJap1rTA1eULA==
X-Received: by 2002:a2e:9bcb:0:b0:2b6:dec9:2813 with SMTP id w11-20020a2e9bcb000000b002b6dec92813mr5993004ljj.29.1689412712645;
        Sat, 15 Jul 2023 02:18:32 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e9891000000b002b840f283a7sm561784ljj.36.2023.07.15.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:18:32 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v9 1/4] iio: adc: Kconfig change description for Allwinner GPADC
Date:   Sat, 15 Jul 2023 12:18:13 +0300
Message-Id: <20230715091816.3074375-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230715091816.3074375-1-bigunclemax@gmail.com>
References: <20230715091816.3074375-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoCs names to Allwinner GPADC description to make it more informative.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dc14bde31ac1..5f1e9bb59623 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1116,7 +1116,7 @@ config STMPE_ADC
 	  built-in ADC block (stmpe811).
 
 config SUN4I_GPADC
-	tristate "Support for the Allwinner SoCs GPADC"
+	tristate "Allwinner A10/A13/A31 and similar GPADCs driver"
 	depends on IIO
 	depends on MFD_SUN4I_GPADC || MACH_SUN8I
 	depends on THERMAL || !THERMAL_OF
-- 
2.39.2

