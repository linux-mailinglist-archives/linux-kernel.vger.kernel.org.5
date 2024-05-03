Return-Path: <linux-kernel+bounces-168241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0138BB591
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1487B1F23DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446379B8E;
	Fri,  3 May 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feauQYI+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AE5A788;
	Fri,  3 May 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771373; cv=none; b=RstRDkaX+cMOujhBydGtADXpPiG0qsmDpWReTwsOq6nYSZCUN4PfR38wPq8ZTnkXQPrlgsuByOFQc3GXhaqUmiBiGAyamYwFgZt8b/rK+3LmTBXiXkaOdiDnRZ2Q9Sa3iT8LjiDzLC1Hb8+6b0Ou6mVhAMbWnWky+lfCX9VLWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771373; c=relaxed/simple;
	bh=65SBhm2zrWFP9xVHnGPeQVhwBSkJioFsSDoST6eHRFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAkggi9fs652/24givhZ4oGoBd6roBno+Q3M18PG3NDD4Gx21rxo0IytwkJKG251GUMAsyzRe8oNDeOf2QjU/fgZCu1B+1IYhEPCwvE9FtHNO43MweIhhNQahNY6AfziUdzL/d+dawVkqug875/UF7ohOYhj0KT9+UEeh4b1m/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feauQYI+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b79450f78so988945e9.2;
        Fri, 03 May 2024 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771369; x=1715376169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TylOqhH9oLbqqMRpzt0l3e00DQ35pa/uQ1g0qYZVtI8=;
        b=feauQYI+C/sPrfO1RmmDfeaiiF82thMKqhSChYxorS1ZFl6sA+5EJ6sjrzT3U2FNur
         iriqbchvTkJWlMzujuUQA/+xla+tiXwus33mdwQRiitOSbqCX85c0jhER3YKOQrc718w
         mob/oDwVX8BjU3uwMHlMxEXe1e680qtJ8t/bK2eg/XLNh6RrhlVq/8mohUGZktfb5zaP
         EhCdCGMQKasKVH7NmUYzSa593Ys+9oNN2g6OVRROqbCWFoBES1d+5940BF2ZlcOanVh7
         VbpwphpLnigdp+hOf/x3YBzGyq8eaHFR+lIubV3ZLZ5JTZf0fe7qEDRIBPb1XFq0XAfA
         1Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771369; x=1715376169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TylOqhH9oLbqqMRpzt0l3e00DQ35pa/uQ1g0qYZVtI8=;
        b=TMnXBjSPI1XJf6htbNhsRxKAjv4z0bHK1mqkXenD9Y9FfdklbucjjSn4OoC7pq5KO/
         6ld/mZkayQqbwQJGze8ZfLwx//omNSzqh0fU6thPMv1gyMo2TQMAPMK1nephLCdP2ecK
         oeExBaWC5ctwrT2Jh0STkiGS6qtDuyKMDbjDzJK4nbS9Dg0zC4lyQQACX5B1cZ6r71QE
         wpQ2HReAe1+TuFwmaJJVbKdJ5jaYG7nziVniq96lM8aDovQ3mrnQ0ZkqBqR5iEl4adfo
         TdX4YXTM2OgumjNTumKLUwqiavl0m5hOWuJB2sYkFsdDfx86AYBri/wIT8a/iI/CUoVz
         hd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXF+Lral0hFAcpnReuMsStW5E4XTsifbFrfYvs7wZG6mpuUg+H9vrhChIWmZBl+8+yTCsLGLLQR8VskobfvP46XSWvhbbUITOAxGaSZPw7mocv7gOlFP1HyFWje+kwQ0u6m7tSTyKmdQ4xR5UjUwLxYfEH/uxeH7hMD6JOhAbBqpAqC/E=
X-Gm-Message-State: AOJu0Yw2hfkngYhDqPT83BBRU5puWAWEmkJwj7mLk0MvHYw7uJyrt84I
	7J737zRzvdk2OPLvm2bAeM2zVR/KLMmyW/cucHriKSmizxESoyk1
