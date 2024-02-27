Return-Path: <linux-kernel+bounces-84216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86086A3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AC3289C89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B859B4F;
	Tue, 27 Feb 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtnZGwPy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13F58ACE;
	Tue, 27 Feb 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076367; cv=none; b=eZhvn21DtgQdd+1oUCF0aTPGTK9yhVf8i8v6BsvtBRdpnUFPlNLC6mYoJHJt111FNEY39N2vL6lsPDON2gF4tyR6eRm7SL+FTzIBFjpgMa1S0NrI5y7j06YY3p59GdbtV7yjpjPCHeEY33dxhIkso7l/YSrBT9KqvTfbksGmdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076367; c=relaxed/simple;
	bh=Faac3kyKWeE/qiw7qWfnqKneULAe6vqjmTEGlRvrUzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZH0E94z9kCZzRJqKe9kufGBVyfVKXESQ/Kh5MfW9obG4d0fkeI9ghUMaMrUK5l8SENFnreES8ZSe9HlsvBzS7rLi1mNK1cumsQHd9yWlg0vuYeQRs4ZnUwk8Z3Yy+FlGyFEUar3OVAHVDB/drxM8s6yp2YUcAztpXv+0RWYNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtnZGwPy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a14299a4so26229475e9.1;
        Tue, 27 Feb 2024 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076363; x=1709681163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrbq9/3K+cXKsueDWBzf+N6MdOLNDuDdOsXrr/s8YT8=;
        b=DtnZGwPy9DWEomM+ePk6WM20ggBPreAOahWcn0DVD+T8FonUaYQKgkj7dEqQ9u3rRs
         tmYzPYfPiqgZAleU8JUb57qhU9bAVJ2Z/OOQY+CZNUTOnqBZwdsyeH7chSQkd34NrAhi
         V3oEd1OAuhFvWutKTFa/3EDFfMiJEtWcHPU2LBoNPe5ba4Bao5m1qTT2o45Z7iGxWG+3
         LxAwLqYEZ/Aowl5FHgQv8S1nWfg9NRElBeYUo3+JkfSZzG4rs2WknDzAn0M/ayc1x09q
         bkq25Tn+rA84YsATybfP5V4+nOe/1lH7bfOZrT/Pa4Rnj0rr7SKyf4l2Lp4cj9RQ3+jY
         In/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076363; x=1709681163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vrbq9/3K+cXKsueDWBzf+N6MdOLNDuDdOsXrr/s8YT8=;
        b=jQF/ZQwGa6Vdk9JZhdDo9SLubp5vh4tbEmv8oNJEKrXT/JDRNJLazvYyilW3hXLdfL
         Fq/KIx+GP19s0emPiLCkTz3Ml9bDIQ9jgNlZiZwv2+SsQmlPxxfi3T6/UJuh4oNJr6Up
         1FrCeuWJt9ho1N+508nFwdn8hjZdlafu0ZOjI1W4xkc9uQG7FEF65i317mB7WwtloYUe
         1CM+b2qneJLEVDeigdPjps58HiTHcMr/swYWnKfTuR+EOdEyRXyq4Dkcx1iMxN+s4IXA
         5kSCZpXoUqcss5UwWuMMgzdyYC3xnvHsg14XOMvw3dwWqpWMcV+NJbEm7CKg45Ys35hC
         wQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVgnZ290x7bxtrzI1V0zGm1KLEiYctCGg7KQ2eUJC6UZBqwb0yJs5sv6RNaCBT3gldAJ6LC+zmTyl5Z/UJgILwem789d29VbEBJJgWWaPt0oNE4dcIzc6CK7NtT3GvjEOxGSVYkmeufUZYC6vySDJHduhApTMN/ZMhf3w6j1ttVdmsu3FeB1fD/U0Cq
