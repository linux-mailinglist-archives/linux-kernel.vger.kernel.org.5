Return-Path: <linux-kernel+bounces-155710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B58AF5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA3628D2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DF1411E6;
	Tue, 23 Apr 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ1iC1SK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B313E8BC;
	Tue, 23 Apr 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895162; cv=none; b=tPHHwCWWSL+WV6LNXYijh8wKUryUp4l2Lh7fijdzaasuuhK3idAqJqPtbV5XuBcS5EhWDVsHuC7lRZ5eZAIFVKU50b9TGbmXflXqF9RKFgpg7sYgJRj0TgoxgnU/KTu8kU7lW6gn8XFlXBjAnFoJ9t1WIEmnGry8iSGdMkvYotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895162; c=relaxed/simple;
	bh=TxT7RBwoDWhi9zCJJZ/QPp3h6RBM/4bgfUUVOU4Dx0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzB+aRI5Xgm7psOZkoZPW+H9vQ91Ur8vih/QhgmT7biCM7jc+wsov9xOHQAXowEIbBajF66Rblb/8YD0JGS31XO7vPFmBJc1NDdLT63nUTik+f0fvqZxXDDtwbqZ4YaC3OTLJdV0hFKPkaAfj0qyz+9Nl4PtrTUnysiZ87o2niM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ1iC1SK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a77836f16so18040495e9.3;
        Tue, 23 Apr 2024 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895159; x=1714499959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcqHIe4hShwv6KW9kzmXn1ZPos31l+yNPmyLSX2yXyo=;
        b=GJ1iC1SK3oLOV6BGU/FBColivjHGRdZvoa1sglrc2oxJxpLAQ8zRZfkv623rupHhJE
         G9J9DUX4RdC18Ugpnt9WnO/09rIqJn5RZjvaXqkMEPiuu+Y84Vulew3S/0/SmgNq2SNt
         nwrfz6vXn44cttAwx3CugUlriwaXgItfMCprVIdGDONDhjl5TX1/q/+KOZemDnBdhZ9X
         dztrKcJyTTg51LaPZ8ZfVvPMS0gMfgfFz5Bo/PLS8ypx1Wv8ZcesYH9bf0olJDE+20Go
         h2JP5Z7rT9fl85QaYSDgeM/xjm8WwyKcTIuEtnLiV2yTjHC5jaN5ufXb3fI3cDfBvgjr
         PCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895159; x=1714499959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcqHIe4hShwv6KW9kzmXn1ZPos31l+yNPmyLSX2yXyo=;
        b=OJBai6gddC5+gv63hiJ2kJRWASoMXfqJ2C1nyG0hkfBJbgAYK4NzzXn+56cc1BV+sz
         mRsvkWvdDAC6R83hZEXdQZ1EnPIexxTz+A0d7i5rL0TR6VVzSmSMeUsbTkFR7KEtOULm
         GwgM2tq1Pf6woateaoqGfL1bEg/JsB/rIKdCKmGVWimi0M8UmagJFP6mtZFejv9S+SZz
         rpqml2MOXqnhojzIrVEwra7yaB3ULxc8Wy+gBJ0oqqzL5lbCRPm3uN/iHauI6XIhBmXO
         coBgYus9f1Cc+kBOinCtt0GJuowzyFFaXM2RCy+T0W7XU+yCwEQEjdTo9fsjQAKasoYs
         zPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrp7hH8u8BDYwm57QOAorID8swYFsBbs7QF/oE7M9q72etwrd8RUghuHelQVyDNqpUu3VfH/RAm/P9w85Z2Ji2ctCHhWDNhfzXuI9/RwjrfjPqi3wUKp0EZOyoE5J+KTqsexAyd+UPFd/eYtbWl4/mcZxX+aOVNmtIKtkeC8rZxR6mr8tePBhd/16W
X-Gm-Message-State: AOJu0YwM8CCRYpBZ8GwKmVCzNpaazhaOCV840bm+9aIkea9vmkQ1Ancu
	eeRlFQ8YWRlswwgMAUWj9QD2jVqOVyP2ZurfYN9Qx2t5R02Jmqja
X-Google-Smtp-Source: AGHT+IGUrBnPwjKbWmXm9BCmzXJGdw3yllNpLRvV2ah+6Ft02VWijO4nHoPeuochHj1xB9kRTQ0U6w==
X-Received: by 2002:a05:600c:3106:b0:416:9b7f:7098 with SMTP id g6-20020a05600c310600b004169b7f7098mr10691wmo.24.1713895158773;
        Tue, 23 Apr 2024 10:59:18 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:18 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 03/13] pinctrl: renesas: pinctrl-rzg2l: Allow more bits for pin configuration
Date: Tue, 23 Apr 2024 18:58:50 +0100
Message-Id: <20240423175900.702640-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The pin configuration bits have been growing for every new SoCs being
added for the pinctrl-rzg2l driver which would mean updating the macros
every time for each new configuration. To avoid this allocate additional
bits for pin configuration by relocating the known fixed bits to the very
end of the configuration.

Also update the size of 'cfg' to 'u64' to allow more configuration bits in
the 'struct rzg2l_variable_pin_cfg'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- Merged the macros and rzg2l_variable_pin_cfg changes into single patch
- Updated types for the config changes
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 30 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index dbcf009837ef..9bb9cc63f9df 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -78,9 +78,9 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
 
-#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
-#define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
-#define PIN_CFG_MASK			GENMASK(19, 0)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
+#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
+#define PIN_CFG_MASK			GENMASK_ULL(46, 0)
 
 /*
  * m indicates the bitmap of supported pins, a is the register index
@@ -102,8 +102,8 @@
  * (b * 8) and f is the pin configuration capabilities supported.
  */
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)
-#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
-#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
+#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
+#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
 
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
@@ -241,9 +241,9 @@ struct rzg2l_dedicated_configs {
  * @pin: port pin
  */
 struct rzg2l_variable_pin_cfg {
-	u32 cfg:20;
-	u32 port:5;
-	u32 pin:3;
+	u64 cfg:46;
+	u64 port:5;
+	u64 pin:3;
 };
 
 struct rzg2l_pinctrl_data {
@@ -1082,7 +1082,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	u64 *pin_data = pin->drv_data;
 	unsigned int arg = 0;
-	u32 off, cfg;
+	u32 off;
+	u64 cfg;
 	int ret;
 	u8 bit;
 
@@ -1186,7 +1187,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	u64 *pin_data = pin->drv_data;
 	enum pin_config_param param;
 	unsigned int i, arg, index;
-	u32 cfg, off;
+	u32 off;
+	u64 cfg;
 	int ret;
 	u8 bit;
 
@@ -2414,9 +2416,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 
 	for (u32 port = 0; port < nports; port++) {
 		bool has_iolh, has_ien;
-		u32 off, caps;
+		u64 cfg, caps;
 		u8 pincnt;
-		u64 cfg;
+		u32 off;
 
 		cfg = pctrl->data->port_pin_configs[port];
 		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
@@ -2460,12 +2462,14 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, bool suspend)
 {
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->dedicated_cache;
+	u64 caps;
+	u32 i;
 
 	/*
 	 * Make sure entries in pctrl->data->n_dedicated_pins[] having the same
 	 * port offset are close together.
 	 */
-	for (u32 i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
+	for (i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
 		bool has_iolh, has_ien;
 		u32 off, next_off = 0;
 		u64 cfg, next_cfg;
-- 
2.34.1


