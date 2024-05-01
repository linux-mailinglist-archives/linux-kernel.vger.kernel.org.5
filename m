Return-Path: <linux-kernel+bounces-165079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A28B877F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E38B21A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B83537F8;
	Wed,  1 May 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqSciS4x"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65D50A68
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555182; cv=none; b=T+AD+s93DFbReI/mRR0DZ3Y81Ah9XJvq6X8v8k3CV3QM4I6DJ94tpoKpopL+2MwarNdnBeAX8oNNiim8WGBo3IsFeqLsS99oyiQ+ZcRQFg13B6qh6F04WYejlMospu/YR0wC+En+YWiUtTyHdsnudgYMhkNFbWc2tHex73DEA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555182; c=relaxed/simple;
	bh=ryuqc6oFolF+KkY34cM/2A0yhpjNhpTDdyt9IWz0L/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nhy3qB5OiHFrL0YNS7JKncUe9FfmXwlXV6Jar3XlwpEgUUkspNYhPaaoZgFkmk/b0YWmNxpQrDvBCPVaSPGyAhD58km5ZmupC6Ao+irCjDHKH+LJndxEuYYwSMK5WjCrFGvzuAR/J5EE+CzZh/rcodoIpUJFU8t+AKprSfs/HQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqSciS4x; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a587831809eso786682766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714555179; x=1715159979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6CBz7V/gypGkWRZPuHFUjAJNpEsLzvmA3Y5G6jT7g8=;
        b=oqSciS4xQggqgyfk1oI+/Ne1XcxyujKR+N1bE0jq95P9sc2CORzBQOkqCSb5viAQPS
         Wr9P9szRpOBO2HjPVW9Z+tCxTJ3JCqKO7vRPPlgcGcW1+2b1g1HfjVEl+ZXzrxhgZbBP
         WErCnU5Vdz3AHOvbepnNxYU+RkOvDMMH7QgNhqHvc2fSlOG6SwVTV3CUMvOO7u1p2HkX
         3gxru7v8OzHZanm7zodOx0IhE++BZnn00hH2EhmGqeFLFo0fL+DSDCbJmAfWr4Vc/CA8
         Naa3WdD82xkYNsF1VT8Irz7ZwtuogvSEK6CoBUvvNyhEzma8ndt0SqW0K6ah1wh0x/fN
         9GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555179; x=1715159979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6CBz7V/gypGkWRZPuHFUjAJNpEsLzvmA3Y5G6jT7g8=;
        b=T2rdI+MLowuwIe2+L33CTeMoS6BYXOTQIKkW9mouGTSTSr8sPExydB5ur3JvbUDToo
         kxVIanMF9GhNAMKQEnbcpNmjecClEHVadKO4pDPZ57V1lqhRWc4fcJdpAT50GHYadw5K
         d4AIMqHdQ+Vc95/rvOYjyS97Ar8dwK3qOmI4Yq89DNBWRR00hIJJc7Q5l0sz9E0QeRuR
         cy1WsCrWq2lg0KU4OAPBCZAsRw7Bkt7L/WMYJD/A255ohES0h/0h+PbgTWv6KuWZs4dh
         vqSeBVwGQ1l36S0tgXA4uvWetXjdNqTp3FHFrtuUWtpreYxIttSxYpew5JyWyg5B8TGh
         NaUw==
X-Forwarded-Encrypted: i=1; AJvYcCXqXLVKXtX32zCSFNWnP22dmgckbmbfcRbCSRksoZvgwtOY7Se7iR5zOEHM6qsXSpXxxggvZvypAP4S1fr+EZWDHhzlMGM+ZplN7LYa
X-Gm-Message-State: AOJu0Yz3PyyPRzZ/fT8BsxLRv6u+AEqYJ0tk3Y1g1YIgoEsLxqr/kLW4
	JIVW65jmcbmDZpQruxtVhm5enlCi1hOngcXQlJt12aYl7PouAoWMpF71LVjoTbg=
X-Google-Smtp-Source: AGHT+IFCRlncLt7jDHy2teEatFl+ETJXuXLGPGbi7dqaTrvE39vqxK8MXbqrb1bOCIrsv3JqEaptYw==
X-Received: by 2002:a17:906:95b:b0:a58:e569:1242 with SMTP id j27-20020a170906095b00b00a58e5691242mr1306584ejd.4.1714555179313;
        Wed, 01 May 2024 02:19:39 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id bw13-20020a170906c1cd00b00a58de09fd92sm5425674ejb.27.2024.05.01.02.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:19:38 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 01 May 2024 10:19:39 +0100
Subject: [PATCH v2 4/7] phy: exynos5-usbdrd: set ref clk freq in
 exynos850_usbdrd_utmi_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-usb-phy-gs101-v2-4-ed9f14a1bd6d@linaro.org>
References: <20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org>
In-Reply-To: <20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, lee@kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

While commit 255ec3879dd4 ("phy: exynos5-usbdrd: Add 26MHz ref clk
support") correctly states that CLKRSTCTRL[7:5] doesn't need to be set
on modern Exynos platforms, SSPPLLCTL[2:0] should be programmed with
the frequency of the reference clock for the USB2.0 phy.

Do so.

Fixes: 691525074db9 ("phy: exynos5-usbdrd: Add Exynos850 support")
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Feel free to drop the Fixes: if you think that is unwarranted here.

v2: add missing bitfield.h include (seems this is implied on some
    platforms, but not on others)
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index d69187c22613..4f30ced439b9 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -8,6 +8,7 @@
  * Author: Vivek Gautam <gautam.vivek@samsung.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -155,6 +156,9 @@
 #define CLKRST_PORT_RST				BIT(1)
 #define CLKRST_PHY_SW_RST			BIT(3)
 
+#define EXYNOS850_DRD_SSPPLLCTL			0x30
+#define SSPPLLCTL_FSEL				GENMASK(2, 0)
+
 #define EXYNOS850_DRD_UTMI			0x50
 #define UTMI_FORCE_SLEEP			BIT(0)
 #define UTMI_FORCE_SUSPEND			BIT(1)
@@ -788,6 +792,31 @@ static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 	reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
 	writel(reg, regs_base + EXYNOS850_DRD_HSP);
 
+	reg = readl(regs_base + EXYNOS850_DRD_SSPPLLCTL);
+	reg &= ~SSPPLLCTL_FSEL;
+	switch (phy_drd->extrefclk) {
+	case EXYNOS5_FSEL_50MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
+		break;
+	case EXYNOS5_FSEL_26MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 6);
+		break;
+	case EXYNOS5_FSEL_24MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 2);
+		break;
+	case EXYNOS5_FSEL_20MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 1);
+		break;
+	case EXYNOS5_FSEL_19MHZ2:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 0);
+		break;
+	default:
+		dev_warn(phy_drd->dev, "unsupported ref clk: %#.2x\n",
+			 phy_drd->extrefclk);
+		break;
+	}
+	writel(reg, regs_base + EXYNOS850_DRD_SSPPLLCTL);
+
 	/* Power up PHY analog blocks */
 	reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
 	reg &= ~HSP_TEST_SIDDQ;

-- 
2.45.0.rc0.197.gbae5840b3b-goog


