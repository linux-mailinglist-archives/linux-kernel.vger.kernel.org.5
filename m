Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088237CCE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbjJQUp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbjJQUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:45:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8C187
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso3599715b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575533; x=1698180333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNiz/16GiKwF18nTvqrbS8bwq2F/L9RlRg7oWtEwZWs=;
        b=IpKs7/swJqbXipEND0s1Z2aY/uAQELev+WpcjVNxhzdu01NfYOqwAr58VNRVHhWm6y
         waY+z7DhfC4cV1aWpjN/RI+MmMD57fOgXKtem8rAX1lPWsUHqPwJdx6HeXJpjBhMFSKf
         H7+N23XeB7+XjwgQLaywxIIdlO13P59j/D4bTDSezMmdiEw5BKWQelPsChZSomvBxU/B
         PVdn8JfqSMpYfRQ4/cfv9FR+rYFkiupw24LHfRrRJ5hAsjJ8Dxaks+kiqdLO8LeRkrkl
         mYPC7ITcm2t5VCri/BfFkEFn8RQPA/4miD6rbhBgvHGECNactqT3C61aOkNGE9YcPaoU
         4elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575533; x=1698180333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNiz/16GiKwF18nTvqrbS8bwq2F/L9RlRg7oWtEwZWs=;
        b=fUZLSArEzqNyorsqowvjw3jS/CkeZPeteSmgwjpuSptONLCQ6GlMOe1RsmQAD3gWXF
         VOLJDtn/9KBdlgbwIXz1/ztIVa223RE+85kvaahwaXl5EWoKSUDan1nzWM5mUZOeULE9
         cRsP13SopSwxV+WwxZrSzGCRKJfhnjRk8mEi73oln4pjTIDs54B4z2LVd5V6YMccEPEc
         8a+2mLf4cBGxAKe7IhM7ybHa86Z6l2PHp4PM+yY5381dB6c5ompJj6yJVUZhVTkRGCtQ
         LjjdYXUR5wwhbhHyG7MCRUk4vd3fZNYA6aVd6mQp9P9r+YaPSUcYjxuWIeX9EY1JInbY
         qSSg==
X-Gm-Message-State: AOJu0Yw7eKjUEZeT+Zgu25yejk5V4doJsHndUcz88nWhZUyAVUSryzc5
        4tOvBK2XQPleWY80nRwX+6bPIQ==
X-Google-Smtp-Source: AGHT+IEnhSQy2mXL6KTfLBhYz1ApnwfXeWRnJ9dLuptY6RRHFhHrPL3MUgmW3VKl54Wgp6BUsyffSQ==
X-Received: by 2002:a05:6a20:7351:b0:14c:910d:972d with SMTP id v17-20020a056a20735100b0014c910d972dmr3485455pzc.12.1697575533216;
        Tue, 17 Oct 2023 13:45:33 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:33 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:53 -0700
Subject: [PATCH v2 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-7-4678c8cc4048@baylibre.com>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=972;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=fP0X7H2ev/K5EsIr1ajuR3Wl40rAHHxMMZR5DlF6EQU=;
 b=zzNGRi480ZBM5jq5QFMXYG/fMcO+yA74L+HUirBBNxAziVp61WiOPvolxmJJ3FfkTdUEllXn1
 T0Hl+mS034yATbcHCEq3lYgVdwBJXjkOiBymPsItzNlzSLVMYbyYY/L
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
 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index a802ab110429..bc8f111571bc 100644
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
@@ -36,3 +40,13 @@ &uart_sclk {
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

-- 
2.34.1

