Return-Path: <linux-kernel+bounces-167730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A48BAE31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092201F23293
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54165155324;
	Fri,  3 May 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzPp27XW"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC660154C08;
	Fri,  3 May 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744516; cv=none; b=CexBLQ+vGOgZXOGotUCNPzwGzJrgUQQYBYr69lW1iFY7kneMukT4GVWISHCnPb+F3iGSB6eGvDY99VWF9WO2tBYZF6cOFgpluDeah46pz/rEmyZ56RRtU9eXsktpv76tHKFgmpS1BG7PWV5ORj/cEtsfXRhvInwVS5wl3xI4Src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744516; c=relaxed/simple;
	bh=QJPkmarfxM3n5aUMQSNsh2BosQFMOvgiMQhvgrb1HVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6Zp5hikV/McyjbYaFoTgOGZQ3jC/1EEfGKDKstKKTP/IolddFs+shCPzu5mlaqEZkXN2L/GgZeLVGAx7m/isObo2caPtUkHyeC2wdQjbCvW7RXWqqDBtEum/P2SOkrw0Vh27iZEnzncj7PDAKUVOOadAVyluRo24Ai/RlSjaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzPp27XW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f60817e34so1656766e87.2;
        Fri, 03 May 2024 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744513; x=1715349313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDycoc9tsSM3a5jvUVLZLpZSYhTTvzLmPmjIFvjcoO0=;
        b=BzPp27XWKXqwfSWy4xbsQrK0YpOeGSsmc7hus8kuK8truLVso8YVtODmYlMNFp5cjb
         NwKxELcgyNe7WkRcoZewa23sUjoJ1xm2LN4RM6eNcZrrx2OgARJXhwV525oJRBrYDFdY
         yQqnD8evIxU0kxhpWWHRdNJt1ICiKMXGzOcXLlxSSI1YvweM6cWeSCNfiZl6EUjPW4Fm
         TfYU0BT4oDjXUe5HwemR1Ohe3z3XJnccEwUt2tHlzKwi1TZpS2P+YBf+DMRrSM1wldcm
         horcECMtI12O9oE1B/7B1xvozL6b0lKNbi6P5zhhrBm6dKjAvOJLYccdU5fpYyLp/oW9
         NUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744513; x=1715349313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDycoc9tsSM3a5jvUVLZLpZSYhTTvzLmPmjIFvjcoO0=;
        b=fIOcZfnpw4QjUYbDCZS1+FgIXCZ9DsOsm0i08EWKlnRsi5i+rQelF2FpqObs6SI7OE
         QDsYUEQXOLIGXy/e+aTAvVe3gkv83lU1FCTYF7lvQFr3SA15HK8fRrAXtxMuOgU+l2KQ
         XPSwrSYpUQ+N/hsr8LOIMlj4yqPg6HUBUw7vWh6QkxKfsVkrvIbAbEYwIYhiw5RgzaEe
         0Da/W22Nf6Uxtm/pC3Wa0Gq+7nrWf7jkEPiUhUkZFtbzFOH7O0hVzLkxdSE0Ph0wz4vK
         Fg2/YWfRtMKIkKRmr6bLT4k0kMkZkMZZmgUsaxaCfX4PvKIeO5RcBrrKB6+n7xTghJhj
         XsMA==
X-Forwarded-Encrypted: i=1; AJvYcCVG4Kn0tUGRFE3CHp1wpTHzug/McyUp6fLEnYnmZxOfJ2DD5WEscaqjxkzDM3C1f8FGlUPQ9pJ5nIihb00eUi1htDz67DZHPDPUcVBI4TUssOUg/UKjq8jZHEjF9u5jzFfpTrVf9x3XrJsuvkCYhCyQyjC6tHrO/aWhjmvfT4IXsnUoGfk=
X-Gm-Message-State: AOJu0Yz8H8va1a1wE1z60HJHZ2qfIyfOjQ0lUdC7GS2ITjX/+3ujUXij
	rhxKRxeodJLQkSqeezgdHRsxbJfVa9EsFHqTHCpIA9KHzs4vFT4i
X-Google-Smtp-Source: AGHT+IGu8h3zTpkduDA2g7DIC5z2V/dTwe21HH0z4Bc3Yy7oILJgBW91QW8ONT37izllzR3z5yRPrA==
X-Received: by 2002:a19:5219:0:b0:51c:b8ec:c46f with SMTP id m25-20020a195219000000b0051cb8ecc46fmr1852797lfb.22.1714744512762;
        Fri, 03 May 2024 06:55:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:12 -0700 (PDT)
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
Subject: [PATCH 4/6] mips: bmips: setup: make CBR address configurable
Date: Fri,  3 May 2024 15:54:04 +0200
Message-ID: <20240503135455.966-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503135455.966-1-ansuelsmth@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
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

To provide a CBR address from DT, the property "mips-cbr-reg" needs to
be set in the "cpus" node. On DT init, this property presence will be
checked and will set the bmips_cbr_addr value accordingly. Also
bmips_rac_flush_disable will be set to false as RAC flush can be
correctly supported.

The CBR address from DT will be applied only if the CBR address from the
registers is 0, if the CBR address from the registers is not 0 and
is not equal to the one set in DT (if provided) a WARN is printed.

To ALWAYS overwrite the CBR address the additional property
"mips-broken-cbr-reg" needs to be set.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/setup.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 18561d426f89..bef84677248e 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -34,7 +34,11 @@
 #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
 #define BCM6328_TP1_DISABLED	BIT(9)
 
-/* CBR addr doesn't change and we can cache it */
+/*
+ * CBR addr doesn't change and we can cache it.
+ * For broken SoC/Bootloader CBR addr might also be provided via DT
+ * with "mips-cbr-reg" in the "cpus" node.
+ */
 void __iomem *bmips_cbr_addr;
 extern bool bmips_rac_flush_disable;
 
@@ -212,8 +216,28 @@ void __init device_tree_init(void)
 
 	/* Disable SMP boot unless both CPUs are listed in DT and !disabled */
 	np = of_find_node_by_name(NULL, "cpus");
-	if (np && of_get_available_child_count(np) <= 1)
-		bmips_smp_enabled = 0;
+	if (np) {
+		u32 addr;
+
+		if (of_get_available_child_count(np) <= 1)
+			bmips_smp_enabled = 0;
+
+		/* Check if DT provide a CBR address */
+		if (!of_property_read_u32(np, "mips-cbr-reg", &addr)) {
+			if (!of_property_read_bool(np, "mips-broken-cbr-reg") &&
+			    bmips_cbr_addr && addr != (u32)bmips_cbr_addr) {
+				WARN(1, "register CBR %x differ from DT CBR %x. Ignoring DT CBR.\n",
+				     (u32)bmips_cbr_addr, addr);
+				goto exit;
+			}
+
+			bmips_cbr_addr = (void __iomem *)addr;
+			/* Since CBR is provided by DT, enable RAC flush */
+			bmips_rac_flush_disable = false;
+		}
+	}
+
+exit:
 	of_node_put(np);
 }
 
-- 
2.43.0


