Return-Path: <linux-kernel+bounces-79851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67D86279A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1FA282B43
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3291E878;
	Sat, 24 Feb 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTbO7Jro"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184712907;
	Sat, 24 Feb 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806835; cv=none; b=W6Y67rTHA3Zs6cBtSNTZCz37c7gyW1faJeCBpp7/hn7ruh9w7FAzV/smBo0Lfwg1+nwhD7MsxB4a50sJm+jTc8iTQ8889wXJbyVDl6Lzp47OuTepsSOpMzbLB0wCwStsDPaVbAaP282tDj2wqWXrquL93swWMTIeh/xWsXOtD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806835; c=relaxed/simple;
	bh=cCfTcHh+L8Sb+wMNuDPsXe3SfkLkUJcgmlIeJkrlaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGnC6sbdpwESXQSB3FzdpE95Ee7k08TFZNgILH1lu3LN7EtNb5yLP3A1hRjd0omD9BYapsqpSO3R5pp3/CM62RLS8k3vOfwtp2ZlGrqB7/ARfAESwkBIHMf+NGLgchCzJavM7HffHtsxZZFUAuWIlmcihg9HgzjdVZUcd4nm9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTbO7Jro; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so299960266b.2;
        Sat, 24 Feb 2024 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708806832; x=1709411632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XM8+0P5wB9WQpTB3495MoLD3B+gCcFRkLx1uWNuJ64=;
        b=cTbO7JroP4AjXv+7XxyYnKGkNSI6FE48BexIqtV3890ByoaN+jR4qxAt3xQhq1RR8r
         eGt6eug0itrPDiGXz/4oUfN+7dxKIwrusVaTZuMGUMYzW39YB2A0Bb4x0/vSB+1F+A7I
         eTTulR65PoHcPcKUqDj0RihH3yG2lxyRY2eAHhEh/RTwXSIV54/59v0qSU3KTVHusW8w
         b2cwAIKA38rFdER7/RrX8U+lDqCNF5n6N96G2cT2XcGtr0Tzw2TpySl5mecGrM1n1K+k
         idruhThuUgllwXAxSVFbxrttgAvm2xR5Yb6Ozf3U5Bkscx+oS0ywa12gEogWD/hGiC0Y
         ttEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806832; x=1709411632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XM8+0P5wB9WQpTB3495MoLD3B+gCcFRkLx1uWNuJ64=;
        b=a/jME/wsZNGvjsx8yqINh9Ot1z73C5wPJQdKY7PM/BqGjQc8BvwXzxrd4Nl2sxA7Fx
         GDOGRHDCUss+6Lbauvszf9BrxnWxWNBJ/U5g2CcFjrOWoE0gMQk/pFnBD2ex52BnuxEN
         +1pEw53K4/ZR0cHI6ANHSG+EX67g7H9TlSgvJFalBEoXTCmQ4deMYLZXS+KkF2Alvv5A
         GqLogy3Kjuj0fZGtIY0N5ojIu8GUEMkzcqETrZ2zMDouPfiLcDFMKjiQb59j26aSeGEB
         lZ8jl7/vAxNyXgOCqx1ecjki2gNoBl6MxceasKw/2ZAjV3b7Lt390ZtDuDWJwXEbANbH
         LWVA==
X-Forwarded-Encrypted: i=1; AJvYcCV8CuRyXjHevHd4mVAvvtAb+bk0MYMmB6yXb9ShVIcny7pyF7mStRhntmEyQSO2eO1WCP8J4gUjm8ihrRWJQfy6GjvRRPGNHUqvRrA5cCneZVb7evVQiD8pxNmHFNZybZKiQNCG
X-Gm-Message-State: AOJu0YxfTuFjxDUYUs8xSxwLQIq4FLquWxZNxlELPMfhnJEqTIc/nxWb
	gS/F5SyL3otgGm769q3oG4lq3Gy1zgQDG94Rmwsygoi3POsAK0V7
