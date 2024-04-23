Return-Path: <linux-kernel+bounces-155719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4312D8AF622
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D07B261A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B654213E051;
	Tue, 23 Apr 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yevd2CPI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB6143896;
	Tue, 23 Apr 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895172; cv=none; b=I6ylAz92rc3pEIRx7zspGhwUPuAeC0Shk0jLrW5Bors76Fo43PBGm58yXA39baNXemhp5SdJ5PsDYVtBSnplNha8TM/6h5YO81pqITVWsTIr75vDqj8sTMAB4x1q34ddt0GC2P0Y/XfQECz95tdZdFkK6BdmDSGlKR3btzC5lOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895172; c=relaxed/simple;
	bh=nVmJXiH4yHIp2+Ic2OWQVS6oMl9V+PTyUf/HbTVGFkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdiL9q0MN5GpFNk9X64Nl0ZiiRHH8CHgIzSTWnIECevlngr+Sms618Td664UzIT8jhqdU5hstwG25iFOUyRWbLfO/T1VPMLksfwOGLE+uda3GT2/WfGCvFu36v3kYGlN70MiVTaY7sZyeeVimW3aFGe64/v9ItqU4iUv5zrE6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yevd2CPI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-417e327773cso562565e9.1;
        Tue, 23 Apr 2024 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895169; x=1714499969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C4Ech5rHYG7C4jDh6HOejAsVKSBZX+m5gTsiDcVD3Y=;
        b=Yevd2CPItOPY5+nTJBvC4sxWssrf2LjSxu6pM6EaxQkf6HeknUogwxP8JuFv0Pctq/
         ulfaEJOf2viVE0DXtxscKC4w+M+MBOtpt+/i80f5gQHpBysQR9K9un2bBBP2IQJEK1zM
         s5WgxPM1ah+ob9wY68rOA/cNpGJmbA2PhzypQGaEuULFpPBgg5vjLX4AXDfFsxUT/cp0
         FGnuk6qZIdZpPdzr6W3tN8WU+EQMTCR3eyG43XaIMUcVGzNFvxeMaRWUuVAtsTFuXppg
         MIuS8VXr4uU8WrDiZ9FFNEGZJ95MupmLvo08hULQyVHZAF2GFtYBD8TWbvd1L/RTtP9Q
         QK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895169; x=1714499969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7C4Ech5rHYG7C4jDh6HOejAsVKSBZX+m5gTsiDcVD3Y=;
        b=nobnmWG+FJALsohXfvOPVEP27CEUe0aKRieZyPsjnXnboEVKJh+YwG2SNINdtUPbJ/
         r0fhaosNUMdpqKBAyuoslUjQ41Y1qoe4lLLVJ2NlnpcFY9g69wfEEhTobDqwjzOP0/8Y
         Em4UqFpaVUuoKSqtNpuvUSHWJh3C7XxuMenAjPXQONMa2dKGlFtszrqwaLl/AnZ2tQFR
         Njz16J5LZ3icM6PNQ0dQ4poyqwqE2G9aiBA3F7yUP00jUy3c2fWnFXmwob1ru3XlGDgt
         FwGQRJnRgTdp5de0FMHEsMg++3xJvqo7nciF5gAx2e760Zuj7jzJm488OasdogzdZYU1
         XvNw==
X-Forwarded-Encrypted: i=1; AJvYcCWrm5BYvEM/PipTrsq1rQE/3Jgj/XZE2tct4mx+J7Ah4IpRMDtdKBk0nMkHPhNcrlNjwq/7dDvMFDgp9aBhfwYqNUV0GaIqmWVGNfVJEsCIKVqoPp0TNFgoahMSMLehZSBWqbyQFD6GepAKUJiTpKU3pg0Kv3OY4NdPbu1Ar+tCu0kRHKVmTWiV7GYB
X-Gm-Message-State: AOJu0YzshoVxDaiP2SUIqXqh22xfzp830beX0uTMlYJd88sM9ji/e2/l
	e6FfI3HJM2m+Md4tGpoH9HYlaav3/JMB+USl1UfC8Qp5aqVsL6uz
X-Google-Smtp-Source: AGHT+IEGFdfJlVa7IglglfByhIZh80xohHWIw8NfwmUi/AJxPTZaMQZmN5w5KSLIzcahuZ+J1Q4EIw==
X-Received: by 2002:a05:600c:35d3:b0:418:3ea8:46c0 with SMTP id r19-20020a05600c35d300b004183ea846c0mr2310079wmq.13.1713895169011;
        Tue, 23 Apr 2024 10:59:29 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:28 -0700 (PDT)
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
Subject: [PATCH v2 12/13] pinctrl: renesas: pinctrl-rzg2l: Add support for custom parameters
Date: Tue, 23 Apr 2024 18:58:59 +0100
Message-Id: <20240423175900.702640-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

In preparation for passing custom params for RZ/V2H(P) SoC assign the
custom params that is being passed via struct rzg2l_pinctrl_data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f3c5e8982623..7e3ed18e0745 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -262,6 +262,9 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	unsigned int num_custom_params;
+	const struct pinconf_generic_params *custom_params;
+	const struct pin_config_item *custom_conf_items;
 	void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
 	void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
@@ -2374,6 +2377,13 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
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


