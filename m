Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF927E83F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjKJUhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbjKJUgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:36:44 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938C57D9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:47:27 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2ea7cc821so945653b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699598847; x=1700203647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSa6NAVY2VMgd1nmwOwphCO64qKVXCiZUmGbVj1XUeM=;
        b=s3E3TkDuqj2OdjQQYasaqQYg1RzcTSfH9CP3aQPrjqgcn1vaQv+jV2C96i8j4wbGou
         aEkK8NKnkc9meXPuVOYBfYTJtRRZmXmDxYwjc/dewK/voGNYlX1IJ1bpWmIdk5Np+5CL
         qkD8zmhLpi3Qy7lRxx7X60GwrMC2DTlKuW0zSKSAvmr/9YXphC7LTx8tqASyEz+78Rrl
         76HcpNwaHkhrMrOGa8OZHKS6J7WmwcghZnFGHkYYGBkPGnNI8gez4naX7VquIJwb5x7q
         aAgJ9y5KBmxiW57M1x5LfDw6Kdf0uXGguOXqFrmET15EtHRTIHDQLfGSK4C7+J1l2efC
         M83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598847; x=1700203647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSa6NAVY2VMgd1nmwOwphCO64qKVXCiZUmGbVj1XUeM=;
        b=f0KaM7EJjCktQ4xBpmBxBrmZkqYKj/4Qeca1KoMHr3EyZERLZejfRTtg6pAk9T/ltv
         U323AFp0CRODABhO7cevyPNCL49++W6Mh0inY4Gl2v29yUHBPZngg8o23CcFhHiGMlgx
         gAzHIwT0sGpj0dSlEnzBGFF/n3s/UCkV+HtTkV8t2gwIPI9G8wtf74WM7PU1CBcaFvMx
         lnUztutK6idzKJ5yP3pnYn4LJlzL2UBOv5GZgX5zP5nU7SOIqQOalgZz95rsdohGZeS1
         iqwHozssz5i1wyPepfv3FFCM2qj8OHf4MFjg2tbuSNaVE05hK6KnU/9WfpR3VeOhKxGJ
         fjnA==
X-Gm-Message-State: AOJu0Yzg/t/wMGl6MV/WU9VmAqqth9PsgVwhc7mmlDvVzw+ONVQsrn9D
        lLbjLJZRtihpBEIaheL8RWBWoO9ieCogqGL8hwhFDw==
X-Google-Smtp-Source: AGHT+IHc2dzth6LKzC6h7TBn2/SL7V+OAEY7bksLZRGZnVrvIoOC/yuSFZMolHtPmyTWRt1rlElQlA==
X-Received: by 2002:a9d:7a83:0:b0:6c4:897a:31d0 with SMTP id l3-20020a9d7a83000000b006c4897a31d0mr7519725otn.24.1699594956388;
        Thu, 09 Nov 2023 21:42:36 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:36 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 09 Nov 2023 21:41:16 -0800
Subject: [PATCH v5 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-6-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=1108;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=4bgo3aK3cuR26cRWBbMVA6MrvhUqOJ8As8gzvmDCzhs=;
 b=lALKEKj8Qm8uCPZT94ZeDZCapEMna2PJb7qYfmxdtsiIiPu5ZBsq1ZTsCjmwM7LQeHswhFuMT
 bUj9CkooLlrCm59R+vpdz5OfJa2nhKLJZ6dvleve4V8ZDgXFGGMNDkz
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

Add mmc0 properties for the eMMC device and add mmc1 properties for
the microSD slot. Set the frequency for the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 70e8042c8304..f91d94f95510 100644
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
 
+&mmc0 {
+	bus-width = <8>;
+	max-frequency = <198000000>;
+	mmc-hs400-1_8v;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <198000000>;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.34.1

