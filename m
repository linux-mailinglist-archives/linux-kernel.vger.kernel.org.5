Return-Path: <linux-kernel+bounces-71647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98885A850
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A00CB22CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54D3FB14;
	Mon, 19 Feb 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etd0pAgC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450C3CF71;
	Mon, 19 Feb 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358998; cv=none; b=iMq9k2//cLPQxbU1t5L8wF8JN5lEiUY9rRGQdQcCFs2k7y3wYjLdeLDGs/Hzsrtu/+j7eDTJZpETvVCGJrBtX2dPkbFi7C1T2BcmIJ/EkOdeyT+Lfhs8okRSmI/TEb1Q7Q1vy/V52pLE820VlCYjXZVwCxDH0h7zo2de7BoCoDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358998; c=relaxed/simple;
	bh=vofPB0kRjGtISv61Eu6snz09738FlvIvSZ5Jg08rcVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOFce4bdpzSUlMV1u/ZvGFjhUkrCxoTrPHtyoS0gwR63JEaH750kvZsOInuwOxTTEogHVm2EED5+dB6ECIkZKnBCilWt3jcc5wF3HaL5RC9+qjfKB3jHmGm3XV++yYZhWuAhQgTbp5sz9Kh9zPXYfHFVef8Cg7EDiKJsuuX8awM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etd0pAgC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so37478545e9.1;
        Mon, 19 Feb 2024 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358995; x=1708963795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAty1mWdwmMOLtDVPwWFJ/YPRqG9UrpAtFa4aRlt5qc=;
        b=etd0pAgCHdSeSGx1nHJpNXJkJJRztNE5fBhaYbLMeDkbUomahEPXk92b+M5YOqosCH
         MjNJ9RU3bFw9y7SIpdYHYrhD2vehL44RJeYzNoLmAE/ifTBdBhqz7sH7agQIp2WZd8t7
         lxisEdZMU2RsitaWfQs2sEcnSO3hgAujiEPJFWZ+EBpWa1RdA8DtwAq6u6hdQMSlw1qm
         mBfAytjwhc1D1Ectl4RB8kawS327tqqHVRxHfiUN++ces1mYoYTuAlEGcn+LjZMWu7iq
         KXgrELkjhrFMd5Lf2E4IgkTXbZkg9Eadk8A79jM04+EXx4rEnsB2D33MZGn2O74lnull
         9jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358995; x=1708963795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAty1mWdwmMOLtDVPwWFJ/YPRqG9UrpAtFa4aRlt5qc=;
        b=plyQiad+G/CzEHrCXabx12tDmS7l3HgnmBYQqILqbB+4hmwbfF+HzdaKmZr4+tx2I5
         3WPTCi6Ty+Op12ZKJzq1QKlqkOZObyrWHybL9h3ZyaeXmlweT1WYvKxiFn8+CJ1Cf7Xb
         QWwA4OZMP4f8X0dleUdnCfgFF0IplcYopGLnU7UhjiqMBuFujfTKM00NeXUg3oCB9yoE
         E9uKnIXTvJ/xxiHBiW1+Qa+aZQnIC1iAiyl0YqBtR8AeIeSWqFzlDpvoGjWJDZpTohgh
         gwwP5ggNhQtoWXQjD6Grw+uocsObS+vjCJH3I4FiWaJgJ2vYjqCZto0TjLh4EvNA8IVG
         rg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXR/YkrNmq1FJ/4O9oh+ZlH31unCDJfOwcxzZyl0HI0Z5ccsIto7/aopWyU9WYENbqAGpQZElyjelh6GYAPWqDO58/wN/ij7GfQFZwpHlttQ9NFGcaM+W7hufD8aP+Yd+Gu/81JWBqcJR4ihyosLhys3lirGi1ylnW2bSzDDOHVnqixF/YhfkjjzCa
X-Gm-Message-State: AOJu0YzkRWPFin+HMDXioN3ubnB+Q7WwYptBDrQrFI2JktaKkv2Lb5hq
	CLRA04U95QnpvcWdDr5Dfy0vSfCup8pQml7pakhtx+5nanOeIXuc
X-Google-Smtp-Source: AGHT+IHrkzblkrWsemQP5Dqf+bUZAM56ai8td+o/veIe6vP6nnk/AAMbYi1zMp751ZFku+6MsMv4Rg==
X-Received: by 2002:a05:600c:3790:b0:40f:cf69:3e1a with SMTP id o16-20020a05600c379000b0040fcf693e1amr9584304wmr.39.1708358994673;
        Mon, 19 Feb 2024 08:09:54 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm11592670wmi.34.2024.02.19.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:09:53 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/4] soc: renesas: Add identification support for RZ/V2H SoC
Date: Mon, 19 Feb 2024 16:09:11 +0000
Message-Id: <20240219160912.1206647-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/soc/renesas/Kconfig       |  5 +++++
 drivers/soc/renesas/renesas-soc.c | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5deca747fb77..78d656d7699f 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -344,6 +344,11 @@ config ARCH_R9A09G011
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
 
+config ARCH_R9A09G057
+	bool "ARM64 Platform support for RZ/V2H{P}"
+	help
+	  This enables support for the Renesas RZ/V2H{P} SoC variants.
+
 endif # ARM64
 
 if RISCV
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 8f9b8d3736dc..499d120f9978 100644
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
+	.id     = 0x847A447,
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


