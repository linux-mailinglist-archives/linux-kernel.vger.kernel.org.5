Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F87F331A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjKUQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjKUQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:04:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF5126;
        Tue, 21 Nov 2023 08:04:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so69575781fa.0;
        Tue, 21 Nov 2023 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700582684; x=1701187484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ3d2ANI8NDUtqghMVJuMiZ8m+3a9HU7G6lTKGK0UKo=;
        b=MZVWmREBOS1QVMi6BBVklGoA0oEMFnQsczrHxx29O8RbnxzScZo1UA2f1pghdFedNh
         ZbXUNREwiw5Ozt9drMzQFbftdTgnF23TQnomZxjsSMZnDTn35hO2G0khcm7ZbDXWn4a0
         ZmgvwoAOM4VeKylpvJIIVmcEU9WH932sgxf9rCkybLnElF04xDjb5FRD4AoizJsoDVlc
         2RFIg2Q3ygsw11lLEu3VEhm+ORsW22RdV0x9aNHKfgtTeSa03fr2gvpodC6sWNOmQHph
         fAjKAO7hVmOEQ94t4pLlC3ZmlxLdYPhQQmpM+JPa/Al88E3U+zm9d7Qq4CKHRSdDTyga
         hSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582684; x=1701187484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ3d2ANI8NDUtqghMVJuMiZ8m+3a9HU7G6lTKGK0UKo=;
        b=FF95n3rEX22Nfhbd5czRGRzUdFTN0HvDVTe6YU91afeyZ8JpjTBHRlzLQx90Acgau2
         OIq+XAgvp4eAlvFTQH84w78USgF88/doZDJCeglzo0exQcW23UtZXxakfWJhtqTv6BDE
         IWyWjNJbNkZW8O6vB+/TulC73nckhO1ieqaS9ZdjAKDpTBrb1EfpaHMPQ7fDgbHGSkKS
         j9vI46sHqJmKvN2rMd5wCg0yuwgDCjkluL6HHmMcg9RyuQalkZFoiLJX4yQUuUrio+iq
         uz8WvlhYsNwrVzCXi6M9q2fa6N+k8qQBxpOsYkbpmRT2eXXB5kbZEi8xfjbt++qalq9t
         agVQ==
X-Gm-Message-State: AOJu0YyaHAx/OnipIKl4XQLdWwTjJ19CV5o5bfHp4qScJrDKVedef6gV
        Sr0WUm7LqDx/GOmNQCnGoxSFYdhDiwY0zA==
X-Google-Smtp-Source: AGHT+IHUv/PoN5clrABjdI1uGFmGETEFm7rLSANNnHvv9YiQLYZ4rBFRS0ALLN/lYjovrWbYPQSuog==
X-Received: by 2002:a05:651c:10af:b0:2c5:6d8:8dfc with SMTP id k15-20020a05651c10af00b002c506d88dfcmr6991998ljn.13.1700582683745;
        Tue, 21 Nov 2023 08:04:43 -0800 (PST)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bcbd7000000b004064ac107cfsm17316836wmi.39.2023.11.21.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:04:43 -0800 (PST)
From:   Parth Pancholi <parth105105@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1] arm64: dts: k3-am625-verdin: enable Verdin UART2
Date:   Tue, 21 Nov 2023 17:04:36 +0100
Message-Id: <20231121160436.1032364-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Pancholi <parth.pancholi@toradex.com>

Enable UART2 for AM62 based SOM's Verdin carrier boards Dahlia,
Development and Yavia.
Earlier Verdin UART2 was reserved by R5 DM firmware which can be now
configured using boardcfg during U-boot compilation in the latest TI
SDKs. In a default config, no one writes to this UART.

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>

---

 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi | 3 +--
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi    | 3 +--
 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index 013357d17d48..bf6d27e70bc4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -214,6 +214,5 @@ &verdin_gpio_keys {
 
 /* Verdin UART_2 */
 &wkup_uart0 {
-	/* FIXME: WKUP UART0 is used by DM firmware */
-	status = "reserved";
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
index 6701cb8974bb..680071688dcb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
@@ -235,6 +235,5 @@ &verdin_gpio_keys {
 
 /* Verdin UART_2 */
 &wkup_uart0 {
-	/* FIXME: WKUP UART0 is used by DM firmware */
-	status = "reserved";
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
index c685df7deaee..997dfafd27eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
@@ -207,6 +207,5 @@ &verdin_gpio_keys {
 
 /* Verdin UART_2 */
 &wkup_uart0 {
-	/* FIXME: WKUP UART0 is used by DM firmware */
-	status = "reserved";
+	status = "okay";
 };
-- 
2.34.1

