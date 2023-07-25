Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC62760488
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGYBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGYBAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:00:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8B1700
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3510536a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690246849; x=1690851649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll0Z6sPfoNlYpMsjwTyfIvK2krIfZa7HiWUCwQnkPdA=;
        b=Qu+lOJSyR4OxlZZGUVqXiRX+LDk5oh9uv+g4FjzcapO3UEOndSDi8uoP6AxzAt/ZO4
         AnPiggOfo+Jl5RcIG6rVXHL88EDLcI00pdFfoaY/Eyyr324sIbdNaxsKTCgCRLcjY+12
         n3xOi+AaqVDjPL0tlC0crgKrr/QEZa7VTXtt7S9SEFoDpRyK9LTewNotXjx9i1EXyMVc
         A2K/NMAUjhM1tWw7P4iBY8fdfQebIk9f1MgGceUiwoWnWtnnA6kNj7x7cRHvX/uJGFVx
         JusGpwjhrPq4RjJpng4h7XkiaKHWXWTjm38FPi8G/RpJMC6u2cNen18Mp+I3DCTxweyn
         3onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690246849; x=1690851649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll0Z6sPfoNlYpMsjwTyfIvK2krIfZa7HiWUCwQnkPdA=;
        b=HkykP9iGMnGhFkSpse/4WSQFNMGvVDp6/OQT8h4UROUfsnjORZq2F1/HnKejFTP1/r
         m+e/2k191MiBenPyA0nqD1pvkafndPMpqBhl7xjpvA6LB4T0kVOG53TSlze//kJop4F3
         Rad3qM/2B8y/s8bfFSiYN++SfyJvZPDPrfJhiVkzgOtwKcDNlAmYeNKAKaQ+SReKiqgl
         0jFgHLNkfUi8Nbxl8gYF7j3p9Lz7YAVnOlIHBas3eXD691Q9zVHMrNs9deEpphBqPRv8
         h5HQIaTXa2sVreb3rTC6MJThYqu2CSOB9KEYkvtHftB6dqPO0xRJ+cW8Fh3miLMmFzUU
         /AHA==
X-Gm-Message-State: ABy/qLbIfV+gMKMzXv+glshhlx243v31cSjLDbUm/3qL5Kk8Zzac+6Hh
        HHbzxw9kAzLEBzQxyX4arePuOQ==
X-Google-Smtp-Source: APBJJlEJfbDJNH608pWUheZz5f97FYPk5RB/uAh2UtiLf7o4tdIdOe44w9xO37Xlj4wo9DuSj9jq8A==
X-Received: by 2002:a05:6a20:12d3:b0:12f:bc36:4c67 with SMTP id v19-20020a056a2012d300b0012fbc364c67mr15897632pzg.61.1690246848782;
        Mon, 24 Jul 2023 18:00:48 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b00682a75a50e3sm8576900pfn.17.2023.07.24.18.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:00:48 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 24 Jul 2023 17:59:17 -0700
Subject: [PATCH RFC 3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v1-3-cca1b2533da2@baylibre.com>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690246840; l=933;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vzPbiAqekRJrMwxZ/WMGUL3NDV27jNZgpcUxGuUx06o=;
 b=mnelfhkyum4sqvxQ4+7or/rnFxuZiOWaKusz28UsOyv+ffJpB1LIb1d/3yMhoePbv89hmvonH
 cSBi299EoneDiFg4Z7DO4In9ih5HiOMUBSPxPdlO+rJCS0RH4MHJTJX
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

Add properties to the emmc node and enable it and set the frequency for
the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index c315e5bd3d2d..140f5d5c8c97 100644
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
@@ -59,3 +63,13 @@ &dmac0 {
 &uart0 {
 	status = "okay";
 };
+
+&mmc0 {
+	max-frequency = <198000000>;
+	non-removable;
+	mmc-hs400-1_8v;
+	no-sdio;
+	no-sd;
+	bus-width = <8>;
+	status = "okay";
+};

-- 
2.34.1

