Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36F7FF35E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjK3PTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbjK3PTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:19:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDE10F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:19:56 -0800 (PST)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3DC563F65A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357594;
        bh=kJozCoiP+8SSmbIdgX+XEOLC3TmZqjTi2KwgKhtjA04=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tg2AgNrsOtlLHpxEc7uRzLLKEozhkNr+M545R6prrCUcJx8c3vpsNNeOFrZU2MM7e
         Em362apU0Ijd9yi8c4MAIzoI2EcmkrdXOI8xqVWzPoLAzayBS/vVYn/xfw87cC7wGi
         UHufiBSfp8/SsPkQD7yNR3gGkDLM4hXGqU7BBFkxiOoIWfBs0EU/N2yNzjBFD8fDWM
         ihZVyI6zJ3V8MTAfivnGc5Pk8aRp/zUvIDoCRyJJedyFmJuE43rdO7HFQZ15uODTQU
         0vuTNuU0RH1AflB0z76e59oZKoWJSvfe1sEBWJ1Wl6o2EaBIIsRH0Md7YmOUxPGV3Q
         2Ix3jSw/pLOCA==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b895096897so1259452b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357592; x=1701962392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJozCoiP+8SSmbIdgX+XEOLC3TmZqjTi2KwgKhtjA04=;
        b=u5YbZcWRx/2lwFoY+GOnvLfKKN02ewMYAdf3+2XH/S+nKLTAmEXVXMTswZcFC4Y+M4
         i22kCv6qew/5L+kHUSLqXGEdpjUs40EOEVw8Qh1SmQYD2p9gRYa/ddpecgw2ShgK2A9u
         Hj9Yv5MWdrJjKuyUZAYVLWhpQEVGFoiaB/vgtSdZokbzNCJ/8Oh9ipkKTRBLyUCaTU7z
         FamzVRyQTrIpJAMY6tSd6qv1Vtdgzub9+xEfLuIkcAdcH2JCZmtb1PeYjw5PJkBMHoeZ
         T9/XbSN+A42PhurzE8JbdTeP6JNrClRoI79y9alM2PJaZJEe4y2aQtmgWpJNYD75aHL0
         1Geg==
X-Gm-Message-State: AOJu0YyrResGMotA/iRpvSZxvvdHOCpUXbpWzbqk26ZO8cOo5HBADSOv
        Rl1yfkNnb263XxNMpleoo0xqGUQDmkOIC0YGqmKZ9APLeh/BUY5ezKBLkJWS20FNxm9VOh83mFw
        sfMnh2Azv4gFcGwyifyoBRIfB905IFVBiHbZPxDvVlw==
X-Received: by 2002:a05:6808:114c:b0:3b8:616b:24e with SMTP id u12-20020a056808114c00b003b8616b024emr22271201oiu.49.1701357592731;
        Thu, 30 Nov 2023 07:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/tZgpwM4g3D4RLe+xKwxGoAIWPI28s+VjwwPdoqac/L+nPUOpvs7DOtcRdrL5y9bTCAwjtg==
X-Received: by 2002:a05:6808:114c:b0:3b8:616b:24e with SMTP id u12-20020a056808114c00b003b8616b024emr22271182oiu.49.1701357592537;
        Thu, 30 Nov 2023 07:19:52 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:19:52 -0800 (PST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/8] riscv: errata: Add StarFive JH7100 errata
Date:   Thu, 30 Nov 2023 16:19:25 +0100
Message-Id: <20231130151932.729708-2-emil.renner.berthing@canonical.com>
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

This not really an errata, but since the JH7100 was made before
the standard Zicbom extension it needs the DMA_GLOBAL_POOL and
RISCV_NONSTANDARD_CACHE_OPS enabled to work correctly.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/Kconfig.errata | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index e2c731cfed8c..692de149141f 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -53,6 +53,23 @@ config ERRATA_SIFIVE_CIP_1200
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_STARFIVE_JH7100
+	bool "StarFive JH7100 support"
+	depends on ARCH_STARFIVE && NONPORTABLE
+	select DMA_GLOBAL_POOL
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
+	select SIFIVE_CCACHE
+	default n
+	help
+	  The StarFive JH7100 was a test chip for the JH7110 and has
+	  caches that are non-coherent with respect to peripheral DMAs.
+	  It was designed before the Zicbom extension so needs non-standard
+	  cache operations through the SiFive cache controller.
+
+	  Say "Y" if you want to support the BeagleV Starlight and/or
+	  StarFive VisionFive V1 boards.
+
 config ERRATA_THEAD
 	bool "T-HEAD errata"
 	depends on RISCV_ALTERNATIVE
-- 
2.40.1

