Return-Path: <linux-kernel+bounces-120056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63C88D0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79A41F26040
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F311411FB;
	Tue, 26 Mar 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz3eHuq7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193F13FD95;
	Tue, 26 Mar 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492216; cv=none; b=YLw/qfJEqpxteb7PWDlInyfTmmQBetynZK1ZRhEjG4Ga1hdFLbM8hji0NYLGmvPj3s6Ws1ijjIuHhXM+e5sB8TRtbNob81WDiz37FxUYigTmA8WdXehzdBsoFLDRfWH79eGr8bKWnoHPb5tvjApSj2IVvNqrPaJxM06OgZHqEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492216; c=relaxed/simple;
	bh=n4Q+rAJxdl0L0vlun3nV+RMJS1ynmTK2ySSf1lNNzPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzyUhqvBnIdIIXokQUxEMtO5MeT5sDzydAyvqlchLSclqKNBOkWr/c57LK3jil/l/RlEUvTYnK0ygGQlx0jlEshMTEXjzQhOLf64QRJlTX53FKD8S08uemM/suSjnsY8SR9EFa6eFI0jiOjfCeyEIxsrb6nV2a/1Do3lYL7dkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz3eHuq7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso156822f8f.0;
        Tue, 26 Mar 2024 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492213; x=1712097013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSLnzc4A97kNjNoMOdC35aW8lG2J1TDCsRnvXQtRKDw=;
        b=Qz3eHuq7uJcWgHKp6PCMMNqTZnJedJnZQLRNLufTClv0J2u4vaUgH4nqbC+5+14xjW
         WqhZemS6hBMKXAz+UJ4SzXCznY2xPtar45sexLMV1wwndJAqfPIOKQWFeWNAKYqdsiA0
         NVhdJduYlAvbX0QODCyGS+sqZ/E9Bzn10jqovxPsDeStXZSPd15gvvyUf/e6PLEjVUla
         LohLeZj22Njvycyi/MBTi9gWzTyvgI+jDgUfwyad3eelEFRfH7gZcJtJhhrhwk9zvz9l
         ZcpgYnl/6x1kVcyfUjn0dkiczyJQUc5p2FxBnUqeRlqTJJNOXojQHERTbXYaYHDEkZt1
         4Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492213; x=1712097013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSLnzc4A97kNjNoMOdC35aW8lG2J1TDCsRnvXQtRKDw=;
        b=qlShSehx1l5Swjh5VySGULavRK14fmYWkMPDr4qIZUp0iXPtbdzSmlFcXBnJnqo009
         oJyJjOR1LbvgNiIZMtvb5QPGISxUx6MERFpkmKWCTu2BDzEdVgmEX6THdspj/0lKvjVm
         Q2ncV7KYWuQ+AgIg5+0fw/gorhA5Lnq9Wp3G59qdvOEY21EeHfT1Y+Dj8pdYCND7wCsi
         yTW7KCufvLBgYGYFu+U+ZpaFik+bNtqanc2Nl4t9MymGPELTz78jN2zD4KXnjBsykFqe
         3kEUsjqSRKf7a3AFFvQ2dCOfX84481bN9bsD6H3vxcoRdNRRUWamIneU2GrwJjc26xcb
         1Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCVL970M3W1h6puxDQKgoUQZz8AjZyM84m88hwxl9KzM0j3QCf2C6KWxkefG93RBM7ivF9qHfyh7PattU1aXseLSyMz9lPIAFW48/uS2nE8nXM4FsDIVtDVgEqURUosBJ39Q7zRriD8o/Cqy7rbUepFtszM1JBbXyNKatkkKMV1H5Qb7SWA=
X-Gm-Message-State: AOJu0Yw/61R+w2vPKdWHwepBglxoR0cSJPRtnIFGT8lp0ySM4nVvTXfp
	pDlBcsCqAVwtJ9pQ5qszPVWTd/HbJNPWc8Iu+6WTsTVPIU0Amo5f
X-Google-Smtp-Source: AGHT+IG6TIFa95hfm5ChJDL88OhPCN8Jp40y+qh+csWO8ZlPV31k/sWIZOWbQ1RnTVqRtdkTOs2tvQ==
X-Received: by 2002:a5d:6d04:0:b0:341:c473:2919 with SMTP id e4-20020a5d6d04000000b00341c4732919mr3238048wrq.14.1711492213427;
        Tue, 26 Mar 2024 15:30:13 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:12 -0700 (PDT)
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
Subject: [RFC PATCH 12/13] pinctrl: renesas: pinctrl-rzg2l: Add support to pass custom params
Date: Tue, 26 Mar 2024 22:28:43 +0000
Message-Id: <20240326222844.1422948-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

In prepration for passing custom params for RZ/V2H(P) SoC assign the
custom params that is being passed of struct rzg2l_pinctrl_data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index d64a441b4f55..6f0c85bb97a8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -258,6 +258,9 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	unsigned int num_custom_params;
+	const struct pinconf_generic_params *custom_params;
+	const struct pin_config_item *custom_conf_items;
 	void (*set_pfc_mode)(struct rzg2l_pinctrl *pctrl, u8 pin, u8 off, u8 func);
 	void (*pm_set_pfc)(struct rzg2l_pinctrl *pctrl);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
@@ -2278,6 +2281,13 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 	pctrl->desc.pmxops = &rzg2l_pinctrl_pmxops;
 	pctrl->desc.confops = &rzg2l_pinctrl_confops;
 	pctrl->desc.owner = THIS_MODULE;
+	if (pctrl->data->num_custom_params) {
+		pctrl->desc.num_custom_params = pctrl->data->num_custom_params;
+		pctrl->desc.custom_params = pctrl->data->custom_params;
+#ifdef CONFIG_DEBUG_FS
+		pctrl->desc.custom_conf_items = pctrl->data->custom_conf_items;
+#endif
+	}
 
 	pins = devm_kcalloc(pctrl->dev, pctrl->desc.npins, sizeof(*pins), GFP_KERNEL);
 	if (!pins)
-- 
2.34.1


