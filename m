Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8757F9673
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjKZX2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZX2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:28:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3A113
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:07 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A84C40C57
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041286;
        bh=UTWv7B0aMCLXIjGIp62HkL6y/eNl9IP6Uhar24MKibc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MocMhaDotGAeHqTwO11kml/FOxZkPEUMFvUX8JrPx85W3/gTYP2eK5dwI0vYTIfLP
         nc29XfQ8UVOQP8YNI0RBVPOxBgqiwpu6bVKSM1p4zq4isdjsU0yIP3QsCeP/75iCvM
         cukL9CZ9TI1+JXp6/7e15eui6bX0jQiX98+y5lcDkm9sDudGXMp+odGcUaUMklhIlg
         t4Jd2LQIaWi4gmLh8o5gDX7yegpzAioajjqVboPJBCaDs6fpIDzZnNR5j8yn16NH66
         mY/UkPWBKtWK488JPcnPZ9VzGvslnmWeDOHg+h+tfHP9r7zHFYH9dlYlEzjMEKqvnx
         CW4LnUlGFyl3A==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cf74396cbeso42328455ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041284; x=1701646084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTWv7B0aMCLXIjGIp62HkL6y/eNl9IP6Uhar24MKibc=;
        b=dLF72Wc7xzpEHYbb55I92pG8ZrZoYuZjoEYM/Bsy3svmdvXWvxiNeFU4PS2EJJJOuR
         KEadzgQ4N8LQF01fRL7KE5HmHp7xWthnnPnP+5uWlAWXJUywUa8nvcb9XMdq4dZIr/5n
         ZG/2seeh0y7ugXex/11I/w6IoRC+fXv9F63keaJ2VSZ2nuJkTdM9UM3Kr1ymLq0GAZ+E
         5+6EfoVc9JyiUNsTThCA2MLLrFB4sWqyy/+RQDx2ivenZS4OMYMApgVzLeH+PYp6++d7
         YbljwdvwcNDpFE69gLgNuYH4TTywW7hZR9zf1p9+o3LqACmH0H6x9AbtL+JfLRI5PZtZ
         ZuKg==
X-Gm-Message-State: AOJu0Ywt6IchbxS8gQXm5v6uBNU8hj286aSeqdYVJeOzxIuQa7h84EVc
        dcvjHjOUVhWbANWklfWKHig9GqP5EzWB5kVp5oLjx3AtRHFpGoCgd6EEIrKfYFIvOyA2hwQmVTj
        c1+JYYXS8KaWXp8u11CX/nkVHMlPStbyIbLeXHsQp2hyCGsePQw==
X-Received: by 2002:a17:903:2308:b0:1ce:6312:5373 with SMTP id d8-20020a170903230800b001ce63125373mr9452861plh.0.1701041284717;
        Sun, 26 Nov 2023 15:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE43ssElCwc1AHbafPfLyauBD+DF8njBdZmf6dkxFwE+D353fKdfdo6BtPGfyggI8uwjzzEag==
X-Received: by 2002:a17:903:2308:b0:1ce:6312:5373 with SMTP id d8-20020a170903230800b001ce63125373mr9452844plh.0.1701041284377;
        Sun, 26 Nov 2023 15:28:04 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:28:04 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v1 1/8] riscv: errata: Add StarFive JH7100 errata
Date:   Mon, 27 Nov 2023 00:27:39 +0100
Message-Id: <20231126232746.264302-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This not really an errata, but since the JH7100 was made before
the standard Zicbom extension it needs the DMA_GLOBAL_POOL and
RISCV_NONSTANDARD_CACHE_OPS enabled to work correctly.

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

