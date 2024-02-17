Return-Path: <linux-kernel+bounces-69783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E900858E84
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DCE1F22229
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254E1DFD0;
	Sat, 17 Feb 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fxHMZSJZ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C241C69F;
	Sat, 17 Feb 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164141; cv=none; b=QJ6oIVGgA53oAcpKGS6VoqiNtC+KLwRApe4CRln6qJO0/LqhWEJvtb+eaLx+PJKQ4NdbrBIBdYUK3IiCYtsl9l07kDYI9OJ0BtvOFS7PRoGC918oceV0jT6X+y8hTy8BXw76ujEeGVfCDV1+MKywbDBjCble/G7t+ZQ164MtFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164141; c=relaxed/simple;
	bh=USFCdbHyoE8FKG3GAqIj7/95rop2cgT/ZVVdnVi+iQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UReHqVt3LBbZWNAhlhj/wPlyD+v3m/4mtiTCvtzF+Tpp3tudXAylndgF9v3jOeE5kxytDXp9pb/pa+cBEU2eoOy0Tb+k3cDOdXE5M4y8hLqa0PUaSHvejP1JLA1kbYm6sv7XA846std0U8OSyZBQ0bhJjnH+2ZmbezC/TTOBaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fxHMZSJZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3de25186fbso164053166b.0;
        Sat, 17 Feb 2024 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708164134; x=1708768934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZM66OWGdF6SbtT/QLY8tKqxblTioRIXbDjnM5RGQoM=;
        b=fxHMZSJZugBa6NBkOjCCOBIlcIKcfLmcPPjlHm43IvKp0NHKKEahswCttp7CZOWwbQ
         B4SQgZhDl7lGkihp7MsAuGwUR1EreMgctd9CcRi/3PucY5X+ncCVzOhqnUKsVQ+0wlz6
         EV8SLle20BvJNn640Qw7B0avj3/d/SpNM8HMCkvuUM9UBuTs67gGfFznGOCmvaS/W0DA
         AgbrKeatPJEmmr+/GJACkS+bx2BQj840rtxU7JDPDiu5TLI24kJ0o4SzUajZXLeqyBYz
         +uLWwOO1WeF9IyVrCiamup1i2YFkaGoCGy7GmkDo5EFM3qUqgvlkPpUxMoScOCNNUMZB
         JihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164134; x=1708768934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZM66OWGdF6SbtT/QLY8tKqxblTioRIXbDjnM5RGQoM=;
        b=DMWpjMym3hkLL3gHfRNBHgtzIwZAQ84eV+H7e9WLFtPVKB6jeg9YF2WUxlWMXRUnE2
         fy6dDA3ltpNkrU2kwouVHYALmbWYMvgSHI8q4aSgs9eb/iJMRlO0/ETgjit3geIYG82w
         nvU0fwkRX1KeERdNb5KD1Wmc0FQm5hyZPWeTHEArkTr01tmRZLoCwDhdYr6onLWatH8w
         RsK7lPp4VInsJ92v0fHM8lyYtkGzPeT6uDFMZrN+Qvo/7R+6IcgnkdAhWZP6cxI6CgcJ
         jrmffDZ2whptTGFnWQQZUpgsIp1ZL1285ot0SL9iqFxWfwojLGa9C5xGXMnZqmNmmptv
         5oBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3mpjX1pCs+GaQ/YyukTXcYGhXfr5yh6C1LHkz+20OlSyjMoj31JQ7qJww/BSzcTn7FIFBFXEnJhwg/NpGnbRpvqG2eNKdxcMawp3vQKJX1oYKGHUI61cJ7eT7XVMuvUsP5PCZzPVy
X-Gm-Message-State: AOJu0Yxd94DLg9i1bRkImkdLfsSi+YYYH2TlpKm++jsT0HGZm4dnrV3j
	pwdZChmdkPd7QVMwDVsK5pM461iBX4gAlG0m163wFXmPIa3ww8oT0Em1f74b
