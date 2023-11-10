Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23BC7E7E54
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjKJRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjKJRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76E4EFB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:13:48 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-42135f8e08fso10527101cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596827; x=1700201627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=0DIC8LsFdN1rZXGu52P8HDBouu0cO76RLSVaW9CtcUuchjJDgfUMJFuOe6sS57kBtT
         gHIlJw5pspXjWXgZN1DZiXJb2/3gTVCHcCberXD0cenPz1pubykHttAH1DwKpbsg0DqI
         ZyrU6YrJB8x2MJdT8wDvAZcUfCfm45Cr+jToIFPTAOtq0ZVOSKuiaQv/oe5uFvsgZV9l
         b0dGCZ/fkQYvQL6O8W7yts04A/FEw+5KzT/TY39RreKWdFJY8OttKYpA6MnBaSAQaRfV
         b0QIOVtSQgQJLXZH3ehwV5nFLsSZwNTnCzGIXioisueCcMtcONR86siMQ3/4C0VsaWvR
         sG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596827; x=1700201627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=AF8YqJGFdxTHDpVApbhY+Fp7qHSk7qiUPvmU9ViifvNrY3yIQLhgLQg/J5ch4hrL0y
         nMeT97XDRsUJq9bUWGuSWRusDPBOUVTMhP6v6G298o4LShWMxO9Apms6NgB3NJooMdbd
         vQQRNNZgBEpsRAa8edhRcDM5gTcOCwLmPhmvlL8qFkaLNCes/vToqWbzyChGMWa1o5GV
         gOFDfdhV8fdFRG7XZuGftAk/OfODLjxbNyIte687DRtfpyYTcBYZsOQXPAytVh/owJPh
         vjKzLYa+zh5i78G7xDtxgCuAS0ZahJX8lhcMU9UIYOgWeXwh3AUSmbnyqpjz1mqQ331C
         fLFw==
X-Gm-Message-State: AOJu0YzJ6l6oaaA8aSH4AiZdxi6HtckyE7ONnnvJrynTU6aLdFJzWJjQ
        +JAOfNceTU+dJKY3VnBWWvTu30cF+mwLuR/L/gylUQ==
X-Google-Smtp-Source: AGHT+IGTTsahV81/Rw5QlsTpUJVxQ1PAILctgM4NyU6BPo77WHSOVHAuWPMQfe9MkO/AQRFIKwQmIA==
X-Received: by 2002:a17:902:cf01:b0:1c9:d8b6:e7ad with SMTP id i1-20020a170902cf0100b001c9d8b6e7admr11068018plg.56.1699594958186;
        Thu, 09 Nov 2023 21:42:38 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:37 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 09 Nov 2023 21:41:17 -0800
Subject: [PATCH v5 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-7-018bd039cf17@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=1102;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vZkA/Rp2zWEJvsAGA/badfpHmHgx6/3DqqLzYe2IxQc=;
 b=fJaLj8Us7PpYhDPHDt2gAJV0CgQsotNJKZ73gVndaddpreipV21Pv9bXilRM3ODn6eiDa/Ubk
 h7kJ2SCtnDZD8g4t2P9LyI/wn5hmo7COmgWYmsLyqjWJR3zX5ICneL5
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc0 properties for the eMMC device and add mmc1 properties for
the microSD slot. Set the frequency for the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index a802ab110429..94f1741435a5 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -29,6 +29,10 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -36,3 +40,19 @@ &uart_sclk {
 &dmac0 {
 	status = "okay";
 };
+
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

-- 
2.34.1

