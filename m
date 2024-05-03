Return-Path: <linux-kernel+bounces-167731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E28BAE34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECCC1C22631
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5E15534D;
	Fri,  3 May 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcC5XhPc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB861552EF;
	Fri,  3 May 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744517; cv=none; b=p/BqLYTPJs475UdAiKb3OS99yQzng92TPE/W8iR/PZkycK0eHulkKQQ2aLz/v288ORLEtm6d020HTT/3BkXSTxcbsbtwP2cglNalZDaMMSBLMp782jQl3kYYa5S874+sfCOOpUpQSZBSS2+2yuwp5KYH1IsK+z3Z+g5QtsRzd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744517; c=relaxed/simple;
	bh=O1Ye1QLJNDCfy1rtmlUyY11EROkwDkBodNDwB1qlbcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD7CoEXuj8c2AdO6L1AC5Tru5AB7DRF0LybRPLTkKz2Swqulg6Ee9Z/IhfzG3AiH+8piT9vKKbfP5sopEA6izKqTSwiKiv51yjmQhbDkkE0Vd2M9KMrkEn6bcxI7hyMPoCpRdRjvGz6RrSSgHyJOghZ+xHC49AEr1bVBScTFRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcC5XhPc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so109511081fa.3;
        Fri, 03 May 2024 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744514; x=1715349314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYk35mpszpWEiG5Dn8jXxaGvBzprHkHDi7l4DpSYmr8=;
        b=hcC5XhPcJnnzPMMeG4QBXwihLdNE0uCYkKZQtRYYoyYiaulCAv7diSnhlxgCkCFuW5
         w4AtRlIf0JMx++gPOK4CDTN9nI/zA0FcRgCOY5fN58fCSG4DoXLRx7mpnWW8B8cdu5BP
         tgy/M2zGPKpLzxPIqmAeYY88zMR/lCKHywk4Z0hHFYCE72TooAos8njT4hCzEW+2v+uN
         S9Kn0g6lAhR0/UIeqUWxlIfHIuy6fWYrfGw+CwTUS8qrU85QXTPT3GoVN5yUUYr0LhD9
         GCCQ8Tn+UNh+lOAnZqWUN1egM3tf/SwRutZT42X/3Q+YVjV3l4NEARsO36eGcWDujFR3
         mjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744514; x=1715349314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYk35mpszpWEiG5Dn8jXxaGvBzprHkHDi7l4DpSYmr8=;
        b=uu9LSpMXTlOgfrDUhOYUVLbZp9Hy2QoV6CN5dH+jHVYxVtPj+lvtLGU8pXo9eW6u/G
         JWoFGhKuqUYi7TUGprbGWCr8ExOucCaoLYJqCUlH/8IO9fUiv4GewZwIbmZB1fYMknYv
         T6EUkwrDFVwCq5TM560ocbHw0EStSqkcbCaUOEfm0hvMZLzLqDIwRzqhH2Seq7iWyVjO
         01ukukBJ36tWLlSFNqsYlSSgtR+41F48194vaE1BAI0iUFV6ubh1hebJE5FNGzKhGpKv
         Y2CBZQmFLzZLZf9kX59p7yvXgjsa1vRPu53P3sJYm5D+KHJm0EXKNmHsOZVkSVK9dfJy
         Murg==
X-Forwarded-Encrypted: i=1; AJvYcCXNqTBn4WMVMJBNCMlQlR4jwQIR9adkdv0BX6XHgl3vVHExWovdRE61cMpVGo+85z+I6pZZadlxtV5FVU3ft4WrPIBfqMgiXaj5WIawJOeluyqsurvvKV5pLhWS3wqBloFp19NwWsKGM9O+0Kyn+Xw088yPGMJ6DrvXtMSKjUfQ/urYZPs=
X-Gm-Message-State: AOJu0Yyn9sCkgb9SHxyqxVKoINE90MAwile5VWklNc33UptJ6sl53ny+
	nKnNU6ZVd1C5aBX0/tYtDK34KnxyEpSlWkn6AnBWTubVnzEUXWO+
X-Google-Smtp-Source: AGHT+IFiqd93L2MR1jV7r0gVwTS1l7NKYde8ybBT3jQi/Gx2sP/WJfeUJEoLJ1LXjnPLISMEF0AcQA==
X-Received: by 2002:a05:651c:1026:b0:2da:49cc:ef39 with SMTP id w6-20020a05651c102600b002da49ccef39mr1772455ljm.0.1714744513927;
        Fri, 03 May 2024 06:55:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:13 -0700 (PDT)
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
Subject: [PATCH 5/6] mips: bmips: enable RAC on BMIPS4350
Date: Fri,  3 May 2024 15:54:05 +0200
Message-ID: <20240503135455.966-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503135455.966-1-ansuelsmth@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel González Cabanelas <dgcbueu@gmail.com>

The data RAC is left disabled by the bootloader in some SoCs, at least in
the core it boots from.
Enabling this feature increases the performance up to +30% depending on the
task.

Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
[ rework code and reduce code duplication ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 6048c471b5ee..7bde6bbaa41f 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -617,6 +617,18 @@ void bmips_cpu_setup(void)
 		__raw_readl(bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE);
 		break;
 
+	case CPU_BMIPS4350:
+		u32 rac_addr = BMIPS_RAC_CONFIG_1;
+
+		if (!(read_c0_brcm_cmt_local() & (1 << 31)))
+			rac_addr = BMIPS_RAC_CONFIG;
+
+		/* Enable data RAC */
+		cfg = __raw_readl(bmips_cbr_addr + rac_addr);
+		__raw_writel(cfg | 0xa, bmips_cbr_addr + rac_addr);
+		__raw_readl(bmips_cbr_addr + rac_addr);
+		break;
+
 	case CPU_BMIPS4380:
 		/* CBG workaround for early BMIPS4380 CPUs */
 		switch (read_c0_prid()) {
-- 
2.43.0


