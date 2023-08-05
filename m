Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A98770D7A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHEDPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHEDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:15:21 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912BB4EF4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:15:17 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56c4457c82eso1841495eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205317; x=1691810117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdRLfV4DSjo6NuAp3G0Z9YBsmLluT1U9pYT+QCm2Ogw=;
        b=Sirb95geXOpdF+w/pVzPoQoiCURDTSuciOvn/xUei5K3StbbKfG9M9SWWEJA6J8KXW
         2Pdu8HvmQP+5V+NXfwzERYjQ7of36NJWN65NM7hwyB1fdGhyXt2V2nzzPNo7sc3dKOUj
         H9ETNR/cjSxuMB4y9dkfqhV84Ch1c7BEnDmaWD0I8kXJ/r6kvINdyrx1D97Aw7kLMlok
         1FBUpcFV0j54uWg0DwZpQAeAU2kgJnCz+3GeIEKCC6l4QckkNfOvi/klhWAZ5/Z+UpGz
         RQG+9MdYLIa289mgJtDhKk1PhXLXDpk7FaRD9y0QS2xEhxi0Ee2vHnOVwB15DQyy7ZSu
         l9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205317; x=1691810117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdRLfV4DSjo6NuAp3G0Z9YBsmLluT1U9pYT+QCm2Ogw=;
        b=MYiWBTfvcjhCV7BCG/1V39yrwiCNc+cMdYZ476GZE62bcA0osKB29eSdvdBq/D8fgi
         g6esPlcp8Hgx89g6GYBBp+1EeXAVkbt9CMz4nrCjHwC0xl8w2CiO74QjfIVkbE0KRIhm
         C6uiuhtnEX9CfaWduUW7VPc7U0Z411cks44fYKipvyahDd5z4SxckAREBAxpEkdX3Br2
         V2eE71m15exgVdTruhQG4IMMQBMKKYQjbhLFIy6ecodsuD6DZahIfYMjo6WieDNEHfg+
         CIu5HuXGEIudnB5+iy5d3OkJIinZ/gd5rLZ+X7QMLjWGD9wj9mf8PCNAHdw7jkfMLjGs
         51vA==
X-Gm-Message-State: AOJu0Yz1qNtKT0TRnhgH0iI/LUjpnZvH29bEaT8Ep7NOjBhk6kfZBk6E
        XA3195GwvAQ9Ws47J+Uymic+uQ==
X-Google-Smtp-Source: AGHT+IHzW5Dh9evbuaAvm6UO7LWse/VuKTkLwUY6Eyif2RtvDcFf9wUdYu+dWABgQoDwdkeE2gAtHw==
X-Received: by 2002:a05:6358:5284:b0:134:c682:213f with SMTP id g4-20020a056358528400b00134c682213fmr3883804rwa.31.1691205316886;
        Fri, 04 Aug 2023 20:15:16 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:16 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 04 Aug 2023 20:14:47 -0700
Subject: [PATCH RFC v2 3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v2-3-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=980;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=fq1uqgjhziV70k9ct30okgNDov04CSkcqVTv+e1VQgM=;
 b=xot9eapxH2cUSYpXQoibI8Z4Ff4UD4GK5A3fDmYWMiila2+9XbnG2Rse6zZNWn3UKb70c0va1
 AiqYKQdIC4iBvQL1X269HN0jdo6Y/rlkz5B+PqnyS6gCAcsFHaH9S3n
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties to the emmc node and enable it and set the frequency for
the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index c315e5bd3d2d..f93c11754639 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -52,6 +52,10 @@ &uart_sclk {
 	clock-frequency = <100000000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &dmac0 {
 	status = "okay";
 };
@@ -59,3 +63,16 @@ &dmac0 {
 &uart0 {
 	status = "okay";
 };
+
+&mmc0 {
+	max-frequency = <198000000>;
+	non-removable;
+	mmc-hs400-1_8v;
+	thead,io-fixed-1v8;
+	no-sdio;
+	no-sd;
+	thead,pull-up;
+	bus-width = <8>;
+	status = "okay";
+
+};

-- 
2.34.1

