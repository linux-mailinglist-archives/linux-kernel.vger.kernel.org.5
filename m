Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD7806927
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377092AbjLFIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376985AbjLFIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:09:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35AD40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:09:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d04dba2781so33662685ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701850188; x=1702454988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbmBzwUY0t2HlseySntw7VHVz6E41O0M8Fv31kHjYNc=;
        b=AmJuUcLkWISoPb9Ub3rTvwrFo06LqJv/fiaG0r5RccEDamWmsaE8rbJMdoqrbvFFNN
         JqdQADf3Us66K72O8ExEGxW/LO8OjFnAFXFFbOfdCATvgUMEJ2TrQK25UPP8XFfjvOVQ
         4I3k3pq6zByftdrUDAkm4RtzZaA1IaPWxkBDS9IlxtF2x7K5hR24F4xmmupD75bReMe1
         /T+YYlknsmyedERNkpn0LKnDxdf7VTZtNTjaG3H0ZE5ONnyzsBZXzUjphmSuRofmr/JV
         QAZm0jaMlvc0RcWXlc8CkXBwnlOKoFj1e/ktSC9350i4m4XcgmCp37L9Uh7GSz8EIvXw
         tW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850188; x=1702454988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbmBzwUY0t2HlseySntw7VHVz6E41O0M8Fv31kHjYNc=;
        b=O1mRa1yrBylmFuUi7GWwTwmFupZh2kkcH+08PRvS/GEorOtbpUa3EhGm4AJqDSwaDy
         a0rXQOIpS+x8TdgVrpA8p2qecILrHSZqot/epbeb3RlppvVPCdeAxVQIU4mCxoSmbeop
         PLEp0UgBH6jvVgeiA+GUtklxGBbfvf74pGPYYyOZn+W4udIxgBLlIhrShQwKZy8b2sgn
         bL4ZkMI1pBwMe0L2YH4PajQ7FSjoBVzr8krNvQ26KLiW5IlQhz37WNJuWq8EdWOMn6Vu
         5A0ZDeNtA/n+IYMdOuEzuKbLNJvKL/QtqZrj6k/l2QZkHOZfQt93vLk9b1l6gbn3fxcm
         +YCg==
X-Gm-Message-State: AOJu0YzpRFCyhXkM2sYxYuedjINeRUybWXhRCLOq2ujvdx7mfl5aHa7Q
        Xc1qZoCXxWEMwHHM2hPjTcoTuw==
X-Google-Smtp-Source: AGHT+IG+IVNu440mrvRBStKIEhon2ZDqZu9o/4ngZUUVarpEskLvBTGXAYNAbp4uL1sBhOVHpCI+pQ==
X-Received: by 2002:a17:903:555:b0:1d0:6ffe:1e85 with SMTP id jo21-20020a170903055500b001d06ffe1e85mr298277plb.104.1701850188352;
        Wed, 06 Dec 2023 00:09:48 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:92e9:8fb4:700:680])
        by smtp.gmail.com with ESMTPSA id bd11-20020a170902830b00b001d0d312bc2asm1208668plb.193.2023.12.06.00.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:09:48 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 06 Dec 2023 00:09:23 -0800
Subject: [PATCH v8 3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-th1520_mmc_dts-v8-3-69220e373e8f@baylibre.com>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701850181; l=1131;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=hHAbb4qtRlHdob9grY86/6CrB93uiLQSe6D5Pf4bJ6w=;
 b=a3RjXkzF5S6RuHE5jVRda77tdw9TE8uVsvTL+GIZkd2GPapFmSTRl6NNWqrVwaVtoNrubatFW
 CldudAcR7JPAYR6Lyqy0D8NDNk3WsZOzEwuNW+fxyDBbe6NCHsQ8Z6Q
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add emmc node properties for the eMMC device and add sdio0 node
properties for the microSD slot. Set the frequency for the sdhci
reference clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 70e8042c8304..d9b4de9e4757 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -48,6 +48,10 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -56,6 +60,22 @@ &dmac0 {
 	status = "okay";
 };
 
+&emmc {
+	bus-width = <8>;
+	max-frequency = <198000000>;
+	mmc-hs400-1_8v;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&sdio0 {
+	bus-width = <4>;
+	max-frequency = <198000000>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.34.1