X-Google-Smtp-Source: AGHT+IHlo8PDCFecvI1JDTqv0y3wApZ9EwtOJk9NkN3RX5kxIjYcBttVmk9YFWme6o8n7kPUmhNIEw==
X-Received: by 2002:a5d:5050:0:b0:346:662f:62b7 with SMTP id h16-20020a5d5050000000b00346662f62b7mr3325364wrt.71.1714771369537;
        Fri, 03 May 2024 14:22:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm6918729wmq.35.2024.05.03.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH v2 4/5] mips: bmips: setup: make CBR address configurable
Date: Fri,  3 May 2024 23:21:00 +0200
Message-ID: <20240503212139.5811-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503212139.5811-1-ansuelsmth@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to provide CBR address from DT to handle broken
SoC/Bootloader that doesn't correctly init it. This permits to use the
RAC flush even in these condition.

To provide a CBR address from DT, the property "brcm,bmips-cbr-reg"
needs to be set in the "cpus" node. On DT init, this property presence
will be checked and will set the bmips_cbr_addr value accordingly. Also
bmips_rac_flush_disable will be set to false as RAC flush can be
correctly supported.

The CBR address from DT will be applied only if the CBR address from the
registers is 0, if the CBR address from the registers is not 0 and
is not equal to the one set in DT (if provided) a WARN is printed.

Also the DT CBR address is validated on being outside DRAM window.

To ALWAYS overwrite the CBR address the additional property
"brcm,bmips-broken-cbr-reg" needs to be set.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/setup.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 5e024399222f..bf27b29c7a14 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -34,7 +34,11 @@
 #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
 #define BCM6328_TP1_DISABLED	BIT(9)
 
-/* CBR addr doesn't change and we can cache it */
+/*
+ * CBR addr doesn't change and we can cache it.
+ * For broken SoC/Bootloader CBR addr might also be provided via DT
+ * with "brcm,bmips-cbr-reg" in the "cpus" node.
+ */
 void __iomem *bmips_cbr_addr __ro_after_init  __read_mostly;
 extern bool bmips_rac_flush_disable;
 
@@ -207,13 +211,42 @@ void __init plat_mem_setup(void)
 void __init device_tree_init(void)
 {
 	struct device_node *np;
+	u32 addr;
 
 	unflatten_and_copy_device_tree();
 
 	/* Disable SMP boot unless both CPUs are listed in DT and !disabled */
 	np = of_find_node_by_name(NULL, "cpus");
-	if (np && of_get_available_child_count(np) <= 1)
+	if (!np)
+		return;
+
+	if (of_get_available_child_count(np) <= 1)
 		bmips_smp_enabled = 0;
+
+	/* Check if DT provide a CBR address */
+	if (of_property_read_u32(np, "brcm,bmips-cbr-reg", &addr))
+		goto exit;
+
+	/* Make sure CBR address is outside DRAM window */
+	if (addr >= (u32)memblock_start_of_DRAM() &&
+	    addr < (u32)memblock_end_of_DRAM()) {
+		WARN(1, "DT CBR %x inside DRAM window. Ignoring DT CBR.\n",
+		     addr);
+		goto exit;
+	}
+
+	if (bmips_cbr_addr && addr != (u32)bmips_cbr_addr &&
+	    !of_property_read_bool(np, "brcm,bmips-broken-cbr-reg")) {
+		WARN(1, "register CBR %x differ from DT CBR %x. Ignoring DT CBR.\n",
+		     (u32)bmips_cbr_addr, addr);
+		goto exit;
+	}
+
+	bmips_cbr_addr = (void __iomem *)addr;
+	/* Since CBR is provided by DT, enable RAC flush */
+	bmips_rac_flush_disable = false;
+
+exit:
 	of_node_put(np);
 }
 
-- 
2.43.0


