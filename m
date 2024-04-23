Return-Path: <linux-kernel+bounces-155712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D88AF605
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0974F28D6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F061422D6;
	Tue, 23 Apr 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UznNbhYz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E491411C7;
	Tue, 23 Apr 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895164; cv=none; b=YAS7RwkpyUEQszUTlORlfMLprvMa/HrvaWAhIKYnwJyAGKkA/KZb4IB4B5zd7ZA2rVyNJZiLe0hCrpORXXoUdaXQY0SGVxnDW6b3eIzzzUxARsp3uloCdkQ7ib4uNHu7QRO4M3eNXzBWkkCr3l4gtNOFnEuTpsHjRlZQJqednhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895164; c=relaxed/simple;
	bh=q1yXhV+4YHqz1aTwCJ1oxJuZ+Epq/n0SspvRNj8qTbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJNVg1F4xIyFWghCyUSeXX5qewqRwpMdYKp62AAlVetCsY24H01mnuB1P/F7a9nc8N1T5hENG/dWYTwrhOrMGxohEz4zyrH5XXAfrA6cZcx5z0gkFCgFoVjhKHnU4Vyhl80j94kTT5STQmWFNC+4HZ4AyHkun7mPi+w6jZrlfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UznNbhYz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41aa21b06b3so16298675e9.0;
        Tue, 23 Apr 2024 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895161; x=1714499961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlu+cze/XH5lMX2g6iIK11eee2996qXsMa53GSJ3Hms=;
        b=UznNbhYzl6AyTGnEaYqh0O2USXZJBpfe5D3kpRCIGj8/7MuBMF6Y2UU6iYCZwcFLaC
         gt9Yjq+dECbjkGf5Sph+hPbAb6l0EcSTLx9EyFhLIYBY5fqTLTVsa6/iB++RHZcm/fgn
         A2m7716M/WG9SGrDTBSGc/WtUHPacsfkLudv8jMa1A9VoomrtzTuekqOoU+6WLdjuNPo
         5K1eHVZW2dLroago2FD6efRZdK+S2vdqQs1gpWSxixzbiH0UQowu/jb4G2TI5rrp1qUb
         VrbfeLmazJPNE1DzR4m1sFe/PNxzOphh4f3/OtG0twwMcAOv1I8VMpL4RlYfBhGCzghU
         UZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895161; x=1714499961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlu+cze/XH5lMX2g6iIK11eee2996qXsMa53GSJ3Hms=;
        b=UUH2wMFxRpWtLOjLzGoGjsCveLKuoMr2m7X/cz7rvL0CAaPlnCbDSh32uIFJ0Xcvrr
         UIKSrDzgTbB//r4txNgOx3XnZ+Uu36GTOJB8f2ZVVWOBEKEqi8xgLV9VTjbpkiAc1vqi
         R47DiK4xkH//a95UNnanCs4xJRqoYGt27EUcxrRI58RJ9Du0jwRymiZTuHPj8qna52BU
         mwr7hP5JmG5W2+ykCzN2o2VmLxRidAkU5JKY1xcsYqpeCcSEvoU9VBBbTjCf12QPhLPc
         mwNYtvrW28slV/QBioAtuEsaO/AhtgcITPIEu+xc5P5HJHbXSC8bgP5g90oSCrf4R7KQ
         IDpw==
X-Forwarded-Encrypted: i=1; AJvYcCVk30N1krhWCXfZRAlRgsJ1A4XGlscIh+L8tuK2bxrpEIQE66lUFp7tY0M7a3Swgzy/C/Ytv8J1xbAd1LDLGb0C4y9x0HwwrL7S96yWVwM5IZ2JahpyYYjib3vOP94gtzispiqjdxnI8ZBs+dZ2DYNNhJZqV4yegn/fcG4RnrxP2wk3gJOAVIb3Ueqf
X-Gm-Message-State: AOJu0YwuxpnYxAt7jr8SXyuD+5d8EheJJuS0c3ndQGm/6s5WO090tm90
	JWlcYes/cCwkAnVcFfBuPTSJCnwQxZuWUef2reprhCCibNBcWPpX
X-Google-Smtp-Source: AGHT+IH5buIEi/VPw6QAuTpTWyRW4A+k0YzEFzIQb6LtOXv4k1FqZjEkPD71f3r/9FJjqYZEXaGtjg==
X-Received: by 2002:a05:600c:3590:b0:41a:93f3:5c6b with SMTP id p16-20020a05600c359000b0041a93f35c6bmr29752wmq.11.1713895160952;
        Tue, 23 Apr 2024 10:59:20 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:20 -0700 (PDT)
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
Subject: [PATCH v2 05/13] pinctrl: renesas: pinctrl-rzg2l: Validate power registers for SD and ETH
Date: Tue, 23 Apr 2024 18:58:52 +0100
Message-Id: <20240423175900.702640-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
resulting in invalid register offsets. Ensure that the register offsets
are valid before any read/write operations are performed. If the power
registers are not available, both SD and ETH will be set to '0'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- Update check to != 0 instead of -EINVAL
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c944d94b9a36..bec4685b4681 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2583,8 +2583,10 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
 
 	for (u8 i = 0; i < 2; i++) {
-		cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
-		cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch)
+			cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc)
+			cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
 
 	cache->qspi = readb(pctrl->base + QSPI);
@@ -2615,8 +2617,10 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	writeb(cache->qspi, pctrl->base + QSPI);
 	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
 	for (u8 i = 0; i < 2; i++) {
-		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
-		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch)
+			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc)
+			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
 
 	rzg2l_pinctrl_pm_setup_pfc(pctrl);
-- 
2.34.1


