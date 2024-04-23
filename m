Return-Path: <linux-kernel+bounces-155714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EC8AF60D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B541C21ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AF142E6F;
	Tue, 23 Apr 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po6waH0L"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EA1422DD;
	Tue, 23 Apr 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895166; cv=none; b=SX63KzJDvLcm7h4QIMUidPOKsB1ly6YMO8mXmqsDW49g3cJyfasY5Ai917tA/LPH3mG1lbo/TPVmM36wm2EJyfhOyb5bVbwlqoN3V0IYD5N7ANXk5JZFow5Q2H2lRhodJOunLkboB7NfDwYYkk+Qzjudod4nndufJOH8qFwK/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895166; c=relaxed/simple;
	bh=+5ygHTr71DNitGm7m0sAPaYUX1UL+ExqAUD+nwhbYlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtU8n5l5qG+1xF4dJ0BMXK0OGXAUnYZo5+0YUIvHBSe8JghqmzmPYyWXWfAWRd4kPUtLPgrjF3JpFysAkIeRdh6c/pqTP4TIFqthrI6s1iCfW4drDnwBiw1UkzOPy4luOqxZaNqjsRj87nZdhbsdXglIhHmJVDo1m5uwDozz160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po6waH0L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41aa45251eeso12277015e9.3;
        Tue, 23 Apr 2024 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895163; x=1714499963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbQ26bp2LTo8Azc9QCf3B+NBWpup/zm6dtXf/3UzkoQ=;
        b=Po6waH0LVKLufTQuccPytuuLYuMg6VluBoIm1wiZY2fdxmcZglJhxOkTvcgjPAR5Py
         +BxUAjoyes08+OZtW9d+EBzYjQww0CUEz1WlPdp1aIJxow1GSYt5Df8Q6NSLqZ2AhDTZ
         MRtk7nOiQJDNcu1CXyoJOwZd62JRM5RsHsOPLlHrzZrMkm3QT8ZBsOGn/P7GOham6mpJ
         huvHQJ+0JINg+6tFj6T/aTaNEwNSFL8huPAjAig4VZDd8SZ3FHcO4G+xwTrP32AcrxXf
         qI2NAYHBYH24tumN+JFVcHstqe8AKUccxT3tqqv677E3CFfT7EAEV+nHQvyKn9v/magb
         vnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895163; x=1714499963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbQ26bp2LTo8Azc9QCf3B+NBWpup/zm6dtXf/3UzkoQ=;
        b=i9zQOfqpRyccq6wk/XNM0006t/biy15oqTrJGFLoz2h5q2NtwX+L1VdoFxxkC2PGqm
         Ydrig8Ra64cL2x61lpaGHjhqjLgEDgrwLRJSscuDfCw0gFtVqJth0dD1rsyS+Cz61Edq
         j7TlsHWIA6n4hv+rGYbukfEHdt0NzGzYtHsEAR+GHeWMaM1jRruHnqMUNnjuCDjf/INt
         t3tx2vVX3Q6k9nPe+2XsjKucLT3hvopYxqxRFzg0Zt+f/JZPlQWbWtz2/RIIXbujJv16
         KJxYAw7t1m0ZGwEFn2R5HRrT0EIVUCxlkWh48Vbr93iSJ/Xgspjb/VhGFn0gyGpYWYQK
         l42Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmS51N0PZJENYWq3osmhfp2YjOj0HkkzIq3gFoSUxnkHDbSCBnfHiLLQW3gwDvc2NE3IDK1wZxDxx7/HTz3TlGsbAyRzcLzUMLCNcDOk2J6vPJOqi9OEIgKJROqcUafxjNbuhj0P2C2NuX+rQFHSDoeCrEfz2ych0UuTIQyW5iRt3NFGWFwv0BxJwG
X-Gm-Message-State: AOJu0YyWVCyL2YbLSi0BJHFOoge/kvgzs0fteRwDJ7pjvD5aHxc5QXGw
	FLfPfiZ7K/tDD1O3ijc6Weh8PwmKn8yBFK4GCPnYBjfvPiSz7OXb
X-Google-Smtp-Source: AGHT+IGyDXzlS+AEqNZexqNenfnSsvSIRWtF8AqjWIF3/9Q01UBvulHrbsLXfzC5g0zt/HFDv3pNeQ==
X-Received: by 2002:a05:600c:4590:b0:418:f991:713f with SMTP id r16-20020a05600c459000b00418f991713fmr3751wmo.23.1713895163472;
        Tue, 23 Apr 2024 10:59:23 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:22 -0700 (PDT)
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
Subject: [PATCH v2 07/13] pinctrl: renesas: pinctrl-rzg2l: Add function pointer for writing to PMC register
Date: Tue, 23 Apr 2024 18:58:54 +0100
Message-Id: <20240423175900.702640-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch introduces a function pointer, pmc_writeb(), in the
struct rzg2l_pinctrl_data to facilitate writing to the PMC register. On
the RZ/V2H(P) SoC, unlocking the PWPR.REGWE_A bit before writing to PMC
registers is required, whereas this is not the case for the existing
RZ/G2L family. This addition enables the reuse of existing code for
RZ/V2H(P). Additionally, this patch populates this function pointer with
appropriate data for existing SoCs.

Note that this functionality is only handled in rzg2l_gpio_request(), as
PMC unlock/lock during PFC setup will be taken care of in the
pwpr_pfc_unlock/pwpr_pfc_lock.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 0840fda7ca69..e6d986b84be6 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -260,6 +260,7 @@ struct rzg2l_pinctrl_data {
 	unsigned int n_variable_pin_cfg;
 	void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
 	void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
+	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
 };
 
 /**
@@ -463,6 +464,11 @@ static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 };
 #endif
 
+static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -1410,7 +1416,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	/* Select GPIO mode in PMC Register */
 	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
-	writeb(reg8, pctrl->base + PMC(off));
+	pctrl->data->pmc_writeb(pctrl, reg8, pctrl->base + PMC(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
@@ -2701,6 +2707,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 #endif
 	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
 	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
+	.pmc_writeb = &rzg2l_pmc_writeb,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -2714,6 +2721,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.hwcfg = &rzg2l_hwcfg,
 	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
 	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
+	.pmc_writeb = &rzg2l_pmc_writeb,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2726,6 +2734,7 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.hwcfg = &rzg3s_hwcfg,
 	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
 	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
+	.pmc_writeb = &rzg2l_pmc_writeb,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


