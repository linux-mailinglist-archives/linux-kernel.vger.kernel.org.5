Return-Path: <linux-kernel+bounces-120050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A9588D0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F081C35FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A913E8BF;
	Tue, 26 Mar 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8eNC/93"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254F1F61C;
	Tue, 26 Mar 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492210; cv=none; b=FlNc10HX3ULARwCCsuOij/B+aVK5de5cya4+hnRqBG5TkyfOMQhtEVT182rI+Gk2TEX1V2Xr/ywUjYGCOUPFYEGWvg6bgLaOZpMfpJmj9kQa2RG8O3VBlnoJiu9fxRjm3FeD5j9+gkoELoueQvswi/WspkecypP+1s+y+o9h1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492210; c=relaxed/simple;
	bh=/pDeMHeqvYkpWe2yYgrSSYVEYoN52aRaMxU3QektXds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPFiNkfq5TXKgNsAyd+vWUbhXt4joHUbcwgWbayGBSgy8YDZ54Vy5S4HpQWpbJ2tVMM9Nflj+ECVp7MgeFy8A6kTiAXiVdn/DVkxf+9Bphf9uIRR7cjMd3few/YLsH8mDsu59PIESX0SYXSlwYKuxrFba0KlmpNKRTmuUuk9dro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8eNC/93; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso4318130f8f.1;
        Tue, 26 Mar 2024 15:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492207; x=1712097007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSimU1CbyugwQOMg7TphS7eBhLoLw2mavmtx882jjic=;
        b=A8eNC/93UNba0nJjAMpPmP2GKVFhlYvWbGYUgpnq1JUc8MhXqot2FXX8nhm7CMCVfh
         j1UOUcGCZLeAzoC49ocb4pGQl6FgjbbUloAGnzV7tgmOYVCRjQPwzKCn+kSD5Q4NfTvU
         lav4DFDflEzFppA1qIPhb8nfwIsZ2xtIxT++1HutgakJLq7UxY+bX2e/+SdtGyq3OSis
         22tRiUnDUZmlIB9H28Pbcen6ICFLd0Kg1XBoNTAjK5uNhvFln34O1Y3fyDj5z4w2p4QZ
         qH2DZEcBVF0+mVy/Dy88uEApzbWk8+pqxLoxAVskO4CZQ0PP9XehdCirvaif6ztl0gnc
         4+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492207; x=1712097007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSimU1CbyugwQOMg7TphS7eBhLoLw2mavmtx882jjic=;
        b=L/MVRX3GKrfOAWrvpewb2l88/vBU69i+vrPJy31HR44SBkW8l+scZLQmbXm0BuJJrr
         6eFcuk0uDpOTADtzkKbmDRblDoqaPuAyN7s2B1FU1Y9x8N9j2gP/pxLQW9lvqOIubVYW
         DPCLSNbebkm0it6E4lxsaP6LpSiZTou3g2Ur0CeWfcnrcw5wF6HVcKyYO5+ef84QNEAL
         /D0H8ejgGOd7EdmakKJCT9oKpfNjg9ykCbGrsv0ZsJi2mHnd3XzpJgzIAQsd42c8lcJ+
         LgMW29YCtV58msN2HS1CPDb/VJkUT0owZRsmX0vsj71hZHA2II4lOIu7iewM9dyfyOQE
         gB/A==
X-Forwarded-Encrypted: i=1; AJvYcCVHvCnstB5ZDK+LS/XxSovKVm8kUMlu5lIIcfTkOiO+p+N5r9P07ZlRqM7LzZl8+3c0z81o56StDK9DtYxNoZjMKQhDbeSn4r0L0A7Ea0g5hjX5MujwaRQhyjs/JuzEAU6oGQi9+C9nTj7X0CSh4yLVUQq//3nIVWlDyRDPzCaJPBuy7VY=
X-Gm-Message-State: AOJu0YyeCO/fmPfkcaHsdSn/oSPAhctCKBOMJ16wBK11Y0YXxVuDC6br
	AZnGQhOOPOV/0hxzxs7LpTajqwFC0pEWbE+HlI6bqxgbAOAnN2wb
X-Google-Smtp-Source: AGHT+IHUmNqXbAuG9ebm/RAQnQZyNG6/KlomjZUIhdQfBpuLpROQHVzZLyqbivlJ0FFo0A2paHwd4w==
X-Received: by 2002:a5d:550d:0:b0:33e:c974:1290 with SMTP id b13-20020a5d550d000000b0033ec9741290mr533448wrv.18.1711492207281;
        Tue, 26 Mar 2024 15:30:07 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:06 -0700 (PDT)
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
Subject: [RFC PATCH 07/13] pinctrl: renesas: pinctrl-rzg2l: Validate power registers for SD and ETH
Date: Tue, 26 Mar 2024 22:28:38 +0000
Message-Id: <20240326222844.1422948-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
resulting in invalid register offsets. Ensure that the register offsets
are valid before any read/write operations are performed. If the power
registers are not available, both SD and ETH will be set to -EINVAL.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 348fdccaff72..705372faaeff 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -184,8 +184,8 @@
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
-	u16 sd_ch;
-	u16 eth_poc;
+	int sd_ch;
+	int eth_poc;
 };
 
 /**
@@ -2567,8 +2567,10 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
 
 	for (u8 i = 0; i < 2; i++) {
-		cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
-		cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch != -EINVAL)
+			cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc != -EINVAL)
+			cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
 
 	cache->qspi = readb(pctrl->base + QSPI);
@@ -2599,8 +2601,10 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	writeb(cache->qspi, pctrl->base + QSPI);
 	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
 	for (u8 i = 0; i < 2; i++) {
-		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
-		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch != -EINVAL)
+			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc != -EINVAL)
+			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
 
 	rzg2l_pinctrl_pm_setup_pfc(pctrl);
-- 
2.34.1


