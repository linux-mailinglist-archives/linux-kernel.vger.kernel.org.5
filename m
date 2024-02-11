Return-Path: <linux-kernel+bounces-60841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A0850A12
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98961C20BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26C5B689;
	Sun, 11 Feb 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Q1RPoPMy"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF745B67B;
	Sun, 11 Feb 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666117; cv=none; b=IeGO3SDBWFQnL1aZix5hC3ijhNSpRrnWHiwYdb03WVVNRvMYA28UO2wZkMcboDoCvrngQVelp/t44FX2NvYuWFiToN/ZIBr5vekUiAk3ZHIPLPfNWoXe4tyvFLExeeJXTqaa4NUiyR8Kpvg7eTzln/QAqC/QD/R0Tfw48z3okgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666117; c=relaxed/simple;
	bh=kNVAB9tNqNyjOxNbAj1tkRNyJhfocPuoy973+DF2Ouw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hBZn04trN3UQf8+FZlwb+cLU3cj9D9gqz8BOrML/i29tMGLePfRettjwdtWzBXknlWM89aQPJ2S6GbPtfomnk6ZGCDpXal0WELxJBabUprS8nRs4NMG9vc8N4zWBkpaCaAvl9JJdwKkBzHA32RaNKV1peqvHf8yrioKZVZ19bE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Q1RPoPMy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e06d2180b0so1991776b3a.0;
        Sun, 11 Feb 2024 07:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666115; x=1708270915;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4L4+gcHoxDmNXs1iw4HULiXJzu/BhYCTjokD3pcZhY=;
        b=dy3ET0AhHsOS0i7KJWwHV9+EfB4xdvHGkWSdYpLTxkxE51VuqzIixO6f4kM+nLwRQ1
         nxvYGk0Mn4mOrjak0j39I+MPfAZpHpHqFwjB399AGHWKc5nSfmM5jbXs01xfW4T9Lmvm
         jC3YZHkLL1if0TC2Bexz+4wNzp0MxZvP/7iLXlNOvfVYkrRLKRVM+10zpurqyjQ5Ss3p
         6mlv8C/IaAKae8Uv109Kp1XhaLJe/1obZn4qhmol30guW4m9sQCKKG1ElvKJEhO6y6AM
         k1uYdj5KqAZxQcad5gut1gR82HH+f9f/6dY4PoerxHfqfzUbeEeL6YtOhLv+xShBpKom
         2taA==
X-Forwarded-Encrypted: i=1; AJvYcCVW84M15V9EHwksf8ZscHls9XG5BylV3Ql9nK2jCklWptUdNvXRUDrh5U/YbOT/3AG8yTJIiGNOUAg7CEQC4lpUCleQWECYPPlZZX2xjniUUT/AXByR2gQMu9o213zBz5clk9rL5lH7IOuX1rMhsAo=
X-Gm-Message-State: AOJu0YzxMD60QzovLNQI+2XviI/LCBZq4O230SjLJHrN4l0E4QJHAIFB
	hfE/FDVGUPjn7bRjTgKOVbxBJzEGTZvZ0Tkt5zG+k5REt9mxW7mJ
X-Google-Smtp-Source: AGHT+IH/skl7LeBk0kUtSSgss1XeeOhXWh3155C4mLb4RbEYKlXsy0KsUe7gPMOOu3cipZDWfI/Qzw==
X-Received: by 2002:a05:6a00:b84:b0:6e0:e235:e2ca with SMTP id g4-20020a056a000b8400b006e0e235e2camr297795pfj.9.1707666115098;
        Sun, 11 Feb 2024 07:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPruGfE8CLfFljgs5W+asgm3IGFvyzrXX/H9F78snfRnJLxjllOUz84+stXXEbiX+GiwzvR4GzlujUVzd1eRQT3m1I5rTqI56bFlxiOqAlI7Moh3HEvxl29E+UhSOKaFBbMVbb68sp2jDQtcghuDNq0mNCe1vFekVgmXgxMD708OW/6jeAOcnzMR0TfTI0SRuxBWSbunkPaGz2OJhJkfO8sIhb1R3s9f9RbWWd1MlCWhpXPGBuvV3OZqNT
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b124-20020a633482000000b005dc491ccdcesm5252180pga.14.2024.02.11.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:41:54 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+4L4+gcHoxDmNXs1iw4HULiXJzu/BhYCTjokD3pcZhY=;
	b=Q1RPoPMyURV04UdEXNEA4wkoZTywC722zNvCTL5jBYg3TXLWiw2X8DdTm6k1c6MG7QqlM5
	+rPGl9/ZGz0AYmVOHifGjeP/PsW2mdXDNn3T499a+jyhL9iYn3sPTBRTymCB+ZPZqUpGR6
	9/AMcZ9/YY08/C36pavYvjIzW6Y3JNkc9c1Zd3wd02LIVmpubLwuJi4Cv4HNbASrpcnnyR
	SGgmuu0FeiA53m5mab+oe/tFXxUrsH+G/mEJbI151NfmmDzoLwG3+Ai7cNXVFQWunQMt+g
	vCL0lxcO6563YAuxMjOkCc4ifVXNpfJLuRCaIoMnDzocVxs/a6iN7qYl2Pojeg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:41:49 -0300
