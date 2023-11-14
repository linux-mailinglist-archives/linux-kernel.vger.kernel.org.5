Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331207EB834
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjKNVI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:08:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56003BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:08:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cb615c6fbso37006051cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699996094; x=1700600894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=ahUIQNrsWoqMCq7/jcJZF9gjodt+KWVgu7oTQbdahh0Zwj7k+F2areaVmEaaJJpLF1
         94iQKu7HXxFbzApzkdQZrUIg1d26269iM9VQ1hHwU8EtCxEqxd0knnpE1AhgU2iOqAnZ
         rbHpf6VkhLAVN68m6sINttmmVcl7vPhpbch3Y53WFfFylt+YKI2YA2ij1+UMia38/vDZ
         WRYku4O9zA5BpwPXSKnUq4v/p7dG+FYcA/zwUmDY575/ZUIj+9Dz3fF5oe3HEgK6AXOJ
         H1Fe0xJpinmADLTC2deSO9eV0deBnaX7/zaAcxKGKgHKafwYYCMXBdgNImvSFMjolEcm
         8bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996094; x=1700600894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnDZGk512Fn6FcfRLVRqtgZTjSOOBJwTCzWACAW0uhY=;
        b=hfKHSx9FwQ7Igmvg6eBcUwjuunCq46rrXcoN8Ssar2c5O3M1qxmfweltFtPQOlNtEj
         YDznOOcFWXVbUEwwZjoyyJVRHmM3ES8oOcN8+mfwoBvvcFlCBY5oUpdkA+OoNguJuQLJ
         WbK0f7wkAMrt7V8Yw6ioacMYRQXHNHYikMBHbxKqCicRy3Wq1QWgNq8O8v7cl1NSDMX+
         AfTDF7aJgWCtJ6R+R7Yvl5hHbgTNiplSL/FycLTcjAYI6cgobNfNUOAKCSL2CVmeC+EQ
         5hsKBIvqf4hBC7OmgchCeM3Vc3JgB4P3EkPlB6OvSTu1J/g3Y/N+Jo2uPpcWuLOp98Nm
         TquA==
X-Gm-Message-State: AOJu0Yz6CsqrhP8HiUS2tlAlpEGB2CT9dVsyPF5JYqfFE6Fi3uU8NALy
        R2J498AFyUxG10VAlBOB1ro7QQ==
X-Google-Smtp-Source: AGHT+IEK7PlZMYuHkL/R+IsthoAOwkSQLBiE4nLJ04BntKaKYMZ7Xfo/U9ypzSKpZtZk+0pj5KANYA==
X-Received: by 2002:ac8:5788:0:b0:40d:7ffd:fc61 with SMTP id v8-20020ac85788000000b0040d7ffdfc61mr3671284qta.23.1699996094414;
        Tue, 14 Nov 2023 13:08:14 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id x16-20020ac85390000000b004198d026be6sm3027549qtp.35.2023.11.14.13.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:08:13 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 14 Nov 2023 16:08:01 -0500
Subject: [PATCH v6 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-th1520-mmc-v6-7-3273c661a571@baylibre.com>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
In-Reply-To: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699996086; l=1102;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vZkA/Rp2zWEJvsAGA/badfpHmHgx6/3DqqLzYe2IxQc=;
 b=SjwF4UAXo6/VukqMwwjVNk1Bt2VTO2cQgXt/3XczOxw6M01DzJI5nFGgAMrBI3p5LGZYyeYHw
 ul3WhjbXZvaBlQ2tkLlrJa4Fs/mjbBvjVO7YJ8LK+2Qn7S2r0S0TXtz
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

