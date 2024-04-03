Return-Path: <linux-kernel+bounces-130539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC78979AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B8C1C2186F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92A155A30;
	Wed,  3 Apr 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRYnYMVP"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CA1553B3;
	Wed,  3 Apr 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175085; cv=none; b=pnZ54BkaO2HBrUrcm3rXNZNMxtxgACJ7Zo3ndYLv67VgtMfiOs5HWeyjIMeXSTHcNEr7tUd2ID8lzvipH+v/uejeYB/JOv6wFr6EjztvGO3329otym7Q/UzlAK4QkFLmrRh/FN+yL4Pq8Dd8PiUF61bWOkNbkwZ/+4ObrFVRHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175085; c=relaxed/simple;
	bh=sun1NsHk2vEsIXt3sZXU+hXzHiz0Ux6ixOcTuUjI7kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uzbamiNV3165kO7Uol0UBmmGW00NjhYE9LRMYvqG2MazWtBQqHam116R1FWo5AKTESvsiixvQ9FYSe5LxpFOPp7eJTRHZJvuC2kkAlVP3kKNgqMl/XpCoUITTiu9HSg0yUHysQUAc7x/iaY11HWOoBCt06M75MufnjXo63PHZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRYnYMVP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415523d9824so2141265e9.3;
        Wed, 03 Apr 2024 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712175082; x=1712779882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOcLWgLOgrNtkAnYfPiCGepAqkA5lMiMzdb5KR8b+o0=;
        b=mRYnYMVPkUR+564YGKX8uEAazIDaS/KePWUhN4a4MYCkl7JTYZvcs+HgQqoFV64OiW
         Afegr+QkblOYKe7XT5Ma5OwpbL+XBp4V55mKi2wNJswihgmeVvrri9YjdLelGxGhT8Bj
         eZ1ubR44iZbsK/Nll3btaKZ8WCJ84bF9C/0RGoQ8huruXYyH5fkDXvw9FAAqdsZs8AWP
         M5mlV14nyYgTbbsNpyvcbSQuMP3wouuS/hrP6xm54xjjLFRYUGFoV9sz7jI9bfPruAO4
         /cyNiCl9plQo8qkKkqsuY1kiZ9pkKbn+WLXkWpCZWl+s785qmMvrpytmsb8bCd5kjSZn
         B5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712175082; x=1712779882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOcLWgLOgrNtkAnYfPiCGepAqkA5lMiMzdb5KR8b+o0=;
        b=aqFQ7VAHugwD+hPTVguiEX9wKE22KfEabBFbDVUb9EXuNKkD23134UkxdWAZD5gSCV
         GgVDgjwfGCEH8Qc4lFXvvQ5P1vGAjhEEwzv3o24EKifkELmxk3Q3hV7sYPbRqFcY46nw
         nNSDFAJ+xfRYnVephfK6xkFLJiRNZdrq+0MZHfrn7yrcmT5jzV4RHFl2FBG0vicpvYVS
         +qbi+d8TI6BMOiHg6Lujy9tZbiasbYkrrgwqR2FRzPJCuoBVVztyHq2ld1KwQwrtg4gT
         83lKXum8Hysv1SZI5Xhho7KJcFiyaGehfeucKG63bX1Kezr3AHUseonDUIRiq48WvBMy
         QtdA==
X-Forwarded-Encrypted: i=1; AJvYcCX3EPyvGGbKyYbIhq3KG1PBk57Zlc00loTDQPLlLuhASPwYPjCwjkOVdjqNDJHfGWLphGROAX9X1ExrKtDLwtgl34ZTC0RxDIc55WJctqQRUQRl/Pqq+bGPgxY1i46K0rOoBQkC5ex/Kd1pzJvJ+9Y=
X-Gm-Message-State: AOJu0YxPVEccYC5xrehC1PiQfb6Ggajad+cVA6TSNhvzIIgSqctqbns+
	YFs8gcTyU0uTlkGwvU9utVR7y6gyo+XbHVy7Ox7edCMe7Wbf7VZ//Y68hAwR
X-Google-Smtp-Source: AGHT+IHtLaUCwwkgS1vtIEW1V174Y94xNXH3nSrut92Q5koJYf4Y2HWj56P76mXN+xJub7xa6PNmqQ==
X-Received: by 2002:a05:600c:4f91:b0:414:227:fc66 with SMTP id n17-20020a05600c4f9100b004140227fc66mr584172wmq.2.1712175082076;
        Wed, 03 Apr 2024 13:11:22 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id u1-20020a7bcb01000000b004155a32841bsm211197wmj.39.2024.04.03.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:11:21 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: r9a07g043: Add clock and reset entry for PLIC
Date: Wed,  3 Apr 2024 21:09:52 +0100
Message-Id: <20240403200952.633084-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the missing clock and reset entry for PLIC. Also add
R9A07G043_NCEPLIC_ACLK to critical clocks list.

Fixes: b3e77da00f1b ("riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index e36d2ec2c0f5..16acc95f3c62 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -280,6 +280,10 @@ static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x5a8, 1),
 	DEF_MOD("tsu_pclk",	R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
 				0x5ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_MOD("nceplic_aclk",	R9A07G043_NCEPLIC_ACLK, R9A07G043_CLK_P1,
+				0x608, 0),
+#endif
 };
 
 static const struct rzg2l_reset r9a07g043_resets[] = {
@@ -338,6 +342,10 @@ static const struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A07G043_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A07G043_TSU_PRESETN, 0x8ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_RST(R9A07G043_NCEPLIC_ARESETN, 0x908, 0),
+#endif
+
 };
 
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
@@ -347,6 +355,7 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 #endif
 #ifdef CONFIG_RISCV
 	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+	MOD_CLK_BASE + R9A07G043_NCEPLIC_ACLK,
 #endif
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
-- 
2.34.1


