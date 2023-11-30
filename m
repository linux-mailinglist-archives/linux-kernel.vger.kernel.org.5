Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62D7FE66A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjK3BtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbjK3BtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:49:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02151A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfc34b6890so4396655ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701308957; x=1701913757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k59bvv7KTPcWcR0nU2285Ag1/kbZ0ckoH5XbjyM+11I=;
        b=dGvaFk2qt8YVjdutA21Vg7xDf3blmg80KWoZK8M61s74CgtEmM7l7UBjuSmpkwleV6
         P02YzLIeMNc4C4VwPQBluwSmM4EzkHPPCKXPIUeRs09m8jK+XGqebPB79hhgNkd6fICj
         MC5X2TZD2KYHRU8p9UgpjmpEZnnLN6IbTA9namEYnorYVQZXe4VeNO4hIElaPGNhGiAz
         SZBdoVPNytTSTOUUltjV45cWbGT1CJ87H1Ibz8JNEUL9k+NyYFVsGuY5fzW9M9MbkUP1
         MwPvYj5URVoA3ySAwPUKlMSyXkUrAQ0cYoQzJUbPrGnHy2JwVxDh3sU1hizNPspf6BDG
         p+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308957; x=1701913757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k59bvv7KTPcWcR0nU2285Ag1/kbZ0ckoH5XbjyM+11I=;
        b=xLrrmwqT0yiiOWVq2vwIMdVtu7DwfGrkTZhVybqn2gX3j4ZiKwa6g3FJCkJ8atZNgf
         bCnV/8DMcH8DTmiAPXXCh5zNY9X/+v16TdVs3ptU9JxCbZ9wcmxGcNEp6dMaJr+Lq/0Z
         vBsoXdhVeJr7eW2UzgGbMFDDJWFCrYM1OQb76hU2ceuUn0UCRPBVjRm3i3lpqBhZAwth
         rVhgUE+YXRY/4DqOlc/l9CZ9UmSYFV4bi1Rcb+TWDV9Q4bMO20Or4bGA6Rxk6j67zsq7
         AzbDowNl0Pf5XSVmZlgZ0BcH74Juw1+dSVQ7eorMK4DgbX69EsA4byFpWJG+a0JpeU60
         DIQA==
X-Gm-Message-State: AOJu0YzPpjZxMq7GKmBagGQYnQZtv9CE+CJ005NfvVpX/TqmyzgRLvjI
        rc6ZkC9criqmIFhuysrVIP9yvg==
X-Google-Smtp-Source: AGHT+IFWN+veB1Lo+5WzY9Hv9vg6vdys4LdvUiI0HD+zQd1G2l7aZznMEfaQzC7XjS8ZH8qOxGjBdA==
X-Received: by 2002:a17:902:c18b:b0:1cf:b2a9:fc00 with SMTP id d11-20020a170902c18b00b001cfb2a9fc00mr21521734pld.9.1701308957476;
        Wed, 29 Nov 2023 17:49:17 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:9707:1e8c:3166:6a23])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001d00b0bd306sm24455plb.251.2023.11.29.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:49:17 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 29 Nov 2023 17:48:50 -0800
Subject: [PATCH v7 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-th1520_mmc_dts-v7-4-c77fc19caa6f@baylibre.com>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
In-Reply-To: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701308949; l=1102;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=FNhPhUUvWwP+QKoj7n3Ul287CfcC/2teVzVQAZNIlgs=;
 b=dAFvB72xQtzNxvN94yqiVLj81s4pJ66+wqg02OfxeOO3TUhR9uDJUuRgzoq7/QDFIVK5ppXps
 jq6MzKvmTLKB6BxP95jRZ/iuxxpATqAnJ5doFXEx2wvG5WjZ8euLRfO
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index a802ab110429..0818bd3c1f84 100644
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
+	bus-width = <4>;
+	max-frequency = <198000000>;
+	status = "okay";
+};

-- 
2.34.1

