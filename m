Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AC7FF361
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbjK3PUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346231AbjK3PUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3340910E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:15 -0800 (PST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0EEBB3FA55
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357610;
        bh=O3TPicaObXUf+CQ2/13bF4S5EM9ZMGJpI/eXjOZpsCQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=rjPwgCGosAQVwCOmWpGHVVCvFG4aIq8Ii7KxZ8Vfkoxy1vM8gTKTxbc+QjsjCmeHj
         K1HZfIZjdFVdKvUfv8zesr7G3+6IgkQDnmV8dI6pHfBAUhgEX5y/L2/17jTzOAU5zS
         zYq7arAxqEiuyruPZ9GfuiBYadqUJ3jLxcN7sLTCNTfBzrTaLWHGKXEKkKXw3zfxaM
         myQUxaojkcXxPEJZ6FSlS6cJTAcBlegkT5J5KKiQqWaljLG0Wo4YCERqLxl2bJPdqE
         PdS25p44Og+fql3Fl9SvYVNYZrHmSNubRAeVR06BzY5ZbYvNqfEvLM6U+m7H9W8M9t
         tWJ4M4kbu8zAw==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cba754b041so1391432b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357607; x=1701962407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3TPicaObXUf+CQ2/13bF4S5EM9ZMGJpI/eXjOZpsCQ=;
        b=hJi8mZ/o9hI9TcfRZc+iJHaqduYcD9vM/reQtZQ7hXURWdemSR12v8A+B+ERKJoZoi
         krMQ1oAQqghxpMaxjnyUA4yZcL5A9QKD52lGPgHiMSDOhuDdZKcwoBPDzK/XNGH6fzIo
         FKqyoIF2SbdrYe66l4vrFEjdfifaeESXNiuvL9paykWLoZKteFy3rUzJpKKgzkExgzCa
         2zmCiJMYg+5YZWFKCrWakUFY61d5L5AXWiYKj02usnsz+gzFqlVzNKOAmni5a3BgKp9N
         eF5Zv6CnsumZFmVF8i17Fogn2gtpyGCeK7Y6II2w1Oi3oi/YsPDvbmWxipH5NHQyK24E
         QQqQ==
X-Gm-Message-State: AOJu0YyMkp/SSemCTCUb3gmNfwUckYGEPrVRmJhezQId9Wk/4W5NZfoR
        I9WKdN7BovzzKdmcitcM4jMkZqNXxDU0wiW693taD0dUu4R2MTUwYtM9wIwdT7TVWaCtg5DXZbO
        hIaD5qLSplBbJ2cucUqFJQwCR5cHWSpVtLQ/DgmCrBg==
X-Received: by 2002:a05:6a00:1914:b0:68f:f38d:f76c with SMTP id y20-20020a056a00191400b0068ff38df76cmr24404052pfi.6.1701357607362;
        Thu, 30 Nov 2023 07:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO2ck+Ida+RKRFtuLd6VUs98DdkRkXb2Q1rcWsF3vYMURGwbviCaQAdpZ1mHrt9Ipgx7Ym1A==
X-Received: by 2002:a05:6a00:1914:b0:68f:f38d:f76c with SMTP id y20-20020a056a00191400b0068ff38df76cmr24404026pfi.6.1701357607117;
        Thu, 30 Nov 2023 07:20:07 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:06 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/8] riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
Date:   Thu, 30 Nov 2023 16:19:27 +0100
Message-Id: <20231130151932.729708-4-emil.renner.berthing@canonical.com>
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

From: Emil Renner Berthing <kernel@esmil.dk>

The StarFive JH7100 SoC has non-coherent device DMAs, so mark the
soc bus as such.

Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Cache%20Coherence%20V1.0.pdf
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index a40a8544b860..7c1009428c1f 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -144,6 +144,7 @@ soc {
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-noncoherent;
 		ranges;
 
 		clint: clint@2000000 {
-- 
2.40.1

