Return-Path: <linux-kernel+bounces-155717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2558AF619
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC9928E6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966E0143899;
	Tue, 23 Apr 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsODWg13"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422B142E77;
	Tue, 23 Apr 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895169; cv=none; b=OMb9WZpKp/1wXkCNrdHy5kIW746OhU9/qGw8P970hAJPOvsfGmYp3jYa+twPaAHXXTSsrt4FmzNMg2uuAUWN2paQl963ST35sLRiwQp9/hdgnenAHFsjBpp2kkiajLc05WofHy1lCNeJBUP2X8Em5PNj+WYeeMHvliOWahCoXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895169; c=relaxed/simple;
	bh=HcbsyG+Tvga8urvYrCDOXy5hy5ESWVMOxCwdjcLP2bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbJep38NoiOur1TltQYWdBnSJla4YZeqsqQx8vg+jr0C9L2ftlb5odlFLRnmo2NHbKRDh8Y6NGfO0UhzQtQMnMIEBRGHXonrHnrYn9dVkTC9qtrJRo1Rk4jxz7t/WgPXoZIVp+jk/5w8/v4HdQCH3PeXnLE10c9uUREaX6gqnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsODWg13; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso20336915e9.0;
        Tue, 23 Apr 2024 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895166; x=1714499966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjO/zSIrfOCV8FlsmQ6h2ESV4mTTgyPIjLpSsgo714E=;
        b=lsODWg13N+pP3Tm8y17rPS4ig6EpH33cN+Vf1fWkSn/9qC0TIOlkKT3VTpBKAFYHqY
         uuYMZ35jymWbUvg2L0EwhDV2U0x1dajfY26pwEQcZ9fHclaMVpSVnoHexIfJrpFXubWs
         jQjtthF3vkTgjAKwP2Ixl5A5UJgH65xH917T29BfGrWayJH0LeyRuqqcdwNaN1CZbh+W
         YZNOUlnDCCm2zP8jPhXmVnOpL5QlsPAjxlSUxtgVncsuUD404d3Fbk2b0Fi3g0pwjWH7
         GS+GKPc/qL6qoMuINpOS5Lgoev+G9+4g77tQwaVbViJs+P5jCk+b4B2eYtdQrpm59p21
         uaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895166; x=1714499966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjO/zSIrfOCV8FlsmQ6h2ESV4mTTgyPIjLpSsgo714E=;
        b=HiHtByHy3YhrA7CRbuj9obvyrBSI3WJxZiKrqoCDZZuukzjLnTeRFOZBS2bfFpDT0T
         uTw9bx5aibHFC9B1G+hNNiy5EhBgi3m+P3ImCxIyCVQy6rDu0QTL21d5Q3HB9sPhDFQV
         HtqAFSXwMUCQ8Icf6wIyyVxzH4m78NtaavgEZV0uacNwV7MoauWGujnpki9h4t/w8vqo
         pTLfLNRasVorgrmhhRQBeZf5FmKeZs+qB3FKiMHjCi0IOGIRlPXqNrvGQ59g6Rm7DwRW
         qqBAbxdIXfJB696yLo24RFxDWa1Xe6I0LJ0q3cZFncd6vJNxm1qXMO+KXgvE6nNniVkR
         iLpw==
X-Forwarded-Encrypted: i=1; AJvYcCVAG7+hsq3JzDGqupoYxZcAbaMPs3QMad9HqPkn4XCvKBhXYrQUeRtCKRO2gJvc7tEk2TFrRao5QQTgOW3tfb+AyWw4B7Y6R1mGO5qHmL8pesHl1mnwJDdX8lu+128sK3xmrye7xCXRexXniqQLsHZJN6kYGjGPbYJcAhWocs/RQoNAkrv3g42OyTvC
X-Gm-Message-State: AOJu0YxULLpVM6cwauYGvOQSv9/RbanM5/tpQvtZpIl3DjJNQBl3QVXN
	Jq0YJ7x5LojrSRj8MaRl3JXRP2ntbASWLI1GTQdKiMlmoUlWMeYd
