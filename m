Return-Path: <linux-kernel+bounces-120051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51788D0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC21B23E86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB63513F422;
	Tue, 26 Mar 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l051wszG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299313E03D;
	Tue, 26 Mar 2024 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492212; cv=none; b=fodvRPvWH9WWn2SfBjM1DNjepf1nVQk81lp9lWpqwJI4lZ+HZVYmt4hNLiOlk+Xh6Efc2i5sc8yokIz79HALUvZvskbEVsptVil9ZePTbUPeYg41rZWRuPUJXBU9VmX5BrwuIj+2C512JJ+XzrBPdSpyCgUT773GgmdVajs+HF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492212; c=relaxed/simple;
	bh=0H2ZfDNM6t107tCbGNszRTnw+5bTLOhziox96iYRPp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSmMFBS3l+06tjBOmW26LX3Wluv+omZrjddI0Tx5uCwY6J/h67ESznReMV15JwhBbNI8mbslRCZgiMsvKf16FZ6Tizn4owvNDPChKicIUInUM5TQ6gXTmUCUnfux91+yazdJmi6wtWxPns9c0KBqY/QJ9BQ3QAuGpOXDLx1LykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l051wszG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ed6078884so149120f8f.1;
        Tue, 26 Mar 2024 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492208; x=1712097008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/PlD95PTusZrY9bo1CqW5ZAjeK4ledYfN/qKGSQZW4=;
        b=l051wszGUI7eT+a/SHSj6xNCkI99kmHoii6DsBJv2a+vDGc10v9xKOk770pCRMuJmG
         R/Dt2kXCJ2AJh6knUOmrEib98sMHRLehERcO8YjqU3t0Y2AoC43AFeAAh4ar780LRaX+
         31REGRMT4UXKlG2rnIqcJuXuvZ36V3nVggJpJkuksz6WSlU6r2fBPf7CyvjsXnrKon9w
         Gc0qEH87e6tsIZJOLqVhXyP1ywbTcC/iYFASi1NOK5vz3135n9xTNJ4N4CsVDmkUYVQb
         CtcW25dzIXI4piRcwMs9Cuu03yXLST7xBLbcqWgzrKpZF6BulaR3eASlpCOT+nTnrBjt
         E8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492208; x=1712097008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/PlD95PTusZrY9bo1CqW5ZAjeK4ledYfN/qKGSQZW4=;
        b=kkcijoKCnxcllEZnSp6CfFGn5CufuhUIGcFoMP3bgfhthxjweTOtqyOEDGhXwNR8/5
         FyIhg7dtMMxqHOUpLkoTAcMp+OhBeIRhEIXn5CocZVWszOXL0RVcSgBdOwaaOtKEuzXu
         RxiY83IrTDolO8VzbR5R7YML8fuGQKcnorSfUlswCspi38i7U8YXwrwZ/uoAXlOVZZFB
         DgWyFPTtrDffFVJX6/x8rau1FJitCmwucnlmYrtiDyWRLztGociNYuPYG7xDf0/mL6O/
         ARchLGSRw639WeHjNAdRHviqOAlS1UCNB9DYoKFYIsRl3g8NeEbKgmM4IdB7UJ5yrZ1R
         r02Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBKNQuKWqjj62kx4HbtbLnCrWdfVh6XPCQvGrLSnTFrszskuo66J29zXSgiaUACvGe/6X/zk1/hmntDcWNHLfKK7jEX3hr5llQHlSCZYs9M4TJdB+pbiwj6bxYf8pSj6G0OnuYnmOU3LdHAutUv0PmK6i7KefTXthzc8UbkjAf8Weu68M=
X-Gm-Message-State: AOJu0YxioeBv6IGR52nKG36sZ42ZNFxJhdQSinUQ8GRwC2x/331Pylo5
	kTNv6PTFyeTlh6hjweb5J63N/8Db9jKnoOZCe/1IRmiUwBLnhN/w
X-Google-Smtp-Source: AGHT+IFP1rkzrdRjJDxHgm+Xx2xHI1J5l15F1U7nMF4j6udTZsLIdM/nVw4EW8KSnBpScrjEFKaJXA==
X-Received: by 2002:adf:e68e:0:b0:341:cb34:780a with SMTP id r14-20020adfe68e000000b00341cb34780amr2063276wrm.28.1711492208604;
        Tue, 26 Mar 2024 15:30:08 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:07 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 08/13] pinctrl: renesas: pinctrl-rzg2l: Add function pointers for writing to PFC
Date: Tue, 26 Mar 2024 22:28:39 +0000
Message-Id: <20240326222844.1422948-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit controls
writing to both PFC and PMC registers. To accommodate these differences
across SoC variants, introduce set_pfc_mode() and pm_set_pfc() function
pointers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 705372faaeff..4cdebdbd8a04 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -246,6 +246,8 @@ struct rzg2l_variable_pin_cfg {
 	u32 pin:3;
 };
 
+struct rzg2l_pinctrl;
+
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u64 *port_pin_configs;
@@ -256,6 +258,8 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	void (*set_pfc_mode)(struct rzg2l_pinctrl *pctrl, u8 pin, u8 off, u8 func);
+	void (*pm_set_pfc)(struct rzg2l_pinctrl *pctrl);
 };
 
 /**
@@ -526,7 +530,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
 			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
 
-		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
+		pctrl->data->set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
 	}
 
 	return 0;
@@ -2607,7 +2611,7 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
 
-	rzg2l_pinctrl_pm_setup_pfc(pctrl);
+	pctrl->data->pm_set_pfc(pctrl);
 	rzg2l_pinctrl_pm_setup_regs(pctrl, false);
 	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, false);
 	rzg2l_gpio_irq_restore(pctrl);
@@ -2672,6 +2676,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.variable_pin_cfg = r9a07g043f_variable_pin_cfg,
 	.n_variable_pin_cfg = ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
 #endif
+	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
+	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -2683,6 +2689,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 	.hwcfg = &rzg2l_hwcfg,
+	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
+	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2693,6 +2701,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.n_port_pins = ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg3s_dedicated_pins),
 	.hwcfg = &rzg3s_hwcfg,
+	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
+	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


