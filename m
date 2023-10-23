Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D774D7D4177
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJWVH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjJWVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:07:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6C10DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:07:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so2895243b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698095238; x=1698700038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRsbR8cyJBJLQiljQwh8xETHPQGsjMsxLgd7DL4I86c=;
        b=iYbHwpW/IAvXQxL2U9dARVIxbVE/wnIpay9aFisX4+IxW7yRcX2GsTrJrqfR4EfYBe
         aKhIjSc45VEs/BGX/Q/iVQ9zh/8E+RDnpbMeWCo55/v/+RIJEj06Uqhqb8jjqPniFU4Q
         qHgFbEMQAzYcQjSr0MKz202Pl/0CDzZNpVZB1Oo3dTjVYKqp0Gg5qn9+M+PR+zfTVa/7
         hIftK0/7Yg2cLCbFU8G51usknEQch9fhpdNQu3xYjubQkS28wSjYq73KE+EsdwouSPiK
         BGyU12LhWrQWUk/JWGfX8hb+IGPKJJ5b29VQD7p8B0+FWhupVhIjQ3FLajOixSKE+9Do
         j7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095238; x=1698700038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRsbR8cyJBJLQiljQwh8xETHPQGsjMsxLgd7DL4I86c=;
        b=rhqdNsyHNITSsLk7pwiPbXZx4fg9TQTVGyJb+6jyHxIPWabc8BBLUBphq9b2jIhq7d
         6GUIUpmVmWtGlCjeJVQto07736D/t1hJvbaLc6OCRs62o7b1+ZGIoJbolkKinHOmCxeP
         ClwymrXi5hIfUs3QD4EQZGgYEfUE+Ybq0dXDAXEvZfzYvI9kGUe97CYQbQlU9IFGEszD
         dIn4STZmpGYbs9g9eBS7fxXj3cMFmyTO4fRvDPVF/ChjW+cc3tWxMuT9MCmh2Wbo/+Uc
         npXBjeyxOHLCCloTuimE4giHqjU7PLS7IPPjBJZJDvJQLhs56SDgl3AN3CuAOgXgjK7l
         KxSw==
X-Gm-Message-State: AOJu0YzSN7AWvQK1gQGjBsezGcY9thgRA2mueybyfxWH1y2nSElAtS7J
        S7iUZ41eJpm3r80X8s+wpQgj4Q==
X-Google-Smtp-Source: AGHT+IEcm7Zc5+MK/lCTTfkNi5jhtUVjUnBE3Ln3l7QAceSfeitd0U6qE3f3EKflACoeh8fywVD2hA==
X-Received: by 2002:a05:6a21:7747:b0:17b:1071:36cc with SMTP id bc7-20020a056a21774700b0017b107136ccmr674297pzc.53.1698095238361;
        Mon, 23 Oct 2023 14:07:18 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b9a0:8714:407c:4146])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm6573066pfp.47.2023.10.23.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:07:18 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 23 Oct 2023 14:07:07 -0700
Subject: [PATCH v3 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-th1520-mmc-v3-6-abc5e7491166@baylibre.com>
References: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
In-Reply-To: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698095224; l=1065;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=ivnAVa4ydzuGy1tIrb6+8N9xlA3xHNWc5N0iKEqGJGs=;
 b=fSe4EYk9ihygXLrUGGGojwk2oDvxB27qsTIAtBQVzytAxI/BhiUgb2rFV4KVB0yQxgBPjOgnG
 waAl7MfGzViCUge3ZosjMnnvAfeTZKgm5HLiqY35OghByzWM/d0dUys
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 70e8042c8304..c4e748827889 100644
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
@@ -59,3 +63,19 @@ &dmac0 {
 &uart0 {
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