X-Google-Smtp-Source: AGHT+IGQMns8H4G/rcVSdlfEuvP8vWD5ItDQGUbTdN9MT5cc1VBP0gNAhrZQzcNVz5mXTseeoutPLg==
X-Received: by 2002:a05:600c:3108:b0:41a:ac28:1fc8 with SMTP id g8-20020a05600c310800b0041aac281fc8mr6347wmo.33.1713895166435;
        Tue, 23 Apr 2024 10:59:26 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:25 -0700 (PDT)
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
Subject: [PATCH v2 10/13] pinctrl: renesas: pinctrl-rzg2l: Add support to set pulling up/down the pins
Date: Tue, 23 Apr 2024 18:58:57 +0100
Message-Id: <20240423175900.702640-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add support to configure bias-disable, bias-pull-up and bias-pull-down
properties of the pin.

Two new function pointers get_bias_param() and get_bias_val() are
introduced as the values in PUPD register differ when compared to
RZ/G2L family and RZ/V2H(P) SoC,

Value | RZ/G2L        | RZ/V2H
---------------------------------
00b:  | Bias Disabled | Pull up/down disabled
01b:  | Pull-up       | Pull up/down disabled
10b:  | Pull-down     | Pull-down
11b:  | Prohibited    | Pull-up

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- New patch
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 102fa75c71d3..c144bf43522b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -122,6 +122,7 @@
 #define IOLH(off)		(0x1000 + (off) * 8)
 #define SR(off)			(0x1400 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
+#define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
@@ -140,6 +141,7 @@
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
+#define PUPD_MASK		0x03
 
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -265,6 +267,8 @@ struct rzg2l_pinctrl_data {
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
 	u32 (*read_oen)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin);
 	int (*write_oen)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen);
+	int (*get_bias_param)(u8 val);
+	int (*get_bias_val)(enum pin_config_param param);
 };
 
 /**
@@ -1081,6 +1085,38 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8
 	return 0;
 }
 
+static int rzg2l_get_bias_param(u8 val)
+{
+	switch (val) {
+	case 0:
+		return PIN_CONFIG_BIAS_DISABLE;
+	case 1:
+		return PIN_CONFIG_BIAS_PULL_UP;
+	case 2:
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int rzg2l_get_bias_val(enum pin_config_param param)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		return 0;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return 1;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return 2;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -1139,6 +1175,25 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		arg = rzg2l_read_pin_config(pctrl, SR(off), bit, SR_MASK);
 		break;
 
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN: {
+		if (!(cfg & PIN_CFG_PUPD))
+			return -EINVAL;
+
+		ret = pctrl->data->get_bias_param(rzg2l_read_pin_config(pctrl,
+									PUPD(off),
+									bit, PUPD_MASK));
+		if (ret < 0)
+			return ret;
+
+		if (ret != param)
+			return -EINVAL;
+		/* for PIN_CONFIG_BIAS_PULL_UP/DOWN when enabled we just return 1 */
+		arg = 1;
+		break;
+	}
+
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
 
@@ -1254,6 +1309,20 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, SR(off), bit, SR_MASK, arg);
 			break;
 
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN: {
+			if (!(cfg & PIN_CFG_PUPD))
+				return -EINVAL;
+
+			ret = pctrl->data->get_bias_val(param);
+			if (ret < 0)
+				return ret;
+
+			rzg2l_rmw_pin_config(pctrl, PUPD(off), bit, PUPD_MASK, ret);
+			break;
+		}
+
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg = pinconf_to_config_argument(_configs[i]);
 
@@ -2746,6 +2815,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.pmc_writeb = &rzg2l_pmc_writeb,
 	.read_oen = &rzg2l_read_oen,
 	.write_oen = &rzg2l_write_oen,
+	.get_bias_param = &rzg2l_get_bias_param,
+	.get_bias_val = &rzg2l_get_bias_val,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2761,6 +2832,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.pmc_writeb = &rzg2l_pmc_writeb,
 	.read_oen = &rzg2l_read_oen,
 	.write_oen = &rzg2l_write_oen,
+	.get_bias_param = &rzg2l_get_bias_param,
+	.get_bias_val = &rzg2l_get_bias_val,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


