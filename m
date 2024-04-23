Return-Path: <linux-kernel+bounces-155716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9F28AF615
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BDE28E2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78021143866;
	Tue, 23 Apr 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyBn5+Gw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C78142E60;
	Tue, 23 Apr 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895168; cv=none; b=DbeeG/DBrldGlLu4DFP7iE6qs/VwHRoRY4Dlpg+xuWw6X5gbtzOBVUpiOKYE3rAQG9q6J5uGXxbCnOoEN495lvl9x6h11Vv4t18yIvU6VHNtu8Ux6y0z3PCUp1VYNaLNbOGCGt8nCriRl2zyNPONa/IwDdSCJUFNJolZmu0J6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895168; c=relaxed/simple;
	bh=f24p978oNHO9WNN1fLZRjrPDQ/Q+S2HAOUSw7IOAnqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9kTz0MYMfZly1u7DhIfssi28qm4itInEalYZQDPnNbXy3Ed2GuALbLiMA5vEf6RC00bdB51zxwR3s+o4gGEqppTk7QYFnbZm9EIWD8BqoEHywoltrE84D0YotwGn5fm+5q/kxsl9MqYm8ip2a70uZyPOtMuUos8WjkvMeLNZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyBn5+Gw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso710025e9.0;
        Tue, 23 Apr 2024 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895164; x=1714499964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+3snCKEJ2UBE0awN9fjDpUa5Hdg4iDF9w8kRU1NdWE=;
        b=FyBn5+Gw8LjK84/SoYiflPQ6sD4CBUiBlhgkkchkqv2XUtH8TSXbvWcHFAoq9odWCL
         Q7kpNYNx5GMUpRN4cdVSdrrEQ+aOj3MH/1vfZo4v/GKiOHhkSyQIBVIb8kPZbDUxIrca
         vbdVb4aZ4Hw1k1X1bVTYdu420jEIPzRXRr1G8xlU88ULRP9iniEyccGTyd3BawtjY+7X
         /+g8W+0H9rZdTW4/dhTQUlplmD6ErSCpqJwhS/GkhDbjZEAUJvYPST8fDmPmzxIYhMtP
         EtK8E/oIGWGAfUiWbhUzkQ5ES5UEHblGZxR5LuyeYmrj7DhUiirYitW1RwG+hCDyEcSS
         e3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895164; x=1714499964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+3snCKEJ2UBE0awN9fjDpUa5Hdg4iDF9w8kRU1NdWE=;
        b=LXNz01xe+GxQstw+0P3PWTTscq4RLkPQo1LMjs+yv16a091mfIGEMiO7WsWXjpGhIf
         uQsKWyK38qTlUOrNd0DZB8C3wR0qx3PZtxW0Aa0s1u8OICucVfUmZ+95jWWoXPlMcOLc
         mwh5LM2cWusjFItUpjSoQMf0XLZyr6eBOFsSWpK+8irT5RsZHGs/mf8sIBVh3J7VBt9J
         O+H/3d3cIdPholdW6H7j7EhWLTFayPLmGP1K2mGgJOOstmQaupjRszKyYOt90m0IXY/j
         9NjuSFE6XVApggJC/irvfZgjjIEt9teUJAgq3wOExl8MDy/4l1BzKerTKcJ5P5Ufvpwf
         oYSA==
X-Forwarded-Encrypted: i=1; AJvYcCWlbxKGngr3yj6eU3M9AJFvjTpziwLkoHKRR7YRHIbiWcJQ9o9fuC+ikFsc9zhggCealQmWj93GJZOdq0kwe5HFCs9+0K9XxUL2vm1+MZFjP9FYjY5z93jQrMwG3OxstzybSBKGSeKmEDoGyVDBq1Oj3ovezqW5H/Hj1P40gBrKDJmdezbeNYEsAGF8
X-Gm-Message-State: AOJu0YwnJEU1zIKWzagkejwqvofg/bB+apeAptO5FysxruMeofqVdEYv
	NfuqQXeCQiKAJrKwVW2qKDBBg/CWgeq/v5lFrU30WaIN+xPwQTz8yHDF/m6m
X-Google-Smtp-Source: AGHT+IETX+4LqtaiWCVcDsJ2omJUnSkV1Gc7bvlSYodEKPuAWO5pk5+/bXscFzNSKU1DkzYahLhn3w==
X-Received: by 2002:a05:600c:1c18:b0:418:f770:30e2 with SMTP id j24-20020a05600c1c1800b00418f77030e2mr2549939wms.1.1713895164433;
        Tue, 23 Apr 2024 10:59:24 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:23 -0700 (PDT)
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
Subject: [PATCH v2 08/13] pinctrl: renesas: pinctrl-rzg2l: Add function pointers for reading/writing OEN register
Date: Tue, 23 Apr 2024 18:58:55 +0100
Message-Id: <20240423175900.702640-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch introduces function pointers, read_oen() and write_oen(), in the
struct rzg2l_pinctrl_data to facilitate reading and writing to the PFC_OEN
register. On the RZ/V2H(P) SoC, unlocking the PWPR.REGWE_B bit before
writing to the PFC_OEN register is necessary, and the PFC_OEN register has
more bits compared to the RZ/G2L family. To handle these differences
between RZ/G2L and RZ/V2H(P) and to reuse the existing code for RZ/V2H(P),
these function pointers are introduced.

Additionally, this patch populates these function pointers with appropriate
data for existing SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index e6d986b84be6..64648a951323 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -261,6 +261,8 @@ struct rzg2l_pinctrl_data {
 	void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
 	void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
+	u32 (*read_oen)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin);
+	int (*write_oen)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen);
 };
 
 /**
@@ -1116,7 +1118,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		arg = rzg2l_read_oen(pctrl, cfg, _pin, bit);
+		arg = pctrl->data->read_oen(pctrl, cfg, _pin, bit);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -1225,7 +1227,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg = pinconf_to_config_argument(_configs[i]);
-			ret = rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
+			ret = pctrl->data->write_oen(pctrl, cfg, _pin, bit, !!arg);
 			if (ret)
 				return ret;
 			break;
@@ -2708,6 +2710,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
 	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.read_oen = &rzg2l_read_oen,
+	.write_oen = &rzg2l_write_oen,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -2722,6 +2726,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
 	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.read_oen = &rzg2l_read_oen,
+	.write_oen = &rzg2l_write_oen,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2735,6 +2741,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
 	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.read_oen = &rzg2l_read_oen,
+	.write_oen = &rzg2l_write_oen,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