Subject: [PATCH] ARM: s3c64xx: make s3c6410_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-arm-v1-1-5c0102bda0bd@marliere.net>
X-B4-Tracking: v=1; b=H4sIALzqyGUC/x3MQQqAIBBA0avIrBNUDKKrRMSkUw2UhWIE4d2Tl
 m/x/wuJIlOCXrwQ6ebEZ6jQjQC3YVhJsq8Go4xVRms55zS5nTDkS2I8pEe1mLZVDm0HtboiLfz
 8x2Es5QOD0hznYQAAAA==
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kNVAB9tNqNyjOxNbAj1tkRNyJhfocPuoy973+DF2Ouw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOrmDpPt4LSED8/f9JCDaJxp1tgoxk2x5PCc4
 438HbLm+7WJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjq5gAKCRDJC4p8Y4ZY
 plXUD/9wSTKxrsAlaTbe4n7Fo2Cqx0pS3sboEClp06Djyem2ktNQEr6/z/hHa3dgpDe4QhcmWKO
 C/LEafa9SPB/O/TCjIvbxZC1RCLfvPmO7aLtvQSrnj4WuTNxuY3eme0gxcerWVdiX5/hAdTJECn
 fB+9S2vcJ6q1oCs3MHts9Ld/OhmbxQnoxWR3irG15F829u45f5R/31t1iILeL9Em+NNnCgQ85Yv
 Gvv7pvE6PG+ySRDVOgVWvMGNszfRzigMAchs9SZqwBOsLDRZY7WdvNDG3zmukfeprDrfHlrqkrS
 bNYzy1C3ST+7v36p+AlmV3U/tl+MP3t6uAunttyPOHYVPgpX6//pdp3TdxU8+ruAQDZgYG4ziJo
 gC6VoAMUJNqYHOiPnBbetKV/gTKY2rw6VMthHLngTLUPRMf50M4uyzpZssQyH5TasnBPjm+8kKe
 P+/PsH3uG7Aa+rXFPHj8UiOI2EolqTaWsQA3L3KfzKCvXlAmjuqrZ/7V2U+r1R55O8FalV6hNQI
 jSJHZpC1Fid2PbTfLFy6IH5pDm8cs82IMYfyq6ZR4ecEk6MhlR0weJ6J2V9AzrYzkLfOrDmIWG4
 O3B2mgz3/NLNIbELq/JCoVZF8FQl1xCqVd5I+U0YAHkdB5lPuF3R0ztGToJnHi/PKtVRj/xOVFM
 OX3+cNetsXUMoAQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the s3c6410_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/arm/mach-s3c/cpu.h     | 2 +-
 arch/arm/mach-s3c/s3c6410.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c/cpu.h b/arch/arm/mach-s3c/cpu.h
index d0adc9b40e25..a0187606b999 100644
--- a/arch/arm/mach-s3c/cpu.h
+++ b/arch/arm/mach-s3c/cpu.h
@@ -76,6 +76,6 @@ extern void s3c24xx_init_uartdevs(char *name,
 				  struct s3c24xx_uart_resources *res,
 				  struct s3c2410_uartcfg *cfg, int no);
 
-extern struct bus_type s3c6410_subsys;
+extern const struct bus_type s3c6410_subsys;
 
 #endif
diff --git a/arch/arm/mach-s3c/s3c6410.c b/arch/arm/mach-s3c/s3c6410.c
index e79f18d0ca81..a29276a4fde5 100644
--- a/arch/arm/mach-s3c/s3c6410.c
+++ b/arch/arm/mach-s3c/s3c6410.c
@@ -57,7 +57,7 @@ void __init s3c6410_init_irq(void)
 	s3c64xx_init_irq(~0 & ~(1 << 7), ~0);
 }
 
-struct bus_type s3c6410_subsys = {
+const struct bus_type s3c6410_subsys = {
 	.name		= "s3c6410-core",
 	.dev_name	= "s3c6410-core",
 };

---
base-commit: fee3a71dc8d26629e5d87e20cff08763f522633f
change-id: 20240211-bus_cleanup-arm-da0f2550ca48

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