X-Google-Smtp-Source: AGHT+IESmMbPDUr6ionUcnAyBbj+WoYK/YfXv7vOgH5HMQrzlxAQqwgXfE2mkH5PkcFc8w8iKaXiIQ==
X-Received: by 2002:a17:906:b755:b0:a3f:8008:1823 with SMTP id fx21-20020a170906b75500b00a3f80081823mr2135627ejb.72.1708806832192;
        Sat, 24 Feb 2024 12:33:52 -0800 (PST)
Received: from fedora.. (cpe-109-60-82-34.zg3.cable.xnet.hr. [109.60.82.34])
        by smtp.googlemail.com with ESMTPSA id o16-20020a170906359000b00a3e45fa1c77sm875363ejb.55.2024.02.24.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:33:51 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next] net: dsa: mv88e6xxx: add Amethyst specific SMI GPIO function
Date: Sat, 24 Feb 2024 21:33:09 +0100
Message-ID: <20240224203349.1358064-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing mv88e6xxx_g2_scratch_gpio_set_smi() cannot be used on the
88E6393X as it requires certain P0_MODE, it also checks the CPU mode
as it impacts the bit setting value.

This is all irrelevant for Amethyst (MV88E6191X/6193X/6393X) as only
the default value of the SMI_PHY Config bit is set to CPU_MGD bootstrap
pin value but it can be changed without restrictions so that GPIO pins
9 and 10 are used as SMI pins.

So, introduce Amethyst specific function and call that if the Amethyst
family wants to setup the external PHY.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            |  5 +++-
 drivers/net/dsa/mv88e6xxx/global2.h         |  2 ++
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 31 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9caecb4dfbfa..41426950da21 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3712,7 +3712,10 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	if (external) {
 		mv88e6xxx_reg_lock(chip);
-		err = mv88e6xxx_g2_scratch_gpio_set_smi(chip, true);
+		if (chip->info->family == MV88E6XXX_FAMILY_6393)
+			err = mv88e6393x_g2_scratch_gpio_set_smi(chip, true);
+		else
+			err = mv88e6xxx_g2_scratch_gpio_set_smi(chip, true);
 		mv88e6xxx_reg_unlock(chip);
 
 		if (err)
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index d9434f7cae53..3b3f8b6c82c8 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -380,6 +380,8 @@ extern const struct mv88e6xxx_gpio_ops mv88e6352_gpio_ops;
 
 int mv88e6xxx_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				      bool external);
+int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
+				       bool external);
 int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port);
 int mv88e6xxx_g2_atu_stats_set(struct mv88e6xxx_chip *chip, u16 kind, u16 bin);
 int mv88e6xxx_g2_atu_stats_get(struct mv88e6xxx_chip *chip, u16 *stats);
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index a9d6e40321a2..6998c687c553 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -290,6 +290,37 @@ int mv88e6xxx_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_scratch_write(chip, misc_cfg, val);
 }
 
+/**
+ * mv88e6393x_g2_scratch_gpio_set_smi - set gpio muxing for external smi
+ * @chip: chip private data
+ * @external: set mux for external smi, or free for gpio usage
+ *
+ * MV88E6191X/6193X/6393X GPIO pins 9 and 10 can be configured as an
+ * external SMI interface or as regular GPIO-s.
+ *
+ * They however have a different register layout then the existing
+ * function.
+ */
+
+int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
+				       bool external)
+{
+	int misc_cfg = MV88E6352_G2_SCRATCH_MISC_CFG;
+	int err;
+	u8 val;
+
+	err = mv88e6xxx_g2_scratch_read(chip, misc_cfg, &val);
+	if (err)
+		return err;
+
+	if (external)
+		val &= ~MV88E6352_G2_SCRATCH_MISC_CFG_NORMALSMI;
+	else
+		val |= MV88E6352_G2_SCRATCH_MISC_CFG_NORMALSMI;
+
+	return mv88e6xxx_g2_scratch_write(chip, misc_cfg, val);
+}
+
 /**
  * mv88e6352_g2_scratch_port_has_serdes - indicate if a port can have a serdes
  * @chip: chip private data
-- 
2.43.2