X-Gm-Message-State: AOJu0YwcqdlwO8K+STwZAKQWqLe9+DWVoxwdq2MoIFi7N+iy3x/Ed1Ys
	IX/ko8ukdELL/f0Ac0gu9QtNWEgEXUXWK0DMLZg8epctraAQd3fI
X-Google-Smtp-Source: AGHT+IHsVjm2Q7TKH3P6XxUjdsf5x35MHtvMZ9f8l+fBRTkAGh8oJVyX1oT6LH8aHrVqysjgwPOOpQ==
X-Received: by 2002:a5d:6649:0:b0:33d:aa78:ed82 with SMTP id f9-20020a5d6649000000b0033daa78ed82mr7972508wrw.34.1709076363542;
        Tue, 27 Feb 2024 15:26:03 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e6a2:98b:e06b:631a])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d96b4efbasm13014444wrb.21.2024.02.27.15.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:26:02 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/4] soc: renesas: Add identification support for RZ/V2H SoC
Date: Tue, 27 Feb 2024 23:25:30 +0000
Message-Id: <20240227232531.218159-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support to identify the RZ/V2H (R9A09G057) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v1 -> v2
- Replaced RZ/V2H{P} -> RZ/V2H(P)
- Used small case for hex value
---
 drivers/soc/renesas/Kconfig       |  5 +++++
 drivers/soc/renesas/renesas-soc.c | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5deca747fb77..91464ea48baf 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -344,6 +344,11 @@ config ARCH_R9A09G011
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
 
+config ARCH_R9A09G057
+	bool "ARM64 Platform support for RZ/V2H(P)"
+	help
+	  This enables support for the Renesas RZ/V2H(P) SoC variants.
+
 endif # ARM64
 
 if RISCV
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 8f9b8d3736dc..172d59e6fbcf 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -75,6 +75,10 @@ static const struct renesas_family fam_rzg3s __initconst __maybe_unused = {
 	.name	= "RZ/G3S",
 };
 
+static const struct renesas_family fam_rzv2h __initconst __maybe_unused = {
+	.name	= "RZ/V2H",
+};
+
 static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
 	.name	= "RZ/V2L",
 };
@@ -177,6 +181,11 @@ static const struct renesas_soc soc_rz_g3s __initconst __maybe_unused = {
 	.id	= 0x85e0447,
 };
 
+static const struct renesas_soc soc_rz_v2h __initconst __maybe_unused = {
+	.family = &fam_rzv2h,
+	.id     = 0x847a447,
+};
+
 static const struct renesas_soc soc_rz_v2l __initconst __maybe_unused = {
 	.family = &fam_rzv2l,
 	.id     = 0x8447447,
@@ -407,6 +416,9 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
+#ifdef CONFIG_ARCH_R9A09G057
+	{ .compatible = "renesas,r9a09g057",	.data = &soc_rz_v2h },
+#endif
 #ifdef CONFIG_ARCH_SH73A0
 	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
 #endif
@@ -432,6 +444,11 @@ static const struct renesas_id id_rzg2l __initconst = {
 	.mask = 0xfffffff,
 };
 
+static const struct renesas_id id_rzv2h __initconst = {
+	.offset = 0x304,
+	.mask = 0xfffffff,
+};
+
 static const struct renesas_id id_rzv2m __initconst = {
 	.offset = 0x104,
 	.mask = 0xff,
@@ -449,6 +466,7 @@ static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a08g045-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a09g011-sys",	.data = &id_rzv2m },
+	{ .compatible = "renesas,r9a09g057-sys",	.data = &id_rzv2h },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
 };
@@ -513,7 +531,7 @@ static int __init renesas_soc_init(void)
 			eslo = product & 0xf;
 			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
 							   eshi, eslo);
-		}  else if (id == &id_rzg2l) {
+		}  else if (id == &id_rzg2l || id == &id_rzv2h) {
 			eshi =  ((product >> 28) & 0x0f);
 			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u",
 							   eshi);
-- 
2.34.1