X-Google-Smtp-Source: AGHT+IH8aFNkKOjHk2QaX+mE3vWKGtqusxEFTd96jtkQJfQEqeUCvx3ptfcS86lAFFLwTWbc4nxtwA==
X-Received: by 2002:a17:906:abce:b0:a3e:13f3:e1ab with SMTP id kq14-20020a170906abce00b00a3e13f3e1abmr890687ejb.3.1708164133432;
        Sat, 17 Feb 2024 02:02:13 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c18b-3d00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c18b:3d00::e63])
        by smtp.googlemail.com with ESMTPSA id vu2-20020a170907a64200b00a3d2e690abfsm832444ejc.122.2024.02.17.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 02:02:13 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/2] mmc: meson-mx-sdhc: Use devm_clk_hw_get_clk() for clock retrieval
Date: Sat, 17 Feb 2024 11:01:59 +0100
Message-ID: <20240217100200.1494980-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
References: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devm_clk_hw_get_clk() has been available for a while we can
resolve an older TODO where this API did not exist yet. No functional
changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc-clkc.c | 43 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
index 19200b7079a6..cbd17a596cd2 100644
--- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
@@ -71,12 +71,23 @@ static int meson_mx_sdhc_clk_hw_register(struct device *dev,
 static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
 					      const char *name_suffix,
 					      struct clk_hw *parent,
-					      struct clk_hw *hw)
+					      struct clk_hw *hw,
+					      struct clk_bulk_data *clk_bulk_data,
+					      u8 bulk_index)
 {
 	struct clk_parent_data parent_data = { .hw = parent };
+	int ret;
+
+	ret = meson_mx_sdhc_clk_hw_register(dev, name_suffix, &parent_data, 1,
+					    &clk_gate_ops, hw);
+	if (ret)
+		return ret;
+
+	clk_bulk_data[bulk_index].clk = devm_clk_hw_get_clk(dev, hw, name_suffix);
+	if (IS_ERR(clk_bulk_data[bulk_index].clk))
+		return PTR_ERR(clk_bulk_data[bulk_index].clk);
 
-	return meson_mx_sdhc_clk_hw_register(dev, name_suffix, &parent_data, 1,
-					     &clk_gate_ops, hw);
+	return 0;
 }
 
 int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
@@ -115,7 +126,8 @@ int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
 	clkc_data->mod_clk_en.bit_idx = 15;
 	ret = meson_mx_sdhc_gate_clk_hw_register(dev, "mod_clk_on",
 						 &clkc_data->div.hw,
-						 &clkc_data->mod_clk_en.hw);
+						 &clkc_data->mod_clk_en.hw,
+						 clk_bulk_data, 0);
 	if (ret)
 		return ret;
 
@@ -123,7 +135,8 @@ int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
 	clkc_data->tx_clk_en.bit_idx = 14;
 	ret = meson_mx_sdhc_gate_clk_hw_register(dev, "tx_clk_on",
 						 &clkc_data->div.hw,
-						 &clkc_data->tx_clk_en.hw);
+						 &clkc_data->tx_clk_en.hw,
+						 clk_bulk_data, 1);
 	if (ret)
 		return ret;
 
@@ -131,7 +144,8 @@ int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
 	clkc_data->rx_clk_en.bit_idx = 13;
 	ret = meson_mx_sdhc_gate_clk_hw_register(dev, "rx_clk_on",
 						 &clkc_data->div.hw,
-						 &clkc_data->rx_clk_en.hw);
+						 &clkc_data->rx_clk_en.hw,
+						 clk_bulk_data, 2);
 	if (ret)
 		return ret;
 
@@ -139,18 +153,7 @@ int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
 	clkc_data->sd_clk_en.bit_idx = 12;
 	ret = meson_mx_sdhc_gate_clk_hw_register(dev, "sd_clk_on",
 						 &clkc_data->div.hw,
-						 &clkc_data->sd_clk_en.hw);
-	if (ret)
-		return ret;
-
-	/*
-	 * TODO: Replace clk_hw.clk with devm_clk_hw_get_clk() once that is
-	 * available.
-	 */
-	clk_bulk_data[0].clk = clkc_data->mod_clk_en.hw.clk;
-	clk_bulk_data[1].clk = clkc_data->sd_clk_en.hw.clk;
-	clk_bulk_data[2].clk = clkc_data->tx_clk_en.hw.clk;
-	clk_bulk_data[3].clk = clkc_data->rx_clk_en.hw.clk;
-
-	return 0;
+						 &clkc_data->sd_clk_en.hw,
+						 clk_bulk_data, 3);
+	return ret;
 }
-- 
2.43.2


